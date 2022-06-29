Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6158755F502
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 06:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiF2ERJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 00:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiF2ERG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 00:17:06 -0400
X-Greylist: delayed 1798 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 28 Jun 2022 21:17:02 PDT
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ADA4E20BE8;
        Tue, 28 Jun 2022 21:17:02 -0700 (PDT)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(2567:0:AUTH_RELAY)
        (envelope-from <lh.Kuo@sunplus.com>); Wed, 29 Jun 2022 11:31:10 +0800 (CST)
Received: from sphcmbx01.sunplus.com.tw (172.17.9.202) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Wed, 29 Jun 2022 11:31:09 +0800
Received: from sphcmbx01.sunplus.com.tw ([fe80::bdb5:968f:d409:32d1]) by
 sphcmbx01.sunplus.com.tw ([fe80::bdb5:968f:d409:32d1%14]) with mapi id
 15.00.1497.033; Wed, 29 Jun 2022 11:31:09 +0800
From:   =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?utf-8?B?6YOt5Yqb6LGq?= <lhjeff911@gmail.com>,
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
Thread-Index: AQHYfGnSmcz0ONeaZ065CGG9qHLjyK1Hct0AgAB4UYCAHe07gA==
Date:   Wed, 29 Jun 2022 03:31:08 +0000
Message-ID: <1eeaba5aeacc4f9e951e8845f15d5c64@sphcmbx01.sunplus.com.tw>
References: <CAGcXWkzJwOPXfE6ESAtwBbe7W-UkApKosKUy=UBRh0kmi-Bc2Q@mail.gmail.com>
 <395072af-3349-cead-fe07-62d3d758d635@infradead.org>
 <e68724b0-4a9f-f564-c833-befd6c3515fb@linaro.org>
In-Reply-To: <e68724b0-4a9f-f564-c833-befd6c3515fb@linaro.org>
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
dGhlIG5leHQgcGF0Y2guDQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+DQo+
IFNlbnQ6IEZyaWRheSwgSnVuZSAxMCwgMjAyMiA2OjMwIFBNDQo+IFRvOiBSYW5keSBEdW5sYXAg
PHJkdW5sYXBAaW5mcmFkZWFkLm9yZz47IOmDreWKm+ixqiA8bGhqZWZmOTExQGdtYWlsLmNvbT47
IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBEYW5pZWwgTGV6Y2FubyA8ZGFuaWVsLmxlemNhbm9AbGlu
YXJvLm9yZz47IGFtaXRrQGtlcm5lbC5vcmc7IHJ1aS56aGFuZ0BpbnRlbC5jb207DQo+IHJvYmgr
ZHRAa2VybmVsLm9yZzsgbGludXgtcG1Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KPiBDYzogTGggS3Vv
IOmDreWKm+ixqiA8bGguS3VvQHN1bnBsdXMuY29tPjsgV2VsbHMgTHUg5ZGC6Iqz6aiwIDx3ZWxs
cy5sdUBzdW5wbHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2OSAxLzJdIHRoZXJtYWw6
IEFkZCB0aGVybWFsIGRyaXZlciBmb3IgU3VucGx1cw0KPiANCj4gT24gMTAvMDYvMjAyMiAwNTox
OSwgUmFuZHkgRHVubGFwIHdyb3RlOg0KPiA+IEhpLS0NCj4gPg0KPiA+IE9uIDYvOS8yMiAxODoz
Miwg6YOt5Yqb6LGqIHdyb3RlOg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy90aGVybWFsL0tj
b25maWcgYi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZyBpbmRleA0KPiA+PiAwZTVjYzk0Li5jODVl
NjY4IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+PiArKysg
Yi9kcml2ZXJzL3RoZXJtYWwvS2NvbmZpZw0KPiA+PiBAQCAtNTA0LDQgKzUwNCwxNCBAQCBjb25m
aWcgS0hBREFTX01DVV9GQU5fVEhFUk1BTA0KPiA+PiAgICAgSWYgeW91IHNheSB5ZXMgaGVyZSB5
b3UgZ2V0IHN1cHBvcnQgZm9yIHRoZSBGQU4gY29udHJvbGxlZA0KPiA+PiAgICAgYnkgdGhlIE1p
Y3JvY29udHJvbGxlciBmb3VuZCBvbiB0aGUgS2hhZGFzIFZJTSBib2FyZHMuDQo+ID4+DQo+ID4+
ICtjb25maWcgU1VOUExVU19USEVSTUFMDQo+ID4+ICsgdHJpc3RhdGUgIlN1bnBsdXMgdGhlcm1h
bCBkcml2ZXJzIg0KPiA+PiArIGRlcGVuZHMgb24gU09DX1NQNzAyMSB8fCBDT01QSUxFX1RFU1Qg
IGhlbHANCj4gPj4gKyAgIFRoaXMgZW5hYmxlIHRoZSBTdW5wbHVzIFNQNzAyMSB0aGVybWFsIGRy
aXZlciwgd2hpY2ggc3VwcG9ydHMgdGhlIHByaW1pdGl2ZQ0KPiA+PiArICAgdGVtcGVyYXR1cmUg
c2Vuc29yIGVtYmVkZGVkIGluIFN1bnBsdXMgU1A3MDIxIFNvQy4NCj4gPj4gKw0KPiA+PiArICAg
SWYgeW91IGhhdmUgYSBTdW5wbHVzIFNQNzAyMSBwbGF0Zm9ybSBzYXkgWSBoZXJlIGFuZCBlbmFi
bGUgdGhpcyBvcHRpb24NCj4gPj4gKyAgIHRvIGhhdmUgc3VwcG9ydCBmb3IgdGhlcm1hbCBtYW5h
Z2VtZW50DQo+ID4NCj4gPiBFbmQgdGhlIHNlbnRlbmNlIGFib3ZlIHdpdGggYSBwZXJpb2QgKCcu
JykuDQo+ID4NCj4gPiBBbmQgdGhlIGluZGVudGF0aW9uIGhlcmUgaXMgYWxsIG1lc3NlZCB1cC4N
Cj4gPiBTZWUgRG9jdW1lbnRhdGlvbi9wcm9jZXNzL2NvZGluZy1zdHlsZS5yc3Q6DQo+ID4NCj4g
DQo+IEl0J3Mgbm90IG9ubHkgdGhpcyBvbmUuIEVudGlyZSBmaWxlIGhhcyB3cm9uZyBpbmRlbnRh
dGlvbi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQo=
