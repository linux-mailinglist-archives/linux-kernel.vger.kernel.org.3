Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D91DD562D71
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiGAIIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235142AbiGAIIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:08:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A631759247
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656662921; x=1688198921;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h+81p6lPRPCMTvzcdyY2BKTyAEgkysKqBsTo4EBahnM=;
  b=QKwhMxsFzoZvkShfi+YksLeaJOXzSfLevNkLpZyehm4GrnHE2T5MW/FP
   b1rX44q98m/6czGec2UevS22dr2LGEj4z79yKd9L6WLq85mwyb7FmU8UV
   +t2OWJ2KnNWD2RN08WxSi4LwnSvHqxwOZ+nJKymVbh9STBiLYyOW/5y7N
   vw/4o4jLAFfUjePl0h4GkC14qoQascOinKxeKRLFDL6dOBULY/Go7D9tE
   pXV+F/8a/mZYh2l6Kjg3Sa/98G+GUtwGOivPWh4aXyWM5EJHGFJkgHhDU
   rjTRpiOKLXEwg2X0zYGt2UrKzeqlsTaaloTjIxov+spSML0a48R5VIZtf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368902376"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="368902376"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 01:08:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="648247603"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga008.fm.intel.com with ESMTP; 01 Jul 2022 01:08:41 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Jul 2022 01:08:41 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Jul 2022 01:08:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Jul 2022 01:08:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LPJfV7vCXTwC1UHEBbpD5BUfulTToFc2hyquYIyUxtw62qeieeHg1wXFfRlEKtWNo6Svm9m+1+qZ1++ve2jJngmz63NDMCgJMNGWnyy3dLMY1k5sdvGP4AYddmg1zscLSuZlh4rY/bYWHzXKM3/i+0abFeoBuctoEyblzP8mWMxJyzTdE6sC5JzFy9KLJwZXFWmqtePUqX3Eiw4q/9ul1RQI+RVdJBoOYNSEu84jCLqL/FouMRsicd6i57QLnNNgsZjTjlfBBXLukNf5gx+SrYFD7Z6hldf5ilQqyG9YaCFJBw26UfAzkg1FA6ps1TDVk2kMt7nvTp/rc4TD2cjwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h+81p6lPRPCMTvzcdyY2BKTyAEgkysKqBsTo4EBahnM=;
 b=MCOKR3boPiTarpU7WZkO447L3EbmQzZy08pQn1IW+JptV1tLKvRoafX/r5d1WT3azy6okXC7XrMs1GLJzwDXdnwRrea8dt9uine8oYcamvC6Vm7Gg2UCFuLUCHZBViyqGOIFeWj91l8vLLvstCrxCKrA5VlwjwZp+O3Kn/lC15X4QsdgMNp1H6eMbPDiMQdgw5eWZoUDXj4FlKObz23u+zXE+ginuFiVNDVtxpObOhJGXbgSLBB8LNv5QKBtpN4yY/v9P4u8JJy0/riS4OjnXf1Cnv/bkoNqby/KF0sLPMmmuUgDgsUXmpRBSkIjvwcyA7j7d0m24elv8q2JA4TPlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SJ0PR11MB5816.namprd11.prod.outlook.com (2603:10b6:a03:427::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Fri, 1 Jul
 2022 08:08:38 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5395.015; Fri, 1 Jul 2022
 08:08:38 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     "Raj, Ashok" <ashok.raj@intel.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/11] iommu/vt-d: Fold __dmar_remove_one_dev_info()
 into its caller
Thread-Topic: [PATCH v3 09/11] iommu/vt-d: Fold __dmar_remove_one_dev_info()
 into its caller
Thread-Index: AQHYi40nYGtucVgHC0O4MBmlalMzSa1pLFkg
Date:   Fri, 1 Jul 2022 08:08:38 +0000
Message-ID: <BN9PR11MB5276A341975321A10A56FF978CBD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220629074725.2331441-1-baolu.lu@linux.intel.com>
 <20220629074725.2331441-10-baolu.lu@linux.intel.com>
In-Reply-To: <20220629074725.2331441-10-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3e756f9b-cabe-424f-95c4-08da5b38e74b
x-ms-traffictypediagnostic: SJ0PR11MB5816:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FnH3xhwIwvOyat3zQrOFXynEfYqiD1YTR5yehTaAA/rTGr4V5CpsPln0P2lE7qhnD37CGhkOt6qg6zAZwzppbY6tHFrkeg6PehqYwkDqSALTsD0aKHvKphqYsExv4u0K1LrecJ0//lCYbSI3/qWCroxbmqSDmjvyCcORSlL7rQjwcguaGJlxYGoLdTxWHUhlGwuyzu3GjmnAGOnR8EBp8fZQdHh+Hvtm1Z/HKd148H+1iNzCRbp00p9dd/KpqGJCQynpp6KJ8Jwtn5F+/zJ9Yl0r0VAUGo288wlRaNOiCpgx71kA9Qj7Z7pP86gyd6dSZksDxWuniRSj8AZyzgR278Bmb0763Qh+XPxOHw8DjYXKd81lh6/gnUO7Q1ab1UJqMtf2KDRdULJglYwyzfqYmY2rx9SvdZi1WE7NzIcpynPPnq+x1DODdsMs7TkQpa3b9ywaX+3nxEVNrZ4ZUljNuKgekkB1QQFeJbtDNUVz2GLdvc/LZlNz8zn8/oLWuBKFXD10av+TmqM63ZPaPIxpOqTjs2DIUJl4rHkCdece9rICGcml5ey5Vnx2Ra6JP8Ej2rWIAJxZZw96QPhGrKopU2CfHbzmttlVoGbO2AdjUPWyKjzKppuhbymQnDeWzYoQ3X+zbAu1if4P+4zbYmeRwlegapv5hTS6NZts1V73qtPsjg4C0y4a8KGk6XxCQFYpb4uXhw0m4tdcUC/+kIeAgyKj+shBEzJjbJ5KB2gs1btErzwGuXM6fGu7oAJ3E4N77cNkkIZldVqxgcYNe1xPPaXZHAMAPChPnHlb36Bm4WWQVm4zUCWzjh8ILenRgyHR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(396003)(366004)(376002)(136003)(39860400002)(38070700005)(38100700002)(7696005)(82960400001)(54906003)(66446008)(64756008)(66476007)(110136005)(122000001)(76116006)(66556008)(4326008)(316002)(66946007)(8676002)(2906002)(478600001)(33656002)(71200400001)(9686003)(186003)(41300700001)(52536014)(26005)(55016003)(86362001)(8936002)(83380400001)(4744005)(6506007)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QDwKdQSaLqIEIk38wAKNx1IZCc4BH+fy8mrW2US6J8Qr+oDF2P7g4cdcGBVT?=
 =?us-ascii?Q?SzIrVAaDSugcWbf1jDE1H/TuhHxQzXfjaQRPW2h/zUlifxhCJvmkRvGkF0KV?=
 =?us-ascii?Q?P0t9e+51qbtDwmCtUi3WKonU4krl45A0veuJzJ9o6xupTIxc6raQ6aY0z9P4?=
 =?us-ascii?Q?TZjR73IdtV3AxhWniDvAj8tsQjYYS9pqhTDymwqXClCUA9/g7/GxmKZBzaoV?=
 =?us-ascii?Q?0kmi1x0AUJLtO0+fnVifYT/q+vus9QPsFEJBGnSXs89wOQlMOHnT3OrWZFOA?=
 =?us-ascii?Q?hI3uPMEWOeTCYetpGiflyfa6OfrCaXMsb9OSzhGfeNxt+VJLgqK96b/d2M6j?=
 =?us-ascii?Q?9naO81wOLn9JWvCThDVPELNx7RuSsn81DtucgQRS251nmBwAoalnUweePoZt?=
 =?us-ascii?Q?s5Zys78o5mIgp/mpcrDJZKdi6rj0Z6iIWuFmLDYlmyHuRIL+GasMvGr7GoMO?=
 =?us-ascii?Q?Ctf8vaueIlhpqLC+lTEC+YbFPBE9vRgxBUsITYJyFdIYJfFn2NgMOma+PeAf?=
 =?us-ascii?Q?5qxJ2iG7uOU/gr96ahlbhru69xWUzN46IE4Xz0xWkZFLIFLSbQyPsDHcni38?=
 =?us-ascii?Q?L1RYxk+QZXbJuRCGxJ3zSdYhV9MANF9a+WJ7WyKjBcTsMliRSeTK4HzWbiET?=
 =?us-ascii?Q?Gvz2qk8bK5BxH2Z639dHoxlwRrjhjaxlvyyEQlnE6TNBdpVWieAvIytb/Bb3?=
 =?us-ascii?Q?2udXb9eIFwW0v1f7D00UZHNEUcfQTkVKq/4kt6LmlsIa0JtsP8fcBAXmPtxw?=
 =?us-ascii?Q?U0gXANv/cOKNlVIPPMSDKUYQzfT0JFmWET5EsKpm96IxLyTEfV8E8YG+5C/0?=
 =?us-ascii?Q?ECGsVQjBff+V7/uTdTslLN1mwhEB+zTQQfAoq+olIR5Xp+flUsUV4T5lTiY/?=
 =?us-ascii?Q?r+pHuda3ss8iLW9EYfH03UH/f1PYdEOkS5h/3rjqftXh6ygZgeZhdZj+ILZ0?=
 =?us-ascii?Q?PhMWkn7MjlR1OG9Y8Ch1fTo3e9p29XcVfQ9wcxata/Tr9RP8lUuHFwzkR2rP?=
 =?us-ascii?Q?dpUdyhhy2YT+bJTO2hRPdcIZXYNHUZFFAaifhq9cjOhWAKFcSncjk8dH5zXs?=
 =?us-ascii?Q?ELSJqerNBrkbtDSVGuDLyzZf5KQSlPh5yf5p13Wx6cn3R1/XWUJNi4xdrKUE?=
 =?us-ascii?Q?YSDl+l/Gs89cIHncg/ZiedmL7ToPSLIaeQIVJEouI4nTBXizZLsnsyrI0U+H?=
 =?us-ascii?Q?irtjjZPoj+bAKphEj/K2Ib+gKwKp89KNiQUrBzaBn+VW0QIZFthZ6pxMhaM/?=
 =?us-ascii?Q?VLocLw2X0pMFNioaT8xxK3lfiqs6pxnJkBp0lAozmo0ju5HUbmbisRHfGNZO?=
 =?us-ascii?Q?icVkO9RBVYQQg1ZpNsY31OPaPTo3D/0xzITKf2nZCUwc+WO6OBMBvi2/wn95?=
 =?us-ascii?Q?ZTsA464Bt0KEbHmWQlxxh+WuvIggMct7TUJqAO8/Kduvv7sqiTFJsL6d/UwI?=
 =?us-ascii?Q?TcqOwP/wF5w6OwIFgqdDrR/yVdsmOnRq9jcFTq78ZHnQIZ6S1peEFv6nt1JG?=
 =?us-ascii?Q?XYiwdOYXlpY37e8k2tK98qHymBTphHLBBhVq4UQNrK4ycfntgwzK9I6jJ4e8?=
 =?us-ascii?Q?CfsRhRpNRggyDUk38KCrpkOFL39obgDLUh6so+Nd?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e756f9b-cabe-424f-95c4-08da5b38e74b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2022 08:08:38.2820
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WI7zComk4cUG16tAkYh5dx6SgJPXeW7O8epugk2XGQt75/Cri54RvPQBzi1p/S9/jLseAGCKJF+aShcdnAts5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Wednesday, June 29, 2022 3:47 PM
>=20
> Fold __dmar_remove_one_dev_info() into dmar_remove_one_dev_info()
> which
> is its only caller. Make the spin lock critical range only cover the
> device list change code and remove some unnecessary checks.
>=20
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Kevin Tian <kevin.tian@intel.com>
