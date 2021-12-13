Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7866472BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:37:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbhLMLhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:37:33 -0500
Received: from mswedge2.sunplus.com ([60.248.182.106]:41042 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236233AbhLMLhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:37:31 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(31402:0:AUTH_RELAY)
        (envelope-from <hammer.hsieh@sunplus.com>); Mon, 13 Dec 2021 19:37:28 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 13 Dec 2021 19:37:21 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 13 Dec 2021 19:37:21 +0800
From:   =?utf-8?B?SGFtbWVyIEhzaWVoIOisneWuj+Wtnw==?= 
        <hammer.hsieh@sunplus.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Hammer Hsieh <hammerh0314@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Thread-Topic: [PATCH v5 2/2] serial:sunplus-uart:Add Sunplus SoC UART Driver
Thread-Index: AQHX7/CFMZTCGS5LYUOaCsS6NSb5Q6wvhUiAgADCIuA=
Date:   Mon, 13 Dec 2021 11:37:21 +0000
Message-ID: <5040ff8d211b4d729f4bdae8ce6dabd8@sphcmbx02.sunplus.com.tw>
References: <1639379407-28607-1-git-send-email-hammer.hsieh@sunplus.com>
 <1639379407-28607-3-git-send-email-hammer.hsieh@sunplus.com>
 <61fefc9d-643d-ca31-9a6d-d2e10cd060bb@kernel.org>
In-Reply-To: <61fefc9d-643d-ca31-9a6d-d2e10cd060bb@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.55]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIEppcmkgU2xhYnk6DQoNClRoYW5rcyBmb3IgeW91ciByZXZpZXcuDQpNeSByZXNwb25zZSBp
cyBiZWxvdyBpbiBtYWlsLg0KDQpCZXN0IFJlZ2FyZHMsDQpIYW1tZXIgSHNpZWgNCg0KPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBKaXJpIFNsYWJ5IDxqaXJpc2xhYnlAa2Vy
bmVsLm9yZz4NCj4gU2VudDogTW9uZGF5LCBEZWNlbWJlciAxMywgMjAyMSAzOjQ3IFBNDQo+IFRv
OiBIYW1tZXIgSHNpZWggPGhhbW1lcmgwMzE0QGdtYWlsLmNvbT47IGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnOw0KPiByb2JoK2R0QGtlcm5lbC5vcmc7IGxpbnV4LXNlcmlhbEB2Z2VyLmtlcm5l
bC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOyBwLnphYmVsQHBlbmd1dHJvbml4LmRlDQo+IENjOiBXZWxscyBMdSDlkYLoirPp
qLAgPHdlbGxzLmx1QHN1bnBsdXMuY29tPjsgSGFtbWVyIEhzaWVoIOisneWuj+Wtnw0KPiA8aGFt
bWVyLmhzaWVoQHN1bnBsdXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHY1IDIvMl0gc2Vy
aWFsOnN1bnBsdXMtdWFydDpBZGQgU3VucGx1cyBTb0MgVUFSVCBEcml2ZXINCj4gDQo+IE9uIDEz
LiAxMi4gMjEsIDg6MTAsIEhhbW1lciBIc2llaCB3cm90ZToNCj4gPiBBZGQgU3VucGx1cyBTb0Mg
VUFSVCBEcml2ZXINCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhhbW1lciBIc2llaCA8aGFtbWVy
LmhzaWVoQHN1bnBsdXMuY29tPg0KPiANCj4gLi4uDQo+IA0KPiA+IC0tLSAvZGV2L251bGwNCj4g
PiArKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc3VucGx1cy11YXJ0LmMNCj4gDQo+IC4uLg0KPiAN
Cj4gPiArc3RhdGljIHZvaWQgcmVjZWl2ZV9jaGFycyhzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KSB7
DQo+ID4gKwl1bnNpZ25lZCBpbnQgbHNyID0gcmVhZGwocG9ydC0+bWVtYmFzZSArIFNVUF9VQVJU
X0xTUik7DQo+ID4gKwl1bnNpZ25lZCBpbnQgY2gsIGZsYWc7DQo+ID4gKw0KPiA+ICsJZG8gew0K
PiA+ICsJCWNoID0gcmVhZGwocG9ydC0+bWVtYmFzZSArIFNVUF9VQVJUX0RBVEEpOw0KPiA+ICsJ
CWZsYWcgPSBUVFlfTk9STUFMOw0KPiA+ICsJCXBvcnQtPmljb3VudC5yeCsrOw0KPiA+ICsNCj4g
PiArCQlpZiAodW5saWtlbHkobHNyICYgU1VQX1VBUlRfTFNSX0JSS19FUlJPUl9CSVRTKSkgew0K
PiA+ICsJCQlpZiAobHNyICYgU1VQX1VBUlRfTFNSX0JDKSB7DQo+ID4gKwkJCQlsc3IgJj0gfihT
VVBfVUFSVF9MU1JfRkUgfCBTVVBfVUFSVF9MU1JfUEUpOw0KPiA+ICsJCQkJcG9ydC0+aWNvdW50
LmJyaysrOw0KPiA+ICsJCQkJaWYgKHVhcnRfaGFuZGxlX2JyZWFrKHBvcnQpKQ0KPiA+ICsJCQkJ
CWdvdG8gaWdub3JlX2NoYXI7DQo+ID4gKwkJCX0gZWxzZSBpZiAobHNyICYgU1VQX1VBUlRfTFNS
X1BFKSB7DQo+ID4gKwkJCQlwb3J0LT5pY291bnQucGFyaXR5Kys7DQo+ID4gKwkJCX0gZWxzZSBp
ZiAobHNyICYgU1VQX1VBUlRfTFNSX0ZFKSB7DQo+ID4gKwkJCQlwb3J0LT5pY291bnQuZnJhbWUr
KzsNCj4gPiArCQkJfQ0KPiA+ICsNCj4gPiArCQkJaWYgKGxzciAmIFNVUF9VQVJUX0xTUl9PRSkN
Cj4gPiArCQkJCXBvcnQtPmljb3VudC5vdmVycnVuKys7DQo+ID4gKw0KPiA+ICsJCQlpZiAobHNy
ICYgU1VQX1VBUlRfTFNSX0JDKQ0KPiA+ICsJCQkJZmxhZyA9IFRUWV9CUkVBSzsNCj4gPiArCQkJ
ZWxzZSBpZiAobHNyICYgU1VQX1VBUlRfTFNSX1BFKQ0KPiA+ICsJCQkJZmxhZyA9IFRUWV9QQVJJ
VFk7DQo+ID4gKwkJCWVsc2UgaWYgKGxzciAmIFNVUF9VQVJUX0xTUl9GRSkNCj4gPiArCQkJCWZs
YWcgPSBUVFlfRlJBTUU7DQo+IA0KPiBXaHkgZG8geW91IGhhbmRsZSB0aGVzZSBzZXBhcmF0ZWx5
IGFuZCBub3QgYWJvdmU/DQo+IA0KDQpJbmRlZWQsIEkgd2lsbCBtb2RpZnkgYXMgYmVsb3cuDQoJ
CWlmIChsc3IgJiBTVVBfVUFSVF9MU1JfQkMpIHsNCgkJCWxzciAmPSB+KFNVUF9VQVJUX0xTUl9G
RSB8IFNVUF9VQVJUX0xTUl9QRSk7DQoJCQlwb3J0LT5pY291bnQuYnJrKys7DQoJCQlmbGFnID0g
VFRZX0JSRUFLOw0KCQkJaWYgKHVhcnRfaGFuZGxlX2JyZWFrKHBvcnQpKQ0KCQkJCWdvdG8gaWdu
b3JlX2NoYXI7DQoJCQl9IGVsc2UgaWYgKGxzciAmIFNVUF9VQVJUX0xTUl9QRSkgew0KCQkJcG9y
dC0+aWNvdW50LnBhcml0eSsrOw0KCQkJZmxhZyA9IFRUWV9QQVJJVFk7DQoJCX0gZWxzZSBpZiAo
bHNyICYgU1VQX1VBUlRfTFNSX0ZFKSB7DQoJCQlwb3J0LT5pY291bnQuZnJhbWUrKzsNCgkJCWZs
YWcgPSBUVFlfRlJBTUU7DQoJCX0NCg0KPiA+ICsJCX0NCj4gPiArDQo+ID4gKwkJaWYgKHBvcnQt
Pmlnbm9yZV9zdGF0dXNfbWFzayAmIFNVUF9EVU1NWV9SRUFEKQ0KPiA+ICsJCQlnb3RvIGlnbm9y
ZV9jaGFyOw0KPiA+ICsNCj4gPiArCQlpZiAodWFydF9oYW5kbGVfc3lzcnFfY2hhcihwb3J0LCBj
aCkpDQo+ID4gKwkJCWdvdG8gaWdub3JlX2NoYXI7DQo+ID4gKw0KPiA+ICsJCXVhcnRfaW5zZXJ0
X2NoYXIocG9ydCwgbHNyLCBTVVBfVUFSVF9MU1JfT0UsIGNoLCBmbGFnKTsNCj4gPiArDQo+ID4g
K2lnbm9yZV9jaGFyOg0KPiA+ICsJCWxzciA9IHJlYWRsKHBvcnQtPm1lbWJhc2UgKyBTVVBfVUFS
VF9MU1IpOw0KPiA+ICsJfSB3aGlsZSAobHNyICYgU1VQX1VBUlRfTFNSX1JYKTsNCj4gPiArDQo+
ID4gKwl0dHlfZmxpcF9idWZmZXJfcHVzaCgmcG9ydC0+c3RhdGUtPnBvcnQpOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICtzdGF0aWMgaXJxcmV0dXJuX3Qgc3VucGx1c191YXJ0X2lycShpbnQgaXJxLCB2
b2lkICphcmdzKSB7DQo+ID4gKwlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0ID0gKHN0cnVjdCB1YXJ0
X3BvcnQgKilhcmdzOw0KPiANCj4gTm8gbmVlZCB0byBjYXN0IGhlcmUuDQo+IA0KDQpPaywgd2ls
bCBtb2RpZnkgaXQuDQoNCj4gPiArCXVuc2lnbmVkIGludCBpc2MgPSByZWFkbChwb3J0LT5tZW1i
YXNlICsgU1VQX1VBUlRfSVNDKTsNCj4gDQo+IFNob3VsZG4ndCB0aGlzIGJlIHVuZGVyIHRoZSBz
cGlubG9jaz8NCj4gDQo+IEFuZCAiaWYgKCFpc2MpIHJldHVybiBJUlFfTk9ORSI/DQo+IA0KDQpX
aWxsIG1vZGlmeSBpdCBhcyBiZWxvdy4NClNwaW5fbG9jaygpDQppc2MgPSByZWFkbChwb3J0LT5t
ZW1iYXNlICsgU1VQX1VBUlRfSVNDKTsNCmlmICghaXNjKSByZXR1cm4gSVJRX05PTkU7DQppZihp
c2MmUlgpIHJlY2VpdmVfY2hhcnMoKTsNCmlmKGlzYyZUWCkgdHJhbnNtaXRfY2hhcnMoKTsNClNw
aW5fdW5sb2NrKCkNCg0KPiA+ICsJc3Bpbl9sb2NrKCZwb3J0LT5sb2NrKTsNCj4gPiArDQo+ID4g
KwlpZiAoaXNjICYgU1VQX1VBUlRfSVNDX1JYKQ0KPiA+ICsJCXJlY2VpdmVfY2hhcnMocG9ydCk7
DQo+ID4gKw0KPiA+ICsJaWYgKGlzYyAmIFNVUF9VQVJUX0lTQ19UWCkNCj4gPiArCQl0cmFuc21p
dF9jaGFycyhwb3J0KTsNCj4gPiArDQo+ID4gKwlzcGluX3VubG9jaygmcG9ydC0+bG9jayk7DQo+
ID4gKw0KPiA+ICsJcmV0dXJuIElSUV9IQU5ETEVEOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgaW50IHN1bnBsdXNfc3RhcnR1cChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KSB7DQo+ID4gKwl1
bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICsJdW5zaWduZWQgaW50IGlzYzsNCj4gPiArCWludCBy
ZXQ7DQo+ID4gKw0KPiA+ICsJcmV0ID0gcmVxdWVzdF9pcnEocG9ydC0+aXJxLCBzdW5wbHVzX3Vh
cnRfaXJxLCAwLCAic3VucGx1c191YXJ0IiwNCj4gPiArcG9ydCk7DQo+IA0KPiBDYW5ub3QgdGhl
IGludGVycnVwdCBiZSBzaGFyZWQ/DQo+IA0KDQpFYWNoIFVBUlQgaGF2ZSBpdHMgb3duIGhhcmR3
YXJlIGludGVycnVwdCBpbiBTdW5wbHVzIFNQNzAyMSBTb0MuDQpObyBuZWVkIHRvIHNldCBJUlFG
X1NIQVJFRCBmb3Igc2VyaWFsIGRyaXZlci4NCg0KPiA+ICsJaWYgKHJldCkNCj4gPiArCQlyZXR1
cm4gcmV0Ow0KPiA+ICsNCj4gPiArCXNwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFn
cyk7DQo+ID4gKw0KPiA+ICsJaXNjIHw9IFNVUF9VQVJUX0lTQ19SWE07DQo+ID4gKwl3cml0ZWwo
aXNjLCBwb3J0LT5tZW1iYXNlICsgU1VQX1VBUlRfSVNDKTsNCj4gPiArDQo+ID4gKwlzcGluX3Vu
bG9ja19pcnFyZXN0b3JlKCZwb3J0LT5sb2NrLCBmbGFncyk7DQo+ID4gKw0KPiA+ICsJcmV0dXJu
IDA7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIHN1bnBsdXNfc2h1dGRvd24oc3Ry
dWN0IHVhcnRfcG9ydCAqcG9ydCkgew0KPiA+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gPiAr
DQo+ID4gKwlzcGluX2xvY2tfaXJxc2F2ZSgmcG9ydC0+bG9jaywgZmxhZ3MpOw0KPiA+ICsJd3Jp
dGVsKDAsIHBvcnQtPm1lbWJhc2UgKyBTVVBfVUFSVF9JU0MpOw0KPiANCj4gV2hhdCBidXMgaXMg
dGhpcyAtLSBwb3N0aW5nPw0KPiANCg0KSGVyZSBqdXN0IGNsZWFyIGludGVycnVwdC4NCk5vdCBy
ZWFsbHkgdW5kZXJzdGFuZCB5b3VyIGNvbW1lbnQ/DQoNCj4gPiArCXNwaW5fdW5sb2NrX2lycXJl
c3RvcmUoJnBvcnQtPmxvY2ssIGZsYWdzKTsNCj4gPiArDQo+ID4gKwlmcmVlX2lycShwb3J0LT5p
cnEsIHBvcnQpOw0KPiA+ICt9DQo+IA0KPiAuLi4NCj4gDQo+ID4gK3N0YXRpYyB2b2lkIHN1bnBs
dXNfcmVsZWFzZV9wb3J0KHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpIHsgfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGludCBzdW5wbHVzX3JlcXVlc3RfcG9ydChzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KSB7
DQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiANCj4gVGhlc2UgdHdvIGFyZSBvcHRpb25hbCAt
LSBubyBuZWVkIHRvIHByb3ZpZGUgdGhlbS4NCj4gDQoNCk9rLCB0aGFua3MuDQpJIHdpbGwgcmVt
b3ZlIHRoZXNlIHR3byBmdW5jdGlvbnMuDQoNCj4gcmVnYXJkcywNCj4gLS0NCj4ganMNCj4gc3Vz
ZSBsYWJzDQo=
