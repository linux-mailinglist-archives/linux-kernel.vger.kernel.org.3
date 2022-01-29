Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19D6C4A2C0B
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:55:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238849AbiA2Fzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:55:43 -0500
Received: from mga04.intel.com ([192.55.52.120]:30937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238600AbiA2Fzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:55:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643435742; x=1674971742;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=In9sPrGbXyE+BrMmnVbEWcMIUtS8HzaQVL6opW+Cg5U=;
  b=FdooUfNvrA9yBCDasNsvHYTS2a7lGh9bY2YTiTDvjcntJ7TrzzcKHsCk
   z2JQvblwU616xAp0JSwtlVyb+Eo8gQRNH6hmaW/71yoG62U5cvEeIFuf/
   UNB6Q3pVEZu3rfCGqg0XDXaV/DWYYOZYgnwu6rWCMOlNqERMQKCnSA7tk
   BlTkBhdOFcJGP8IqCyBZW9ye2aA9eG4Vj+uJXwgYb86inAKH7BrGiZlhk
   wb9wPhLgtZ1pXMnDC+SM6r4gXQ97z0GmjxpVikNRq4Xh04PVeGdqtkwXr
   PjnUig1t7Ub19SwQnoi1B2q8Z1wWbAFLfvvWfG1POzi0P56efJhuVEzia
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10241"; a="246086916"
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="246086916"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 21:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,326,1635231600"; 
   d="scan'208";a="768095903"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga006.fm.intel.com with ESMTP; 28 Jan 2022 21:55:41 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 21:55:41 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 28 Jan 2022 21:55:40 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 28 Jan 2022 21:55:40 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 28 Jan 2022 21:55:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVgJ4wQw1BPRUgk/7JJvBjJboFCfkXbDL7wbLZY4yfUOJm8W8PknLcI3OSQ29+3F7y4O8RjOIK3AJtRPRUK8PH6oDuAljFFLcwmLY7Do/y3UP69ZM9qge+l2FWXa1AhdX6K8fb6R4IT3lGfjWziDmIWMcr6qF2QSTu+g/3/68f/OT3TFxupegwswYFxBhM17fDOGn4khJor9dT+XWDg381sQs6ihnPb1omSY2tnY3vBiT41HK+9c/24VZy+43S1LyBMGOB22gYChxVmgwIrL6VATeCqNUIcZXrAehVKWmRUCEzTKH+oISku1PVzCUNb0gae7neikUtIZaf1xPhcKaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXgjcrHUOeJWH3tpP36ww6D6FLPTH1l8G3fyhGPLmaY=;
 b=WBu3G2raaTSOiPmDaXBjUiLUt5VL48nFUgMiUR6lP1G8y1sJJmJklFd7Sa7UMinCLlIYl+cpIEHL1VpD/+m90uZQQfkfwOeJ8R2EW+QqUreErj297/vLL2U5TYCmaczFTv952WeDasMiPMjv9swMXtQaX2IpYvBp0962jIUx1QxHuRlCJXtNYpR6A0uZTKV6FfZYgkAdPje1Fa4ngi8Lt8pigNGOYjAI/cTnRdNOGeLcwVZ28U3fAv9pTcLRXAkwPaFFUc1UR2Pff3C+bQ7Nhb8oQ8TPqSBIVhd9D5k+tZjWWeEZrkq0svEmnzVJMtwOQQiwrFs47hqNQ8l4yNWJiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH0PR11MB5208.namprd11.prod.outlook.com (2603:10b6:510:3b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Sat, 29 Jan
 2022 05:55:34 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9%9]) with mapi id 15.20.4930.018; Sat, 29 Jan 2022
 05:55:34 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup
 waitqueue is not requried
Thread-Topic: [PATCH] rcu: When rcuog kthreads is in polling mode, wakeup
 waitqueue is not requried
Thread-Index: AQHYE/UODHHjhGvlP0WE4iSSid3cl6x5dzEAgAAFxeA=
Date:   Sat, 29 Jan 2022 05:55:34 +0000
Message-ID: <PH0PR11MB5880073B7080265117EE2868DA239@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220128031346.157961-1-qiang1.zhang@intel.com>
 <20220129051748.GP4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220129051748.GP4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: a6e707a0-47d6-4485-5f6a-08d9e2ebf742
x-ms-traffictypediagnostic: PH0PR11MB5208:EE_
x-microsoft-antispam-prvs: <PH0PR11MB5208156C60B23C396C066D3FDA239@PH0PR11MB5208.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: LZ6FwwftcsDTxplNvRfXZWjAD55BGs9eRNdtqE9NJVcBaWUYyVSSymBBgAkG3U0VHLNsnUc5GiD/cwWdTsnJk//ZHrrgOILfpszL2KSKrG+f8vfTcVxB6EMgpRAjvuJ90AImVhtKL/dPH/qBfj7sNkf2JQMIPXAd5a1lB29OgUjjGYw+kmPh3HX7jV6ztjtx2s7XHjHWxD2V+Dy8X7j/NWAtM/ZTCsN7nXCZAvZ4xRDjyl86mZt4BCDqeYKWBdIyKGg8lKQt5jcDzkb9HvjIGil2R2Cj2V7L3oskfbAVAZWlQkQqt5Ct0WNM0Rba+jVrxWAPP15boPOvqwNcNHudhe5RcRRK3fgCkkR6WL/1lE82h6vAP98rrEQ1PI7PWOpfCqYiPuS4xlEZkAhsSG+/POY2752PyyqvK5g4g/7f6NFdJP/CDtTKANxPw3jFXZRHCQTI49AJf6cIUTOg8bnDNqfZf3fTPtTOOIuVcajOpXjcmrvL1Nk/p7iA1X35AssoVaRhjhQAC8m5hXarYW0IBi9ZipOnxuRLkfU58rMTUyovyzAuXmzsoCyLddUxu9A0h8+WGy4htO+ZpSQq5sQzGc4FX/2NQZgp+DgVNIm2FPJl37P5PiM3g1CH9zWYUaYeAUZYTcezJBiNPPwxgby546cIasFdWxasv2NKwVx5Az/qBS590xICgSkTqlEDk2iVbH6fMe94hdaY6pZcftpElA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(8936002)(4326008)(71200400001)(86362001)(66446008)(66476007)(76116006)(66946007)(64756008)(66556008)(66574015)(6506007)(7696005)(316002)(52536014)(5660300002)(54906003)(38070700005)(6916009)(508600001)(122000001)(55016003)(9686003)(33656002)(82960400001)(38100700002)(83380400001)(2906002)(26005)(186003)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?NOJbvCurBrSS3kwv7sGmtuQiNI+aGEy+Aq/j+oPylCf2XQKkFJwUbbkfPzd6?=
 =?us-ascii?Q?eEabM28+9WduEUGmM9RUx4Zn0grTelm04SOgOTGxvO/LfFi7mF9gVr8h/KS0?=
 =?us-ascii?Q?Ci9O6cxBK9RmVigEYy6DX/gHbHA1KZCmmyAODeqITv6kgVr5W17vkRYXse/J?=
 =?us-ascii?Q?vKqXEYnzCLgXlgbIGHBt4EYVCxGwxotZXIx4nkBh0eERtwSlu+BOG4I10DLg?=
 =?us-ascii?Q?E/ENYOlMyLWg2L5Wdf6jhT4hLLK82SCxlNuuKTx2g6+D8h4CzQPiVNUwWBQm?=
 =?us-ascii?Q?CtNv8EiFHzOz5j/lzOVey/W7RxTTOyXi3jUUJBex6i3IXlwaKW2kv78gVhzI?=
 =?us-ascii?Q?NRgxSMABCfFCB1qgLxbi596VL6ymOPPb+sOfrMneGRr1u5MCOWV6t4UKtdLa?=
 =?us-ascii?Q?JvsU38bkRexBhVGs3m+C4TLvO3s2uEEAdEPt78nga02cESF0nbkkZUXWvlvD?=
 =?us-ascii?Q?gIsjVDZrMpub+XI6inHXMRGmIsUQDlHZiD7agzbSTDiKI3yaiihiwRUqyjL0?=
 =?us-ascii?Q?DaM98jzsFUlLLs6aqlsHPYfn0VZ0mX3t0WMybEprdRGWBCqfuYd+4IDDej2n?=
 =?us-ascii?Q?7VSfyxtS9voLYO1VDEf6BbgQEuPaITJdzEe3Jb+Fvp3pXqtO+wcsxCU3bYEL?=
 =?us-ascii?Q?Eu+d2BD7HgbVaRCxd5F2K0lreZ6/wF15Utg5q5RXv8uZqXkwxQUEVPyc56RM?=
 =?us-ascii?Q?ibdws7vD7rraSSO89CSU1JOPXKOMH3l0eqgJAGZUnCiB2nZEFAeJPax8yQM5?=
 =?us-ascii?Q?sm7awJ/YMEOHDjL3XbP0TQQG6R+hHilKLn4m2LB5/G6fVKgEP56di67RCM4K?=
 =?us-ascii?Q?NAITcV0fedrl03DktdDgOS0BVnVKpViyBi+B/3JjEPkJ4R7O1a59iIW3RVwV?=
 =?us-ascii?Q?9KGzr7QC69hAfgDV2rnucTsrqBlcJYG+Dle6k1PyFRCnL7hVwZ+9BmolraFI?=
 =?us-ascii?Q?U+CuFYHFp4/vgOMJ10cB/nnYQuB5+EU7QxRpdl6ZdWG8TwUw/ZoATXD3511q?=
 =?us-ascii?Q?cqS2J6z5J7quBwjk9ZDzyvdZleFsy9cws+p4RSZdrZXGT1FXAzwgrolOJHPw?=
 =?us-ascii?Q?G7ec7HVqFDtzfFypHSmpdxs9Nw/K6RMQr3hyQqXldBK29ZgEhIK65QpNICIl?=
 =?us-ascii?Q?umE9LtcO52TG5jXrxu2oxWkD3d5ZMm5hHrP2pEqwB6iebZOtTvLakrm7FwTg?=
 =?us-ascii?Q?mewYH7133zE6r97zjIA+reZDwG9bqTXsA8KMGC9srkpugY2SK/jD2LGaJ9Rd?=
 =?us-ascii?Q?bRRwDvUUbXDrr4TKigYPE7P+0xUG5BWDRsRzQgGVtFF4AvlaKXDUj2BxVuo3?=
 =?us-ascii?Q?lUw4mwpuG+NCFrX1ntgQDVxzhsn5vXW56EmUCKaDMxh9jgz8joCqIfDkJUKm?=
 =?us-ascii?Q?PktkNaDOQJt2SKPfD0qu35nRVgdDVp8vTojo+mPm5QEK7BM2idVRvYB6ugVk?=
 =?us-ascii?Q?2Mrh/szPFQi50JMX6ysVs4qld3Mk4opOnK0x2P0iR0FD4hMj7AbBGGsCMjqZ?=
 =?us-ascii?Q?5QJ4t/+JCMOft1iN5MZfNcIlomSq0Xe3Skll97XRjs4Cb+j6drQIXIRG8JOK?=
 =?us-ascii?Q?PZefGWWtuNVkqUM1BlVMMlVcAuqEFdMCmBlBxQT0QtjOfMoZ7C4iTKHmKI1t?=
 =?us-ascii?Q?jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6e707a0-47d6-4485-5f6a-08d9e2ebf742
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2022 05:55:34.2056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 88X/5J7VqmEpBR0d1LQXYHTLCZo/ovbsIGKaXz3i6giU/GxNhkhPbrTqHnlz8z9yy1sUvZOxwXZRiWr/roXt2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5208
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Jan 28, 2022 at 11:13:46AM +0800, Zqiang wrote:
> When grace period cleanup, the rcuog kthreads that waiting in sq=20
> waitqueue will be awakened, however if the 'rcu_nocb_poll' is set, the=20
> sq waitqueue always empty, so if 'rcu_nocb_poll' is set, return=20
> directly.

>This does decrease grace-period-cleanup overhead in kernels built with CON=
FIG_RCU_NOCB_CPU=3Dy and booted with the rcu_nocb_poll kernel boot paramete=
r set.  On the other hand, it increases grace-period-cleanup overhead in ke=
rnels built with CONFIG_RCU_NOCB_CPU=3Dy but booted without the rcu_nocb_po=
ll kernel boot parameter set.
>
>Last I checked, more kernels were booted without the rcu_nocb_poll kernel =
boot parameter set.  If this is still the case, this patch would slow thing=
s down for most systems.
>
>Or are there now lots of systems booted with rcu_nocb_poll?

Hi Paul
I found that some of our customers configured rcu_nocb_poll startup paramet=
ers under Preempt-RT kernel.
at each grace period cleanup, we'll all wakeup sq waitqueue, however when r=
cuog kthreads is in polling mode,=20
the wakeup operation doesn't required, because the sq waitqueue always empt=
y.

Thanks,
Zqiang

>
>							Thanx, Paul

> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_nocb.h | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index=20
> 636d0546a4e9..9e106c590e56 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -201,6 +201,8 @@ static void rcu_lockdep_assert_cblist_protected(struc=
t rcu_data *rdp)
>   */
>  static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq)  {
> +	if (rcu_nocb_poll)
> +		return;
>  	swake_up_all(sq);
>  }
> =20
> --
> 2.25.1
>=20
