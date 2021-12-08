Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868AE46CD31
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbhLHFgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:36:41 -0500
Received: from mx0b-0064b401.pphosted.com ([205.220.178.238]:49626 "EHLO
        mx0b-0064b401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231911AbhLHFgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:36:41 -0500
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B85Iv6p015238;
        Wed, 8 Dec 2021 05:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=PPS06212021;
 bh=ztqAJZqHuy55Euz51e/+acaj5ajDH5lXIegaqrridrk=;
 b=nhxLVHhSVfuTKugoClWkaSflHX4ZNLSx8xCLX9QLlpqqI+Wx/8jTDGQx+nlbmCToyllP
 9xVHGC4u9205k2HqqDfKWb97kB4j+Qt3wHF+wP6rqCiZE3+eYleCXGVEXDCeMMfDKdtX
 NvocVVKXj18PQaJ4WxDpTEUgmiYYz8DCYqyRmNzf6b1G7tJmfZBnTs5RFfsGczrzB9AH
 nkI8/ACum07nYbBdlIa8bux9OA8UdQGsMVY+GVgQ0Z8N8y+Az5ggOmPOGxB1Q+pI8cLQ
 /E7j/HEql132U5JLEDBIuLVnQKhrTfjARomf/Kr/aRDfHo1MaqARatgaWsblvrNsAlFo gA== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3ctba60fpe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 08 Dec 2021 05:32:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hoPh+fDzuWih3PS3Hip/BumaLNwSY9Ggrh/bMnrrVbfQ11Efjln8fTxlgazrvQC7/hcUCB3smnEGh6D96v/ceRnUA6QkZePZ2FHzlTQ4tC2R/giyshhdIgGM0NkVthjTyoPM+s4KABd9FC8fvUL/DmS+1VylO+rSQSJEsk4/CitwMB23XDpIN474ycNZk/kL1PRs6/bU8ZO1OvzJaZnmtQ/i+uf0I0Bok/lYt9+DhflXua2KoTP1C2OebDEBUYOqpGUubgSlGz1Wd4aXh5GjjLfPHG4lKCkns/YWJ0JV3WrYI8Mdq+CB9LMkfq+mUYDWS8GtFS/V3pYwAntfxDmWjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztqAJZqHuy55Euz51e/+acaj5ajDH5lXIegaqrridrk=;
 b=jmY9dR7+jowYCMOYc5KZufpRl+t8Sa1lOUm5dMZQ+sqNhXOdm6M1hpnMU43UypE+MrGD/xm5eQDH/zVxxLYUAzWYD9QUXsuTbuic0qT8zAVAJGQg9bfVx1tn67etnDTgkScP5DHLgpnjCHxkvR8eB7eJi9Z/x0HyD1N9GmwZUzMvruAEw92kAV/opmjbICgM9tIRyMaxT04ePqmrYIw2eIePF3OFL7wvZiOmMR/oNOCZWXhzivwJutU54eCc+4Z7xi6prV8u1TSDRKWCFfJjwlNaZnpaHrFBvvYUPnXcd384wsdYXlfccm73VUnkjV/1Ztxz7XkgIu4PR6Bug9Vvow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=windriver.com; dmarc=pass action=none
 header.from=windriver.com; dkim=pass header.d=windriver.com; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM5PR1101MB2169.namprd11.prod.outlook.com (2603:10b6:4:51::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.15; Wed, 8 Dec
 2021 05:32:43 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::a1f3:e04:7411:f6d5]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::a1f3:e04:7411:f6d5%4]) with mapi id 15.20.4755.022; Wed, 8 Dec 2021
 05:32:42 +0000
Date:   Wed, 8 Dec 2021 00:32:37 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/2] sched/isolation: really align nohz_full with
 rcu_nocbs
Message-ID: <20211208053237.GA18550@windriver.com>
References: <20211206145950.10927-1-paul.gortmaker@windriver.com>
 <20211206145950.10927-2-paul.gortmaker@windriver.com>
 <20211206213333.GH641268@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211206213333.GH641268@paulmck-ThinkPad-P17-Gen-1>
X-ClientProxiedBy: YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::34) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
Received: from windriver.com (128.224.252.2) by YT1PR01CA0095.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::34) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Wed, 8 Dec 2021 05:32:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1e8001-5685-44ef-2d06-08d9ba0c280a
X-MS-TrafficTypeDiagnostic: DM5PR1101MB2169:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1101MB2169E77D407E1F4F720FC8DB836F9@DM5PR1101MB2169.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dVGmPFWH7CfHS4AxRG/S1pz4Luh7n3IcppShbkMhu3sPUOkEMCbmOFlTjwXsaAnkxyG0rvqfsOdyrnBTqcXzXYj6Q4ZOhHjyVFcL1JkcihGTAkluloM06HMbz/AhDPrqaID8uu6c1EfX2RdZwCp6UbMm/vWHo5QEWQaKxTEfrNRXFB+uTWhYDgIHRTwbAgCoa5aw2xvdKGXiZzS0wOzRDMFQ0rnqZnwgXJlYRwSx9RowuYDpE2QT1xnNRVCiTT5B724T2YoyXqIXc0BbmP5tBNPbYkxoi9pctHlw9R7budRul5/BatnX76LsWr4A0EBSAEDWwmny9ueC7F2eeOTuapR5JtOQtSYhWr2T/HeMOGcoG3ICJdFjNHOZOsBxEBE6+TvvxoFAAUdqfiVfwBKon8eeqcQjpnVFm4SyrROiOwawdzu/ZnoOfuamRyI/S+pPuiIwd51M/F5qnQXgqH4+qSs347HJPOkTmM26AcLUe22XuPxklSqWvf+GUwWiGd8tC4g8nCwkVFdCWlXV06EzQYhY3Mdh/cl/D1JUrGAE2mDgCg7KwPDlUFcd2MG9D7fkaEJOd6nz11HSv3KiQj8G4xn1+XrB77LH7NoKvkeY0FPS54CxTxh9zIvCZERyhMdLFL9Zi0+2uV13rz43k6PmyFkCoIrudOSpMeRQmi3lHEnWFjw1mrZnTYz7Ycsty+e+5vd31DSDlVJhzQBdzRoI2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(44832011)(1076003)(38100700002)(52116002)(7696005)(8676002)(508600001)(66476007)(66946007)(66556008)(38350700002)(8886007)(8936002)(55016003)(83380400001)(956004)(6666004)(26005)(2616005)(2906002)(4326008)(5660300002)(186003)(36756003)(54906003)(316002)(6916009)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CJ/c28bXmvKknXXPkmB1V9TiwcWXT99QER04MTiqN7jhAC2cF63530QZ9hHh?=
 =?us-ascii?Q?VAFrW1a3UjV+9466FPqKHM8jstEcOjR6OWkYz3RTRG5F4yS8C38FhPoEuH0D?=
 =?us-ascii?Q?vZ/QM1NdOXSselsJjnYAAQPkvTtQ59hQElzPDmInJXmQBHoMpZ10l9OHxWQu?=
 =?us-ascii?Q?MF9OfDh12jPPKInLkJZOBiLe4wTU2KIlN4QuNExQlw5HpXvej1M1DzROid8Z?=
 =?us-ascii?Q?q0q53sA5Db9BxRKI5us5axxVjo/nKl9LiG+SPFEkPb0+4N/dTz7+asDVyIv6?=
 =?us-ascii?Q?9rbqct2k73ueXECCre16zJGLp0oc0JmrdY5/e9j+HkSIgrrsNXuVV+aiZq1l?=
 =?us-ascii?Q?jz+uDWLV1KWkjVdlKbKG85Uxmt78M0byVLP1S+sLCAbl80zKCs2u5LUOJNIB?=
 =?us-ascii?Q?kX3b/K6IFU4K7OKi9196m7OEwlc2FNzXAR3Nkrbge/H687MYsfEzWojr9x/U?=
 =?us-ascii?Q?X07lKH1Iq15NyZomUe4+S0t12xNOQzXB4XIsPPJb9Yk4/A5Dd45B4KEOxgn/?=
 =?us-ascii?Q?//m1eDt0Jqs85WaOjNtcdBa2jEksLW92sKDGzxzsrAzMENUqGV2R/F5ZqB+9?=
 =?us-ascii?Q?xk8RiteDtqepMGkNRJDW6EtCWODetJEvH0lIGoVY7nrag9U+GV63S7/L1C4F?=
 =?us-ascii?Q?Q/Ese8O3ECdnc9eaSvKntYSAAP8pIcxh/m6dQnSNsV09IFlMvO++fbQ5nbks?=
 =?us-ascii?Q?/pmRECedidYy2WH0VFIpBG750WGfrY5P5Bjic0bicNuijh7jdaS8na+nE+3P?=
 =?us-ascii?Q?vsYFSIORRJrkpuWARtHRnGKXx51cyvdEmMzpaxDTAOKs6UrAKLinXkaSHgd7?=
 =?us-ascii?Q?tCBHAcuTN+/C8QHslghZUoVW/L5FT3oyJkZYq4WALmxsxDU5HPBxja0Sp3Xf?=
 =?us-ascii?Q?sCj9A+zZsBKC2mkFnP3KU9/crgjfnSpCfJXutgnrIE/drL9u2uju4iWyfOYB?=
 =?us-ascii?Q?yIDJBD6XhC+TNVHnF77JSAS5P4+Q3XO90zAI/MzVna+HmCUYHvxNn8E/1lXB?=
 =?us-ascii?Q?rILgjAjuoG1iJMCKTQByU4Ub8DNzpZ/bTF5Kbf8m4dSS9stG+ZQN7tiEH7au?=
 =?us-ascii?Q?W8IP/9Ti0KMkBeQLZOtBOFDu5pJ1YjPd1mx/a/O2f/AZGYf1BeA+H+g7iP7S?=
 =?us-ascii?Q?gO1RTysjmReEjk3ZU1tR2OkVUmK5IM3/78ZVFMJTGBNkCuUH+W/r/Hfguvys?=
 =?us-ascii?Q?M7xWH17C0TCu5bTe7XlrDShGBbAXQzYwVmjJixE2aPfWyfNAlzRGPeEjuhgm?=
 =?us-ascii?Q?pvdD3TtwQy3Z3aKwAuzWpbG9jwr5wjbgIjoMYID/WHHc1aH37Iw6VV9pSyVv?=
 =?us-ascii?Q?UFCJ7EJSb4AD2ffg98GwXoo6ldbkxJ3VnwMk9eIE2yeArgrJMmwiMnRymw5M?=
 =?us-ascii?Q?Bmvpry1XoOOWPnIMsCNFrgg0UUlG+R1GWA4SfFnDednFullzoqzffMON/y/P?=
 =?us-ascii?Q?fO8gbLqY+AXK4ep/RA943EODW4o5MNxZoH8oRyZ8EJDHwtYTfHc07ByxVb7y?=
 =?us-ascii?Q?qwA4Pxa5ylMrjWN3TzzKePSlbj14tXqLpBvEwgJ5c6xNddbdWWGG8F/tCegL?=
 =?us-ascii?Q?eSA4KY/USBT6m5guHGlWEKYvfYlqkk07rgxydiN9Us7to9CovLg+KWm3yCIQ?=
 =?us-ascii?Q?Nt/KD0ownMD5klocwJakwsxP47LbaIYJ6OAv9f7WUY7P6c0MoeuH8zVZIbyV?=
 =?us-ascii?Q?u3sqnQ=3D=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1e8001-5685-44ef-2d06-08d9ba0c280a
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 05:32:42.6264
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Q1+QvfRp2JPDihZJhGsGgANkWTEPs98AgvrlGFargfYMWgQCdt36sHJspxNdo8ca3/l7s/hzLSJO8tElyHAqcerhNlTfL96v8/MzmtxNvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2169
X-Proofpoint-GUID: No-4uml4YTOFVXBE2moSJxDNgUjnlFGJ
X-Proofpoint-ORIG-GUID: No-4uml4YTOFVXBE2moSJxDNgUjnlFGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-08_01,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 clxscore=1011 suspectscore=0 mlxlogscore=779 adultscore=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112080038
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Re: [PATCH 1/2] sched/isolation: really align nohz_full with rcu_nocbs] On 06/12/2021 (Mon 13:33) Paul E. McKenney wrote:

> On Mon, Dec 06, 2021 at 09:59:49AM -0500, Paul Gortmaker wrote:
> > At the moment it is currently possible to sneak a core into nohz_full
> > that lies between nr_possible and NR_CPUS - but you won't "see" it
> > because cpumask_pr_args() implicitly hides anything above nr_cpu_ids.
> > 
> > This becomes a problem when the nohz_full CPU set doesn't contain at
> > least one other valid nohz CPU - in which case we end up with the
> > tick_nohz_full_running set and no tick core specified, which trips an
> > endless sequence of WARN() and renders the machine unusable.
> > 
> > I inadvertently opened the door for this when fixing an overly
> > restrictive nohz_full conditional in the below Fixes: commit - and then
> > courtesy of my optimistic ACPI reporting nr_possible of 64 (the default
> > Kconfig for NR_CPUS) and the not-so helpful implict filtering done by
> > cpumask_pr_args, I unfortunately did not spot it during my testing.
> > 
> > So here, I don't rely on what was printed anymore, but code exactly what
> > our restrictions should be in order to be aligned with rcu_nocbs - which
> > was the original goal.  Since the checks lie in "__init" code it is largely
> > free for us to do this anyway.
> > 
> > Building with NOHZ_FULL and NR_CPUS=128 on an otherwise defconfig, and
> > booting with "rcu_nocbs=8-127 nohz_full=96-127" on the same 16 core T5500
> > Dell machine now results in the following (only relevant lines shown):
> > 
> >  smpboot: Allowing 64 CPUs, 48 hotplug CPUs
> >  setup_percpu: NR_CPUS:128 nr_cpumask_bits:128 nr_cpu_ids:64 nr_node_ids:2
> >  housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.
> >  housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.
> >  rcu:     RCU restricting CPUs from NR_CPUS=128 to nr_cpu_ids=64.
> >  rcu:     Note: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.
> >  rcu:     Offload RCU callbacks from CPUs: 8-63.
> > 
> > One can see both new housekeeping checks are triggered in the above.
> > The same invalid boot arg combination would have previously resulted in
> > an infinitely scrolling mix of WARN from all cores per tick on this box.
> > 
> > Fixes: 915a2bc3c6b7 ("sched/isolation: Reconcile rcu_nocbs= and nohz_full=")
> > Cc: Paul E. McKenney <paulmck@kernel.org>
> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > ---
> >  kernel/sched/isolation.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
> > index 7f06eaf12818..01abc8400d6c 100644
> > --- a/kernel/sched/isolation.c
> > +++ b/kernel/sched/isolation.c
> > @@ -89,6 +89,18 @@ static int __init housekeeping_setup(char *str, enum hk_flags flags)
> >  		return 0;
> >  	}
> >  
> > +	if (!cpumask_subset(non_housekeeping_mask, cpu_possible_mask)) {
> > +		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' contains nonexistent CPUs.\n");
> > +		cpumask_and(non_housekeeping_mask, cpu_possible_mask,
> > +			    non_housekeeping_mask);
> > +	}
> > +
> > +	if (cpumask_empty(non_housekeeping_mask)) {
> > +		pr_info("housekeeping: kernel parameter 'nohz_full=' or 'isolcpus=' has no valid CPUs.\n");
> > +		free_bootmem_cpumask_var(non_housekeeping_mask);
> > +		return 0;
> 
> If Frederic applies his rcu_nocbs work to nohz_full, it may some day be
> valid to specify an empty nohz_full CPU mask.  Of course, it might well
> be that warning in the meantime is a good thing, but I figured that I
> should call attention to the possibility.

It isn't just a good thing ; it is required.  Call chain is as this:

nohz_full= / isolcpus=
  housekeeping_nohz_full_setup / housekeeping_isolcpus_setup
      housekeeping_setup
            tick_nohz_full_setup
	            tick_nohz_full_running = true;

So housekeeping setup is the "last chance" to validate inputs and
avoid calling tick_nohz_full_setup which unconditionally sets the
tick_nohz_full_running (as the crux of this problem).

At least that is as things stand today based on my understanding.

Paul.
--

> 
> 							Thanx, Paul
> 
> > +	}
> > +
> >  	alloc_bootmem_cpumask_var(&tmp);
> >  	if (!housekeeping_flags) {
> >  		alloc_bootmem_cpumask_var(&housekeeping_mask);
> > -- 
> > 2.17.1
> > 
