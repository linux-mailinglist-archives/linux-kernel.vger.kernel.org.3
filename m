Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF7F4462FE0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240317AbhK3Joc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:44:32 -0500
Received: from mail-vi1eur05on2076.outbound.protection.outlook.com ([40.107.21.76]:25696
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235639AbhK3Jo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:44:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV/dkymo+rF2DuHZLcK9hPyn710r5au4YRCo8LAD/ctenGWUQg9nZkJiUKxgOp/XSgyZ3r/jFKhKyK1GXQbrjXMo3asXXlTtKGBPUFeazyOb/opUykhfqlQOqX049aUu0GCtKu+xmDmeVoSoUoX25jmxUiSuVCfe/BvOHsued9t8faQZ6G/aCTCQCykW6skKeS/1jDGhd/elrrHytSerPbuf7XbWjgOONKYcRdFw+UP+GO+6V7Y1BQCdq843TEw4g4wMUZ0Xl34o4YrzPlc83NBsXteCSHgVyL4VUkyo1uxV3p75+dAQZXrzfYcTBoi2sSTqSVIhk6lokgU3laRKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALjk5bW6QEaVkgH1lP7A8f0JRuk5XFhI560E40A6sdA=;
 b=j2RRQKprGMynApSCYDpAQMg1TP7KP/TmWgsScwH5dURseE9x7jtojssdWqseJ6tfqSgSO6VZh+3lR9DzL83Vt/vBNbPJgu/+ZhOks3bALIoL2fBuSnBASUxXjw8vBYyh1FBA1xZEtuGr0jr4/xkxnvrtDHQqWTYvaeM/yB9+aaTu2KOsOHHkm//PFBHcssTouy7e4GUFEJrFBUENiV0PgLx+NhNYyh1u7QfXhq9qfqCKdw15k3muTyKgZXVkIHT7GhomrmwU1nkBXnPK1A8538MTfaA6HCQ7DA7kFqVexajBLXi/QtogyB1/xYJ5he7uwTi+VzvZgS9dB4LdBiCuaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALjk5bW6QEaVkgH1lP7A8f0JRuk5XFhI560E40A6sdA=;
 b=ONRUcaGJHDdnvLD8hQjUq3KZ6APx0Q3UuZG2N+SROs5Pa0G5dG3UZIVjglI21QKZgIr8og0vSW+W1UBurAMs4cg9Tf/ANQKdWfH0uOxRZJ2Jq+t9Yd9z9I3ZIavlFC5FudG5HcOCLWgin8VJPjceoN8HNp79a10kRiiQunCYYGY=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB7PR10MB1929.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:5:6::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11; Tue, 30 Nov 2021 09:41:04 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 09:41:04 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "y.bas@phytec.de" <y.bas@phytec.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/2] watchdog: da9062: reset board on watchdog timeout
Thread-Topic: [PATCH 2/2] watchdog: da9062: reset board on watchdog timeout
Thread-Index: AQHX4Q3npNRtviCugkid2y7uipNYX6wVzxoggASjegCAAWXZ0A==
Date:   Tue, 30 Nov 2021 09:41:04 +0000
Message-ID: <DB9PR10MB46524A6D216E65C2428588A680679@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211124083258.2606511-1-andrej.picej@norik.com>
 <20211124083258.2606511-2-andrej.picej@norik.com>
 <DB9PR10MB4652529FAC6253C266B172EF80639@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
 <b65c9c58-485d-1735-bda2-e750ee8d8a8a@norik.com>
In-Reply-To: <b65c9c58-485d-1735-bda2-e750ee8d8a8a@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccb8f05a-6f0c-4d17-c2c0-08d9b3e58701
x-ms-traffictypediagnostic: DB7PR10MB1929:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB7PR10MB192917BB272FC4F04162D468A7679@DB7PR10MB1929.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMCAwrMeeOjmVm9zqp0QWJFnrmrEAGjASBa/9m8ZZW04MmCD3clrIC4l6R+hDgJgjQdjOioK1NqAw05nkbpuZqD6GphwsPxkc0E1FoZnzbxZOy7moxPIboRHyHmR2hBWU6f9B6PfcAhJ6w/MkhLfTnnttzspPr8O9U+JLUL/0//NZ4iNNHpiBxzngIGl6dMVRHARK1QufCXLRLN++/OdH8rkjJ9cqEotmgCXa8xgjEXohkfWIcjBQ3Ajp36BXOij64QfcppL0xqZUTYsvuWRF9YgmaQH/AvR1Amn/3RF5X7eltZGErqZg9nB0Rq00nK5FbFNjkCACWkDyVs7NSWK7lxvSE082wm3NO5Bktv6uZtB8GiJx5GTsmBI/W1y3t/QYcX+2LKAjZwyCmJ8r7twR9HIgklnKbfMmi6CKmLMz7ToNf9pClOO8ZspIVqx8iOLhhmi7L8CauiFxAyVIaIZKSJhBbCGCld+Z9a8qVQb28Y0sMda7Bl/82JsY8MGkQYONkc/7t+UvC1nch1c5llDsLJGCqaUI/6ONhvUVcn6mmUvCeyz0UT7gNW32VaiASS9809Uuj7FnVPFJBjcHYDmBFIuSdl3Dnu69QmimPKcK/QZYTl+Jn+GMNaMESHcBcff8HEdn/N66fo57yV/4to5lz+feicIMdUhLR+e5ZFM1DbJi1xYPbznYn7pBAYRE1BQHeNeLovf4Xw9sXFmg12W6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(66946007)(66446008)(64756008)(66556008)(66476007)(76116006)(5660300002)(4326008)(52536014)(122000001)(186003)(71200400001)(53546011)(8676002)(9686003)(6506007)(8936002)(38100700002)(26005)(2906002)(7696005)(33656002)(38070700005)(55016003)(110136005)(316002)(86362001)(508600001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SGhCSW5OY2NHazdYQzJxYnRKejZFbDUzcXI2bVlLcFFLc3dQalN4bXBvNG8y?=
 =?utf-8?B?d3dGZTBPWGVuVUM1VElTa2FtYUsrR0g1ZFlRV24rY3BJQm16K1B1UnNpT0li?=
 =?utf-8?B?N2ZFWFMrRVBkTDJ2ekgzMWFjMkNReDZya3B5R0FEa2pvNFJkT2Y0V2xoM2ZC?=
 =?utf-8?B?Ri9mcDByY051dXZuNG1iUTV2Wk9WV05oNzNHUW5PdzZ0UnBjOGo5RWhmU3RN?=
 =?utf-8?B?TVJBTUxZay9pU1JkK29NUWU2bkkzQzNqa3hlSC9hclRmMTFVZDVwV1huTFFR?=
 =?utf-8?B?cXd1aGh4SDh2VzM0WnBFeWxJZi9xMC9HUXQvTmNxQnZSb01Jdk1ENEdRRkp2?=
 =?utf-8?B?MWUvMEtIVVl3aytHYkNkYzNPTFgyWmtBQ3pPbWo4RG5hNHBac3dkcTd0R3VE?=
 =?utf-8?B?YWg1Sm52L2VtSFpsWk1KQWFIZFRoRFdCOC9lSUgwM2pIRkwwUldxays2VTc0?=
 =?utf-8?B?RytzWm90cnRkM1lWU1dacjRUa3I2TjMvT0NnMHc1NVhacW00NTVZUFhGdjNp?=
 =?utf-8?B?R0NRbURkYVpiZmlCVHdBNE5pSjlSRUxFZmdEeFlwN2VzTFpwamtOUnJKdHpG?=
 =?utf-8?B?K0QybXhTdmE0Q2ZEdTlQYkVqeTlVVVFZeVpZM1N4amxGUTAzRUVIMnZscFJJ?=
 =?utf-8?B?anFYUzZtcE9scm9ldVdQRThhMjZxZVN2SjFrU3NIdU5XTWxwQys1aTBOM1ZH?=
 =?utf-8?B?M093UFVQemV3UEtxbG5hTXJ5aW1kR25paysrcmRWM2orQ0RKQWJBaUJ5MlJz?=
 =?utf-8?B?UGtTdXpmaU94dVJ0OWJWN0I5QnlSa3pPcGVJaVBYSDZ6dkhPTFNtakVQTUFm?=
 =?utf-8?B?OWJGdjdxRjdZV0k3Wkh6cGFvclVEeEIwdFpFcjJYSDdBWkhYS1BuOFVGdlpn?=
 =?utf-8?B?dlNCZGpTODNvQ2Yxbkp1ZlpETzVWa0hoZUs1bHN5bytmNUNWb1pnZkFBd3VJ?=
 =?utf-8?B?cSthU2hhTm84WDhSdi9OMThnQW5abzZSZWFQNzQ3R1NrejZXQ2ExT1ZYc3Fr?=
 =?utf-8?B?THQ0YzI4N3ViYmtzU25xb01CSjNQaU5VdERaYmprdVVTUEpqTGNPNXBuMGhD?=
 =?utf-8?B?N3NrUlc0YmJMSWNnK1BSYVM3a1Y5TjNBbXlsLzNlMFlNTTgrdmFZcVJWdVJk?=
 =?utf-8?B?b0xnS1BBTzNKdTdpbytOMUpDczY4SGpqZGN4VmdnZW0rTFFPdHNYNXNOMmEw?=
 =?utf-8?B?TllmTmZsQm5QWjlpNlllY0NHeVNmeTdjb3Y0Z1NLdmVMclVnRU40cm5VTWFz?=
 =?utf-8?B?S3lnWEJyeWxLRHhHbzRTcXJ3eHF2NTBNd0daRnlEdTl1dkxxOGJ2aFZhU21w?=
 =?utf-8?B?ZWxVeTdxRFdSRnRWY2xxWUlkclJHcEk4YUxzZ1p5cWlXbHB4S2pTS2IwUnhU?=
 =?utf-8?B?enlkODIvYU9hQjlDaDE3T1QyQjBWY1R0UlJXSmpMY1MvbUExU0VPdXh0eFNx?=
 =?utf-8?B?QVM2YzZMWGRiakxaS3VoZGdyVHVpZ0NaWENMckhadzdoSmkrelI1RHVvNnZz?=
 =?utf-8?B?MnB2YnN1ZDZKWDhvMzZ2RlVoVjI0bFBUbmJQbWFTazBtNGMwZnhqM3ZTQ0J1?=
 =?utf-8?B?QkVlUXRTdEtNSkVJWEN6NVp4eVAyVE5VUjV2ZUlmVlhIZC9OcHQ3NE9hNXBW?=
 =?utf-8?B?NGpRclZlcFVYV2pLT1ZjdlYwUm1wYkdZTnlFZWNNYy8wcEFMb3dSK2pzSHJN?=
 =?utf-8?B?ZmpwUFRlNVV6eEluK2pnMkhLUzFoekpKRVhoVWVudGh0TFVvS0M1WHdQRFl3?=
 =?utf-8?B?NzJ4c2JPUG9PT09OTngrQmlsWVdnSHk3dnBkV0JneklMN0tUbUo3bW5HMC9s?=
 =?utf-8?B?a1doZ2RMTDZFK2Q3amRBZjdzNHdNNkVPa2swZmJadWJyK3M4SDM0TmRuOGRJ?=
 =?utf-8?B?RnlFeURLZGJUb3NLeGJTMUdmSjAwWWtoSWdYMmYyejVhWkZiZUNNT3ljNXNT?=
 =?utf-8?B?SlVMZFVIZGpZOXhDT284QjJXNk92VVU0R0FpRHBaRGRscWE4UGtYYTBUQUhl?=
 =?utf-8?B?UEhtMlFzVXFKODVzYmpTU0wxcWVzODdiZU8ySmhNZ2lIaHN1OFFpYWZ6aXd3?=
 =?utf-8?B?MllOUERkK2dXeEt5TXg4Qm1oYTB4Z0cvY21tRk1ZT25KVEh6U01jOEdid09Q?=
 =?utf-8?B?c2VueGlGVVpuMFdlalk3MTU0WDdRMzl1cWpXVG5XL0txZTRuNFR1enhqV05p?=
 =?utf-8?B?WEpTN2hYODdWdXFwa09Gam5Oa3dra1ZGZG0xUFhIcFIwTG1WRmxFMlBGZmVN?=
 =?utf-8?B?YThDajR6eVZEZ0NPUlFXTU9pWWtnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb8f05a-6f0c-4d17-c2c0-08d9b3e58701
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2021 09:41:04.2213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bj58wak0jp4gCNXbz6TICNnWtysqsiEmxKvrJkZas3Z5kryxg+2cl9ePYLrHiH/TU342r8sRw8NsBCXsToSEpdbFvvjtZ4ZhpIXyETUPwQA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR10MB1929
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkgTm92ZW1iZXIgMjAyMSAxMjoxMiwgQW5kcmVqIFBpY2VqIHdyb3RlOg0KDQo+ID4gSSdt
IGEgbGl0dGxlIGNvbmNlcm5lZCBhYm91dCBmb3JjaW5nIHRoaXMgY2hhbmdlIGluIHRoZSBkcml2
ZXIuIFRoZXJlIG1heSBiZQ0KPiA+IHBsYXRmb3JtcyB3aGljaCBkb24ndCB3YW50IHRoZSBQTUlD
IHRvIHBlcmZvcm0gYSBmdWxsIHJlc2V0IHRocm91Z2ggT1RQIHJlLQ0KPiByZWFkDQo+ID4gYW5k
IGlmIHdlIGhhcmQgY29kZSB0aGlzIGNoYW5nZSB0aGVuIHRoYXQncyBpbXBhY3RpbmcgdGhvc2Ug
cGxhdGZvcm1zLiBJZiB3ZQ0KPiA+IHdhbnQvbmVlZCB0aGlzIHRoZW4gSSB0aGluayBpdCBzaG91
bGQgcHJvYmFibHkgYmUgYSBEVCBiaW5kaW5nIGZvciBkYTkwNjEvMg0KPiA+IHdoaWNoIHRoZW4g
aW5kaWNhdGVzIHRoZSBiZWhhdmlvdXIgd2Ugd2FudC4NCj4gDQo+IE9rLCBJIHNlZSB0aGUgaW1w
YWN0IHRoaXMgbWlnaHQgaGF2ZSBvbiB0aGUgcGxhdGZvcm1zIHRoYXQgYXJlIHJlbHlpbmcNCj4g
b24gdGhlIGN1cnJlbnQgZGVmYXVsdCBzZXR0aW5nLiBJIHdpbGwgc3RhcnQgb24gdGhlIERUIGJp
bmRpbmcNCj4gaW1wbGVtZW50YXRpb24gYW5kIHN1Ym1pdCBhIG5ldyBwYXRjaC4NCg0KVGhhbmtz
LiBQcm9iYWJseSB0aGUgc2FmZXN0IHJvdXRlLg0KDQo+IA0KPiA+DQo+ID4gTlJFU19NT0RFIGJp
dCBhbHNvIHBsYXlzIGEgcGFydCBoZXJlIGFzIGl0IGNvbnRyb2xzIHdoZXRoZXIgb3Igbm90IHRo
ZSBuUkVTRVQNCj4gPiBsaW5lIHN0YXRlIGlzIGNoYW5nZWQgYXMgcGFydCBvZiB0aGUgcG93ZXIt
ZG93bi91cCBwcm9jZXNzLiBJJ20gYXNzdW1pbmcgZm9yDQo+ID4geW91ciBzZXR1cCB0aGlzIGJp
dCBpcyAwPw0KPiA+DQo+IFdlIGxlYXZlIE5SRVNfTU9ERSBhcyBpdCBpcywgMCBieSBkZWZhdWx0
IEkgZ3Vlc3M/IFNvIGRvIHlvdSB3YW50IGENCj4gc2VwYXJhdGUgZHQgYmluZGluZyBmb3IgTlJF
U19NT0RFPw0KDQpJIHRoaW5rIHRoZSBzZXR0aW5nIHZlcnkgbXVjaCBkZXBlbmRzIG9uIHRoZSBj
dXN0b21lcnMgT1RQIGNvbmZpZyBzZWxlY3Rpb24uIEZvcg0Kbm93IHdlIGNhbiBsZWF2ZSB0aGlz
IG9wdGlvbi4gSnVzdCB3YW50ZWQgdG8gaGlnaGxpZ2h0IGl0Lg0K
