Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0F5554C1AC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347843AbiFOGPV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352630AbiFOGN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:13:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC1393C6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655273603; x=1686809603;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MAw12frkse7EwAUGL+2vb4G2f+xyyHDhaQpAoBmT4+E=;
  b=ft0e0EpY6XtgrowptFrUZzUVxmMzuLqGGlfrfgsS0T+SS3KjZkZjLsWd
   38P7y+a0GVSrczpzKWUXnhYxjnXkzllQ0VxUs75jGELP3/p//qTiGPjZu
   AfhapD1H9aVuBnPmOZrK0mXGRpwLVHA4ajt/HVpENPp/8BOFH3P+2EzGR
   vlbDtEmktqXFK6ZWnsQnX6gwuebPx2p6znueewZ+huwlBwzvFYjZ558TI
   FXYexCx8/HKGETihFPqVnhivzX+Lw7s3F6MEMWBIFbSyS/NrUqKZuozSq
   MlbeklrszTDE73MJgNvXEsb9ke3GLWdW69JGz49kS6JMcziZLwSipaHPP
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="365199342"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="365199342"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 23:13:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="640811711"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 14 Jun 2022 23:13:20 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 14 Jun 2022 23:13:20 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 14 Jun 2022 23:13:20 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 14 Jun 2022 23:13:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T+1NrELQNDFi2KNq8Xb1Dp09Qu4GrTQ4579LKU32lHfScHSYT+8DQJ19X5OZnfTK2we67/fvi1W3xanPgKbYTN0QycpBgVA4yox38SkVuUnc3kDNRZ71xzY8livJwbV/4jJCYfjqpuBnsTZwjLoqH2Gn1ZQMdyMsfxN9AvR+1KCQKTSfrUp1gZ4l5xAZmXMkLk83qztj8ApUykKIQTXi3GHTOTq/QY/EzG84s3+GEithV/3eC1b7Pr73TTArKOk8LL2WYEJoXnwi2ECVP6Il3HFM8KvQeIlD1rxwoNucE/vbPW7h1cC4skQBI9861WwJ4S49nsXCFxE7/V9G7vC4Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAw12frkse7EwAUGL+2vb4G2f+xyyHDhaQpAoBmT4+E=;
 b=f8nhhbhSa8VHcMiVzpNEvKmwzoAPQ3ycaaLzf5myF0QKiPKGLRRjrjJK0Knsu2awsSqvuFr8pTqy3EMTsTH9Aw3NcyE4CyXCgYS+b0be4itQ//frB/GtH8TQqt0QsKAxLPrqMmogHWp/ZyLBF+zWCy2ZuXGD9m4XgfZ6AQGGKgyh9zyhrwpV+87VAwnW2BLSjUfoTe7m3frEw4oS0/NDcHeelhRzNNt1G+b1exaUrGbEXHYy8TE9QW/DL224TkuGNpJIs0aEkB+1tstmDIFUvyYWftl9gHHl1x2X0qkpXb2/Ul6Ji6dICrcJdWjpy4fqxZqK9VhoUTmT1TF8jiv1fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by CY4PR11MB1590.namprd11.prod.outlook.com (2603:10b6:910:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 06:13:17 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 06:13:17 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>
CC:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Topic: [PATCH v2 01/12] iommu/vt-d: debugfs: Remove device_domain_lock
 usage
Thread-Index: AQHYf5o9PBZqbtPZ60ix6nIaRhUsd61OcNnAgAFFbQCAAEgwYA==
Date:   Wed, 15 Jun 2022 06:13:17 +0000
Message-ID: <BN9PR11MB52769385E96377F5FD8CE2928CAD9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614025137.1632762-1-baolu.lu@linux.intel.com>
 <20220614025137.1632762-2-baolu.lu@linux.intel.com>
 <BN9PR11MB527680C1957C0E29E8AE85168CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <4f6f7bb9-5ea4-b466-7a59-62ebd5bc2cf7@linux.intel.com>
In-Reply-To: <4f6f7bb9-5ea4-b466-7a59-62ebd5bc2cf7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ad13b66c-f13a-4d82-c0ca-08da4e96237f
x-ms-traffictypediagnostic: CY4PR11MB1590:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <CY4PR11MB159005E2DFE85B2A6097202F8CAD9@CY4PR11MB1590.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6T7bM/KUR+WTaa9KdIQ+8kqf9vGTjBb27qE5t+Y4H5nd/KGt6SHih3p7eRxvr6jayp+hu4ga26VEmCbRX4JYg50aVI8MfKCaQUVUXOShPLTkG7W2YJcg3rYqhUTv+T6p5oz1lIOzYX3Bh7MFXjhI6RH2WzWi3ovV4fkm/hVd9EoVBH8om6n+deBq1udkXHbkuUZ9U7HLusq/Rk54tTdb1piFEbn9IQ6akUFVVPdLLQDw+079fOTZchCe2E13j4QuGXHT4N0QIc4amOMh5WZ3c/5JihqDWA0x6rGpcpbyQ7rpBldbkE8y8TC42nff+gH7f4T28rcA1qP+ugHJznmzlL2gPqMlMc/+JRl+/RQs5U4w/bkFUhWozoAU1r/h+7ukPosG2bpw3S0rsuXkVXe1h/NXBbY0aTk301SiP96cVKJqTtFLPvSb+rVF7CMBJhiMhhZ2SZ17wMvChXW5uuhqWiR0ZyoCr4OM1Rd7B+KmfyZcDCL0CTI3aF48bQ2kmhP+MFqf6LquKEyOJwdJn5fPHEneeKGXTIJ4HyMRy7cvVqh98QHRFcQ5CFtp6zIiDyawaK26fkv2GjUEastKIncKnxlpxdyAHMJ8dqfdaEz2l8TL5qmrGZBRpTSgrBCkhKK/xFCTq/Mv/t1xAOQigVOqgsv4/tbbiX/RpybVP75SHWoZHtv0Yjl76j8P6cZydiQbgVwGHhFoawwLpGyCDk8oug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(83380400001)(55016003)(2906002)(8676002)(316002)(7696005)(33656002)(6506007)(71200400001)(86362001)(9686003)(110136005)(53546011)(508600001)(4326008)(54906003)(26005)(82960400001)(122000001)(186003)(66556008)(66446008)(52536014)(66476007)(8936002)(66946007)(5660300002)(64756008)(38100700002)(38070700005)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NVpqaXQ3ck41RTBBaS9zNHRieXRGV0tvdndsZ0ZoenJYdjZBbkNFSFZMaGhy?=
 =?utf-8?B?YzlkbmQ0bjRxckVva1Fia3J3OHQ3c3l1RTJDdk9pVjI1Y2plRVp2NlQ4bktD?=
 =?utf-8?B?KzFDMmlpeHBhTVBYWTEvWTVPVGdUM2htU1ZvTGJQTEd5dkVxU0ZOYUE4R2Vv?=
 =?utf-8?B?c2FtL2NtZCtnWmxERUJubzErN053UmJOd04yc0RiWStDRFJnMmpXeDRWRlNQ?=
 =?utf-8?B?dnJkZHBaS0xRRlA4RXhnZ2Q2UlhKOENpaU45Q3BYOENBMngzOC8xeS9uOGIv?=
 =?utf-8?B?dzlsTkhwRUVQSXBtM1lIQTZRSG8ybHR1L09nd1JKRUdSVGd6UzhWQ0pQMnph?=
 =?utf-8?B?Y2dRMVJ6YkU0akVBTGNMSGg0VWs4RzdaVlFPZ1pHNWNpOVZDSjhBMzQwNmRM?=
 =?utf-8?B?dTVVbld3NTB6a3NPdy9BWFE0V3hXc3A4Tkd1QW1EbzNyaUk4SVVkcDU0b1Ev?=
 =?utf-8?B?Y2VyVFNqcGpjZEVmMXRLUmhJU2ZIellYWnJlSzl0Y2VBMWxjcWVJOGt1dTNC?=
 =?utf-8?B?U0dWRS9kNGtQTVdyOWVXVGIyd3dCUDJlSlM4Z1I3eldkUTZQYlJuTjNBVmlS?=
 =?utf-8?B?QjVqaExrd2JTS0d6NEVOVE91T1hMVXkrcDBjamxlZGQ2MGpwaUVyejhZYWNX?=
 =?utf-8?B?bjg2N2ozWGhtWlAzREorbzF4aWF0cHdQUmdEUjBHanRXemdXVnFMb09zOTRM?=
 =?utf-8?B?QjZHdHY5cVlBSlc5NE8wZWhCOGdiWG9BNEhiNGdQaGFzMFIvUzM1K09YeU1F?=
 =?utf-8?B?UG5GTDdxMVp2RndHTDlpSTJXQTUwRXk2VXpCcmU3TnFjM0o3N2E4YnAwU3RE?=
 =?utf-8?B?cUgrRkpNeTJDeEtsWE53b1FJeUt5Rjl6amxEMFh4SThHSmRiZm5ZVTN5Z3dO?=
 =?utf-8?B?TTJYMllvWUYwaitkZStESDkvQ28xRXZjT0w2ZmxVaGN3Rnc1RWtSd3dmcHBv?=
 =?utf-8?B?MXQwYXN5d1J3VDRIUlpsWDc5d3pWR1Z1dFRlTmIycElnalJTQko5cktoRjBV?=
 =?utf-8?B?UnZMbEhWcXBydnIySCtYdWRJTS96YmxCdlNCQ0ZSR0NMNTRpVFJzUmZvUHpl?=
 =?utf-8?B?UW5mdGVLWWJLOTBmWHlaQThOeXU0WVgxdGRUakRaRms5K1M3WkpucjdtUnR2?=
 =?utf-8?B?eHJxWkcyTFZUSHgrR1ZXbFZaTEE1NWg0SUJmUzhLK0Jqa3lKVEpCdHEybnpY?=
 =?utf-8?B?OWFIMTArRE0vVGxJNW9abHRFcGROb2U1aGNndkJjMXhOSmRVTk9pOGY0ZmNW?=
 =?utf-8?B?bjROUzJ4OVJMa3p5bk5LTWo5YU9SS1FsMlVYVE9yc1FadkRiUExJNzFzTnlM?=
 =?utf-8?B?c1dLMzRVS3ZncmRnMzQ0L1l2SUlvUUhVelJBamFDQUozYllmNlZCYXh3MFJ4?=
 =?utf-8?B?UFR6RUhKKzIyWlU3dWJBNFJ3MGRkL1R6UHp4OEQzMXpTTzU0NVZqK0w3aXRY?=
 =?utf-8?B?VWpqd0ROcWxCaWpnaytlMm9ZdTRrY0JHc1FrbDB1SzZrR0w2VFFWVDAwVWFn?=
 =?utf-8?B?V2lkeDdwd0tWQzVkczJUZkNmc1NQVUxyeGZ5QU5JRkQzTXpPVUdWQnVFcVZX?=
 =?utf-8?B?dGhYWExzYmVGUVkzbWRnejFhQlRjbitYUkc3VUwxWldTK0I3K3NJR1cwSEI1?=
 =?utf-8?B?bmZWcm8xR0owQ0c1Zm9KV0g2T0JpWDVhNnNGOVV1cHBIenJwcW5sY0ZiMXdX?=
 =?utf-8?B?YmNhOFRxdkJoemR0NXNueE9HTDNyd2ZjN3R1cWZxQzNkYkd4RDVobEc5djMx?=
 =?utf-8?B?blZVa0kwQ2ZKS3pJMFROc3JEZXd5cVhBQXkxWGplWE1NWHZvckNLM0I3MDFP?=
 =?utf-8?B?MllHR05QempmS2xEMGdMYXZ3ZzFEZXNQZUNuUjB0clh4RTFkbGZzeVVEYjNI?=
 =?utf-8?B?bkJjaUZjekdjbUpnZUpHdHIvQkFXRlcvblE2SU1ySTlyM2Zpd1kzdFJyMzNk?=
 =?utf-8?B?dTd6bEZ0M2dnUlBkTWY2SUdscWRGTW1FekM3Z2hSYWlodjdodmNzTG1MSUNj?=
 =?utf-8?B?VWdacHdtVzJzSHZtUFJnSmtUL0RNZ0N3Zi9YK0xOeER5OGs0RksxbEozeDN0?=
 =?utf-8?B?Tk5pdkl0UDlNZWcyQjVRdWxZVHQ0bzhKRENUNmludy9ZclVSVDYzd0UwWGw1?=
 =?utf-8?B?b2JXTmxNZTNDSDN2akxKSlo1N1JwOFdEeGt5ajNvblkxQldxamxHVlptN3dp?=
 =?utf-8?B?cG8xQzk4ai8zM1NZSUtLNlZ2a3J6c2dNa3c1a3VhcVJFWUM4K1VFV1g1eXgw?=
 =?utf-8?B?Nm8zVVVPQlh6TU5MeElLY002b2tEYVBZVm1OUFFaOHNVck5FaDhmQW12YWhU?=
 =?utf-8?B?Z1hmdVFWdTM2QW9uUGR0SGZOaDdNNkxmamV2VGFuMklnSHlyR1Bhdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad13b66c-f13a-4d82-c0ca-08da4e96237f
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2022 06:13:17.3826
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: no8q8Na7ziaL0nF2B8CpCgcrS4ImqkjcdfaU7Fvv0Sb9yMu1Qin6xEcAmmds7lFQVGnQedcKZuCMAr2Z0XqsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1590
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRu
ZXNkYXksIEp1bmUgMTUsIDIwMjIgOTo1NCBBTQ0KPiANCj4gT24gMjAyMi82LzE0IDE0OjQzLCBU
aWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHU8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE0LCAyMDIyIDEwOjUxIEFNDQo+ID4+
DQo+ID4+IFRoZSBkb21haW5fdHJhbnNsYXRpb25fc3RydWN0IGRlYnVnZnMgbm9kZSBpcyB1c2Vk
IHRvIGR1bXAgdGhlIERNQVINCj4gPj4gcGFnZQ0KPiA+PiB0YWJsZXMgZm9yIHRoZSBQQ0kgZGV2
aWNlcy4gSXQgcG90ZW50aWFsbHkgcmFjZXMgd2l0aCBzZXR0aW5nIGRvbWFpbnMgdG8NCj4gPj4g
ZGV2aWNlcy4gVGhlIGV4aXN0aW5nIGNvZGUgdXNlcyBhIGdsb2JhbCBzcGlubG9jayBkZXZpY2Vf
ZG9tYWluX2xvY2sgdG8NCj4gPj4gYXZvaWQgdGhlIHJhY2VzLCBidXQgdGhpcyBpcyBwcm9ibGVt
YXRpY2FsIGFzIHRoaXMgbG9jayBpcyBvbmx5IHVzZWQgdG8NCj4gPj4gcHJvdGVjdCB0aGUgZGV2
aWNlIHRyYWNraW5nIGxpc3RzIG9mIGVhY2ggZG9tYWluLg0KPiA+IGlzIGl0IHJlYWxseSBwcm9i
bGVtYXRpYyBhdCB0aGlzIHBvaW50PyBCZWZvcmUgZm9sbG93aW5nIHBhdGNoZXMgYXJlIGFwcGxp
ZWQNCj4gPiB1c2luZyBkZXZpY2VfZG9tYWluX2xvY2sgc2hvdWxkIGhhdmUgc2ltaWxhciBlZmZl
Y3QgYXMgaG9sZGluZyB0aGUgZ3JvdXANCj4gPiBsb2NrLg0KPiA+DQo+ID4gSGVyZSBpdCBtaWdo
dCBtYWtlIG1vcmUgc2Vuc2UgdG8ganVzdCBmb2N1cyBvbiByZW1vdmluZyB0aGUgdXNlIG9mDQo+
ID4gZGV2aWNlX2RvbWFpbl9sb2NrIG91dHNpZGUgb2YgaW9tbXUuYy4gSnVzdCB0aGF0IHVzaW5n
IGdyb3VwIGxvY2sgaXMNCj4gPiBjbGVhbmVyIGFuZCBtb3JlIGNvbXBhdGlibGUgdG8gZm9sbG93
aW5nIGNsZWFudXBzLg0KPiA+DQo+ID4gYW5kIGl0J3Mgd29ydGggbWVudGlvbmluZyB0aGF0IHJh
Y2luZyB3aXRoIHBhZ2UgdGFibGUgdXBkYXRlcyBpcyBvdXQNCj4gPiBvZiB0aGUgc2NvcGUgb2Yg
dGhpcyBzZXJpZXMuIFByb2JhYmx5IGFsc28gYWRkIGEgY29tbWVudCBpbiB0aGUgY29kZQ0KPiA+
IHRvIGNsYXJpZnkgdGhpcyBwb2ludC4NCj4gPg0KPiANCj4gSGkgS2V2aW4sDQo+IA0KPiBIb3cg
ZG8geW91IGxpa2UgYmVsb3cgdXBkYXRlZCBwYXRjaD8NCg0KWWVzLCB0aGlzIGlzIGJldHRlci4N
Cg0KPiANCj4gIEZyb20gY2VjYzlhMDYyMzc4MGExMWM0ZWE0ZDBhMTVhYTYxODdmMDE1NDFjNCBN
b24gU2VwIDE3IDAwOjAwOjAwDQo+IDIwMDENCj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxp
bnV4LmludGVsLmNvbT4NCj4gRGF0ZTogU3VuLCAyOSBNYXkgMjAyMiAxMDoxODo1NiArMDgwMA0K
PiBTdWJqZWN0OiBbUEFUQ0ggMS8xXSBpb21tdS92dC1kOiBkZWJ1Z2ZzOiBSZW1vdmUgZGV2aWNl
X2RvbWFpbl9sb2NrDQo+IHVzYWdlDQo+IA0KPiBUaGUgZG9tYWluX3RyYW5zbGF0aW9uX3N0cnVj
dCBkZWJ1Z2ZzIG5vZGUgaXMgdXNlZCB0byBkdW1wIHRoZSBETUFSDQo+IHBhZ2UNCj4gdGFibGVz
IGZvciB0aGUgUENJIGRldmljZXMuIEl0IHBvdGVudGlhbGx5IHJhY2VzIHdpdGggc2V0dGluZyBk
b21haW5zIHRvDQo+IGRldmljZXMuIFRoZSBleGlzdGluZyBjb2RlIHVzZXMgdGhlIGdsb2JhbCBz
cGlubG9jayBkZXZpY2VfZG9tYWluX2xvY2sgdG8NCj4gYXZvaWQgdGhlIHJhY2VzLg0KPiANCj4g
VGhpcyByZW1vdmVzIHRoZSB1c2Ugb2YgZGV2aWNlX2RvbWFpbl9sb2NrIG91dHNpZGUgb2YgaW9t
bXUuYyBieSByZXBsYWNpbmcNCj4gaXQgd2l0aCB0aGUgZ3JvdXAgbXV0ZXggbG9jay4gVXNpbmcg
dGhlIGdyb3VwIG11dGV4IGxvY2sgaXMgY2xlYW5lciBhbmQNCj4gbW9yZSBjb21wYXRpYmxlIHRv
IGZvbGxvd2luZyBjbGVhbnVwcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9s
dS5sdUBsaW51eC5pbnRlbC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvaW9tbXUvaW50ZWwvZGVi
dWdmcy5jIHwgNDIgKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0NCj4gICBkcml2
ZXJzL2lvbW11L2ludGVsL2lvbW11LmMgICB8ICAyICstDQo+ICAgZHJpdmVycy9pb21tdS9pbnRl
bC9pb21tdS5oICAgfCAgMSAtDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzMSBpbnNlcnRpb25zKCsp
LCAxNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVs
L2RlYnVnZnMuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZGVidWdmcy5jDQo+IGluZGV4IGQ5Mjdl
ZjEwNjQxYi4uZjRhY2Q4OTkzZjYwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVs
L2RlYnVnZnMuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2RlYnVnZnMuYw0KPiBAQCAt
MzQyLDEzICszNDIsMTMgQEAgc3RhdGljIHZvaWQgcGd0YWJsZV93YWxrX2xldmVsKHN0cnVjdCBz
ZXFfZmlsZSAqbSwNCj4gc3RydWN0IGRtYV9wdGUgKnBkZSwNCj4gICAJfQ0KPiAgIH0NCj4gDQo+
IC1zdGF0aWMgaW50IHNob3dfZGV2aWNlX2RvbWFpbl90cmFuc2xhdGlvbihzdHJ1Y3QgZGV2aWNl
ICpkZXYsIHZvaWQgKmRhdGEpDQo+ICtzdGF0aWMgaW50IF9fc2hvd19kZXZpY2VfZG9tYWluX3Ry
YW5zbGF0aW9uKHN0cnVjdCBkZXZpY2UgKmRldiwgdm9pZCAqZGF0YSkNCj4gICB7DQo+IC0Jc3Ry
dWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGRldl9pb21tdV9wcml2X2dldChkZXYpOw0K
PiAtCXN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluID0gaW5mby0+ZG9tYWluOw0KPiArCXN0cnVj
dCBkbWFyX2RvbWFpbiAqZG9tYWluOw0KPiAgIAlzdHJ1Y3Qgc2VxX2ZpbGUgKm0gPSBkYXRhOw0K
PiAgIAl1NjQgcGF0aFs2XSA9IHsgMCB9Ow0KPiANCj4gKwlkb21haW4gPSB0b19kbWFyX2RvbWFp
bihpb21tdV9nZXRfZG9tYWluX2Zvcl9kZXYoZGV2KSk7DQo+ICAgCWlmICghZG9tYWluKQ0KPiAg
IAkJcmV0dXJuIDA7DQo+IA0KPiBAQCAtMzU5LDIwICszNTksMzggQEAgc3RhdGljIGludCBzaG93
X2RldmljZV9kb21haW5fdHJhbnNsYXRpb24oc3RydWN0DQo+IGRldmljZSAqZGV2LCB2b2lkICpk
YXRhKQ0KPiAgIAlwZ3RhYmxlX3dhbGtfbGV2ZWwobSwgZG9tYWluLT5wZ2QsIGRvbWFpbi0+YWdh
dyArIDIsIDAsIHBhdGgpOw0KPiAgIAlzZXFfcHV0YyhtLCAnXG4nKTsNCj4gDQo+IC0JcmV0dXJu
IDA7DQo+ICsJcmV0dXJuIDE7DQo+ICAgfQ0KPiANCj4gLXN0YXRpYyBpbnQgZG9tYWluX3RyYW5z
bGF0aW9uX3N0cnVjdF9zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdW51c2VkKQ0KPiAr
c3RhdGljIGludCBzaG93X2RldmljZV9kb21haW5fdHJhbnNsYXRpb24oc3RydWN0IGRldmljZSAq
ZGV2LCB2b2lkICpkYXRhKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiAtCWlu
dCByZXQ7DQo+ICsJc3RydWN0IGlvbW11X2dyb3VwICpncm91cDsNCj4gDQo+IC0Jc3Bpbl9sb2Nr
X2lycXNhdmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiAtCXJldCA9IGJ1c19mb3Jf
ZWFjaF9kZXYoJnBjaV9idXNfdHlwZSwgTlVMTCwgbSwNCj4gLQkJCSAgICAgICBzaG93X2Rldmlj
ZV9kb21haW5fdHJhbnNsYXRpb24pOw0KPiAtCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUoJmRldmlj
ZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiArCWdyb3VwID0gaW9tbXVfZ3JvdXBfZ2V0KGRldik7
DQo+ICsJaWYgKGdyb3VwKSB7DQo+ICsJCS8qDQo+ICsJCSAqIFRoZSBncm91cC0+bXV0ZXggaXMg
aGVsZCBhY3Jvc3MgdGhlIGNhbGxiYWNrLCB3aGljaCB3aWxsDQo+ICsJCSAqIGJsb2NrIGNhbGxz
IHRvIGlvbW11X2F0dGFjaC9kZXRhY2hfZ3JvdXAvZGV2aWNlLiBIZW5jZSwNCj4gKwkJICogdGhl
IGRvbWFpbiBvZiB0aGUgZGV2aWNlIHdpbGwgbm90IGNoYW5nZSBkdXJpbmcgdHJhdmVyc2FsLg0K
PiArCQkgKg0KPiArCQkgKiBBbGwgZGV2aWNlcyBpbiBhbiBpb21tdSBncm91cCBzaGFyZSBhIHNp
bmdsZSBkb21haW4sDQo+IGhlbmNlDQo+ICsJCSAqIHdlIG9ubHkgZHVtcCB0aGUgZG9tYWluIG9m
IHRoZSBmaXJzdCBkZXZpY2UuIEV2ZW4gdGhvdWdoLA0KDQpidXNfZm9yX2VhY2hfZGV2KCkgd2ls
bCBzdGlsbCBsZWFkIHRvIGR1cGxpY2F0ZWQgZHVtcCBpbiB0aGUgc2FtZSBncm91cA0KYnV0IHBy
b2JhYmx5IHdlIGNhbiBsZWF2ZSB3aXRoIGl0IGZvciBhIGRlYnVnIGludGVyZmFjZS4NCg0KPiAr
CQkgKiB0aGlzIGNvZGUgc3RpbGwgcG9zc2libHkgcmFjZXMgd2l0aCB0aGUgaW9tbXVfdW5tYXAo
KQ0KPiArCQkgKiBpbnRlcmZhY2UuIFRoaXMgY291bGQgYmUgc29sdmVkIGJ5IFJDVS1mcmVlaW5n
IHRoZSBwYWdlDQo+ICsJCSAqIHRhYmxlIHBhZ2VzIGluIHRoZSBpb21tdV91bm1hcCgpIHBhdGgu
DQo+ICsJCSAqLw0KPiArCQlpb21tdV9ncm91cF9mb3JfZWFjaF9kZXYoZ3JvdXAsIGRhdGEsDQo+
ICsJCQkJCSBfX3Nob3dfZGV2aWNlX2RvbWFpbl90cmFuc2xhdGlvbik7DQo+ICsJCWlvbW11X2dy
b3VwX3B1dChncm91cCk7DQo+ICsJfQ0KPiANCj4gLQlyZXR1cm4gcmV0Ow0KPiArCXJldHVybiAw
Ow0KPiArfQ0KPiArDQo+ICtzdGF0aWMgaW50IGRvbWFpbl90cmFuc2xhdGlvbl9zdHJ1Y3Rfc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnVudXNlZCkNCj4gK3sNCj4gKwlyZXR1cm4gYnVz
X2Zvcl9lYWNoX2RldigmcGNpX2J1c190eXBlLCBOVUxMLCBtLA0KPiArCQkJCXNob3dfZGV2aWNl
X2RvbWFpbl90cmFuc2xhdGlvbik7DQo+ICAgfQ0KPiAgIERFRklORV9TSE9XX0FUVFJJQlVURShk
b21haW5fdHJhbnNsYXRpb25fc3RydWN0KTsNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lv
bW11L2ludGVsL2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gaW5kZXgg
MTkwMjRkYzUyNzM1Li5hMzlkNzJhOWQxY2YgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuYw0KPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gQEAg
LTMxNCw3ICszMTQsNyBAQCBzdGF0aWMgaW50IGlvbW11X3NraXBfdGVfZGlzYWJsZTsNCj4gICAj
ZGVmaW5lIElERU5UTUFQX0dGWAkJMg0KPiAgICNkZWZpbmUgSURFTlRNQVBfQVpBTElBCQk0DQo+
IA0KPiAtREVGSU5FX1NQSU5MT0NLKGRldmljZV9kb21haW5fbG9jayk7DQo+ICtzdGF0aWMgREVG
SU5FX1NQSU5MT0NLKGRldmljZV9kb21haW5fbG9jayk7DQo+ICAgc3RhdGljIExJU1RfSEVBRChk
ZXZpY2VfZG9tYWluX2xpc3QpOw0KPiANCj4gICAvKg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9p
b21tdS9pbnRlbC9pb21tdS5oIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+IGluZGV4
IGEyMmFkZmJkZjg3MC4uOGE2ZDY0ZDcyNmMwIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11
L2ludGVsL2lvbW11LmgNCj4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5oDQo+IEBA
IC00ODAsNyArNDgwLDYgQEAgZW51bSB7DQo+ICAgI2RlZmluZSBWVERfRkxBR19TVk1fQ0FQQUJM
RQkJKDEgPDwgMikNCj4gDQo+ICAgZXh0ZXJuIGludCBpbnRlbF9pb21tdV9zbTsNCj4gLWV4dGVy
biBzcGlubG9ja190IGRldmljZV9kb21haW5fbG9jazsNCj4gDQo+ICAgI2RlZmluZSBzbV9zdXBw
b3J0ZWQoaW9tbXUpCShpbnRlbF9pb21tdV9zbSAmJg0KPiBlY2FwX3NtdHMoKGlvbW11KS0+ZWNh
cCkpDQo+ICAgI2RlZmluZSBwYXNpZF9zdXBwb3J0ZWQoaW9tbXUpCShzbV9zdXBwb3J0ZWQoaW9t
bXUpICYmDQo+IAkJXA0KPiAtLQ0KPiAyLjI1LjENCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gYmFv
bHUNCg==
