Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB9A506719
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 10:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350101AbiDSIrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 04:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344465AbiDSIrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 04:47:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3253E21251
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 01:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650357878; x=1681893878;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OF9ge3voF2KCA8NkQBT8L39ZT8ec8wR+vCdwE/a8QIo=;
  b=NLZI6jfyf+U5iilx13/U+ElQHf5pHQlrwLcJ9cTR4AyLs/xg7YTTGjfN
   KkReGktEKFyQtXxc1GH0ryH/GaQIgBpgvtknzGn1HGIM4IA68VOLz2KwW
   csxgv1Xw7vbtTelniOn7zV3BkjG+YFG6GnOUOtNb+p8JXBnxLD7T16rbJ
   gbgeBXz4Da0xeu3zj0KwvHjANvuRg6qdPr4IuD3XzgwCI218Fu4kc0jaf
   HtNpWXYXcS40TQzgOkwQD5q5LN8avnePLbrdKzw4TPj2eqR9wvfXW+aub
   9C09q8qKKgxaPH5tnNAFiRDSrN00vcxiQh823mTB4V0C4HrmgqEEbTaMn
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="288810524"
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="288810524"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 01:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,272,1643702400"; 
   d="scan'208";a="702112698"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 19 Apr 2022 01:44:37 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 19 Apr 2022 01:44:36 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 19 Apr 2022 01:44:36 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 19 Apr 2022 01:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hVsPPkr1ROqAbUktCtSW19fkJJ/U3Dl7x1LP6uj41B0+gGhD63pQ53UTgkbKCTNIYES40jq0NDK7Afzpc398vqASwt+/v4STmYzW/5zYr7EMqUjGiFZl9HU3v11OO5nOqJrJLTiZGggrGjXQ13PD5FgKl32DbKiF4FvaPii5V0TL5yzhOlsxEzztD4K+bev7dN2lTHuxaSPqVmRuFgOn7oDgehlOpgDU+WEjDgSlsy1HOEPVMFEijiM+4eM8aLQkEkmPqP2mG3ivoYpG2sEgbtsAB8hLuwbIFodDXFrwcm6b09BlwRo01perOy9bvb0nYxl2hvDNr9nnAUWWazRxOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qk7OpG2mMg2eHI4r8FSZmekZ01aybjLrK9JBd/4SRUw=;
 b=TZu+ogzDUU16mALq0d7vlozJGg2Y/HdVxWYMF0kS9NOuA6/VXG0/RNzQvylm6GBRdeTzWDfGagqAFZXhC/1vGihKJ5yia7dmcMimgY3OmQ56oZ/wsjFgojAdTFFb94IDrNV27h+abAkY3wPnUbcudvCaQDfNMgSrY4xhXnh0xDGV33jNYFwq+wuuMfQ8TXEqfOkQ6yC3fRyfr5vnTd357+vgp3SV0vGc4RvC+d8KuLHoB2Vq0PC5piLnS7bvBQzMQQhs+M1RV40m+i/igDYItA4UgKZjzecLvU3/DQTjtDEqIt+L1/HYM0V4EYiONt5Ya1axJFJwDO0eK83iELclzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10)
 by MN2PR11MB4678.namprd11.prod.outlook.com (2603:10b6:208:264::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 08:44:35 +0000
Received: from BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22]) by BN9PR11MB5483.namprd11.prod.outlook.com
 ([fe80::c076:6436:db8e:ee22%9]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 08:44:34 +0000
From:   "Zhang, Tianfei" <tianfei.zhang@intel.com>
To:     "Weight, Russell H" <russell.h.weight@intel.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "trix@redhat.com" <trix@redhat.com>,
        "lgoncalv@redhat.com" <lgoncalv@redhat.com>,
        "Xu, Yilun" <yilun.xu@intel.com>, "Wu, Hao" <hao.wu@intel.com>,
        "matthew.gerlach@linux.intel.com" <matthew.gerlach@linux.intel.com>,
        "Muddebihal, Basheer Ahmed" <basheer.ahmed.muddebihal@intel.com>
Subject: RE: [PATCH v3 0/8] Extend FW framework for user FW uploads
Thread-Topic: [PATCH v3 0/8] Extend FW framework for user FW uploads
Thread-Index: AQHYU3T/OFSmBz9UQkmzV0HnpdHlfqz26vNQ
Date:   Tue, 19 Apr 2022 08:44:34 +0000
Message-ID: <BN9PR11MB548384A9E1EE6B72FFEE5FFFE3F29@BN9PR11MB5483.namprd11.prod.outlook.com>
References: <20220418223753.639058-1-russell.h.weight@intel.com>
In-Reply-To: <20220418223753.639058-1-russell.h.weight@intel.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ea35909a-3f3d-417f-b263-08da21e0d492
x-ms-traffictypediagnostic: MN2PR11MB4678:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR11MB46781DCFD0E801E0907C3EC2E3F29@MN2PR11MB4678.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /XLB5f8BoHKo4QHJAQJefOEXb0AhU2xhoTDPL8fwFrMZSj3NU+s58OZFWObRP2QKvt/ZclM57f68oc00UrgyD6qHI+qMsH/w1vBzhY6Fvf2GvKJC791GGSiAKh0IRpjLEHF34iHOG0OnkegiGxUj3Ty6FCOCIuaCekPx+X9hIB9X7pSAnVjFgsCFMW+xsaEWt/4gPwbHSPKXlkTTXkvxY/JMuEiaxsLeGCQepmNAVoHEH7Z5SiIUc93XZwyiDSl83UFJHarErRVjrrOTCQrfLE3d/g2UbhKZr2wkdYCMY2QUnmZOv0pGI99UMmB40cNHt1iAeeG/5prQSzEldkiM6hU8sLez8zhlgBmoJfjZ7lYeoyupnEAAxcDi6KIXU5IrK8rwYz1actPIZd8QQvk7i5ugwb1NIj0qu02Yk1bFkeILTDBlXher3F6Mz2dllJeSbfZnlQn4/0Ay5uVVw1nwRcqhVcSpWzOV6zjGBCO9ZqBEGmhG4Xv3StF9gVvRgMF5D0Divr998o8M+1hHsrE2Jjw7V0pBukE2Md7xz3wYR9KFpWP5Dc38de87ZBmVKTg4bQqcDUJfwrEC6FyOQzYr1z43nZnNzG26+hDf8vYpOj44MAoK57NZswfPqkU5XjMMVKGZIa3Lfd6Vvi+HwFZn7QpTtCPGZ3E2ylWdxw0tbQYZOcfO6bhgCGrppWMLXawxCYhzywLO7aq+ClUcv2R6pg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5483.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(64756008)(66556008)(66476007)(66446008)(4326008)(66946007)(8936002)(33656002)(5660300002)(508600001)(52536014)(71200400001)(186003)(82960400001)(122000001)(86362001)(76116006)(2906002)(8676002)(110136005)(54906003)(316002)(55016003)(26005)(7696005)(38100700002)(6506007)(83380400001)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/AkYhpRS8klNtFHBqlJxQxrgtgBnn8eu4ypDeyAy8YlQhQdRM6tj0sWXxWrT?=
 =?us-ascii?Q?ODdEnPtJ+AwD0az7AJ5qquD5ItQNejQ/qqWGGyXcdINpvau/RsiAGiRUirtt?=
 =?us-ascii?Q?B8fUNwQvSg2nVLy95tkt9lJ+H6f69BXnjhit8GxQHL5WdERBYIT1Q2mDn2CB?=
 =?us-ascii?Q?aAJ3b+08F+EVCiLk995lM1Vh1xsFtcy18YsNUUr2vcJiRG68gwwYJ7lYg+uB?=
 =?us-ascii?Q?6hU2IgrhEQXcLef1/u5wu7CQerEabtVIQIwgP1bB1vFq8A9QXWQJscP3srFe?=
 =?us-ascii?Q?vKD4h3KMScLn6HXLeG9JMfK065Etn2w68pWgiLkBkygw0f2rwUjDU083ewD4?=
 =?us-ascii?Q?ON8R36Ij2zr+bBU2br5XnX0mDRaW4sc9APN0x2TlHq4NgEHJYcMepXDpmbG2?=
 =?us-ascii?Q?qfD4oiOJUELWm61/DqyhzIZw8dq3ErpbbU9BmLKrmwVLdED/C7P+vV1BwkQg?=
 =?us-ascii?Q?98konND8vjyqBHrUnNvZBKm+j0EaDl0B6Ek4lVBs13R/WoYpAz369Z+UyYG1?=
 =?us-ascii?Q?fcTnzcSwwia4KD193UjZMx30yheAcjQD5LLbIPi+7QFNqLvxnhOD+uh7owj0?=
 =?us-ascii?Q?ZObs+V/VX0jXRFw1qRQTvgt7kh4DAGvMGDZplfAj6a3PmJbLClGAShTg7x4A?=
 =?us-ascii?Q?02KnR7takLiPCZsxwHfIxCV15ilWtpjE3K1qvTRBwd6HzwF4ssdNhrUevTEw?=
 =?us-ascii?Q?ogJwhroW9PwYZ302Qf5JLvWoZPkXuVN1dTCiTg6ewlFCGg3TsfidXWMPfGYG?=
 =?us-ascii?Q?hhiZpUN8/jAfgTm0pT97WNPx+kmLPrO4Zrde3wcXrwJhO0ByEp4Sh4UD+qCK?=
 =?us-ascii?Q?+1+9dmw/5dK+JgVp+Tj/z7S7Olg3DqaYAinIS17+jurDZRSEGpc9ByipeHY/?=
 =?us-ascii?Q?IIgkZxA4s/oNUmrFEhD/lvob2ttQxU2hcIRN47fYOCfp3MCC4y4peY0PwG4N?=
 =?us-ascii?Q?766pcRQhNZS/kQYRGOkOPWi6K7PdMAe7V706VhbaGaHl3J6ikrIP4EocOAHX?=
 =?us-ascii?Q?KlIsGJU18o7xqye0qspq07xPx6XOSRCIDVSAjwIT/zI0M/mFfOWXVraId5+4?=
 =?us-ascii?Q?2zviLctRBsED+E5QgZ1QbztusSlI3Z4YXwxIpCeZUz4jEWhJFFDCJ6VtOF9M?=
 =?us-ascii?Q?t+vQVsVWdSr8sQepvojDLLZ+uo1YlLBHGqPQ1mnHCjd1UBchX+ZRIxrsDtXj?=
 =?us-ascii?Q?PToloCODQo81fZEKgMY47oZF/KmsVmReyuBPu8vzNkSrEAgHbY6WVH4/kcht?=
 =?us-ascii?Q?aGLs25pfF1pYnlqg80IkiM9i3Mn7MXbP+/b3Z5DO3h3GTdH3s3om2Y2rpuOc?=
 =?us-ascii?Q?nkE7MkiyzgBYxUlPwwTfyKEFo6ZSb6mo4NTDjXUQHzaGsCb651bWg1Rz378O?=
 =?us-ascii?Q?/K81Y8kOc9RFEXBHS4zFMfd4RTgb/JvGfc07GO/RAxr5az7+9R3zgaCM2bGT?=
 =?us-ascii?Q?kc951+JmIxh50+AYqfdbbp8IPhe9PpsWlcVEOhaoIteg3R/2zjQ3I2U55C9x?=
 =?us-ascii?Q?7nqg2gU1umjHhKKNFYjoEDwDO9VKIPOxFRDr8hKsjvXhGRms8Tomw3Us2Ag1?=
 =?us-ascii?Q?x7jUVX8rPvi9ujRbUyKLv3RptntlN+M9+3egER6faWNNkIOZ3eZdmccQIezV?=
 =?us-ascii?Q?PCiCfxPeDW81+XjTlMxiM3ZIAnAXNsPqkotpnsdYl3NbNstdy86LmLT1SjZ4?=
 =?us-ascii?Q?5eMEWeRSJDnrPr2a0PJDOZ4Y2f2t3Ch+qNGS0Dh0cU9D5DyeDx5KwhR0NO7t?=
 =?us-ascii?Q?cD7Fit3vtA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5483.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea35909a-3f3d-417f-b263-08da21e0d492
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 08:44:34.7558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZdWnI19mBtg9N1UoGA8/oSlWI0oOrgNiZVPUAd4JyAJXtfKUsqYwJEVXNXZFNuEtRat0r6t8eoDTS6NT2co5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4678
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



> -----Original Message-----
> From: Weight, Russell H <russell.h.weight@intel.com>
> Sent: Tuesday, April 19, 2022 6:38 AM
> To: mcgrof@kernel.org; rafael@kernel.org; linux-kernel@vger.kernel.org
> Cc: trix@redhat.com; lgoncalv@redhat.com; Xu, Yilun <yilun.xu@intel.com>;
> Wu, Hao <hao.wu@intel.com>; matthew.gerlach@linux.intel.com; Muddebihal,
> Basheer Ahmed <basheer.ahmed.muddebihal@intel.com>; Zhang, Tianfei
> <tianfei.zhang@intel.com>; Weight, Russell H <russell.h.weight@intel.com>
> Subject: [PATCH v3 0/8] Extend FW framework for user FW uploads
>=20
> Extend the firmware loader subsystem to support a persistent sysfs interf=
ace
> that userspace may use to initiate a firmware update. For example, FPGA b=
ased
> PCIe cards automatically load firmware and FPGA images from local FLASH w=
hen
> the card boots. The images in FLASH may be updated with new images that a=
re
> uploaded by the user.
>=20
> A device driver may call firmware_upload_register() to expose persistent
> "loading" and "data" sysfs files at /sys/class/firmare/<NAME>/*. These fi=
les are
> used in the same way as the fallback sysfs "loading" and "data"
> files. However, when 0 is written to "loading" to complete the write of f=
irmware
> data, the data is also transferred to the lower-level driver using pre-re=
gistered
> call-back functions. The data transfer is done in the context of a kernel=
 worker
> thread.
>=20
> Additional sysfs nodes are added in the same location as "loading" and "d=
ata" to
> monitor the transfer of the image data to the device using callback funct=
ions
> provided by the lower-level device driver and to allow the data transfer =
to be
> cancelled.
>=20
> Example usage:
>=20
> $ pwd
> /sys/class/firmware/secure-update.1
> $ ls
> cancel  device  loading  remaining_size  subsystem
> data    error   power    status          uevent
> $ echo 1 > loading
> $ cat /tmp/firmware.bin > data
> $ echo 0 > loading
> $ while :; do cat status; cat remaining_size ; sleep 3; done preparing
> 44590080
> <--snip-->
> transferring
> 44459008
> transferring
> 44311552
> <--snip-->
> transferring
> 173056
> <--snip-->
> programming
> 0
> <--snip-->
> idle
> 0
> ^C
> $ cat error
>=20
> The first two patches in this set make minor changes to enable the fw_pri=
v data
> structure and the sysfs interfaces to be used multiple times during the e=
xistence
> of the device driver instance. The third patch is mostly a reorganization=
 of
> existing code in preparation for sharing common code with the firmware-up=
load
> support. The fourth and fifth patches provide the code for user-initiated
> firmware uploads. The final 3 patches extend selftest support to test fir=
mware-
> upload functionality.
>=20
>=20
> Changelog v2 -> v3:
>   - Added Reviewed-by tag
>   - Added kdoc support for enum fw_upload_prog progress codes
>=20
> Changelog v1 -> v2:
>   - Rebased to 5.18-rc2.
>   - It was discovered that the new function in v1, fw_state_is_done(), is
>     equivalent to the existing fw_sysfs_done() function. Renamed
>     fw_sysfs_done() and fw_sysfs_loading() to fw_state_is_done() and
>     fw_state_is_loading() respectively, and placed them along side compan=
ion
>     functions in drivers/base/firmware_loader/firmware.h.
>   - Removed the "if !fw_sysfs_done(fw_priv))" condition in switch case 1 =
of
>     firmware_loading_store(). It is rendered unnecessary by other changes
>     to the function.
>   - Updated documentation Date and KernelVersion fields to July 2022
>     and 5.19.
>   - Unconditionally set fw_priv->is_paged_buf to true in
>     firmware_upload_register();
>=20
> Changelog RFC -> v1:
>   - Renamed files fw_sysfs.c and fw_sysfs.h to sysfs.c and sysfs.h
>   - Moved "MODULE_IMPORT_NS(FIRMWARE_LOADER_PRIVATE);" from sysfs.c
> to
>     sysfs.h to address an error identified by the kernel test robot
>     <lkp@intel.com>
>   - renamed fw_upload_register() and fw_upload_unregister() to
>     firmware_upload_register() and fw_upload_unregister().
>   - Moved ifdef'd section of code out of firmware_loading_store() in sysf=
s.c
>     into a new function, fw_upload_start(), in sysfs_upload.c.
>   - Changed #defines to enums for error codes and progress states
>   - Added additional kernel-doc supported symbols into the documentation.
>     Some rewording in documentation as well.
>   - Added module reference counting for the parent module in the
>     firmware_upload_register() and firmware_upload_unregister() functions
>     to fix problems found when testing with test_firmware module.
>   - Removed unnecessary module reference counting for THIS_MODULE.
>   - Added a new patch to modify the test_firmware module to support
>     testing of the firmware upload mechanism.
>   - Added a new patch to modify the test_firmware module to support
>     error injection for firmware upload.
>   - Added a new patch to extend the existing firmware selftests to cover
>     firmware upload.
>=20
> Russ Weight (8):
>   firmware_loader: Clear data and size in fw_free_paged_buf
>   firmware_loader: Check fw_state_is_done in loading_store
>   firmware_loader: Split sysfs support from fallback
>   firmware_loader: Add firmware-upload support
>   firmware_loader: Add sysfs nodes to monitor fw_upload
>   test_firmware: Add test support for firmware upload
>   test_firmware: Error injection for firmware upload
>   selftests: firmware: Add firmware upload selftests
>=20
>  .../ABI/testing/sysfs-class-firmware          |  77 ++++
>  .../driver-api/firmware/fw_upload.rst         | 126 +++++
>  Documentation/driver-api/firmware/index.rst   |   1 +
>  drivers/base/firmware_loader/Kconfig          |  18 +
>  drivers/base/firmware_loader/Makefile         |   2 +
>  drivers/base/firmware_loader/fallback.c       | 430 ------------------
>  drivers/base/firmware_loader/fallback.h       |  46 +-
>  drivers/base/firmware_loader/firmware.h       |  16 +
>  drivers/base/firmware_loader/main.c           |  18 +-
>  drivers/base/firmware_loader/sysfs.c          | 423 +++++++++++++++++
>  drivers/base/firmware_loader/sysfs.h          | 100 ++++
>  drivers/base/firmware_loader/sysfs_upload.c   | 397 ++++++++++++++++
>  drivers/base/firmware_loader/sysfs_upload.h   |  54 +++
>  include/linux/firmware.h                      |  82 ++++
>  lib/test_firmware.c                           | 378 +++++++++++++++
>  tools/testing/selftests/firmware/Makefile     |   2 +-
>  tools/testing/selftests/firmware/config       |   1 +
>  tools/testing/selftests/firmware/fw_lib.sh    |   7 +
>  .../selftests/firmware/fw_run_tests.sh        |   4 +
>  tools/testing/selftests/firmware/fw_upload.sh | 214 +++++++++
>  20 files changed, 1910 insertions(+), 486 deletions(-)  create mode 1006=
44
> Documentation/ABI/testing/sysfs-class-firmware
>  create mode 100644 Documentation/driver-api/firmware/fw_upload.rst
>  create mode 100644 drivers/base/firmware_loader/sysfs.c
>  create mode 100644 drivers/base/firmware_loader/sysfs.h
>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.c
>  create mode 100644 drivers/base/firmware_loader/sysfs_upload.h
>  create mode 100755 tools/testing/selftests/firmware/fw_upload.sh

Hi Russ,
I have tested and reviewed  this patchset, it looks good for me.

Reviewed-by: Tianfei zhang <tianfei.zhang@intel.com>
>=20
> --
> 2.25.1

