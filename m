Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A8FC4C87AC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbiCAJTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232066AbiCAJTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:19:00 -0500
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 617D15C66F;
        Tue,  1 Mar 2022 01:18:18 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10043:0:AUTH_RELAY)
        (envelope-from <edwin.chiu@sunplus.com>); Tue, 01 Mar 2022 17:18:32 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Tue, 1 Mar 2022 17:18:31 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Tue, 1 Mar 2022 17:18:31 +0800
From:   =?big5?B?RWR3aW4gQ2hpdSCq9KurrnA=?= <edwin.chiu@sunplus.com>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Edwin Chiu <edwinchiu0505tw@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Topic: [PATCH v5] cpuidle: sunplus: Create cpuidle driver for sunplus
 sp7021
Thread-Index: AQHYJvM6KsEFetK2rkm3Rlg2+5O/D6ydTg2AgAz92lA=
Date:   Tue, 1 Mar 2022 09:18:31 +0000
Message-ID: <7b09a22cc178439aa41a752af936313d@sphcmbx02.sunplus.com.tw>
References: <cover.1645427180.git.edwinchiu0505tw@gmail.com>
 <1628e048220f066204b8ac27f3cedf7f3cc02963.1645427180.git.edwinchiu0505tw@gmail.com>
 <20220221105151.6rvyoqyvj6ehhtnj@bogus>
In-Reply-To: <20220221105151.6rvyoqyvj6ehhtnj@bogus>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.40]
Content-Type: text/plain; charset="big5"
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFN1ZGVlcCBIb2xsYSA8c3Vk
ZWVwLmhvbGxhQGFybS5jb20+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgMjEsIDIwMjIgNjo1
MiBQTQ0KPiBUbzogRWR3aW4gQ2hpdSA8ZWR3aW5jaGl1MDUwNXR3QGdtYWlsLmNvbT4NCj4gQ2M6
IEVkd2luIENoaXUgqvSrq65wIDxlZHdpbi5jaGl1QHN1bnBsdXMuY29tPjsgcm9iaCtkdEBrZXJu
ZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgcmFmYWVsQGtlcm5lbC5vcmc7IFN1ZGVlcCBIb2xsYSA8c3VkZWVwLmhvbGxh
QGFybS5jb20+Ow0KPiBkYW5pZWwubGV6Y2Fub0BsaW5hcm8ub3JnOyBsaW51eC1wbUB2Z2VyLmtl
cm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NV0gY3B1aWRsZTogc3VucGx1czogQ3Jl
YXRlIGNwdWlkbGUgZHJpdmVyIGZvciBzdW5wbHVzIHNwNzAyMQ0KPiANCj4gT24gTW9uLCBGZWIg
MjEsIDIwMjIgYXQgMDM6MjY6MThQTSArMDgwMCwgRWR3aW4gQ2hpdSB3cm90ZToNCj4gPiBDcmVh
dGUgY3B1aWRsZSBkcml2ZXIgZm9yIHN1bnBsdXMgc3A3MDIxIGNoaXANCj4gPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEVkd2luIENoaXUgPGVkd2luY2hpdTA1MDV0d0BnbWFpbC5jb20+DQo+ID4gLS0t
DQo+ID4gQ2hhbmdlcyBpbiB2Mw0KPiA+ICAtIFJlYXJyYW5nZW1lbnQgI2luY2x1ZGUgc2VxdWVu
Y2UNCj4gPiAgLSBDaGFuZ2UgcmVtYXJrIHN0eWxlIHRvIC8qfiovDQo+ID4gIC0gQWxpZ24gYXV0
aG9yIGVtYWlsIGFkZHJlc3MgdG8gc2FtZSBhcyBzb2INCj4gPiAgLSBPcHRpbWFsIGNvZGUNCj4g
PiBDaGFuZ2VzIGluIHY0DQo+ID4gIC0gQWNjb3JkaW5nIFJvYiBIZXJyaW5ncm9iaCdzIGNvbW1l
bnQNCj4gPiAgICBUaGVyZSBpcyBubyBuZWVkIGZvciB0aGlzIGJpbmRpbmcuDQo+ID4gICAgSnVz
dCB3YW50aW5nIGEgZGlmZmVyZW50IGRyaXZlciBpcyBub3QgYSByZWFzb24NCj4gPiAgICBmb3Ig
YSBkdXBsaWNhdGUgc2NoZW1hLg0KPiA+ICAgIFNvIHJlbW92ZSB5YW1sIGZpbGUgYW5kIHN1Ym1p
dCBkcml2ZXIgYWdhaW4uDQo+ID4gQ2hhbmdlcyBpbiB2NQ0KPiA+ICAtIEFjY29yZGluZyBLcnp5
c3p0b2YncyBjb21tZW50DQo+ID4gICAgWW91IGVpdGhlciB1c2UgYXBwcm9wcmlhdGUgY29tcGF0
aWJsZSBpbiBEVA0KPiA+ICAgIG9yIGFkZCB5b3VyIGNvbXBhdGlibGUgdG8gY3B1aWRsZS1hcm0u
DQo+ID4gICAgRXZlbiBpZiB0aGlzIGRpZCBub3Qgd29yaywgdGhlbiB0aGUgc29sdXRpb24gaXMg
dG8NCj4gPiAgICB1c2UgY29tbW9uIHBhcnRzLCBub3QgdG8gZHVwbGljYXRlIGVudGlyZSBkcml2
ZXIuDQo+ID4gICAgQWNjb3JkaW5nIFN1ZGVlcCdzIGNvbW1lbnQNCj4gPiAgICBJbiBzaG9ydCBO
QUNLIGZvciBhbnkgZGVkaWNhdGVkIGRyaXZlciBmb3IgdGhpcyBwbGF0Zm9ybSwNCj4gPiAgICB1
c2UgdGhlIGdlbmVyaWMgY3B1aWRsZS1hcm0gZHJpdmVyIHdpdGggYXBwcm9wcmlhdGUgcGxhdGZv
cm0gaG9va3MNCj4gPiAgICBDcmVhdGUgY3B1aWRsZS1zdW5wbHVzLmMgaW4gYXJjaC9hcm0vbWFj
aC1zdW5wbHVzLw0KPiA+ICAgIGZvciBob29rIGdlbmVyaWMgY3B1aWRsZS1hcm0gZHJpdmVyDQo+
ID4NCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDYgKysNCj4gPiAgYXJjaC9hcm0vbWFjaC1zdW5wbHVzL2NwdWlkbGUtc3VucGx1cy5jICAgICAg
IHwgODggKysrKysrKysrKysrKysrKysNCj4gPiAgaW5jbHVkZS9saW51eC9wbGF0Zm9ybV9kYXRh
L2NwdWlkbGUtc3VucGx1cy5oIHwgMTIgKysrKw0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEwNiBp
bnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBhcmNoL2FybS9tYWNoLXN1bnBs
dXMvY3B1aWRsZS1zdW5wbHVzLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGluY2x1ZGUvbGlu
dXgvcGxhdGZvcm1fZGF0YS9jcHVpZGxlLXN1bnBsdXMuaA0KPiA+DQo+ID4gZGlmZiAtLWdpdCBh
L01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXggZTBkY2E4Zi4uNWM5NjQyOCAxMDA2NDQN
Cj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAgLTE4
MjUyLDYgKzE4MjUyLDEyIEBAIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzoJTWFp
bnRhaW5lZA0KPiA+ICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9kbGluay9zdW5kYW5jZS5jDQo+
ID4NCj4gPiArU1VOUExVUyBDUFVJRExFIERSSVZFUg0KPiA+ICtNOglFZHdpbiBDaGl1IDxlZHdp
bmNoaXUwNTA1dHdAZ21haWwuY29tPg0KPiA+ICtTOglNYWludGFpbmVkDQo+ID4gK0Y6CWFyY2gv
YXJtL21hY2gtc3VucGx1cy9jcHVpZGxlLXN1bnBsdXMuYw0KPiA+ICtGOglpbmNsdWRlL2xpbnV4
L3BsYXRmb3JtX2RhdGEvY3B1aWRsZS1zdW5wbHVzLmgNCj4gPiArDQo+ID4gIFNVUEVSSA0KPiA+
ICBNOglZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMuc291cmNlZm9yZ2UuanA+DQo+ID4gIE06
CVJpY2ggRmVsa2VyIDxkYWxpYXNAbGliYy5vcmc+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJt
L21hY2gtc3VucGx1cy9jcHVpZGxlLXN1bnBsdXMuYw0KPiA+IGIvYXJjaC9hcm0vbWFjaC1zdW5w
bHVzL2NwdWlkbGUtc3VucGx1cy5jDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRl
eCAwMDAwMDAwLi5lOWQ5NzM4DQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL2FyY2gvYXJt
L21hY2gtc3VucGx1cy9jcHVpZGxlLXN1bnBsdXMuYw0KPiA+IEBAIC0wLDAgKzEsODggQEANCj4g
PiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb25seQ0KPiA+ICsvKg0KPiA+
ICsgKiBTUDcwMjEgY3B1IGlkbGUgRHJpdmVyLg0KPiA+ICsgKiBDb3B5cmlnaHQgKEMpIFN1bnBs
dXMgVGVjaCAvIFRpYmJvIFRlY2guDQo+ID4gKyAqLw0KPiA+ICsjZGVmaW5lIHByX2ZtdChmbXQp
ICJDUFVpZGxlIGFybTogIiBmbXQNCj4gPiArDQo+ID4gKyNpbmNsdWRlIDxsaW51eC9jcHVpZGxl
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gPiArI2luY2x1ZGUgPGxp
bnV4L3BsYXRmb3JtX2RhdGEvY3B1aWRsZS1zdW5wbHVzLmg+DQo+ID4gKw0KPiA+ICsjaW5jbHVk
ZSA8YXNtL2NwdWlkbGUuaD4NCj4gPiArDQo+ID4gK3R5cGVkZWYgaW50ICgqaWRsZV9mbikodm9p
ZCk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgREVGSU5FX1BFUl9DUFUoaWRsZV9mbiosIHNwNzAyMV9p
ZGxlX29wcyk7DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IHNwNzAyMV9jcHVpZGxlX2VudGVyKHVu
c2lnbmVkIGxvbmcgaW5kZXgpIHsNCj4gPiArCXJldHVybiBfX3RoaXNfY3B1X3JlYWQoc3A3MDIx
X2lkbGVfb3BzKVtpbmRleF0oKTsNCj4gPiArfQ0KPiA+ICtzdGF0aWMgaW50IHNwNzAyMV9jcHVf
c3BjKHZvaWQpDQo+ID4gK3sNCj4gPiArCWNwdV92N19kb19pZGxlKCk7ICAgLyogaWRsZSB0byBX
RkkgKi8NCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+IA0KPiBZb3UgcmVhbGx5IGRvbid0IG5l
ZWQgYSBjcHVpZGxlIGRyaXZlciB0byBqdXN0IFdGSSBmb3IgYW55IHN0YXRlcy4NCj4gQWRkIHRo
ZSBkcml2ZXIgd2hlbiB5b3UgaGF2ZSBzb21ldGhpbmcgbm9uIFdGSSBpbiB0aGUgc3VzcGVuZCBm
dW5jdGlvbi4NCj4gDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkIHNwNzAy
MV9pZGxlX3N0YXRlX21hdGNoW10gPSB7DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImFybSxpZGxl
LXN0YXRlIiwgLmRhdGEgPSBzcDcwMjFfY3B1X3NwYyB9LA0KPiA+ICsJeyB9LA0KPiA+ICt9Ow0K
PiANCj4gVGhpcyBpcyBiZXR0ZXIgdGhhbiBhZGRpbmcgbmV3IGRyaXZlciBsaWtlIHlvdSBkaWQg
aW4gcHJldmlvdXMgdmVyc2lvbi4NCj4gDQo+IEkgZGlkIGEgcXVpY2sgY2hlY2sgYnV0IGNvdWxk
bid0IGZpZ3VyZSBvdXQuIEhvdyBkbyBjcHVzIGdldCBzd2l0Y2hlZCBPTiBvciBPRkYgb24gdGhp
cyBwbGF0Zm9ybShmb3INCj4gZXhhbXBsZSBkdXJpbmcgQ1BVIGhvdHBsdWcpID8NCj4gDQo+IC0t
DQo+IFJlZ2FyZHMsDQo+IFN1ZGVlcA0KDQoNCkluIHRoaXMgcGF0Y2gsIEkganVzdCB3YW50IHRv
IHN1Ym1pdCBjcHVpZGxlIGZ1bmN0aW9uLg0KU28gdGhlcmUgaGF2ZSBubyBjcHUgaG90cGx1ZyBm
dW5jdGlvbiBub3cuDQoNCg0KDQqq9KurrnAgRWR3aW5DaGl1DQq0vK/guUK64rFNrtcNClQ6ICs4
ODYtMy01Nzg2MDA1IGV4dC4yNTkwDQplZHdpbi5jaGl1QHN1bnBsdXMuY29tDQozMDAgt3Omy6zs
vse26bDPs9C3c6RAuPQxObi5DQo=
