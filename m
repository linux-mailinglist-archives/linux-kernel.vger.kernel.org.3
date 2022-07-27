Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D4B5823B6
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbiG0KCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbiG0KBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:01:37 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCE048E80;
        Wed, 27 Jul 2022 03:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658916083; x=1690452083;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IrIQM2v2X7wElwf3s21db/pDoQl+GvGkVvuX70nhbOc=;
  b=lcAGbcS+ToJceBqWLPy2u62rMrwbLlXssKwEMDBVDpdwFqz7HI6ptxJh
   qKBC5rE5abschW0tJhJRi4p1Q8PxHs7stsCJ3+NXkQOUG6II/9daEb2lf
   U/IhcD4gU7GqED/bB8oKnkQQwEPlep+YbN81B4KQnKBQA+eUfgkb02jmg
   sXILqI6zOul2acpzTVwYuGRcuOUsGwMcXvueRSY0h1ChjbqEIubzfhXw4
   JihhrME/7QQiPhfC52O+nbeMZ2d/zbT11i7bxhjUrGIrfKKSePGqHIFIq
   OHCfhMiV7T2GN7IkaX7kYjM2Y8+2wfPGDTsUl+5/TONFwlgpFzt1t2GpD
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="285741657"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="285741657"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 03:01:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="659128499"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga008.fm.intel.com with ESMTP; 27 Jul 2022 03:01:23 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 03:01:23 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 03:01:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Wed, 27 Jul 2022 03:01:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mFVTAqtv8k7fh6ZWRSQ6IILw4iSUEIyDNyR3uoW+cVa/4rx5b3ABHKH8kpKzAa+d0SLOeYYtX2kerLXVzqOhvOIDsTbWLQhItV/yEwvbTmEuRxVE5y3rFh2qBwp7TR/aHW2aN1i3ASkXhVT+ZpFydg+FG3dERZfOUy5Du/ICR2htV8V37Pi8VOj5ET7dJw/NQ8FRREnus6nWMJW9hHv7QGUwQJqTwNIZ6C5vq6aW0nThAGklikJ15vThc4+Ay+npweNNyGCHs/U3bOxdx5bm7IA6vBpT1aOWGHoRbANjwLQxGVDGl8EeRby/BXTEBle9OjTGPSQJHZdzpfK+wtZKww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=np8XvSRtO+u3YNlbGRGzREFMld8rtQ9vCPjbXTI1JXE=;
 b=n2cMIkChcq63bXQ6w97Cq+WQFLwX6fmy19RHVaWyU/FQPLg705leAJej/W5SFRbmVgeB2kHPs4eNbhOEgimN4tLcHhkCYsbjOO8upd41ixYyYxffdJv3Ny92ZT1G4kgnW4Gh3gBFlqQ83EucZ1+XmMQfpMn6woiyvS2AUKFNlz5jayYLXTT3OU5QYygOJQpkkmzLI7do808Fv+r62XGcaaQDNFpTyzWlKoMQYxoqvrMTLlm0UFFaIMQmb6hXY8ww6EwewUb+Pj6JqEi97xV0MypAYoRCkx5cZnHGxA1oBvkbmdNJIrQcHRyAyjbvRLuc37ATomFvx79tT6gSz2ytDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM8PR11MB5653.namprd11.prod.outlook.com (2603:10b6:8:25::8) by
 PH8PR11MB6732.namprd11.prod.outlook.com (2603:10b6:510:1c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Wed, 27 Jul
 2022 10:01:19 +0000
Received: from DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521]) by DM8PR11MB5653.namprd11.prod.outlook.com
 ([fe80::9983:65c7:ae4c:d521%7]) with mapi id 15.20.5482.006; Wed, 27 Jul 2022
 10:01:19 +0000
From:   "Cao, Bingbu" <bingbu.cao@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Qiu, Tian Shu" <tian.shu.qiu@intel.com>,
        "Tu, ShawnX" <shawnx.tu@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: RE: [PATCH v1 7/8] media: ov2740: Add missed \n to the end of the
 messages
Thread-Topic: [PATCH v1 7/8] media: ov2740: Add missed \n to the end of the
 messages
Thread-Index: AQHYoOgTCK3PndfoK02A1T2sPMnCeq2R/cfw
Date:   Wed, 27 Jul 2022 10:01:19 +0000
Message-ID: <DM8PR11MB56539B719C80F54BC0EBF8C299979@DM8PR11MB5653.namprd11.prod.outlook.com>
References: <20220726120556.2881-1-andriy.shevchenko@linux.intel.com>
 <20220726120556.2881-7-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220726120556.2881-7-andriy.shevchenko@linux.intel.com>
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
x-ms-office365-filtering-correlation-id: df0d5e39-3381-440d-ead6-08da6fb6f438
x-ms-traffictypediagnostic: PH8PR11MB6732:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3/uMICZW8R9su+7QdPHFVIQH/V+s+efBh8uf+vSuetmeE6Feu85GelNpAldkrdINHb558bF4F5POuOXfJVn7C+C5kd45yEOdvL5gSuxn7VZo8p1oBEf5SAoRkks5n+/etRvIReF85kHyjBxoUSfmu6hTdCwEMeGWKjWDuTrfZXVTU3witCZOhken+vLqG7ZS4czU9ZeLan9Yu5DXoZBKvBpSFYP7DpZV/Zezp5QBGfvRcXfK9uduT2qR9/Cl9Z0yrXF+Z0iaG8Xjr84zrsCwY84HAGORYsuDuKINyl4W/W0Lo9xTSnPUvTrwtBvL27H1VAP7xoMPGnFitNtur4ahwEdLwHc7JPS+Oi4XjhBbbUUEns/ZNB5+osr7jXnjatc7jdaWDYRg6a9rF8C1lAe1Wi0hOEOeBCP8Uofa39H4l6mx/1ycg2qvUCWZZKIglXjT2xpMEMmvraWr5FDhJNNTaqGbbgSnR1GQ9GbZzA9IaW4j+OQgDtRdlsHY9vO60OUjvFQjhp4zmtAq22HE43zwgw9/O1dp21GevRQisre1rndLjyeLWGQFR58/tnkltVyvAmU44Joiqs21yY/Hvs0+gQQZWah5GX6+llgIOcSTRzSr3fwdIi/E5vY/inGVtxZys2j7sebf9PoIRxFMLns7S8wUy43Jy4KVlLD+KTu6P6p/JjQHJ1oUEmsOxFpsqsv1ETplaCez9EnTAiuszeiQGrsONTk4zpffbytNhqZEcrGSTHUJvTtwvbWNAMc5xrpk8tvab3gfvlq7zoH36tCOgOclCPoiY1rSdcN3nqrqLmoq+zHfsPwGbwfdaYFsuad4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5653.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(39860400002)(346002)(396003)(366004)(376002)(64756008)(7696005)(66556008)(33656002)(26005)(76116006)(66476007)(66946007)(6506007)(83380400001)(41300700001)(53546011)(54906003)(316002)(4326008)(8676002)(9686003)(86362001)(38070700005)(186003)(110136005)(122000001)(5660300002)(55016003)(8936002)(15650500001)(38100700002)(71200400001)(2906002)(478600001)(82960400001)(66446008)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?sp7PdJsoe8XCyjXh0iEurXqIXZcOw9VCVRX9Uu09yLU3LyREoNDXQtmNdFLg?=
 =?us-ascii?Q?SWTNZVqUeqoIa36B+KmuhDibSj8aGbnTWgbjj8hqw1wFVgBiLtb+aZ83Wn+K?=
 =?us-ascii?Q?26ljkIMtM8iKdFdA/FKV41ilEMOIFO6D4Hc5gRbWsSwEWmJ0O9RCFDYfD9wr?=
 =?us-ascii?Q?2R+DNrIb/eTKlzjmKPbJZdZPG3AuwMY7K2NZSrBVOhEoWjPE6SO/1mPGAJ+M?=
 =?us-ascii?Q?E+WADYQhWZPGma2H4PxJCLHn/WcEOP0LpOsV1ScEBNhfOQpJPXOWw/suOziT?=
 =?us-ascii?Q?eBDiT4GNa+oGboDRkvovHTQYOKYplRvibwyz2MtiuSkJ3vMuBofRIxglMlM2?=
 =?us-ascii?Q?EgQpwaZhLo6IyJpkQGdagVYnJMhkfGb6c/xXdUKvdQTsxr4b2a92NC5IGbcd?=
 =?us-ascii?Q?Wyf5YVzHrwjrEk70s4GlKC+zI52amibLfVbLx3YfadkVJEfw7eIRmIsT3SbS?=
 =?us-ascii?Q?68W2bYbth3YP0VwvDu8aiCTcK8kUaGd8AXYENl4+HSXofM7s3MH2Dh8soDpQ?=
 =?us-ascii?Q?axT1yzLftTQ3p8zmZYfYc0TLh8gsrOOyMWA7sQbhDMifNr644YCpdDvU2L2g?=
 =?us-ascii?Q?Q3+gaQpouB0h5CFUGCQZwBnpTc9cQqD7BXo/owmLcXe9LAJpq2QmR3ppGCKG?=
 =?us-ascii?Q?6dKu85gJRpkxJGgEtSobIiRrHfmKiHX2zGfZ9+cx3IpAxmu2rhps8Fu15/oD?=
 =?us-ascii?Q?KEG+GUDqvSrmAptnGfvy42S7nRg9mDjgd65hBsIOyzRVy31qx5etAXxu9Dwo?=
 =?us-ascii?Q?VeFoANQzrT53nsjEa+TAgzfdFFrIgumi5dlmNk4gVUlhCOX6B0w/gvS9C4ZF?=
 =?us-ascii?Q?E203o0DMfdq3n72HKEy/aOWdZMEYgAa8VxZJPuXZdTR/423OF7QbktDlVWt0?=
 =?us-ascii?Q?VZaj9oBFgmSUtne2PuPEj6api2JOwAZVR1qpx/c6gcvONEi6eObISgDJ/5m2?=
 =?us-ascii?Q?P9rADhDHUWIRyxyIiT4MGZ38D/kVnaGBX+ozm6XEz+mDemdal24yLeFu9VnA?=
 =?us-ascii?Q?cl2G2HiTC2wiRBZ3M2yGyvVtpn4piRO8SxEjLS7R7ZcrhCpAabdzaJ7UqsIs?=
 =?us-ascii?Q?o2nlDnpuChn6vol80gS2uB5FZLMEH364+STz4e2KNNA+v2Mx0++ldl49wjXF?=
 =?us-ascii?Q?3NUaLHFwLM6e+id96ckwRQgWovT1ULYpjbhCM/q/Rf5Kv7sZi7qM8A3uk5+N?=
 =?us-ascii?Q?dr5tRTGknLTq7djlTxdRrZd/OF6kz37JGal4Q4ZOYRhdfPm+btISEDHHtP6O?=
 =?us-ascii?Q?RKwNj2OFBKhhdlpZBQ83RnRNWkqt24DXtjX5xsOxT2TTRzxUJx6z//1pyzOC?=
 =?us-ascii?Q?CpjbYC2mj3HOl37ZFS6jOpMD3cMCKFurV37tecSGxWOD7MDFJeWMFimhy328?=
 =?us-ascii?Q?M5G1+U7XNJav+SZ4mJPnDQWJfpNlhuYgoB5Tw3DVa6KZWROa8O6SYSHHw/op?=
 =?us-ascii?Q?53SAmzXcIsOYCTtmg6eapR1FAyqeRqwJHGAnx8jfojyDEbIorTZkHqQ1WVOl?=
 =?us-ascii?Q?r021B1i8oN3CpuiGaW+878hzX6w841TfUIdOYzkau+jwZposmBJhEzB+b5jh?=
 =?us-ascii?Q?bUVuoVq3S8XpIUgJOuUgJRRF1TNhNEv+3EZehosQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5653.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df0d5e39-3381-440d-ead6-08da6fb6f438
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 10:01:19.7822
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZJga+yhlhT8zZE5WYjW7eQI9GbkLjZftn3gyL4thvg1y3Jp+IcPN1cKLjjm7a7Kh4u3BrtB9ShRr9n1Yhj9jgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6732
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
> Subject: [PATCH v1 7/8] media: ov2740: Add missed \n to the end of the
> messages
>=20
> Add missed \n to the end of the messages.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/media/i2c/ov2740.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20
> diff --git a/drivers/media/i2c/ov2740.c b/drivers/media/i2c/ov2740.c inde=
x
> 7271e3d011c9..c4c511f90257 100644
> --- a/drivers/media/i2c/ov2740.c
> +++ b/drivers/media/i2c/ov2740.c
> @@ -451,7 +451,7 @@ static int ov2740_write_reg_list(struct ov2740 *ov274=
0,
>  				       r_list->regs[i].val);
>  		if (ret) {
>  			dev_err_ratelimited(&client->dev,
> -					    "write reg 0x%4.4x return err =3D %d",
> +					    "write reg 0x%4.4x return err =3D %d\n",
>  					    r_list->regs[i].address, ret);
>  			return ret;
>  		}
> @@ -474,7 +474,7 @@ static int ov2740_identify_module(struct ov2740
> *ov2740)
>  		return ret;
>=20
>  	if (val !=3D OV2740_CHIP_ID) {
> -		dev_err(&client->dev, "chip id mismatch: %x!=3D%x",
> +		dev_err(&client->dev, "chip id mismatch: %x !=3D %x\n",
>  			OV2740_CHIP_ID, val);
>  		return -ENXIO;
>  	}
> @@ -772,14 +772,14 @@ static int ov2740_start_streaming(struct ov2740
> *ov2740)
>  	reg_list =3D &link_freq_configs[link_freq_index].reg_list;
>  	ret =3D ov2740_write_reg_list(ov2740, reg_list);
>  	if (ret) {
> -		dev_err(&client->dev, "failed to set plls");
> +		dev_err(&client->dev, "failed to set plls\n");
>  		return ret;
>  	}
>=20
>  	reg_list =3D &ov2740->cur_mode->reg_list;
>  	ret =3D ov2740_write_reg_list(ov2740, reg_list);
>  	if (ret) {
> -		dev_err(&client->dev, "failed to set mode");
> +		dev_err(&client->dev, "failed to set mode\n");
>  		return ret;
>  	}
>=20
> @@ -790,7 +790,7 @@ static int ov2740_start_streaming(struct ov2740
> *ov2740)
>  	ret =3D ov2740_write_reg(ov2740, OV2740_REG_MODE_SELECT, 1,
>  			       OV2740_MODE_STREAMING);
>  	if (ret)
> -		dev_err(&client->dev, "failed to start streaming");
> +		dev_err(&client->dev, "failed to start streaming\n");
>=20
>  	return ret;
>  }
> @@ -801,7 +801,7 @@ static void ov2740_stop_streaming(struct ov2740
> *ov2740)
>=20
>  	if (ov2740_write_reg(ov2740, OV2740_REG_MODE_SELECT, 1,
>  			     OV2740_MODE_STANDBY))
> -		dev_err(&client->dev, "failed to stop streaming");
> +		dev_err(&client->dev, "failed to stop streaming\n");
>  }
>=20
>  static int ov2740_set_stream(struct v4l2_subdev *sd, int enable)
> --
> 2.35.1

