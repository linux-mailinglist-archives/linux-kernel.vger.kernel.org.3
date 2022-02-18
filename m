Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194AE4BB47A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 09:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiBRInX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 03:43:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiBRInV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 03:43:21 -0500
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ACA7F298AC9;
        Fri, 18 Feb 2022 00:43:03 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(32753:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Fri, 18 Feb 2022 16:43:15 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 18 Feb 2022 16:43:15 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 18 Feb 2022 16:43:15 +0800
From:   =?utf-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
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
Thread-Index: AQHYG/cOqjt4Bbqwy06Z29eKCBs1J6yIApeAgApaEBD//8HxAIAANpMAgAa1xTA=
Date:   Fri, 18 Feb 2022 08:43:14 +0000
Message-ID: <2ff2ec3f14b24565bafb29b43be1dc4e@sphcmbx02.sunplus.com.tw>
References: <cover.1644218105.git.edwinchiu0505tw@gmail.com>
 <957d882222d218b62fe3fb7a069e2f7952afc5be.1644218105.git.edwinchiu0505tw@gmail.com>
 <64f91b1a-93b9-941d-fdfa-271e198e1ab5@canonical.com>
 <0edae7bea1ae47cd9044cd223a989b81@sphcmbx02.sunplus.com.tw>
 <136f2087-10e7-c9e8-2292-3046711c8f68@canonical.com>
 <20220214095950.vt7fkvrkvio3gtkw@bogus>
In-Reply-To: <20220214095950.vt7fkvrkvio3gtkw@bogus>
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

DQoNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBTdWRlZXAgSG9sbGEg
PHN1ZGVlcC5ob2xsYUBhcm0uY29tPg0KPiBTZW50OiBNb25kYXksIEZlYnJ1YXJ5IDE0LCAyMDIy
IDY6MDAgUE0NCj4gVG86IEVkd2luIENoaXUg6YKx5Z6C5bOwIDxlZHdpbi5jaGl1QHN1bnBsdXMu
Y29tPg0KPiBDYzogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBjYW5v
bmljYWwuY29tPjsgRWR3aW4gQ2hpdQ0KPiA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT47IHJv
YmgrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOyBkYW5pZWwubGV6Y2Fub0Bs
aW5hcm8ub3JnOyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2NF0gY3B1aWRsZTogc3VucGx1czogQ3JlYXRlIGNwdWlkbGUgZHJpdmVyIGZvciBzdW5wbHVz
IHNwNzAyMQ0KPiANCj4gT24gTW9uLCBGZWIgMTQsIDIwMjIgYXQgMDc6NDQ6MzBBTSArMDEwMCwg
S3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gPiBPbiAxNC8wMi8yMDIyIDAzOjU1LCBFZHdp
biBDaGl1IOmCseWeguWzsCB3cm90ZToNCj4gPiA+IEhpIEtyenlzenRvZjoNCj4gPiA+DQo+ID4g
PiBQbGVhc2Ugc2VlIGJlbG93IGFuc3dlci4NCj4gPiA+DQo+ID4gPj4+ICtzdGF0aWMgc3RydWN0
IGNwdWlkbGVfZHJpdmVyIHNwNzAyMV9pZGxlX2RyaXZlciA9IHsNCj4gPiA+Pj4gKwkubmFtZSA9
ICJzcDcwMjFfaWRsZSIsDQo+ID4gPj4+ICsJLm93bmVyID0gVEhJU19NT0RVTEUsDQo+ID4gPj4+
ICsJLyoNCj4gPiA+Pj4gKwkgKiBTdGF0ZSBhdCBpbmRleCAwIGlzIHN0YW5kYnkgd2ZpIGFuZCBj
b25zaWRlcmVkIHN0YW5kYXJkDQo+ID4gPj4+ICsJICogb24gYWxsIEFSTSBwbGF0Zm9ybXMuIElm
IGluIHNvbWUgcGxhdGZvcm1zIHNpbXBsZSB3ZmkNCj4gPiA+Pj4gKwkgKiBjYW4ndCBiZSB1c2Vk
IGFzICJzdGF0ZSAwIiwgRFQgYmluZGluZ3MgbXVzdCBiZSBpbXBsZW1lbnRlZA0KPiA+ID4+PiAr
CSAqIHRvIHdvcmsgYXJvdW5kIHRoaXMgaXNzdWUgYW5kIGFsbG93IGluc3RhbGxpbmcgYSBzcGVj
aWFsDQo+ID4gPj4+ICsJICogaGFuZGxlciBmb3IgaWRsZSBzdGF0ZSBpbmRleCAwLg0KPiA+ID4+
PiArCSAqLw0KPiA+ID4+PiArCS5zdGF0ZXNbMF0gPSB7DQo+ID4gPj4+ICsJCS5lbnRlciAgICAg
ICAgICAgICAgICAgID0gc3A3MDIxX2VudGVyX2lkbGVfc3RhdGUsDQo+ID4gPj4+ICsJCS5leGl0
X2xhdGVuY3kgICAgICAgICAgID0gMSwNCj4gPiA+Pj4gKwkJLnRhcmdldF9yZXNpZGVuY3kgICAg
ICAgPSAxLA0KPiA+ID4+PiArCQkucG93ZXJfdXNhZ2UJCT0gVUlOVF9NQVgsDQo+ID4gPj4+ICsJ
CS5uYW1lICAgICAgICAgICAgICAgICAgID0gIldGSSIsDQo+ID4gPj4+ICsJCS5kZXNjICAgICAg
ICAgICAgICAgICAgID0gIkFSTSBXRkkiLA0KPiA+ID4+DQo+ID4gPj4gSSBoYXZlIGltcHJlc3Np
b24gdGhhdCB0aGVyZSBpcyBubyBwb2ludCBpbiBoYXZpbmcgY3VzdG9tIGRyaXZlciB3aXRoIFdG
SS4uLg0KPiA+ID4+DQo+IA0KPiArMQ0KPiANCj4gPiA+PiBTdGlsbCB0aGUgbWFpbiBxdWVzdGlv
biBmcm9tIERhbmllbCBhbmQgU3VkZWVwIHN0YXlzOiB3aHkgZG8geW91DQo+ID4gPj4gbmVlZCB0
aGlzPyBZb3UgY29waWVkIGV4YWN0bHkgY3B1aWxkbGUtYXJtIGRyaXZlciwgdGhlcmUgaXMgbm90
aGluZw0KPiA+ID4+IGRpZmZlcmVudCBoZXJlLiBBdCBsZWFzdCBJIGNvdWxkIG5vdCBzcG90IGRp
ZmZlcmVuY2VzLiBNYXliZSBleGNlcHQNCj4gPiA+PiB0aGF0IHlvdSB1c2UgY3B1X3Y3X2RvX2lk
bGUgZXhwbGljaXRseS4NCj4gPiA+Pg0KPiANCj4gUGxlYXNlIGNvbW1lbnQgb3IgYW5zd2VyIHdo
eSB5b3UgY2FuJ3QgdXNlIHN0YW5kYXJkIGRyaXZlci4NCg0KSSBkbyB1c2VkIGNvbXBhdGlibGUg
PSAiYXJtLGlkbGUtc3RhdGUiIGluIERUIGFuZCBlbmFibGUgZ2VuZXJpYyBhcm0gY3B1aWRsZSBk
cml2ZXIgaW4gbWVudWNvbmZpZy4NCkJ1dCB0aGVyZSBoYXZlIG1vdW50IGRyaXZlciBmYWlsIG1l
c3NhZ2UgZHVlIHRvIG5vIGNwdWlkbGVfb3BzIGZ1bmN0aW9ucy4NClRoYXQgaXMgd2h5IEkgbmVl
ZCBhZGRlZCBwYXRjaCBjb2RlIHRvIGNvbXBsZXRlIGNwdWlkbGUgZHJpdmVyLg0KDQo+ID4gPj4g
VW5mb3J0dW5hdGVseSBJIGNhbm5vdCB1bmRlcnN0YW5kIHRoZSBleHBsYW5hdGlvbiBoZXJlOg0K
PiA+ID4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8wODEyYzQ0Zjc3N2Q0MDI2Yjc5ZGYy
ZTM2OTgyOTRiZUBzcGhjbWINCj4gPiA+PiB4MDIuc3VucGx1cy5jb20udHcvIFdoeSBleGFjdGx5
IGNwdWlkbGUtYXJtIGRvZXMgbm90IHdvcmsgaW4geW91cg0KPiA+ID4+IGNhc2U/DQo+ID4gPj4N
Cj4gPiA+IEVkd2luPT4gSSBtZWFuIGNwdWlkbGUtYXJtIGRyaXZlciBjYW4ndCBkaXJlY3RseSB1
c2Ugd2l0aCBubyBtb2RpZmllZC4NCj4gPiA+ICAgICAgICBJZiBzb21lb25lIHdhbnQgdG8gdXNl
IGNwdWlkbGUtYXJtIGRyaXZlciwgYmVsb3cgbW9kaWZpY2F0aW9uIHNlZW1zIG5lY2Vzc2FyeS4N
Cj4gPiA+DQo+IH5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+ID4gPiAgICAgICAgU3RhdGljIGludCBz
cDcwMjFfY3B1aWRsZV9zdXNwZW5kX2VudGVyKHVuc2lnbmVkIGxvbmcgaW5kZXgpIHt+fQ0KPiA+
ID4gICAgICAgIFN0YXRpYyBpbnQgX19pbml0IHNwNzAyMV9jcHVpZGxlX2luaXQoc3RydWN0IGRl
dmljZV9ub2RlICpjcHVfbm9kZSwgaW50IGNwdSkge359DQo+ID4gPiAgICAgICAgU3RhdGljIGNv
bnN0IHN0cnVjdCBjcHVpZGxlX29wcyBzY19zbXBfb3BzIF9faW5pdGNvbnN0ID0gew0KPiA+ID4g
ICAgICAgICAgICAgLnN1c3BlbmQgPSBzcDcwMjFfY3B1aWRsZV9zdXNwZW5kX2VudGVyLA0KPiA+
ID4gICAgICAgICAgICAgLmluaXQgPSBzcDcwMjFfY3B1aWRsZV9pbml0LA0KPiA+ID4gICAgICAg
IH07DQo+ID4gPiAgICAgICAgQ1BVSURMRV9NRVRIT0RfT0ZfREVDTEFSRShzY19zbXAsICJzdW5w
bHVzLHNjLXNtcCIsICZzY19zbXBfb3BzKTsgLy9kZWNsYXJlDQo+IGVuYWJsZSBtZXRob2QNCj4g
PiA+DQo+ID4gPiB+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fg0KPiA+ID4gfn5+fn5+fn5+fn5+DQo+ID4gPg0KPiANCj4g
TWF5IGJlLiBJdCBkZXBlbmRzIG9uIHdoYXQgaXMgeW91ciBlbmFibGUtbWV0aG9kLiBJIGRpZCBh
IHF1aWNrIGdyZXAgYW5kIGNvdWxkIHNlZSBhbnkgc3VwcG9ydCBmb3INCj4gc3VucGx1cyBwbGF0
Zm9ybSB1cHN0cmVhbS4gU28gSSBhbSBub3Qgc3VyZSB3aGF0IGlzIHRoZSBjcHUgYm9vdC9lbmFi
bGUgbWV0aG9kIHVzZWQuIElzIGl0IFBTQ0kgb3INCj4gc29tZXRoaW5nIGN1c3RvbS4gWW91IHNo
b3VsZCBiZSB1c2luZyBzdGFuZGFyZCBQU0NJIGlmIGl0IGlzIHJlbGF0aXZlbHkgbmV3IHBsYXRm
b3JtIG9yIHlvdSBoYXZlIGFueQ0KPiBvdGhlciBzdHJvbmcgcmVhc29ucyB0byB1c2UgY3VzdG9t
IG1ldGhvZC4gSWYgeW91IGFyZSB1c2luZyBjdXN0b20gbWV0aG9kLCB0aGVuIHNvbWUgY2hhbmdl
cyBsaWtlDQo+IGFib3ZlIGlzIHJlcXVpcmVkIGJ1dCB0aGF0IHdpbGwgYmUgaW4gdGhlIHBsYXRm
b3JtIHBvcnQgYW5kIG5vdCB0aGUgY29yZSBjcHVpZGxlIGRyaXZlci9mcmFtZXdvcmsuDQo+IA0K
PiBJbiBzaG9ydCBOQUNLIGZvciBhbnkgZGVkaWNhdGVkIGRyaXZlciBmb3IgdGhpcyBwbGF0Zm9y
bSwgdXNlIHRoZSBnZW5lcmljIGNwdWlkbGUtYXJtIGRyaXZlciB3aXRoDQo+IGFwcHJvcHJpYXRl
IHBsYXRmb3JtIGhvb2tzKGxpa2UgdGhlIGFib3ZlIG9uZSBvbmx5IGlmIHlvdSBjaG9vc2UgdG8g
dXNlIGN1c3RvbSBlbmFibGUgbWV0aG9kIGFuZCBub3QNCj4gc3RhbmRhcmQgUFNDSSkNCj4gDQo+
IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0KDQoNClllcyBpdCBzZWVtcyBkZXBlbmRzIG9uIGVu
YWJsZS1tZXRob2QuDQoicHNjaSIgaXMgb25lIG1ldGhvZC4NCkJ1dCB3aGVuIEkgdGVzdCAicHNj
aSIgaW4gbXkgcGxhdGZvcm0sIHRoZXJlIGhhdmUgZXhjZXB0aW9uIGhhcHBlbmVkIGluIG9wZXJh
dGUgc21jLg0KVGhpcyBpcyBhbm90aGVyIHN0b3J5Lg0KDQpBY2NvcmRpbmcgeW91ciBjb21tZW50
LCBJIHdpbGwgdHJ5IHRvIHVzZSBjb21tb24gcGFydHMgYW5kIGhvb2sgY3VzdG9tIGNvZGUgaW4g
cGxhdGZvcm0gc2lkZSBsYXRlci4NClRoYW5rcy4NCg0K6YKx5Z6C5bOwIEVkd2luQ2hpdQ0K5pm6
6IO96YGL566X5bCI5qGIDQpUOiArODg2LTMtNTc4NjAwNSBleHQuMjU5MA0KZWR3aW4uY2hpdUBz
dW5wbHVzLmNvbQ0KMzAwIOaWsOerueenkeWtuOWckuWNgOWJteaWsOS4gOi3rzE56JmfDQo=
