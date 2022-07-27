Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D61582360
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 11:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbiG0Jl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 05:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiG0JlZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 05:41:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C43402C1;
        Wed, 27 Jul 2022 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658914884; x=1690450884;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o2vgAj57qEmV+/mHCqyUM1gTDYf7PPsrTkxumVZ6d3Y=;
  b=Iw1ArU+taOoNiqs2K0S68uqZYYuHvV40X4Gur6hNs8DvtQ660IGXeYL1
   luyfzH3xTJWH23wqF6MwJPNPjSjMYVrKw90Ask6CsUbdI2Fth2vvap6nz
   BuGBChz3O2Nf2zWD/yPG3YT5+siwtwFzx7r0UB0/OEsC/foqjY4qVOwCr
   1fTzakxUqUO7FjaDgCxRY1zpC3KLIUAQyjY9/GcpcC6P3g1hsegWXj9w9
   Vd83TLXQ8MM34INZvIKkw11pOThEclapqCtQ6gXwzKfihVhbY0E6HouBY
   XcAnWGUzu918iVEyyzpe+A5jVccTGjUh3tu//ZHycluJ5C+qJC4etjOws
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="285738399"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="285738399"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 02:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="628310280"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2022 02:41:14 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 02:41:13 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 02:41:13 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 02:41:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 02:41:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGegzkT5/FugkiIAfcSqz663agpyu2luTE05UmvT758DDDG01/R6YP0IoorRR/l8TS3GSokaP8ScEB3ObZcr50nHxoq3nAe646hFcg3osr6ZRu17X2mKzkjuSe1LnGqd4p43pDjzQSr6ZF3lWVojR7JpRkM8EmGGnMz0jAzhOV5r28Cwc0lqTuWPEFCzFfe2Va+VhrNI3QaPNPk04j/Sh2uNew4T9SMo05lWu6/jcKFJcityMKGelVIbSHHzaAGoXNF1ZoDgv56fl+U4xwPmpOtFguBo1oYK0kPuEBxN41JCzO6ZWdJNJ6TIx5sEULTW0Ir/tMhEa846AcqyLSuv7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J5iSmN6fSgFLWnm8Xatcizp5I/MEIXIQRwRq5fhsjg8=;
 b=WoAZfp+c9kHoOjWvSe/PuTaueE4WnrF5MojoMEg6kcs0unUqNxVX/FnlLPi6wOb2mxlgA1bkVz4HagU54M5/1ijw7oSBI8CW0fWpCwbPzpwnI5mc88ioey3Udubcu7KH1vIa/4wOvagOXzZht0y7niFdhujpB35qEO+onjZhAwra3hR2mxjlo1EjVykk8ptngT0FO8Ksq63gRNH2tFvHXX40rNWgUwWjsMoOPfZokNYHKhNFD2/+Hkj7FcyrTHr7WTaYaVEWVHAbtnfrh4PkAQlckuPGEoegY2qMwEV49ECSEfMWqdDQFIfmZuiFBTKS53Vk9Hjyjs6hzj6KUBnhag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 SN6PR11MB2815.namprd11.prod.outlook.com (2603:10b6:805:62::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.23; Wed, 27 Jul 2022 09:41:05 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521%7]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 09:41:05 +0000
From:   "Cao, Bingbu" <bingbu.cao@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Tu, ShawnX" <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL
 fwnode
Thread-Topic: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL
 fwnode
Thread-Index: AQHYoOgT3BbsvDQ0lEurL8cW5qr1wa2R9Ryw
Date:   Wed, 27 Jul 2022 09:41:05 +0000
Message-ID: <DM8PR11MB56539D93300DE7709DB0F0DF99979@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220726120556.2881-4-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.500.17
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68306f78-758a-4ff3-29ca-08da6fb42061
x-ms-traffictypediagnostic: SN6PR11MB2815:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NOpt902H7XwW8ifpPD9mdy2jRR+zdgdXdFp9rQmFDYf3bw0OukrdI9QRuxVbMLpcNhbM7cbIS4P9O06AQKfxDg7IcPs+ocOHO5X7hk64IvtADX4go/08wjpGqhC3fXtdwL2fEsRXq0a5AmxjzASuSOuJ09La6zjVhjqScQ4kvCCZysK9DTa6RpJR1luJ0ctiJ3VFUpA3EG3El70BSqvzesYwIGMuQcqnNStuYwEPPtBjxLpwwgM6tRAzCA7llPlhJjIjtCIsHeEta2Xy4yXQYAtWpt9aQdAUHH62KOGeD8rIciyzqLIvZTJprUxDqazXp8fSJPrxZLSnHU5daLEFyLQS4QkLcuet6tKf2SiNSGR9aKW6dcY/c0hdnu3RKhRmR5bjEHfohPP4n8EAaWpa/qnj0Mk2mQol5J555QFlwOB5nB7nlcJGwblifvnmdFmI649OoM3ihVAk3n64Wf4Luv4ezmW9imLdEJD6anxxKXkqyeHvX+MWY1+9rXxrZC3ZwShpOaZRlxfwYEBAJgY3w2vao4rvN/iXs6qW9w6myVqUrfWlxlSjRcxsUMPM0hIHnWc5mxg424aTmYObke99J6DvNGHmeIuaiRCqHiwo0BFyeid/ULsg38s2z6SG8ipjyuR5DW/fFEfxdDpYyIilwNyCvAccmiSe7dlzOpem2oKenSyMfYz6fDe5pP1EuQryCcMRX1QR61B00bTEPjOLuu+IPWAMpJ2gdFc4oFXKnnYRA3cWi1lPjKOzjQdbKE+VuT/yH83UJEc17+0M0bJK6ZhU5qLMwkYZfG0pFxUZUEsL0OHm+Iz1R/K9xWeFzg3g
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39860400002)(366004)(8676002)(4326008)(76116006)(64756008)(66946007)(66556008)(66446008)(82960400001)(52536014)(55016003)(5660300002)(122000001)(38070700005)(66476007)(8936002)(2906002)(38100700002)(478600001)(316002)(41300700001)(71200400001)(186003)(7696005)(33656002)(86362001)(6506007)(110136005)(54906003)(83380400001)(9686003)(53546011)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P/Jjm1URVSqs2a8XzQ9SCC2WYABQ6aKXZJ52sXwoAtD/Vm7HSHO21SW0GRtx?=
 =?us-ascii?Q?KiLO98yd/Z4rL9vMNDlMVD00p7iCH4Sb+AC/xXTts+gvVnL6no0hxOsPo/kL?=
 =?us-ascii?Q?Q/LfzGt1nVU2ngxp2fTyNgmpWs9qEvEgaPRVbK6hAFrDjd4x2QtfP937dIry?=
 =?us-ascii?Q?s/r4HNatOlMlG0g69AI9FBoXInx9ZiIQZ9r/jOTRLAT//5q8KsdZvm8poGp9?=
 =?us-ascii?Q?VJVBYgGQfAz1Qqx8KUUpigsQCjCJ3ggC1rb+vnfFvA8M9VJ+R4M/crO+iHOb?=
 =?us-ascii?Q?uHRbpa2JqLav7adv0w6icR72ojuBzqZWNrHYLEe7PqzpsUc/p/SC1e1VUycN?=
 =?us-ascii?Q?IjPokfJGHZ2zinEmMObgOvTp1b0zL7WwtXYPyOEUiDUZ6C+3YNCFRRbDOt0h?=
 =?us-ascii?Q?8K4l7BhZOVVCrRPdq1C9OKPKqdWi4GcOtexyisK4bG+0/VeWztKVHnAXkUjt?=
 =?us-ascii?Q?Wzyw2IxzJYjqk2705qqlFSxfJxN7aye0P9VKzsWPnOlGjonN2F2nlajdV76g?=
 =?us-ascii?Q?NokgA8MUWK0QOfTgOKbDZ6nXxeSG2I3D7CVQhP1qA3DPF9v4H+tkKT1ytWXp?=
 =?us-ascii?Q?5eZBP7OdTHgLEXXxxLcen9AIZWW3c4QuafJ3DS3sNeEkzXMUS/XihVPHJTSb?=
 =?us-ascii?Q?4dyjFvpu/4zC3NBJgaR52dCeeJ7s5cOUwgm7Bqe50LaQ9/JPZTLPTizAvtlk?=
 =?us-ascii?Q?KaEKzX68+SJ6O0TzRdCTrhT3URwp26Ve7ag+l+kGtaRa5QqcUZhC95tpU1Oi?=
 =?us-ascii?Q?USGgyXxm7Szm3lRPgy80Q2cjp/BsAmEJlMXnp+J1RYPEC6DuvnlJBGqmVtqp?=
 =?us-ascii?Q?xxGtIbSSi5CPuV4lsSMCmGPnywvohpH6AWCNN+LiLKTOBGk4oDGxUTImUp1Q?=
 =?us-ascii?Q?AbriiWZHQ28C/hm5mJkI3jPYmGMokK6LvRd1E7rXS/smMXoxRS6iRPiP9Z96?=
 =?us-ascii?Q?Sae6ObkBoNWs+bJZcCrXS7/tkDG6RXWdRB1QebBGNpOx7hUBN7Bp3kUTOdVJ?=
 =?us-ascii?Q?kFzSE+qzl+b31HWx452X8kycWZcIu3ZSu7gdZCWQPoSjnTG3csRQVM74a4o0?=
 =?us-ascii?Q?EvdYGOSFcM71lD/qL2HMSatMjTNp8EKh+OyK6qpxYPyzLnmqMhstDQc69TNO?=
 =?us-ascii?Q?Ds60KTTZbtl+JSeedA2qIXYzjLI27xEMj8tpQ7L6t8WWxsLEow4raw7FlDAU?=
 =?us-ascii?Q?H3VAt8G722csinqW8x+9U1Qv8vxTbeVT4Ob1crj5hgVLjLFz/v02T1z7GNr5?=
 =?us-ascii?Q?utiBtcSkFBq6VeSCPdGuwiMkXTZyHPrCDpLLlau6hmeVAoH3YWFNHR15zyKL?=
 =?us-ascii?Q?RiWpk4DsSNJv2yaKGk489RYGgDoGvzyHLzca74Znb3I/INUeNucJzmTxkyKI?=
 =?us-ascii?Q?l3TRjPc1JUAtrN4ODyLrSlGJpO5lHmeTonGv6UczA2SwYc6Sq5ZD0oGt5neN?=
 =?us-ascii?Q?BDUaNgtZlTL8ZfjbsP12Q0YMCFfX/Y7aCx28dFACULFYgotd+jdZArpFkO7P?=
 =?us-ascii?Q?gI3Wstp7yS+YdWFSFeBBxvHXVVvOkXWEeByasFxEkrbV173vtt89404SBHSz?=
 =?us-ascii?Q?8Yfg9vFM4Zx80fC1SisuU7oPuE5eUNGzMmO9dmCy?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68306f78-758a-4ff3-29ca-08da6fb42061
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 09:41:05.3756
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPlHbhDriZib8wX/l+aeq5vK6XCPqnfz2LyFviHbWk1IGq6xizXd/QLxdybmn+ImkK0cniG967v/9OESlyny7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2815
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andy

Thanks for your patch.

Reviewed-by: Bingbu Cao <bingbu.cao@intel.com>

________________________
BRs, =20
Bingbu Cao=20

> -----Original Message-----
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Sent: Tuesday, July 26, 2022 8:06 PM
> To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>; linux-
> media@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: Qiu, Tian Shu <tian.shu.qiu@intel.com>; Tu, ShawnX
> <shawnx.tu@intel.com>; Cao, Bingbu <bingbu.cao@intel.com>; Mauro Carvalho
> Chehab <mchehab@kernel.org>
> Subject: [PATCH v1 4/8] media: ov2740: Remove duplicate check for NULL
> fwnode
>=20
> fwnode API does proper checks and returns correct codes, no need to repea=
t
> it in the caller.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/ov2740.c | 3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c inde=
x
> 9420258c6073..07fe8fda274e 100644
> --- a/drivers/media/i2c/ov2740.c
> +++ b/drivers/media/i2c/ov2740.c
> @@ -1009,9 +1009,6 @@ static int ov2740_check_hwcfg(struct device *dev)
>  	int ret;
>  	unsigned int i, j;
>=20
> -	if (!fwnode)
> -		return -ENXIO;
> -
>  	ret =3D fwnode_property_read_u32(fwnode, "clock-frequency", &mclk);
>  	if (ret)
>  		return ret;
> --
> 2.35.1

