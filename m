Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D93A4B3F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 03:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239237AbiBNCCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 21:02:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiBNCCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 21:02:09 -0500
Received: from mg.sunplus.com (mswedge1.sunplus.com [60.248.182.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56C2953B56;
        Sun, 13 Feb 2022 18:02:00 -0800 (PST)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(29719:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 14 Feb 2022 10:02:09 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 14 Feb 2022 10:02:09 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 14 Feb 2022 10:02:09 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>
CC:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Topic: [PATCH v3 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus
 SP7021
Thread-Index: AQHYHaGbHjb6ERvO1kGc6F944DDDK6yLDxUAgAEMUcCAAa/MAIAEfxTg
Date:   Mon, 14 Feb 2022 02:02:09 +0000
Message-ID: <1dffd14796b84ffe92aa248fa994b0a4@sphcmbx02.sunplus.com.tw>
References: <cover.1644398657.git.tonyhuang.sunplus@gmail.com>
 <f8b89f9981e17c023ce530afedb1f2b599edec0f.1644398657.git.tonyhuang.sunplus@gmail.com>
 <YgQQ2nJa12xblXBX@robh.at.kernel.org>
 <40d202104eec46d2a35445e0128a124f@sphcmbx02.sunplus.com.tw>
 <CAPDyKFqPcpVr-JZF-9-4Jxq9fbsVbLYsh8TjEJffRfueczq=uQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqPcpVr-JZF-9-4Jxq9fbsVbLYsh8TjEJffRfueczq=uQ@mail.gmail.com>
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

RGVhciBVZmZlOg0KDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8yXSBkdC1iaW5kaW5nOiBt
bWM6IEFkZCBtbWMgeWFtbCBmaWxlIGZvciBTdW5wbHVzDQo+IFNQNzAyMQ0KPiANCj4gT24gVGh1
LCAxMCBGZWIgMjAyMiBhdCAwOTo1NiwgVG9ueSBIdWFuZyDpu4Pmh7fljpoNCj4gPHRvbnkuaHVh
bmdAc3VucGx1cy5jb20+IHdyb3RlOg0KPiA+DQo+ID4gRGVhciBSb2JoOg0KPiA+DQo+ID4gPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDEvMl0gZHQtYmluZGluZzogbW1jOiBBZGQgbW1jIHlhbWwg
ZmlsZSBmb3INCj4gPiA+IFN1bnBsdXMNCj4gPiA+IFNQNzAyMQ0KPiA+ID4NCj4gPiA+IE9uIFdl
ZCwgRmViIDA5LCAyMDIyIGF0IDA2OjQxOjA2UE0gKzA4MDAsIFRvbnkgSHVhbmcgd3JvdGU6DQo+
ID4gPiA+IEFkZCBtbWMgeWFtbCBmaWxlIGZvciBTdW5wbHVzIFNQNzAyMQ0KPiA+ID4gPg0KPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5j
b20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBDaGFuZ2VzIGluIHYzOg0KPiA+ID4gPiAgLSBjb21i
aW5lIHNkY2FyZCBhbmQgZU1NQyBpbnRvIG9uZSBkcml2ZXIuDQo+ID4gPiA+DQo+ID4gPiA+ICAu
Li4vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1cy1tbWMueWFtbCAgICAgICB8IDc2DQo+
ID4gPiArKysrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICA2ICsrDQo+ID4gPiA+ICAyIGZpbGVz
IGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKykgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBE
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbW1jL3N1bnBsdXMtbW1jLnlhbWwNCj4g
PiA+ID4NCj4gPiA+ID4gZGlmZiAtLWdpdA0KPiA+ID4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNl
dHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1cy1tbWMueWFtbA0KPiA+ID4gPiBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tbWMvc3VucGx1cy1tbWMueWFtbA0KPiA+ID4gPiBuZXcg
ZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBpbmRleCAwMDAwMDAwLi44ZjQ0ZDEzDQo+ID4gPiA+
IC0tLSAvZGV2L251bGwNCj4gPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL21tYy9zdW5wbHVzLW1tYy55YW1sDQo+ID4gPiA+IEBAIC0wLDAgKzEsNzYgQEANCj4g
PiA+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTIt
Q2xhdXNlKSAjDQo+ID4gPiA+ICtDb3B5cmlnaHQNCj4gPiA+ID4gKyhDKSBTdW5wbHVzIEx0ZC4g
Q28uIDIwMjEgJVlBTUwgMS4yDQo+ID4gPiA+ICstLS0NCj4gPiA+ID4gKyRpZDogaHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvbW1jL3N1bnBsdXMtbW1jLnlhbWwjDQo+ID4gPiA+ICskc2No
ZW1hOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4gPiA+
ID4gKw0KPiA+ID4gPiArdGl0bGU6IHN1bnBsdXMgTU1DIGNvbnRyb2xsZXINCj4gPiA+ID4gKw0K
PiA+ID4gPiArYWxsT2Y6DQo+ID4gPiA+ICsgIC0gJHJlZjogIm1tYy1jb250cm9sbGVyLnlhbWwi
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK21haW50YWluZXJzOg0KPiA+ID4gPiArICAtIFRvbnkgSHVh
bmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiA+ID4gKyAgLSBMaS1oYW8gS3Vv
IDxsaGplZmY5MTFAZ21haWwuY29tPg0KPiA+ID4gPiArDQo+ID4gPiA+ICtwcm9wZXJ0aWVzOg0K
PiA+ID4gPiArICBjb21wYXRpYmxlOg0KPiA+ID4gPiArICAgIGVudW06DQo+ID4gPiA+ICsgICAg
ICAtIHN1bnBsdXMsc3A3MDIxLWVtbWMNCj4gPiA+ID4gKyAgICAgIC0gc3VucGx1cyxzcDcwMjEt
c2RoY2kNCj4gPiA+DQo+ID4gPiBXaHkgYXJlIHRoZXNlIHN0aWxsIGRpZmZlcmVudD8gTG9va2lu
ZyBhdCB0aGUgZHJpdmVyLCBpdCBzZWVtcyB0aGUNCj4gPiA+IHNldHRpbmdzIGFyZSB0aGUgc2Ft
ZSBmb3IgYm90aC4gQW5kIGZvciBjbG9jayBzcGVlZHMsIHdlIGhhdmUNCj4gPiA+IHByb3BlcnRp
ZXMgdG8gY29udHJvbCB0aGVtIGFzIHRoZXkgY2FuIGJlIGJvYXJkIHNwZWNpZmljLg0KPiA+ID4N
Cj4gPg0KPiA+IFRoZSByZWdpc3RlciBiYXNlIGFkZHJlc3Mgb2YgZW1tYyBhbmQgc2QgY2FyZCBh
cmUgZGlmZmVyZW50Lg0KPiA+IGVNTUMgYW5kIHNkY2FyZCBhcmUgaW5kaXZpZHVhbCBoYXJkd2Fy
ZSBzZXR0aW5ncw0KPiANCj4gV2hlbiBJIGxvb2tlZCBhdCB0aGUgcHJldmlvdXMgdmVyc2lvbiBv
ZiB0aGUgZHJpdmVyKHMpIHRoYXQgd2FzIHBvc3RlZCwgSSBnb3QgdGhlDQo+IGltcHJlc3Npb24g
dGhhdCB5b3UgaGF2ZSBzb21lIHJlZ2lzdGVycyBpbiB0aGUgY29udHJvbGxlciB0aGF0IGFyZSBz
cGVjaWZpYyBmb3INCj4gZU1NQywgU0Qgb3IgU0RJTy4NCj4gDQo+IFNvLCBkZXBlbmRpbmcgb24g
aG93IHRoZSBjb250cm9sbGVyIGlzIGdvaW5nIHRvIGJlIHVzZWQgKGZvciBlTU1DLCBTRCBvciBT
RElPKQ0KPiBpdCdzIG5lZWRzIHRvIGJlIGNvbmZpZ3VyZWQgZGlmZmVyZW50bHkuIFJpZ2h0Pw0K
PiANCj4gSWYgSSBnb3QgdGhpcyByaWdodCwgSSB0aGluayB5b3UgY2FuIGluc3RlYWQgdXNlIHRo
ZSBleGlzdGluZyBjb21tb24gRFQNCj4gcHJvcGVydGllcywgIm5vLXNkIiwgIm5vLXNkaW8iLCAi
bm8tbW1jIiB0byBleHBsYWluIGhvdyBlYWNoIGNvbnRyb2xsZXIgaXMNCj4gY29uZmlndXJlZC4N
Cj4gDQoNCk9LLCBJIHdpbGwgdXNlIERUPiBwcm9wZXJ0aWVzLCAibm8tc2QiLCAibm8tc2RpbyIs
ICJuby1tbWMiICB0byBleHBsYWluIGhvdyANCmVhY2ggY29udHJvbGxlciBpcyBjb25maWd1cmVk
Lg0KVGhhbmtzDQo=
