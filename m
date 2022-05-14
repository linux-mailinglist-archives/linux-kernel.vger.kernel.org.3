Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2C4526ECA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbiENC5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiENC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:56:47 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F039B3227BB;
        Fri, 13 May 2022 18:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652493163; x=1684029163;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1TX3aV7OgWIzBfqnwLt/7E5cVLJehPW6Q2wBybOPg1s=;
  b=jwGLJl6wd2r6hki2NdfNSNY7Uq0EL0SGaKvoMk/3BjR9sRwL9HoEHk4Z
   /M3OESq/Go+Q7EqlZBxa4V5v7rQMJB4K776nu7btkUdi6Mk9HkbKsDPnl
   Bo2ssb9Q48jJV0nG0R/yDL+sBmXPvJqG2nfYopltjoZGZBD88EZf6Mlk2
   PiyZ5wzZqLR31WFPQZ5C0kBT6klfonJ/4RLg+IQpcRkuopKS3FW9jmo0r
   kH/upMbr+54AmfjWmjIPVms/ltzeDO7bptu/FO+pcbkpHw20r1z5+S7oP
   PYMmCXMJ2sD/55ZES/XLri/wbb33JpinYRMPOftO/fwqzpukB3eof1rrN
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="295702627"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="295702627"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 17:02:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="521627058"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2022 17:02:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 17:02:44 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 17:02:44 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 17:02:44 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 17:02:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N31T7WTy+Onj85lYuaA9gUr39iAZG7iDriYHOakbNv1LieUtdlehs+cST4ePLpP8dH/8xzYIZvzSFzXtqo9O4MAI35D7cO2p5PaVoLVEM/B2g3JqkyWP4av0Md8PN26RUrV6IQ0ImsLCZ9zNj0nvlNO0myMb4BlKwuxA11rdPkcfucu498lpmQSWSkzwnyazOOnUrKcnK4ysmjM7QHcWyi7WRKGx8OcCjn6XuTgB0reoiQp+ZIoFC8bY+WPX20N3remnVh/XHirrrtJFP7UpEls9NFo+tlfMLBU/aiAzS6EcrHPs6czYDA74Lx8IckZgzV92/XQSztu9kF50CnidAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3w6IPbLaY9SH7x5OcIUS1l90rTgLLdDUtXS1WC2uMX0=;
 b=HgO55s1iH/2dFJXBTGPDqA3+tYTawdQik37Gzxzc7A+v5N5rrnRmiWr5gVNtGOziIARJQ5zui8w7u4eEPozyo2GStTBQFYP+9XbrId6qxiilpLWl4vMovNbOcwZBrWUf4DbeH+YxmsfA5Nvo8eNnmiNRBq1H6xHdduzqT6KKaqza8tARaxW/QGhVIS7ueXNqk9esrSJkbm5teAAO+UELmwrBfY8sI6spTbGPwcTy60cFV63yYTtpFsGQB5Z9J84pvebLLWuK73bu98hegSOnS4PrD1sQxLcUgjr2gYmO2fKyxep9y5ahzhgYNENfHUNHIkhfiR+beoYrEyOyObPMCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DM8PR11MB5751.namprd11.prod.outlook.com (2603:10b6:8:12::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Sat, 14 May
 2022 00:02:37 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%6]) with mapi id 15.20.5250.013; Sat, 14 May 2022
 00:02:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Topic: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Thread-Index: AQHYZBspeMDe3A1Muk2pGu69iofBM60b/oOAgAACsSCAAWeEgIAAFeAw
Date:   Sat, 14 May 2022 00:02:36 +0000
Message-ID: <PH0PR11MB588067B25F6F6AE96303055FDACD9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
 <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58804FA659B1FF7F82C37485DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220513222619.GP1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 2dac49ff-40a3-40f4-a93d-08da353d0dd0
x-ms-traffictypediagnostic: DM8PR11MB5751:EE_
x-microsoft-antispam-prvs: <DM8PR11MB575185D17609C0F0B530DFEADACD9@DM8PR11MB5751.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WZAotKw+9Egx8da7AleRD6wRy0AtswrS2/n5kQcGoYGOtNfLJ/wgoxp4tfXlq4i1XPajWPbsdN4fU+unWB8YwhDnuSf8g+ekp9fCkXjUD1wsFqfAlDj6X7uWLyNMU25LDmLPbPM7e3B0i6VilHDRuFKfwbqMiv6VqCTyfFwAbawmqgUazX8k5FTDQve4Q2VrCRmhPueB1c+ISuY8jfpOpq+/hJZ540sdDwxwSp8Lwd/0dtXsG+opJcqg6ujksKRYlZ8rceUOqiDOFDM4dTrAhvgr5loIvdSu94rrtgNGxPvBMJk2RRw6dmps73uOgmbbK+/Jwe1eO7kktNHQ2qo3rHKNFSo+r5Nti3NW+DgfjRLBX6bnYY+pzlin2jp7H1MeYcLIXcIFPp7mmCqrkjPI0fWsXXWqn8AL4Z619FQtrdrjGSo7TV6G835XYAppvgrFolv6xOVC3qEutBAz+K5V+4GOdDSgxvg8p1fA90WQdxMuW8FKmiMMafilJepJNX5pK0oDIT3o0Tkxlw8QnazrWgUVsNzgMDCUm2wzR6lipY3iApZ6zKmN3nCF9yW9Cx8W0IYFo53eSP1oxz/6Ghf1Q8P/lhM7IesQRoaW3qBorwMczQJb+TF0AIvYxXt9ameGrffSd2v2o39ajxa9HQ3bJX2bJ2zZqbaPQwrgHshYGwfzUQUm7c7O8i4STfMlJmudUWCrwofYI/Zk0kPBAROrJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(6506007)(76116006)(38070700005)(508600001)(7696005)(30864003)(45080400002)(55016003)(6916009)(54906003)(66476007)(38100700002)(66556008)(9686003)(66946007)(26005)(66446008)(8676002)(4326008)(316002)(82960400001)(83380400001)(186003)(71200400001)(2906002)(33656002)(8936002)(86362001)(122000001)(64756008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?wyB4UC/6nk8FyApTq7XsqOuATPrHPCc05sPt/GbTmjnirlWoJNWEknRTiWMk?=
 =?us-ascii?Q?eRcqq5GkZ9SvVMjJnEN8CuPMviB0Q3ng2I8+O+xhY2KkL8Rnb7/5/13MuO9P?=
 =?us-ascii?Q?eCIl1BFTATAI2PTg6u/HuI25//kmeC9xPvrnVzu5rjLTDhqjM3OsUXJcy1qy?=
 =?us-ascii?Q?fdx9EyaYlSsi2lTggNcCm+jMY4/EE8/ca+ay9aWtWqBkd9RxPQhUY/BgX6aQ?=
 =?us-ascii?Q?ydhaoEGl9HGU+131QTK3d8kx+wHIw1bdbDRXZrUU3OCasWVP8/hyt/I2dYZR?=
 =?us-ascii?Q?gQQC4/VWGNctw0AXjDrDbzLFjniWqnzX91ke/ugOSBTgAWell1f4LC9RVL/b?=
 =?us-ascii?Q?Nksoj+beO30zoow8pi6VJyp+rzEv1IsBZYXUao+2cldbO6pld7zjaYyM9PPD?=
 =?us-ascii?Q?WW3uKjNZ29AKQpSrpj7xt82eIOXB0lGoUjkKnZJR2csJ5T+ZMNPWmGEoEuFi?=
 =?us-ascii?Q?H+Yc9C3qKj5sHpWouvVRsXdH9XNgLg5gGs8/esULGHWW4PPNxZlywL+gWhBX?=
 =?us-ascii?Q?YZabQuFMw9ZnXQUsI4x4dNjAjBMfuBOgG74vu2go3h2N8WIV5X+y9xVpkXjL?=
 =?us-ascii?Q?kfHoZXbl0C40Aw3XIC/pfYAH/Jn8J2SwTOJCiP85ekuV54jkioY7jJ4jtuww?=
 =?us-ascii?Q?4uQdpN6T26KTOrI7sXlqp67DCQ/FWSEIy7G5o7N52UMG1gmvFWmIeb8vDmGL?=
 =?us-ascii?Q?tnsbOyZA5SPhJvGpfZ7Ly52+zssu10sZObNTvBr8EjeQiJwXSG83uKHAhKeb?=
 =?us-ascii?Q?jaxQdFs+z76xcofD5f8o/+0gWpFAf0jLMWUlvgf3+UBgbJo4f46y5ie0adMh?=
 =?us-ascii?Q?7tb8O68mbMmM0GyPxwy8ldpuaqtY+sw8ykVRgDJ5oWgE7aRaagMblHK+mtJX?=
 =?us-ascii?Q?BWp7OyqZElrFiNu271bxlYeV/v1PxE5egpPj71uw2mGcBnSY0+5JMS4xKwMS?=
 =?us-ascii?Q?5eQK+TUkeYZNhQSyR9CtxbkLyp8HDq0gXW4iJAzWFCgqGJaQBwMk5Z/q1VF8?=
 =?us-ascii?Q?CRi0c1azBbuKOmNtssxeHj4u0fvL5iL6T2WG79z9itPuURP1MTnopfdBpFnE?=
 =?us-ascii?Q?GDWpirmSoBbhVXaDal8FC53asWYPCME0xPfiwVi6e4AhqaPb2Iq+9NKoo1Dp?=
 =?us-ascii?Q?RD4Ke+YvvnQ8qRRuuNDxKgCglEFgXGn00Yx6ZiaKBYChlArcjqsq5lGoA7D2?=
 =?us-ascii?Q?xkDKsG7ZvozqmrhLEtHzHU3Mf57PExiAehq8ukP4DqDUgEvJYjrBOeHYbN6f?=
 =?us-ascii?Q?5IwNB8hlxg3Ou73msyx4E9ktmTYWQVVGktwAUlCyiS1PdLCtFPiJuzVCRJpG?=
 =?us-ascii?Q?ltq4dPyCpaylgU2N3qu2e/LumYXMVPhNerAfk7jDuYd1RWddshdBICzdB2MA?=
 =?us-ascii?Q?TcMjNigkkWP6J4Lgfrj/G5S9+rNzJRcdv+aS/9MJDG0F7exFiwSWobV6qnM+?=
 =?us-ascii?Q?05YrO4FK+SvfV8eth6DzHB2kk/So+PnyzGN8WsVKNvEWnrCpg56ABUDky7vD?=
 =?us-ascii?Q?F2+/JdLifaxm18Gq2LUvQCAl2OiW7qEy6AojMFw6KysBQNNg0g6yUWLl6gTk?=
 =?us-ascii?Q?G0YHIpQ064pry3vps8e9zXASMBIDxtQN/YCnSiHXDUZANYrS8h78clWzPbPP?=
 =?us-ascii?Q?3cEL1cDYNrI3wmFDagJ/4vcul8KVc3J3E0paS3lNyx/wyh1WW0dc66rC9pCK?=
 =?us-ascii?Q?12eSV+yQCS0XqnLR+yhdJQKcbx2PKqWcaJOFhReCCQ0FV7e9iWjtDFYms9QW?=
 =?us-ascii?Q?KTdMnplzgg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dac49ff-40a3-40f4-a93d-08da353d0dd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2022 00:02:36.6933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: whX1xcKPypn2RhkQbjTcBNaEPMVeWSoD+m7jtAmBoA5coKyEdQsyhrfZeNTjUCSMPLhhrte7Vfyc8IWsmDNrXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5751
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 01:03:19AM +0000, Zhang, Qiang1 wrote:
> On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> > Currently, the double call_rcu() detected only need call
> > debug_object_activate() to check whether the rcu head object is=20
> > activated, the rcu head object usage state check is not necessary=20
> > and when call rcu_test_debug_objects() the=20
> > debug_object_active_state() will output same callstack as=20
> > debug_object_activate(). so remove
> > debug_object_active_state() to reduce the output of repeated callstack.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >Could you please post the output of the dmesg output of a failed check w=
ith your change?
> >
>=20
> Original output:
>=20
> [    0.818279] ODEBUG: activate active (active state 1) object type: rcu_=
head hint: 0x0
> [    0.818296] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_pri=
nt_object+0xd8/0xf0
> [    0.818301] Modules linked in:
> [    0.818304] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> [    0.818306] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.818308] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.818311] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 8=
9 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <=
0f> f
> [    0.818313] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> [    0.818315] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    0.818317] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed102=
0067f4c
> [    0.818319] RBP: ffff88810033fb00 R08: ffffffff9b50d898 R09: fffffbfff=
3bf5c6d
> [    0.818320] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 000000000=
0000001
> [    0.818322] R13: ffffffff9ce769a0 R14: ffffffff9d039a80 R15: 000000000=
0000000
> [    0.818324] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlG=
S:0000000000000000
> [    0.818327] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.818329] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 000000000=
01506e0
> [    0.818330] Call Trace:
> [    0.818331]  <TASK>
> [    0.818333]  debug_object_activate+0x2b8/0x300
> [    0.818336]  ? debug_object_assert_init+0x220/0x220
> [    0.818340]  ? __kasan_check_write+0x14/0x20
> [    0.818343]  call_rcu+0x98/0x1110
> [    0.818347]  ? vprintk+0x4c/0x60
> [    0.818350]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.818354]  ? strict_work_handler+0x70/0x70
> [    0.818357]  rcu_torture_init+0x18be/0x199e
> [    0.818361]  ? srcu_init+0x133/0x133
> [    0.818364]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.818368]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818371]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818374]  ? srcu_init+0x133/0x133
> [    0.818377]  do_one_initcall+0xb3/0x300
> [    0.818380]  ? initcall_blacklisted+0x150/0x150
> [    0.818382]  ? parameq+0x70/0x90
> [    0.818385]  ? __kasan_check_read+0x11/0x20
> [    0.818389]  kernel_init_freeable+0x2b2/0x310
> [    0.818392]  ? rest_init+0xf0/0xf0
> [    0.818396]  kernel_init+0x1e/0x140
> [    0.818399]  ret_from_fork+0x22/0x30
> [    0.818402]  </TASK>
> [    0.818403] ---[ end trace 0000000000000000 ]---
> [    0.818405] ------------[ cut here ]------------
> [    0.818405] ODEBUG: active_state active (active state 1) object type: =
rcu_head hint: 0x0
> [    0.818421] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_pri=
nt_object+0xd8/0xf0
> [    0.818424] Modules linked in:
> [    0.818426] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-rc6-next-20220511-yoctodev-standard+ #75
> [    0.818428] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.818430] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.818432] Code: dd 40 9e 03 9d e8 48 62 a2 ff 4d 89 f9 4d 89 e8 44 8=
9 e1 48 8b 14 dd 40 9e 03 9d 4c 89 f6 48 c7 c7 c0 93 03 9d e8 f6 1a b1 00 <=
0f> f
> [    0.818435] RSP: 0000:ffff88810033fac0 EFLAGS: 00010086
> [    0.818437] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    0.818438] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed102=
0067f4a
> [    0.818440] RBP: ffff88810033faf0 R08: ffffffff9b50d898 R09: fffffbfff=
3bf5c6d
> [    0.818441] R10: 0000000000000003 R11: fffffbfff3bf5c6c R12: 000000000=
0000001
> [    0.818443] R13: ffffffff9ce769a0 R14: ffffffff9d039820 R15: 000000000=
0000000
> [    0.818445] FS:  0000000000000000(0000) GS:ffff888158880000(0000) knlG=
S:0000000000000000
> [    0.818448] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.818449] CR2: 0000000000000000 CR3: 000000017600e000 CR4: 000000000=
01506e0
> [    0.818451] Call Trace:
> [    0.818452]  <TASK>
> [    0.818453]  debug_object_active_state+0x1d6/0x210
> [    0.818456]  ? debug_object_deactivate+0x210/0x210
> [    0.818460]  ? __kasan_check_write+0x14/0x20
> [    0.818464]  call_rcu+0xb7/0x1110
> [    0.818466]  ? vprintk+0x4c/0x60
> [    0.818469]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.818472]  ? strict_work_handler+0x70/0x70
> [    0.818476]  rcu_torture_init+0x18be/0x199e
> [    0.818479]  ? srcu_init+0x133/0x133
> [    0.818482]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.818486]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818489]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.818492]  ? srcu_init+0x133/0x133
> [    0.818495]  do_one_initcall+0xb3/0x300
> [    0.818497]  ? initcall_blacklisted+0x150/0x150
> [    0.818500]  ? parameq+0x70/0x90
> [    0.818503]  ? __kasan_check_read+0x11/0x20
> [    0.818507]  kernel_init_freeable+0x2b2/0x310
> [    0.818510]  ? rest_init+0xf0/0xf0
> [    0.818513]  kernel_init+0x1e/0x140
> [    0.818515]  ret_from_fork+0x22/0x30
> [    0.818519]  </TASK>
> [    0.818520] ---[ end trace 0000000000000000 ]---
> [    0.818521] rcu: call_rcu(): Double-freed CB 00000000e2817fcb->rcu_tor=
ture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory
>=20
>=20
> After apply this patch:
>=20
> [    0.647048] ODEBUG: activate active (active state 0) object type: rcu_=
head hint: 0x0
> [    0.647068] WARNING: CPU: 1 PID: 1 at lib/debugobjects.c:505 debug_pri=
nt_object+0xd8/0xf0
> [    0.647073] Modules linked in:
> [    0.647075] CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W         =
5.18.0-rc6-next-20220511-yoctodev-standard+ #77
> [    0.647078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS r=
el-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [    0.647080] RIP: 0010:debug_print_object+0xd8/0xf0
> [    0.647083] Code: dd 80 9d 43 a2 e8 38 62 a2 ff 4d 89 f9 4d 89 e8 44 8=
9 e1 48 8b 14 dd 80 9d 43 a2 4c 89 f6 48 c7 c7 00 93 43 a2 e8 f6 1a b1 00 <=
0f> 0b 83 05 7b 62f
> [    0.647085] RSP: 0000:ffff88810033fad0 EFLAGS: 00010082
> [    0.647088] RAX: 0000000000000000 RBX: 0000000000000003 RCX: 000000000=
0000000
> [    0.647090] RDX: 0000000000000002 RSI: 0000000000000004 RDI: ffffed102=
0067f4c
> [    0.647091] RBP: ffff88810033fb00 R08: ffffffffa090d898 R09: fffffbfff=
467586d
> [    0.647093] R10: 0000000000000003 R11: fffffbfff467586c R12: 000000000=
0000000
> [    0.647095] R13: ffffffffa22769a0 R14: ffffffffa24399c0 R15: 000000000=
0000000
> [    0.647097] FS:  0000000000000000(0000) GS:ffff88815b880000(0000) knlG=
S:0000000000000000
> [    0.647100] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    0.647102] CR2: 0000000000000000 CR3: 000000002f20e000 CR4: 000000000=
01506e0
> [    0.647104] Call Trace:
> [    0.647104]  <TASK>
> [    0.647106]  debug_object_activate+0x2b8/0x300
> [    0.647110]  ? debug_object_assert_init+0x220/0x220
> [    0.647114]  ? __kasan_check_write+0x14/0x20
> [    0.647118]  call_rcu+0x98/0x1100
> [    0.647121]  ? vprintk+0x4c/0x60
> [    0.647125]  ? rcu_torture_fwd_cb_hist.cold+0xe9/0xe9
> [    0.647129]  ? strict_work_handler+0x50/0x50
> [    0.647133]  rcu_torture_init+0x18be/0x199e
> [    0.647136]  ? srcu_init+0x133/0x133
> [    0.647140]  ? __mutex_unlock_slowpath.isra.0+0x270/0x270
> [    0.647144]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.647148]  ? rcu_torture_barrier1cb+0x40/0x40
> [    0.647151]  ? srcu_init+0x133/0x133
> [    0.647155]  do_one_initcall+0xb3/0x300
> [    0.647157]  ? initcall_blacklisted+0x150/0x150
> [    0.647160]  ? parameq+0x70/0x90
> [    0.647164]  ? __kasan_check_read+0x11/0x20
> [    0.647167]  kernel_init_freeable+0x2b2/0x310
> [    0.647171]  ? rest_init+0xf0/0xf0
> [    0.647174]  kernel_init+0x1e/0x140
> [    0.647177]  ret_from_fork+0x22/0x30
> [    0.647181]  </TASK>
> [    0.647182] ---[ end trace 0000000000000000 ]---
> [    0.647184] rcu: call_rcu(): Double-freed CB 000000009a684b70->rcu_tor=
ture_leak_cb+0x0/0x10()!!!   non-slab/vmalloc memory

>Very good, and thank you!
>
>Now suppose that someone passes a pointer to call_rcu(), but then invokes =
kfree() on that same object before the grace period ends.
>Is the offending kfree() flagged?

If the CONFIG_DEBUG_OBJECTS_FREE is enabled, the debug_check_no_obj_freed()=
 will check wether the object is activated in kfree()
If is activated, also output callstack.

__debug_check_no_obj_freed()=20
{........
	switch (obj->state) {
	case ODEBUG_STATE_ACTIVE:
	 	descr =3D obj->descr;
		state =3D obj->state;
		_spin_unlock_irqrestore(&db->lock, flags);
		debug_print_object(obj, "free");
	}
.........
}

Thanks,
Zqiang

>
>							Thanx, Paul

> Thanks,
> Zqiang
>=20
>=20
>=20
> >							Thanx, Paul
> >
> > ---
> >  kernel/rcu/rcu.h | 13 +------------
> >  1 file changed, 1 insertion(+), 12 deletions(-)
> >=20
> > diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h index
> > 15b96f990774..0604ecd16627 100644
> > --- a/kernel/rcu/rcu.h
> > +++ b/kernel/rcu/rcu.h
> > @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsigned=
 long new, unsigned long old)
> >   */
> > =20
> >  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> > -# define STATE_RCU_HEAD_READY	0
> > -# define STATE_RCU_HEAD_QUEUED	1
> > =20
> >  extern const struct debug_obj_descr rcuhead_debug_descr;
> > =20
> >  static inline int debug_rcu_head_queue(struct rcu_head *head)  {
> > -	int r1;
> > -
> > -	r1 =3D debug_object_activate(head, &rcuhead_debug_descr);
> > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > -				  STATE_RCU_HEAD_READY,
> > -				  STATE_RCU_HEAD_QUEUED);
> > -	return r1;
> > +	return debug_object_activate(head, &rcuhead_debug_descr);
> >  }
> > =20
> >  static inline void debug_rcu_head_unqueue(struct rcu_head *head)  {
> > -	debug_object_active_state(head, &rcuhead_debug_descr,
> > -				  STATE_RCU_HEAD_QUEUED,
> > -				  STATE_RCU_HEAD_READY);
> >  	debug_object_deactivate(head, &rcuhead_debug_descr);  }
> >  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> > --
> > 2.25.1
> >=20
