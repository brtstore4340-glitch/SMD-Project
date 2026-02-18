
import CountryMap from "../components/ecommerce/CountryMap";
import EcommerceMetrics from "../components/ecommerce/EcommerceMetrics";
import RecentOrders from "../components/ecommerce/RecentOrders";
import StatisticsChart from "../components/ecommerce/StatisticsChart";
import MonthlyTarget from "../components/ecommerce/MonthlyTarget";
import PageBreadCrumb from "../components/common/PageBreadCrumb";
import GridShape from "../components/common/GridShape";

const Sales = () => {
  return (
    <section>
      <PageBreadCrumb pageTitle="Sales" />
      <div className="grid grid-cols-12 gap-4 md:gap-6">
        <div className="col-span-12">
          <EcommerceMetrics />
        </div>
        <div className="col-span-12 xl:col-span-7">
          <StatisticsChart />
        </div>
        <div className="col-span-12 xl:col-span-5">
          <MonthlyTarget />
        </div>
        <div className="col-span-12 xl:col-span-8">
          <RecentOrders />
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
