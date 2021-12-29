Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B07480EBF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 02:57:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238292AbhL2B5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 20:57:32 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:60276
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238285AbhL2B5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 20:57:31 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(4610:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Wed, 29 Dec 2021 09:57:32 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Wed, 29 Dec 2021 09:57:32 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Wed, 29 Dec 2021 09:57:32 +0800
From:   =?big5?B?VG9ueSBIdWFuZyC2wMNoq3A=?= <tony.huang@sunplus.com>
To:     Rob Herring <robh@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v5 1/2] dt-binding: misc: Add iop yaml file for Sunplus
 SP7021
Thread-Topic: [PATCH v5 1/2] dt-binding: misc: Add iop yaml file for Sunplus
 SP7021
Thread-Index: AQHX+KFTE+nhXo4y7kaVGkJTGla/nqxGCmuAgAKxoPA=
Date:   Wed, 29 Dec 2021 01:57:32 +0000
Message-ID: <eafd00b2fca947b894607fb327594b76@sphcmbx02.sunplus.com.tw>
References: <cover.1640332430.git.tonyhuang.sunplus@gmail.com>
 <edc63b968d7903cc6e96151c7e51cd6446835b70.1640332430.git.tonyhuang.sunplus@gmail.com>
 <YcntOas63oWyZ1sq@robh.at.kernel.org>
In-Reply-To: <YcntOas63oWyZ1sq@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBSb2I6DQoNCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSAxLzJdIGR0LWJpbmRpbmc6IG1p
c2M6IEFkZCBpb3AgeWFtbCBmaWxlIGZvciBTdW5wbHVzDQo+IFNQNzAyMQ0KPiANCj4gT24gRnJp
LCBEZWMgMjQsIDIwMjEgYXQgMDQ6MzU6NTVQTSArMDgwMCwgVG9ueSBIdWFuZyB3cm90ZToNCj4g
PiBBZGQgaW9wIHlhbWwgZmlsZSBmb3IgU3VucGx1cyBTUDcwMjENCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIGluIHY1Og0KPiA+IC1BZGQgaW9wLXdha2V1cCBwaW4gZm9yIDgwNTEgdG8g
d2FrZSB1cCB0aGUgTGludXgga2VybmVsIGluIHNodXRkb3duDQo+IG1vZGUuDQo+ID4NCj4gPiAg
Li4uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9zdW5wbHVzLWlvcC55YW1sICAgICAgfCA3Mg0K
PiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA3
NyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+IERvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3N1bnBsdXMtaW9wLnlhbWwNCj4gPg0KPiA+IGRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9zdW5wbHVz
LWlvcC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9z
dW5wbHVzLWlvcC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gPiBpbmRleCAwMDAw
MDAwLi5mYWQwZjUwDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3N1bnBsdXMtaW9wLnlhbWwNCj4gPiBAQCAtMCwwICsx
LDcyIEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1Ig
QlNELTItQ2xhdXNlKSAjIENvcHlyaWdodA0KPiA+ICsoQykgU3VucGx1cyBMdGQuIENvLiAyMDIx
ICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2No
ZW1hcy9taXNjL3N1bnBsdXMtaW9wLnlhbWwjDQo+ID4gKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0
cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4gPiArdGl0bGU6IFN1bnBs
dXMgSU9QKDgwNTEpIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0KPiA+ICsg
IC0gVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tPg0KPiA+ICsNCj4gPiAr
ZGVzY3JpcHRpb246IHwNCj4gPiArICBQcm9jZXNzb3IgZm9yIEkvTyBjb250cm9sLCBSVEMgd2Fr
ZS11cCBwcm9jZWR1cmUgbWFuYWdlbWVudCwNCj4gPiArICBhbmQgY29vcGVyYXRpb24gd2l0aCBD
UFUmUE1DIGluIHBvd2VyIG1hbmFnZW1lbnQuDQo+ID4gKw0KPiA+ICtwcm9wZXJ0aWVzOg0KPiA+
ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAgICAtIHN1bnBsdXMsc3A3
MDIxLWlvcA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAg
LSBkZXNjcmlwdGlvbjogSU9QIHJlZ2lzdGVycyByZWdpb25zDQo+ID4gKyAgICAgIC0gZGVzY3Jp
cHRpb246IFBNQyByZWdpc3RlcnMgcmVnaW9ucw0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBN
T09OMCByZWdpc3RlcnMgcmVnaW9ucw0KPiA+ICsNCj4gPiArICByZWctbmFtZXM6DQo+ID4gKyAg
ICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogaW9wDQo+ID4gKyAgICAgIC0gY29uc3Q6IGlv
cF9wbWMNCj4gPiArICAgICAgLSBjb25zdDogbW9vbjANCj4gPiArDQo+ID4gKyAgaW50ZXJydXB0
czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0aW9uOiBJT1BfSU5UMC4g
SU9QIHRvIHN5c3RlbSBJbnRlcnJ1cHQgMC4NCj4gPiArICAgICAgICAgICAgICAgICAgICAgU2Vu
dCBieSBJT1AgdG8gc3lzdGVtIFJJU0MuDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IElPUF9J
TlQxLiBJT1AgdG8gU3lzdGVtIEludGVycnVwdCAxLg0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBTZW50IGJ5IElPUCB0byBzeXN0ZW0gUklTQy4NCj4gPiArDQo+ID4gKyAgbWVtb3J5LXJlZ2lv
bjoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGlvcC13YWtldXA6DQo+ID4g
KyAgICBkZXNjcmlwdGlvbjogTm90aWZ5IDgwNTEgdG8gd2FrZSB1cCB0aGUgTGludXgga2VybmVs
Lg0KPiANCj4gV2hhdCBkb2VzIHRoYXQgbWVhbj8gV2hhdCdzIHRoZSB0eXBlPyBEb2VzIHRoZSBz
dGFuZGFyZCAnd2FrZXVwLXNvdXJjZScNCj4gcHJvcGVydHkgbm90IHdvcmsgaGVyZT8NCj4gDQoN
CldoZW4gbW91bnRpbmcgSU9QICg4MDUxKS4gV2UgY2FuIGFzc2lnbiBhIGdwaW8gcGluIHRvIDgw
NTEuDQpXaGVuIHRoZSBsaW51eCBrZXJuZWwgc3lzdGVtIGlzIHBvd2VyZWQgb2ZmLiA4MDUxIGlz
IGFsd2F5cyBwb3dlcmVkLg0KODA1MSBjYW4gcmVjZWl2ZSBleHRlcm5hbCBzaWduYWxzIGFjY29y
ZGluZyB0byB0aGlzIGdwaW8gcGluIC4NCjgwNTEgcmVjZWl2ZXMgZXh0ZXJuYWwgc2lnbmFsIHRo
cm91Z2ggZ3BpbyBwaW4uIDgwNTEgY2FuIHBvd2VyIG9uIGxpbnV4IGtlcm5lbCBzeXN0ZW0uDQoN
Cj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVn
DQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIG1lbW9y
eS1yZWdpb24NCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsN
Cj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+ICsgICAgaW9wOiBpb3BAOWMwMDA0MDAgew0K
PiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAic3VucGx1cyxzcDcwMjEtaW9wIjsNCj4gPiArICAg
ICAgICByZWcgPSA8MHg5YzAwMDQwMCAweDgwPiwgPDB4OWMwMDMxMDAgMHg4MD4sIDwweDljMDAw
MDAwDQo+IDB4ODA+Ow0KPiA+ICsgICAgICAgIHJlZy1uYW1lcyA9ICJpb3AiLCAiaW9wX3BtYyIs
ICJtb29uMCI7DQo+ID4gKyAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmaW50Yz47DQo+ID4g
KyAgICAgICAgaW50ZXJydXB0cyA9IDw0MSBJUlFfVFlQRV9MRVZFTF9ISUdIPiwgPDQyDQo+IElS
UV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgIG1lbW9yeS1yZWdpb24gPSA8JmlvcF9y
ZXNlcnZlPjsNCj4gPiArICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsg
ICAgICAgIHBpbmN0cmwtMCA9IDwmaW9wX3BpbnM+Ow0KPiA+ICsgICAgICAgIGlvcC13YWtldXAg
PSA8JnBjdGwgMSBHUElPX0FDVElWRV9ISUdIPjsNCj4gDQo+IFRoYXQncyBub3QgaG93IHRoZSBH
UElPIGJpbmRpbmcgd29ya3MuDQo+IA0KPiA+ICsgICAgfTsNCj4gPiArLi4uDQo+ID4gZGlmZiAt
LWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXggM2I3OWZkNC4uMDcxYjVlNiAx
MDA2NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4g
QEAgLTE3OTQ1LDYgKzE3OTQ1LDExIEBAIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAg
UzoJTWFpbnRhaW5lZA0KPiA+ICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9kbGluay9zdW5kYW5j
ZS5jDQo+ID4NCj4gPiArU1VOUExVUyBJT1AgRFJJVkVSDQo+ID4gK006CVRvbnkgSHVhbmcgPHRv
bnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiArUzoJTWFpbnRhaW5lZA0KPiA+ICtGOglE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9zdW5wbHUtaW9wLnlhbWwNCj4g
PiArDQo+ID4gIFNVUEVSSA0KPiA+ICBNOglZb3NoaW5vcmkgU2F0byA8eXNhdG9AdXNlcnMuc291
cmNlZm9yZ2UuanA+DQo+ID4gIE06CVJpY2ggRmVsa2VyIDxkYWxpYXNAbGliYy5vcmc+DQo+ID4g
LS0NCj4gPiAyLjcuNA0KPiA+DQo+ID4NCg==
