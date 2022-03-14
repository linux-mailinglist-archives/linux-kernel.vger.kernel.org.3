Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CE3E4D791E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 02:37:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235756AbiCNBiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 21:38:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbiCNBiE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 21:38:04 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F332B31DE1;
        Sun, 13 Mar 2022 18:36:53 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10874:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 14 Mar 2022 09:37:11 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 14 Mar 2022 09:37:06 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 14 Mar 2022 09:37:06 +0800
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
Thread-Index: AQHYNiyKdSfO42iHq0+Lq46VktzTVKy8iGwAgAGSqFA=
Date:   Mon, 14 Mar 2022 01:37:06 +0000
Message-ID: <a10c6b10b3f14c3d9d530ec89552cf3a@sphcmbx02.sunplus.com.tw>
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
 <c0ef91adc0af9fedca2791e4006009fabfdfef2c.1647095774.git.tonyhuang.sunplus@gmail.com>
 <8eb40370-9b33-e97c-a576-18ba23266084@kernel.org>
In-Reply-To: <8eb40370-9b33-e97c-a576-18ba23266084@kernel.org>
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
aWNldHJlZS5vcmcvc2NoZW1hcy9taXNjL3N1bnBsdXMtaW9wLnlhbWwjDQo+IA0KPiBTdGlsbCB3
cm9uZyBwYXRoLiBUaGlzIHdvdWxkIGJlIGVhc2lseSBzcG90dGVkIGlmIHlvdSB0ZXN0IHRoZSBi
aW5kaW5ncy4NCj4gUGxlYXNlIHJ1biBkdF9iaW5kaW5nX2NoZWNrLiBJdCdzIGEgcmVxdWlyZW1l
bnQuDQoNCkkgaGF2ZSBydW4gZHRfYmluZGluZ19jaGVjayBhbmQgZG9uJ3Qgc2VlIGVycm9yLg0K
QmVsb3cgaXMgbXkgbW9kaWZpY2F0aW9uDQokaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hl
bWFzL21pc2Mvc3VucGx1cyxpb3AueWFtbCMNCg0KPiANCj4gPiArJHNjaGVtYTogaHR0cDovL2Rl
dmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTog
U3VucGx1cyBJT1AoODA1MSkgY29udHJvbGxlcg0KPiA+ICsNCj4gPiArbWFpbnRhaW5lcnM6DQo+
ID4gKyAgLSBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+DQo+ID4gKw0K
PiA+ICtkZXNjcmlwdGlvbjogfA0KPiA+ICsgIFByb2Nlc3NvciBmb3IgSS9PIGNvbnRyb2wsIFJU
QyB3YWtlLXVwIHByb2NlZHVyZSBtYW5hZ2VtZW50LA0KPiA+ICsgIGFuZCBjb29wZXJhdGlvbiB3
aXRoIENQVSZQTUMgaW4gcG93ZXIgbWFuYWdlbWVudC4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6
DQo+ID4gKyAgY29tcGF0aWJsZToNCj4gPiArICAgIGVudW06DQo+ID4gKyAgICAgIC0gc3VucGx1
cyxzcDcwMjEtaW9wDQo+ID4gKw0KPiA+ICsgIHJlZzoNCj4gPiArICAgIGl0ZW1zOg0KPiA+ICsg
ICAgICAtIGRlc2NyaXB0aW9uOiBJT1AgcmVnaXN0ZXJzIHJlZ2lvbnMNCj4gPiArICAgICAgLSBk
ZXNjcmlwdGlvbjogUE1DIHJlZ2lzdGVycyByZWdpb25zDQo+ID4gKyAgICAgIC0gZGVzY3JpcHRp
b246IE1PT04wIHJlZ2lzdGVycyByZWdpb25zDQo+ID4gKw0KPiA+ICsgIHJlZy1uYW1lczoNCj4g
PiArICAgIGl0ZW1zOg0KPiA+ICsgICAgICAtIGNvbnN0OiBpb3ANCj4gPiArICAgICAgLSBjb25z
dDogaW9wX3BtYw0KPiA+ICsgICAgICAtIGNvbnN0OiBtb29uMA0KPiA+ICsNCj4gPiArICBpbnRl
cnJ1cHRzOg0KPiA+ICsgICAgaXRlbXM6DQo+ID4gKyAgICAgIC0gZGVzY3JpcHRpb246IElPUF9J
TlQwLiBJT1AgdG8gc3lzdGVtIEludGVycnVwdCAwLg0KPiA+ICsgICAgICAgICAgICAgICAgICAg
ICBTZW50IGJ5IElPUCB0byBzeXN0ZW0gUklTQy4NCj4gPiArICAgICAgLSBkZXNjcmlwdGlvbjog
SU9QX0lOVDEuIElPUCB0byBTeXN0ZW0gSW50ZXJydXB0IDEuDQo+ID4gKyAgICAgICAgICAgICAg
ICAgICAgIFNlbnQgYnkgSU9QIHRvIHN5c3RlbSBSSVNDLg0KPiA+ICsNCj4gPiArICBtZW1vcnkt
cmVnaW9uOg0KPiA+ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgd2FrZXVwLWdwaW9z
Og0KPiA+ICsgICAgZGVzY3JpcHRpb246IFdoZW4gdGhlIGxpbnV4IGtlcm5lbCBzeXN0ZW0gaXMg
cG93ZXJlZCBvZmYuDQo+ID4gKyAgICAgIDgwNTEgaXMgYWx3YXlzIHBvd2VyZWQuIDgwNTEgY2Fu
ZCByZWNlaXZlIGV4dGVybmFsIHNpZ25hbHMNCj4gPiArICAgICAgYWNjb3JkaW5nIHRvIHRoaXMg
Z3BpbyBwaW4uIDgwNTEgcmVjZWl2ZXMgZXh0ZXJuYWwgc2lnbmFsDQo+ID4gKyAgICAgIHRocm91
Z2ggZ3BpbyBwaW4uIDgwNTEgY2FuIHBvd2VyIG9uIGxpbnV4IGtlcm5lbCBzeXN0ZW0uDQo+ID4g
KyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRp
YmxlDQo+ID4gKyAgLSByZWcNCj4gPiArICAtIHJlZy1uYW1lcw0KPiA+ICsgIC0gY2xvY2tzDQo+
ID4gKyAgLSBpbnRlcnJ1cHRzDQo+ID4gKyAgLSBtZW1vcnktcmVnaW9uDQo+ID4gKyAgLSB3YWtl
dXAtZ3Bpb3MNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0KPiA+ICsN
Cj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmluZGlu
Z3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvaXJxLmg+DQo+ID4gKyAgICAjaW5jbHVkZSA8ZHQtYmlu
ZGluZ3MvaW50ZXJydXB0LWNvbnRyb2xsZXIvYXJtLWdpYy5oPg0KPiA+ICsgICAgI2luY2x1ZGUg
PGR0LWJpbmRpbmdzL2dwaW8vZ3Bpby5oPg0KPiA+ICsgICAgaW9wOiBpb3BAOWMwMDA0MDAgew0K
PiA+ICsgICAgICAgIGNvbXBhdGlibGUgPSAic3VucGx1cyxzcDcwMjEtaW9wIjsNCj4gPiArICAg
ICAgICByZWcgPSA8MHg5YzAwMDQwMCAweDgwPiwgPDB4OWMwMDMxMDAgMHg4MD4sIDwweDljMDAw
MDAwDQo+IDB4ODA+Ow0KPiA+ICsgICAgICAgIHJlZy1uYW1lcyA9ICJpb3AiLCAiaW9wX3BtYyIs
ICJtb29uMCI7DQo+ID4gKyAgICAgICAgY2xvY2tzID0gPCZjbGtjIDB4MTQ+Ow0KPiA+ICsgICAg
ICAgIGludGVycnVwdC1wYXJlbnQgPSA8JmludGM+Ow0KPiA+ICsgICAgICAgIGludGVycnVwdHMg
PSA8NDEgSVJRX1RZUEVfTEVWRUxfSElHSD4sIDw0Mg0KPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gPiArICAgICAgICBtZW1vcnktcmVnaW9uID0gPCZpb3BfcmVzZXJ2ZT47DQo+ID4gKyAgICAg
ICAgcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gPiArICAgICAgICBwaW5jdHJsLTAgPSA8
JmlvcF9waW5zPjsNCj4gPiArICAgICAgICB3YWtldXAtZ3Bpb3MgPSA8JnBjdGwgMSBHUElPX0FD
VElWRV9ISUdIPjsNCj4gPiArICAgIH07DQo+ID4gXCBObyBuZXdsaW5lIGF0IGVuZCBvZiBmaWxl
DQoNCkkgd2lsbCBtb2RpZnkuDQoNCg==
