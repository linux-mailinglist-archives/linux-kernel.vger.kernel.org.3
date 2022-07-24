Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7223A57F790
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 01:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiGXXA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 19:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiGXXAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 19:00:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB512616B
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658703622; x=1690239622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=nGe904gP9WICtA0Hv+JmJqmgw1CVdbnlG3lZ4+msa9M=;
  b=nPAe64D9foZNSfxwvMPZPxmYV1sJivkR++UGFKDe7Qm+qzPAGEcGbzSM
   M5jndgvQF7LHuaHOGTQZ5ybju08LeNHR/OvQop0SjTm0SuHfj/F8vI4gJ
   D/lK8Kve151hxeo+OPHnbtQmEV9e2zR/sOdnaGj2RtUTXikbzsQ8lDyoP
   fN0uV2G4H3A/VxoDpqVQ654o/AGVZZyOLltiRhelHDgJIUJbDDFmkXbSZ
   V2Smfvh8Y72ZsCcAi6k8OL0vrZ7xqEIerkqx34h2rr+suG87rgRp1x/d4
   aartd2jogMA1p0c+nfbQoU+uGaR80fLjc8D/tY6+4AxF0QBihwjzJHMlr
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="373879494"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="373879494"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 16:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="926680167"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2022 16:00:22 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Sun, 24 Jul 2022 16:00:22 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Sun, 24 Jul 2022 16:00:22 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sun, 24 Jul 2022 16:00:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k9X0PwqDzDlvSILGagY87heZbXEzgA0cIrgDGOTeKxJxUMdww0qo7Z/NYgvYzTQR4rhy798Qn5PdVaBotS0F4NjgcdsHy0u9965RO3rb76BITvBenKPWzzPfxy9MflV1rjFCGEHoPusUEfEE7mlHKjcy5887F3DAVJ7WonOycSwQ3xq0zMxKmloH4YoROMcUCjCtt2xQAUQHV9ebdc25UUkTnlQCB+bTyOlwn0TCD4jbAUepjPxyGmol0ltt+Zk79zrfk3iAUVW8el7TwcDS0MMecba+Ad/hu6jecSqzJz0EONEHhygXcG8GxekV1tZ4lVSJ1QPCsbdc+Mvu0QfLag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGe904gP9WICtA0Hv+JmJqmgw1CVdbnlG3lZ4+msa9M=;
 b=G18nwOXFUZZf1v2I+2uTlCJdsHkEYIQWTGQzMNEUNJOY7KdS43YyYpaMiw+t8CBJnwQKn7Buf9kNPJkF1yr6v1OV6Y60nGwZDnELMkpsJ6say67FoBYpIt5aPbbb8FnS6DoWYmxradVQZ1nwWoRABmlPVXCkEEmomkSvMaqBfX8+M2q+zLp9ZNUy6eNhhg989XywijLca7ukfh6o0jx7NrlOBdLcZdNiKbKA0DAlB2tSiSoTIpH8rIZFdHoT4vt4Vw3ghH4cCAf5di+cp45w3prRo8LRj5y9Fs2jeiTK4UW6Irx323EUhd5Q2FWFqdIXb+QynRus8Ympr2ii2tax3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by PH7PR11MB6403.namprd11.prod.outlook.com (2603:10b6:510:1f9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.23; Sun, 24 Jul
 2022 23:00:19 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7c8a:9ebc:e674:796e%8]) with mapi id 15.20.5458.023; Sun, 24 Jul 2022
 23:00:19 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     David Laight <David.Laight@aculab.com>
CC:     "Sun, Yi" <yi.sun@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "Su, Heng" <heng.su@intel.com>
Subject: Re: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Topic: [PATCH 1/2] x86/fpu: Measure the Latency of XSAVE and XRSTOR
Thread-Index: AQHYnm+MVQB8AtxVUUee2ps+343Gtq2OAj6AgAAjLAA=
Date:   Sun, 24 Jul 2022 23:00:19 +0000
Message-ID: <75084D4E-80AC-4FE7-8CDD-2BFD30D23695@intel.com>
References: <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
In-Reply-To: <921078bc2a994d3ab6aba26d4654cb47@AcuMS.aculab.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f9af1d07-8de6-4718-6aef-08da6dc84809
x-ms-traffictypediagnostic: PH7PR11MB6403:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: K+kxrfEUEkbybB2ArE0NLZHK6q/HTCX81VCYteIA+521t36xFcPYh4kOeYuNwjyv5dCq91Yw7s7vaKFdIa8PSBO+/2GWEePt2ujiR1Ikpp8VjoM6hLko2Sfo6hneQ7NZniW3BeHgYnWhAxND2B6LK+Cm5wH0snogEjgAqHqCO2NQ1vs3BVQdhcl4scVpLfueGpnKSiaKP+f3r/cWdB0pSSC3B2slRx2KQyBvIIrRIiUHlVJdv/FykHNtwoxUBFi90rhDLiYPx1ECD9CcsYNFAjmTP5ivWE2wf5ZhMuPw7p+4h+oDALxNB/WU8xViyIiB4qbyn3FHppMwoZcKnZwGp2+JSsjmLtbFJO5eTqpmYLmMYcXSdDGivJ0I7XloFozEiZrqq/TXRks/somYEu/WZMI3SEq4r480IiNKp4Clj0hq9riAkGirY3qTcLcB6lKxCabOHihRR8lh7M8JiF8AAk6lo33rE4ZkCVw2uU/r6RT7LjRlk2AE8wlG1Lg53izKGTLQL+6pEhKqoIHhxSuFw+FSA8Q01djD+QrOCC1P4U4ph8UCvhQq6ZrT3iYgsjlNtMEJmH+wHRmqRGIavLyjFhyxUuGLIyqDXGl0rw0q8uJl4sRqE3vaWPlS59Cwb5Zn12n8G7YXamNWKLw0p5OFmCO0BiOcgTvVHGhC/TGYpDwhOZ7AIUzQPMt/TVmhw+7l7kfOyDrHE3cr8mbn6bct/Uf5JPD0d/MBlmp0UfAtdjw89TUeYy2jjxquU4OIrTKprutDdeLVumA8G2AK8Ru7Q2hvg1SjtjtGZ8S/pVNk10ZJoL8+j59LFChOaSfChcP7+FAAVtH5kjrSRz0JZbMf4g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(366004)(39860400002)(376002)(346002)(122000001)(83380400001)(38070700005)(76116006)(66946007)(38100700002)(82960400001)(66446008)(91956017)(54906003)(8676002)(66476007)(316002)(64756008)(66556008)(6916009)(478600001)(4326008)(8936002)(6512007)(26005)(53546011)(186003)(107886003)(6486002)(2616005)(2906002)(6506007)(41300700001)(86362001)(5660300002)(36756003)(33656002)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VEIrS2NwVWI4Wk5iMWlVVnY3Y0hTd3F6RmxhbTRpWGNuTHlVVVBMTjJLR2Qv?=
 =?utf-8?B?YU9ZN2NSbTFmS2F3eDdaMVNreFlXTkhLcU4wc1hqbURWREEyVjVkcEx5bWk5?=
 =?utf-8?B?enR6V2hiNzNQU3B2TWtxN0hFWEtxU0JJVGJFZWFVY1JSWWcwbFcxaFAreXd0?=
 =?utf-8?B?bmlIU3U3c3pxcm1PWDExVFdHNXB2aTZMekFwVnIvSSt5RHFhZmZLdE16bkhv?=
 =?utf-8?B?VW9kOUx1T0NxTmhJNVdzY2phenNRQ2U4Sm1zWGhWcis2aXJQTFRkMkxGVU03?=
 =?utf-8?B?WUhJM3l1SHQrT3RJemcxem1mcVM0STVZNHJTYW9zVHdRWUJJOEZqdFp1dDdm?=
 =?utf-8?B?YWxwNTVySWVGNkdIL25rQmtxcVUxeU5Ncm5JWThEeGh3TnFacUpJWnhpL0wr?=
 =?utf-8?B?dWc1RG5zc1NoTFZTODhPTm1SdlIvY2dJZklma0tzTzIzMHB0bUNBMkJIZ0sy?=
 =?utf-8?B?MVpuNHYvN3JPa1h2Kzd5dWJ4dXhTalpVVmExNU1Qa05kZVFZVm1CUDE3bVQ2?=
 =?utf-8?B?aWVxNjV1OWF3NFk2N3J5NTlJbWVYT1ZPYVEvelFCRmVXVGFkNVNUSlEyV1hO?=
 =?utf-8?B?UmYvdFVBdE41OGcxbHR4dzM4UVNvblRCbVcrVENiVU9JS25DZXlUclRQQ1BJ?=
 =?utf-8?B?SXM0Q0Fkc2U5VFlnUnhKWXlrL2t1SDFqcW5hNU5nMUlsMlorS1F0R1M3Nktu?=
 =?utf-8?B?b2ZDcTNQUDdoVnYvZXkyRGdyOXphdG5YMWZ1Q3pQTCtlajBMTExXZ2E4aHE3?=
 =?utf-8?B?U1RiaE5QVlJWdUdWTmhlVHdOZUMzUE5iSjA0SkpVcEs5Mzk1QVhGeUk2M1po?=
 =?utf-8?B?R3RkdU4rWXZkenpOMHBFTkZNcVAzUXRqWmNXVHdDWUJERnVDRDVOU0NlSVc4?=
 =?utf-8?B?WGlBaklENGVpZXBycEJ2QUI4MWRYOHhNTFdpVTVYSloybmFzTHdiNWpOTkRv?=
 =?utf-8?B?TklkSmxkb3FtcDZIZDVvR1NmL0dkV1RDVDZ1Q1VObUNpSGUxOVV4U1p3WTAr?=
 =?utf-8?B?YjRUVHNqZjlyYzZGVCtHdjVzZ09FUW1OeGJTOVhhbHpIczhEVlM1LysvR2M5?=
 =?utf-8?B?L0E1MmxGL2FvYXpwMkVHNEl3cXhoaFdBZWZoK3MyL1NHcVJHQ1IrV2ZFTVZM?=
 =?utf-8?B?b20xRTV0TEI3Z2FuQmhxc2R4dXNDYzczTVRYdlRHYkxIS3crVUNmZnZ0Sk94?=
 =?utf-8?B?eHBwZWVwQXhVMnNiQ1NkWStkOEUyR0p1N1dpaVAyTzdFNitGTHdLbHFqa1FD?=
 =?utf-8?B?d25IU1Q3akdsZDNpZDNiR216OE9jaFE3OFpCdC9SbkhxWkcxcm1XVU8zMHpq?=
 =?utf-8?B?MEFrUnVndUI0SXFHYnluc2FTWTVuWUNJbFVQVmVkK3ZWRzlIYXg1TVl1WFFE?=
 =?utf-8?B?WWdHYkNycEgwM3JrYzZQYmlLZjlVaHBYbEZUNm1FRGNhUjlTdE81ajFnMjh3?=
 =?utf-8?B?ckhuWVZJV3FrNXNLQVZnTGdPYjIwVXp3U0RWTWh2dW5UcUtKTlk4c28wU1pm?=
 =?utf-8?B?QkFZV0kzQmVkL0dhNlI2RzBBVFFpRDBZNFFPMVFrZ2dIUi9kc0xucGxzNStu?=
 =?utf-8?B?ZUw2alFzc2F0WkNwcWdnL0lGWGRlWGY3WWNDVzVqUzA0WitrK01qTGlCeDNU?=
 =?utf-8?B?VTJjYWRZSHZWakd5alEwQldYT3BWUmZybDN3a1UxcHEyMDJDVkR3M1V1VTdh?=
 =?utf-8?B?eURtVk9hMzQ4OGVJbHRNNEdmVjdKcEhvVHhXck9uZUdScmpkUUtkeHU4dXpa?=
 =?utf-8?B?WDBCS3ZnWWVnMU40SWhham4zMUFkWGw4TThkYzJHSVRnbWRQY1BEc3hXMFdo?=
 =?utf-8?B?QWtjZHA0czhrOW83Qm5URTB1cXJaVVhVYnR6WWlkS0NweXAwV2RpMmpXSjFY?=
 =?utf-8?B?VWtOT3Z3QnZhNDFtTjZXbC9ESmx6YWF1a1VqUHR0ei9KejFLa1ROVXBleTdo?=
 =?utf-8?B?Z3ZaRHR2d3lyOFRKMnA1TFBaSmV3K2p2UEc1Ylcxa1ZkYXR5TTdJL2FZSWZi?=
 =?utf-8?B?VXlzY0ZiSWcvY0g0T2UzWG40V01NWHMvQ2RXc2tGR3lieWg5bE4vL0xNMFhX?=
 =?utf-8?B?V0JMRlB1MVl6NHBaWVRyS2MwbWhmQkRtdGpkWnJjcmdBU0RTc2ZLcVh0Rm5p?=
 =?utf-8?Q?urMUNhA1KUEMGvkdx2u6wngFW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CEA944BD7A8DEA47A965F4A21328C040@intel.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9af1d07-8de6-4718-6aef-08da6dc84809
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2022 23:00:19.5185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YF8GSq7sf3WIgRAJQkBdBp5ckztqIzCnT4MiICRTPRZtKNMw+AtlCkJRHU4Pkci5NqcNeUG6tva7ygWbe1pKVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6403
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UkRUU0MgaGFzIHJldHVybmVkIHZhbHVlcyBpbnZhcmlhbnQgb2YgY3VycmVudCBmcmVxdWVuY3kg
c2luY2UgTmVoYWxlbSAobW9kdWxvIGEgZmV3IGhpY2NvdWdocykuIFNvIGFueSBDUFUgd2l0aCBY
U0FWRS9YUkVTVE9SIHNob3VsZCBiZSBzYWZlIHRvIG1lYXN1cmUgdXNpbmcgVFNDLg0KDQpTZW50
IGZyb20gbXkgaVBob25lDQoNCj4gT24gSnVsIDI0LCAyMDIyLCBhdCAxNDoxNiwgRGF2aWQgTGFp
Z2h0IDxEYXZpZC5MYWlnaHRAYWN1bGFiLmNvbT4gd3JvdGU6DQo+IA0KPiDvu79Gcm9tOiBZaSBT
dW4NCj4+IFNlbnQ6IDIzIEp1bHkgMjAyMiAwOTozOA0KPj4gDQo+PiBDYWxjdWxhdGUgdGhlIGxh
dGVuY3kgb2YgaW5zdHJ1Y3Rpb25zIHhzYXZlIGFuZCB4cnN0b3Igd2l0aCBuZXcgdHJhY2UNCj4+
IHBvaW50cyB4ODZfZnB1X2xhdGVuY3lfeHNhdmUgYW5kIHg4Nl9mcHVfbGF0ZW5jeV94cnN0b3Iu
DQo+PiANCj4+IFRoZSBkZWx0YSBUU0MgY2FuIGJlIGNhbGN1bGF0ZWQgd2l0aGluIGEgc2luZ2xl
IHRyYWNlIGV2ZW50LiBBbm90aGVyDQo+PiBvcHRpb24gY29uc2lkZXJlZCB3YXMgdG8gaGF2ZSAy
IHNlcGFyYXRlZCB0cmFjZSBldmVudHMgbWFya2luZyB0aGUNCj4+IHN0YXJ0IGFuZCBmaW5pc2gg
b2YgdGhlIHhzYXZlL3hyc3RvciBpbnN0cnVjdGlvbnMuIFRoZSBkZWx0YSBUU0Mgd2FzDQo+PiBj
YWxjdWxhdGVkIGZyb20gdGhlIDIgdHJhY2UgcG9pbnRzIGluIHVzZXIgc3BhY2UsIGJ1dCB0aGVy
ZSB3YXMNCj4+IHNpZ25pZmljYW50IG92ZXJoZWFkIGFkZGVkIGJ5IHRoZSB0cmFjZSBmdW5jdGlv
biBpdHNlbGYuDQo+PiANCj4+IEluIGludGVybmFsIHRlc3RpbmcsIHRoZSBzaW5nbGUgdHJhY2Ug
cG9pbnQgb3B0aW9uIHdoaWNoIGlzDQo+PiBpbXBsZW1lbnRlZCBoZXJlIHByb3ZlZCB0byBiZSBt
b3JlIGFjY3VyYXRlLg0KPiAuLi4NCj4gDQo+IEkndmUgZG9uZSBzb21lIGV4cGVyaW1lbnRzIHRo
YXQgbWVhc3VyZSBzaG9ydCBpbnN0cnVjdGlvbiBsYXRlbmNpZXMuDQo+IEJhc2ljYWxseSBJIGZv
dW5kOg0KPiAxKSBZb3UgbmVlZCBhIHN1aXRhYmxlIHNlcmlhbGlzaW5nIGluc3RydWN0aW9uIGJl
Zm9yZSBhbmQgYWZ0ZXINCj4gICB0aGUgY29kZSBiZWluZyB0ZXN0ZWQgLSBvdGhlcndpc2UgaXQg
Y2FuIG92ZXJsYXAgd2hhdGV2ZXINCj4gICB5b3UgYXJlIHVzaW5nIGZvciB0aW1pbmcuDQo+IDIp
IFRoZSBvbmx5IHJlbGlhYmxlIGNvdW50ZXIgaXMgdGhlIHBlcmZvcm1hbmNlIG1vbml0b3IgY2xv
Y2sNCj4gICBjb3VudGVyIC0gZXZlcnl0aGluZyBlbHNlIGRlcGVuZHMgb24gdGhlIGN1cnJlbnQg
Y3B1IGZyZXF1ZW5jeS4NCj4gICBPbiBpbnRlbCBjcHUgdGhlIGNwdSBmcmVxdWVuY3kgY2FuIGNo
YW5nZSBhbGwgdGhlIHRpbWUuDQo+IEFsbG93aW5nIGZvciB0aGF0LCBhbmQgdGhlbiBpZ25vcmlu
ZyBjb21wbGV0ZSBvdXRsaWVycywgSSBjb3VsZA0KPiBnZXQgY2xvY2stY291bnQgYWNjdXJhdGUg
dmFsdWVzIGZvciBpdGVyYXRpb25zIG9mIHRoZSBJUCBjc3VtIGxvb3AuDQo+IA0KPiAgICBEYXZp
ZA0KPiANCj4gLQ0KPiBSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNCj4gUmVnaXN0cmF0aW9uIE5v
OiAxMzk3Mzg2IChXYWxlcykNCj4gDQo=
