Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C10F4ED718
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbiCaJiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234206AbiCaJht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:37:49 -0400
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2695DC3374;
        Thu, 31 Mar 2022 02:36:00 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(30220:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Thu, 31 Mar 2022 17:35:49 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 31 Mar 2022 17:35:48 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Thu, 31 Mar 2022 17:35:48 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v5 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Topic: [PATCH v5 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Index: AQHYQ3s7AWWAn1pcyEaVCbkq9QRphazWDP+AgAMwGSA=
Date:   Thu, 31 Mar 2022 09:35:48 +0000
Message-ID: <cdef40f96f084d17b79d67cf8ed7c5f5@sphcmbx02.sunplus.com.tw>
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
 <abd34a74bf56e04050868c63d030552a9af210f4.1648551070.git.tonyhuang.sunplus@gmail.com>
 <85ed0e5b-0c6f-aea0-ea89-522591d85420@linaro.org>
In-Reply-To: <85ed0e5b-0c6f-aea0-ea89-522591d85420@linaro.org>
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

RGVhciBLcnp5c3p0b2Y6DQoNCj4gPiBBZGQgbW1jIHlhbWwgZmlsZSBmb3IgU3VucGx1cyBTUDcw
MjENCj4gDQo+IHMvbW1jL01NQy8NCj4gcy95YW1sL1lBTUwvDQo+IEFuZCBhIGZ1bGwgc3RvcC4N
Cj4gDQoNCk9LLCBJIHdpbGwgbW9kaWZ5IGl0Lg0KDQo+IFBsZWFzZSByZWJhc2UgeW91ciBjaGFu
Z2VzIG9uIHJlY2VudCBMaW51eCBrZXJuZWwsIGJlY2F1c2UgeW91IHNraXAgQ2MtaW5nIG1lDQo+
IGFsbCB0aGUgdGltZSwgc28gSSBhc3N1bWUgeW91IGhhdmUgc29tZSBvbGQgTWFpbnRhaW5lcnMg
ZmlsZS4NCj4gDQoNCk9LLCBJIHdpbGwgcGF5IGF0dGVudGlvbi4NCg0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tPg0KPiA+IC0t
LQ0KPiA+IENoYW5nZXMgaW4gdjU6DQo+ID4gIC0gQWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gS3J6
eXN6dG9mLg0KPiA+DQo+ID4gIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zdW5wbHVzLG1t
Yy55YW1sICAgICAgIHwgNjQNCj4gKysrKysrKysrKysrKysrKysrKysrKw0KPiA+ICBNQUlOVEFJ
TkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ID4g
IDIgZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2
NDQNCj4gPiBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnBsdXMsbW1j
LnlhbWwNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbW1jL3N1bnBsdXMsbW1jLnlhbWwNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9tbWMvc3VucGx1cyxtbWMueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQo+ID4gaW5kZXggMDAwMDAwMC4uOTI1MzdkMA0KPiA+IC0tLSAvZGV2L251bGwNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnBsdXMsbW1jLnlhbWwN
Cj4gPiBAQCAtMCwwICsxLDY0IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChH
UEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKSAjIENvcHlyaWdodA0KPiA+ICsoQykgU3VucGx1
cyBMdGQuIENvLiAyMDIxICVZQU1MIDEuMg0KPiA+ICstLS0NCj4gPiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9tbWMvc3VucGx1cyxtbWMueWFtbCMNCj4gPiArJHNjaGVtYTog
aHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+
ICt0aXRsZTogU3VucGx1cyBNTUMgQ29udHJvbGxlcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6
DQo+ID4gKyAgLSBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+DQo+ID4g
KyAgLSBMaS1oYW8gS3VvIDxsaGplZmY5MTFAZ21haWwuY29tPg0KPiA+ICsNCj4gPiArYWxsT2Y6
DQo+ID4gKyAgLSAkcmVmOiAibW1jLWNvbnRyb2xsZXIueWFtbCINCj4gPiArDQo+ID4gK3Byb3Bl
cnRpZXM6DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0g
c3VucGx1cyxzcDcwMjEtbW1jDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIG1heEl0ZW1z
OiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+
ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBy
ZXNldHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBtYXgtZnJlcXVlbmN5
OiB0cnVlDQo+IA0KPiBJIHRoaW5rIHlvdSBkbyBub3QgbmVlZCB0aGlzLg0KPiANCg0KT0ssIEkg
d2lsbCBtb2RpZnkgaXQuDQoNCj4gPiArDQo+ID4gK3JlcXVpcmVkOg0KPiA+ICsgIC0gY29tcGF0
aWJsZQ0KPiA+ICsgIC0gcmVnDQo+ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBjbG9ja3MN
Cj4gPiArICAtIHJlc2V0cw0KPiA+ICsNCj4gPiArdW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxz
ZQ0KPiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8
ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAgICAjaW5jbHVk
ZSA8ZHQtYmluZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAg
bW1jMDogbW1jQDljMDAzYjAwIHsNCj4gPiArICAgICAgICBjb21wYXRpYmxlID0gInN1bnBsdXMs
bW1jLXYyIjsNCj4gPiArICAgICAgICByZWcgPSA8MHg5YzAwM2IwMCAweDE4MD47DQo+ID4gKyAg
ICAgICAgaW50ZXJydXB0cyA9IDwyMCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiArICAgICAg
ICBjbG9ja3MgPSA8JmNsa2MgMHg0ZT47DQo+ID4gKyAgICAgICAgcmVzZXRzID0gPCZyc3RjIDB4
M2U+Ow0KPiA+ICsgICAgICAgIGJ1cy13aWR0aCA9IDw4PjsNCj4gPiArICAgICAgICBtYXgtZnJl
cXVlbmN5ID0gPDUyMDAwMDAwPjsNCj4gPiArICAgICAgICBub24tcmVtb3ZhYmxlOw0KPiA+ICsg
ICAgICAgIGRpc2FibGUtd3A7DQo+ID4gKyAgICAgICAgY2FwLW1tYy1oaWdoc3BlZWQ7DQo+ID4g
KyAgICAgICAgbW1jLWRkci0zXzN2Ow0KPiA+ICsgICAgICAgIG5vLXNkaW87DQo+ID4gKyAgICAg
ICAgbm8tc2Q7DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5F
UlMgYi9NQUlOVEFJTkVSUyBpbmRleCBmYjE4Y2U3Li40MjQ5OGIyIDEwMDY0NA0KPiA+IC0tLSBh
L01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtMTgyNDIsNiArMTgy
NDIsMTIgQEAgTDoJbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiA+ICBTOglNYWludGFpbmVkDQo+
ID4gIEY6CWRyaXZlcnMvbmV0L2V0aGVybmV0L2RsaW5rL3N1bmRhbmNlLmMNCj4gPg0KPiA+ICtT
VU5QTFVTIE1NQyBEUklWRVINCj4gPiArTToJVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNA
Z21haWwuY29tPg0KPiA+ICtNOglMaS1oYW8gS3VvIDxsaGplZmY5MTFAZ21haWwuY29tPg0KPiA+
ICtTOglNYWludGFpbmVkDQo+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9tbWMvc3VucGx1LG1tYy55YW1sDQo+IA0KPiBJIHBvaW50ZWQgdGhpcyBhbHJlYWR5IGZvciB5
b3VyIHY0Lg0KPiANCg0KU29ycnksIEkgd2lsbCBtb2RpZnkgaXQuDQoNCg==
