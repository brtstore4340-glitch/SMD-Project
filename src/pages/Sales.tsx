
import CountryMap from "@/components/ecommerce/CountryMap";
import SaleMetrics from "@/components/ecommerce/SaleMetrics";
import RecentSales from "@/components/ecommerce/RecentSales";
import SalesChart from "@/components/ecommerce/SalesChart";
import SalesTarget from "@/components/ecommerce/SalesTarget";
import PageBreadCrumb from "@/components/common/PageBreadCrumb";
import GridShape from "@/components/common/GridShape";

const Sales = () => {
  return (
    <section>
      <PageBreadCrumb
        title="Sales"
        pageName="Dashboard"
        breadCrumbLink="/dashboard"
      />
      <div className="grid grid-cols-12 gap-4 md:gap-6">
        <div className="col-span-12">
          <SaleMetrics />
        </div>
        <div className="col-span-12 xl:col-span-7">
          <SalesChart />
        </div>
        <div className="col-span-12 xl:col-span-5">
          <SalesTarget />
        </div>
        <div className="col-span-12 xl:col-span-8">
          <RecentSales />
        </div>
        <div className="col-span-12 xl:col-span-4">
          <CountryMap />
        </div>
      </div>
      <GridShape />
    </section>
  );
};

export default Sales;
