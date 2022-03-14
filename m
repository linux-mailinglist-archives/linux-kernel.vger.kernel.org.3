Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B5A4D7920
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235764AbiCNBkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiCNBkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:40:40 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D3CF5369EB;
        Sun, 13 Mar 2022 18:39:29 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10888:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 14 Mar 2022 09:39:50 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 14 Mar 2022 09:39:45 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 14 Mar 2022 09:39:45 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v11 1/2] dt-bindings: misc: Add iop yaml file for Sunplus
 SP7021
Thread-Topic: [PATCH v11 1/2] dt-bindings: misc: Add iop yaml file for Sunplus
 SP7021
Thread-Index: AQHYNiyKdSfO42iHq0+Lq46VktzTVKy8ijeAgAGRsMA=
Date:   Mon, 14 Mar 2022 01:39:45 +0000
Message-ID: <15e1d1f2586f4ebfb7220771f72085c4@sphcmbx02.sunplus.com.tw>
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
 <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
 <45c40613-fe0a-1a5e-408c-493f4d012aa6@kernel.org>
In-Reply-To: <45c40613-fe0a-1a5e-408c-493f4d012aa6@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
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

RGVhciBLcnp5c3p0b2Y6DQoNCj4gT24gMTIvMDMvMjAyMiAxNzoxNiwgVG9ueSBIdWFuZyB3cm90
ZToNCj4gPiBBZGQgaW9wIHlhbWwgZmlsZSBmb3IgU3VucGx1cyBTUDcwMjENCj4gPg0KPiA+IFJl
dmlld2VkLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPg0KPiA+IFNpZ25lZC1vZmYt
Ynk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiAtLS0NCj4g
PiBDaGFuZ2VzIGluIHYxMToNCj4gPiAgLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBrcnp5c3p0
b2YuDQo+ID4NCj4gPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3MvbWlzYy9zdW5wbHVzLGlvcC55
YW1sICAgICAgfCA3OA0KPiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIE1BSU5UQUlORVJT
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDUgKysNCj4gPiAgMiBm
aWxlcyBjaGFuZ2VkLCA4MyBpbnNlcnRpb25zKCspDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NA0K
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3N1bnBsdXMsaW9wLnlh
bWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWlzYy9zdW5wbHVzLGlvcC55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvbWlzYy9zdW5wbHVzLGlvcC55YW1sDQo+ID4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gPiBpbmRleCAwMDAwMDAwLi5hZDFjNGJlDQo+ID4gLS0tIC9kZXYvbnVsbA0KPiA+ICsrKyBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9taXNjL3N1bnBsdXMsaW9wLnlhbWwN
Cj4gPiBAQCAtMCwwICsxLDc4IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAjIENvcHlyaWdodA0KPiA+ICsoQykgU3VucGx1
cyBMdGQuIENvLiAyMDIxICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9taXNjL3N1bnBsdXMtaW9wLnlhbWwjDQo+ID4gKyRzY2hlbWE6
IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsNCj4g
PiArdGl0bGU6IFN1bnBsdXMgSU9QKDgwNTEpIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK21haW50
YWluZXJzOg0KPiA+ICsgIC0gVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29t
Pg0KPiA+ICsNCj4gPiArZGVzY3JpcHRpb246IHwNCj4gPiArICBQcm9jZXNzb3IgZm9yIEkvTyBj
b250cm9sLCBSVEMgd2FrZS11cCBwcm9jZWR1cmUgbWFuYWdlbWVudCwNCj4gPiArICBhbmQgY29v
cGVyYXRpb24gd2l0aCBDUFUmUE1DIGluIHBvd2VyIG1hbmFnZW1lbnQuDQo+ID4gKw0KPiA+ICtw
cm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAg
ICAtIHN1bnBsdXMsc3A3MDIxLWlvcA0KPiA+ICsNCj4gPiArICByZWc6DQo+ID4gKyAgICBpdGVt
czoNCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjogSU9QIHJlZ2lzdGVycyByZWdpb25zDQo+ID4g
KyAgICAgIC0gZGVzY3JpcHRpb246IFBNQyByZWdpc3RlcnMgcmVnaW9ucw0KPiA+ICsgICAgICAt
IGRlc2NyaXB0aW9uOiBNT09OMCByZWdpc3RlcnMgcmVnaW9ucw0KPiA+ICsNCj4gPiArICByZWct
bmFtZXM6DQo+ID4gKyAgICBpdGVtczoNCj4gPiArICAgICAgLSBjb25zdDogaW9wDQo+ID4gKyAg
ICAgIC0gY29uc3Q6IGlvcF9wbWMNCj4gPiArICAgICAgLSBjb25zdDogbW9vbjANCj4gPiArDQo+
ID4gKyAgaW50ZXJydXB0czoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGRlc2NyaXB0
aW9uOiBJT1BfSU5UMC4gSU9QIHRvIHN5c3RlbSBJbnRlcnJ1cHQgMC4NCj4gPiArICAgICAgICAg
ICAgICAgICAgICAgU2VudCBieSBJT1AgdG8gc3lzdGVtIFJJU0MuDQo+ID4gKyAgICAgIC0gZGVz
Y3JpcHRpb246IElPUF9JTlQxLiBJT1AgdG8gU3lzdGVtIEludGVycnVwdCAxLg0KPiA+ICsgICAg
ICAgICAgICAgICAgICAgICBTZW50IGJ5IElPUCB0byBzeXN0ZW0gUklTQy4NCj4gPiArDQo+ID4g
KyAgbWVtb3J5LXJlZ2lvbjoNCj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIHdh
a2V1cC1ncGlvczoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBXaGVuIHRoZSBsaW51eCBrZXJuZWwg
c3lzdGVtIGlzIHBvd2VyZWQgb2ZmLg0KPiA+ICsgICAgICA4MDUxIGlzIGFsd2F5cyBwb3dlcmVk
LiA4MDUxIGNhbmQgcmVjZWl2ZSBleHRlcm5hbCBzaWduYWxzDQo+ID4gKyAgICAgIGFjY29yZGlu
ZyB0byB0aGlzIGdwaW8gcGluLiA4MDUxIHJlY2VpdmVzIGV4dGVybmFsIHNpZ25hbA0KPiA+ICsg
ICAgICB0aHJvdWdoIGdwaW8gcGluLiA4MDUxIGNhbiBwb3dlciBvbiBsaW51eCBrZXJuZWwgc3lz
dGVtLg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsg
IC0gY29tcGF0aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSByZWctbmFtZXMNCj4gPiArICAt
IGNsb2Nrcw0KPiANCj4gV2h5IGRvIHlvdSBoYXZlIGNsb2NrcyBoZXJlIGJ1dCBub3QgaW4gcHJv
cGVydGllcz8NCg0KSSB3aWxsIG1vZGlmeS4gQWRkIGNsb2NrcyBpbiBwcm9wZXJ0aWVzLg0KDQo=
