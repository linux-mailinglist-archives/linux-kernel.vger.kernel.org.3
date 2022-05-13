Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FDA05262E2
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380646AbiEMNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380656AbiEMNRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:17:41 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06FD51EEDA;
        Fri, 13 May 2022 06:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652447839; x=1683983839;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1tq8/tiZyJCZ+CFMmb8ZTRpsRrXHxuITJpqOqzQBXfA=;
  b=cjjqbAnvSBe9z1omrLimSJ3Ln64NdjkJR947SyMQSk70gAb7oBEwZTmW
   Kd6hAS9mZku6RtYdx2RxpMao1m5dDFRnXuEIRj+4L3dR9MDuHM2NcEGMs
   VJTu/mfgGPK1kpBDp62IMxoCY/cYP283ac/8eSUhtRtn2ikouv2mqAOhs
   raqVyPNkiUkAgCzvuO9FnoTMBxKZfGNmOJR3lStGHFich9Fig1CLv6aYP
   PV0esnAduEh6dkrKwUa2kOhrsyh87uOGpbQoRC4Y/lGePiTgLngGEZuab
   p7XVD4rAVHa0rV0W89lJ5R33shTMaGGzMxkDJ8Bi8NM7zbpADZjEVrSVF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="356728684"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="356728684"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:17:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="698482065"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 13 May 2022 06:17:18 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 13 May 2022 06:17:17 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 13 May 2022 06:17:17 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 13 May 2022 06:17:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQDo3wndOV30BeAbXr6nO3YN2iHqmsvmKor41xxBV/7X8jF3hqfMggvwxUdu80IMHCFObyHvXsCVvq++egnE4GirLNTEcg0Gi+NkQDdgHYRCUHm8HQVdibdKbd8KbCLqgv+sLtHOwTainMT6nOdxZdXjybBXgtqvtPkWzixIccXfgKh/xE/hpYwxmmYvj03HOGEidjNmboaFNJSfj14U3fnng5ZBCXUXyGB3HHQS8h/eiZNTIEw+d+HsS5OTmaw1wrEex/5pS2em4ZqdQmGog7yWfufS9hRD/lZTTUJvn5WYs9xo4Ue3lvrCGl6sRCdtYgwJwXX51X/+KruYxPjTtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=55VvVc92Zl2G5EdRg5G3/+IvcE2/zRUz3gRUf76PK+Q=;
 b=ayKzXnkavFroudINDlZlhV4AREIiAlTWryCrr+kzmcQBAAuVGF4lh/RsSj2myINU3iwjSj1aWFBNHdS/EoGCmce1LeJYFk38EnJDiyrHbBw8QLyk2hIfLNcSooz5wIeYkA7994NoT/yJV1OFTM0vUNAXbvwMlv/3uix3LUtl4K7ps933ITTBwblH14KnW0J2K4u8f8mbf6Ulw3bBItIfOusmMzM4z0VwvGGZ0/ocinDRfNMsb4viXGmt1B7T6LlJsJdta8bkts+HnQ5AEzue7JCCfrDUmn9DLud6HRlWNXsDJVi/3z0fqUnGp7lbs5SJM8IImH5H2K2NpgNZIw9Vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MWHPR11MB1247.namprd11.prod.outlook.com (2603:10b6:300:2a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 13:17:16 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%6]) with mapi id 15.20.5250.013; Fri, 13 May 2022
 13:17:16 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Thread-Topic: [PATCH] rcu: Direct boosting gp_tasks for strict grace periods
Thread-Index: AQHYZmJsqZZOz0NYwkqRvRtT9o+4C60b/q+AgAC5l6A=
Date:   Fri, 13 May 2022 13:17:16 +0000
Message-ID: <PH0PR11MB588012EC5E5DFD3FFDA49401DACA9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220513004256.465233-1-qiang1.zhang@intel.com>
 <20220513010651.GD1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220513010651.GD1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 2ba8e6af-37c6-4200-362d-08da34e2e682
x-ms-traffictypediagnostic: MWHPR11MB1247:EE_
x-microsoft-antispam-prvs: <MWHPR11MB12470814A5C92106B673029BDACA9@MWHPR11MB1247.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xj7c6sQ11DaZBcgX451mkB1sLyqtvwepNcLW14FfOKuZ6RDRcyo6EPlbVX+demqOY1l8CE+qAhoI8a6fnTrpdGlBOwmJi0nxPylCTeQ6YhscjjeckPtcTn+KxrUzaXrwrmrgqcXnAsYEm/fXoV+yHNP1COXVHsWZ5f1Ho03rx3ZAdueqP1Pnm1TNZu81wW2P/OQjQ18inGiU0wKAhz9YnjfCkQUsY75zduBY4M5+OsJCUDfLN2juvUHwaAupskgnxPWFbV/1/twFTi47Xsjh26cAdPqIBE4thy6eGB1GkUGUlA0TMSw/+BNcj7Os0Y9Ylpnaf2VCsjN7YGUjgLARia+sgK/IsUTs7mzB4GoB0bFhqyUshtrRjd0ZN3n8rb0Yem5/d6xnlngxliFRCBFhU0LXefl47aiK48rv9a08zFkefS3KmjGlAqP8LNSiXLgAmUhVAaoHMp1Ydf0jdZuWyKXAr7hEne/3ThLLCCZC3sN5YeCLf6B+aGiCyQESAS+FpPwy9+GhomewYa2kX/X90VeIlqZ+SHlot65uDb3IDLiRqeht3S4SOWYr5X8xugevN4Ee9BavUyeonFt1G0bLzl0si5I7GQgKWrHBTcZa0OB9F2c8VmDDVL++9jZm4+ZNLc9jsKu0T/kLn57+OgLmtRnejhPKwPA8S0iwn8rr03rR/BjnqfCPSw0p9zjaPL0rORrFBnxwnC3ArP4Ve4L9xw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(55016003)(66556008)(66946007)(76116006)(64756008)(8676002)(4326008)(8936002)(52536014)(5660300002)(66476007)(186003)(9686003)(6506007)(66446008)(7696005)(508600001)(26005)(71200400001)(33656002)(82960400001)(86362001)(122000001)(54906003)(38100700002)(38070700005)(83380400001)(316002)(6916009)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lm7O0h47nM3L6A8TmtuafZcmPTDECx6S2kTe3A4km8Mvhkg1f28uvmpWfEbg?=
 =?us-ascii?Q?Bh/E60qp/os5OTXH2pufrWrFjwx47+tPi5SFdwV6YQKVJ4Ku+DOiNOxPZ/+R?=
 =?us-ascii?Q?nqQOpEImNO0EYOVuRgPRvs6vN4NSgsmdfIZ8UmsNTu5u1LEoo9R+5OV/8Gzh?=
 =?us-ascii?Q?kDyeElJjhMzrK4pIeS+4c89I+jXO9Y8pfcrVRtvZI/4/HKgQJ115BfKsRX3Z?=
 =?us-ascii?Q?YD5dERX+8F6nqk2g2QFhXbx1xbi6vG9o9lsVJV+flKB+dVpyioDIG27a5Vjx?=
 =?us-ascii?Q?wrLQVOa/sSS/u3DNua1TofM/tYsEKe11acrQA/rwCIngNL3aryFMX9731cgr?=
 =?us-ascii?Q?MH9rb0nw+cyX1huWSIFsl2I1vnzVgANSeS01aWSwuiMB7zCVXbdN0Q9PQBOP?=
 =?us-ascii?Q?9f8xgt9FJFTOsJZ8xNKn01O54B6+oyeVbnb2mUpGopPjQKknTmvZRzUZEvUO?=
 =?us-ascii?Q?zGs6lVjXTSaGD6zFCGzDOwA39W2o46+5zVgaHOUPE0VQnXIB69fw5/hDsfrc?=
 =?us-ascii?Q?IIe4pIpwadbuSEBFY4eToIRs054JzEGaYfUmKKVaA2+AZB1Mupzic6vivf3n?=
 =?us-ascii?Q?caQylc/ANmTnaYq37QzCYpYr7gP7zf5CR4hW0mi0gltdcL7rfbGSZNa/d+B0?=
 =?us-ascii?Q?YFqx0ypFO0xhl0tnKJGjhiuI0HtVkSktwPvnEdVx65zg4SwYKVr9L+5oACWJ?=
 =?us-ascii?Q?mnUhJo17+6c9tFaiKNDyrh3aMHGKM5KGqrpQOCPoda3g48UzVbmcdxUpj/xW?=
 =?us-ascii?Q?pcIvsMQ8dOTEEL3nN9Yz3z6w3x5LwYt3YbJsdQcil3Xu1+A6qxtMb3N0555P?=
 =?us-ascii?Q?BBJ3YYnXBwXHw4U65BPS780yjN3jpfcpA84CrI6u5fN3+QA4LBYnmY8etKwW?=
 =?us-ascii?Q?lFo/KGBArVMD8/vu7/+h+uIdYxzd3l9hST0HaNHIhkCYzYTxsRy1HItcqSsH?=
 =?us-ascii?Q?PWJhD9sqSrXoxmueYQi1gc1HfvLDh2o75kMCELJZX11ON3u5tQ8ALYE6XWYw?=
 =?us-ascii?Q?Maq1lQX/t0aCKUd+r9ABnlf2jZyxY2/qre60gDkzIotc8RHZU4zU1hCP77/B?=
 =?us-ascii?Q?qfkvSEdIfaHWFW9l/YuFTrbkP3Om2J5tpzYicHNAFGba025Kb0ihQk/AfRvu?=
 =?us-ascii?Q?o1oSgERPtoTI1rI+Z15aP8HHTZSOIQ527u5Klcp57WnV3IiztFlWwJQ6ofrn?=
 =?us-ascii?Q?38MPlh/atFOHkroxDAioWhtE278h5jU6Jl63OrFJyOA/X3JW8ZQ9H02+gaz7?=
 =?us-ascii?Q?4bIvo8C8l3EQ0PVQoNTJFtSdI3sd/YyHY+SJjt1ovPm4waG/y08vyviZhDvL?=
 =?us-ascii?Q?i9BcdlcBV2eeddqY629BbsqGQyIsgqnNEPPlr2BVpT5eup0UqLlLPIutIAww?=
 =?us-ascii?Q?KCXHLL5aPvTqpN2PjoAQk9UswydXdRNW4bsDpWyui9hEZTEW+PD/rCY355eb?=
 =?us-ascii?Q?TmVUCScm+A3WGnfqV4CeIkHi+uDFXTjyCoizoDdEgCWc0fduViIJoZC7RUuu?=
 =?us-ascii?Q?RhgvKstnMdXFjSsZUVKRasNlIdtF4r2UKzSvruova7IDPu09VNR9UAYRMzu+?=
 =?us-ascii?Q?s0FVxtPuKRw1Z46elAtx8Kn5D0hhPO0VHywuDwrgSGv1pPx/Rk6KJEmIwhdx?=
 =?us-ascii?Q?sfrP6gIidMew5HwIYr128/pllJevR0LX9xoDT1TC3IpgsnHysV4AXh+qXook?=
 =?us-ascii?Q?V0S0S6Ct79KSbzMsCrTBgiotYllhnzHLpaXsvnW0lb8XN90jWUuezUocnBkI?=
 =?us-ascii?Q?4zspd83sIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ba8e6af-37c6-4200-362d-08da34e2e682
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2022 13:17:16.0268
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MTxSDz68jn4KlFhi3wFq3F1RIbVV+25pY5ewhQjS18NRGtEMGCQenxeNfTQpBdDurANfJaiOfyoUu3Jvp+z8tA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1247
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 13, 2022 at 08:42:55AM +0800, Zqiang wrote:
> If the CONFIG_RCU_STRICT_GRACE_PERIOD option is enabled, the normal=20
> grace period will be treated as expedited grace period, the gp_tasks=20
> that block current grace period needs to be boosted unconditionally,=20
> therefore this commit adds Kconfig check in rcu_initiate_boost().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>Good eyes!  I have queued this for further review and testing, thank you!
>
>What sorts of tests did you run on it?

Hi Paul

I didn't think of  suitable test method,
Can you provide me with a test method to test it, I will be happy to test.

Thanks,
Zqiang

>
>As usual, I could not resist the urge to wordsmith, so could you please ch=
eck the version shown below?
>
>							Thanx, Paul

------------------------------------------------------------------------

commit 079e0f894c5d887c678f94332c1fa7287abfd6bc
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Fri May 13 08:42:55 2022 +0800

    rcu: Immediately boost preempted readers for strict grace periods
   =20
    The intent of the CONFIG_RCU_STRICT_GRACE_PERIOD Konfig option is to
    cause normal grace periods to complete quickly in order to better catch
    errors resulting from improperly leaking pointers from RCU read-side
    critical sections.  However, kernels built with this option enabled sti=
ll
    wait for some hundreds of milliseconds before boosting RCU readers that
    have been preempted within their current critical section.  The value
    of this delay is set by the CONFIG_RCU_BOOST_DELAY Kconfig option,
    which defaults to 500 milliseconds.
   =20
    This commit therefore causes kernels build with strict grace periods
    to ignore CONFIG_RCU_BOOST_DELAY.  This causes rcu_initiate_boost()
    to start boosting immediately after all CPUs on a given leaf rcu_node
    structure have passed through their quiescent states.
   =20
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index 99cd=
e4c947699..b4ab952f04ea6 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1159,7 +1159,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, =
unsigned long flags)
 	    (rnp->gp_tasks !=3D NULL &&
 	     rnp->boost_tasks =3D=3D NULL &&
 	     rnp->qsmask =3D=3D 0 &&
-	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld))) {
+	     (!time_after(rnp->boost_time, jiffies) || rcu_state.cbovld ||
+	      IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD)))) {
 		if (rnp->exp_tasks =3D=3D NULL)
 			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
