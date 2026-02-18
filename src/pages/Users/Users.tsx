import PageBreadCrumb from "../../components/common/PageBreadCrumb";
import UserTable from './UserTable';

const Users = () => {
	return (
		<div>
			<PageBreadCrumb pageTitle="Users" />
			<UserTable />
		</div>
	);
};

export default Users;
