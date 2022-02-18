Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D62B14BB3EA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232390AbiBRIK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:10:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiBRIKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:10:25 -0500
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1229A38182;
        Fri, 18 Feb 2022 00:10:06 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(314:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Fri, 18 Feb 2022 16:10:13 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 18 Feb 2022 16:10:13 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 18 Feb 2022 16:10:13 +0800
From:   =?utf-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Topic: [PATCH v4] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Index: AQHYG/cOqjt4Bbqwy06Z29eKCBs1J6yIApeAgApaEBD//8HxAIAG4ruw
Date:   Fri, 18 Feb 2022 08:10:13 +0000
Message-ID: <eca9b5a613c9417cacdcb90eef5b2235@sphcmbx02.sunplus.com.tw>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
 <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
 <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
 <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
In-Reply-To: <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.40]
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

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgS296
bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IE1vbmRh
eSwgRmVicnVhcnkgMTQsIDIwMjIgMjo0NSBQTQ0KPiBUbzogRWR3aW4gQ2hpdSDpgrHlnoLls7Ag
PGVkd2luLmNoaXVAc3VucGx1cy5jb20+OyBFZHdpbiBDaGl1IDxlZHdpbmNoaXUwNTA1dHdAZ21h
aWwuY29tPjsNCj4gcm9iaCtkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9y
ZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGRh
bmllbC5sZXpjYW5vQGxpbmFyby5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIHY0XSBjcHVpZGxlOiBzdW5wbHVzOiBDcmVhdGUgY3B1aWRsZSBkcml2
ZXIgZm9yIHN1bnBsdXMgc3A3MDIxDQo+IA0KPiBPbiAxNC8wMi8yMDIyIDAzOjU1LCBFZHdpbiBD
aGl1IOmCseWeguWzsCB3cm90ZToNCj4gPiBIaSBLcnp5c3p0b2Y6DQo+ID4NCj4gPiBQbGVhc2Ug
c2VlIGJlbG93IGFuc3dlci4NCj4gPg0KPiA+Pj4gK3N0YXRpYyBzdHJ1Y3QgY3B1aWRsZV9kcml2
ZXIgc3A3MDIxX2lkbGVfZHJpdmVyID0gew0KPiA+Pj4gKwkubmFtZSA9ICJzcDcwMjFfaWRsZSIs
DQo+ID4+PiArCS5vd25lciA9IFRISVNfTU9EVUxFLA0KPiA+Pj4gKwkvKg0KPiA+Pj4gKwkgKiBT
dGF0ZSBhdCBpbmRleCAwIGlzIHN0YW5kYnkgd2ZpIGFuZCBjb25zaWRlcmVkIHN0YW5kYXJkDQo+
ID4+PiArCSAqIG9uIGFsbCBBUk0gcGxhdGZvcm1zLiBJZiBpbiBzb21lIHBsYXRmb3JtcyBzaW1w
bGUgd2ZpDQo+ID4+PiArCSAqIGNhbid0IGJlIHVzZWQgYXMgInN0YXRlIDAiLCBEVCBiaW5kaW5n
cyBtdXN0IGJlIGltcGxlbWVudGVkDQo+ID4+PiArCSAqIHRvIHdvcmsgYXJvdW5kIHRoaXMgaXNz
dWUgYW5kIGFsbG93IGluc3RhbGxpbmcgYSBzcGVjaWFsDQo+ID4+PiArCSAqIGhhbmRsZXIgZm9y
IGlkbGUgc3RhdGUgaW5kZXggMC4NCj4gPj4+ICsJICovDQo+ID4+PiArCS5zdGF0ZXNbMF0gPSB7
DQo+ID4+PiArCQkuZW50ZXIgICAgICAgICAgICAgICAgICA9IHNwNzAyMV9lbnRlcl9pZGxlX3N0
YXRlLA0KPiA+Pj4gKwkJLmV4aXRfbGF0ZW5jeSAgICAgICAgICAgPSAxLA0KPiA+Pj4gKwkJLnRh
cmdldF9yZXNpZGVuY3kgICAgICAgPSAxLA0KPiA+Pj4gKwkJLnBvd2VyX3VzYWdlCQk9IFVJTlRf
TUFYLA0KPiA+Pj4gKwkJLm5hbWUgICAgICAgICAgICAgICAgICAgPSAiV0ZJIiwNCj4gPj4+ICsJ
CS5kZXNjICAgICAgICAgICAgICAgICAgID0gIkFSTSBXRkkiLA0KPiA+Pg0KPiA+PiBJIGhhdmUg
aW1wcmVzc2lvbiB0aGF0IHRoZXJlIGlzIG5vIHBvaW50IGluIGhhdmluZyBjdXN0b20gZHJpdmVy
IHdpdGggV0ZJLi4uDQo+ID4+DQo+ID4+IFN0aWxsIHRoZSBtYWluIHF1ZXN0aW9uIGZyb20gRGFu
aWVsIGFuZCBTdWRlZXAgc3RheXM6IHdoeSBkbyB5b3UgbmVlZA0KPiA+PiB0aGlzPyBZb3UgY29w
aWVkIGV4YWN0bHkgY3B1aWxkbGUtYXJtIGRyaXZlciwgdGhlcmUgaXMgbm90aGluZw0KPiA+PiBk
aWZmZXJlbnQgaGVyZS4gQXQgbGVhc3QgSSBjb3VsZCBub3Qgc3BvdCBkaWZmZXJlbmNlcy4gTWF5
YmUgZXhjZXB0IHRoYXQgeW91IHVzZSBjcHVfdjdfZG9faWRsZQ0KPiBleHBsaWNpdGx5Lg0KPiA+
Pg0KPiA+PiBVbmZvcnR1bmF0ZWx5IEkgY2Fubm90IHVuZGVyc3RhbmQgdGhlIGV4cGxhbmF0aW9u
IGhlcmU6DQo+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8wODEyYzQ0Zjc3N2Q0MDI2
Yjc5ZGYyZTM2OTgyOTRiZUBzcGhjbWJ4MA0KPiA+PiAyLnN1bnBsdXMuY29tLnR3LyBXaHkgZXhh
Y3RseSBjcHVpZGxlLWFybSBkb2VzIG5vdCB3b3JrIGluIHlvdXIgY2FzZT8NCj4gPj4NCj4gPiBF
ZHdpbj0+IEkgbWVhbiBjcHVpZGxlLWFybSBkcml2ZXIgY2FuJ3QgZGlyZWN0bHkgdXNlIHdpdGgg
bm8gbW9kaWZpZWQuDQo+ID4gICAgICAgIElmIHNvbWVvbmUgd2FudCB0byB1c2UgY3B1aWRsZS1h
cm0gZHJpdmVyLCBiZWxvdyBtb2RpZmljYXRpb24gc2VlbXMgbmVjZXNzYXJ5Lg0KPiA+DQo+IH5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gICAgICAgIFN0YXRpYyBpbnQgc3A3MDIxX2NwdWlkbGVf
c3VzcGVuZF9lbnRlcih1bnNpZ25lZCBsb25nIGluZGV4KSB7fn0NCj4gPiAgICAgICAgU3RhdGlj
IGludCBfX2luaXQgc3A3MDIxX2NwdWlkbGVfaW5pdChzdHJ1Y3QgZGV2aWNlX25vZGUgKmNwdV9u
b2RlLCBpbnQgY3B1KSB7fn0NCj4gPiAgICAgICAgU3RhdGljIGNvbnN0IHN0cnVjdCBjcHVpZGxl
X29wcyBzY19zbXBfb3BzIF9faW5pdGNvbnN0ID0gew0KPiA+ICAgICAgICAgICAgIC5zdXNwZW5k
ID0gc3A3MDIxX2NwdWlkbGVfc3VzcGVuZF9lbnRlciwNCj4gPiAgICAgICAgICAgICAuaW5pdCA9
IHNwNzAyMV9jcHVpZGxlX2luaXQsDQo+ID4gICAgICAgIH07DQo+ID4gICAgICAgIENQVUlETEVf
TUVUSE9EX09GX0RFQ0xBUkUoc2Nfc21wLCAic3VucGx1cyxzYy1zbXAiLCAmc2Nfc21wX29wcyk7
IC8vZGVjbGFyZQ0KPiBlbmFibGUgbWV0aG9kDQo+ID4NCj4gPiB+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4g
fn5+fn5+fn5+fg0KPiA+DQo+ID4gICAgICAgIEJ1dCBjaGFuZ2UgY3B1aWxkZS1hcm0uYyBmb3Ig
c3VucGx1cyBkcml2ZXIgc2VlbXMgbm90IHJlYXNvbmFibGUuDQo+ID4gICAgICAgIFRoYXQgaXMg
d2h5IEkgd2FudCB0byBzdWJtaXQgY3B1aWRsZS1zdW5wbHVzLmMNCj4gPiAgICAgICAgQWx0aG91
Z2h0IHN1bnBsdXMgY3B1aWRsZSBvbmx5IGNvbWUgaW4gV0ZJLCBidXQgaXQgY2FuIGNvbXBsZXRl
IHRoZSBjcHVpZGxlIGZyYW1ld29yay4NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgaXQgaXMgY29ycmVj
dC4gWW91IGNhbiB1c2UgY3B1aWRsZS1hcm0sIGJlY2F1c2UgaXQgaXMgYmVpbmcgYWx3YXlzIGlu
aXRpYWxpemVkIHdpdGgNCj4gZGV2aWNlX2luaXRjYWxsKCkuIFlvdSBlaXRoZXIgdXNlIGFwcHJv
cHJpYXRlIGNvbXBhdGlibGUgaW4gRFQgb3IgYWRkIHlvdXIgY29tcGF0aWJsZSB0byBjcHVpZGxl
LWFybS4NCj4gDQo+IEV2ZW4gaWYgdGhpcyBkaWQgbm90IHdvcmssIHRoZW4gdGhlIHNvbHV0aW9u
IGlzIHRvIHVzZSBjb21tb24gcGFydHMsIG5vdCB0byBkdXBsaWNhdGUgZW50aXJlIGRyaXZlci4N
Cj4gRHVwbGljYXRpbmcgaXMgbm90IGFjY2VwdGFibGUuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+
IEtyenlzenRvZg0KDQoNCkkgZG8gdXNlZCBjb21wYXRpYmxlID0gImFybSxpZGxlLXN0YXRlIiBp
biBEVCBhbmQgZW5hYmxlIGdlbmVyaWMgYXJtIGNwdWlkbGUgZHJpdmVyIGluIG1lbnVjb25maWcu
DQpCdXQgdGhlcmUgaGF2ZSBtb3VudCBkcml2ZXIgZmFpbCBtZXNzYWdlIGR1ZSB0byBubyBjcHVp
ZGxlX29wcyBmdW5jdGlvbnMuDQpUaGF0IGlzIHdoeSBJIG5lZWQgYWRkZWQgcGF0Y2ggY29kZSB0
byBjb21wbGV0ZSBjcHVpZGxlIGRyaXZlci4NCkFjY29yZGluZyB5b3VyIGNvbW1lbnQsIEkgd2ls
bCB0cnkgdG8gdXNlIGNvbW1vbiBwYXJ0cyBhbmQgaG9vayBzb21lIGN1c3RvbSBjb2RlLCBsYXRl
ci4gDQpUaGFua3MuDQoNCumCseWeguWzsCBFZHdpbkNoaXUNCuaZuuiDvemBi+eul+WwiOahiA0K
VDogKzg4Ni0zLTU3ODYwMDUgZXh0LjI1OTANCmVkd2luLmNoaXVAc3VucGx1cy5jb20NCjMwMCDm
lrDnq7nnp5HlrbjlnJLljYDlibXmlrDkuIDot68xOeiZnw0K
