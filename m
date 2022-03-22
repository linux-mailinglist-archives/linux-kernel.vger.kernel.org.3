Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8615E4E3C68
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbiCVK0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbiCVKZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:25:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96DB13DCE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647944670; x=1679480670;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gAAaW5xH0rrISTRWxmuQlr10ncG6IJoy3VUipW1uf9I=;
  b=anJfK3NJaw5FLqhEdPzBmFRscrv+F82n1SoKEoVLGTGC0vJD9nXosZL+
   jmusk3QN9EDHyiMbUfOHJvhnAH6ud02X/DJFNFABR7bckX/bcbRelZP8z
   GSrFOFtIdIuixoM3A/G/BqXScxPtQMJgJKFeNTl5TxleM8QHEa6pJaLXb
   YmOHjTP8mkIYtJaXf+o2J8uZ+tvDYvd/5rm4PBB9+vx+5ZSKZTfUBIe6h
   xrZQSBaeDmbRV5UTB29QJN6MDt1W3tk4DOBAiSCzTBDoVOypsPPZdCAUh
   J7YO18Y42LxivjidABQWYL3dPKNVZXPm4RfpaxkUbIJcr3UHC7wv11Z2a
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="239938783"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="239938783"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 03:24:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="560320276"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga008.jf.intel.com with ESMTP; 22 Mar 2022 03:24:28 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 22 Mar 2022 03:24:28 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 22 Mar 2022 03:24:28 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 22 Mar 2022 03:24:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GszgwLOSHuWx7lyY2mxvgGofRlr4zksAPcwJ/OQTdzGiTR6PjuUyC+qAaOdVIt8bBWIRBwPlGNYRuXy3/C1GqdpMEvn8Eded07tP9N8SuTXoGAJ/Mf7ASzOq+jWlJ4Qwp4TmONKp9Yk65qektMqWLff4gXS2Wt29j8EPfkayWoQDd5Sx0EfwxDRc3S0kXYGdbjFxcjvZyrIN6GeQT+8LvuSXJtMJVBotOxJjuiP4AQqgmFWMp9DOWYUJj2yUwEO9fjnsAbjpf1ynl+evqrxG23lXZbAOPPlYNddnQVIkF3o6+WxPGA9f1LiPoumLqX81HrTlXUKNqN1lh5s/gbqBSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gAAaW5xH0rrISTRWxmuQlr10ncG6IJoy3VUipW1uf9I=;
 b=nGPLPqEHOINsUZo9a7A/jkd3SxWg40Gvrx+TYxXqoDuNlxNa5PnICh6j0aL/wWRJpJx+HbGwU0bGF79yzqUY315Vt1QxD/mjD43FKcYJfbtVXk4oDnO5LNoMCX/AKW+yI819fWbA+sSSSKJxAZ0yATP8HN3NLmL/jXHceQhVkysxtM/tHD9SSFUAVZaRbHgoaKsNLB3DLWVc5RsIU3i+3FSmOeY1TG08JPkccfTfjxywQBg2mVE+PkQMg84AQo3NUhR7fqT2JOnVv/pOqGZE/NbL3+OPJBCrjb/9T2TmLiBwjX/sGlrbNmvg8oG9K2PaGzDQHYYIunS/0UF7VkUdVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BYAPR11MB3399.namprd11.prod.outlook.com (2603:10b6:a03:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Tue, 22 Mar
 2022 10:24:26 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::4df7:2fc6:c7cf:ffa0%4]) with mapi id 15.20.5081.023; Tue, 22 Mar 2022
 10:24:26 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
CC:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Thread-Topic: [PATCH RFC 10/11] iommu: Make IOPF handling framework generic
Thread-Index: AQHYPCXJ2tlsQR7+N0uG4LpIf9YVg6zJfVAQgAA70QCAAN2a8IAAmeYAgAABAlA=
Date:   Tue, 22 Mar 2022 10:24:26 +0000
Message-ID: <BN9PR11MB5276642FF0D53AE7773B5B718C179@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220320064030.2936936-1-baolu.lu@linux.intel.com>
 <20220320064030.2936936-11-baolu.lu@linux.intel.com>
 <BL1PR11MB5271DE11A868204D2E0D5B548C169@BL1PR11MB5271.namprd11.prod.outlook.com>
 <YjhkmDEGwF4EcM8R@myrica>
 <BN9PR11MB52769EBCAE7E3EBB6D6AF1328C179@BN9PR11MB5276.namprd11.prod.outlook.com>
 <YjmflimaXyM/IZhk@myrica>
In-Reply-To: <YjmflimaXyM/IZhk@myrica>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f4f51f02-ac5f-4f98-0794-08da0bee2423
x-ms-traffictypediagnostic: BYAPR11MB3399:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR11MB3399DB51D130DC3CEE9B7C158C179@BYAPR11MB3399.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0c0sld/F2voW0icaoNMRJL10OS8Vc0pDv0mwx4z9gkJ/EWSoUMd6uxKCs82tTRi2HboezZwIu1gaHJ6vovRMCqQxCiAIOpd3akLR1nRHzc0EdLokSkb+rlAGSCZvdXNJS7BVBHZtG9PMOJcR4iO8dn6QcTXkSct2a/PIDQMsinVRKlavwrXe+/N4Q0V3960yacNdD480mTEls4GqBYXWxGrwSTC3XQbOHffvKGEMXYAh5PwDP0mHEUAUmvR4qhQY8wzR2FEo2xQQAvzka+Va2mKuYOQacGP/ztpSipgkLGVFL9bdJmw4R+2ftasaqWldEyQ4+Qipk3q+JAHmmI+i2vrZDM+Okse0wc07MTzHSYGCOsx43zyKwEuSHAZaygIJtcghDJny+3tfIBJ3C7NO8TgHjJVAyn4A/xXhrK46Z31qidTlwzblTYsn3srkLIZ5pAVWAQg/6gI3CvQ7DY8qQIcK1sSKS2/Tj/qclYpjkXImPL8ZzHX7ezVizk8x44mCeGwKHUZ02J3O55UApQ4jHRoUjmNiiC6VszNMQ/MjV2MU/oOsTBNAhobn/QYPsn5QPm7Ihzne7CbuoTvaRJP84QnYcYadfZRKlZFC3f7hOD8XREbW4xPIBlzc2QUpXVQ5aa3MYuzXXZ4N21OKE1iHkV41FWoTbaog6BJCpZ4w9jelnAdbNKP+nx3zvE5WNFlnvDdXamgM4ifeKBAfB9jGrZHYFDu2EAPsX0rMza2lXTw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(82960400001)(316002)(55016003)(38100700002)(9686003)(7416002)(54906003)(7696005)(6506007)(6916009)(33656002)(122000001)(26005)(5660300002)(186003)(86362001)(52536014)(66946007)(4326008)(2906002)(71200400001)(38070700005)(508600001)(8936002)(66446008)(64756008)(83380400001)(66476007)(8676002)(66556008)(76116006)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXpSeVNFQjdWZE14RWI3U3p0RVhRQi9raEZQa05vMm9CYW43M1d2NTBaSmZ3?=
 =?utf-8?B?dEhNTkdNa2JJOXc1cVlXQVdTaWp2TDJmeWp1U1FhVHVuaGNka1BNZnBPcXNs?=
 =?utf-8?B?cXdqUnRtWFA1RmRKa3RGdmlvOCs4VENOSHpHT0JqVnRQdU1ta1NDblBEODVm?=
 =?utf-8?B?QjJ1TlpXZDVzSGZML3FXbE11TGJxV0J6Mll2bmEwcVVXMVpyMVNVZDRBb0xI?=
 =?utf-8?B?dm5mNDZHSFg0OWFLZS9VVW1iSFBEZ0dvVEdMd3UrOFJhQmN5cGNwdmZqNlJh?=
 =?utf-8?B?akt3QStveDNhMTArMk1kYmJPSFZtdmgvYU1za09FUERZOGY3b2w3QnovR0sv?=
 =?utf-8?B?WWlvVlpXd2k4eWRIYzB5YTZHb2t1NlJmTGVESXhlTkdKS3IyUlRtQ0IzL1Vs?=
 =?utf-8?B?SW5iMmZhRnVrVUZ2ci9sbnNQYmdSdFpGQUQxTExJckZLVlVuZE1BbS9GTklL?=
 =?utf-8?B?MUdLaHRvTlpKQ25hSlRWZmp5bytwQkUxOVREVnBLMTZ3UVVVeTE2bTM1ckdM?=
 =?utf-8?B?WVliU1l1VnYzeThWWkZtNDRBd1Y0MHJCQlAvOVlFcVFKU01zOEEyUlVnWW5x?=
 =?utf-8?B?M0F0bW9OMGlGZW1SVnRMYmlQc0ZQWVZBU3dpcXNwQ25JWGNDK2xvdG55UUFS?=
 =?utf-8?B?bFBYVmZpZmg5VGZwNXRWZ2tjWGU4VGtyWUhDZGtOSjdOdDdKSFNsRmNkU3hp?=
 =?utf-8?B?aitubGcxY1JUL0VMaWhGcWNMOG96ZndSckZCY1JzQm5wZXZjNmVibnNkd25M?=
 =?utf-8?B?TE9pdmwzM2swM0kvL045RFRvUEJ4Z3RDR2RHbDhWWnZEVGpOVHh4dkR3UTlx?=
 =?utf-8?B?VHp5Tjk5NzloWEg3ZHVwVmw4WTBIQVB0TGI1L0pOMGN6OXZ1aEpLQ2ZvTHpl?=
 =?utf-8?B?dUFOREV2MGRYK01SMExKcmNIbzU2bk9pelR1ZzFON2UzckloVFYzOTBUeGJS?=
 =?utf-8?B?eXVHdlROWDVZYTFBMWswUFhTVlQrQlErb1FaUWora3hVQXI5dWI2cngvREwz?=
 =?utf-8?B?VUdLV0sxdjIwOUZBTFZzRlJiTXRWakg1N09WVHlzMzRwNnU2VXZiR0d5ZDFs?=
 =?utf-8?B?VFNlaWZrZEN5M3VGV2phd2NBbWlROHZQbmp1MGQ4eG9LYmlrZ0Zvd1F0ODZk?=
 =?utf-8?B?dEZ6SngxN2pNQ3NsUUFFbVgrWDFyQUpXNW9lZU9zV1NZaVlKK0wvZWkwVFVQ?=
 =?utf-8?B?WVNTK2VtSzdZNENRcU1HOGNoNm8wZjc2QXRxR3h1bVpBcVVJb1NjanZqbUJn?=
 =?utf-8?B?aGgxZFRieGl1dElGc1AyNWRTdWNMQ3BGWXJsS3B6K2NvN2pPaHVxUVZlNGxL?=
 =?utf-8?B?cXZxbnROb0lYdlQvcmgzV1Vyb3RjY1RlWUthTUJNdzdRSW5vRGFkRWFUNmtu?=
 =?utf-8?B?VXRsUnlQY0k5ZkJtditiNnFyZW1HeVNDZ1NCYzUrRXVUekt2Mk9RRFNUL1Qy?=
 =?utf-8?B?ckdmb0Q1Z0xSK0FrRHpScklJWGlpZ3JrQmlzUmdycU5zSFg5Z2F2Ui9OWGZW?=
 =?utf-8?B?WkhHMlBjUnhEWnhmcThiZG4yOFpRQ1pZR3I4TGhIL2x1YW9FS1BFaVFrQWhh?=
 =?utf-8?B?eTFlZGJKbjR5eUdoQi93L0tWaWpmQlF0NDJNN1RVeDFyQURjN1IvUFZzYzdP?=
 =?utf-8?B?em1YL3VaS0ppL1dZREIvbFNoc0VPY1BVQWtHekEyQWp4c3gxR2FNZ1ExYTNO?=
 =?utf-8?B?RzhyY1M3UmZ0TkZ0T1JHR1VmTFJpa3VYMlJKaW80TWtWUlYxMjMrUWU3ejEx?=
 =?utf-8?B?UTFacXoyQU93c1p4NW13REo3ZldtdzcvWnQ1TUlPcUdHQTAwa0FjbWNTMkMz?=
 =?utf-8?B?Q2pJVWl1bTNrRkp1SUdQem5XL21HMy9IcXVRWmZuVTh4cGdmVGV3MW84T0pu?=
 =?utf-8?B?elczV09SMmRJQ1VsYjFFSWkweFhEd0tQVnhFRFVsNzMxcWZaQnhzNlN4Z0ly?=
 =?utf-8?Q?l6adpUmqNVM2GJ5LywRZjzqjOHS0Ag6U?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f51f02-ac5f-4f98-0794-08da0bee2423
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 10:24:26.1506
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uF18j6r9cNXKeGXfNffUm6YaTbscUUXFxlm/6P9KoXwqv5s+Zy51vb+dsCruxlO4b4ZPVURbDryZouBNVaeXhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3399
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4N
Cj4gU2VudDogVHVlc2RheSwgTWFyY2ggMjIsIDIwMjIgNjowNiBQTQ0KPiANCj4gT24gVHVlLCBN
YXIgMjIsIDIwMjIgYXQgMDE6MDA6MDhBTSArMDAwMCwgVGlhbiwgS2V2aW4gd3JvdGU6DQo+ID4g
PiBGcm9tOiBKZWFuLVBoaWxpcHBlIEJydWNrZXIgPGplYW4tcGhpbGlwcGVAbGluYXJvLm9yZz4N
Cj4gPiA+IFNlbnQ6IE1vbmRheSwgTWFyY2ggMjEsIDIwMjIgNzo0MiBQTQ0KPiA+ID4NCj4gPiA+
IEhpIEtldmluLA0KPiA+ID4NCj4gPiA+IE9uIE1vbiwgTWFyIDIxLCAyMDIyIGF0IDA4OjA5OjM2
QU0gKzAwMDAsIFRpYW4sIEtldmluIHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEx1IEJhb2x1IDxi
YW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gU2VudDogU3VuZGF5LCBNYXJjaCAy
MCwgMjAyMiAyOjQwIFBNDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBUaGUgZXhpc3RpbmcgSU9QRiBo
YW5kbGluZyBmcmFtZXdvcmsgb25seSBoYW5kbGVzIHRoZSBJL08gcGFnZSBmYXVsdHMNCj4gZm9y
DQo+ID4gPiA+ID4gU1ZBLiBHaW52ZW4gdGhhdCB3ZSBhcmUgYWJsZSB0byBsaW5rIGlvbW11IGRv
bWFpbiB3aXRoIGVhY2ggSS9PDQo+IHBhZ2UNCj4gPiA+IGZhdWx0LA0KPiA+ID4gPiA+IHdlIGNh
biBub3cgbWFrZSB0aGUgSS9PIHBhZ2UgZmF1bHQgaGFuZGxpbmcgZnJhbWV3b3JrIG1vcmUNCj4g
Z2VuZXJhbA0KPiA+ID4gZm9yDQo+ID4gPiA+ID4gbW9yZSB0eXBlcyBvZiBwYWdlIGZhdWx0cy4N
Cj4gPiA+ID4NCj4gPiA+ID4gIm1ha2UgLi4uIGdlbmVyaWMiIGluIHN1YmplY3QgbGluZSBpcyBr
aW5kIG9mIGNvbmZ1c2luZy4gUmVhZGluZyB0aGlzIHBhdGNoDQo+IEkNCj4gPiA+ID4gdGhpbmsg
eW91IHJlYWxseSBtZWFudCBjaGFuZ2luZyBmcm9tIHBlci1kZXZpY2UgZmF1bHQgaGFuZGxpbmcg
dG8gcGVyLQ0KPiA+ID4gZG9tYWluDQo+ID4gPiA+IGZhdWx0IGhhbmRsaW5nLiBUaGlzIGlzIG1v
cmUgYWNjdXJhdGUgaW4gY29uY2VwdCBzaW5jZSB0aGUgZmF1bHQgaXMgY2F1c2VkDQo+IGJ5DQo+
ID4gPiA+IHRoZSBkb21haW4gcGFnZSB0YWJsZS4g8J+Yig0KPiA+ID4NCj4gPiA+IEkgdGVuZCB0
byBkaXNhZ3JlZSB3aXRoIHRoYXQgbGFzdCBwYXJ0LiBUaGUgZmF1bHQgaXMgY2F1c2VkIGJ5IGEg
c3BlY2lmaWMNCj4gPiA+IGRldmljZSBhY2Nlc3Npbmcgc2hhcmVkIHBhZ2UgdGFibGVzLiBXZSBz
aG91bGQga2VlcCB0aGF0IGRldmljZQ0KPiA+ID4gaW5mb3JtYXRpb24gdGhyb3VnaG91dCB0aGUg
ZmF1bHQgaGFuZGxpbmcsIHNvIHRoYXQgd2UgY2FuIHJlcG9ydCBpdCB0byB0aGUNCj4gPiA+IGRy
aXZlciB3aGVuIHRoaW5ncyBnbyB3cm9uZy4gQSBwcm9jZXNzIGNhbiBoYXZlIG11bHRpcGxlIHRo
cmVhZHMgYm91bmQNCj4gdG8NCj4gPiA+IGRpZmZlcmVudCBkZXZpY2VzLCB0aGV5IHNoYXJlIHRo
ZSBzYW1lIG1tIHNvIGlmIHRoZSBkcml2ZXIgd2FudGVkIHRvDQo+ID4gPiBzaWduYWwgYSBtaXNi
ZWhhdmluZyB0aHJlYWQsIHNpbWlsYXJseSB0byBhIFNFR1Ygb24gdGhlIENQVSBzaWRlLCBpdCB3
b3VsZA0KPiA+ID4gbmVlZCB0aGUgZGV2aWNlIGluZm9ybWF0aW9uIHRvIHByZWNpc2VseSByZXBv
cnQgaXQgdG8gdXNlcnNwYWNlLg0KPiA+ID4NCj4gPg0KPiA+IGlvbW11IGRyaXZlciBjYW4gaW5j
bHVkZSB0aGUgZGV2aWNlIGluZm9ybWF0aW9uIGluIHRoZSBmYXVsdCBkYXRhLiBCdXQNCj4gPiBp
biBjb25jZXB0IHRoZSBJT1BGIHNob3VsZCBiZSByZXBvcnRlZCBwZXIgZG9tYWluLg0KPiANCj4g
U28gSSBkb24ndCByZW1lbWJlciB3aGVyZSB3ZSBsZWZ0IG9mZiBvbiB0aGF0IHRvcGljLCB3aGF0
IGFib3V0IGZhdWx0DQo+IGluamVjdGlvbiBpbnRvIGd1ZXN0cz8gIEluIHRoYXQgY2FzZSBkZXZp
Y2UgaW5mbyBpcyBtb3JlIHRoYW4ganVzdA0KPiBkaWFnbm9zdGljLCBmYXVsdCBpbmplY3Rpb24g
Y2FuJ3Qgd29yayB3aXRob3V0IGl0LiBJIHRoaW5rIHdlIHRhbGtlZCBhYm91dA0KPiBwYXNzaW5n
IGEgZGV2aWNlIGNvb2tpZSB0byB1c2Vyc3BhY2UsIGp1c3Qgd2FudCB0byBtYWtlIHN1cmUuDQo+
IA0KPiA+IGFuZCBJIGFncmVlIHdpdGggSmFzb24gdGhhdCBhdCBtb3N0IHdlIGNhbiBzZW5kIFNF
R1YgdG8gdGhlIGVudGlyZSB0aHJlYWQNCj4gPiBncm91cCBzaW5jZSB0aGVyZSBpcyBubyB3YXkg
dG8gYXNzb2NpYXRlIGEgRE1BIGJhY2sgdG8gYSB0aHJlYWQgd2hpY2gNCj4gPiBpbml0aWF0ZXMg
dGhlIERNQS4NCj4gDQo+IFRoZSBwb2ludCBpcyBwcm92aWRpbmcgdGhlIG1vc3QgYWNjdXJhdGUg
aW5mb3JtYXRpb24gdG8gdGhlIGRldmljZSBkcml2ZXINCj4gZm9yIGRpYWdub3N0aWNzIGFuZCBk
ZWJ1Z2dpbmcuIEEgcHJvY2VzcyBvcGVucyBtdWx0aXBsZSBxdWV1ZXMgdG8NCj4gZGlmZmVyZW50
IGRldmljZXMsIHRoZW4gaWYgb25lIG9mIHRoZSBxdWV1ZXMgaXNzdWVzIGludmFsaWQgRE1BLCB0
aGUNCj4gZHJpdmVyIHdvbid0IGV2ZW4ga25vdyB3aGljaCBxdWV1ZSBpcyBicm9rZW4gaWYgeW91
IG9ubHkgcmVwb3J0IHRoZSB0YXJnZXQNCj4gbW0gYW5kIG5vdCB0aGUgc291cmNlIGRldi4gSSBk
b24ndCB0aGluayB3ZSBnYWluIGFueXRoaW5nIGZyb20gZGlzY2FyZGluZw0KPiB0aGUgZGV2aWNl
IGluZm9ybWF0aW9uIGZyb20gdGhlIGZhdWx0IHBhdGguDQo+IA0KDQpJbiBjYXNlIEkgZGlkbid0
IG1ha2UgaXQgY2xlYXIsIHdoYXQgSSB0YWxrZWQgYWJvdXQgaXMganVzdCBhYm91dCBoYXZpbmcg
aW9tbXUNCmNvcmUgdG8gcmVwb3J0IElPUEYgcGVyIGRvbWFpbiBoYW5kbGVyIHZzLiBwZXIgZGV2
aWNlIGhhbmRsZXIgd2hpbGUgdGhpcw0KZGVzaWduIGNob2ljZSBkb2Vzbid0IGNoYW5nZSB3aGF0
IHRoZSBmYXVsdCBkYXRhIHNob3VsZCBpbmNsdWRlIChkZXZpY2UsDQpwYXNpZCwgYWRkciwgZXRj
LikuIGkuZS4gaXQgYWx3YXlzIGluY2x1ZGVzIGFsbCB0aGUgaW5mb3JtYXRpb24gcHJvdmlkZWQg
YnkgdGhlDQppb21tdSBkcml2ZXIgbm8gbWF0dGVyIGhvdyB0aGUgZmF1bHQgaXMgcmVwb3J0ZWQg
dXB3YXJkcy4NCg0KZS5nLiB3aXRoIGlvbW11ZmQgaXQgaXMgaW9tbXVmZCB0byByZWdpc3RlciBh
IElPUEYgaGFuZGxlciBwZXIgbWFuYWdlZA0KZG9tYWluIGFuZCByZWNlaXZlIElPUEYgb24gdGhv
c2UgZG9tYWlucy4gSWYgbmVjZXNzYXJ5LCBpb21tdWZkIGZ1cnRoZXINCmZvcndhcmRzIHRvIHVz
ZXJzcGFjZSBpbmNsdWRpbmcgZGV2aWNlIGNvb2tpZSBhY2NvcmRpbmcgdG8gdGhlIGZhdWx0IGRh
dGEuDQoNClRoYW5rcw0KS2V2aW4NCg==
