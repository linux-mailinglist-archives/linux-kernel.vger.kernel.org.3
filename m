Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50D2255CBBE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241407AbiF1AbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 20:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiF1AbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 20:31:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB34C1;
        Mon, 27 Jun 2022 17:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656376275; x=1687912275;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=eBX9aAd8tj00MSUH8BE9vQ8zNbphjzzyjW6MybH34q0=;
  b=cm0Bkfc4TONGKOBbDm90TVk/Fm3efIicPxTZ0j/eq0qyt1dJVCvL86LL
   9aNSA5NkcfebpUOv4ca0Mx/6DDL3XymVqaTQkolC3fHsNfOtG6vp9lEj/
   NyYpot/lXK7quxEwCnluzifQK4wvo0KhSkT9916PylGreNorpJxAyKD8U
   O1iQhmBE+KkNNnbBNHpP79x7fobKkc/S4gNACQB5JTw1nfXqXd196J6uS
   sDPFm8t7eYcAc7Guvy6h9n4U4NF4DVgGrWOvNcJQKMNBBcMHJsj4b7293
   8PJksinmx1SuG/lEIKu5ubGiwZYkvjQPaMicorRlK/fkFqAd+d0tANmL8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="261399978"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="261399978"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 17:31:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="594538695"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 27 Jun 2022 17:31:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 17:31:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 27 Jun 2022 17:31:14 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 27 Jun 2022 17:31:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 27 Jun 2022 17:31:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b6kazYEka1XsAfAWj8mX3ddklp1kkDgSl7IIPxeNMWux2c8NZATW84phMD5tcMWM5NHsLEFWJbTdsNNc+b785FAK743UydDhNAWYjUl8wnppOhHG7EgmjZWEvWDy0Zk6mOJT//wChxIeyrPFj/Ca5bIEHLQVqs+jOCIKKyvE1BJbwlTOu0UzO8Oj2/Erki96PvkP6BGb06PSIkYx1AJ2IGxSjfPyNLxc0Od7Bo3h1WOg0WIwIW4ljXet989zSpIuvqW3n/ePmzzPD4xBmhpQiXibnaa7xm+h1MCyyeWrDBfwtZFDa58Ygof8N/Kx5KDg13QGTdvueCKNK7Ih52CFDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Twv/SaZ8675nsEusQwgl2sBCVYhNtqzoXU94+/ge8OA=;
 b=V27CdVtXlLqFRgjzMi3RMVGrdNT4MHjmoyPpL6nteXVfFzqgLJAVeIiAsw4sPu4jQqOus/Xy74Lfj4HdQELHdPT7QrTkPhPOO6zdAs4j+4Rq3x1OadYQIkUEh5AovwWvCt1sgLAo7V761lCfBmvbv9bV+Vr2/a4AmCV+lJouAfGUUNGXWPN16zt3gjv14u2rE8HdXzklrz0mWHYP38bxKYcQia3rg5Wn+nx1Tqn+OUTDih8TLhdtjM0RgMZGXWZMEU9PUcnTLVdrxOsoIXa/wns3GsVEoZo/P0tAhbYJBa/V+G6mNhAeWu4/AypPmhfEfKLZz1fl1NctLxEh2N7Rxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BL1PR11MB6004.namprd11.prod.outlook.com (2603:10b6:208:390::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Tue, 28 Jun
 2022 00:31:12 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%6]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 00:31:12 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Topic: [PATCH] rcu: Add a warnings in sync_sched_exp_online_cleanup()
Thread-Index: AQHYhQ20/x4TmjWtSEepVJie126Nl61cGSeggAezNQCAADNyMA==
Date:   Tue, 28 Jun 2022 00:31:12 +0000
Message-ID: <PH0PR11MB5880B496CB57A804B95977A9DAB89@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220621012412.2724457-1-qiang1.zhang@intel.com>
 <PH0PR11MB588005D38E08891423310EBBDAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220627211658.GN1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220627211658.GN1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43a715ae-3a59-41b5-0365-08da589d80fd
x-ms-traffictypediagnostic: BL1PR11MB6004:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qJ/l0DY+1oib2ci57cOcwEmVAXJkYsVOtMzdgYthQl3RybzhYN++9Kh3GNM3QKuuNMRgsINSum0+6YxsdVU/kbkNTWmxgGAyUh4z3Ni9igduot42kRFDO404aci6ZCytbFKcl4Xwr4x9Ticlhj84ktVZISajhrKkx715u403C9QBzgqkHRlyrMqlysyypSufOkUwoC+fMuRQROkSdhbgSwwbnHB+UF76Pa/Y8v/5T/zntvoLZzydjHrVwWCg0ixkRcwdIaiShozlIh9T6/yiYPo7AlExJXTBPDylEhInhKyPf0gzTC6ls6JF/yRgPijOEygzdrjMD84HloQYhl0x6QF23WZEUZTJgPPX5ovYiJfffXpOvKyEI56jziXtaT+YEJXIDuynM/5hz1MDiiqf28ucnWcktNdPVSxlAxhWHdU4IOXpmhqH/ukpa7F5KMGh8xwCQKf6yeB7zxOLJL1hr8NOU9FUt/1K/vpOSTueSWn5Hpnv3ZqrtAkY0FiyPElPJy+x2F6ANQMQWVf6Le27nEm5cbDmwfjiVzfEcZFwBFpN+UNxExJTvpctN1luPbM66Zo540KeRCdKWXhlXjH03xnzaxChqdp/5lqwTi1L74GcsFUQqTrAQXMl5lG096McIuniGpz3NDDiijjf60OnjJ+0Rqd11MV/vwFh5F5tYbJsrH/JaE8nUCoN/iv6oT1eg04fRmAi59O/WqHd2G5qC6RfYuVOeaOuJsJQBuj+QWagHkvWuV9hSIzB7N8AayLqShv6F6Lt9gtyWtKHkxMt9o03mPD5uS2j2szNnn1/tlE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(136003)(366004)(396003)(41300700001)(6506007)(66476007)(38100700002)(86362001)(9686003)(38070700005)(82960400001)(7696005)(316002)(26005)(55016003)(122000001)(66556008)(2906002)(66446008)(83380400001)(52536014)(186003)(8936002)(478600001)(71200400001)(6916009)(54906003)(8676002)(76116006)(66946007)(4326008)(5660300002)(64756008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?dPUksDYLZarJHpdjHz3B0isG8dzUKFTeYlw4E0aknaD3bqsJtaZbexjsoNLY?=
 =?us-ascii?Q?hIozNjdFp/LkOI0kQ0QMA6wIWMzlq9ueRK9PLGGQHYVoGJbL198I7lHiz5d0?=
 =?us-ascii?Q?tKt2o461+tr7vWOSQfk9V7Y3206TUGy8gNwZOFy2Azvc8JEslOoTeKxZCbq6?=
 =?us-ascii?Q?nV0KL/fqiTxswundW6EvWXi5eEaq0+BKB/eoNhV9uxKpCMh71ZGO17af7zo4?=
 =?us-ascii?Q?K3eKRLs88OTxDqRHFeDvzax9f+WtiFimD2lq1c2/r18YVi0qwaZl7pz8q8oM?=
 =?us-ascii?Q?KmhidJlT7PN86gJOnhBMPV+0H6tj17ZpXmHpPMdllzNnr8HgM2IqYlxmDkX+?=
 =?us-ascii?Q?V1aZ0Hc02noyLsDQoTUaN5NjKIFw6UhuNysBa7iZZ+PVYt8EiZOq+Yqd8Ltw?=
 =?us-ascii?Q?s42UOat4ZyL6Qhi3p1o4111AHpBqDXBkbWcYyB+iMRF+YIr0doxdnwahFaPl?=
 =?us-ascii?Q?KyJkhqS9YURnZx4icnB4Y8dQdXBxTaQSyRRHPBvI+nmRFQYpgkxh9vjsHNoX?=
 =?us-ascii?Q?tPQHGwHoQpihsfisMaIcqrADCjm/h4TvpY+g7UmKCCVl7B8rVjS+LopPmz/L?=
 =?us-ascii?Q?04+Z4kPvRq7GuDXai6/ELTyc6wqnBEup/EDvYPXIPQjd/i1WJSObKkqmxtgF?=
 =?us-ascii?Q?JjG8MUDyg2zPtADE9jTKWQSO8oL0LaJ0IiLtJW+GwbY+4Sov3jj8evIOFKH2?=
 =?us-ascii?Q?xRG1VCeCSual8J5/rXazXwtK08GzWwTfDifFoMCHJrDuGaMMUxQu5CQJjP6h?=
 =?us-ascii?Q?3V+pdiidisDgMxi7AzVqLbeW5is6couIRcE9wwzBdheWjTKB1w40VGsLTjgx?=
 =?us-ascii?Q?BTl5v2X5xOgzkeeIdKoxkHUEKA69lrfDlHxY++g2GcmoMmws0Vroo3NkME5m?=
 =?us-ascii?Q?70V1s/q9xY9Ta3kKVoIAfWpB6nqlE0L1yXdm+nNL6r7oFvRUZIN9Kwsdqj5H?=
 =?us-ascii?Q?XJhFzYSdbwtuSCGGvTL2QLdKobbclMK5AAKhX75+QIYYn2reR/Xhw3UEtQBg?=
 =?us-ascii?Q?wIp1WjimQRqAq/RPncIzIwLf6HwvsYinp7iVnNRL5dCo88HFIO5+H/Ob+A+1?=
 =?us-ascii?Q?G6oHjqe61CiPfmmULCzr/cn1FZozEmcXNDwvhTZy6ixpz+4/71yJjJ5UXGbR?=
 =?us-ascii?Q?qOmXwUH5YX4RJL1eFYb08C0FXo+sRM/7UXchXy/FxVDpZMnVD7Z29bzIxW+R?=
 =?us-ascii?Q?bkkehuwdS+dzLKB0waMog+iYKV2T4xj+GaodQ6zWpd20au2YYE0fhcF5OfJ3?=
 =?us-ascii?Q?pirRdAmKwbeXjMibl9wGjgd3hUnEMEatXIrfcyaNhQumvkbxv8tUIDkDJyDi?=
 =?us-ascii?Q?WaM8zkq0E4TyrhWuPHnFCtjROJjXuSjpBAkF4kN3ODFPn6JfZLLsDtFxQar7?=
 =?us-ascii?Q?5c0983El4hVsOFA/79eP19KaeH5+1u+XtSL9IobTX/bWA/T5rbiWAwNE2ob+?=
 =?us-ascii?Q?l8zBgBPIT96qBb4H14xi6J/h983fcv3yxcgmR1GZM4X6juvkpRl5sf3PA0FY?=
 =?us-ascii?Q?4wQmigwhlzSJjYtqmL+/rouFukumwabKTY/nbh039z42mwVSpLJnkuQ/PyYa?=
 =?us-ascii?Q?8XDbO3MUowjb4dLT6jrkXGkNQXhL/mcUZKCGCCtP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a715ae-3a59-41b5-0365-08da589d80fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 00:31:12.3208
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wa3Qoe3nKWXHY6whV4Fsh6rFbx+TgTwIO/hPHsBP+Rao/55QeWAXYTm8w1akQf028qf8ucnmiARbp20vSU34vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> Add Cc=20
>=20
> Currently, the sync_sched_exp_online_cleanup() is invoked in
> cpuhp per-cpu kthreads when CPU is going online, so the CPU id
> obtained by get_cpu() should always be equal to the CPU id of
> the passed parameter, that is to say, the smp_call_function_single()
> never be invoked, if be invoked, there may be problem with cpu-hotplug,
> this commit add WARN_ON_ONCE() to remind everyone.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_exp.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index be667583a554..ae8dcfd4486c 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -865,6 +865,8 @@ static void sync_sched_exp_online_cleanup(int cpu)
>  		put_cpu();
>  		return;
>  	}
> +
> +	WARN_ON_ONCE(my_cpu !=3D cpu);

>If we are going to add this sort of warning, why not instead add it
>to rcutree_online_cpu()?
>
>The reason the warning has not been present is the prospect of concurrent
>onlining at boot time, which might have rcutree_online_cpu() invoked
>from CPU 0 for multiple CPUs at boot.  However, the for_each_online_cpu()
>loop has recently been removed from rcu_init().

The rcutree_online_cpu() is always invoked in per-cpu cpuhp kthreads,=20
and even if it is called directly through the for_each_online_cpu() loop in
rcu_init(), since the rcu_init() takes precedence over smp initialization,
only the CPU0 is online at this time, still only called on CPU0.

Thanks
Zqiang

>
>But I would like to hear what others think.  Would such a warning
>significantly help debugging?
>
>							Thanx, Paul
>
>  	/* Quiescent state needed on some other CPU, send IPI. */
>  	ret =3D smp_call_function_single(cpu, rcu_exp_handler, NULL, 0);
>  	put_cpu();
> --=20
> 2.25.1
>=20
