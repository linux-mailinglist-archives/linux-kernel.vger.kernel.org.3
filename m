Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7055F2FF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 03:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbiF2ByK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiF2ByJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 21:54:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11E29CBF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 18:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656467648; x=1688003648;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5lYai6Wbbr6hhhvgEQ5LNjNBQg9a3RCdYGYVOBNU4SM=;
  b=XYUNTVaD5bqnXzivzXH1o5MMXivymkOdyc8KJWDFUaEj+uFGhZo3S8AV
   6N9u1OZg6eiOV/HI74elPtnNtMaBZUV1Yi3uETBbG3ZewAJQjy0VnRktF
   qQp9+osSsQw6lE8IAc3vWydMTmwXNc2xaq/hj7NegXdCmAJHu/YxeKeGh
   1zzF5BhkeduP2Uu1O43OP9W8jDSJ+vg/Va/AQKNZ1AJ2BZeLGAjOhobpU
   LhgUYspZATcnQQ6bdPRZBBZ+ww6aG2kpObhbpfK1MxGqPIirbIHbwysr+
   L2ZFZL24s+WnlLBEMqgyKOzZs+EEI6D7Z0bncjG95ox5+PL2MnrGraOaA
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10392"; a="345889482"
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="345889482"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2022 18:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,230,1650956400"; 
   d="scan'208";a="565265847"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 28 Jun 2022 18:54:08 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 28 Jun 2022 18:54:07 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 28 Jun 2022 18:54:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 28 Jun 2022 18:54:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fupSz9AuXg24IufJEd6NZx2ibaR1hiyAYbOhqQSyCNoGecogsjiRqi/IzxZbcNxfZ79Zg3qxH0kKwZ7+H7sZDfiuEzuacQcE57oexpoTfcwKUwEq6NAMJUc4B06RmmF0Xv5HZwFD+bfhWEVW6UjvYUZmPK8sdIj5xq0SFg7+E4tP7uJ3B76wcPI5d1UpX0x92X+QhtGFAgKIlW8d7eY2X0j8mdOges4GhW/XYybEAXtc9m+Jjo4ppf+twh67P5pmc8U/35sgxjzr4NWDrrt5bEwOMGjbtSyZc6Z2QtyQrYAIK8xrsWLLsARifrcVeDZiEyDRHyUojdwKgV4z6FjUxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5lYai6Wbbr6hhhvgEQ5LNjNBQg9a3RCdYGYVOBNU4SM=;
 b=LC9gPDdyV9G7kx4NV9dZ7qlcjdGKgrQEWlb9eh+L2ZNHKjXK6cA5f8AnvPFFMRVDkbX6Gm18GDc4f74bLW6O9/enycHdGrwnZxCmLL20bSqEB7ZTBFtg+GXGXtqy6Qplx8XADmdM25qy+qoC81WPXPmM63kN+r6VSDeI1DQk9GIYJq8YnagfSOwyl5PeuuiCJX1DydNMpiI0dk0x5mAwovVnvCzoncGcq8Zl4NfvRneRir96ygHBCp33XXSGcgrros3GUht3GtT6SGQ7xICjRCMzSxXRJ9KcDEPUE7RXETYRh7dqbRx+HtY4ehUgg4ud7QRWdiMkwkoM5cFdIRU72A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SN6PR11MB2575.namprd11.prod.outlook.com (2603:10b6:805:57::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Wed, 29 Jun
 2022 01:54:00 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5373.018; Wed, 29 Jun 2022
 01:54:00 +0000
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
Thread-Index: AQHYhX35xSpIBtEUJk2c4sDKhBGbeq1i8Q6wgAFnYgCAADJ2MIAAMAaAgADuHyA=
Date:   Wed, 29 Jun 2022 01:54:00 +0000
Message-ID: <BN9PR11MB5276CE638C49B571612702BA8CBB9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220621144353.17547-1-baolu.lu@linux.intel.com>
 <20220621144353.17547-5-baolu.lu@linux.intel.com>
 <BN9PR11MB5276FA1A1A8C20786D958C048CB99@BN9PR11MB5276.namprd11.prod.outlook.com>
 <42825be5-e24c-0f95-f49d-5f50d608506d@linux.intel.com>
 <BN9PR11MB527679FF12B6D990A5E596A88CB89@BN9PR11MB5276.namprd11.prod.outlook.com>
 <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
In-Reply-To: <89130952-155c-38f0-3318-1c071562661f@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 97a69769-b549-4c67-b4fa-08da59723c7a
x-ms-traffictypediagnostic: SN6PR11MB2575:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kboznsDIzh5EtyWrZ1uCfFqNjs5LpUsN/vjhYLW8NAOXRAUX/DoB2Tm5pB7tBfNE7R09vz8Z42IqK4xU629K4xRmP4x5qtfV01Hw3813BDXgvolTROCfhCzucTYpohmYPJ/VTMRB3TfO8+LSc20Nic+gcdF4aNiSUShy8dCbJR4oOuuq7sRi5Lm3rsGZ+NdQiXB2XE97lFB+pJH8BHZVcEbFVxcc3L01WRTZnkwJutEQccSsz7RMQYC7R2Bti6p+q/QTpmm2LsBszUbwaJD4g+5zQgbwq0QSnN9McmA3bHJuLl8AtYvFqPWEnlZWKd8y2kCjefguaBYrhTOvCVcRObydmgqi324S4VVvp/YLbs83F8hpL7Ip6IsshpNbAEWhYw0H/umirD+MAw1FOxILRLY8Nw8wroJjiU5mx1H1Igf07eXZwKInrIgrvv+FkrjyG6rOlKDn7zyio/IpgLn3L0GWZhWvcTr7EES7Ew0L+AVH7csStqZJud/tjzHDMRVhG6GwQQ+Y/MhmaoJrFtZwL2kwKjJSILQ6p09XdFjzQui+A2meZrdCXJ62aKol57RgjWdasHT1+08AxeW3n/CccGV4XcXa9gKIPUfk39+/WD3fiVk9hYt+MOZLbIDutxad9y7KEqsDpBpVEtB/C8sIAcXtpwTUEkfbYRZGXi74wwnw3sKkV04dnIG+egVPdh9S5eFhYOMiz2TpdZ/l9ta+Q0VdntJ/8h+pt6HxO7BfZ7T4dtWh2yC0rPafg/4VvydC0zYg03w1tCfC33nXDOyeMJ9aMJFWNEN3cD+vM5o6BA1aRmnzJKVYQkf7IULtp5X5kaEtDy75Mmde4SNO2WNiA9YR7445JUpo56YI/hCY0vlhXSIwWmuGNw/nO7mHRXEIxGI4UqKKyqg0Fzuzrg0TYg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(39860400002)(396003)(346002)(376002)(82960400001)(8936002)(921005)(52536014)(122000001)(966005)(7416002)(478600001)(38100700002)(5660300002)(38070700005)(26005)(66556008)(66946007)(76116006)(316002)(4326008)(66476007)(55016003)(66446008)(8676002)(64756008)(71200400001)(9686003)(86362001)(110136005)(53546011)(54906003)(7696005)(33656002)(186003)(41300700001)(6506007)(2906002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWhNQXBLRVR1TDhCd2V2ZTdPOE9OMHB5Y1BXZC9DM3RveGMyY3JlYUpLK2t4?=
 =?utf-8?B?T2tyQXpBMUdPWmRERS9mWHVzTUgxOWRkWHMzcmJuTnBMY0w0NWhTMzRqcVB4?=
 =?utf-8?B?b2FNdlgzbTBhNjRvM25WQVBKM1AwYVo2c21lNW40ODRzS0JteFNVdjhMNmxm?=
 =?utf-8?B?b2h4bWNvdHBHVldFWFNxdFpXdEhpd2hTY00xeTA4U05NMzZlNVhoRE12ZUxw?=
 =?utf-8?B?ZlNDb1JEVURwUWFwb0d2dlY4VWFadktCcmR2c255S09yMjdNZDJ3OXlMVUt0?=
 =?utf-8?B?U1h0YTBsVmlhUnRGajhDOUZEZm5sckQrNnQwTjVtN3lpVUp1UkJzancxT3g3?=
 =?utf-8?B?WWR6R01nTy8yNDYyNjc0RGJqV3krR2M3UFVOdFE2QmZZRGRYdnBJL21uUGN4?=
 =?utf-8?B?b2MzZkxPWEx2OVFTYU5aLzgwcjd2a2ZpUHdNTEI0L1Q5OGZ5aFQ0eE0vVzVr?=
 =?utf-8?B?MVVLL3I0ZzQ0MWNFQjFBWGNCdEVOaXI4RjF4ODBjbmJZZ25KWERsNU9tU3ZQ?=
 =?utf-8?B?UEdJL2QzUTBJdUpjbml4dElGSVFKTzhlV2xrdzFQYnZpZUt6aFNTM1lpM1VN?=
 =?utf-8?B?ZnBJdTdEZnF4NWtDa2h4c0l5VFRUYTVjcnFNQUFSZG9MSUVQaGo2MHVpUzdz?=
 =?utf-8?B?UGZMQ0kzWjVnMFJqY090dzFMeENwa2tZN08wQTFEUnhodmc0Ry9EOHB3UGJ5?=
 =?utf-8?B?SmMzMlNhZkRyMHl1UXJnTldUSUdTQXdzZmh5dURXZkczZ28rcWhvUWdiSnh2?=
 =?utf-8?B?WFVyRmdSa1pORlJHMlpTM0h3V2hxQSs0d08ySzBvVHVqdDFtMHhYTktlZnJH?=
 =?utf-8?B?RHZoVnpYWkw3QkxQbXhPcnhnSHFndmQ5c0xoZ05OV1J6bXBvMDEwMTdDeVNo?=
 =?utf-8?B?RWh5c244VjVnZW5icXI0Skc0UG9MbVh6QktBTlE2aStJN00rUlpjMUpvREpX?=
 =?utf-8?B?aGQxOWpFbkJodWg1MDJsS3R3cU9nZ2FiM0h3VEpQeU1PbTNkN0c5Z3JGT0R5?=
 =?utf-8?B?d2srNVgwWE9rakV2dHZ6L3orQWRmOWowbHc2YXBZc2ZianFGY2JGNi85emM1?=
 =?utf-8?B?S2orYWNyWFB0czM3OVBub0RDaUE1emtJWW1QVmpMdmpzVUc5c0svbjllMWkx?=
 =?utf-8?B?NnBOaERsK29mU3k4Q0FOREtUbWJJYzl6UGxqeGVhR3MwVVBoNzNmbTRSNFFB?=
 =?utf-8?B?RzF0cjFwOVBuSXoyTExFL3A3YnArOTErajBtanZsTG5MSWc0RWZBZnc1dTl1?=
 =?utf-8?B?L0RtQzV1akVRZ0hLQ29iYll5Z0dCc0NkK05GRmlSRlN3dU43OUwrandhb1dM?=
 =?utf-8?B?MTRKcmd6eGYyRDA3Rkg2V0VnVG1YUENJZGJzWi9CNm5HYkZrUTZ1d1lIdVll?=
 =?utf-8?B?T1NtcWJiaC91UHk3NFhsUDQ3L1JjZFhRaFQvdkZCOG9XWVZUS1BzdmlGNFhu?=
 =?utf-8?B?SVZVd1E4R0I0VllTUDUweSt2YzJSUFdHWGZRYTh1MjRmS0NiZ2h1OHcrRW5p?=
 =?utf-8?B?cXhweEh3UjYxVWJ2NTFnaXAzQlFoV2NoUFFGemQrQjNRbmwzazArRDYya3RD?=
 =?utf-8?B?T2hpSTFzWmZqb0kzMVpsVHNNeXVOaXhqd054V3B5end5Zkg1TVBSQ0hpNWY5?=
 =?utf-8?B?ejNuWlBmMzVubnZIYXluZ00rNlY2SlhpRy9VaUpVbVF0SmFBMVJhcmxvVHpm?=
 =?utf-8?B?eXE4VXBVN3UrbzV2OGdJcnE4M0syV2dON01PeXU0T3ZXRTF0R0hKQjczbmFG?=
 =?utf-8?B?ZW5OTWxrREFYUjUxbWsvbFBjQXVpcmZyY1hZTUhHTnRFaFE3dmxTZ3ZDdFVu?=
 =?utf-8?B?ZkwxcFdsTGpBUW9uaHVhZ1Bua2VIbVdFWi80L0VyUEJ2YzVLNlREc1Z6WmNx?=
 =?utf-8?B?aisxTzBvVGN4cWF5NlcxWXBITzhoZElzZmFCdi8wa2xOdzU5bEp0cGcvalZr?=
 =?utf-8?B?ZGhEYml3UnFyS2g2R3VNZmZ4bWc1MVE4bVc0UnRKbGtVdDNaVEhhcEo2cDdN?=
 =?utf-8?B?V2lwdklPVXdrZmZ6UmZCVXFTendLLzBUMzQ4QkFJV2k0T0gycDFXU3dKb1Fn?=
 =?utf-8?B?R0ZnL0pBSVk4OVNkMWJNVTZEeWR0ZWFxN0t0YjZXalM0MUVKUlVKcEppVDNv?=
 =?utf-8?Q?GgPdw/yBM+Up76ecXZ3pnj5Re?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97a69769-b549-4c67-b4fa-08da59723c7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 01:54:00.1539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /qFPhgywc0Kr2gxDI3TLBNSLa/0FLz6rdLHYuQoAU2CHwRoMf/75tGBB89LRdTj0QT+/7rFNOrrcNgyFQZprOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2575
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
ZGF5LCBKdW5lIDI4LCAyMDIyIDc6MzQgUE0NCj4gDQo+IE9uIDIwMjIvNi8yOCAxNjo1MCwgVGlh
biwgS2V2aW4gd3JvdGU6DQo+ID4+IEZyb206IEJhb2x1IEx1PGJhb2x1Lmx1QGxpbnV4LmludGVs
LmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVuZSAyOCwgMjAyMiAxOjQxIFBNDQo+ID4+Pj4g
ICAgc3RydWN0IGlvbW11X2RvbWFpbiB7DQo+ID4+Pj4gICAgCXVuc2lnbmVkIHR5cGU7DQo+ID4+
Pj4gICAgCWNvbnN0IHN0cnVjdCBpb21tdV9kb21haW5fb3BzICpvcHM7DQo+ID4+Pj4gICAgCXVu
c2lnbmVkIGxvbmcgcGdzaXplX2JpdG1hcDsJLyogQml0bWFwIG9mIHBhZ2Ugc2l6ZXMgaW4gdXNl
ICovDQo+ID4+Pj4gLQlpb21tdV9mYXVsdF9oYW5kbGVyX3QgaGFuZGxlcjsNCj4gPj4+PiAtCXZv
aWQgKmhhbmRsZXJfdG9rZW47DQo+ID4+Pj4gICAgCXN0cnVjdCBpb21tdV9kb21haW5fZ2VvbWV0
cnkgZ2VvbWV0cnk7DQo+ID4+Pj4gICAgCXN0cnVjdCBpb21tdV9kbWFfY29va2llICppb3ZhX2Nv
b2tpZTsNCj4gPj4+PiArCXVuaW9uIHsNCj4gPj4+PiArCQlzdHJ1Y3QgewkvKiBJT01NVV9ET01B
SU5fRE1BICovDQo+ID4+Pj4gKwkJCWlvbW11X2ZhdWx0X2hhbmRsZXJfdCBoYW5kbGVyOw0KPiA+
Pj4+ICsJCQl2b2lkICpoYW5kbGVyX3Rva2VuOw0KPiA+Pj4+ICsJCX07DQo+ID4+PiB3aHkgaXMg
aXQgRE1BIGRvbWFpbiBzcGVjaWZpYz8gV2hhdCBhYm91dCB1bm1hbmFnZWQNCj4gPj4+IGRvbWFp
bj8gVW5yZWNvdmVyYWJsZSBmYXVsdCBjYW4gaGFwcGVuIG9uIGFueSB0eXBlDQo+ID4+PiBpbmNs
dWRpbmcgU1ZBLiBIZW5jZSBJIHRoaW5rIGFib3ZlIHNob3VsZCBiZSBkb21haW4gdHlwZQ0KPiA+
Pj4gYWdub3N0aWMuDQo+ID4+IFRoZSByZXBvcnRfaW9tbXVfZmF1bHQoKSBzaG91bGQgYmUgcmVw
bGFjZWQgYnkgdGhlIG5ldw0KPiA+PiBpb21tdV9yZXBvcnRfZGV2aWNlX2ZhdWx0KCkuIEplYW4g
aGFzIGFscmVhZHkgc3RhcnRlZCB0aGlzIHdvcmsuDQo+ID4+DQo+ID4+IGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LWlvbW11L1lvNE53OVF5bGxUMVJaYmRAbXlyaWNhLw0KPiA+Pg0KPiA+
PiBDdXJyZW50bHkgdGhpcyBpcyBvbmx5IGZvciBETUEgZG9tYWlucywgaGVuY2UgUm9iaW4gc3Vn
Z2VzdGVkIHRvIG1ha2UgaXQNCj4gPj4gZXhjbHVkZSB3aXRoIHRoZSBTVkEgZG9tYWluIHRoaW5n
cy4NCj4gPj4NCj4gPj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtaW9tbXUvZjMxNzAw
MTYtNGQ3Zi1lNzhlLWRiNDgtDQo+ID4+IDY4MzA1ZjY4MzM0OUBhcm0uY29tLw0KPiA+IFRoZW4g
aXQncyB3b3J0aHkgYSBjb21tZW50IHRoYXQgdGhvc2UgdHdvIGZpZWxkcyBhcmUgZm9yDQo+ID4g
c29tZSBsZWdhY3kgZmF1bHQgcmVwb3J0aW5nIHN0dWZmIGFuZCBETUEgdHlwZSBvbmx5Lg0KPiAN
Cj4gVGhlIGlvbW11X2ZhdWx0IGFuZCBTVkEgZmllbGRzIGFyZSBleGNsdXNpdmUuIFRoZSBmb3Jt
ZXIgaXMgdXNlZCBmb3INCj4gdW5yZWNvdmVyYWJsZSBETUEgcmVtYXBwaW5nIGZhdWx0cywgd2hp
bGUgdGhlIGxhdHRlciBpcyBvbmx5IGludGVyZXN0ZWQNCj4gaW4gdGhlIHJlY292ZXJhYmxlIHBh
Z2UgZmF1bHRzLg0KPiANCj4gSSB3aWxsIHVwZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2Ugd2l0aCBh
Ym92ZSBleHBsYW5hdGlvbi4gRG9lcyB0aGlzIHdvcmsNCj4gZm9yIHlvdT8NCj4gDQoNCk5vdCBl
eGFjdGx5LiBZb3VyIGVhcmxpZXIgZXhwbGFuYXRpb24gaXMgYWJvdXQgb2xkIHZzLiBuZXcgQVBJ
IHRodXMNCmxlYXZpbmcgdGhlIGV4aXN0aW5nIGZhdWx0IGhhbmRsZXIgd2l0aCBjdXJyZW50IG9u
bHkgdXNlciBpcyBmaW5lLg0KDQpidXQgdGhpcyBpcyBub3QgcmVsYXRlZCB0byB1bnJlY292ZXJh
YmxlIHZzLiByZWNvdmVyYWJsZS4gQXMgSSBzYWlkDQp1bnJlY292ZXJhYmxlIGNvdWxkIGhhcHBl
biBvbiBhbGwgZG9tYWluIHR5cGVzLiBUeWluZyBpdCB0bw0KRE1BLW9ubHkgZG9lc24ndCBtYWtl
IHNlbnNlIGFuZCBJIHRoaW5rIGluIHRoZSBlbmQgdGhlIG5ldw0KaW9tbXVfcmVwb3J0X2Rldmlj
ZV9mYXVsdCgpIHdpbGwgbmVlZCBzdXBwb3J0IGJvdGguIElzIGl0IG5vdCB0aGUNCmNhc2U/DQo=
