Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D008054A8CA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238094AbiFNFhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbiFNFhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:37:01 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5610B2935C
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 22:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655185021; x=1686721021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=UQLTjMIZ/sXj3sPCr2bTxd0gG0Iun4+3IhwHosFViCk=;
  b=AFdjRdd8XzrnSS/8VsXzRqTVX8Fdw/Gc+pVg9Kl/u5tsXCt2jQYDRutn
   aFjIwFNw1zTqDAPpTgSVNoJDka26sKCp1ZY4lTe3Rq4NlYuWoGNmn5Xh8
   C0/WdGXr3eBrxVUx3wPf9ba8t0GIx0QjMTy1BhREtfOHckIUiUUQkSPUx
   K4AT5uu7mFVsOCrmeEZwlXVjfz84wYd/TdM8CSdiuGZAQjmyR1csDDg5I
   WT+27oZQiWafJZCBk0LKFA0REfDrJZwl++EIgF+OQeZixMKHuAdYxRycr
   7z26RcPICzbe3kVWAZOYRu1KIbPzgvmyJ6zbsDZdiRELz+hUjmo/L9AXQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="303917417"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="303917417"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 22:37:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="569756060"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2022 22:37:00 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 22:37:00 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 22:36:59 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 22:36:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BOV6Mt5ZbT5g7GvbMd8JEDwII12vRGMdaK7Pr9p5bssXCX9UBOIUZTgNHC1dds6J7jb+D8QW+7Q9RsCt28uZeWZlJtldXN4/4tFoQZ3MRBKYl1nyTGgoAVP7Dv/2O+3yV+9aPMsbXBgDSgDah0v/pJAt8otPfoFYyxFDKegd4YbZCniLuxbeUekRflYWPy2ZrvlyOIi8tGQ3ddiryLo+S8C1tcvgm5KbdPxoU5KMfCte+YIZ5shrya0up31s08CqjVPcfaUFzMsmbDic8WU9gVx5LEyXpVJ/StNRLIvwvYPsYqolS4AdhZeoXHg3KcHFG5X5vV0PuzKEhPfjKI7PTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UQLTjMIZ/sXj3sPCr2bTxd0gG0Iun4+3IhwHosFViCk=;
 b=B4FWMPDaLUAm8AoUC2dA0dRqwcJIlL+fszVD5CP8vAFew9BUi9UBBT7NeF5qkejzgFTR2MJtcrf09rKd79ntccSd84VYYLcD/7MCY88xSPIZm6LjWGs0tyg2sDYQ3/ICemXIJttPSDEF86+K5kqw/YTP0RIUXkfOQUf9ya3NPDosHB501yZraxCQnuFawumEOIv9+YIszCUmVTrJ+Jw1x7FdgU8oQf7piZ+DFHm76QmNO8XJbPB/XHbfBaF0v7U+L6JEoYekLGfFBy/E6/oz+UKLW5wB+1NOPyEriURw7aDBsUXssVPdt7vhrU5Usp+RRq7pAwoggQBKN5wCKz+rlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by DM6PR11MB4345.namprd11.prod.outlook.com (2603:10b6:5:202::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Tue, 14 Jun
 2022 05:36:57 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::3583:afc6:2732:74b8%4]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 05:36:57 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>
CC:     "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Topic: [PATCH 1/1] iommu/vt-d: Add set_dev_pasid callbacks for default
 domain
Thread-Index: AQHYf6GWvMc4HxovbUuxK/w7aTPg8K1ORtLggAANygCAAAb88A==
Date:   Tue, 14 Jun 2022 05:36:57 +0000
Message-ID: <BN9PR11MB5276DF2C87451A1164A995FB8CAA9@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220614034411.1634238-1-baolu.lu@linux.intel.com>
 <DM4PR11MB5278EBE8FA26185D91ACCD118CAA9@DM4PR11MB5278.namprd11.prod.outlook.com>
 <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
In-Reply-To: <2d2a52db-70a8-788e-fedc-197789caa145@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 94ce135c-9ce9-427f-ccb3-08da4dc7e581
x-ms-traffictypediagnostic: DM6PR11MB4345:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <DM6PR11MB4345D667F681DFEA1C6E7B198CAA9@DM6PR11MB4345.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QX8ulOFitVA98GqMfuPypcDG6WrpRXeg+9HdH0BTUaUq1Os4mrYEbImOo0hFGoBkA37A3S5I49YcyEemoyJIvQPEtY0Z/a/gkf8OSnHubviJZDPXj50ga/yOndcB+UBLtq/Fp2LaYZ2RJAH96fUIZfzU2s+9DOtoCoA2usLyW4p+oZT5Sibmd0+YTG+wuhqKtkW8xwFAH1I9lmW8PzQx9TGbUyyrXuPucNVp6AaABs2Fnx2fE6G1c368KhVMMya9PuSlKhfM9Emux4MfK+ccDyU4pkSY6+MgL/o9DxZx9ZJ4saEbX+StAK7vqsjMlbHpQ+4ZVmpY70VoX+jz6VzGZHiDphVnpH5yaQLF941CS7OlNQ75UY2qEs2saUI9GNNk3BQm69cPJntNi2uCxmA7NGRQBCvnObAdkJwSBnIXBPe/jWlwsyywC0GPqIbpjH5ZVwdeCjg9yrvbhUuLWTtKzzJCW7kI71a37lGRMJd6Dh9+Ce+0WS3GSWZRhcxBMyyFQHDQC8HFLWapNT1jxmWrI6O0OnSyOsQV4VlUJxrgCzCc9xWClq7dr6x/Mii/X/ZaQwxD9lIv3XX3k8dYjlXgSlbgz3rozJmm2OdPMJ+p6omk2lQ3rRQDAFs4875qbgo4A+Sa4LL5XNYiWWI3ByU7mPupLokIlGsPOzNqa34yRQ7Q6kYwTjnHGcsCbwyzEFT/MzDJU5qwrwVZlihApaCbeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(38100700002)(86362001)(9686003)(26005)(8936002)(122000001)(508600001)(316002)(52536014)(2906002)(33656002)(55016003)(5660300002)(82960400001)(76116006)(38070700005)(186003)(66946007)(4326008)(64756008)(66476007)(8676002)(66446008)(66556008)(54906003)(110136005)(7696005)(53546011)(6506007)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2pBd3N3SlJRRzlhY0Y2Z2dRUk45b2dYQyt5NS80aGdZYkRVSWt0amlObHh0?=
 =?utf-8?B?a1JEeDB6WE5jU2t4TkQ3MDNvUHowM0dkSTFORWdJY0V2cjRNTWd0ZGlXYUxB?=
 =?utf-8?B?eHgzYk5ZMkQwc1VzTFIvTHNzaXlPbHV6NTNwUUgvMDU0QmhiU1pzaDAzTFZB?=
 =?utf-8?B?VUV2N0dCRUl3SmoxNUh6RzI4all0WnlPcUhUalRDMjU4aEtZbFVoTEtmY3Bm?=
 =?utf-8?B?UG1Dd3RpRGhhdmdEcXdtQm45eXlDT0JUUVN3ZnQrMXVqT2RVeU03cjBCeWNN?=
 =?utf-8?B?TTM4c1VjcGNBL0VXM01HR1ZLY28xeGxSSWdLM0lyTytWZlVTNWsvQWlsY0NQ?=
 =?utf-8?B?eHBPRjh1eVRhSkgvNUsxVzJzc1N5RGdhbzhWMG0vUVBESWRveG5VdXZMSHd1?=
 =?utf-8?B?MXdWK1FqbEZWREtZTHlVK0hNc0crZ2dCL3g5K0ZNTDdZQzNTay9Qc1dHMEZm?=
 =?utf-8?B?YzczdnQvNmN6NG9UMFFPK1NnU0tKWDdkcWo2TUlmVVBDYkVLRHFIOUhsUUlH?=
 =?utf-8?B?MXhiVk03VWV0Tk5SMXVWZWR2ZGN1RkVYRS9qTWJyQUE4LzMvRUVjSlEzQ0tv?=
 =?utf-8?B?VWdoQTBqZm1XRy9PcUVQZ0NoeDNNUkxYZVp3aG5zNTdxR3l1MEMyWDJzSXpO?=
 =?utf-8?B?Y2Q0SFZLRUU4YTNjS21oRExCY01GQSsra2hPNGF1cDRYWDFRSlNkOTdvQ1NJ?=
 =?utf-8?B?RUNMcHg1Y3ViNGJQRXNwK2xGUGRhVThJK0Qxbnp5d281WXdsUmtzaWNycXJD?=
 =?utf-8?B?ZGhFWm9CUjVpM3JlMDZiQmdxclp4K25vS1JJWWxzM1AvdFNDVkpxL1A2cUtT?=
 =?utf-8?B?anBjV080b1JxN1dtcjhuVzJwakd4ZmdoZGxHNkVOWG45K05CejFXdnYzUXJk?=
 =?utf-8?B?bG5uSDBaMHl1NkRnUkk3cVlMK0tGL2c1c2R4WVloMDdGSTcvUmJNRGQxbEV0?=
 =?utf-8?B?K2w5SUZ5TVRVY3RpbFRUbmZiV21JT1VzQzI3NWdKWU95emZlUHc3cTFEN3ND?=
 =?utf-8?B?ZEJuN0JkZ0R6NlZRMXBPeDhuRWh1Mk9NOGpod1dzY2dONDRJNHZDZ25XQmQ1?=
 =?utf-8?B?dEpQY2RKb1lUR2pIT3VtajNKa0R4a3NSK1hLZFJVZXYzVVd0YUpFNi9QaENN?=
 =?utf-8?B?UHozV1ZJL1I2T3JMK0FWcjBlRnhQU0ZLMkZlMkR1ZEgydXFvbHdOSzY4emcr?=
 =?utf-8?B?Z0JIUnkrRThYOXdPSkFCZVEyOTRmTlZCbGNHb3Nhd3NFTHRtYmVuUUw5QWNH?=
 =?utf-8?B?WDliTHZWQWM0UXVIK2wySU5oc2RjU0ZiL2tHYXdMZ29JRXF5U0VjME5MbEZF?=
 =?utf-8?B?dnhaV1Z6UnF1SFJkcXdaTFN4STlSUWtKNGtiWTJocWVCSEhSZDFJeXdiamt2?=
 =?utf-8?B?aEFzQXN4elBlSVVhVnFyNmo2dXAwY05HNFRxRDM3U280QzgwcmRjTGxnVDZl?=
 =?utf-8?B?OXB0UUdQKzNWVTJNZGFZNEZzall1RzI5ck5Gc1lJOEorVjZ0UGdHdTdIOXlL?=
 =?utf-8?B?bTQxSis5aHBSTldyZ0txMEc1WFRrVFpBVWdDV1o2Ryt5RjF4VHNma09ldGV5?=
 =?utf-8?B?U3lodGFrN01DaVdtWUhnTnZmTjRDR0dDRFJYTXdweWJway9ZbjhSa1ZWRlE4?=
 =?utf-8?B?Um00dDJCTnBQajVTb2U3QTJibjNGVy94NzFxOXBWUlNPclp3SkY4cE42Q1Fk?=
 =?utf-8?B?aDY1MFBPOGtWcUpCYWNzdldjbkVodDFsN00wbkZOU21NZEppWCtJODZEVkxz?=
 =?utf-8?B?L2lBQlpNV2FlNlFZV0tjdk5wbkdscEw0SDVkelJQb2pSV1FiSXdDc0lMREQ2?=
 =?utf-8?B?WUR6WGs0akJWKzdnc2RSNEI3UWhObGFXQk1vRWNLcHBJK3Z6Z0dTMS96bkFB?=
 =?utf-8?B?a0IxVjlWamcxRitYQTBmSXE3aEhMQXp1aGRoV05IdEpYVkxUTnlmQ3paTkYz?=
 =?utf-8?B?TVp2MVQrYmJsQ1htMUwwM2lvVC8xZW9LNm5JUjVaMGdXZWVCeGV4VDBOMU5w?=
 =?utf-8?B?VHQ5MFp1YTdXY0FSMXFLRjdqMFRMZVlCU2U0WFJraGVtcVpRQy9IN3hPb2M2?=
 =?utf-8?B?LzF1bmFNMzk2SUFhSkJZeC9neGNXVzhsa2tFaG94VDYwS1pjVHBoSTdWWWda?=
 =?utf-8?B?NjlGRjdHSDhqL0ZoYmpNcDFVbHFYMHJybXFyRHYzYjE4WHdJSGVCYXlKelhq?=
 =?utf-8?B?bmlKaFo4WWRsYWdHL3ZGTkY0d1hhTkZiQzNPdkNEbEIrVDZ5cFJjU0NzazhD?=
 =?utf-8?B?dmsyRlJqWWlzd2lOZjVOQ0xRYnJ1YjJOWlNGSjJubElIb1VERXlCWU83QkND?=
 =?utf-8?B?L1JSdVlOY3hBWmRYanFYajA5c2U0c3pvczVvUmpQREhNM1NmcDFvQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ce135c-9ce9-427f-ccb3-08da4dc7e581
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 05:36:57.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eEPL1hj6g8YAAw/dQp4a2UzEO91JH8UzrxupPD+i3yKV8IcfdvGY1pUeVVN5az4f15uRAA/wt45dAoJg735/1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4345
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBUdWVz
ZGF5LCBKdW5lIDE0LCAyMDIyIDEyOjQ4IFBNDQo+IA0KPiBPbiAyMDIyLzYvMTQgMTI6MDIsIFRp
YW4sIEtldmluIHdyb3RlOg0KPiA+PiBGcm9tOiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50
ZWwuY29tPg0KPiA+PiBTZW50OiBUdWVzZGF5LCBKdW5lIDE0LCAyMDIyIDExOjQ0IEFNDQo+ID4+
DQo+ID4+IFRoaXMgYWxsb3dzIHRoZSB1cHBlciBsYXllcnMgdG8gc2V0IGEgZG9tYWluIHRvIGEg
UEFTSUQgb2YgYSBkZXZpY2UNCj4gPj4gaWYgdGhlIFBBU0lEIGZlYXR1cmUgaXMgc3VwcG9ydGVk
IGJ5IHRoZSBJT01NVSBoYXJkd2FyZS4gVGhlIHR5cGljYWwNCj4gPj4gdXNlIGNhc2VzIGFyZSwg
Zm9yIGV4YW1wbGUsIGtlcm5lbCBETUEgd2l0aCBQQVNJRCBhbmQgaGFyZHdhcmUNCj4gPj4gYXNz
aXN0ZWQgbWVkaWF0ZWQgZGV2aWNlIGRyaXZlcnMuDQo+ID4+DQo+ID4NCj4gPiB3aHkgaXMgaXQg
bm90IHBhcnQgb2YgdGhlIHNlcmllcyBmb3IgdGhvc2UgdXNlIGNhc2VzPyBUaGVyZSBpcyBubyBj
b25zdW1lcg0KPiA+IG9mIGFkZGVkIGNhbGxiYWNrcyBpbiB0aGlzIHBhdGNoLi4uDQo+IA0KPiBJ
dCBjb3VsZCBiZS4gSSBqdXN0IHdhbnRlZCB0byBtYWludGFpbiB0aGUgaW50ZWdyaXR5IG9mIElu
dGVsIElPTU1VDQo+IGRyaXZlciBpbXBsZW1lbnRhdGlvbi4NCg0KYnV0IGxldCdzIG5vdCBhZGQg
ZGVhZCBjb2RlLiBhbmQgdGhpcyBwYXRjaCBpcyBhY3R1YWxseSBhIHJpZ2h0IHN0ZXANCnNpbXBs
eSBmcm9tIHNldF9kZXZfcGFzaWQoKSBwLm8udiBoZW5jZSB5b3Ugc2hvdWxkIGluY2x1ZGUgaW4g
YW55DQpzZXJpZXMgd2hpY2ggZmlyc3QgdHJpZXMgdG8gdXNlIHRoYXQgaW50ZXJmYWNlLg0KDQo+
IA0KPiA+DQo+ID4+ICsvKiBQQ0kgZG9tYWluLXN1YmRldmljZSByZWxhdGlvbnNoaXAgKi8NCj4g
Pj4gK3N0cnVjdCBzdWJkZXZfZG9tYWluX2luZm8gew0KPiA+PiArCXN0cnVjdCBsaXN0X2hlYWQg
bGlua19kb21haW47CS8qIGxpbmsgdG8gZG9tYWluIHNpYmxpbmdzICovDQo+ID4+ICsJc3RydWN0
IGRldmljZSAqZGV2OwkJLyogcGh5c2ljYWwgZGV2aWNlIGRlcml2ZWQgZnJvbSAqLw0KPiA+PiAr
CWlvYXNpZF90IHBhc2lkOwkJCS8qIFBBU0lEIG9uIHBoeXNpY2FsIGRldmljZSAqLw0KPiA+PiAr
fTsNCj4gPj4gKw0KPiA+DQo+ID4gSXQncyBub3Qgc3ViZGV2LiBKdXN0IGRlditwYXNpZCBpbiBp
b21tdSdzIGNvbnRleHQuDQo+IA0KPiBIb3cgYWJvdXQgc3RydWN0IGRldmljZV9wYXNpZF9pbmZv
Pw0KPiANCg0KdGhpcyBpcyBiZXR0ZXIuDQo=
