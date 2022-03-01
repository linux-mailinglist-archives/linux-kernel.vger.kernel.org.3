Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0094C87DC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbiCAJah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbiCAJaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:30:35 -0500
Received: from mg.sunplus.com (mswedge2.sunplus.com [60.248.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 310E35C674;
        Tue,  1 Mar 2022 01:29:52 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(59926:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Tue, 01 Mar 2022 17:30:12 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Tue, 1 Mar 2022 17:30:06 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Tue, 1 Mar 2022 17:30:06 +0800
From:   =?utf-8?B?RWR3aW4gQ2hpdSDpgrHlnoLls7A=?= <edwin.chiu@sunplus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Topic: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Index: AQHYJvM6KsEFetK2rkm3Rlg2+5O/D6ydsX4AgAybu1A=
Date:   Tue, 1 Mar 2022 09:30:06 +0000
Message-ID: <bcc7a0b58aad4f0989d7d86eaee2c746@sphcmbx02.sunplus.com.tw>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
In-Reply-To: <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3J6eXN6dG9mIEtvemxv
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBGZWJydWFyeSAyMiwgMjAy
MiAxMjo0OCBBTQ0KPiBUbzogRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT47
IEVkd2luIENoaXUg6YKx5Z6C5bOwIDxlZHdpbi5jaGl1QHN1bnBsdXMuY29tPjsNCj4gcm9iaCtk
dEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7DQo+IGRhbmllbC5sZXpjYW5vQGxpbmFy
by5vcmc7IGxpbnV4LXBtQHZnZXIua2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1
XSBjcHVpZGxlOiBzdW5wbHVzOiBDcmVhdGUgY3B1aWRsZSBkcml2ZXIgZm9yIHN1bnBsdXMgc3A3
MDIxDQo+IA0KPiBPbiAyMS8wMi8yMDIyIDA4OjI2LCBFZHdpbiBDaGl1IHdyb3RlOg0KPiA+IENy
ZWF0ZSBjcHVpZGxlIGRyaXZlciBmb3Igc3VucGx1cyBzcDcwMjEgY2hpcA0KPiA+DQo+ID4gU2ln
bmVkLW9mZi1ieTogRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT4NCj4gPiAt
LS0NCj4gPiBDaGFuZ2VzIGluIHYzDQo+ID4gIC0gUmVhcnJhbmdlbWVudCAjaW5jbHVkZSBzZXF1
ZW5jZQ0KPiA+ICAtIENoYW5nZSByZW1hcmsgc3R5bGUgdG8gLyp+Ki8NCj4gPiAgLSBBbGlnbiBh
dXRob3IgZW1haWwgYWRkcmVzcyB0byBzYW1lIGFzIHNvYg0KPiA+ICAtIE9wdGltYWwgY29kZQ0K
PiA+IENoYW5nZXMgaW4gdjQNCj4gPiAgLSBBY2NvcmRpbmcgUm9iIEhlcnJpbmdyb2JoJ3MgY29t
bWVudA0KPiA+ICAgIFRoZXJlIGlzIG5vIG5lZWQgZm9yIHRoaXMgYmluZGluZy4NCj4gPiAgICBK
dXN0IHdhbnRpbmcgYSBkaWZmZXJlbnQgZHJpdmVyIGlzIG5vdCBhIHJlYXNvbg0KPiA+ICAgIGZv
ciBhIGR1cGxpY2F0ZSBzY2hlbWEuDQo+ID4gICAgU28gcmVtb3ZlIHlhbWwgZmlsZSBhbmQgc3Vi
bWl0IGRyaXZlciBhZ2Fpbi4NCj4gPiBDaGFuZ2VzIGluIHY1DQo+ID4gIC0gQWNjb3JkaW5nIEty
enlzenRvZidzIGNvbW1lbnQNCj4gPiAgICBZb3UgZWl0aGVyIHVzZSBhcHByb3ByaWF0ZSBjb21w
YXRpYmxlIGluIERUDQo+ID4gICAgb3IgYWRkIHlvdXIgY29tcGF0aWJsZSB0byBjcHVpZGxlLWFy
bS4NCj4gPiAgICBFdmVuIGlmIHRoaXMgZGlkIG5vdCB3b3JrLCB0aGVuIHRoZSBzb2x1dGlvbiBp
cyB0bw0KPiA+ICAgIHVzZSBjb21tb24gcGFydHMsIG5vdCB0byBkdXBsaWNhdGUgZW50aXJlIGRy
aXZlci4NCj4gPiAgICBBY2NvcmRpbmcgU3VkZWVwJ3MgY29tbWVudA0KPiA+ICAgIEluIHNob3J0
IE5BQ0sgZm9yIGFueSBkZWRpY2F0ZWQgZHJpdmVyIGZvciB0aGlzIHBsYXRmb3JtLA0KPiA+ICAg
IHVzZSB0aGUgZ2VuZXJpYyBjcHVpZGxlLWFybSBkcml2ZXIgd2l0aCBhcHByb3ByaWF0ZSBwbGF0
Zm9ybSBob29rcw0KPiA+ICAgIENyZWF0ZSBjcHVpZGxlLXN1bnBsdXMuYyBpbiBhcmNoL2FybS9t
YWNoLXN1bnBsdXMvDQo+ID4gICAgZm9yIGhvb2sgZ2VuZXJpYyBjcHVpZGxlLWFybSBkcml2ZXIN
Cj4gPg0KPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
fCAgNiArKw0KPiA+ICBhcmNoL2FybS9tYWNoLXN1bnBsdXMvY3B1aWRsZS1zdW5wbHVzLmMgICAg
ICAgfCA4OCArKysrKysrKysrKysrKysrKw0KPiA+ICBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2Rh
dGEvY3B1aWRsZS1zdW5wbHVzLmggfCAxMiArKysrDQo+ID4gIDMgZmlsZXMgY2hhbmdlZCwgMTA2
IGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGFyY2gvYXJtL21hY2gtc3Vu
cGx1cy9jcHVpZGxlLXN1bnBsdXMuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5jbHVkZS9s
aW51eC9wbGF0Zm9ybV9kYXRhL2NwdWlkbGUtc3VucGx1cy5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleCBlMGRjYThmLi41Yzk2NDI4IDEwMDY0
NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAt
MTgyNTIsNiArMTgyNTIsMTIgQEAgTDoJbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiA+ICBTOglN
YWludGFpbmVkDQo+ID4gIEY6CWRyaXZlcnMvbmV0L2V0aGVybmV0L2RsaW5rL3N1bmRhbmNlLmMN
Cj4gPg0KPiA+ICtTVU5QTFVTIENQVUlETEUgRFJJVkVSDQo+ID4gK006CUVkd2luIENoaXUgPGVk
d2luY2hpdTA1MDV0d0BnbWFpbC5jb20+DQo+ID4gK1M6CU1haW50YWluZWQNCj4gPiArRjoJYXJj
aC9hcm0vbWFjaC1zdW5wbHVzL2NwdWlkbGUtc3VucGx1cy5jDQo+ID4gK0Y6CWluY2x1ZGUvbGlu
dXgvcGxhdGZvcm1fZGF0YS9jcHVpZGxlLXN1bnBsdXMuaA0KPiA+ICsNCj4gPiAgU1VQRVJIDQo+
ID4gIE06CVlvc2hpbm9yaSBTYXRvIDx5c2F0b0B1c2Vycy5zb3VyY2Vmb3JnZS5qcD4NCj4gPiAg
TToJUmljaCBGZWxrZXIgPGRhbGlhc0BsaWJjLm9yZz4NCj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vbWFjaC1zdW5wbHVzL2NwdWlkbGUtc3VucGx1cy5jDQo+ID4gYi9hcmNoL2FybS9tYWNoLXN1
bnBsdXMvY3B1aWRsZS1zdW5wbHVzLmMNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGlu
ZGV4IDAwMDAwMDAuLmU5ZDk3MzgNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvYXJjaC9h
cm0vbWFjaC1zdW5wbHVzL2NwdWlkbGUtc3VucGx1cy5jDQo+ID4gQEAgLTAsMCArMSw4OCBAQA0K
PiA+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vbmx5DQo+ID4gKy8qDQo+
ID4gKyAqIFNQNzAyMSBjcHUgaWRsZSBEcml2ZXIuDQo+ID4gKyAqIENvcHlyaWdodCAoQykgU3Vu
cGx1cyBUZWNoIC8gVGliYm8gVGVjaC4NCj4gPiArICovDQo+ID4gKyNkZWZpbmUgcHJfZm10KGZt
dCkgIkNQVWlkbGUgYXJtOiAiIGZtdA0KPiA+ICsNCj4gPiArI2luY2x1ZGUgPGxpbnV4L2NwdWlk
bGUuaD4NCj4gPiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0KPiA+ICsjaW5jbHVkZSA8
bGludXgvcGxhdGZvcm1fZGF0YS9jcHVpZGxlLXN1bnBsdXMuaD4NCj4gPiArDQo+ID4gKyNpbmNs
dWRlIDxhc20vY3B1aWRsZS5oPg0KPiA+ICsNCj4gPiArdHlwZWRlZiBpbnQgKCppZGxlX2ZuKSh2
b2lkKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBERUZJTkVfUEVSX0NQVShpZGxlX2ZuKiwgc3A3MDIx
X2lkbGVfb3BzKTsNCj4gPiArDQo+ID4gK3N0YXRpYyBpbnQgc3A3MDIxX2NwdWlkbGVfZW50ZXIo
dW5zaWduZWQgbG9uZyBpbmRleCkgew0KPiA+ICsJcmV0dXJuIF9fdGhpc19jcHVfcmVhZChzcDcw
MjFfaWRsZV9vcHMpW2luZGV4XSgpOw0KPiA+ICt9DQo+ID4gK3N0YXRpYyBpbnQgc3A3MDIxX2Nw
dV9zcGModm9pZCkNCj4gPiArew0KPiA+ICsJY3B1X3Y3X2RvX2lkbGUoKTsgICAvKiBpZGxlIHRv
IFdGSSAqLw0KPiA+ICsJcmV0dXJuIDA7DQo+ID4gK30NCj4gPiArc3RhdGljIGNvbnN0IHN0cnVj
dCBvZl9kZXZpY2VfaWQgc3A3MDIxX2lkbGVfc3RhdGVfbWF0Y2hbXSA9IHsNCj4gPiArCXsgLmNv
bXBhdGlibGUgPSAiYXJtLGlkbGUtc3RhdGUiLCAuZGF0YSA9IHNwNzAyMV9jcHVfc3BjIH0sDQo+
ID4gKwl7IH0sDQo+ID4gK307DQo+IA0KPiBUaGlzIGlzIGNvbmZ1c2luZy4gWW91IHdhbnQgdG8g
aGF2ZSB0d28gZHJpdmVycyB0byBiaW5kIHRvIHRoZSBzYW1lIGNvbXBhdGlibGU/IEFzIEkgd3Jv
dGUgaW4gdGhlDQo+IHByZXZpb3VzIG1lc3NhZ2VzLCB5b3Ugc2hvdWxkIHNpbXBseSB1c2UgYXJt
LGlkbGUtc3RhdGUganVzdCBsaWtlIGZldyBvdGhlciBhcmNoaXRlY3R1cmVzLg0KPiANCj4gDQo+
IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg0KVGhlIHBhdGNoIHY1IGltcGxlbWVudGVk
IGFjY29yZGluZyB5b3VyIGNvbW1lbnQuDQpVc2VkIGNvbW1vbiBwYXJ0IG9mIGFybSxpZGxlLXN0
YXRlLg0KQ3JlYXRlIG5ldyBlbmFibGUtbWV0aG9kIGZvciBjcHVpZGxlLm9wcyBmdW5jdGlvbi4N
Ckl0IG9ubHkgaGF2ZSBhcm0gY3B1aWRsZSBkcml2ZXIgZXhpc3Qgbm93LCBubyB0d28gZHJpdmVy
cyB0byBiaW5kIHRvIHRoZSBzYW1lIGNvbXBhdGlibGUuDQoNCldoYXQgZG8geW91IG1lYW4gIiBz
aW1wbHkgdXNlIGFybSxpZGxlLXN0YXRlIGp1c3QgbGlrZSBmZXcgb3RoZXIgYXJjaGl0ZWN0dXJl
cyAiPw0KDQoNCumCseWeguWzsCBFZHdpbkNoaXUNCuaZuuiDvemBi+eul+WwiOahiA0KVDogKzg4
Ni0zLTU3ODYwMDUgZXh0LjI1OTANCmVkd2luLmNoaXVAc3VucGx1cy5jb20NCjMwMCDmlrDnq7nn
p5HlrbjlnJLljYDlibXmlrDkuIDot68xOeiZnw0KDQo=
