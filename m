Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2FA4878A0
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 14:59:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347757AbiAGN7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 08:59:14 -0500
Received: from mail-bo1ind01olkn0140.outbound.protection.outlook.com ([104.47.101.140]:16960
        "EHLO IND01-BO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1347748AbiAGN7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 08:59:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cs6yXFpTDmdwbhGABTInbR/ygeiLhC/Kefmd6Rp+lNlVz6tPM23P6cEDnAkIc4xN9eljEVKpsour4W+EJ4iS6hypnrFRuSCo0G1ifGQbzbnzbddY5KOx5OdteF1KplkJ6JbCfZE9WjmT9KscB0qDhGmVc+TYlL13/OfnOKSuAvo2X746SqN4LnVAo7h1Ave8rIJaQCTFJmb2JMv4M7Zm1uuk0Kpxf6ySynQwC0RJLVNlDWHB8WarxT3Lc5YFqTp2AYWBxEjxOT9/sieGelB7xBpBOWlHrL32OOITPJK1gRmzfl+rxUT/w6ASy9nFSJCrotkIW2duccsLr8Jcfc+lMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ynS6hFPuQBTyD4WcFX36jV5I/U3ms4nc1dISdjU9xCA=;
 b=Q4PEk9+SrllkRRIkKhq91Cn+jPu6P+PKDHsSM5RjGZzAl5JrRLQS0V6zTfp0+Jssyuf/rf3sZlyTk9a1mnxR6f824V/HtFaZd28n4pUyd43kTWiMlqUhu7xm04fXFC/kXoTzvHngVF51dVPjpRx89K5xObgQPbzh2TAfb1IXc+/73Wn9pdnyIYdYNGdLCfwBmgXE0yvEAt50jOlVeVqXU8agG63GrGzJ+qwdZvkadrFsU00GdzvbfvEVzKmwt2jZvP2iblnCmRndEuA8srV1+0cJ9tAybwD7DU1ld6//3+1Fg+DltlphlD3gTfAs3Uu4sp1f4Zoc6ZNEujaAeK1W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=live.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ynS6hFPuQBTyD4WcFX36jV5I/U3ms4nc1dISdjU9xCA=;
 b=syq7H5EoadBj3dT/wNxv6fMowk0dkChc6Tb/5LDNDKHdpHF0kMxFDkZWCvH+VFyrnVrSX0k1Pn9pIjYlaDfDHAiOqVKeT0xlyaKmgDx1N6j8pncBVB6Q7OXEOzrUwB/H1lPDXSa3zXzL2OIpvQOoavKE1W0C7hNGf5omjICPK/d+6s57ZQVT5laHU/tvwv1udeXoDtdrRmW8GzcSZJKYRom+Eze6P9KleF2PN2P8WUqFuP3or1EjD0loXyJlKFnjcpRhm2Ld+Tu1ut9pTOXn5ihXQM+Am7lMs+NZ6z7HIPc6X8Ywz0VOkz4QSpTXzarQQtDAEpMpUFt2DLhiqGA3mg==
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13)
 by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:1b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Fri, 7 Jan
 2022 13:59:09 +0000
Received: from PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7]) by PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
 ([fe80::7ca6:9165:19ec:4cd7%8]) with mapi id 15.20.4867.010; Fri, 7 Jan 2022
 13:59:09 +0000
From:   Aditya Garg <gargaditya08@live.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
CC:     "joonas.lahtinen@linux.intel.com" <joonas.lahtinen@linux.intel.com>,
        "rodrigo.vivi@intel.com" <rodrigo.vivi@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] drm/i915: Discard large BIOS framebuffers causing display
 corruption.
Thread-Topic: [PATCH] drm/i915: Discard large BIOS framebuffers causing
 display corruption.
Thread-Index: AQHYA869ks2A2KJEhUK+YmC3LMjOOQ==
Date:   Fri, 7 Jan 2022 13:59:09 +0000
Message-ID: <46AB6A6B-5DF3-4CD2-8CF6-0AD57634ADB7@live.com>
References: <7F167771-2D0A-40AD-8162-645E7EE2B9A0@outlook.com>
 <87sftzlnkp.fsf@intel.com>
In-Reply-To: <87sftzlnkp.fsf@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [gFelZWzTzeFUAYIvIajvz6CyTuEC0a3Fl8NDIBU6g9bsE+vvqqNbWSQqeDxDivuO]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27f3b5c4-fb82-4a96-47da-08d9d1e5e081
x-ms-traffictypediagnostic: PNZPR01MB4415:EE_
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nkDlpdNXQd9jFB8LR1Aks/aidO/E1LU7R3SuLGunB3ik890jciuNgG26Sb0vBy/LLlWgC7FgP5WvvYvnf87AdDnNE+P7wF2/L6iHmDppM1Hx2whuasUmeYSUFgRWVfcgLwZZgzBZgMy9BK3Frr9W7onF4K42Bmxnmym0c1pW0Z6WaoitYgowS6hXy1Hiz/LPPoY4dTWofkXX3fMRachtm+fWNRYDP+cQntlw/hkULoc2PTf6JtA/cVubb/5Yj3wJqpuAlzdf6fDsgsF+oxTMQ5chOawzH7Q9wmUpm2iJozbWxCsv13tFGpsdUzPPV739Ic/bhOwMS+Qb5GdH9/BiTqrTO9y2/bNSNCrZuO07A571QDUOABaCIR9CTAP0Wbpd9wDWtj+1b2p+11dQCe5gx5lJwt2dBl69cO5R84qp2C9Y4J8S2M8A5VLdAOglvfhRscegNefvCgOCR/B7MKNoHOg0GHXAddPhxRUSPg2g0eSfo88qj8vBM1BWFPnWUYQX4F8P9aWg4L1xO4cdX5oAkSbspWXGAFDdVKAIA8ZhjNduDB/PdT6qPWuyfZBpR7aHOulvgkr3UN9qy0IfQnKJOg==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UVZwdEU1b1g5THhvMzMzQXJCeEJ4TytCZTdkYTZOU2VzSlNGTFRxejlwK1ox?=
 =?utf-8?B?cmU2NTVkZjh0NXp1eTVCQ0NnWlRVcW9IODkwNWxQaHdqdXFPOUlFVHZ3N1hn?=
 =?utf-8?B?cTVuaEZyQ0JiSVNpb0xheUxsRkd0SENWS1NtZ084blhYQUlISWM3a04rNGl4?=
 =?utf-8?B?QVF5bFRHdUU2bktrSE1CRWY0ZndqMWovd3ZuaVRtV2dqR0JKQWNpcklLcXk1?=
 =?utf-8?B?cjBndy9DcEZWTnBmWVp5VkhLbytjV05Ra1NZMlF4NVNiMUovcHk4L0FFVzky?=
 =?utf-8?B?TGljQzU1MGtvYnNqRXY4WGgwcWU0UUw5cHd0VkMydTlSdGdaN0p4anNBS2FS?=
 =?utf-8?B?VTNGQks4UFNOcE84eHFQOHRaaGxSajdGZlNBZzhURnFkSmg0M1VOUi95NDdI?=
 =?utf-8?B?cWpaa3I3TTJnTk5IQ0Ivc2xtTytmQmxhbFI1emZoNWI3aFp4b0x5WUFWb0xk?=
 =?utf-8?B?d2VLSlhsdzJwbWNWVWxZdDB5SDI3aFdtaWlqNTdJTW11Mkw0QUpobFdERllM?=
 =?utf-8?B?NGdjTlRLOUh1NHdpc2JXM0o2MU1vZC9vbklGQWs3VjNMWUpoc0kwS3RhZCtK?=
 =?utf-8?B?dktCV0JYWnZsQUpsaHFIV2dibTFKQ25ScjlhZXhFdXcxQm9UZVgrOGFKSjlB?=
 =?utf-8?B?ZlVTWGdiaEZmejNYbTBRRFJ6YkVSbDRJekovUnNWUW10MWJoWmdIMmhNMzNP?=
 =?utf-8?B?R0hvTHljL3NncHY4eGdyd0IwSmlNWGZ1RDJsQSszdDZWaUgyL0hQTEpOZEsy?=
 =?utf-8?B?dVhGZ0VGMzkwUnB4WjRFWjg3OEhEK1FjUGJsUmxaeTQzZ2E5WC9mVENoaXRJ?=
 =?utf-8?B?N0NjcGxVZ2UyMkVkSTNkTENVcDFpR0diWjJyNGhXQUhYbGxVZnNWNGVjWE8x?=
 =?utf-8?B?Vk9GTUtBYUtvZFFIVXBJeHJ2b2JJTk9Na21lZUJRazlOT3ZGd1JMbC8vdEk1?=
 =?utf-8?B?bXZmaTlFdW5pZFVzN2Z5Q3VCZ0dNclIyR1BRTGtOZzFEeS9nNHVmeVV1R3RT?=
 =?utf-8?B?c09tVlVWbXFueEtxQWY4NXllREtmemN3VEgrUitPZDZEOTlJUzc1WUJEMGp4?=
 =?utf-8?B?b0ZyUjdPU3hLRmU2TlhMZFZITGlZOE9kUm9GTXA4akdrR0pUT2RrTlpiVnRw?=
 =?utf-8?B?M29abGZoaVB4VmxxZktJMlZ5M2tqZ2xxWkJseCt2QUk5ekRhSHQ0QlVONzNa?=
 =?utf-8?B?TWdPQjdYRjRpR05SMGV1Vk1FRWVqeVl1dllVRGVWRHBGRXlxQmFwUlF3NTVF?=
 =?utf-8?B?L09OdXB1MnB5ZGNOUXpzMlhETHZjU3VRNGlQeUkwcTYyWGFtdGdFYU1qcmo5?=
 =?utf-8?B?aDlpUmtZd0lnQTBDZndXWVBkL1FpWXVLVFFVYW90ajR5ZGZzQjN4Y2V5aUR4?=
 =?utf-8?B?QVJ2YVZ4NW9vaGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3E47E5EFCE29954A846DD3E7E0C33E99@INDPRD01.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-42ed3.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PNZPR01MB4415.INDPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 27f3b5c4-fb82-4a96-47da-08d9d1e5e081
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jan 2022 13:59:09.3253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PNZPR01MB4415
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gMDctSmFuLTIwMjIsIGF0IDY6MTcgUE0sIEphbmkgTmlrdWxhIDxqYW5pLm5pa3Vs
YUBsaW51eC5pbnRlbC5jb20+IHdyb3RlOg0KPiANCj4gT24gRnJpLCAwNyBKYW4gMjAyMiwgQXNo
aXNoIEFyb3JhIDxhc2hpc2hhcm9yYS5saW51eEBvdXRsb29rLmNvbT4gd3JvdGU6DQo+PiBGcm9t
OiBBc2hpc2ggQXJvcmEgPGFzaGlzaGFyb3JhLmxpbnV4QG91dGxvb2suY29tPg0KPj4gDQo+PiBP
biBjZXJ0YWluIDRrIHBhbmVscywgdGhlIEJJT1MgZnJhbWVidWZmZXIgaXMgbGFyZ2VyIHRoYW4g
d2hhdCBwYW5lbA0KPj4gcmVxdWlyZXMgY2F1c2luZyBkaXNwbGF5IGNvcnJ1cHRpb24uIEludHJv
ZHVjZSBhIGNoZWNrIGZvciB0aGUgc2FtZS4NCj4gDQo+IFRoaXMgaXMgcXVpdGUgdGhpbiBvbiBk
ZXRhaWxzLiBJcyB0aGVyZSBhIGJ1ZyByZXBvcnQ/DQpObyBidWcgcmVwb3J0LCBidXQgYW4gaXNz
dWUgSSBhbSBmYWNpbmcgbXlzZWxmLiBUaGlzIHBhdGNoIHNlZW1zIHRvIGZpeCBpdC4NCj4gDQo+
IE1vcmVvdmVyLCBpZiB0aGlzIGlzIHdoYXQgd2Ugd2FudCwgdGhpcyBzaG91bGQgYmUgY29tYmlu
ZWQgd2l0aCB0aGUNCj4gY29uZGl0aW9ucyB0aGF0IGZvbGxvdyByZXN1bHRpbmcgaW4gYSAiIT0i
IGNoZWNrIGluc3RlYWQgb2Ygc2VwYXJhdGUgIjwiDQo+IGFuZCAiPuKAnS4NClNlbmRpbmcgYSB2
ZXJzaW9uIDINCj4gDQo+IEJSLA0KPiBKYW5pLg0KPiANCj4gDQo+IA0KPj4gDQo+PiBTaWduZWQt
b2ZmLWJ5OiBBc2hpc2ggQXJvcmEgPGFzaGlzaGFyb3JhLmxpbnV4QG91dGxvb2suY29tPg0KPj4g
LS0tDQo+PiBkcml2ZXJzL2dwdS9kcm0vaTkxNS9kaXNwbGF5L2ludGVsX2ZiZGV2LmMgfCAxMSAr
KysrKysrKysrKw0KPj4gMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4+IA0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZmJkZXYuYyBi
L2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3BsYXkvaW50ZWxfZmJkZXYuYw0KPj4gaW5kZXggYWRj
M2E4MWJlLi5mOTk1MmUxZjggMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0vaTkxNS9k
aXNwbGF5L2ludGVsX2ZiZGV2LmMNCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9pOTE1L2Rpc3Bs
YXkvaW50ZWxfZmJkZXYuYw0KPj4gQEAgLTE5Myw2ICsxOTMsMTcgQEAgc3RhdGljIGludCBpbnRl
bGZiX2NyZWF0ZShzdHJ1Y3QgZHJtX2ZiX2hlbHBlciAqaGVscGVyLA0KPj4gCXN0cnVjdCBkcm1f
aTkxNV9nZW1fb2JqZWN0ICpvYmo7DQo+PiAJaW50IHJldDsNCj4+IA0KPj4gKwlpZiAoaW50ZWxf
ZmIgJiYNCj4+ICsJICAgIChzaXplcy0+ZmJfd2lkdGggPCBpbnRlbF9mYi0+YmFzZS53aWR0aCB8
fA0KPj4gKwkgICAgIHNpemVzLT5mYl9oZWlnaHQgPCBpbnRlbF9mYi0+YmFzZS5oZWlnaHQpKSB7
DQo+PiArCQlkcm1fZGJnX2ttcygmZGV2X3ByaXYtPmRybSwNCj4+ICsJCQkgICAgIkJJT1MgZmIg
dG9vIGxhcmdlICglZHglZCksIHdlIHJlcXVpcmUgKCVkeCVkKSwiDQo+PiArCQkJICAgICIgcmVs
ZWFzaW5nIGl0XG4iLA0KPj4gKwkJCSAgICBpbnRlbF9mYi0+YmFzZS53aWR0aCwgaW50ZWxfZmIt
PmJhc2UuaGVpZ2h0LA0KPj4gKwkJCSAgICBzaXplcy0+ZmJfd2lkdGgsIHNpemVzLT5mYl9oZWln
aHQpOw0KPj4gKwkJZHJtX2ZyYW1lYnVmZmVyX3B1dCgmaW50ZWxfZmItPmJhc2UpOw0KPj4gKwkJ
aW50ZWxfZmIgPSBpZmJkZXYtPmZiID0gTlVMTDsNCj4+ICsJfQ0KPj4gCWlmIChpbnRlbF9mYiAm
Jg0KPj4gCSAgICAoc2l6ZXMtPmZiX3dpZHRoID4gaW50ZWxfZmItPmJhc2Uud2lkdGggfHwNCj4+
IAkgICAgIHNpemVzLT5mYl9oZWlnaHQgPiBpbnRlbF9mYi0+YmFzZS5oZWlnaHQpKSB7DQo+IA0K
PiAtLSANCj4gSmFuaSBOaWt1bGEsIEludGVsIE9wZW4gU291cmNlIEdyYXBoaWNzIENlbnRlcg0K
DQo=
