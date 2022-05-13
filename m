Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23D0525932
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359864AbiEMBD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357632AbiEMBDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:03:25 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F67440913;
        Thu, 12 May 2022 18:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652403804; x=1683939804;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cpkj2SW697qIa5Ou5XXoq8Bpx6zGzZM67TXfdH23eH8=;
  b=CLX/MJsxCgBS4ICDU/PXqQ/X1h1Cu4u3bdjVjguytPI0kfJH+dw4Akdn
   Lj8TX5RpT1C7zBY2GMk9+EA+I5amoWmkoE9+p41wRc/WHGCvgilgS5dWy
   myyS+U0G9eJXqvg3AqC+EUTQr8kv79nT+YZuUOfYr2ayXuW14wBTSjHLv
   uq0ceD6K1aw2GXm0MfckzQM/aWj6mOQ0FfN32rjhg+Qn03pQsELUbobEx
   64rdNDAVN6fJB8os7kOSQHMG6qIcdYzOWjJj1knX08ny4txbqn1iYckk2
   52UnFt5sRVUIbBbO+fRFTQQq2osyOUsdCHpMOuFH/XfzCOj1pI+QL2NKc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="252225955"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="252225955"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:03:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="698283945"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga004.jf.intel.com with ESMTP; 12 May 2022 18:03:23 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 12 May 2022 18:03:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 12 May 2022 18:03:22 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 12 May 2022 18:03:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G1g1+fNUZbCwTCJewwY7706fK3GF3bOAKI5AlDq8y3qTDPO1LrXaIKZM1wC9L5n7Fp+sV+HSUfkcnl33gPt10MF6lUv/QhoVEIH6yXP4nHdYEVWyGrKLuZfe/bcumSrZitLZvK+JWIm+h/yLOxCfBbDmCzkK86R/bO4/CUsp/DQZn9pptEowlblx6OT12+5jrjUVjCnr7RVCNPrjxzYb2HtfkYgFkHiYyKrFEoA1aRR4Ty6m71idf/8opjI+QbrDF7yqRXiOG6jo2SjxnePvglBMRfRvGQ1S3iWbuWpR0din2bhC5evlg6RMmd9FICeEANkYWHVTKXCMdVcFH5DO5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6HyPipEr8vX3OTH4VwKiqsokP7KKDEgvM7hT8O88aE=;
 b=m05fw2Z5N1xi8L5ts+4Fu7isXp6UsOUCHigl2xDRn0JucNZbJyNhBuQymLzXRXs0S7jK4i31XcwwjEu2HLdnEcQf1t2HtzLv60E7DAO5T0ZDEkcjQlHtmOq95QkRlmi8dqgWXy5OjRHO7IKWBNwI5b02d41+MDvrMPwfGC0CtTsRlJPwW1nAuJGOr2i2BS8zl1NDsdAkF48afJxplKH51ShaKDMO3x6aVs2mfoXK77tgjYWd8A4suqBdhQv/hQZF8pDj09VUaU7vmioEWh9bhsLZV8LoPpLmoQgGOO9BZe6MospkXq/zxmr/K29NVcnXiCKUKrEgO9GQK7M7i8frCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MWHPR11MB1728.namprd11.prod.outlook.com (2603:10b6:300:2b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Fri, 13 May
 2022 01:03:20 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%6]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 01:03:20 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Topic: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSA=
Date:   Fri, 13 May 2022 01:03:19 +0000
Message-ID: <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c0f4203-bcb0-402b-5be0-08da347c5eee
x-ms-traffictypediagnostic: MWHPR11MB1728:EE_
x-microsoft-antispam-prvs: <MWHPR11MB17283542BB48D246DA59AD50DACA9@MWHPR11MB1728.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EEZg0WvLkHlkTVYAVqASXuMU2S//B87mhv/lkOh7kkGlyS/+AT3lXqfwdnwqeNp8rQAeVZYlmgURkDSxvwqWOBsSHYjOOhbjZiYIUAtmGcNU2j9E7cB2RUcLESgukf34n4GOMeDFPnk81SOQkpHGoxtrEdAxJE8XL/FD3+I+pKtpzGKAzDzxnOaPzcdAqJenEqlAW5K8r80lY64c+i5IlDRQFWD/RD85fvqsgvb+Tu/v8iQuhz6NLZnRWWXPwIf4ntyMtC5xqGhWL+m61iH0HfqVSSsb1SWuF5ztx7WKolEmBqm4ipIHuTGOMD9NRTU+4xko1uVNN6Y11aJWivWg2GtLz8xxZJ+2IbS4v5XGHc428+3FmOTK9DI7Ghjl18bj+A13s1MloRSdX+BItIOZ+Hf28NuK2th/gZCJaNml6O3uJGI8khB7C2uzVANmKC9IWSg4fMiC0r4w60566tyvk7ZN+Ynvg22eTVUe8wVNMLjNhMfgmFY7jN5+QNSK3nEgS3JskizSGe6Hi7j+rBXZwOCs20KuXgrfVpyd/OualoJDQSJIbhjYPl0ltLqAsOKqDUIlttTJXesXlgQHdAc0mBLFhRsAt1N/JEpKbmpNj7vHIsm3aiiGfRuI+jp+E9+2oSL+A0WoHItn8An0pm+0kLnQy3aruzmXE80rRMUlG7titRS2CYdyLB5cg16Ke/zqlYxLPiNL0+Oj8lTv1z2znw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(33656002)(9686003)(316002)(2906002)(71200400001)(83380400001)(82960400001)(55016003)(54906003)(508600001)(8676002)(8936002)(26005)(6916009)(186003)(122000001)(38070700005)(86362001)(52536014)(45080400002)(38100700002)(5660300002)(66556008)(7696005)(66946007)(6506007)(66446008)(66476007)(64756008)(4326008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lDMxvoXs5IpqvcYe7CYqV60vU2gbDnTNymqDnfrk0KEDAIuvfINBO6AQf6De?=
 =?us-ascii?Q?ahzIsayC32FqX8RXgmW1ioiTS58pQoBLytJeUoAPBU99eV+uEzzg2yk+ySlM?=
 =?us-ascii?Q?hG+Dcq+X4A2J+S7ffRteRvOB09f81aE4LpNpEWZHtkqbyLqT1VlNGybRfvrj?=
 =?us-ascii?Q?PlLBE9j2ADFQH+BuX8Q33cTQObP9sm4WqvsQjk3xw2cNarWioJetCp4CggzC?=
 =?us-ascii?Q?e/KJoxhVJe8ADKJqdPlpLhcDvlmvWWgNOfL02t7mJJtLs8X6Uj26Sp4vfKys?=
 =?us-ascii?Q?dVwpzathtaC2x8xjliziKnmavWzfu5r4MQPkse21GvNW78gd/QVQhejO/ZWp?=
 =?us-ascii?Q?SJpq6faQA+5XCGxyHhF18cjdfhfoG3Zeo4CTH0uWfYrFyALziddFp3I2GuMf?=
 =?us-ascii?Q?gfwty2GJwDty4ICDECXLRXhAtfSLZp+jpJrOOZwMfNuuoMpvAUvnzN562BI0?=
 =?us-ascii?Q?cTCkRP2kyk75A7jE7tFx9n1mjXpJScf2aPmvS+NxF/W2JV9F3j0FxNu4O9Sj?=
 =?us-ascii?Q?wwLcvyt3A8AsiB2hoGywONLMR/9fyy1V7QCqBX8V+xz3kT3m9HFT+pqolSjK?=
 =?us-ascii?Q?A0bqaUCJP3Rof68XXLXMyc4QDxmdtWeLR8voucIedgb0bGzHXZw9CUyrpjmf?=
 =?us-ascii?Q?2rTRkeyJEeRBSfWuE2bVL2R3PZDyaPrpq1v89g9brLnxF97Wv03WM0ZvDdYS?=
 =?us-ascii?Q?M1FFxJOBGwyfFcN4EG+PRhCpmUVkBTnnRknZaqG8XVtIheno2Wj3CbMQBfJD?=
 =?us-ascii?Q?FNo0sA3aUJ7QJc/EsXMgW88DxhfZgF+W8OYRoVk8iHLjE4cnHvOasNsS5omp?=
 =?us-ascii?Q?IZtPm1MvmSNIQypFNq3crFBotKD3nr1p6qghrfULr08h2D1yhxrwL+SekqS3?=
 =?us-ascii?Q?2IKsFaJzbLBqiy49j+DwL5892esYjwQat/egscFqZbYZKyolJDASKuUaLqWF?=
 =?us-ascii?Q?PcoIthZrsHmmmK/Oy7DPXbnNddJ5BJc4SJkD2ugt7Hir/ehJ1PQ3cYG7Xvdu?=
 =?us-ascii?Q?HHi5F0e4WEAeA9C5zV0bAJ52+ikxuwXGA5dAZhb2Yl/SmKt6042Qu3KYxRqM?=
 =?us-ascii?Q?xnX0tSsrjv/iI0UBYRPAA/i3WURUH8hYA4bHSC3gzQoAVeKwgSAVQRtfyuo1?=
 =?us-ascii?Q?AohNRZh9J2LGeBlY+pAjp/KO2gj+OYU1HA//8As9MJVT6QT2uJ6WV9LA3kAk?=
 =?us-ascii?Q?l39O2PLMwydp4nM9tVFynVGvP8zj7rmsAWKJP72DJqcFt7Vy0QL7zbkMvAb4?=
 =?us-ascii?Q?NmFBtPs9APzlSB5NBmw4wCBn+o2lelHOEHhoPNncAP4F4+5gx7e/KrfIWCOp?=
 =?us-ascii?Q?7BFhqjGsL5WtD85U2PXzUtqi7q9DmRr51AXZhbQ4clFyyR2ecVJJetUVPIhP?=
 =?us-ascii?Q?IIFX2SgJbxCXfayrGQyfhc/6/mm9E4qmw1PjQK7HyowHrOs1CTrw6OM+0d4b?=
 =?us-ascii?Q?HAvdmc4PMVS4L7KO5FZulsxk7jh/LvVt8Hxutl50kW5YISX74VmLooOIksH+?=
 =?us-ascii?Q?qNhn17DCoyobxhOfF0urFdM5ON0PRtOHadCfVjRwcSJDXUn2aE1kT/kRDfGK?=
 =?us-ascii?Q?kaBLdVrmeQ5YZCA5Ze0tloVSVAlc/ZcTlPVR4L+XUSrxIz/Eus6uM53wfKjh?=
 =?us-ascii?Q?OyeQbscNy/9GJPLxxa7JVGunCXuOhnqmjgxGtqxHLC3RPixgSkj/4kBS9nrS?=
 =?us-ascii?Q?rHcVujgJ4De7hOcj624epnsya3HxLpiOr7iAXOrQRKVj/065osXOkQhYzGo0?=
 =?us-ascii?Q?L0ixAljMxw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c0f4203-bcb0-402b-5be0-08da347c5eee
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 01:03:19.8989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BXh8NG4Hr1b4thA4rX8wkHL0HU8yr9fRii7Uw/6V0c3rIEfW9dwgOAA76n9DEVawS0OQHaF/xdoSnAgzpUkcfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1728
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> Currently, the double call_rcu() detected only need call
> debug_object_activate() to check whether the rcu head object is=20
> activated, the rcu head object usage state check is not necessary and=20
> when call rcu_test_debug_objects() the debug_object_active_state()=20
> will output same callstack as debug_object_activate(). so remove
> debug_object_active_state() to reduce the output of repeated callstack.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Could you please post the output of the dmesg output of a failed check wit=
h your change?
>

Original output:

[    0.818279] ODEBUG: activate active (active state 1) object type: rcu_he=
ad hint: 0x0
[    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_print=
_object+0xd8/0xf0
[    0.818301] Modules linked in:
[    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.=
18.0-rc6-next-20220511-yoctodev-standard+ #75
[    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
[    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 89 =
e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <0f=
> f
[    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
[    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed10200=
67f4c
[    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffffbfff3b=
f5c6d
[    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 00000000000=
00001
[    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 00000000000=
00000
[    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlGS:=
0000000000000000
[    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 00000000001=
506e0
[    0.818330] Call Trace:
[    0.818331]  <TASK>
[    0.818333]  debug_object_activate+0x2b8/0x300
[    0.818336]  ? debug_object_assert_init+0x220/0x220
[    0.818340]  ? __kasan_check_write+0x14/0x20
[    0.818343]  call_rcu+0x98/0x1110
[    0.818347]  ? vprintk+0x4c/0x60
[    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    0.818354]  ? strict_work_handler+0x70/0x70
[    0.818357]  rcu_torture_init+0x18be/0x199e
[    0.818361]  ? srcu_init+0x133/0x133
[    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
[    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
[    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
[    0.818374]  ? srcu_init+0x133/0x133
[    0.818377]  do_one_initcall+0xb3/0x300
[    0.818380]  ? initcall_blacklisted+0x150/0x150
[    0.818382]  ? parameq+0x70/0x90
[    0.818385]  ? __kasan_check_read+0x11/0x20
[    0.818389]  kernel_init_freeable+0x2b2/0x310
[    0.818392]  ? rest_init+0xf0/0xf0
[    0.818396]  kernel_init+0x1e/0x140
[    0.818399]  ret_from_fork+0x22/0x30
[    0.818402]  </TASK>
[    0.818403] ---[ end trace 0000000000000000 ]---
[    0.818405] ------------[ cut here ]------------
[    0.818405] ODEBUG: active_state active (active state 1) object type: rc=
u_head hint: 0x0
[    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_print=
_object+0xd8/0xf0
[    0.818424] Modules linked in:
[    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.=
18.0-rc6-next-20220511-yoctodev-standard+ #75
[    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
[    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 89 =
e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <0f=
> f
[    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
[    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed10200=
67f4a
[    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffffbfff3b=
f5c6d
[    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 00000000000=
00001
[    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 00000000000=
00000
[    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlGS:=
0000000000000000
[    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 00000000001=
506e0
[    0.818451] Call Trace:
[    0.818452]  <TASK>
[    0.818453]  debug_object_active_state+0x1d6/0x210
[    0.818456]  ? debug_object_deactivate+0x210/0x210
[    0.818460]  ? __kasan_check_write+0x14/0x20
[    0.818464]  call_rcu+0xb7/0x1110
[    0.818466]  ? vprintk+0x4c/0x60
[    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    0.818472]  ? strict_work_handler+0x70/0x70
[    0.818476]  rcu_torture_init+0x18be/0x199e
[    0.818479]  ? srcu_init+0x133/0x133
[    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
[    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
[    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
[    0.818492]  ? srcu_init+0x133/0x133
[    0.818495]  do_one_initcall+0xb3/0x300
[    0.818497]  ? initcall_blacklisted+0x150/0x150
[    0.818500]  ? parameq+0x70/0x90
[    0.818503]  ? __kasan_check_read+0x11/0x20
[    0.818507]  kernel_init_freeable+0x2b2/0x310
[    0.818510]  ? rest_init+0xf0/0xf0
[    0.818513]  kernel_init+0x1e/0x140
[    0.818515]  ret_from_fork+0x22/0x30
[    0.818519]  </TASK>
[    0.818520] ---[ end trace 0000000000000000 ]---
[    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu_tortu=
re_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory


After apply this patch:

[    0.647048] ODEBUG: activate active (active state 0) object type: rcu_he=
ad hint: 0x0
[    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_print=
_object+0xd8/0xf0
[    0.647073] Modules linked in:
[    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         5.=
18.0-rc6-next-20220511-yoctodev-standard+ #77
[    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
[    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
[    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 44 89 =
e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 00 <0f=
> 0b 83 05 7b 62f
[    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
[    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00000000000=
00000
[    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed10200=
67f4c
[    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffffbfff46=
7586d
[    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 00000000000=
00000
[    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 00000000000=
00000
[    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) knlGS:=
0000000000000000
[    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 00000000001=
506e0
[    0.647104] Call Trace:
[    0.647104]  <TASK>
[    0.647106]  debug_object_activate+0x2b8/0x300
[    0.647110]  ? debug_object_assert_init+0x220/0x220
[    0.647114]  ? __kasan_check_write+0x14/0x20
[    0.647118]  call_rcu+0x98/0x1100
[    0.647121]  ? vprintk+0x4c/0x60
[    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
[    0.647129]  ? strict_work_handler+0x50/0x50
[    0.647133]  rcu_torture_init+0x18be/0x199e
[    0.647136]  ? srcu_init+0x133/0x133
[    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
[    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
[    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
[    0.647151]  ? srcu_init+0x133/0x133
[    0.647155]  do_one_initcall+0xb3/0x300
[    0.647157]  ? initcall_blacklisted+0x150/0x150
[    0.647160]  ? parameq+0x70/0x90
[    0.647164]  ? __kasan_check_read+0x11/0x20
[    0.647167]  kernel_init_freeable+0x2b2/0x310
[    0.647171]  ? rest_init+0xf0/0xf0
[    0.647174]  kernel_init+0x1e/0x140
[    0.647177]  ret_from_fork+0x22/0x30
[    0.647181]  </TASK>
[    0.647182] ---[ end trace 0000000000000000 ]---
[    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu_tortu=
re_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory

Thanks,
Zqiang



>							Thanx, Paul
>
> ---
>  kernel/rcu/rcu.h | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>=20
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index=20
> 15b96f990774..0604ecd16627 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsigned l=
ong new, unsigned long old)
>   */
> =20
>  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> -# define STATE_RCU_HEAD_READY	0
> -# define STATE_RCU_HEAD_QUEUED	1
> =20
>  extern const struct debug_obj_descr rcuhead_debug_descr;
> =20
>  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> -	int r1;
> -
> -	r1 =3D debug_object_activate(head, &rcuhead_debug_descr);
> -	debug_object_active_state(head, &rcuhead_debug_descr,
> -				  STATE_RCU_HEAD_READY,
> -				  STATE_RCU_HEAD_QUEUED);
> -	return r1;
> +	return debug_object_activate(head, &rcuhead_debug_descr);
>  }
> =20
>  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  {
> -	debug_object_active_state(head, &rcuhead_debug_descr,
> -				  STATE_RCU_HEAD_QUEUED,
> -				  STATE_RCU_HEAD_READY);
>  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
>  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> --
> 2.25.1
>=20
