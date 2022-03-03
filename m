Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395324CB9BE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 10:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiCCJCQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 04:02:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCCJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 04:02:09 -0500
Received: from mg.sunplus.com (mswedge2.sunplus.com [60.248.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C418116AA6F;
        Thu,  3 Mar 2022 01:01:21 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(59929:1:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Thu, 03 Mar 2022 17:01:32 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 3 Mar 2022 17:01:27 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Thu, 3 Mar 2022 17:01:27 +0800
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
Thread-Index: AQHYJvM6KsEFetK2rkm3Rlg2+5O/D6ydsX4AgAybu1D//588AIADfEqg
Date:   Thu, 3 Mar 2022 09:01:26 +0000
Message-ID: <fda1e55e576b4cdf9ab412529a3dfc7b@sphcmbx02.sunplus.com.tw>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <394261d1-f1df-e80d-3591-10f2d649e731@kernel.org>
 <bcc7a0b58aad4f0989d7d86eaee2c746@sphcmbx02.sunplus.com.tw>
 <748eb0e1-684c-a772-bccd-64b80780192f@kernel.org>
In-Reply-To: <748eb0e1-684c-a772-bccd-64b80780192f@kernel.org>
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
d3NraSA8a3J6a0BrZXJuZWwub3JnPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxLCAyMDIyIDc6
MzQgUE0NCj4gVG86IEVkd2luIENoaXUg6YKx5Z6C5bOwIDxlZHdpbi5jaGl1QHN1bnBsdXMuY29t
PjsgRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT47DQo+IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHJhZmFlbEBrZXJuZWwub3JnOw0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3Jn
OyBsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NV0gY3B1
aWRsZTogc3VucGx1czogQ3JlYXRlIGNwdWlkbGUgZHJpdmVyIGZvciBzdW5wbHVzIHNwNzAyMQ0K
PiANCj4gT24gMDEvMDMvMjAyMiAxMDozMCwgRWR3aW4gQ2hpdSDpgrHlnoLls7Agd3JvdGU6DQo+
ID4NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBLcnp5
c3p0b2YgS296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+DQo+ID4+IFNlbnQ6IFR1ZXNkYXksIEZl
YnJ1YXJ5IDIyLCAyMDIyIDEyOjQ4IEFNDQo+ID4+IFRvOiBFZHdpbiBDaGl1IDxlZHdpbmNoaXUw
NTA1dHdAZ21haWwuY29tPjsgRWR3aW4gQ2hpdSDpgrHlnoLls7ANCj4gPj4gPGVkd2luLmNoaXVA
c3VucGx1cy5jb20+Ow0KPiA+PiByb2JoK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOw0KPiA+PiByb2JoK2xpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJhZmFl
bEBrZXJuZWwub3JnOw0KPiA+PiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBsaW51eC1wbUB2
Z2VyLmtlcm5lbC5vcmcNCj4gPj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NV0gY3B1aWRsZTogc3Vu
cGx1czogQ3JlYXRlIGNwdWlkbGUgZHJpdmVyIGZvcg0KPiA+PiBzdW5wbHVzIHNwNzAyMQ0KPiA+
Pg0KPiA+PiBPbiAyMS8wMi8yMDIyIDA4OjI2LCBFZHdpbiBDaGl1IHdyb3RlOg0KPiA+Pj4gQ3Jl
YXRlIGNwdWlkbGUgZHJpdmVyIGZvciBzdW5wbHVzIHNwNzAyMSBjaGlwDQo+ID4+Pg0KPiA+Pj4g
U2lnbmVkLW9mZi1ieTogRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT4NCj4g
Pj4+IC0tLQ0KPiA+Pj4gQ2hhbmdlcyBpbiB2Mw0KPiA+Pj4gIC0gUmVhcnJhbmdlbWVudCAjaW5j
bHVkZSBzZXF1ZW5jZQ0KPiA+Pj4gIC0gQ2hhbmdlIHJlbWFyayBzdHlsZSB0byAvKn4qLw0KPiA+
Pj4gIC0gQWxpZ24gYXV0aG9yIGVtYWlsIGFkZHJlc3MgdG8gc2FtZSBhcyBzb2INCj4gPj4+ICAt
IE9wdGltYWwgY29kZQ0KPiA+Pj4gQ2hhbmdlcyBpbiB2NA0KPiA+Pj4gIC0gQWNjb3JkaW5nIFJv
YiBIZXJyaW5ncm9iaCdzIGNvbW1lbnQNCj4gPj4+ICAgIFRoZXJlIGlzIG5vIG5lZWQgZm9yIHRo
aXMgYmluZGluZy4NCj4gPj4+ICAgIEp1c3Qgd2FudGluZyBhIGRpZmZlcmVudCBkcml2ZXIgaXMg
bm90IGEgcmVhc29uDQo+ID4+PiAgICBmb3IgYSBkdXBsaWNhdGUgc2NoZW1hLg0KPiA+Pj4gICAg
U28gcmVtb3ZlIHlhbWwgZmlsZSBhbmQgc3VibWl0IGRyaXZlciBhZ2Fpbi4NCj4gPj4+IENoYW5n
ZXMgaW4gdjUNCj4gPj4+ICAtIEFjY29yZGluZyBLcnp5c3p0b2YncyBjb21tZW50DQo+ID4+PiAg
ICBZb3UgZWl0aGVyIHVzZSBhcHByb3ByaWF0ZSBjb21wYXRpYmxlIGluIERUDQo+ID4+PiAgICBv
ciBhZGQgeW91ciBjb21wYXRpYmxlIHRvIGNwdWlkbGUtYXJtLg0KPiA+Pj4gICAgRXZlbiBpZiB0
aGlzIGRpZCBub3Qgd29yaywgdGhlbiB0aGUgc29sdXRpb24gaXMgdG8NCj4gPj4+ICAgIHVzZSBj
b21tb24gcGFydHMsIG5vdCB0byBkdXBsaWNhdGUgZW50aXJlIGRyaXZlci4NCj4gPj4+ICAgIEFj
Y29yZGluZyBTdWRlZXAncyBjb21tZW50DQo+ID4+PiAgICBJbiBzaG9ydCBOQUNLIGZvciBhbnkg
ZGVkaWNhdGVkIGRyaXZlciBmb3IgdGhpcyBwbGF0Zm9ybSwNCj4gPj4+ICAgIHVzZSB0aGUgZ2Vu
ZXJpYyBjcHVpZGxlLWFybSBkcml2ZXIgd2l0aCBhcHByb3ByaWF0ZSBwbGF0Zm9ybSBob29rcw0K
PiA+Pj4gICAgQ3JlYXRlIGNwdWlkbGUtc3VucGx1cy5jIGluIGFyY2gvYXJtL21hY2gtc3VucGx1
cy8NCj4gPj4+ICAgIGZvciBob29rIGdlbmVyaWMgY3B1aWRsZS1hcm0gZHJpdmVyDQo+ID4+Pg0K
PiA+Pj4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2
ICsrDQo+ID4+PiAgYXJjaC9hcm0vbWFjaC1zdW5wbHVzL2NwdWlkbGUtc3VucGx1cy5jICAgICAg
IHwgODggKysrKysrKysrKysrKysrKysNCj4gPj4+ICBpbmNsdWRlL2xpbnV4L3BsYXRmb3JtX2Rh
dGEvY3B1aWRsZS1zdW5wbHVzLmggfCAxMiArKysrDQo+ID4+PiAgMyBmaWxlcyBjaGFuZ2VkLCAx
MDYgaW5zZXJ0aW9ucygrKQ0KPiA+Pj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNo
LXN1bnBsdXMvY3B1aWRsZS1zdW5wbHVzLmMNCj4gPj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgaW5j
bHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2NwdWlkbGUtc3VucGx1cy5oDQo+ID4+Pg0KPiA+Pj4g
ZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXggZTBkY2E4Zi4uNWM5
NjQyOCAxMDA2NDQNCj4gPj4+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4+PiArKysgYi9NQUlOVEFJ
TkVSUw0KPiA+Pj4gQEAgLTE4MjUyLDYgKzE4MjUyLDEyIEBAIEw6CW5ldGRldkB2Z2VyLmtlcm5l
bC5vcmcNCj4gPj4+ICBTOglNYWludGFpbmVkDQo+ID4+PiAgRjoJZHJpdmVycy9uZXQvZXRoZXJu
ZXQvZGxpbmsvc3VuZGFuY2UuYw0KPiA+Pj4NCj4gPj4+ICtTVU5QTFVTIENQVUlETEUgRFJJVkVS
DQo+ID4+PiArTToJRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT4NCj4gPj4+
ICtTOglNYWludGFpbmVkDQo+ID4+PiArRjoJYXJjaC9hcm0vbWFjaC1zdW5wbHVzL2NwdWlkbGUt
c3VucGx1cy5jDQo+ID4+PiArRjoJaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRhL2NwdWlkbGUt
c3VucGx1cy5oDQo+ID4+PiArDQo+ID4+PiAgU1VQRVJIDQo+ID4+PiAgTToJWW9zaGlub3JpIFNh
dG8gPHlzYXRvQHVzZXJzLnNvdXJjZWZvcmdlLmpwPg0KPiA+Pj4gIE06CVJpY2ggRmVsa2VyIDxk
YWxpYXNAbGliYy5vcmc+DQo+ID4+PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1zdW5wbHVz
L2NwdWlkbGUtc3VucGx1cy5jDQo+ID4+PiBiL2FyY2gvYXJtL21hY2gtc3VucGx1cy9jcHVpZGxl
LXN1bnBsdXMuYw0KPiA+Pj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPj4+IGluZGV4IDAwMDAw
MDAuLmU5ZDk3MzgNCj4gPj4+IC0tLSAvZGV2L251bGwNCj4gPj4+ICsrKyBiL2FyY2gvYXJtL21h
Y2gtc3VucGx1cy9jcHVpZGxlLXN1bnBsdXMuYw0KPiA+Pj4gQEAgLTAsMCArMSw4OCBAQA0KPiA+
Pj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gPj4+ICsvKg0K
PiA+Pj4gKyAqIFNQNzAyMSBjcHUgaWRsZSBEcml2ZXIuDQo+ID4+PiArICogQ29weXJpZ2h0IChD
KSBTdW5wbHVzIFRlY2ggLyBUaWJibyBUZWNoLg0KPiA+Pj4gKyAqLw0KPiA+Pj4gKyNkZWZpbmUg
cHJfZm10KGZtdCkgIkNQVWlkbGUgYXJtOiAiIGZtdA0KPiA+Pj4gKw0KPiA+Pj4gKyNpbmNsdWRl
IDxsaW51eC9jcHVpZGxlLmg+DQo+ID4+PiArI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPg0K
PiA+Pj4gKyNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kYXRhL2NwdWlkbGUtc3VucGx1cy5oPg0K
PiA+Pj4gKw0KPiA+Pj4gKyNpbmNsdWRlIDxhc20vY3B1aWRsZS5oPg0KPiA+Pj4gKw0KPiA+Pj4g
K3R5cGVkZWYgaW50ICgqaWRsZV9mbikodm9pZCk7DQo+ID4+PiArDQo+ID4+PiArc3RhdGljIERF
RklORV9QRVJfQ1BVKGlkbGVfZm4qLCBzcDcwMjFfaWRsZV9vcHMpOw0KPiA+Pj4gKw0KPiA+Pj4g
K3N0YXRpYyBpbnQgc3A3MDIxX2NwdWlkbGVfZW50ZXIodW5zaWduZWQgbG9uZyBpbmRleCkgew0K
PiA+Pj4gKwlyZXR1cm4gX190aGlzX2NwdV9yZWFkKHNwNzAyMV9pZGxlX29wcylbaW5kZXhdKCk7
DQo+ID4+PiArfQ0KPiA+Pj4gK3N0YXRpYyBpbnQgc3A3MDIxX2NwdV9zcGModm9pZCkNCj4gPj4+
ICt7DQo+ID4+PiArCWNwdV92N19kb19pZGxlKCk7ICAgLyogaWRsZSB0byBXRkkgKi8NCj4gPj4+
ICsJcmV0dXJuIDA7DQo+ID4+PiArfQ0KPiA+Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2
aWNlX2lkIHNwNzAyMV9pZGxlX3N0YXRlX21hdGNoW10gPSB7DQo+ID4+PiArCXsgLmNvbXBhdGli
bGUgPSAiYXJtLGlkbGUtc3RhdGUiLCAuZGF0YSA9IHNwNzAyMV9jcHVfc3BjIH0sDQo+ID4+PiAr
CXsgfSwNCj4gPj4+ICt9Ow0KPiA+Pg0KPiA+PiBUaGlzIGlzIGNvbmZ1c2luZy4gWW91IHdhbnQg
dG8gaGF2ZSB0d28gZHJpdmVycyB0byBiaW5kIHRvIHRoZSBzYW1lDQo+ID4+IGNvbXBhdGlibGU/
IEFzIEkgd3JvdGUgaW4gdGhlIHByZXZpb3VzIG1lc3NhZ2VzLCB5b3Ugc2hvdWxkIHNpbXBseSB1
c2UgYXJtLGlkbGUtc3RhdGUganVzdCBsaWtlIGZldw0KPiBvdGhlciBhcmNoaXRlY3R1cmVzLg0K
PiA+Pg0KPiA+Pg0KPiA+PiBCZXN0IHJlZ2FyZHMsDQo+ID4+IEtyenlzenRvZg0KPiA+DQo+ID4N
Cj4gPiBUaGUgcGF0Y2ggdjUgaW1wbGVtZW50ZWQgYWNjb3JkaW5nIHlvdXIgY29tbWVudC4NCj4g
PiBVc2VkIGNvbW1vbiBwYXJ0IG9mIGFybSxpZGxlLXN0YXRlLg0KPiA+IENyZWF0ZSBuZXcgZW5h
YmxlLW1ldGhvZCBmb3IgY3B1aWRsZS5vcHMgZnVuY3Rpb24uDQo+ID4gSXQgb25seSBoYXZlIGFy
bSBjcHVpZGxlIGRyaXZlciBleGlzdCBub3csIG5vIHR3byBkcml2ZXJzIHRvIGJpbmQgdG8gdGhl
IHNhbWUgY29tcGF0aWJsZS4NCj4gPg0KPiA+IFdoYXQgZG8geW91IG1lYW4gIiBzaW1wbHkgdXNl
IGFybSxpZGxlLXN0YXRlIGp1c3QgbGlrZSBmZXcgb3RoZXIgYXJjaGl0ZWN0dXJlcyAiPw0KPiA+
DQo+IA0KPiBJIG1lYW4sIGRvIGl0IHNpbWlsYXJseSAoYnkgdXNpbmcgYXJtLGlkbGUtc3RhdGUg
YW5kIG90aGVyIHJlbGF0ZWQNCj4gcHJvcGVydGllcykgdG8gZm9yIGV4YW1wbGUgdGksYW00Mzcy
L3RpLGFtMzM1Mi4NCj4gDQo+IEJlc3QgcmVnYXJkcywNCj4gS3J6eXN6dG9mDQoNCg0KVGhlIGFt
MzM1MiBjcHVpZGxlIGNvZGUgc3RydWN0dXJlIGlzIHZlcnkgc2ltaWxhciB0byBvdXJzLgkJCQkN
ClVzZWQgZW5hYmxlLW1ldGhvZCA9ICJ0aSxhbTMzNTIiIGFuZCBjb21wYXRpYmxlID0gImFybSxp
ZGxlLXN0YXRlIiBpbiBhbTMzeHguZHRzaQkJCQkNClVzZWQgQ1BVSURMRV9NRVRIT0RfT0ZfREVD
TEFSRShwbTMzeHhfaWRsZSwgInRpLGFtMzM1MiIsICZhbXgzX2NwdWlkbGVfb3BzKSBpbiBwbTMz
eHgtY29yZS5jCQkJCQ0KCQkJCQ0KVGhlIGRpZmZlcmVuY2UgYXJlCQkJCQ0KYW0zMzUyCQkJCQ0K
YW14M19pZGxlX2luaXQofikgYXNzaWduIGlkbGVfc3RhdGVzW2ldLndmaV9mbGFncyA9IHN0YXRl
c1tpXS53ZmlfZmxhZ3M7CQkJCQ0KYW14M19pZGxlX2VudGVyKH4pIGNhbGwgaWRsZV9mbihpZGxl
X3N0YXRlLT53ZmlfZmxhZ3MpCQkJCQ0KCQkJCQ0Kc3VucGx1cy1zcDcwMjEJCQkJDQpzcDcwMjFf
Y3B1aWRsZV9pbml0KH4pIGFzc2lnbiBmbnNbaV0gPSBpZGxlX2Zuc1tpXTsJCQkJDQpzcDcwMjFf
Y3B1aWRsZV9lbnRlcih+KSBjYWxsIF9fdGhpc19jcHVfcmVhZChzcDcwMjFfaWRsZV9vcHMpW2lu
ZGV4XSgpOwkJCQkNCg0KSSBkb24ndCB0aGluayBhbTMzNTIgY3B1aWRsZSBjb2RlIGFyY2hpdGVj
dHVyZSBzaW1wbGVyIHRoYW4gb3Vycy4NClRoZSBpZGxlX2ZuIGZ1bmN0aW9uIG5lZWQgbW9yZSBj
b21wbGV4IG1ldGhvZCB0byBiZSBhc3NpZ24uDQpIb3cgZG8geW91IHRoaW5rPw0KDQoNCumCseWe
guWzsCBFZHdpbkNoaXUNCuaZuuiDvemBi+eul+WwiOahiA0KVDogKzg4Ni0zLTU3ODYwMDUgZXh0
LjI1OTANCmVkd2luLmNoaXVAc3VucGx1cy5jb20NCjMwMCDmlrDnq7nnp5HlrbjlnJLljYDlibXm
lrDkuIDot68xOeiZnw0KDQo=
