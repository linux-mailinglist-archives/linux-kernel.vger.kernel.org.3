Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 651A754F22A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380312AbiFQHrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiFQHrW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:47:22 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BF4674F9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655452041; x=1686988041;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=L+VYME86cviSoNidQnO8E9CWO+9t/EWnGzwCjVVEJUU=;
  b=PQtb2Zwh0sVuxyF1+sGiIgg2mPlFDdqmtMl5lcSKEg8qb6mqWS5DuRr+
   zJ+hd+5NB7ZO2K//W7jRPkwyL4t2ltIxyJShLE1KDCP8R/2/LSQLyTTct
   RiMWKlJU6x0aWV3XUXbah1hZZw7nO8DHMi6Gr5Ckja5CeokA0Yo1obmfa
   RzizNzYmD2uYX92Ns9kTPhptReXkWzoatnukzHp+jp9LtsveidWRikxxR
   XZjngbPRFaMkzj5L+u+9RymaGyhg6DrbY+W3Dz9/D1bnKwew4BtF2DeOz
   6RG9mMeJtPVxxn91QjtzxKsVZLK7eIFUHCfjhc0ACC7tC0v12QSrU6lkH
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="279504526"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="279504526"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 00:47:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="763173160"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2022 00:47:21 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 17 Jun 2022 00:47:20 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 17 Jun 2022 00:47:20 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 17 Jun 2022 00:47:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F5mv8TfNmWixymOwFTqDw7Gx2/IMv4XKIUo8+Ht4Fbdj87JW1NXuoqdW/sHUJkWsI2IdIOaj6Vxx8kcvIcr1pLeiymBvn1eGhRMO3HLJccvknLkFnIrHDeZj4EI7emy5GfNGW5NygmwXthGRX0pbIDkY0XWhlu+MLmmBKMaBX6osd3WD8LK3ARn9Qy0r+c7ww5U+/UMs5HXw2V4FF5NaWthyhQ8PE5ndBgI4jNfcsaj6GtTOlmiH5NIWfbfpp79r0EIhkzkZ2WfcTAFnDpKCRiGDzMODMDEzVclV6j+4cIrP/ZUpxDkWt1WnLdMAXpesFM/WZB4XyhyYo1kZhEE1lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2lAx2xQND66RIkz89g888b0+os5IPW8AEKRQCfPTBw=;
 b=LcB2ugx2mwfc0BHJGnJ0q4HOWdGm0cIC6IxSL6C5TVZCL7Ej6tNvXFi1NvZtw8fbyV7Rz8yhzH9/rdj0r/a1PzDASqjwOF2f3eNk0gZIjLwhqJwBqoO01biC7b59001lk0T0BJQcvl4/4BKUh6Avhm9tePAQhikR08B0kdb/pe7onlaXZXr+ppYtS4TKVroBv2vtqRixq7eOGlA7QbKbX2U/oYjHvqHuoXHnSF/6CK3UdYFjEFtlHo2FtLpR2g7HiWCLidLqgokZyXlFiKqw8kBrlKj01Kwm5XGcbe4GvipjwhoMWJURVkDzFaJ+txaKBRYmgYGpVTTiS50Bw6X0BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM5PR11MB1771.namprd11.prod.outlook.com (2603:10b6:3:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.15; Fri, 17 Jun
 2022 07:47:18 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5353.016; Fri, 17 Jun 2022
 07:47:18 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Jiang, Dave" <dave.jiang@intel.com>, Vinod Koul <vkoul@kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v8 05/11] iommu/vt-d: Add SVA domain support
Thread-Topic: [PATCH v8 05/11] iommu/vt-d: Add SVA domain support
Thread-Index: AQHYehF5sV8oGvUOlUaa9QPToj6vZK1TSJUw
Date:   Fri, 17 Jun 2022 07:47:17 +0000
Message-ID: <BN9PR11MB5276F6765461543CD9D2D0D98CAF9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220607014942.3954894-1-baolu.lu@linux.intel.com>
 <20220607014942.3954894-6-baolu.lu@linux.intel.com>
In-Reply-To: <20220607014942.3954894-6-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ef4bb7f7-d267-422c-63ad-08da50359a6c
x-ms-traffictypediagnostic: DM5PR11MB1771:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM5PR11MB17713B2D97E266B6E11117878CAF9@DM5PR11MB1771.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cnEgRKrad42bAQWT/2hBWkG2rdLhRT3RgXqeIITLXgR9ITDx02+R3xVrkldATltyIuCQbEX6i1PxE6Qs4DEVl5ojlN+IEjCXm0YMGv+GC/DNIX7X0Lku75MoPWr6/G764s+OCkuDp3mQwO+llTEntp4+6akGpyYN/p7d2ShDcQNv0Tje7VfIz6++g601siSozkSpOtduIrfyKR73GEqFcvITKvlMPS3IxSFeuZvajdFGVmGCRVgSe959uZxMYoozP+5AB1MambQUBhLyuNn+xH/ZBWnAwwMtaXY5pM/gCaNVWqzwPp3DTU3TpHBTvCCe1/i9bJxVHQARruxewSXWzvQRrCcxmLIbL49oMwm4aRVljDDEzLOtZp0qxMJp785Ses/7ZO9B7wUNoF8kTM4eNFaHslrlgtjZ3S5NG8oCalRRQnEgwMCw2XjnFEr7sn00iNLQU/vm89DTFdkF7ljnMl/uTOtBMGH+Wmf0Mw/gj9OzbfnqPYj738KcTz3TjfofKOe2jCwPK52G4OJ/ftaRZuEUeRmh+liVw2sBPUqPibTJ6EBejFkOC5XOAWxZO7iyHs8AVOc4/M6TBh/Kgox6ExL2g9TzrwktSeGDkJSJcT+KsXYvO/4eD2T27vwgEeOfUI3MVetwpatNCYBXcSMHrlLE4hSnm5PMrkQMr+qJHh4rPtQAV4Brhe6Ef0Tb/ZIYfdoUZwCkL5Uno4Qhbz1gWFb+N+LrtmgXo57x0+6o72s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(26005)(5660300002)(2906002)(8936002)(86362001)(7416002)(9686003)(6506007)(7696005)(52536014)(4744005)(110136005)(316002)(54906003)(498600001)(71200400001)(38100700002)(122000001)(921005)(38070700005)(66446008)(82960400001)(76116006)(66946007)(66556008)(64756008)(186003)(8676002)(4326008)(66476007)(33656002)(55016003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KWc7aYyIgWUjvyTI/T6FYDo6y3xt3IDKapr5ntdqUf8IqpJpGZIYCKOzJuS1?=
 =?us-ascii?Q?mVPP2JMKEPII8yVAzJUmr5MAJSZnRZt4jVf1EM+rr3oRGvxvSj0Jh2Ok6SiC?=
 =?us-ascii?Q?PkJvzjCE26tBaq9S3FkLY8vwdLRlEVxKzy/yJRAdfHvEGvRQEMucd/Kj+24z?=
 =?us-ascii?Q?9pHY2glOhvrkS6LBKnwThGBXxiLDpV32nHg4OV16hybkFad4xdQ7sUTRSvFe?=
 =?us-ascii?Q?tfLLH29t1a6CiY4uoTCmWMY+ZmKYeivCFrNsweQ8zNLg+r5unOwuEURAEy/X?=
 =?us-ascii?Q?0SPMyCZBHgd3ApuqPgzorcWGeKPTmdNebtw0xjJ6BRHo9l5+ZtJmqNyTrCVd?=
 =?us-ascii?Q?HaiRpk3nqJhSaXjbP0YK2ZiqN+dIiaGbYbdcBFSwML9vpZe1xjZHHM+lKkgX?=
 =?us-ascii?Q?8naxI/LXSogrQjXDAB/9WD9W0dxaH39q7gZm5AK08mKb7z4qrSZf4c6IWfN7?=
 =?us-ascii?Q?O7rGd1eNIriv1bMFAbeF/Uli46isOreWuLpsQjdyhslGRL5lyacVpAUkV4sq?=
 =?us-ascii?Q?lWMDedTxF9HYXfasePHjVikdE1w1X7oh4jVuu0okSioieUDLrFp3aN9RtLFE?=
 =?us-ascii?Q?TkXY56pYtAtKvF5e5tpmnCACoDLgK+hcm70zilb/LZx0qBsoQ8FFURyy9tqe?=
 =?us-ascii?Q?CVDU5jT6uwHfQhGDpikestHkNy7qBxh8k9KmBjPBPZ9fzEb3/bqQLRR2slj6?=
 =?us-ascii?Q?kxqwHWAn9NShVtIvNKhOrKhVCbxwA4uyc0u/5wsEryzCmAVmf/udNNXK2e8g?=
 =?us-ascii?Q?HQmPuBavN2waBqLMB66Cfl28BVB9Lz5DdKZWBj926dODq0AKGUxb1x8gqFEl?=
 =?us-ascii?Q?JSzzJB3JckKCUAvkz/rYAxhllZ/afOEcYVeoT0iHNXkr/Pnd74LYQnfNSj9h?=
 =?us-ascii?Q?5jsVekCDjgDVC4PxmED4YPua6pIFG0cz0pURMPkS6fYOQTEy0sROB037gG7R?=
 =?us-ascii?Q?8YNY6shKBR8yQLAkKMcIE58zjRYEFd5FWNSwn02Ad+9clKo6JgQ42uQePdNw?=
 =?us-ascii?Q?7ret2GRt/LSuez6gc4zUodWXsSqg2/pQfTvGgX5gFTS2DXJds+fOfHJiCWf8?=
 =?us-ascii?Q?yK5ExMQfkYiang9P/OotAWPFABkiT6FRJdMzAiGFXY320wSMsmXso0fMIJRG?=
 =?us-ascii?Q?6ssWwIFu78YkZ4941LGUGBUXlxQqg5av8YkTib09Djh4+4tCQ9X/zE9M4KcF?=
 =?us-ascii?Q?YcyXYmDXtEh8VeXHCU1w8qCdfQOBUxLcFy8Akopp9sp6fLSc9Er1Un5a25L7?=
 =?us-ascii?Q?tjoAANLrviHEU4wlNsJyzZf6P5rge16lUThqK1pw71KTS8vVX6zq0fZTNNqo?=
 =?us-ascii?Q?Bqav3tlSsYV1rXSpbkFUqlDtkXJgTjA0HBKnEQWS+59e4H3wbg5CFTFYMERB?=
 =?us-ascii?Q?3AA6xxIZidNbvBB3RzAXvGcD3HERIibi+/e+jxEQoOTTFdECPWMyctrzOW2+?=
 =?us-ascii?Q?NupRVsZEBRU6T1OywiTtmxiaml6f7KaH3rt/VazqC+1nfA9a50XWIdiLHZj8?=
 =?us-ascii?Q?M6heub9qh/bMVVN4wRMj80IpVNpArvry1xEsxf0s8Ip5ACL1wxYeX62G1JMR?=
 =?us-ascii?Q?xR0dvu08qBwGFBUjj8Ovn8bQM7qoY1+sfNFn33q44RnAw9NGTHv92hkOepaN?=
 =?us-ascii?Q?JVNfXCnqcfbY30CiiIVSnVliRE38uD97KwLUhxU2NHzCvBx2+aXSZo6jBOEA?=
 =?us-ascii?Q?ikde0F1yxFWEy2Dyt7+/FRKlpWga4FNtTm9Y4Pp7o4T66/BhJtNgEqaVrYqX?=
 =?us-ascii?Q?A8pmrh/nSw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4bb7f7-d267-422c-63ad-08da50359a6c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 07:47:18.0317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 74gvjjyKkZXV1cx8QBa0gxdUJjLGy8Q0heisN4uQMf2WXd+ar9YNUBWDN8fpbsrX9NvWhEltcEvhf+mlu9MapQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1771
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Tuesday, June 7, 2022 9:50 AM
>=20
> +
> +static const struct iommu_domain_ops intel_svm_domain_ops =3D {
> +	.set_dev_pasid		=3D intel_svm_attach_dev_pasid,
> +	.block_dev_pasid	=3D intel_svm_detach_dev_pasid,
> +	.free			=3D intel_svm_domain_free,
> +};
> +

It's clearer to use set/block for intel callbacks.
