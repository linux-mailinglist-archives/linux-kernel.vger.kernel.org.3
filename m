Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC184B08F3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 09:56:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238076AbiBJI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 03:56:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238052AbiBJI4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 03:56:12 -0500
Received: from mg.sunplus.com (mswedge2.sunplus.com [60.248.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DABDEF38;
        Thu, 10 Feb 2022 00:56:12 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(3703:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Thu, 10 Feb 2022 16:56:22 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 10 Feb 2022 16:56:22 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Thu, 10 Feb 2022 16:56:22 +0800
From:   =?big5?B?VG9ueSBIdWFuZyC2wMNoq3A=?= <tony.huang@sunplus.com>
To:     Rob Herring <robh@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>,
        =?big5?B?TGggS3VvILOipE+7qA==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Topic: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Index: AQHYHaGbHjb6ERvO1kGc6F944DDDK6yLDxUAgAEMUcA=
Date:   Thu, 10 Feb 2022 08:56:22 +0000
Message-ID: <40d202104eec46d2a35445e0128a124f@sphcmbx02.sunplus.com.tw>
References: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
 <f8b89f9981e17c023ce530afedb1f2b599edec0f.1644398657.git.tonyhuang.sunplus@gmail.com>
 <YgQQ2nJa12xblXBX@robh.at.kernel.org>
In-Reply-To: <YgQQ2nJa12xblXBX@robh.at.kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
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

RGVhciBSb2JoOg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nOiBt
bWM6IEFkZCBtbWMgeWFtbCBmaWxlIGZvciBTdW5wbHVzDQo+IFNQNzAyMQ0KPiANCj4gT24gV2Vk
LCBGZWIgMDksIDIwMjIgYXQgMDY6NDE6MDZQTSArMDgwMCwgVG9ueSBIdWFuZyB3cm90ZToNCj4g
PiBBZGQgbW1jIHlhbWwgZmlsZSBmb3IgU3VucGx1cyBTUDcwMjENCj4gPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiAtLS0N
Cj4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ICAtIGNvbWJpbmUgc2RjYXJkIGFuZCBlTU1DIGludG8g
b25lIGRyaXZlci4NCj4gPg0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1
cy1tbWMueWFtbCAgICAgICB8IDc2DQo+ICsrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJ
TlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgNiArKw0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykNCj4gPiAgY3JlYXRlIG1vZGUg
MTAwNjQ0DQo+ID4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zdW5wbHVz
LW1tYy55YW1sDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL21tYy9zdW5wbHVzLW1tYy55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2Rldmlj
ZXRyZWUvYmluZGluZ3MvbW1jL3N1bnBsdXMtbW1jLnlhbWwNCj4gPiBuZXcgZmlsZSBtb2RlIDEw
MDY0NA0KPiA+IGluZGV4IDAwMDAwMDAuLjhmNDRkMTMNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21tYy9zdW5wbHVzLW1tYy55
YW1sDQo+ID4gQEAgLTAsMCArMSw3NiBAQA0KPiA+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVy
OiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkgIyBDb3B5cmlnaHQNCj4gPiArKEMpIFN1
bnBsdXMgTHRkLiBDby4gMjAyMSAlWUFNTCAxLjINCj4gPiArLS0tDQo+ID4gKyRpZDogaHR0cDov
L2RldmljZXRyZWUub3JnL3NjaGVtYXMvbW1jL3N1bnBsdXMtbW1jLnlhbWwjDQo+ID4gKyRzY2hl
bWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KPiA+ICsN
Cj4gPiArdGl0bGU6IHN1bnBsdXMgTU1DIGNvbnRyb2xsZXINCj4gPiArDQo+ID4gK2FsbE9mOg0K
PiA+ICsgIC0gJHJlZjogIm1tYy1jb250cm9sbGVyLnlhbWwiDQo+ID4gKw0KPiA+ICttYWludGFp
bmVyczoNCj4gPiArICAtIFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4N
Cj4gPiArICAtIExpLWhhbyBLdW8gPGxoamVmZjkxMUBnbWFpbC5jb20+DQo+ID4gKw0KPiA+ICtw
cm9wZXJ0aWVzOg0KPiA+ICsgIGNvbXBhdGlibGU6DQo+ID4gKyAgICBlbnVtOg0KPiA+ICsgICAg
ICAtIHN1bnBsdXMsc3A3MDIxLWVtbWMNCj4gPiArICAgICAgLSBzdW5wbHVzLHNwNzAyMS1zZGhj
aQ0KPiANCj4gV2h5IGFyZSB0aGVzZSBzdGlsbCBkaWZmZXJlbnQ/IExvb2tpbmcgYXQgdGhlIGRy
aXZlciwgaXQgc2VlbXMgdGhlIHNldHRpbmdzIGFyZQ0KPiB0aGUgc2FtZSBmb3IgYm90aC4gQW5k
IGZvciBjbG9jayBzcGVlZHMsIHdlIGhhdmUgcHJvcGVydGllcyB0byBjb250cm9sIHRoZW0gYXMN
Cj4gdGhleSBjYW4gYmUgYm9hcmQgc3BlY2lmaWMuDQo+IA0KDQpUaGUgcmVnaXN0ZXIgYmFzZSBh
ZGRyZXNzIG9mIGVtbWMgYW5kIHNkIGNhcmQgYXJlIGRpZmZlcmVudC4NCmVNTUMgYW5kIHNkY2Fy
ZCBhcmUgaW5kaXZpZHVhbCBoYXJkd2FyZSBzZXR0aW5ncw0KDQo+ID4gKw0KPiA+ICsgIHJlZzoN
Cj4gPiArICAgIG1heEl0ZW1zOiAxDQo+ID4gKw0KPiA+ICsgIGludGVycnVwdHM6DQo+ID4gKyAg
ICBtYXhJdGVtczogMQ0KPiA+ICsNCj4gPiArICBjbG9ja3M6DQo+ID4gKyAgICBtaW5JdGVtczog
MQ0KPiA+ICsNCj4gPiArICByZXNldHM6DQo+ID4gKyAgICBtYXhJdGVtczogMQ0KPiA+ICsNCj4g
PiArICBtYXgtZnJlcXVlbmN5OiB0cnVlDQo+ID4gKw0KPiA+ICtyZXF1aXJlZDoNCj4gPiArICAt
IGNvbXBhdGlibGUNCj4gPiArICAtIHJlZw0KPiA+ICsgIC0gaW50ZXJydXB0cw0KPiA+ICsgIC0g
Y2xvY2tzDQo+ID4gKyAgLSByZXNldHMNCj4gPiArDQo+ID4gK3VuZXZhbHVhdGVkUHJvcGVydGll
czogZmFsc2UNCj4gPiArDQo+ID4gK2V4YW1wbGVzOg0KPiA+ICsgIC0gfA0KPiA+ICsgICAgI2lu
Y2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2lycS5oPg0KPiA+ICsgICAg
I2luY2x1ZGUgPGR0LWJpbmRpbmdzL2ludGVycnVwdC1jb250cm9sbGVyL2FybS1naWMuaD4NCj4g
PiArICAgIG1tYzA6IG1tY0A5YzAwM2IwMCB7DQo+ID4gKyAgICAgICAgY29tcGF0aWJsZSA9ICJz
dW5wbHVzLHNwNzAyMS1lbW1jIjsNCj4gPiArICAgICAgICByZWcgPSA8MHg5YzAwM2IwMCAweDE4
MD47DQo+ID4gKyAgICAgICAgaW50ZXJydXB0cyA9IDwyMCBJUlFfVFlQRV9MRVZFTF9ISUdIPjsN
Cj4gPiArICAgICAgICBjbG9ja3MgPSA8JmNsa2MgMHg0ZT47DQo+ID4gKyAgICAgICAgcmVzZXRz
ID0gPCZyc3RjIDB4M2U+Ow0KPiA+ICsgICAgICAgIGJ1cy13aWR0aCA9IDw4PjsNCj4gPiArICAg
ICAgICBtYXgtZnJlcXVlbmN5ID0gPDUyMDAwMDAwPjsNCj4gPiArICAgICAgICBub24tcmVtb3Zh
YmxlOw0KPiA+ICsgICAgICAgIGRpc2FibGUtd3A7DQo+ID4gKyAgICAgICAgY2FwLW1tYy1oaWdo
c3BlZWQ7DQo+ID4gKyAgICAgICAgbW1jLWRkci0zXzN2Ow0KPiA+ICsgICAgICAgIG5vLXNkaW87
DQo+ID4gKyAgICAgICAgbm8tc2Q7DQo+ID4gKyAgICB9Ow0KPiA+ICsNCj4gPiArICAgIG1tYzE6
IG1tY0A5YzAwM2U4MCB7DQo+ID4gKyAgICAgICBjb21wYXRpYmxlID0gInN1bnBsdXMsc3A3MDIx
LXNkaGNpIjsNCj4gPiArICAgICAgIHJlZyA9IDwweDljMDAzZTgwIDB4MjgwPjsNCj4gPiArICAg
ICAgIGludGVycnVwdHMgPSA8MjEgSVJRX1RZUEVfTEVWRUxfSElHSD47DQo+ID4gKyAgICAgICBj
bG9ja3MgPSA8JmNsa2MgMHg0Zj47DQo+ID4gKyAgICAgICByZXNldHMgPSA8JnJzdGMgMHgzZj47
DQo+ID4gKyAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KPiA+ICsgICAgICAgcGlu
Y3RybC0wID0gPCZtbWMxX211eCAmbW1jMV9tdXhfY2Q+Ow0KPiA+ICsgICAgICAgbWF4LWZyZXF1
ZW5jeSA9IDw1MjAwMDAwMD47DQo+ID4gKyAgICB9Ow0KPiA+ICsuLi4NCj4gPiBkaWZmIC0tZ2l0
IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUyBpbmRleCBmYjE4Y2U3Li5jYjQ2YTU1IDEwMDY0
NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAt
MTgyNDIsNiArMTgyNDIsMTIgQEAgTDoJbmV0ZGV2QHZnZXIua2VybmVsLm9yZw0KPiA+ICBTOglN
YWludGFpbmVkDQo+ID4gIEY6CWRyaXZlcnMvbmV0L2V0aGVybmV0L2RsaW5rL3N1bmRhbmNlLmMN
Cj4gPg0KPiA+ICtTVU5QTFVTIE1NQyBEUklWRVINCj4gPiArTToJVG9ueSBIdWFuZyA8dG9ueWh1
YW5nLnN1bnBsdXNAZ21haWwuY29tPg0KPiA+ICtNOglMaS1oYW8gS3VvIDxsaGplZmY5MTFAZ21h
aWwuY29tPg0KPiA+ICtTOglNYWludGFpbmVkDQo+ID4gK0Y6CURvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1LW1tYy55YW1sDQo+ID4gKw0KPiA+ICBTVVBFUkgNCj4g
PiAgTToJWW9zaGlub3JpIFNhdG8gPHlzYXRvQHVzZXJzLnNvdXJjZWZvcmdlLmpwPg0KPiA+ICBN
OglSaWNoIEZlbGtlciA8ZGFsaWFzQGxpYmMub3JnPg0KPiA+IC0tDQo+ID4gMi43LjQNCj4gPg0K
PiA+DQo=
