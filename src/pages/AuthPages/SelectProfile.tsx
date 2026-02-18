import { useState } from "react";
import { useNavigate, Link } from "react-router";
import Label from "../../components/form/Label";
import Input from "../../components/form/input/InputField";
import Button from "../../components/ui/button/Button";
import PageMeta from "../../components/common/PageMeta";

export default function SelectProfile() {
  const navigate = useNavigate();
  const [userId, setUserId] = useState("");
  const [pin, setPin] = useState("");
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault();
    setError(null);

    if (!/^\d{7}$/.test(userId)) {
      setError("User ID must be exactly 7 digits.");
      return;
    }

    if (!/^\d{4}$/.test(pin)) {
      setError("PIN must be exactly 4 digits.");
      return;
    }

    localStorage.setItem("profileConfirmed", "true");
    localStorage.setItem("profileUserId", userId);

    navigate("/dashboard", { replace: true });
  };

  return (
    <div className="flex min-h-screen items-center justify-center bg-gray-50 px-4 dark:bg-gray-900">
      <PageMeta
        title="Select Profile"
        description="Confirm your profile with User ID and PIN"
      />
      <div className="w-full max-w-md rounded-2xl border border-gray-200 bg-white p-6 shadow-sm dark:border-gray-800 dark:bg-white/[0.03]">
        <h1 className="mb-2 text-xl font-semibold text-gray-800 dark:text-white/90">
          Confirm Profile
        </h1>
        <p className="mb-6 text-sm text-gray-500 dark:text-gray-400">
          Enter your 7-digit User ID and 4-digit PIN to continue.
        </p>

        {error && (
          <div className="mb-4 rounded-lg bg-red-100 p-3 text-sm text-red-500 dark:bg-red-900/30 dark:text-red-400">
            {error}
          </div>
        )}

        <form onSubmit={handleSubmit} className="space-y-5">
          <div>
            <Label>User ID</Label>
            <Input
              type="text"
              placeholder="7-digit User ID"
              value={userId}
              onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                setUserId(e.target.value)
              }
              required
            />
          </div>
          <div>
            <Label>PIN</Label>
            <Input
              type="password"
              placeholder="4-digit PIN"
              value={pin}
              onChange={(e: React.ChangeEvent<HTMLInputElement>) =>
                setPin(e.target.value)
              }
              required
            />
          </div>
          <Button className="w-full" size="sm">
            Continue
          </Button>
        </form>

        <div className="mt-4 text-center text-sm text-gray-500 dark:text-gray-400">
          <Link to="/signin" className="text-brand-500 hover:text-brand-600">
            Back to Sign In
          </Link>
        </div>
      </div>
    </div>
  );
}