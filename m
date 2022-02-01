Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3261A4A62C2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:43:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241626AbiBARm6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:42:58 -0500
Received: from mga01.intel.com ([192.55.52.88]:38539 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241149AbiBARm5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:42:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643737377; x=1675273377;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+NNKICmyDUYxH68utIXwqiuNCgX4GGQ1pHi6Lm+kigQ=;
  b=RgId0rKIvRC/562DI9XOYxSCdTIR661ppkVdrSM7vStNeat8FDFiO7A2
   biPPPbsNCBFUDogWpcFWxAzP24DbeY4JEltGl6fLIgwlz4Ald3K96sraE
   QPMPy8cZ14LKC4h9fLBAh3vHINZ2fqluTyuiNxnkNTBThYyfcE1opgAtc
   Cy6KCMZUmy9EOqmpNTJgOcHb3jQsJQ9ScLvmcR74uO4xW5D+oZNmZi2qT
   jU7bOAsILS5D541trSHJXr6/rSgzhkbEFIh2hF9QbmSP3UTqzh5D24fY5
   WvYm2SPPA/bGHxC6AUaoI7oqzhAjo3TzwFNgvoE13Ka61QpunMmF2zcSC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="272226950"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="272226950"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:42:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="583110990"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga008.fm.intel.com with ESMTP; 01 Feb 2022 09:42:39 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 09:42:39 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 09:42:39 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.47) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 09:42:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVS0DzSmK+/GCVcRB6IsymYcyyXbDEW7g+Ef2uqNwm/FCX2Rz6iRMK+hDXZ3jjWoMSDduRX65H9yYvuBfDLUerujs96L1VWBqwR+SE/ufIuMbIvo0POEOjU20WqrFOIUFQ+QUoKHLP8i8dFlsQcXyzTzbHMnAkuJ+WB0+3vpGlaEdkP98dPw9PMH0vXx6VdCJlvQkYddEoOblD7glMuw14qK7YQDacH8/mAoL1zm6CeIS49kZbIokutJ402UXUpp14H+0VrTjvJOPykcW6jyFxo7w6l3bTCyH6msVhIFgP0VkSaf0HyGSU3rJ84XGzZPDslS1foPcrMkd78zYoC78Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NNKICmyDUYxH68utIXwqiuNCgX4GGQ1pHi6Lm+kigQ=;
 b=NCJ3N063/DQxWBmk1uKE/I/N8dywJ6ewXhQVR1/KVBgWixH13lKq9czR7UyTcYHAe75lURC6c+bUaGU6+EMy5G+B6CGenKs3gHlPz3/B4RiynAmkJ6+hEwMHM3/+Yy1ZTWyDRXAcOz4K/ZQvltkHPeVWxPrCbLt9U4uLRfGaeDwnGhkZ2UzrFxdu7PTrkmznsK6xW6fNayHEGzp3xpvMprj9kvK+TFIhRTkIDDeYMALy0u3YTVvVOhHVXeYn5GpXNzvMrJASOK8wkhs3FydCPL9XT3TX+m5jK1R4LwWuemwExz6bVmpEtIlE8eyLRcRWRHs3jexfDjUgIRLZ38zM2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 17:42:33 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 17:42:33 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom
 fault callback
Thread-Topic: [PATCH V8 30/44] mm/pkeys: Test setting a PKS key in a custom
 fault callback
Thread-Index: AQHYE6cS6O+hTjNVIUi6bZpYZjBtFax+/t8A
Date:   Tue, 1 Feb 2022 17:42:32 +0000
Message-ID: <9ef3dff3f46edda07afdf6b2469ef9a1a606563e.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-31-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-31-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b375573b-0b07-4928-69e9-08d9e5aa3a0c
x-ms-traffictypediagnostic: PH0PR11MB4839:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB4839CF46CFCAE7BF7A7816C4C9269@PH0PR11MB4839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0ufhBWljF+bTNXOfYjAbByTG6LgRDAaQ2BH24VtxF87+QOcQnT5hl6ClGqyi04mPg8m22yg47qW0LiaabTsWAxnXkj23Ifdc0SwHeS3ntfJsLTdqZk+uRkedwVL5GJu0pWbnERzsPE9/s7l+xTz0Rw7UWrcGsJ/gPK6kQQ1aWvl7TEHXjABbN+shuKSnonAK8wbgP7nHh2aLOgV5mJqa2yGYGBUm8CCo5RxVNeLIqVuH4aXcBDPQe9lJQzt8bgINSTfGbO35ySYn+Ro6Y5cgnbZtXFR9BH668Tw231pWWL4axpiBgxJI8wtxpvPOGUgLJ8q7qz2lwVbFDE8DPvvCNh6XSF3cx0vRfzCaLsXorMS/9xaJL5wUNMCBpSzL7xox0r85OUULTOdNbaMxQ6WuX2cv381gb1NPW87FEcyDcezD83nl5mlM0K+qaK1j+G3sbRNNg1t+q8w6/NvOFRSw0SNQETZhGqFq/5eoy6xYOBRQuNu+XVofgF88/O0qQLb2tfuGQa21s7XOK/8+KihpXGCG8/OEs0Q/a0SSDV9Fm1Usu//DvzizrDn/1GU5riNl6M/2K2HL5BtyzUKiXpMuSccFqVDgbpybQ6BpxitKYCG7L/N6UE71on+R2oYwPaUNGZ/Gtg/ZeKAiV19lfi9kWBLMoN7f4+6NQjy7DIsgAN8XHqd2OR5ua3OW4ipeB1gS9z0fpHrRx8dbAHI950no3Rgv2y8VEwFZRnUNbda/zqs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(110136005)(508600001)(82960400001)(86362001)(2906002)(558084003)(5660300002)(6486002)(38070700005)(66446008)(66476007)(36756003)(6506007)(26005)(66946007)(64756008)(66556008)(4326008)(76116006)(6512007)(8936002)(8676002)(186003)(122000001)(2616005)(71200400001)(316002)(38100700002)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZW9UZjdHemFtY3M4YmwwemJVR3drZXQrb3NaZ1B2RXIrSmQrdkUxVEFYQk9u?=
 =?utf-8?B?eHZFWEQyekZneG9zK1dFU2t3VWlmYjdHTkVFZVZvYTF6L2RkbURPankvLzRp?=
 =?utf-8?B?SG53MDBXd0ZISGdlL3JmbVhrUmVmNEE2SVdKLzlwVVlIRnEwMmlSdkdDTzJZ?=
 =?utf-8?B?cmxyS0FqUC9qZ3ZrcFUzSFowclpPaVg3VWwvWHpyYm9DVzE4SzgwT3VmU1dB?=
 =?utf-8?B?VkVmSUhHcSt2ajJVc2dEMEtYcHBYTFJEOCtZckZDSnZUMUxCblBpQnpxRk1D?=
 =?utf-8?B?K3YvQThXYzFCS3RDbnA4YlNpTnptN3NnRHMrZnJtc21TZEpCWnpscTRvMkRw?=
 =?utf-8?B?aHdyQVVadU5XOWVhMHkvWXY4b0VDMXZad3p6RXdWV3Bia3hwNlBrV0t4V3Bk?=
 =?utf-8?B?V2JGdzVna2NneVYrWDVBMElmZkVOdUR3U2pESEkvakhYUlFVZlR6RERDRnE2?=
 =?utf-8?B?UDkvaW9UaWlBN0VaU1pJQ0NmTlpFT0d0ZFJCTFI3emZ6R3ZHbndkNzVuUFoy?=
 =?utf-8?B?clVEdlprNGZBUWZPejRrYzdDbkFKZmVrcHZsZFAweGM5Vm55bDV0eXJ2eXZI?=
 =?utf-8?B?Wi93NC9kMzNNWTFScm9yeWFDb3dRNnJleTRST3RPMGpWbDJFTlppYlIxWU9j?=
 =?utf-8?B?NlVvWk1ENEQxYkx2Sk5xVEtiRXdjNHFmRHFub2RxQUllTkNDVWd4RnRxcStS?=
 =?utf-8?B?cE1Zbng5cTAxM3N5aXhFb2dZVmFzdE5sZHdHS29xUi9rVzRNZGlRQmd4Unc5?=
 =?utf-8?B?L0kvZjdvNTEzZnN2Sm96T3ZoS01WTWZ0ajVHYlh3UFQrQ0x4bU1GUk9hSk8z?=
 =?utf-8?B?VDlxQ25pNWlHcXJkZ1J1Zm0wNVNjeDBQbmZ2TzZGN1hNWXdwb2MvVjZRZE5h?=
 =?utf-8?B?S04yUkhaTmxXaUtKMU5MMHhqcWFJT2c3YUhqcm9mYTkySmdpYUY2eFR0UXZq?=
 =?utf-8?B?RDFnaUhtTlhRckJkRis1UWNGaUVwRllmbXJkaGNwQ0VLcGpaNzg0cVhnM1M5?=
 =?utf-8?B?Uk5sS012czl4NHdvbitvcncvaUR4K3hIU05YbUxpcGJNM0lRUGdpS2ZYL3pW?=
 =?utf-8?B?ZjVUcVEzVC81bEt3cWFkNUdpZXArdU9MVURwdFgyT3NJWVBlRW92RXhVNkx1?=
 =?utf-8?B?ZUNybjZRRXZRL0pKdzRNeTQvWWdrc1ppVW43UUhkR3FkU3dud0UxSTVOcWtI?=
 =?utf-8?B?KzhwOTVNaGtnUTgxVCt1NnFZUlFyNU9RSEczbTZkYUhESVRzOGtMdkw5SHlo?=
 =?utf-8?B?SXp6RnJQeXRKL1JVU3pVUEdrSjRCcmo3QzdUalJhZ3lUS0xicUhUSHdLdHRw?=
 =?utf-8?B?U2gxK25HT3czSnlWYVBXOXRBaG1sMUEvZnZ0bGpYK2RJVktjTWhFMEY5aHg4?=
 =?utf-8?B?a0xIOTZKK1pQQ1pOVDNheDZ4NHdRRW1uZEw3QnB4V3VEWUNSbjFVRXdlTDZ4?=
 =?utf-8?B?aVhXUmJ4Rkc0a2RXNzE5bzBqMlFRbWszb2VGbzAyQ2d0cXNlTXBaeTZQcWpJ?=
 =?utf-8?B?Vk1kaWc0QmNiejNVOEZoTnN1Um1tZDk3bW80NUJzbXdkbVJaY1M1aXNvVkVJ?=
 =?utf-8?B?UTkvaTR2SkxqUGtzc1VSdlFaMElVU1NwM2FxR2hwMXBndnJGeHNsVjF0bmV4?=
 =?utf-8?B?Uk44ckFESTQzRG9zMWhIcmNWK1F2M0hSdkJ4VEF6emFXWkRiTmtzOEliTWdN?=
 =?utf-8?B?eXYwdUJYNjR2NWhmK2dHN3JzdzQ5bng2K0UxQkF4ck1NRzlxWVNHMGpISW0w?=
 =?utf-8?B?aGU0YVpGaFBYOWFydFVxVEwwcE1VK3Y0ellZOGY5ZDh2dDYwWUdsMmpZR1k3?=
 =?utf-8?B?eEt0ZUQwaFMxbnJ3cEFtN0FucGR3bVI3RnBFMnV1V25vZDd2MFQ3eVB4R3JI?=
 =?utf-8?B?ckZBR0tKTXhEVFQ1N3pFRXlDeGpxbGV6RHR4RUQrVU1xNEhicjNUSjZjK0tJ?=
 =?utf-8?B?N0dnQXV4L0ZZKzB5R0trUyt3Q0xsS0MvNkQxUGlSMXJGenFHZHFBWXlwSzhS?=
 =?utf-8?B?ZVErNWFuODZLMjczcnd3SHhkbmVPNWxkeWY5d3cycE9NcE5hc1VicEJuNGU0?=
 =?utf-8?B?NUEyK2htdUZsRENtSTN5cnk5R1BSYnlpdVZ2TDhFcWhvOXhSblgvNTF4Q3RK?=
 =?utf-8?B?SVRqOWxCVFVmRlNUZVYyZkRGMFZYM3V5YlFZbTRLVk5mczVKZTFPK1Z4SnpC?=
 =?utf-8?B?elhhbUdTMkgyeHJyREM0OVUwM3lYWHp3c0tpM1FHcit0cGVBRHpTQnJGdk5n?=
 =?utf-8?Q?0ZA0AaIROIwB6cMn4/pt4KGI8V0nLZ21qUcJ/Qzom4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <922093A5311E5A4FB0094F12C590A222@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b375573b-0b07-4928-69e9-08d9e5aa3a0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 17:42:33.0103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOArEUcA0TXKw+Pf5V6TZmI25wo7YjTwp4sWwPThXzGu6qTuWJqbXo5BReSEneCU270D3ZQq4Bls/TMCB6djGQ+DrUlzXyLJ8NrpmGSQtV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiArI2RlZmluZSBSVU5fRkFVTFRfQUJBTkRPTiAgICAgIDUNCg0KVGhlIHRlc3RzIHN0
aWxsIGNhbGwgdGhpcyBvcGVyYXRpb24gImFiYW5kb24iIGFsbCB0aHJvdWdob3V0LCBidXQgdGhl
DQpvcGVyYXRpb24gZ290IHJlbmFtZWQgaW4gdGhlIGtlcm5lbC4gUHJvYmFibHkgc2hvdWxkIHJl
bmFtZSBpdCBpbiB0aGUNCnRlc3RzIHRvby4NCg==
