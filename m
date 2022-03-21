Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E908F4E1F13
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbiCUChJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238487AbiCUChH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:37:07 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EAB6A4C7A6;
        Sun, 20 Mar 2022 19:35:40 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10880:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 21 Mar 2022 10:35:52 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 21 Mar 2022 10:35:46 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 21 Mar 2022 10:35:46 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v4 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Topic: [PATCH v4 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Index: AQHYOzO5KyAdMjgPQEaJFU8W2wW2NazHonKAgAF9QKA=
Date:   Mon, 21 Mar 2022 02:35:46 +0000
Message-ID: <cab5bdafed86451a99cd59da3b1c5a38@sphcmbx02.sunplus.com.tw>
References: <cover.1647652688.git.tonyhuang.sunplus@gmail.com>
 <27dba330ec0c1cd7edbcec53083f78169713a42e.1647652688.git.tonyhuang.sunplus@gmail.com>
 <c78aa9fa-8001-2c48-7a25-1f44f9952c9b@kernel.org>
In-Reply-To: <c78aa9fa-8001-2c48-7a25-1f44f9952c9b@kernel.org>
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

RGVhciBLcnp5c3p0b2Y6DQoNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL3N1bnBsdXMsbW1jLnlhbWwNCj4gPiBAQCAtMCwwICsxLDc5IEBADQo+ID4gKyMg
U1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAj
IENvcHlyaWdodA0KPiA+ICsoQykgU3VucGx1cyBMdGQuIENvLiAyMDIxICVZQU1MIDEuMg0KPiA+
ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9tbWMvc3VucGx1
cyxtbWMueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogc3VucGx1cyBNTUMgY29udHJvbGxl
cg0KPiANCj4gcy9zdW5wbHVzL1N1bnBsdXMvDQo+IA0KDQpCZWxvdyBpcyBteSBtb2RpZmljYXRp
b246DQp0aXRsZTogU3VucGx1cyBNTUMgQ29udHJvbGxlcg0KDQo+ID4gKw0KPiA+ICthbGxPZjoN
Cj4gPiArICAtICRyZWY6ICJtbWMtY29udHJvbGxlci55YW1sIg0KPiANCj4gYWxsT2YgYmVsb3cg
bWFpbnRhaW5lcnMsDQo+IA0KDQpJIHdpbGwgbW9kaWZ5IGl0Lg0KDQo+ID4gKw0KPiA+ICttYWlu
dGFpbmVyczoNCj4gPiArICAtIFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNv
bT4NCj4gPiArICAtIExpLWhhbyBLdW8gPGxoamVmZjkxMUBnbWFpbC5jb20+DQo+ID4gKw0KPiA+
ICtwcm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsg
ICAgICAtIHN1bnBsdXMsbW1jLXYxDQo+ID4gKyAgICAgIC0gc3VucGx1cyxtbWMtdjINCj4gDQo+
IEhvdyBkaWQgdGhpcyBoYXBwZW4/IFZlcnNpb25zIG9mIGJsb2NrcyBhcmUgdXN1YWxseSBkaXNj
b3VyYWdlZCwgdW5sZXNzIHlvdQ0KPiBoYXZlIGNsZWFyIHNwZWNpZmljYXRpb24sLiBUaGUgcHJl
dmlvdXMgZGlzY3Vzc2lvbiBkaWQgbm90IGVuZCB3aXRoICJhZGQgdjEgYW5kDQo+IHYyIi4NCj4g
DQo+IERvIHlvdSBoYXZlIGNsZWFyIGRvY3VtZW50YXRpb24vc3BlY2lmaWNhdGlvbiBvZiB0aGVz
ZSBibG9ja3M/IElmIG5vLCBwbGVhc2UNCj4gdXNlIFNvQyBjb21wYXRpYmxlcy4NCj4gDQoNCnYx
OiBzdXBwb3J0IFNESU8gMi4wCQkJCQkJCQ0KdjI6IHN1cHBvcnQgZU1NQyA0LjQxCQkJCQkJCQ0K
VGhlIHJlZ2lzdGVyIGJhc2UgYWRkcmVzcyBhbmQgb2Zmc2V0IGFkZHJlc3Mgb2YgZW1tYyBhbmQg
c2QgY2FyZCBhcmUgZGlmZmVyZW50LgkJCQkJCQkNCmVNTUMgYW5kIHNkY2FyZCBhcmUgaW5kaXZp
ZHVhbCBoYXJkd2FyZSBzZXR0aW5ncwkJCQkJCQkNCldlIG5lZWQgdmVyc2lvbiB0byBkaXN0aW5n
dWlzaCBkaWZmZXJlbnQgc3BlZWRzCQkJCQkJCQ0KDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiAr
ICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBtYXhJ
dGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtaW5JdGVtczogMQ0KPiAN
Cj4gbWF4SXRlbXMNCj4gDQoNCkkgd2lsbCBtb2RpZnkgaXQuDQoNCj4gPiArDQo+ID4gKyAgcmVz
ZXRzOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgbWF4LWZyZXF1ZW5jeTog
dHJ1ZQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxlDQo+ID4gKyAg
LSByZWcNCj4gPiArICAtIGludGVycnVwdHMNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gcmVz
ZXRzDQo+ID4gKw0KPiA+ICt1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQo+ID4gKw0KPiA+
ICtleGFtcGxlczoNCj4gPiArICAtIHwNCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5ncy9p
bnRlcnJ1cHQtY29udHJvbGxlci9pcnEuaD4NCj4gPiArICAgICNpbmNsdWRlIDxkdC1iaW5kaW5n
cy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+ID4gKyAgICBtbWMwOiBtbWNAOWMw
MDNiMDAgew0KPiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAic3VucGx1cyxtbWMtdjIiOw0KPiA+
ICsgICAgICAgIHJlZyA9IDwweDljMDAzYjAwIDB4MTgwPjsNCj4gPiArICAgICAgICBpbnRlcnJ1
cHRzID0gPDIwIElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsgICAgICAgIGNsb2NrcyA9IDwm
Y2xrYyAweDRlPjsNCj4gPiArICAgICAgICByZXNldHMgPSA8JnJzdGMgMHgzZT47DQo+ID4gKyAg
ICAgICAgYnVzLXdpZHRoID0gPDg+Ow0KPiA+ICsgICAgICAgIG1heC1mcmVxdWVuY3kgPSA8NTIw
MDAwMDA+Ow0KPiA+ICsgICAgICAgIG5vbi1yZW1vdmFibGU7DQo+ID4gKyAgICAgICAgZGlzYWJs
ZS13cDsNCj4gPiArICAgICAgICBjYXAtbW1jLWhpZ2hzcGVlZDsNCj4gPiArICAgICAgICBtbWMt
ZGRyLTNfM3Y7DQo+ID4gKyAgICAgICAgbm8tc2RpbzsNCj4gPiArICAgICAgICBuby1zZDsNCj4g
PiArICAgIH07DQo+ID4gKw0KPiA+ICsgICAgbW1jMTogbW1jQDljMDAzZTgwIHsNCj4gPiArICAg
ICAgIGNvbXBhdGlibGUgPSAic3VucGx1cyxtbWMtdjEiOw0KPiA+ICsgICAgICAgcmVnID0gPDB4
OWMwMDNlODAgMHgyODA+Ow0KPiA+ICsgICAgICAgaW50ZXJydXB0cyA9IDwyMSBJUlFfVFlQRV9M
RVZFTF9ISUdIPjsNCj4gPiArICAgICAgIGNsb2NrcyA9IDwmY2xrYyAweDRmPjsNCj4gPiArICAg
ICAgIHJlc2V0cyA9IDwmcnN0YyAweDNmPjsNCj4gPiArICAgICAgIHBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ID4gKyAgICAgICBwaW5jdHJsLTAgPSA8Jm1tYzFfbXV4ICZtbWMxX211eF9j
ZD47DQo+ID4gKyAgICAgICBtYXgtZnJlcXVlbmN5ID0gPDUyMDAwMDAwPjsNCj4gPiArICAgICAg
IGRpc2FibGUtd3A7DQo+ID4gKyAgICAgICBjYXAtc2QtaGlnaHNwZWVkOw0KPiA+ICsgICAgICAg
bm8tc2RpbzsNCj4gPiArICAgICAgIG5vLW1tYzsNCj4gPiArICAgIH07DQo+ID4gZGlmZiAtLWdp
dCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMgaW5kZXggZmIxOGNlNy4uMmQ5MTQzMSAxMDA2
NDQNCj4gPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiA+ICsrKyBiL01BSU5UQUlORVJTDQo+ID4gQEAg
LTE4MjQyLDYgKzE4MjQyLDEyIEBAIEw6CW5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzoJ
TWFpbnRhaW5lZA0KPiA+ICBGOglkcml2ZXJzL25ldC9ldGhlcm5ldC9kbGluay9zdW5kYW5jZS5j
DQo+ID4NCj4gPiArU1VOUExVUyBNTUMgRFJJVkVSDQo+ID4gK006CVRvbnkgSHVhbmcgPHRvbnlo
dWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiArTTogTGktaGFvIEt1byA8bGhqZWZmOTExQGdt
YWlsLmNvbT4NCj4gDQo+IFdyb25nIGluZGVudGF0aW9uLg0KDQpJIHdpbGwgbW9kaWZ5IGl0Lg0K
DQo+IA0KPiA+ICtTOglNYWludGFpbmVkDQo+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvc3VucGx1LG1tYy55YW1sDQo+IA0KPiBXcm9uZyBmaWxlIG5hbWUuDQo+
IA0KDQpJIHdpbGwgbW9kaWZ5IGl0Lg0KDQo=
