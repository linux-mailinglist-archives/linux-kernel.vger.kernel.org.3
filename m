Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A9949C160
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 03:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236469AbiAZCfC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 21:35:02 -0500
Received: from mga06.intel.com ([134.134.136.31]:55665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236471AbiAZCe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 21:34:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643164499; x=1674700499;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nyT2+WGo74r2BfNq/bBJLvEjlrC8b2TktIE0XyALL5g=;
  b=QcRtvxv7FXWxW6dHZAXsNuthZVqEzwEiqcfE/y0TYc5op6DdmylBT8F5
   IqQ9ZjxLleMAHFFgeZwPs5wD1v1uDTCxL5QJRSYtuYpusE+7hmL4bjCDy
   UNFzcZ04RD9BfhX+qDXus9O7Ouw46U5nLItslsq7UALQNT+vYvqDfxalA
   CqCBey8M7uo46ShL57qoeJLGO8AGcGCiDZNig91nIY25ECpN3Xn/y3nXo
   kTroeaCNnj+UTlxhg8I6jdY/ZRQCQ8ZJ2ULdDf0aT7FVK8J1d0sFhK29e
   jtHrgl3p6MxGbwXYc/ok1GcrGklEdpmYVytGbw2weBCZZ5iDERH9pibHL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="307182022"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="307182022"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 18:34:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="495219190"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2022 18:34:34 -0800
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 18:34:34 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 25 Jan 2022 18:34:33 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 25 Jan 2022 18:34:33 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.173)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 25 Jan 2022 18:34:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RB3jzwG8qheXYn2mccs5Ya9PngfD27oUzbroaSnvyzwWJXKQ1MmQbu59dPTTVLVZPpX2iY1NVSiL/Zfhwf8++XzdP1GqVT2BUwO22WraYllOPFmJsaym7YQQzsxZA46FP9kErUE9dWzBsIq+VaJEaQgyzj/fVrby78cNwjxPj6xV0sCt1SXUEWoM2xUkigtCTmjoVqJCI5uaSUVY6eFklhdyd11SId5Vok3989iC7IETbOomLFzyi9jbbuNufhuCtyQdLfPllXXTNumZIG2NALKMancVR2w/kajuGAv5N7bpR4Au2q/b1THe5G+VsHDsJyn5VFDAG6g0b0VqoLuMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JzkjjsbBedU6hbDCrKPaEDBbSyE2hshQ1QMYG1NKROM=;
 b=UlqhIwZvwdeQqYLXvNseUABhn8Y1BL2kWUhKFDISZGrAh2Uwvu4ySy9zXZwPwXniqKg/L/bOsb4XHslr10uk0B35RI8nkOMQFnDLFMA16p717sUwYeTDBpI1OAaMeWVFku6oCe5Zt7knC0s9nX4/n4al12OOVdTTE1F75FvynGVzn+7JR5vwF0TPupL4QozsZN7lB8Wc1A61UVFdrxY0uy5Zh1fLV9Fm0UvnjxjWdpG3/CwP2jnW2/KztaF5g4GJpf6y5tt9Segj61rIv8pr8nfJGCYjDn8iWv/9XXE+A3/gADixK/tqavTupxmuezso7wYNrJ3oyxZimadSFk9Ggg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM6PR11MB3273.namprd11.prod.outlook.com (2603:10b6:5:56::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 02:34:31 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9%8]) with mapi id 15.20.4909.017; Wed, 26 Jan 2022
 02:34:31 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Thread-Topic: [PATCH v3] rcu: Add per-CPU rcuc task info to RCU CPU stall
 warnings
Thread-Index: AQHYEZXmQkhOmxrSAkeH7BSBmewIgaxzUE0AgADMdYCAAHR8gA==
Date:   Wed, 26 Jan 2022 02:34:31 +0000
Message-ID: <PH0PR11MB58801E3E64CA745CA99135ADDA209@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220125024744.4186726-1-qiang1.zhang@intel.com>
 <df2d15fe-bc81-bdb1-1c31-2d717f274ab0@gnuweeb.org>
 <20220125191551.GR4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220125191551.GR4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 10c68bff-2471-4a85-66fc-08d9e074622c
x-ms-traffictypediagnostic: DM6PR11MB3273:EE_
x-microsoft-antispam-prvs: <DM6PR11MB32733702C8D38C7419FE70C9DA209@DM6PR11MB3273.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1923;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: McZt5sK87bkj+iXGyrJbayg+KelM35FlkGhTq1AWmcSV7k9zIXsJL6wyxkpzVBbbvytB8Xa5V3TVwq2fU71sFOk9Gtmn23Ay3Gsk2Mbt1zMRCePdSyHRB5ORoKru/dbPkdphZIxktkpx7lSqV/DVryNxUPcTnyX8n57vRdQC6cSSVMdy5TN3ddO5+zFqZ77XqP7YlcepSXIWJ13dZs+DlwSbSm9HC5W739DeRiKgegC69lTh/9QYKIq1J2Zt1L95OMxAkatgW3p0aIdH5TCENuhC2QQM0MMQNzf1CVmFNndGyoL+WDqKV3RXuj/SGVWnbAoG5GEJlCKo+ilmMMJqzxlCBh7XaMovvfANO/hBTEK1WSxxfWD+cSyUedS4qEIPkrrOGUaSgHj/nFE8Ct/7+4nX62ZXvHuxT5Nkm8moaEH763yyZmEGAl0tRda+MU9o29BJctJqxP8tCxToNjO/wHqjzvxOgxVt2IMC74JHlpwPl6VEtke53pbfrv6l1HQkDpyBrT4rravAvhwzEs6rOjns3YPCmYPqGzceFI9YW2WJ7uhnbLDouFOJ6I8LiZGZXG5jq0YR6/RMx+V2RrDsJnKzQwQj/u2dknzZCUXf3EXrRvbv73HNRyQnm3yQkdaI8vkby9Y7+38bsqmUZH8XUBHgzBJL6n9aHTqSI9krQEqXU8uagkexpDbvLCoHcZvrRUyL/cFaXTZkNjXLHwrBJfJR0ywFvi0+r0vjeaDeDBhUxnwhmiVX3kPrjMWrgY5evVcSjA8v7CgsKHV7xJJAgIJ9XPvk+DTEMH2S0xI5bdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(110136005)(5660300002)(38100700002)(82960400001)(38070700005)(2906002)(316002)(55016003)(76116006)(66476007)(64756008)(52536014)(8676002)(66446008)(66946007)(8936002)(66556008)(53546011)(4326008)(86362001)(84970400001)(66574015)(9686003)(508600001)(83380400001)(122000001)(26005)(966005)(71200400001)(186003)(33656002)(6506007)(7696005)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?fGdgD5LN7XuYO3RROv9NxgINazAWdofRSNiobBvleJy4NoyFpYFiWtW2QrUZ?=
 =?us-ascii?Q?XFQho8JI0Mr+Fk7V+1kyQi7cpwC7xrWagdHMXDAiE7Bs/8AviZBNsgb2NSOF?=
 =?us-ascii?Q?6l0WqSy18SJL4jI7KGZntfyRCMZVNfUbnGHFZS6P0J3flG0Wpfkpwn5T0MW4?=
 =?us-ascii?Q?4NQ6YjwsSpdtcwS8UH7FpL12QliEj0xiwQf8XrDh9rDD+VPhkKO/sFmf1mwl?=
 =?us-ascii?Q?m7widyGrQqTNgrrt7P5JTXuIRCcun7pdLaQGCy01derqIV9N4X4hM8hbGeNI?=
 =?us-ascii?Q?tgh3dowdRfgLmiNlJRep0Y0brLOTt1nO28TlEILdmk1AXi1ndrpMJp+2UI36?=
 =?us-ascii?Q?s9PXwVRO59R/g4KRwagZT/pjGgejQC4rjM6ysUuTK3m9B9R47V2fxSq11wm2?=
 =?us-ascii?Q?Lgmqz95vsYNl0f66t3uA7GIII9KU16lt5o3/ovsWndkRCr7BKjkoWwYJ/470?=
 =?us-ascii?Q?55Tuqt04r/YtXSgDE+dXSBfdz2mFQck9CJYZBy5J3ozjTI4aD0IWna7CxEZo?=
 =?us-ascii?Q?IlnGGj17i3029YZm0xkKZIm7aXs0JlKfMMiYZKVKLWnwyQd1YqixT5wVCj7X?=
 =?us-ascii?Q?jkXQy5sVxLXZZcKR8Xc5bNLcl5qHMw0z/7r1vbw7hh6+EaUtdBtlzfNN9nSP?=
 =?us-ascii?Q?0jhgasoHWFJ5lwRRbweWGyZJZVrdn4p8EIkoVMifEafxUai5NSae+mG+1L1e?=
 =?us-ascii?Q?m9v4VJgvDWworGHBaSw7L774JX61wP7+TeN3wWmYi1ueJ+gWhJhHsjIoBAn3?=
 =?us-ascii?Q?eql/PsDHw7EX9a1L+uBZ9mPpd+nrjJMrTch1xRH6169ANoZ+oW7YUlenuTTh?=
 =?us-ascii?Q?7MM/9TRV+2JSEuoODxJ6z8Dj0LwAmCtdLI2l2j2u2MbSPeeR9BlvSgCkdxXi?=
 =?us-ascii?Q?qRWguaHd+V6r5RAU4L80xYyDJzKM8Xq0vClTvHK8nP0YayINmcAS1Q2yLs16?=
 =?us-ascii?Q?bfeubw5a1WROx4SuiewME5QsEVACEnw3qFEs0Ii1FWPtqqXJX1yy03I9gWEZ?=
 =?us-ascii?Q?JjllVcOmxRBtyDdaX7HtuHCJSHgNp0VWPAE0bn8j2Xko2KKKs0BOgjTzS4Ta?=
 =?us-ascii?Q?UcMw82fvMzmj1QrG9fUfBMagbHUmCOpL8+s+PqAhGD6TgcxIN5UHC/Zvhxsj?=
 =?us-ascii?Q?jQHMglrustmsOQ5sciCF258AAJxT3XFZBMfc/7t7CwukpmrDgx5WMxFz3Z+B?=
 =?us-ascii?Q?TWbkDUXmb9dEikc9toUisCDsgFhKU8142EfYTaHg/URQkeZ2zLCyoMP8pusD?=
 =?us-ascii?Q?Bg+8V5uQVpw9YNxL8yo+hHIX8MFZI3pLvi+g5XlFsGHfTUsZ9xPTVW7K3CUZ?=
 =?us-ascii?Q?zs9FKl8qhAWlNfTrda94eFGpTo+qoLymXwCTKTbX2Sfdw8ncT2S7dWtJbP0o?=
 =?us-ascii?Q?g6Kk3X0l/5PV9tyNemHy0MN3XsD/wFz65dBYap1ySRvRZzG3qshR1XiWjr2o?=
 =?us-ascii?Q?AQ0RnljcxHiUvtDppJ31tdSwclA/88T5CpZiipzgW7XdTdrxdkiEQLPzIcgF?=
 =?us-ascii?Q?/yxAW/6av1FxMu+jlo2zbpHxWCtq8ynzzeaTQAwAZhb+EpX1P+mtxzovhOZX?=
 =?us-ascii?Q?jgY3EDGWfmuxD0wdOUJp6chuE/HEie9oD9TTqHIGQ+HGwibvfhjVWHXVAfj5?=
 =?us-ascii?Q?p9+O42L+mfBxxhk4ploeRnk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c68bff-2471-4a85-66fc-08d9e074622c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 02:34:31.6448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EJ01Ii4iYGairgwrMHCQFcQHXNkgEmEQyKpz3eNGyZ1cnWskW08ejQnWiVkVDTBeKOcTl98d5GOjQBuWTV4Lvg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3273
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Jan 25, 2022 at 02:04:04PM +0700, Ammar Faizi wrote:
> On 1/25/22 9:47 AM, Zqiang wrote:
> > When the 'use_softirq' be set zero, all RCU_SOFTIRQ processing be=20
> > moved to per-CPU rcuc kthreads, if the rcuc kthreads is being=20
> > starved, quiescent state can not report in time. the RCU stall may=20
> > be triggered. this commit adds a stack trace of this CPU and dump=20
> > rcuc kthreads stack to help analyze what prevents rcuc kthreads from=20
> > running.
> >=20
> > Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
>=20
> For=20
> https://lore.kernel.org/lkml/20220125024744.4186726-1-qiang1.zhang@int
> el.com/T/
>=20
> ```
>=20
> Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>=20
> ```

>I queued this wordsmithed as shown below.  Please check to see if I messed=
 anything up.  And thank you both!
>
>							Thanx, Paul
>

Thanks Paul,  this description is clearer.


>------------------------------------------------------------------------
>
>commit 72bdc0a6f8cfb7cc56238dc850b7fe236e7371cb
>Author: Zqiang <qiang1.zhang@intel.com>
>Date:   Tue Jan 25 10:47:44 2022 +0800
>
>    rcu: Add per-CPU rcuc task dumps to RCU CPU stall warnings
>   =20
>    When the rcutree.use_softirq kernel boot parameter is set to zero, all
>    RCU_SOFTIRQ processing is carried out by the per-CPU rcuc kthreads.
>    If these kthreads are being starved, quiescent states will not be
>    reported, which in turn means that the grace period will not end, whic=
h
>    can in turn trigger RCU CPU stall warnings.  This commit therefore dum=
ps
>    stack traces of stalled CPUs' rcuc kthreads, which can help identify
>    what is preventing those kthreads from running.
>   =20
>    Suggested-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>    Reviewed-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index f071c49b37118..e6=
ad532cffe78 100644
>--- a/kernel/rcu/tree.c
>+++ b/kernel/rcu/tree.c
>@@ -2859,10 +2859,12 @@ static void rcu_cpu_kthread(unsigned int cpu)  {
> 	unsigned int *statusp =3D this_cpu_ptr(&rcu_data.rcu_cpu_kthread_status)=
;
> 	char work, *workp =3D this_cpu_ptr(&rcu_data.rcu_cpu_has_work);
>+	unsigned long *j =3D this_cpu_ptr(&rcu_data.rcuc_activity);
> 	int spincnt;
>=20
> 	trace_rcu_utilization(TPS("Start CPU kthread@rcu_run"));
> 	for (spincnt =3D 0; spincnt < 10; spincnt++) {
>+		WRITE_ONCE(*j, jiffies);
> 		local_bh_disable();
> 		*statusp =3D RCU_KTHREAD_RUNNING;
> 		local_irq_disable();
>@@ -2883,6 +2885,7 @@ static void rcu_cpu_kthread(unsigned int cpu)
> 	schedule_timeout_idle(2);
> 	trace_rcu_utilization(TPS("End CPU kthread@rcu_yield"));
>	*statusp =3D RCU_KTHREAD_WAITING;
>+	WRITE_ONCE(*j, jiffies);
> }
>=20
> static struct smp_hotplug_thread rcu_cpu_thread_spec =3D { diff --git a/k=
ernel/rcu/tree.h b/kernel/rcu/tree.h index a87f31b1701db..926673ebe355f 100=
644
>--- a/kernel/rcu/tree.h
>+++ b/kernel/rcu/tree.h
>@@ -241,6 +241,7 @@ struct rcu_data {
> 					/* rcuc per-CPU kthread or NULL. */
> 	unsigned int rcu_cpu_kthread_status;
> 	char rcu_cpu_has_work;
>+	unsigned long rcuc_activity;
>=20
> 	/* 7) Diagnostic data, including RCU CPU stall warnings. */
> 	unsigned int softirq_snap;	/* Snapshot of softirq activity. */
>diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index 478=
1aa338c7c1..6082dd23408f8 100644
>--- a/kernel/rcu/tree_plugin.h
>+++ b/kernel/rcu/tree_plugin.h
>@@ -994,12 +994,15 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
>  */
> static void rcu_cpu_kthread_setup(unsigned int cpu)  {
>+	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
> #ifdef CONFIG_RCU_BOOST
> 	struct sched_param sp;
>=20
> 	sp.sched_priority =3D kthread_prio;
> 	sched_setscheduler_nocheck(current, SCHED_FIFO, &sp);  #endif /* #ifdef =
CONFIG_RCU_BOOST */
>+
>+	WRITE_ONCE(rdp->rcuc_activity, jiffies);
> }
 >
> #ifdef CONFIG_RCU_BOOST
>diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index 21beb=
f7c9030b..0c5d8516516af 100644
>--- a/kernel/rcu/tree_stall.h
>+++ b/kernel/rcu/tree_stall.h
>@@ -379,6 +379,15 @@ static bool rcu_is_gp_kthread_starving(unsigned long =
*jp)
> 	return j > 2 * HZ;
> }
>=20
>+static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned=20
>+long *jp) {
>+	unsigned long j =3D jiffies - READ_ONCE(rdp->rcuc_activity);
>+
>+	if (jp)
>+		*jp =3D j;
>+	return j > 2 * HZ;
>+}
>+
> /*
>  * Print out diagnostic information for the specified stalled CPU.
>  *
>@@ -430,6 +439,29 @@ static void print_cpu_stall_info(int cpu)
> 	       falsepositive ? " (false positive?)" : "");  }
>=20
>+static void rcuc_kthread_dump(struct rcu_data *rdp) {
>+	int cpu;
>+	unsigned long j;
>+	struct task_struct *rcuc;
>+
>+	rcuc =3D rdp->rcu_cpu_kthread_task;
>+	if (!rcuc)
>+		return;
>+
>+	cpu =3D task_cpu(rcuc);
>+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
>+		return;
>+
>+	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
>+		return;
>+
>+	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
>+	sched_show_task(rcuc);
>+	if (!trigger_single_cpu_backtrace(cpu))
>+		dump_cpu_task(cpu);
>+}
>+
> /* Complain about starvation of grace-period kthread.  */  static void rc=
u_check_gp_kthread_starvation(void)
> {
>@@ -601,6 +633,9 @@ static void print_cpu_stall(unsigned long gps)
>	rcu_check_gp_kthread_expired_fqs_timer();
> 	rcu_check_gp_kthread_starvation();
>=20
>+	if (!use_softirq)
>+		rcuc_kthread_dump(rdp);
>+
> 	rcu_dump_cpu_stacks();
>=20
> 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
