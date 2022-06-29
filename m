Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D2E55F50C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiF2ERN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbiF2ERG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:17:06 -0400
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD9361FCCB;
        Tue, 28 Jun 2022 21:17:02 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(2574:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Wed, 29 Jun 2022 11:31:55 +0800 (CST)
Received: from sphcmbx01.sunplus.com.tw (172.17.9.202) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 29 Jun 2022 11:31:49 +0800
Received: from sphcmbx01.sunplus.com.tw ([fe80::bdb5:968f:d409:32d1]) by
 sphcmbx01.sunplus.com.tw ([fe80::bdb5:968f:d409:32d1%14]) with mapi id
 15.00.1497.033; Wed, 29 Jun 2022 11:31:49 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>,
        "krzk@kernel.org" <krzk@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "amitk@kernel.org" <amitk@kernel.org>,
        "rui.zhang@intel.com" <rui.zhang@intel.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v9 1/2] thermal: Add thermal driver for Sunplus
Thread-Topic: [PATCH v9 1/2] thermal: Add thermal driver for Sunplus
Thread-Index: AQHYfGnSmcz0ONeaZ065CGG9qHLjyK1Hct0AgB5lyhA=
Date:   Wed, 29 Jun 2022 03:31:48 +0000
Message-ID: <254b6c711c9a464cb23d1eb5957a6af9@sphcmbx01.sunplus.com.tw>
References: <CAGcXWkzJwOPXfE6ESAtwBbe7W-UkApKosKUy=UBRh0kmi-Bc2Q@mail.gmail.com>
 <395072af-3349-cead-fe07-62d3d758d635@infradead.org>
In-Reply-To: <395072af-3349-cead-fe07-62d3d758d635@infradead.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.51]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SSdtIHNvcnJ5IGZvciB0aGUgd3JvbmcgaW5kZW50YXRpb24gcHJvYmxlbSwgaXQgd2FzIGNhdXNl
ZCBieSBhIHdyb25nIHNldHRpbmcgaW4gdGhlIG1haWwgc2VydmVyLkkgd2lsbCBmaXggaXQgaW4g
dGhlIG5leHQgcGF0Y2guDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
UmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQo+IFNlbnQ6IEZyaWRheSwgSnVu
ZSAxMCwgMjAyMiAxMToyMCBBTQ0KPiBUbzog6YOt5Yqb6LGqIDxsaGplZmY5MTFAZ21haWwuY29t
Pjsga3J6a0BrZXJuZWwub3JnOyByYWZhZWxAa2VybmVsLm9yZzsgRGFuaWVsIExlemNhbm8NCj4g
PGRhbmllbC5sZXpjYW5vQGxpbmFyby5vcmc+OyBhbWl0a0BrZXJuZWwub3JnOyBydWkuemhhbmdA
aW50ZWwuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxpbnV4LXBtQHZnZXIua2VybmVsLm9y
ZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmcNCj4gQ2M6IExoIEt1byDpg63lipvosaogPGxoLkt1b0BzdW5wbHVzLmNvbT47IFdlbGxzIEx1
IOWRguiKs+mosCA8d2VsbHMubHVAc3VucGx1cy5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
djkgMS8yXSB0aGVybWFsOiBBZGQgdGhlcm1hbCBkcml2ZXIgZm9yIFN1bnBsdXMNCj4gDQo+IEhp
LS0NCj4gDQo+IE9uIDYvOS8yMiAxODozMiwg6YOt5Yqb6LGqIHdyb3RlOg0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBiL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnIGlu
ZGV4DQo+ID4gMGU1Y2M5NC4uYzg1ZTY2OCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3RoZXJt
YWwvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZlcnMvdGhlcm1hbC9LY29uZmlnDQo+ID4gQEAgLTUw
NCw0ICs1MDQsMTQgQEAgY29uZmlnIEtIQURBU19NQ1VfRkFOX1RIRVJNQUwNCj4gPiAgICAgSWYg
eW91IHNheSB5ZXMgaGVyZSB5b3UgZ2V0IHN1cHBvcnQgZm9yIHRoZSBGQU4gY29udHJvbGxlZA0K
PiA+ICAgICBieSB0aGUgTWljcm9jb250cm9sbGVyIGZvdW5kIG9uIHRoZSBLaGFkYXMgVklNIGJv
YXJkcy4NCj4gPg0KPiA+ICtjb25maWcgU1VOUExVU19USEVSTUFMDQo+ID4gKyB0cmlzdGF0ZSAi
U3VucGx1cyB0aGVybWFsIGRyaXZlcnMiDQo+ID4gKyBkZXBlbmRzIG9uIFNPQ19TUDcwMjEgfHwg
Q09NUElMRV9URVNUICBoZWxwDQo+ID4gKyAgIFRoaXMgZW5hYmxlIHRoZSBTdW5wbHVzIFNQNzAy
MSB0aGVybWFsIGRyaXZlciwgd2hpY2ggc3VwcG9ydHMgdGhlIHByaW1pdGl2ZQ0KPiA+ICsgICB0
ZW1wZXJhdHVyZSBzZW5zb3IgZW1iZWRkZWQgaW4gU3VucGx1cyBTUDcwMjEgU29DLg0KPiA+ICsN
Cj4gPiArICAgSWYgeW91IGhhdmUgYSBTdW5wbHVzIFNQNzAyMSBwbGF0Zm9ybSBzYXkgWSBoZXJl
IGFuZCBlbmFibGUgdGhpcyBvcHRpb24NCj4gPiArICAgdG8gaGF2ZSBzdXBwb3J0IGZvciB0aGVy
bWFsIG1hbmFnZW1lbnQNCj4gDQo+IEVuZCB0aGUgc2VudGVuY2UgYWJvdmUgd2l0aCBhIHBlcmlv
ZCAoJy4nKS4NCj4gDQo+IEFuZCB0aGUgaW5kZW50YXRpb24gaGVyZSBpcyBhbGwgbWVzc2VkIHVw
Lg0KPiBTZWUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3Q6DQo+IA0KPiAx
MCkgS2NvbmZpZyBjb25maWd1cmF0aW9uIGZpbGVzDQo+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0NCj4gDQo+IEZvciBhbGwgb2YgdGhlIEtjb25maWcqIGNvbmZpZ3VyYXRpb24gZmls
ZXMgdGhyb3VnaG91dCB0aGUgc291cmNlIHRyZWUsIHRoZSBpbmRlbnRhdGlvbiBpcyBzb21ld2hh
dA0KPiBkaWZmZXJlbnQuICBMaW5lcyB1bmRlciBhIGBgY29uZmlnYGAgZGVmaW5pdGlvbiBhcmUg
aW5kZW50ZWQgd2l0aCBvbmUgdGFiLCB3aGlsZSBoZWxwIHRleHQgaXMgaW5kZW50ZWQgYW4NCj4g
YWRkaXRpb25hbCB0d28gc3BhY2VzLg0KPiANCj4gDQo+ID4gKw0KPiA+ICBlbmRpZg0KPiANCj4g
LS0NCj4gflJhbmR5DQo=
