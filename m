Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20FF57FA62
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 09:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiGYHlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 03:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbiGYHl2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 03:41:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289C8CE2E
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 00:41:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658734887; x=1690270887;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=nTGSqBysm5OfOyGISceqMLzr1GePdGG75ExVdspD+a8=;
  b=LggVg0hX42kBcLbAIZaaAZUuLzD2Iu4zCIWbWWpnhTRQw3J7cRSCOXv1
   Ye2C0TCSqC3TmaS5n/nb8qay/Hme4aPQgav7FKGCD392ZIxhnrTnNqeo/
   Bqu/oABrFmp+0UfjkwON/9c9CWPQoh1Budoo+GjaqYIHIzj5qpzdGX9HU
   VtWzXqzlmUoxR+9CNV6SE8bOT9Vank+HFtAFatBYY/GqIsC0eKiAG82y9
   DRM8JiXkrEVZ0yc/89b6QXuIzDu18PY9B6hOXXtjZ2K+RobeEtO5Jv5TO
   CP5ckRuE6lJ+2HlMDtGcId275qDYTyNwZPzgCdMtnC/ZONoOECbOk7KS8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="285184576"
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="285184576"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2022 00:40:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,192,1654585200"; 
   d="scan'208";a="627347888"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga008.jf.intel.com with ESMTP; 25 Jul 2022 00:40:26 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 25 Jul 2022 00:40:25 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 25 Jul 2022 00:40:25 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Mon, 25 Jul 2022 00:40:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NV3pakoh/eIBmvFkDHFkXrcmkDIHBvMK0uBqxn2I6eyYmsS+tcclPXsOAU8mkdZXvouvucU9IXn/xAn9dDtDchF4hQjzalXi/M0LSk7uAT3KANxqFbny1nMuFDK7qyeJbvbE97xOc7z3vEzgF9i7E9ewCpCBW41LEi9mx4NTjck71gX74BhWmBv+LS54lsxmBdjT0imq+WTT8qfaBGtiNoKy7cGo29WFwDW3eZIjWGbzGXxNfqWy7I0sLNwdzf2Daugi/zyhlFnJhUQbqN1WZIrVj8ZBNB1fHtH+rj4McJJMJEy7e8D52hF2KgpoSpMgJkLhUokZKFeJfiJTz14nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nTGSqBysm5OfOyGISceqMLzr1GePdGG75ExVdspD+a8=;
 b=MVFBRZpcO68Yi6z/f8ly3P34+ahjPOdUdEGsWN0wtOYIDOhqMnzIyLd0bjRTXNESRhybP17NWuTe2yZrE0CL23RwLo/WyiFgniN8uHRj9zyDtX9AjaT0wy4B+NXseAjDMYD3qDGZ7Ks/+OWm6aAQZ+JIHQGa9QwABAehqkN30j8mM5ca8+sKmAbFIVTguYmdaxGvV+hnM4dijOGQZueDmKLPKXcUHhvg66P2dLUS6BP90nEv7F146iO9Jn/1tl1WxopJDiMWtc7EijQ/jm/mgReqx6j3Syt7ykyJQ76sKWW0/SF2twv3u5lrH8c6hPfbDAgV61v3v7zjdnRSh24z+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by BY5PR11MB4038.namprd11.prod.outlook.com (2603:10b6:a03:18c::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Mon, 25 Jul
 2022 07:40:22 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::8435:5a99:1e28:b38c%2]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 07:40:22 +0000
From:   "Tian, Kevin" <kevin.tian@intel.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
CC:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Thread-Topic: [PATCH 1/1] iommu/vt-d: Fix possible recursive locking in
 intel_iommu_init()
Thread-Index: AQHYmwJBYp2710JQ30Cl1E4c+WdJBq2Ic2JwgARpZwCAAeCH4A==
Date:   Mon, 25 Jul 2022 07:40:22 +0000
Message-ID: <BN9PR11MB52765FEEC0ED0EAB5D691FA38C959@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20220718235325.3952426-1-baolu.lu@linux.intel.com>
 <BN9PR11MB5276287E75395A59865812978C919@BN9PR11MB5276.namprd11.prod.outlook.com>
 <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
In-Reply-To: <8e970367-746e-0e74-ba39-e941fdbfdab7@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ce296778-589d-40f7-f105-08da6e10ee3c
x-ms-traffictypediagnostic: BY5PR11MB4038:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ESlZfSDd8hwkPBcOOq1IYPZHyHjdpY+3ASXPKFgMUxWhcmXp37ILSQuiSahIesj9r54EXe4tOdlmv3eYQeTNlWbgB71WDwCVt3yi3X42GLf7W/PrADVvzBhaf3TVSYB9Sw5JZV43EgzwBVVf2euXKWMLeK06MYJQEBB5XoTbfXlB3IyQfZQZrjV/8S5joi6en5Cg2Ou89ZQvi63+fcsBh98ViQrNIMgT1dW3ZOOanHJmUPdHo2NxUMmEODVYW1Cj/6NCoa0kAqRzYiunXh0L/Yb5rAnTbDP+lHoo7y5ol+Wd9fh8GpMoVgv66tQAvtxSGloItDVeL5Nhh7vp/3ZSWFNnv1LScx8N2HEE8N2NcduPMJranPTQvj1QnMW+WMwHOj6vidbAlsnFBJ0dE7V3/VUxXQsNQJ/6vfUvuDqn312bR4T2MzM+UcFWe/Fu+hMbx9HgpG0uHJLyWDi1TNYny7bOqF381HoCxzif4SSnV/JTf91zYMeSFm4uCINQlOcNC+NVOg8iZpt5oAGm0mwzQOKdykj84kLFZvytvFhS4TPsoqV0pRDDzejsxOgjV+lBcJONe7jnYXviojqsFS3wnxYTIdUuq4tYmFkYMBW8oMAM4HArtZXsojXw3seeBh8x10PrFLQMiM4fdpz2kNzaBoDvWMsM1kBj5O/thb/0Gy/bl/0tolyoDnNAB7JJjlW0nozhXyRNwTLxju05fKcQOVsUIO9rDtBitHH2mIP1cCqc9E6kRacC9WZPLmF1RKeI0evvWOYyi3gnyJUbvYstrOh0LYQXQrV0hYzrjMQoD0u2WQdCRD4Kk3pt0uS3w4wp
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(366004)(39860400002)(376002)(396003)(346002)(478600001)(86362001)(54906003)(53546011)(41300700001)(7696005)(6506007)(33656002)(82960400001)(38070700005)(9686003)(26005)(316002)(186003)(71200400001)(110136005)(83380400001)(55016003)(66476007)(66446008)(64756008)(8676002)(66556008)(5660300002)(52536014)(4326008)(8936002)(76116006)(66946007)(38100700002)(4744005)(122000001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJLdm4wT3p3bEZxNDhEQ0xKdmRGdGsxSUFHUEFXd0trVTRpdlRWMWltWTRN?=
 =?utf-8?B?QXNxUXBnY3Z3Sjk0RDZ0RGhqOEc3cFNOYVZqbXdRMld5eVBzNUZqTVRrUzNB?=
 =?utf-8?B?MjRsdHdLb2NCdEEwck02Y2htc2M0cktJdk41YlVMS0x2ZW1qNW1vR1I1cW11?=
 =?utf-8?B?ZDhpNWs0VmVpT0c4b2NOa2RYTWkxZXRzS09sNWhsQmVCa29ibElYOXZ3aEt0?=
 =?utf-8?B?dkVMSlBpWTQwcjdORE5TbUxKZEpQb05teFpOS0lCSjNhUkVHUkFCNklpNlln?=
 =?utf-8?B?OEl3ZzliUzJyR0cvZUFGVElPOGUrcnFBRXlCMWR1c29FWnFad0Z5WlVEM0NC?=
 =?utf-8?B?QmxMZ2p0cCs5UWFhZnB1bHorN1RlYTJNR0tBZmNucWdkdk9od1JNR0liWUxV?=
 =?utf-8?B?cmdyanhNYW9UL0hzZG9TVmx3VjY2Y1F0NFp1S2gxWU9BVndybjRuelhrN25o?=
 =?utf-8?B?K3F1d05GenliTHBMRVVUMmVzdEM2N211TGVDcFh2TzVwbTZwZDNyb2JoQTc1?=
 =?utf-8?B?YWJjT1l2TEE2eEtxNDhPa0pKMzNhT2d3SWVMcWpGcjd3U1BRVHhxbFVhR1h5?=
 =?utf-8?B?YUFZbkkzU2I5c2hxZFJiWEwwWEZrZzUrc2QzNFc3ZXo5dzNSSFZxRG5IRkhp?=
 =?utf-8?B?YmRoeDN5RElEN3ZVNkVuT2lwZWVTbDdMeVgwM1JDREhmTnYvVW04Uy80N3Q2?=
 =?utf-8?B?QzBXR1BWd2dvcnBXNm9IYW5SOGx0V200YTRBRG9QQzdtTG12T1IvQVd4Ymta?=
 =?utf-8?B?UVpzb2dmOE5oQ1NWM2lpYkZ0UkMzeGhSZ1F6ZXpUdk1FUXFJdHUwdHRtY2lX?=
 =?utf-8?B?eXVlanFDcjhKWnU0dDNtSk52S25SWnNaVGxUSGpvWElaZ0M3b3ZldzBqdFpE?=
 =?utf-8?B?L3UzQU9jTmlMclBYb2NRN205VklaWEh1U1NTTXQxUVRqWU50cUE4ZDlGQmdr?=
 =?utf-8?B?M2swRm1sVkhRVzVqV0Fod1AzTmVuQ0RDT01pcVo0ZDN4ekxycllXY0hCbTJH?=
 =?utf-8?B?czlVa0FmQ3I5YXNCK2FSaWlnS25Fa0hZSWpqQnVZNmRFb0Q0djRwYW53QjJH?=
 =?utf-8?B?WDB0SVArZ3NSb2xzd2pqaDNwY3VubndZVm9DSUNidm9PaWFRYm96MlRKQ3VX?=
 =?utf-8?B?cm9zMkwxeXEwbVdvZ0hjSXV6M1hIN1pPRWJ3dnZKQjN5SFR6K3pTTW80VlZP?=
 =?utf-8?B?Z1Z0T0FlRTVJK21TZGpxTytxdXF2K0NMOHhwdW9iZG4xTVk5Y0NuMFdqaWlJ?=
 =?utf-8?B?b2JnbmVuaHdUUUE0T0VoQmpNcnJtTFQ4VjI4RWtYc1YvaUQwNmFoWWE5RGtt?=
 =?utf-8?B?Rkg2ZXpuT3FMVUxmWFlXV1FmZFRVRURxcHJlUmRHTW5rdnBNcDlJNGV3SEVx?=
 =?utf-8?B?UFEzOEZLV3Q5Mngzc2V2RCthSVVvOTVuVDJYSkhtb2s4VzROK3hvdXluL2tR?=
 =?utf-8?B?MjBUM0R3OFVLbDJnWUlCdmJ6KzlrakdjL0FQamtCcTNrK1crU1U2VEF2cUtK?=
 =?utf-8?B?WDFvY0tQL254d1FKTkVjRHhpNkMvMkgwVXMzTVhSdEdzdFNCK1JudVlabVNN?=
 =?utf-8?B?d3BBeFlmYUtzazN5OFFxeHlGejlwVFhrUGtQbFRJb09nRzN1d1lQR2tKNHJJ?=
 =?utf-8?B?U3d5UjVQaS80N1Q2ZmVpTGUyaDdxWm1OenZ2YlNFNDlqRzlyOHd4R2VTYVlm?=
 =?utf-8?B?dWhyYXpRdDA2RmtvbHhpZHllZEJFS0ZNWHpYZEVoUmhTRkplNGF2eDliUjM4?=
 =?utf-8?B?TXVndnM0dUpRbnFrZld1UVFMdHVURTNENnZRRGFuV2ZSZ3ZpMUxuSElLdXBY?=
 =?utf-8?B?N1Z0RVRxNGUwQmJwR0psSGY5ajREOHMzZG5Tb092OHFBMVJPQ2E0Sm01TGlR?=
 =?utf-8?B?eTU1dnB2SlphMVhkL0NQOXp2ZGhDNVQ1dlFUNk9pb0lURGR1eEJhVHJQNHBZ?=
 =?utf-8?B?OUxXS0t1QnFVOHZCMzd1Z3c0bU9jV1VIbEZJbHRHcFFJSGhXNTNzZWwycjVy?=
 =?utf-8?B?MXBsdzFxalhxWWNMZzhqd013WTdPSER0NWNzZU9LQTVlL0dqMlUyNmx4WDFk?=
 =?utf-8?B?R3BVeXNmQjVBSmN2QkpjR2d6aldFZUh1QkdsYUNRR3VNVFBKUHI2bW0vVVhw?=
 =?utf-8?Q?1B0eX09zLiT5AsJFww0NCV+0X?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce296778-589d-40f7-f105-08da6e10ee3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 07:40:22.1381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fn7XocjSbz0L1Yqzji/uonRHb0W4WRkV+M2GNppZD3QamK2X/e2HYjrE4MsOOkBw9LKRf9v4w1sQ1fyHuoELmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4038
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBGcm9tOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBTdW5k
YXksIEp1bHkgMjQsIDIwMjIgMTE6MDAgQU0NCj4gDQo+IEhpIEtldmluLA0KPiANCj4gT24gMjAy
Mi83LzIxIDE1OjM5LCBUaWFuLCBLZXZpbiB3cm90ZToNCj4gPj4gRnJvbTogTHUgQmFvbHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gPj4gU2VudDogVHVlc2RheSwgSnVseSAxOSwgMjAy
MiA3OjUzIEFNDQo+ID4+DQo+ID4+IEBAIC04OCw3ICs4OSw4IEBAIGV4dGVybiBzdHJ1Y3QgbGlz
dF9oZWFkIGRtYXJfZHJoZF91bml0czsNCj4gPj4gICBzdGF0aWMgaW5saW5lIGJvb2wgZG1hcl9y
Y3VfY2hlY2sodm9pZCkNCj4gPj4gICB7DQo+ID4+ICAgCXJldHVybiByd3NlbV9pc19sb2NrZWQo
JmRtYXJfZ2xvYmFsX2xvY2spIHx8DQo+ID4+IC0JICAgICAgIHN5c3RlbV9zdGF0ZSA9PSBTWVNU
RU1fQk9PVElORzsNCj4gPj4gKwkgICAgICAgc3lzdGVtX3N0YXRlID09IFNZU1RFTV9CT09USU5H
IHx8DQo+ID4+ICsJICAgICAgIChJU19FTkFCTEVEKENPTkZJR19JTlRFTF9JT01NVSkNCj4gPj4g
JiYgIWludGVsX2lvbW11X2VuYWJsZWQpOw0KPiA+PiAgIH0NCj4gPg0KPiA+IGludGVsX2lvbW11
X2VuYWJsZWQgaXMgMCBpZiBDT05GSUdfSU5URUxfSU9NTVUgaXMgbm90IHNldC4NCj4gPg0KPiA+
IHNhbWUgZm9yIG90aGVyIHNpbWlsYXIgY2hlY2tzLg0KPiANCj4gU29ycnkgdGhhdCBJIGRpZG4n
dCBnZXQgeW91ciBwb2ludC4gSWYgQ09ORklHX0lOVEVMX0lPTU1VIGlzIG5vdCBzZXQsDQo+IElT
X0VOQUJMRUQoQ09ORklHX0lOVEVMX0lPTU1VKSBpcyAwLiBUaGUgYWRkaW5nIGNoZWNrIGhhcyBu
byBlZmZlY3QuDQo+IERpZA0KPiBJIG1pc3MgYW55dGhpbmc/DQo+IA0KDQpNeSBwb2ludCB3YXMg
dGhhdCB0aGUgY2hlY2sgb24gQ09ORklHX0lOVEVMX0lPTU1VIGlzIHVubmVjZXNzYXJ5Lg0KDQo=
