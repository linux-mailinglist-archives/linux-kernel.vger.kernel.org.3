Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE784ED6FD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 11:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbiCaJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233450AbiCaJdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 05:33:43 -0400
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF29D1BBF7C;
        Thu, 31 Mar 2022 02:31:53 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(30201:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Thu, 31 Mar 2022 17:27:32 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Thu, 31 Mar 2022 17:27:27 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Thu, 31 Mar 2022 17:27:27 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "lhjeff911@gmail.com" <lhjeff911@gmail.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?TGggS3VvIOmDreWKm+ixqg==?= <lh.Kuo@sunplus.com>
Subject: RE: [PATCH v5 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Topic: [PATCH v5 2/2] mmc: Add mmc driver for Sunplus SP7021
Thread-Index: AQHYQ3s7ORyaR4vCu0uQF2nts2U94azV8Q6AgAM9naA=
Date:   Thu, 31 Mar 2022 09:27:27 +0000
Message-ID: <7c4b66f7fe4940cba1b0158803767f6e@sphcmbx02.sunplus.com.tw>
References: <cover.1648551070.git.tonyhuang.sunplus@gmail.com>
 <46aad49867912fc57b669fc54fdb28638cccfcd9.1648551070.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CLA33CTerXJ=bK+myhyHp_utoLnTX-NzMgjeb7icAGg@mail.gmail.com>
In-Reply-To: <CAK8P3a0CLA33CTerXJ=bK+myhyHp_utoLnTX-NzMgjeb7icAGg@mail.gmail.com>
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

RGVhciBBcm5kOg0KDQo+ID4gQWRkIG1tYyBkcml2ZXIgZm9yIFN1bnBsdXMgU1A3MDIxDQo+ID4N
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5j
b20+DQo+IA0KPiBUaGVyZSBzaG91bGQgYmUgYSBkZXNjcmlwdGlvbiBvZiB0aGUgZGV2aWNlIGlu
IHRoZSBjaGFuZ2Vsb2csIG5vdCBqdXN0IHRoZSBzYW1lDQo+IHRleHQgYXMgdGhlIHN1YmplY3Qu
DQoNCk9LLCBJIHdpbGwgYWRkIGRlc2NyaXB0aW9uLg0KDQo+ID4gK3N0YXRpYyB2b2lkIHNwbW1j
X3JlcXVlc3Qoc3RydWN0IG1tY19ob3N0ICptbWMsIHN0cnVjdCBtbWNfcmVxdWVzdA0KPiA+ICsq
bXJxKSB7DQo+ID4gKyAgICAgICBzdHJ1Y3Qgc3BtbWNfaG9zdCAqaG9zdCA9IG1tY19wcml2KG1t
Yyk7DQo+ID4gKyAgICAgICBzdHJ1Y3QgbW1jX2RhdGEgKmRhdGE7DQo+ID4gKyAgICAgICBzdHJ1
Y3QgbW1jX2NvbW1hbmQgKmNtZDsNCj4gPiArICAgICAgIGludCByZXQ7DQo+ID4gKw0KPiA+ICsg
ICAgICAgcmV0ID0gbXV0ZXhfbG9ja19pbnRlcnJ1cHRpYmxlKCZob3N0LT5tcnFfbG9jayk7DQo+
ID4gKyAgICAgICBpZiAocmV0KQ0KPiA+ICsgICAgICAgICAgICAgICByZXR1cm47DQo+IA0KPiBJ
IGRvbid0IHRoaW5rIGl0J3MgdmFsaWQgdG8ganVzdCByZXR1cm4gaGVyZSB3aGVuIHlvdSBnZXQg
YSBzaWduYWwuIElmIG5vdGhpbmcgY2FuDQo+IGhhbmRsZSB0aGUgc2lnbmFsLCBkb2Vzbid0IGl0
IGp1c3QgaGFuZz8NCj4gDQo+IEl0IGFsc28gYXBwZWFycyB0aGF0IHlvdSBkb24ndCByZWxlYXNl
IHRoZSBtdXRleCB1bnRpbCB0aGUgdGFza2xldCBydW5zLCBidXQgaXQgaXMNCj4gbm90IHZhbGlk
IHRvIHJlbGVhc2UgYSBtdXRleCBmcm9tIGEgZGlmZmVyZW50IGNvbnRleHQuDQo+IA0KPiBZb3Ug
c2hvdWxkIGdldCBhIHdhcm5pbmcgYWJvdXQgdGhpcyB3aGVuIHJ1bm5pbmcgYSBrZXJuZWwgd2l0
aCBsb2NrZGVwDQo+IGVuYWJsZWQgYXQgY29tcGlsZSB0aW1lLiBQbGVhc2UgcmV3b3JrIHRoZSBs
b2NraW5nIHRvIG1ha2UgdGhpcyB3b3JrLg0KPiANCglSZW9tdmUgY29kZToNCiAgICByZXQgPSBt
dXRleF9sb2NrX2ludGVycnVwdGlibGUoJmhvc3QtPm1ycV9sb2NrKTsNCiAgICBpZiAocmV0KQ0K
ICAgICAgICAgcmV0dXJuOw0KDQoJQmVsb3cgaXMgbXkgbW9kaWZpY2F0aW9uOg0KLiAgICBtdXRl
eF9sb2NrKCZob3N0LT5tcnFfbG9jayk7DQoNCg0KPiA+ICsjZW5kaWYgLyogaWZkZWYgQ09ORklH
X1BNX1JVTlRJTUUgKi8NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29w
cyBzcG1tY19wbV9vcHMgPSB7DQo+ID4gKyAgICAgICBTRVRfU1lTVEVNX1NMRUVQX1BNX09QUyhz
cG1tY19wbV9zdXNwZW5kLA0KPiBzcG1tY19wbV9yZXN1bWUpDQo+ID4gKyNpZmRlZiBDT05GSUdf
UE1fUlVOVElNRQ0KPiA+ICsgICAgICAgU0VUX1JVTlRJTUVfUE1fT1BTKHNwbW1jX3BtX3J1bnRp
bWVfc3VzcGVuZCwNCj4gPiArc3BtbWNfcG1fcnVudGltZV9yZXN1bWUsIE5VTEwpICNlbmRpZiB9
OyAjZW5kaWYgLyogaWZkZWYgQ09ORklHX1BNDQo+ICovDQo+IA0KPiBJdCdzIGJldHRlciB0byB1
c2UgU1lTVEVNX1NMRUVQX1BNX09QUy9SVU5USU1FX1BNX09QUyBpbnN0ZWFkIG9mIHRoZQ0KPiBT
RVRfIHZlcnNpb24sIHRoZW4geW91IGNhbiByZW1vdmUgYWxsIHRoZSAjaWZkZWYgY2hlY2tzLg0K
PiANCg0KCUkgdXNlIFNZU1RFTV9TTEVFUF9QTV9PUFMvUlVOVElNRV9QTV9PUFMuIAkJCQkJCQkJ
DQoJQ29tcGlsZSBzaG93cyBlcnJvci4gRXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1
bmN0aW9uID8gPyBTWVNURU1fU0xFRVBfUE1fT1BTPyA/IERpZCB5b3UgbWVhbiA/ID8gU0VUX1NZ
U1RFTV9TTEVFUF9QTV9PUFM/ID8JCVstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQkJCQkJCQkJDQoJCQkJCQkJCQkNCglJIHJlZmVyZW5jZSBvdGhlciBtbWMgZHJpdmVyLgkJ
CQkJCQkJDQoJQmVsb3cgaXMgbXkgbW9kaWZpY2F0aW9uOg0KICAgIENvbXBpbGVyIGlzIHBhc3Mu
CQkJCQkJCQkNCgkJCQkJCQkJCQ0KCSNpZmRlZiBDT05GSUdfUE1fU0xFRVAJCQkJCQkJCQ0KCXN0
YXRpYyBpbnQgc3BtbWNfcG1fc3VzcGVuZChzdHJ1Y3QgZGV2aWNlICpkZXYpCQkJCQkJCQkNCgl7
CQkJCQkJCQkNCgkJcG1fcnVudGltZV9mb3JjZV9zdXNwZW5kKGRldik7CQkJCQkJCQ0KCQkJCQkJ
CQkJDQoJCXJldHVybiAwOwkJCQkJCQkNCgl9CQkJCQkJCQkNCgkJCQkJCQkJCQ0KCXN0YXRpYyBp
bnQgc3BtbWNfcG1fcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikJCQkJCQkJCQ0KCXsJCQkJCQkJ
CQ0KCQlwbV9ydW50aW1lX2ZvcmNlX3Jlc3VtZShkZXYpOwkJCQkJCQkNCgkJCQkJCQkJCQ0KCQly
ZXR1cm4gMDsJCQkJCQkJDQoJfQkJCQkJCQkJDQoJI2VuZGlmCQkJCQkJCQkNCgkJCQkJCQkJCQ0K
CSNpZmRlZiBDT05GSUdfUE0JCQkJCQkJCQ0KCXN0YXRpYyBpbnQgc3BtbWNfcG1fcnVudGltZV9z
dXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldikJCQkJCQkJCQ0KCXsJCQkJCQkJCQ0KCQlzdHJ1Y3Qg
c3BtbWNfaG9zdCAqaG9zdDsJCQkJCQkJDQoJCQkJCQkJCQkNCgkJaG9zdCA9IGRldl9nZXRfZHJ2
ZGF0YShkZXYpOwkJCQkJCQkNCgkJY2xrX2Rpc2FibGUoaG9zdC0+Y2xrKTsJCQkJCQkJDQoJCQkJ
CQkJCQkNCgkJcmV0dXJuIDA7CQkJCQkJCQ0KCX0JCQkJCQkJCQ0KCQkJCQkJCQkJDQoJc3RhdGlj
IGludCBzcG1tY19wbV9ydW50aW1lX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCQkJCQkJCQkN
Cgl7CQkJCQkJCQkNCgkJc3RydWN0IHNwbW1jX2hvc3QgKmhvc3Q7CQkJCQkJCQ0KCQkJCQkJCQkJ
DQoJCWhvc3QgPSBkZXZfZ2V0X2RydmRhdGEoZGV2KTsJCQkJCQkJDQoJCQkJCQkJCQkNCgkJcmV0
dXJuIGNsa19lbmFibGUoaG9zdC0+Y2xrKTsJCQkJCQkJDQoJfQkJCQkJCQkJDQoJI2VuZGlmCQkJ
CQkJCQkNCgkJCQkJCQkJCQ0KCXN0YXRpYyBjb25zdCBzdHJ1Y3QgZGV2X3BtX29wcyBzcG1tY19w
bV9vcHMgPSB7CQkJCQkJCQkNCgkJU0VUX1NZU1RFTV9TTEVFUF9QTV9PUFMoc3BtbWNfcG1fc3Vz
cGVuZCwgc3BtbWNfcG1fcmVzdW1lKQkJCQkJCQkNCgkJU0VUX1JVTlRJTUVfUE1fT1BTKHNwbW1j
X3BtX3J1bnRpbWVfc3VzcGVuZCwgc3BtbWNfcG1fcnVudGltZV9yZXN1bWUsIE5VTEwpCQkJCQkJ
CQ0KCX07CQkJCQkJCQkNCg0K
