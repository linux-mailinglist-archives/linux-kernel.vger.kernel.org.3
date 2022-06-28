Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232CA55CDB1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbiF1Iu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 04:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236098AbiF1IuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 04:50:25 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA272F009
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 01:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656406224; x=1687942224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9a8cvSo4n/0WU6ain9aqV8Jx76a/gpcjYmGTQ+nnRS4=;
  b=QRlbqoRCJtbeZJ7aOuWbmVHQGWAfKGxjb4hb1Vs/u/Oe9z8Jg4tWY6c5
   cbp8e672JDeTlTrNf+hNuvayzwnBK1N9lhoZsLh+D5w/NXBf0axaKq+Km
   I1IkqpHYOmjWWIc6BchOYMySUK/fr+musNyLZHgIi/Sf8P+d5f7guYvVe
   UYkljN7Gt2FolvqLJ5sN2QpiiiEjlyU0ewx+hF5pki7CzAPNP3GCdU1AG
   NGEW8aFgwBS4Hn+Zz7xWWQ/1LOVL6rTzZPDem/upn05k2JMcJlh9HJEMC
   kzrS4dIEnl54sP+RqjsYB3K8o90UEUpA0fZVxDFjkCpQ3qvEhoMDbfGPe
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="343367908"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="343367908"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 01:50:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="540418970"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga003.jf.intel.com with ESMTP; 28 Jun 2022 01:50:19 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 01:50:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 01:50:18 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 01:50:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cvw/a9vPiTijGwCnT0UCh47EQV+2VN6txiOAtu5CtFqNDYEYZiV5rcMjvoUX9lTZLkrHoTBYx9WMQQVLjo07jJI2CBqLMUy/muwK3Mj3Xg515TdCjJXoR0qRNBLYhRYBVaQnsTmnRH1IIwRbB+WXbQgWortlZ9V9jTF/7KRZYcOmMlHFUxwqtPRXwFL5qLZDanOm1YRJSKCvWXigXCGmF3P1l0XKcoDpL58LchanGCG7NhcJ8ztsL+6EIwCorwEQb/h1sda78h/JYpB6/AOgSSCcbTU5ZtQ5+N1F5O1WwBSOyl0ix0QtOyS8l5XI6YWp4FmXKSYdq6kdwbimyft7Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9a8cvSo4n/0WU6ain9aqV8Jx76a/gpcjYmGTQ+nnRS4=;
 b=ls+CLZrixrB/0zsN7kKhQruCeQ0blxEZoi4D9adGKOV56ifhMHNbZwqJUwJJ03TJSkbIR5XY+OOVsQXRoo35yzYRPViCNHshbPzU0sZdu50FiQMaqWlx2T3WatsvVTVrJGjzaIaoWa7Ag4eBXMnzW5BoGGAi8Dk8BX4S9ZFUzRVVBqRBo5Mko0RYwnyhWzXUkREO6neEZUa0fiFHUblrbfKFufMENXwwGT1uqtK3XtgnXx6iBtYH8wqo7nn2gs6yxekQSvrYiT+BM+6G3aq2WAaexz3RLDJdMosLYZypu/OITvqfLC0Xj3mjdj8n+mh8I+D2QnLA0dvuNJEDU00W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CH0PR11MB5377.namprd11.prod.outlook.com (2603:10b6:610:b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 08:50:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Tue, 28 Jun 2022
 08:50:17 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
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
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Subject: RE: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Topic: [PATCH v9 04/11] iommu: Add sva iommu_domain support
Thread-Index: AQHYhX35xSpIBtEUJk2c4sDKhBGbeq1i8Q6wgAFnYgCAADJ2MA==
Date:   Tue, 28 Jun 2022 08:50:16 +0000
Message-ID: <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
In-Reply-To: <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.500.17
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9317c51a-c74e-45e4-5389-08da58e3394d
x-ms-traffictypediagnostic: CH0PR11MB5377:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tIIiBP0Wx3wRwtkztYwt5xYcWzpVedqq6iKdbQj/TEIn3k6jUgLg7HuYOQpJrUPg5+tuU6JV5V/FdYP0rtN1mk4qxsr3Viv52cBxJxXjbsA388LtbNsJQ7woYhgjfkGlmj/6nyHxA/Lqg25lEFEWuLIBCNFqFoz2hTQVpmhKGFba6O7g2Aeez63p4A9np2jgaHaXrAT+YvbFHCp1nICeTAELYmOqIHlEoRmUY70p3S0nPb+k3OX3oqLk9VMiotu5EJbkCD+z1Q8z/oE8ytO9Z9XieHMU+Fu/kxMUM4du2ff8XoJhzIO9oycoJ00x0Dzkrq1/rJRfMV4BrSRF7hsNTxAA8bIN/eKIbfv5IKo/YbXW/RdnwlRUGyz1WrsRnbPsjI3aWPrPPHlZWAtJkuE8bLdLGuk4v1V+KD2aqKxryL6Fbpl9Rupey2wBYYI4lz2yfBw67XKLoFXeROJTorD9+yTFzW04cMBNZw7yQgxknWI7M+raRX9cfdeTscr80jEKX+zIFSZpPyeMuwzOzDCcDk54tkGmVBT4NM9YsEcZPV8Dcwt8aN0cc8PLNhkSQhOlSN8WW3GD6L/Ez+Sxv/8mxNKzwWWJN9EmeoUyQNjwxhlffCUXQt6fBfwTIGp2xBajCBpIjRQL+xcKG9Ks3qA12Te8/iZ6U5TGp4NusWO2PrsQXDMn0Qk6hudiOuUmUCzEyi7+p681y0+oiA4D1o4wvKxELbHZnOOAtpFWu/49Bc7E2xKv7RRFbVOq2bCetahn5TIIduxQi6VhBiYp/Wu9dGxjihEWrCD49NpvD8f8tHPNpLU2zIvRhz4YnGYjdL0f0s/q3XPgkUNPO0JvleFWEurHSy/780XJQ70qzBEre3ZoDfoNy0FgYe3YOxoP7L0wJzSrlYDGPlTuA/1TtQdo5A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(396003)(346002)(39860400002)(110136005)(76116006)(66556008)(83380400001)(52536014)(921005)(33656002)(122000001)(82960400001)(66946007)(54906003)(316002)(186003)(71200400001)(4326008)(64756008)(55016003)(66446008)(8676002)(38100700002)(5660300002)(66476007)(478600001)(2906002)(8936002)(7696005)(26005)(38070700005)(9686003)(6506007)(86362001)(41300700001)(7416002)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a0ZUSlFjclRGbWRnTkZxa04ybDhJajR4N1RSOURoUGtJMjZoNlZHQUpQeTdZ?=
 =?utf-8?B?d3l2WTlGZk1IM2t3WGswL3N0aGgyR2JZWjlFU29CYzg3VXREOUNPSldwVFZX?=
 =?utf-8?B?ZEdHdXpHaFoxNFZZclVyczZSaDRFUURKQXRETEVJU0c1SlNnSWN4ZzZQQk9m?=
 =?utf-8?B?RHhXQm9DdFhFaDBaNjNjY3dPWFFFUlQ2RTJSZmlYTCtoYUdOeEVhb2hGMFNJ?=
 =?utf-8?B?RFMwVTFQTjE4OTZZcC9abWI5SlZnQWp0YTc4T1JtL01hODBheXQreU85dVRO?=
 =?utf-8?B?eVh3SWZ6dVJ3YUtvdFY1d1o3dk9hc0FqTFdlZ3VNNnVpL0ZsazgydUt0N1dQ?=
 =?utf-8?B?bHlGcm4yY2w3YVNiQTVRdDEreFJhcmhpZG1MZ0hweTRwQWN4clpVQ1VtTTRz?=
 =?utf-8?B?cUhDL0tGTFVTN3NGWVJSMS9PVlVxRzFhZSt3Nzd6ZjdRV1NoZHNCZGJqVzZK?=
 =?utf-8?B?VUpCNXd1UjZOUWNOR0x5VzRyWldYWk5EVEhQUVNNd2pHVVRGYlgrWU9CWm5k?=
 =?utf-8?B?ZFJwWFMzU2NSOVFTc1k1QU5iWUloWEI4UlRxTXlCbXozM296RnpiUDB6cXRz?=
 =?utf-8?B?VUdaR05VeEZMVWJOY1kyTnhpM0ZoUk9rQUhLZkUzaHFFU0VDRXlXU1pTd21R?=
 =?utf-8?B?QUtjWTZZUGNEVXEraEgzWGNuN0V6SmE5bkdsTVFYbnhuK2FSZnpIZnJ4SW1H?=
 =?utf-8?B?L1NJQTJORTdFRXJVRmpuQ3ZrSTlrcFBadTFLc2JTOUhhbXFrZmswNlJGK1dh?=
 =?utf-8?B?NzQ1UUMxOXMyKzFKVkJNRUVNZzc0WXJmRElodEw0YlZ0VkRzTnhWN0JFQlps?=
 =?utf-8?B?SVdSVHpSVlpkdUVGc29uZU1NY2ZUOG1QUVQyekRWTi9SZ3RQa0g2WGd4THhL?=
 =?utf-8?B?NjNqWkxCRS9PNGNpRkFnRnJlMnltb3ZFT1pIT1U5ZzZFVldJeWlVT1ZxY3M5?=
 =?utf-8?B?bWxTemR0eGJ0L3pWMy9Za1JKQXRtZmZIbHhYeFpCa0V0QllNMXNqSTlycnli?=
 =?utf-8?B?blg0SVFjbDJDUXVDR2cvRUtpWjVoclBvMCtrdmdmUlM0OHhvYVpjZWw0S25Q?=
 =?utf-8?B?NWlUcFFQc2YrNjRlTWlDWXM4TkVxeDNKS1czMlZVSGkxRnJHd0dxbTFSWjVi?=
 =?utf-8?B?S2Z1emRpcUpyTEZVNGw4MTN0c3AwY1VOTi9PamFKb3dNZTRxelN4VGpsWEpJ?=
 =?utf-8?B?NlY3R0hUdXZsd0dhRjZqQmV3d3R4SXJUK1RnSVJUVEMvN2lrNlpoYWFuS2RK?=
 =?utf-8?B?TURreUNDWEpSQ3NYZXB0MS9kK1NMc2ptWlhyK3pkam1ZUjl3K0tmN2dyNEh0?=
 =?utf-8?B?aHBVMG03N05UU3VneU5nYnhQbzBFTGRYMUhSUkZSZGhsZEpUd2RXV25DSS9N?=
 =?utf-8?B?MUxjVk1lQ283VTM2TFExWk1CUWZzMHlYSERoM0xGZzFxaGQ5anFlWUtwRjRj?=
 =?utf-8?B?N1U0SUtUc1Z5dWNINlc5alBHVk9QSHE0Q0ppVVZYOHNqcGE5cU9Ua2plM2RR?=
 =?utf-8?B?KzJGVXRWQnRLcDl6YXFrMm9jKzhrTGY0T0YrMElUMTNxN0JJRnp3TERobmJx?=
 =?utf-8?B?dFVyMGR3NDd2MUxESkJyNnpOT3J6OEtxMkpHNVVseFRVSVhMcHdmbHlZVnd2?=
 =?utf-8?B?dFQreVhsNnhubHZDOU9TclhhWWxUMGpCS0VvOGJzdDdUV1d3TmRUR3Fnc1hq?=
 =?utf-8?B?S3BYRW5ScXF3UFVLa0hkS003QkxpWW5SNE5uWUFmWHFjeVE0TTFiY2ZidXhR?=
 =?utf-8?B?anFkMHhralNwRVJsczcxK1RpazE4TlVIM1ZTQ2JCb3dzSDhCNThZRHRBMkQ3?=
 =?utf-8?B?YXlpQTZDK29sQjdSbzJqRVdjS00rMzFHVDQzVmY1eWNreDl1Z2g2Q1JOM3hk?=
 =?utf-8?B?cml6TGZXRXZydWFlT3FuREl4NVVmYUV1MG8wRGhWTDNHYUtxVUd3Wm1uTDN6?=
 =?utf-8?B?LzlDa0ZZY3VtK256anpWMGFWZXovclNSa0svT29zbkhZb1JmdkdvREtDbHNm?=
 =?utf-8?B?M1RJUm9zbUcwcjFIT2FFZzdYQml6aVRYcmhMUTl3YWJzNFRDamFJWXovdDBa?=
 =?utf-8?B?OVZBTlRqblBQQXhVdlZCRGFBWDBUQjlyZG1nVlV0cjZOL3hXdUg0Y3pqalJs?=
 =?utf-8?Q?D5FCysJKxBTwry8FSi/HF91Ag?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9317c51a-c74e-45e4-5389-08da58e3394d
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 08:50:16.8223
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KIbV5zTx32mOGcG2+RQxFxBWuOxTOpwrwpCOnhDVWjkGSQXtDu5lnSTIGnzNxKSESsLRHsoxvoZ1wYNY34D9ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5377
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

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDI4LCAyMDIyIDE6NDEgUE0NCj4gPg0KPiA+PiAgIHN0cnVjdCBpb21tdV9kb21h
aW4gew0KPiA+PiAgIAl1bnNpZ25lZCB0eXBlOw0KPiA+PiAgIAljb25zdCBzdHJ1Y3QgaW9tbXVf
ZG9tYWluX29wcyAqb3BzOw0KPiA+PiAgIAl1bnNpZ25lZCBsb25nIHBnc2l6ZV9iaXRtYXA7CS8q
IEJpdG1hcCBvZiBwYWdlIHNpemVzIGluIHVzZSAqLw0KPiA+PiAtCWlvbW11X2ZhdWx0X2hhbmRs
ZXJfdCBoYW5kbGVyOw0KPiA+PiAtCXZvaWQgKmhhbmRsZXJfdG9rZW47DQo+ID4+ICAgCXN0cnVj
dCBpb21tdV9kb21haW5fZ2VvbWV0cnkgZ2VvbWV0cnk7DQo+ID4+ICAgCXN0cnVjdCBpb21tdV9k
bWFfY29va2llICppb3ZhX2Nvb2tpZTsNCj4gPj4gKwl1bmlvbiB7DQo+ID4+ICsJCXN0cnVjdCB7
CS8qIElPTU1VX0RPTUFJTl9ETUEgKi8NCj4gPj4gKwkJCWlvbW11X2ZhdWx0X2hhbmRsZXJfdCBo
YW5kbGVyOw0KPiA+PiArCQkJdm9pZCAqaGFuZGxlcl90b2tlbjsNCj4gPj4gKwkJfTsNCj4gPg0K
PiA+IHdoeSBpcyBpdCBETUEgZG9tYWluIHNwZWNpZmljPyBXaGF0IGFib3V0IHVubWFuYWdlZA0K
PiA+IGRvbWFpbj8gVW5yZWNvdmVyYWJsZSBmYXVsdCBjYW4gaGFwcGVuIG9uIGFueSB0eXBlDQo+
ID4gaW5jbHVkaW5nIFNWQS4gSGVuY2UgSSB0aGluayBhYm92ZSBzaG91bGQgYmUgZG9tYWluIHR5
cGUNCj4gPiBhZ25vc3RpYy4NCj4gDQo+IFRoZSByZXBvcnRfaW9tbXVfZmF1bHQoKSBzaG91bGQg
YmUgcmVwbGFjZWQgYnkgdGhlIG5ldw0KPiBpb21tdV9yZXBvcnRfZGV2aWNlX2ZhdWx0KCkuIEpl
YW4gaGFzIGFscmVhZHkgc3RhcnRlZCB0aGlzIHdvcmsuDQo+IA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1pb21tdS9ZbzROdzlReWxsVDFSWmJkQG15cmljYS8NCj4gDQo+IEN1cnJl
bnRseSB0aGlzIGlzIG9ubHkgZm9yIERNQSBkb21haW5zLCBoZW5jZSBSb2JpbiBzdWdnZXN0ZWQg
dG8gbWFrZSBpdA0KPiBleGNsdWRlIHdpdGggdGhlIFNWQSBkb21haW4gdGhpbmdzLg0KPiANCj4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvZjMxNzAwMTYtNGQ3Zi1lNzhlLWRi
NDgtDQo+IDY4MzA1ZjY4MzM0OUBhcm0uY29tLw0KDQpUaGVuIGl0J3Mgd29ydGh5IGEgY29tbWVu
dCB0aGF0IHRob3NlIHR3byBmaWVsZHMgYXJlIGZvcg0Kc29tZSBsZWdhY3kgZmF1bHQgcmVwb3J0
aW5nIHN0dWZmIGFuZCBETUEgdHlwZSBvbmx5Lg0KDQo+ID4NCj4gPj4gKw0KPiA+PiArCW11dGV4
X2xvY2soJmdyb3VwLT5tdXRleCk7DQo+ID4+ICsJY3VyciA9IHhhX2NtcHhjaGcoJmdyb3VwLT5w
YXNpZF9hcnJheSwgcGFzaWQsIE5VTEwsIGRvbWFpbiwNCj4gPj4gR0ZQX0tFUk5FTCk7DQo+ID4+
ICsJaWYgKGN1cnIpDQo+ID4+ICsJCWdvdG8gb3V0X3VubG9jazsNCj4gPg0KPiA+IE5lZWQgY2hl
Y2sgeGFfaXNfZXJyKG9sZCkuDQo+IA0KPiBFaXRoZXINCj4gDQo+ICgxKSBvbGQgZW50cnkgaXMg
YSB2YWxpZCBwb2ludGVyLCBvcg0KDQpyZXR1cm4gLUVCVVNZIGluIHRoaXMgY2FzZQ0KDQo+ICgy
KSB4YV9pc19lcnIoY3VycikNCg0KcmV0dXJuIHhhX2VycihjdXIpDQoNCj4gDQo+IGFyZSBmYWls
dXJlIGNhc2VzLiBIZW5jZSwgImN1cnIgPT0gTlVMTCIgaXMgdGhlIG9ubHkgY2hlY2sgd2UgbmVl
ZC4gRGlkDQo+IEkgbWlzcyBhbnl0aGluZz8NCj4gDQoNCkJ1dCBub3cgeW91IGFsd2F5cyByZXR1
cm4gLUVCVVNZIGZvciBhbGwga2luZHMgb2YgeGEgZXJyb3JzLg0K
