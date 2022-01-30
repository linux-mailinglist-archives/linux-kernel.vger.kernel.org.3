Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC294A3340
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 03:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353777AbiA3CS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 21:18:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:65065 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353761AbiA3CSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 21:18:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643509104; x=1675045104;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0GXYOBfmDx/MbakuRmi61UE9IzVwH+4EqM1jsJ1EpVs=;
  b=eT7GQ0EBzRkO95g5JEg+v0l9fKWZ97GO+MvSG38zNMJ60Xl1vCVFoFOu
   I8F/SuoqFFIjYlnj9rNiC5AOtT8TipdY8nBQvzF0xAAYY7pZimq872YNq
   dHNkZ7pXInLrg1GCzOHKQloQ91jLAmxuHiuFgTGMhnjG9i6wh9Tk5TzHx
   +DM76jmL7S5Qx1pnT/h4LDmltsQ0EnhFlTvH4JDzfKAdsBye8scA8z3Oi
   miCvnAk/06MA9eFsLG/doGC9G6IkibqBzw5VcXi4At8ceeSPCknpaVp66
   IApck5fl9l6i5prH+b2sm1zCJLtiQ792GdR60BJ/CQPJEc7IMO77rUIA3
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10242"; a="247261430"
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="247261430"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2022 18:18:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,327,1635231600"; 
   d="scan'208";a="619064840"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jan 2022 18:18:23 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 29 Jan 2022 18:18:22 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 29 Jan 2022 18:18:22 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Sat, 29 Jan 2022 18:18:22 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Sat, 29 Jan 2022 18:18:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JbEQpsfe8E3AmOWLWdgYr6zaujq+hjE7PWetCHPzaHGvIWTGFl8+mCX7mQGrcWlcXTm9W/sCEkEd8l8uptFXTpEQYWayZk6GgS42Fa6tYgIynyZi5JYweBFt00j2zGeDLzuEJJyw4Zkc9wlfFw7jqcmCJJg8BTgQ++DHRJ14+3nTl0rKPrzLzRArvEjI94TVr5l/dVxrBPQ5aRIl/4HTtUwl9ECjTxt9Vix+/osOX3J3yaGXQ4dJImF47JfdAMMG4YinUzZWuqUJm6tXlqMSckBbRKhgqTKpDM9lYPZiR6qIGywkEZJqPoKGgbUS4alJn6tDhzxHvfSwU4KDtJoaZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iNRikSbxBeh1WiCX8XmqZHpKLH97sNO1+PHcvJDpBaQ=;
 b=Bdx3wNeelfy8mY0voIPE7UiLxFW+LTlPrqUU15rFAq1tVGoEzepVJYdxnaPt1eoHVP7CDyBGsBV1g6W9OJOPNEWCYMkDeguN5V+aGkvC+pFEKJ7Lmjr0x7pjURoWBW4dwJ9ygw1MIhFGQxaTweJU1C9JRqiTgEWjUbdL5+2l/w6ww0ZGTIucaQH4iaj6Sf/HbUPMnj61ghOxCdtbJTiwHkHIJqnggNzfvMT0FlU2U0YStsZqHrK86qAUM8+TILFYZm+qRfGFb54swHcRR/HHoGTyFzRvKi/Y73P72P+MaxTvKe7qaRS5sfp/MUFtvqcQgfz5hR2FzFxrBevngx0iAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM8PR11MB5736.namprd11.prod.outlook.com (2603:10b6:8:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sun, 30 Jan
 2022 02:18:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::1476:8411:9a6f:23d7]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::1476:8411:9a6f:23d7%6]) with mapi id 15.20.4930.020; Sun, 30 Jan 2022
 02:18:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup
 waitqueue is not requried
Thread-Topic: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup
 waitqueue is not requried
Thread-Index: AQHYE/UODHHjhGvlP0WE4iSSid3cl6x5dzEAgAAFxeCAALgZgIAAmMcw
Date:   Sun, 30 Jan 2022 02:18:20 +0000
Message-ID: <PH0PR11MB5880282CC101743255D68136DA249@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220128031346.157961-1-qiang1.zhang@intel.com>
 <20220129051748.GP4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880073B7080265117EE2868DA239@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220129163721.GQ4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220129163721.GQ4285@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1200efd3-b0ab-4750-ed96-08d9e396c8b9
x-ms-traffictypediagnostic: DM8PR11MB5736:EE_
x-microsoft-antispam-prvs: <DM8PR11MB57364BAA3C3444501B5563BDDA249@DM8PR11MB5736.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8XDpFQUEGVsbTelVICHc6BpbXpfci4WqZ89PCMCxy6Hwe2kxGe6KwBarCQ5vutFQwVHhd6pSxky9vtabPSuc3ymxXX912MOR3D5Q1AMZK2oY+Of5gibeJe3Do5bq8Eimz6vGbuI8sSBeV5DMVXSRSVFn36tzPjytbD7z3/OiaWS3K81r1xXn8KSQ0u7WjPtypjfPxOet66x5/gy9Pr2HnfE35RJdhAhotmoXI+r9sSKy5LYJB3/hzf79mqhktmO98b0kbpGeZlP73rlYNsshcTo4o/V9qlR5hh6HiPOXQOgIM4EL6+rrD9W6B6qyKZUnasOKdvR/ijja9muc8OwzaKUHqy9yqGM4FVwiX8BisX7yLH5y1dE7IH/XyDFfAYprDypRHoiHbRl1C3wRGM1fimkkvALcbEo97kQnK5JOY2aE68AjFOD8u5DibS5y0mV510k6CRi95wh7yqXembrkWkqYT8r0nrL11GzZ/i51twjjggou0LJYuRgsdoAZMOFsso4AfR99bslJHA+b9KLVdg3DKMV0jRqNKix4qrXoo4z9oZunyfEuyJIULsr1UQA6gowbxw1p4GvEmQElTgfXk6BdBthFfYt4qaAQY4bcTwOXR7iI7Ax3nAtijKpWjpx3JFBDyV0iDB5lfX13Yc9hBl1Q1KC16ioVbgQh4ZN9/6KrwnOA32WJFXg6USiehP+DPmsF76y3/NglVes9NHaIhg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(7696005)(6916009)(54906003)(83380400001)(6506007)(66574015)(71200400001)(33656002)(508600001)(66556008)(66476007)(66446008)(64756008)(8936002)(38100700002)(26005)(86362001)(122000001)(55016003)(76116006)(8676002)(66946007)(4326008)(82960400001)(52536014)(38070700005)(9686003)(2906002)(186003)(5660300002)(316002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Ba8NVBtxQIr3GPR7sXIxxL3S8h+GrB541nvUhEL5Xt1OoSQiufo5C6UaWObx?=
 =?us-ascii?Q?yW7fetcsUQUe4aCHqviggxHohUxS8dbljKwkaVGRWbkbkTaYlXUj7aJ3QvZI?=
 =?us-ascii?Q?FDda4QemeG/Ozfwe+MOaEgvd18BOq4oYoY6vNobUZzdsrkw60CQKtTj4YiJg?=
 =?us-ascii?Q?dQMb/9E5FI22h60vyZ0DCCC0hpITx8oAU5WzaGDvBuTf3eWN6IGb4sjqIA81?=
 =?us-ascii?Q?vZIX4oH2RA4aY5zQNR1kg15+DJkCGbOAM9UoCEpGmOigM1dkH26Tlx7UvZz+?=
 =?us-ascii?Q?ReIbbw3y4a/sYfdRDPSKxgTpq5i9JFM/OSQZsNMtv6P3iEMtEjEK1a1UBpYj?=
 =?us-ascii?Q?YV/jP6Pu73M6gUhopJacGjvwEnZUp/956x4HsfhWPPwfWaCs/9ar2GO6DgFp?=
 =?us-ascii?Q?GVJeBJxmw3TJDZYaO9MLHh4ha1FC80DB/e6OdECvSoRZOxZ2n/Wri2iYl0Xm?=
 =?us-ascii?Q?jYCUBgfurMknWQVKuleOkA/y0MBi6bpriq6tTaG2CIxpdCT4p9Plm+OgVBVT?=
 =?us-ascii?Q?O6s7uG/6GZldW6UgqyxDeto0ZnNmsHvuJ5oUiC4rpVkQa0CyoDFqfuafaxyL?=
 =?us-ascii?Q?l36sTrNKxJhjQ26sWdr3l96U5gflpoGIbTjWMMHRJeo2rSwuFuQaEvJ57DM/?=
 =?us-ascii?Q?rPK3QcMM86yzko+ff705p2EOAnm9jOdU7S8cnTvDpknGsuYkEHUZ53YU5YL9?=
 =?us-ascii?Q?VPKMI4GTfU0M8wr0hokHKvQFgxWNAVeF3oEuqOgHzKveCaKKoKpbrODA5TDh?=
 =?us-ascii?Q?rw0kUsvcOCxDem77TDa4xtZ6nY9SFfl/TkpE6JvBZEAvNmYgCn/414UFQoB4?=
 =?us-ascii?Q?D5F1XiWCO5jFnfh0VvhGKwsqOAcmnto+9Rlb2BJ/oOxbmy+rwz6q0TPry8eD?=
 =?us-ascii?Q?r7oQxXK+5hRd2bq0ZToh5GG1BpJ7VPph+f+UOqle1EXnQr/+7nMeqiLdAwtc?=
 =?us-ascii?Q?ZaWo0oYBfHC5tLBv4eEALO5BJjR1RyVC5AQOMA+Y+2yhBrVcz+EYxaYWOIpK?=
 =?us-ascii?Q?D+n7G9zrofAA8nR7ASrLcMQXD0RYONYLEJ2mfOLITLQz+WrOCzZ6PVsgAY4d?=
 =?us-ascii?Q?s/hoi1tEnj1xVLGmvwMkmOlZ0hEzbXaSfcajZMaIpBikydGgPN21+pSjrMlq?=
 =?us-ascii?Q?4y8RZxf0vDBqZL8fHaWfu2j3JSqnDUyC5A6D7J2bxOo9jzyeajCtFiEt5XhA?=
 =?us-ascii?Q?T8HbPyFnYaHDhcK7VAEiFx9vSpudzWR469c2qawEWQ5cyzN5DDZcQlIdEsXX?=
 =?us-ascii?Q?IFyB8aaDuqvHaxwdd8wzfo7s+SPxeXoN+sTYUnnynB/ugM9e+8loL30cTmbf?=
 =?us-ascii?Q?PgqnRyWLHrO1UvcFIO3ORH5cbB/RyOExG/Ztfs4OJ2fu/MAZz2awvnKT+cVe?=
 =?us-ascii?Q?gk4WSuUl1m6OeqpUnlZ998DdhAWepwMLiextQX4HhFYGE6tc/yFsckMq7Evt?=
 =?us-ascii?Q?J8+NTeRwsSRUSuXJGoqGm5DZzkMBieof358igg60ZgdAxQ4C7o8UADFGo8UM?=
 =?us-ascii?Q?JeNOVRaTertI/IJr4Oq5ocab0xaNpPGv/REweVdbk0CleNrh5r2b1qcSowJ1?=
 =?us-ascii?Q?y1UOP5vOy0oT/cBTeDAEUoLoFrpC8Hr/cje+Dkt7iuYfrXhz7TZ3Afl7apeB?=
 =?us-ascii?Q?Kg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1200efd3-b0ab-4750-ed96-08d9e396c8b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2022 02:18:20.0925
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hT1u6wU6w5TNp0l9OAlBoKhmDZHlvoFrebESR5/veB2tdmOiuT7nxWEuZ4FIht+M3d8gl/1u6ai4GQEcgROnKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5736
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, Jan 29, 2022 at 05:55:34AM +0000, Zhang, Qiang1 wrote:
>=20
> On Fri, Jan 28, 2022 at 11:13:46AM +0800, Zqiang wrote:
> > When grace period cleanup, the rcuog kthreads that waiting in sq=20
> > waitqueue will be awakened, however if the 'rcu_nocb_poll' is set,=20
> > the sq waitqueue always empty, so if 'rcu_nocb_poll' is set, return=20
> > directly.
>=20
> >This does decrease grace-period-cleanup overhead in kernels built with C=
ONFIG_RCU_NOCB_CPU=3Dy and booted with the rcu_nocb_poll kernel boot parame=
ter set.  On the other hand, it increases grace-period-cleanup overhead in =
kernels built with CONFIG_RCU_NOCB_CPU=3Dy but booted without the rcu_nocb_=
poll kernel boot parameter set.
> >
> >Last I checked, more kernels were booted without the rcu_nocb_poll kerne=
l boot parameter set.  If this is still the case, this patch would slow thi=
ngs down for most systems.
> >
> >Or are there now lots of systems booted with rcu_nocb_poll?
>=20
> Hi Paul
> I found that some of our customers configured rcu_nocb_poll startup param=
eters under Preempt-RT kernel.
> at each grace period cleanup, we'll all wakeup sq waitqueue, however=20
> when rcuog kthreads is in polling mode, the wakeup operation doesn't requ=
ired, because the sq waitqueue always empty.

>>>OK, fair enough.  But was there any difference in performance measurable=
 at the system level?  Let's take a look at swake_up_all():>>>
>>>
>>>	void swake_up_all(struct swait_queue_head *q)
>>>	{
>>>		struct swait_queue *curr;
>>>		LIST_HEAD(tmp);
>>>
>>>		raw_spin_lock_irq(&q->lock);
>>>		list_splice_init(&q->task_list, &tmp);
>>>		while (!list_empty(&tmp)) {
>>>			curr =3D list_first_entry(&tmp, typeof(*curr), task_list);
>>>
>>>			wake_up_state(curr->task, TASK_NORMAL);
>>>			list_del_init(&curr->task_list);
>>>
>>>			if (list_empty(&tmp))
>>>				break;
>>>
>>>			raw_spin_unlock_irq(&q->lock);
>>>			raw_spin_lock_irq(&q->lock);
>>>		}
>>>		raw_spin_unlock_irq(&q->lock);
>>>	}
>>>
>>>If the list is empty, we acquire an uncontended lock, splice an empty li=
st, check a pair of pointers for equality, and release that lock.
>>>We do this once per 16 CPUs per grace period, which normally will be eve=
ry few milliseconds or less frequently.
>>>
>>>What is the system-level performance difference and how did you measure =
it?

Sorry  I ignored that. I don't measure performance differences at the syste=
m level, =20

>>>
>>>Please don't get me wrong.  If this really is causing your users trouble=
, we clearly do need to fix it.  But if so, let's do so in a way that doesn=
't risk penalizing the many users who do not set rcu_nocb_poll.

Thank you for detailed analysis .   the original intention of my modificati=
on is avoid  unnecessary wake-up operations,=20
when rcu_nocb_poll is set. In polling mode, the rcuog kthreads don't use sq=
 waitqueue,  however, every time the grace period cleanup,=20
all rnp nodes must be traversed for wake-up operation.  after that, I will =
do the test.

Thanks
Zqiang

>>>
>>>							Thanx, Paul
>>>
> Thanks,
> Zqiang
>=20
> >
> >							Thanx, Paul
>=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index
> > 636d0546a4e9..9e106c590e56 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -201,6 +201,8 @@ static void rcu_lockdep_assert_cblist_protected(str=
uct rcu_data *rdp)
> >   */
> >  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)  =20
> > +	if (rcu_nocb_poll)
> > +		return;
> >  	swake_up_all(sq);
> >  }
> > =20
> > --
> > 2.25.1
> >=20
