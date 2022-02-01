Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE2E4A62C6
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 18:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241653AbiBARn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 12:43:27 -0500
Received: from mga17.intel.com ([192.55.52.151]:37949 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241645AbiBARnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 12:43:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643737402; x=1675273402;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C/MPgjG7Yx2YUTC3Qasu1BglCLO6Nrg28vqoKNmun2c=;
  b=W0Bi6SNFGVXM/VKDvuv5BB7OnkEZS1mCpuc3RiV3RWwfJvmupjXRLvNs
   tNnlt247xpmUW6zkAmA5eGIyawkxDmRm5lif78YdGEOActbXJHhd5GJvk
   0FsRBh1keN7fuYkDajmo4Vs3eyFjockaG2E83w5oajm9rVr4mbijBOM3B
   wRLkQrpx7LRoZ/dBiEgAipaz3aAj6scROYDewGK/PzRoO17RZ3L+4Mbrm
   UcN55wOCcP9kQjIDCxQjSZLFa7RLW2vqMcvwhfhPxd+RgBswvorfAW1YG
   hRFEwor3/y2WBvV93bewiM6qK7YSBSLEgFL8Wh/jRpgAhDx+STmU0a2ew
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="228405674"
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="228405674"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 09:43:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,334,1635231600"; 
   d="scan'208";a="626803882"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga002.fm.intel.com with ESMTP; 01 Feb 2022 09:43:22 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 09:43:21 -0800
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 1 Feb 2022 09:43:21 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 1 Feb 2022 09:43:21 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 1 Feb 2022 09:43:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bx5XmjtLgIoP2b0h2ZBjqQ8WyueFrhMlry8j5FIS1Mm54+l7oA/dLOcwuE8jJhsn4GAUkj1Xaji9HNpCeWcOXREC111VUHKdBJGiJh7xJXcLlgjJVtiZP+Rurn6sMibl1q/XNsw1Cf/MMQOgxop86U+/R6dIvgrvWtGP0V2l3hGOP7XfuKntuytDDWQJGx5v2ZJHOZIkl3YUaWVqM7qUwLnqQsq40OI+d1bV5M7VFgG34JV+c+z6UyYt/vb7Q53GxeDwIpWXVLDgbiJtHZxUQOvE0kSadglmHJjYyQwX3p3SgnY7uVfPEZSUkYH2gsBjMSK1o0ntHLM1UWMOiLLNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/MPgjG7Yx2YUTC3Qasu1BglCLO6Nrg28vqoKNmun2c=;
 b=jC6OAZB7DA3xGuyECOyUnbT2xbGLh+Vz3c6gNfmEgs42M7dANbAsbnGUWcJrDGitK3aowT8IncYO2023f8jV1VcsyQUEnXs5sZZ3cfgn/Ypk483lKEFfxTQYS83ACNln8UpG0RR6eWSoeLuPcsFs/KvUT6Vg+j9hhvOmBixsmfbNbw1rg0d6WWD+nALXrKEuOdCXWDPsDnonxa+Fv9Ji2ghByutRlin58MU5svT3oWFrUrVMgAmiStZmxkbR9VRdhlSOFiy0zIXfcuYWdEP2tOOjnt8H8iBspgBoFJLaLCU995PPX1ZFlC6ztxHSJL1yUG4pruChxGzk0Flvwz/IKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from MWHPR11MB1392.namprd11.prod.outlook.com (2603:10b6:300:24::14)
 by PH0PR11MB4839.namprd11.prod.outlook.com (2603:10b6:510:42::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 17:43:18 +0000
Received: from MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f]) by MWHPR11MB1392.namprd11.prod.outlook.com
 ([fe80::7053:5a70:1fec:345f%7]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 17:43:18 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "hpa@zytor.com" <hpa@zytor.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Thread-Topic: [PATCH V8 20/44] mm/pkeys: Add PKS test for context switching
Thread-Index: AQHYE6cS1JgGONNff02sCQH7fdYxhqx+/xWA
Date:   Tue, 1 Feb 2022 17:43:17 +0000
Message-ID: <fd507c3259da765f4c6b42dc6b319d7f5ce29ce6.camel@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
         <20220127175505.851391-21-ira.weiny@intel.com>
In-Reply-To: <20220127175505.851391-21-ira.weiny@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0585b57d-7125-487e-5b87-08d9e5aa54de
x-ms-traffictypediagnostic: PH0PR11MB4839:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr,ExtFwd
x-microsoft-antispam-prvs: <PH0PR11MB4839565FA8A54172C4174BF3C9269@PH0PR11MB4839.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fOOttJZBecYU81gH/7ZAyT4s6vtN1Xon/csMA9oNrm6pooAyPaGqkuzYFvoY1BPrnRFTSgMy3owrX/1SbpV5jv0IP15LMNf2WKNRpKWFP/1xKCUjj5anyb6hDeu430LySqcttFjm98wjfH0eESVPpxKMt3wGCxl9AKaoX73isaBJpkrXiO97ajetUqzYPTPaM+kwfQ938oUXI+586ob5+X1vJEEf4CJE+T39n8CA0PYaI+rQ+KTHLMGPJVG3ZsLgjTKKfGIQemXo4PxUuCqG9XiYLxMXGgVKz3z9ht7aLvwZx9qlaJhh+49k6HMHWMBTlz+I8VU1BAOioguX0xU3d7dLlkWubssUGB5aRJ4qzTcJgdhwEyqOiU9f+Az8FdRXMKGfgl/26ntzyK3o0FExpywof7SN3/HRpsEwKmQqG5ZqGhBgi73fxo6HTS6SYTOJNNUmu0DT5wjVfKOuNsxHp/D+Dcu2RwLM+p+GiHsIzSJiJXT90uUuMULffy/STc1hMcqM9uq6thO09qmAm+rGUyZkkt/d7mxVkd3B2kV5+yha8XnWQYa/5E+8Q7xFhJeDyrRg5QKapCBmaahaAjvQRY/Y0ZMrN/CG2IQqDuMmqcsk006pjNyByuWsKKF5ACt4pC+ao1az0G4Qha9dvJmW9uumc2uwJlcjmivNxsWOLFdST+DXfIoZ+z+Ze3jLCWLvirQz7Kb3CmWWPtwQGTUtjm82qifIzdB5HxTj9XrJ+Sc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1392.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(110136005)(508600001)(82960400001)(86362001)(2906002)(83380400001)(5660300002)(6486002)(38070700005)(66446008)(66476007)(36756003)(6506007)(26005)(66946007)(64756008)(66556008)(4326008)(76116006)(6512007)(8936002)(8676002)(186003)(122000001)(2616005)(71200400001)(316002)(38100700002)(99106002)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZTFZTXFSL3U4RnZEbDJtRWtGaGRFbVhlL0xNWGdIQlJ4VGpLSkJFMWM2d2cv?=
 =?utf-8?B?ZHMwYkhwaDZIMzFPbjZLVFNTZzM5eE8zdHVRcGg2Z0NVMkU4UHBLc0NsSFl6?=
 =?utf-8?B?OCsrVFoyaElBazRKRlNxQzBTVDZiaFAzR2J0Qm5nYlJyQ01jWmpCbWl6WGNh?=
 =?utf-8?B?Z05QTW5kMmRkNVBENnpnQ1Q2dUdNTjRxSW8vRksvbnlNaFpieTBYeDZSZy9z?=
 =?utf-8?B?UDErN0pVeWxiRldiL2V6VkgwcmF2MkliRlViU1RVdW52ajFpRXhEYVp0S0dZ?=
 =?utf-8?B?V3ZjSVhrcUNPSVpUaDRQQVlkclJETU5DWXlRZ2xoakNGcU9rdDdmbDN3OHp0?=
 =?utf-8?B?Y3V1UU5rdzFzTVNIc0UydG0wUSs3QVdxdVFCRnhUTmlyQlpzSGNsTTBsZlc0?=
 =?utf-8?B?Wjg1aDRwVEJSUmJvbi9VZkxXY1lMaW9kalhiQWlRN0hjN3hpRzE1Qjd0Z1dV?=
 =?utf-8?B?TnhiTlR4b0xwOVRMdGVndGU1S2tWUDk1RTRleElyT3pJbEs0VU9ZbHdDeUxU?=
 =?utf-8?B?M1dPYXNydEYxWTdnYmNxdVhaTSt4N2Q5dUV2RFRqVHhQRmVOVHM4TTZkbFBs?=
 =?utf-8?B?dXVabGZhOWZCT3JLSTJxRlVqMkJvd1FEaHRZUEVncUlTS21tMHlWNkM1Rjd3?=
 =?utf-8?B?OE5IOVBUYXpYVGdCRThvNkFDeXZYeVlrbXVRclNVYXpxRjVUOTNBRWIzWU5Y?=
 =?utf-8?B?MUNTQWxVMy9RQ1ZkRUVFRExsODR4UzYvaGRHODFVMWNmMHFaeHFmNXNTYlY5?=
 =?utf-8?B?RGVZMkJYYnV0Z3hoUU1WS0EvUDVZSCtZWWJQbDd4TTR0N2NzS21mL0ZyamRn?=
 =?utf-8?B?SlNiVDF2TEowcmVHVmFZb0pTNTdBOXQ5Q3RuRjBDcE12TFd6NmlvbmY0UE1C?=
 =?utf-8?B?RVlsUXNlb0NGRmw0bytuM0lDS2lDUzBhWDVsc3l4M0NqRS9YbDJzajBBSjRD?=
 =?utf-8?B?MXpYN0wvQ3ZXM3FzM0U1b3JXek1iZjVPOVhVT2JpVnpvNUhwclNHdG9DbjJG?=
 =?utf-8?B?SFY5K24wdHlYbWY1Q2pBSDB3ZlliT1dyU0dkbmlyZG9mNG5FVzYyVWxjeE0v?=
 =?utf-8?B?N2lZSnlIdDBuY2pMcDFMNEZ1NHl5Y3AxZ1NaUDR2UXovczZsOVJhSk5GS29Y?=
 =?utf-8?B?WFYyZHVnMW9FTnBRVHJjbi9RdVBxYmhGb1IwbTFWWFZuMTFFWFBOUUpXa0Jr?=
 =?utf-8?B?d2NENzRuRDdLM0ROWEdPMW43a1RDYktBa0R1Zm1jc3F6OVUwQzFNY3l6Qm02?=
 =?utf-8?B?aFFNeFlnaUY3c2tsRS9pZkNpbUh0ejF6c3pIS2xSd1B1L2dPUTlWNXl5dmta?=
 =?utf-8?B?TytxWk1CU2xsU3o4WE43TStpYWZSLzE3UEQ0ZTJXb1FuelNMZEpSVGdnbGJ0?=
 =?utf-8?B?aFNmbTZLcm5YT1pMVHd6T09jVldHVmJuRGhVTzl5WGFGT0kzS1pDaXl0cGZw?=
 =?utf-8?B?cnMvRXFYV1RsbnJvT2xoVlZ4cUdxbVdYdlE1eHBnckRlUDZUeVUvQXVVZDlU?=
 =?utf-8?B?cGxCR3dCaVcvbVF0ckk1L1h0NWU4dDA1RGZURS9oMUJwVE91aVBIemsrTS81?=
 =?utf-8?B?SlNJbmtlN0JObTRPTXRtamNPOWg4WjJUOFdEV0lVc0ROc1NqaUo2aERRSVRh?=
 =?utf-8?B?dmkyKzM3Y0xMLzlncEdCeUsvNkY3ZlJ2VC83RFZXVm90eDBRQys2eUE0NU1E?=
 =?utf-8?B?Tk0vNHpraXphZzVXM2tYSzBBLyszVGlKNU4raUpseDFMZFBRM2loRUVTQ0dw?=
 =?utf-8?B?Sk5VRWt3VUF5NFkwS04yMWVuUTRuTXc4YUFZZGUwN2YxTURHV1A0TytGWFY0?=
 =?utf-8?B?NElpSVJJZXFLNlNqTzhjeWFTY2h5TzVpSDc3THFXRTlGQ3NXMTlJMExjZkFu?=
 =?utf-8?B?cnV6QVFqaTJkaktDZ1k4bXNWcFF6VDBteUhIb3FSTmVZOTFhbndWMkl2NUdL?=
 =?utf-8?B?dTg5bWxOZStLME85dThvcXhMTEliTEwxbE1xTHFvZDBEdEUvaS9RMmM5dDRY?=
 =?utf-8?B?dk9IbzBMbVQrZHV2TVdDWUNOK0tteHJKa0VoNlR3NGFNR21SYmtWQkFvdWph?=
 =?utf-8?B?NVJrS2hHWm5lRHZibUZXT1ZhaU1JcHBVakU3Y0NYUE5iRG0raUlSZGF2dTZ5?=
 =?utf-8?B?SFdMb0xYd2lpVlh0TjYrcWJhTTBNWkxQc3p5a2RyaXcwemkwN3pPZzVVRlBT?=
 =?utf-8?B?M3lPOHd3SUk2OVplSVk3ZkxTVHcwbTc3aEJoRUsxcTdrY1h1cG1vTlR0a0pG?=
 =?utf-8?Q?kB8pu1ARr5HWKTusfTlaBaPEq+ZjhtxuJeYWSOK2xk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EBF0394D780AB04FB3A95098D5A805DB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1392.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0585b57d-7125-487e-5b87-08d9e5aa54de
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2022 17:43:18.0070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4qcnaZNC5a30IW/PWsAfSB1QjaM98HlWRqCNiaoqxAl7BHqxeacJrz9OiCYSvDSUfea725dK9VprHpBD+ib3HZUI7YnC4Pydks9zUZsjlUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4839
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIyLTAxLTI3IGF0IDA5OjU0IC0wODAwLCBpcmEud2VpbnlAaW50ZWwuY29tIHdy
b3RlOg0KPiAraW50IGNoZWNrX2NvbnRleHRfc3dpdGNoKGludCBjcHUpDQo+ICt7DQo+ICsgICAg
ICAgaW50IHN3aXRjaF9kb25lWzJdOw0KPiArICAgICAgIGludCBzZXR1cF9kb25lWzJdOw0KPiAr
ICAgICAgIGNwdV9zZXRfdCBjcHVzZXQ7DQo+ICsgICAgICAgY2hhciByZXN1bHRbMzJdOw0KPiAr
ICAgICAgIGludCByYyA9IDA7DQo+ICsgICAgICAgcGlkX3QgcGlkOw0KPiArICAgICAgIGludCBm
ZDsNCj4gKw0KPiArICAgICAgIENQVV9aRVJPKCZjcHVzZXQpOw0KPiArICAgICAgIENQVV9TRVQo
Y3B1LCAmY3B1c2V0KTsNCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIEVuc3VyZSB0aGUgdHdv
IHByb2Nlc3NlcyBydW4gb24gdGhlIHNhbWUgQ1BVIHNvIHRoYXQgdGhleQ0KPiBnbyB0aHJvdWdo
DQo+ICsgICAgICAgICogYSBjb250ZXh0IHN3aXRjaC4NCj4gKyAgICAgICAgKi8NCj4gKyAgICAg
ICBzY2hlZF9zZXRhZmZpbml0eShnZXRwaWQoKSwgc2l6ZW9mKGNwdV9zZXRfdCksICZjcHVzZXQp
Ow0KPiArDQo+ICsgICAgICAgaWYgKHBpcGUoc2V0dXBfZG9uZSkpIHsNCj4gKyAgICAgICAgICAg
ICAgIHByaW50ZigiRVJST1I6IEZhaWxlZCB0byBjcmVhdGUgcGlwZVxuIik7DQo+ICsgICAgICAg
ICAgICAgICByZXR1cm4gLTE7DQo+ICsgICAgICAgfQ0KPiArICAgICAgIGlmIChwaXBlKHN3aXRj
aF9kb25lKSkgew0KPiArICAgICAgICAgICAgICAgcHJpbnRmKCJFUlJPUjogRmFpbGVkIHRvIGNy
ZWF0ZSBwaXBlXG4iKTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtMTsNCj4gKyAgICAgICB9
DQo+ICsNCj4gKyAgICAgICBwaWQgPSBmb3JrKCk7DQo+ICsgICAgICAgaWYgKHBpZCA9PSAwKSB7
DQo+ICsgICAgICAgICAgICAgICBjaGFyIGRvbmUgPSAneSc7DQo+ICsNCj4gKyAgICAgICAgICAg
ICAgIGZkID0gb3BlbihQS1NfVEVTVF9GSUxFLCBPX1JEV1IpOw0KPiArICAgICAgICAgICAgICAg
aWYgKGZkIDwgMCkgew0KPiArICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIkVSUk9SOiBj
YW5ub3Qgb3BlbiAlc1xuIiwNCj4gUEtTX1RFU1RfRklMRSk7DQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHJldHVybiAtMTsNCg0KV2hlbiB0aGlzIGhhcHBlbnMsIHRoZSBlcnJvciBpcyBwcmlu
dGVkLCBidXQgdGhlIHBhcmVudCBwcm9jZXNzIGp1c3QNCmhhbmdzIGZvcmV2ZXIuIE1pZ2h0IG1h
a2UgaXQgaGFyZCB0byBzY3JpcHQgcnVubmluZyBhbGwgdGhlIHNlbGZ0ZXN0cy4NCg0KQWxzbywg
dGhlIG90aGVyIHg4NiBzZWxmdGVzdHMgbW9zdGx5IHVzZSBbUlVOXSwgW0lORk9dLCBbT0tdLCBb
RkFJTF0sDQpbU0tJUF0gYW5kIFtPS10gaW4gdGhlaXIgcHJpbnQgc3RhdGVtZW50cy4gUHJvYmFi
bHkgc2hvdWxkIHN0aWNrIHRvIHRoZQ0KcGF0dGVybiBhY3Jvc3MgYWxsIHRoZSBwcmludCBzdGF0
ZW1lbnRzLiBUaGlzIGlzIHByb2JhYmx5IGEgIltTS0lQXSIuDQpKdXN0IHJlYWxpemVkIEkndmUg
b21pdHRlZCB0aGUgIltdIiBpbiB0aGUgQ0VUIHNlcmllcyB0b28uDQoNCj4gKyAgICAgICAgICAg
ICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgICAgY3B1ID0gc2NoZWRfZ2V0Y3B1KCk7DQo+ICsg
ICAgICAgICAgICAgICBwcmludGYoIkNoaWxkIHJ1bm5pbmcgb24gY3B1ICVkLi4uXG4iLCBjcHUp
Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAvKiBBbGxvY2F0ZSBhbmQgcnVuIHRlc3QuICovDQo+
ICsgICAgICAgICAgICAgICB3cml0ZShmZCwgUlVOX1NJTkdMRSwgMSk7DQo+ICsNCj4gKyAgICAg
ICAgICAgICAgIC8qIEFybSBmb3IgY29udGV4dCBzd2l0Y2ggdGVzdCAqLw0KPiArICAgICAgICAg
ICAgICAgd3JpdGUoZmQsIEFSTV9DVFhfU1dJVENILCAxKTsNCj4gKw0KPiArICAgICAgICAgICAg
ICAgcHJpbnRmKCIgICB0ZWxsIHBhcmVudCB0byBnb1xuIik7DQo+ICsgICAgICAgICAgICAgICB3
cml0ZShzZXR1cF9kb25lWzFdLCAmZG9uZSwgc2l6ZW9mKGRvbmUpKTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgLyogQ29udGV4dCBzd2l0Y2ggb3V0Li4uICovDQo+ICsgICAgICAgICAgICAgICBw
cmludGYoIiAgIFdhaXRpbmcgZm9yIHBhcmVudC4uLlxuIik7DQo+ICsgICAgICAgICAgICAgICBy
ZWFkKHN3aXRjaF9kb25lWzBdLCAmZG9uZSwgc2l6ZW9mKGRvbmUpKTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgLyogQ2hlY2sgbXNyIHJlc3RvcmVkICovDQo+ICsgICAgICAgICAgICAgICBwcmlu
dGYoIkNoZWNraW5nIHJlc3VsdFxuIik7DQo+ICsgICAgICAgICAgICAgICB3cml0ZShmZCwgQ0hF
Q0tfQ1RYX1NXSVRDSCwgMSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIHJlYWQoZmQsIHJlc3Vs
dCwgMTApOw0KPiArICAgICAgICAgICAgICAgcHJpbnRmKCIgICAjUEYsIGNvbnRleHQgc3dpdGNo
LCBwa2V5IGFsbG9jYXRpb24gYW5kDQo+IGZyZWUgdGVzdHM6ICVzXG4iLCByZXN1bHQpOw0KPiAr
ICAgICAgICAgICAgICAgaWYgKCFzdHJuY21wKHJlc3VsdCwgIlBBU1MiLCAxMCkpIHsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgcmMgPSAtMTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZG9uZSA9ICdGJzsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgICAg
LyogU2lnbmFsIHJlc3VsdCAqLw0KPiArICAgICAgICAgICAgICAgd3JpdGUoc2V0dXBfZG9uZVsx
XSwgJmRvbmUsIHNpemVvZihkb25lKSk7DQo+ICsgICAgICAgfSBlbHNlIHsNCj4gKyAgICAgICAg
ICAgICAgIGNoYXIgZG9uZSA9ICd5JzsNCj4gKw0KPiArICAgICAgICAgICAgICAgcmVhZChzZXR1
cF9kb25lWzBdLCAmZG9uZSwgc2l6ZW9mKGRvbmUpKTsNCj4gKyAgICAgICAgICAgICAgIGNwdSA9
IHNjaGVkX2dldGNwdSgpOw0KPiArICAgICAgICAgICAgICAgcHJpbnRmKCJQYXJlbnQgcnVubmlu
ZyBvbiBjcHUgJWRcbiIsIGNwdSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIGZkID0gb3BlbihQ
S1NfVEVTVF9GSUxFLCBPX1JEV1IpOw0KPiArICAgICAgICAgICAgICAgaWYgKGZkIDwgMCkgew0K
PiArICAgICAgICAgICAgICAgICAgICAgICBwcmludGYoIkVSUk9SOiBjYW5ub3Qgb3BlbiAlc1xu
IiwNCj4gUEtTX1RFU1RfRklMRSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiAt
MTsNCj4gKyAgICAgICAgICAgICAgIH0NCj4gKw0KPiArICAgICAgICAgICAgICAgLyogcnVuIHRl
c3Qgd2l0aCB0aGUgc2FtZSBwa2V5ICovDQo+ICsgICAgICAgICAgICAgICB3cml0ZShmZCwgUlVO
X1NJTkdMRSwgMSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIHByaW50ZigiICAgU2lnbmFsaW5n
IGNoaWxkLlxuIik7DQo+ICsgICAgICAgICAgICAgICB3cml0ZShzd2l0Y2hfZG9uZVsxXSwgJmRv
bmUsIHNpemVvZihkb25lKSk7DQo+ICsNCj4gKyAgICAgICAgICAgICAgIC8qIFdhaXQgZm9yIHJl
c3VsdCAqLw0KPiArICAgICAgICAgICAgICAgcmVhZChzZXR1cF9kb25lWzBdLCAmZG9uZSwgc2l6
ZW9mKGRvbmUpKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChkb25lID09ICdGJykNCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgcmMgPSAtMTsNCj4gKyAgICAgICB9DQoNCg0K
