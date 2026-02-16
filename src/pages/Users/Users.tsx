import PageBreadCrumb from '@/components/common/PageBreadCrumb';
import UserTable from './UserTable';

const Users = () => {
	return (
		<div>
			<PageBreadCrumb
				pageName="User"
				items={[
					{
						label: 'Dashboard',
						url: '/',
					},
					{
						label: 'User',
						url: '/users',
					},
				]}
			/>
			<UserTable />
		</div>
	);
};

export default Users;
