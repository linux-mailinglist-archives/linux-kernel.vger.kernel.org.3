Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDF75892C0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 21:27:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238534AbiHCT1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 15:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238594AbiHCT1Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 15:27:24 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 517725B787;
        Wed,  3 Aug 2022 12:27:13 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id D07665FD36;
        Wed,  3 Aug 2022 22:27:10 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1659554830;
        bh=I6vdD/Bwy6gfYtG6Ow/MeIyIZrRN95jKhnC5qo+nMoA=;
        h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version;
        b=R20dkrN/hY99HOi03dXLOFjJfOTxEkPMbN/c1Rbjbm0L+ieU3il+hG9UofVe6NM3C
         WcKQh1pDwKd+6DBczGnZZr1T808zq+cyfK99cItwNR+xEH8ACpl0Usu70Cxl1AovPw
         72StiN4LgKPgv8ONAoPqFouHdiKvfWKYJuLa5+Mtfhw3nGk4aY4IdrT6gvQ/QvAFf9
         uVzPUZdPP9C3lAl0tCTN4mremYAPt9PEd//EpoWYkjOfKfukf8D/oSUBI00+dwv14J
         s4pxPJPeVYyaNCq73eYhxXkN3cu63bsvx9zG3/ioPRrCjqEs/6n7PHq0MrgZfvfCKL
         FPniNoUtu0+ew==
Received: from S-MS-EXCH02.sberdevices.ru (S-MS-EXCH02.sberdevices.ru [172.16.1.5])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Wed,  3 Aug 2022 22:27:10 +0300 (MSK)
From:   Dmitry Rokosov <DDRokosov@sberdevices.ru>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jic23@kernel.org" <jic23@kernel.org>,
        kernel <kernel@sberdevices.ru>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "stano.jakubek@gmail.com" <stano.jakubek@gmail.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>
Subject: Re: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Topic: [PATCH v4 2/3] iio: add MEMSensing MSA311 3-axis accelerometer
 driver
Thread-Index: AQHYpzqIoQnaRj7vNkq2cXUUGjAB/62dSAuAgAAIFYCAAAq8AIAAAmwA
Date:   Wed, 3 Aug 2022 19:26:55 +0000
Message-ID: <20220803192706.ls6kizgqkw46thln@CAB-WSD-L081021.sigma.sbrf.ru>
References: <20220803131132.19630-1-ddrokosov@sberdevices.ru>
 <20220803131132.19630-3-ddrokosov@sberdevices.ru>
 <67041dbe-ad6c-c53f-9760-bd7b5988d137@wanadoo.fr>
 <20220803184001.fcappv7grdjyaetn@CAB-WSD-L081021.sigma.sbrf.ru>
 <1406f120-9542-d90e-1258-5a8a300c1822@wanadoo.fr>
In-Reply-To: <1406f120-9542-d90e-1258-5a8a300c1822@wanadoo.fr>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.1.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <635E08126EDABF4E8786D6E8269D9479@sberdevices.ru>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/03 16:08:00 #20044033
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBBdWcgMDMsIDIwMjIgYXQgMDk6MTg6MjZQTSArMDIwMCwgQ2hyaXN0b3BoZSBKQUlM
TEVUIHdyb3RlOg0KPiBMZSAwMy8wOC8yMDIyIMOgIDIwOjM5LCBEbWl0cnkgUm9rb3NvdiBhIMOp
Y3JpdMKgOg0KPiA+IEhlbGxvIENocmlzdG9waGUsDQo+ID4gDQo+ID4gVGhhbmsgeW91IGZvciBx
dWljayByZXZpZXcNCj4gPiANCj4gPiBPbiBXZWQsIEF1ZyAwMywgMjAyMiBhdCAwODoxMTowNVBN
ICswMjAwLCBDaHJpc3RvcGhlIEpBSUxMRVQgd3JvdGU6DQo+ID4gPiBMZSAwMy8wOC8yMDIyIMOg
IDE1OjExLCBEbWl0cnkgUm9rb3NvdiBhIMOpY3JpdMKgOg0KPiA+ID4gPiBNU0EzMTEgaXMgYSB0
cmktYXhpYWwsIGxvdy1nIGFjY2VsZXJvbWV0ZXIgd2l0aCBJMkMgZGlnaXRhbCBvdXRwdXQgZm9y
DQo+ID4gPiA+IHNlbnNpdGl2aXR5IGNvbnN1bWVyIGFwcGxpY2F0aW9ucy4gSXQgaGFzIGR5bmFt
aWMgdXNlci1zZWxlY3RhYmxlIGZ1bGwNCj4gPiA+ID4gc2NhbGVzIHJhbmdlIG9mICstMmcvKy00
Zy8rLThnLystMTZnIGFuZCBhbGxvd3MgYWNjZWxlcmF0aW9uIG1lYXN1cmVtZW50cw0KPiA+ID4g
PiB3aXRoIG91dHB1dCBkYXRhIHJhdGVzIGZyb20gMUh6IHRvIDEwMDBIei4NCj4gPiA+ID4gDQo+
ID4gPiA+IFNwZWM6IGh0dHBzOi8vY2RuLXNob3AuYWRhZnJ1aXQuY29tL3Byb2R1Y3QtZmlsZXMv
NTMwOS9NU0EzMTEtVjEuMS1FTkcucGRmDQo+ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGRyaXZlciBz
dXBwb3J0cyBmb2xsb3dpbmcgTVNBMzExIGZlYXR1cmVzOg0KPiA+ID4gPiAgICAgICAtIElJTyBp
bnRlcmZhY2UNCj4gPiA+ID4gICAgICAgLSBEaWZmZXJlbnQgcG93ZXIgbW9kZXM6IE5PUk1BTCBh
bmQgU1VTUEVORCAodXNpbmcgcG1fcnVudGltZSkNCj4gPiA+ID4gICAgICAgLSBPRFIgKE91dHB1
dCBEYXRhIFJhdGUpIHNlbGVjdGlvbg0KPiA+ID4gPiAgICAgICAtIFNjYWxlIGFuZCBzYW1wX2Zy
ZXEgc2VsZWN0aW9uDQo+ID4gPiA+ICAgICAgIC0gSUlPIHRyaWdnZXJlZCBidWZmZXIsIElJTyBy
ZWcgYWNjZXNzDQo+ID4gPiA+ICAgICAgIC0gTkVXX0RBVEEgaW50ZXJydXB0ICsgdHJpZ2dlcg0K
PiA+ID4gPiANCj4gPiA+ID4gQmVsb3cgZmVhdHVyZXMgdG8gYmUgZG9uZToNCj4gPiA+ID4gICAg
ICAgLSBNb3Rpb24gRXZlbnRzOiBBQ1RJVkUsIFRBUCwgT1JJRU5ULCBGUkVFRkFMTA0KPiA+ID4g
PiAgICAgICAtIExvdyBQb3dlciBtb2RlDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5
OiBEbWl0cnkgUm9rb3NvdiA8ZGRyb2tvc292LWk0cjhvQStlTGxIOTlySGtQK0Z4SXdAcHVibGlj
LmdtYW5lLm9yZz4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAgIE1BSU5UQUlORVJTICAgICAgICAg
ICAgICAgIHwgICAgNiArDQo+ID4gPiA+ICAgIGRyaXZlcnMvaWlvL2FjY2VsL0tjb25maWcgIHwg
ICAxMyArDQo+ID4gPiA+ICAgIGRyaXZlcnMvaWlvL2FjY2VsL01ha2VmaWxlIHwgICAgMiArDQo+
ID4gPiA+ICAgIGRyaXZlcnMvaWlvL2FjY2VsL21zYTMxMS5jIHwgMTMyMyArKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+ID4gICAgNCBmaWxlcyBjaGFuZ2VkLCAxMzQ0
IGluc2VydGlvbnMoKykNCj4gPiA+ID4gICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvaWlv
L2FjY2VsL21zYTMxMS5jDQo+ID4gPiA+IA0KPiA+ID4gDQo+ID4gPiBIaSwNCj4gPiA+IGEgZmV3
IG5pdHMgYmVsb3cuDQo+ID4gPiANCj4gPiA+IFsuLi5dDQo+ID4gPiANCj4gPiA+ID4gK3N0YXRp
YyBpbnQgbXNhMzExX2NoZWNrX3BhcnRpZChzdHJ1Y3QgbXNhMzExX3ByaXYgKm1zYTMxMSkNCj4g
PiA+ID4gK3sNCj4gPiA+ID4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBtc2EzMTEtPmRldjsNCj4g
PiA+ID4gKwl1bnNpZ25lZCBpbnQgcGFydGlkOw0KPiA+ID4gPiArCWludCBlcnI7DQo+ID4gPiA+
ICsNCj4gPiA+ID4gKwllcnIgPSByZWdtYXBfcmVhZChtc2EzMTEtPnJlZ3MsIE1TQTMxMV9QQVJU
SURfUkVHLCAmcGFydGlkKTsNCj4gPiA+ID4gKwlpZiAoZXJyKQ0KPiA+ID4gPiArCQlyZXR1cm4g
ZGV2X2Vycl9wcm9iZShkZXYsIGVyciwNCj4gPiA+ID4gKwkJCQkgICAgICJmYWlsZWQgdG8gcmVh
ZCBwYXJ0aWQgKCVkKVxuIiwgZXJyKTsNCj4gPiA+IA0KPiA+ID4gTm8gbmVlZCBmb3IgIiglZCki
IGFuZCBlcnIuDQo+ID4gPiANCj4gPiANCj4gPiBEbyB5b3UgbWVhbiBmb3IgYWxsIGRldl9lcnIo
KSBjYWxscz8gSSB0aGluayBzb21ldGltZXMgaXQncyBoZWxwZnVsIHRvDQo+ID4ga25vdyB0aGUg
YWN0dWFsIGVycm9yIHZhbHVlIGdvdCBmcm9tIGV4dGVybmFsIEFQSSwgaXNuJ3Q/IENvdWxkIHlv
dSBwbGVhc2UNCj4gPiBleHBsYWluIHlvdXIgcG9pbnQgaWYgcG9zc2libGU/DQo+ID4gDQo+IA0K
PiBObywgbXkgY29tbWVudCBpcyBvbmx5IGZvciBkZXZfZXJyX3Byb2JlKCkgZnVuY3Rpb24uDQo+
IEhhdmluZyByZXQgZm9yIGRldl9lcnIoKSBjYWxscyBpcyBmaW5lLg0KPiANCj4gU2VlOiBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4xOS9zb3VyY2UvZHJpdmVycy9iYXNlL2Nv
cmUuYyNMNDczMg0KPiANCj4gZGV2X2Vycl9wcm9iZSgpIGFscmVhZHkgaGFzIGEgImVycm9yICVw
ZTouLi4sIEVSUl9QVFIoZXJyKSINCj4gVGhpcyBtZWFucyB0aGF0IGlmIHJldCA9IC1FTk9NRU06
DQo+ICAgICIoJWQpIiAgICAgICAtLT4gIigtMTIpIg0KPiAgICAiZXJyb3IgJXBlOiIgLS0+ICJl
cnJvciAtRU5PTUVNOiINCj4gDQo+IFNvIHRoZXJlIGlzIG5vIHJlYWwgbmVlZCB0byBkdXBsaWNh
dGUgdGhlIGVycm9yIGNvZGUgaW4gdGhlIG1lc3NhZ2UgaXRzZWxmLA0KPiBpdCBpcyBhbHJlYWR5
IGRpc3BsYXllZCBpbiBhIGh1bWFuIHJlYWRhYmxlIG1hbm5lci4NCj4gDQo+IFdoYXQgeW91ciBj
b2RlIGRvZXMgd291bGQgcmVzdWx0IGluOg0KPiAgICAiZXJyb3IgLUVOT01FTTogZmFpbGVkIHRv
IHJlYWQgcGFydGlkICgtMTIpXG4iDQpodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92
NS4xOS9zb3VyY2UvZHJpdmVycy9iYXNlL2NvcmUuYyNMNDczMj4gDQoNCkhtbSwgdmVyeSBpbnRl
cmVzdGluZy4gVGhhbmsgeW91IGZvciBnb29kIHBvaW50LiBJIHdpbGwgZml4IGl0IGluIHRoZQ0K
djUsIGFuZCB3aWxsIHVzZSAlcGUgZm9yIGFsbCBkZXZfZXJyKCkgY2FsbHMsIEkgc3VwcG9zZSBp
dCdzIGhlbHBmdWwuDQoNClsuLi5dDQoNCj4gPiA+ID4gKwlpZiAobXNhMzExLT52ZGQpIHsNCj4g
PiA+ID4gKwkJZXJyID0gcmVndWxhdG9yX2VuYWJsZShtc2EzMTEtPnZkZCk7DQo+ID4gPiA+ICsJ
CWlmIChlcnIpDQo+ID4gPiA+ICsJCQlyZXR1cm4gZGV2X2Vycl9wcm9iZShkZXYsIGVyciwNCj4g
PiA+ID4gKwkJCQkJICAgICAiY2Fubm90IGVuYWJsZSB2ZGQgc3VwcGx5XG4iKTsNCj4gPiA+ID4g
Kw0KPiA+ID4gPiArCQllcnIgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBtc2EzMTFf
dmRkX2Rpc2FibGUsDQo+ID4gPiA+ICsJCQkJCSAgICAgICBtc2EzMTEtPnZkZCk7DQo+ID4gPiA+
ICsJCWlmIChlcnIpIHsNCj4gPiA+ID4gKwkJCXJlZ3VsYXRvcl9kaXNhYmxlKG1zYTMxMS0+dmRk
KTsNCj4gPiA+IA0KPiA+ID4gRG91YmxlIHJlZ3VsYXRvcl9kaXNhYmxlKCksIGJlY2F1c2Ugb2Yg
dGhlIF9vcl9yZXNldCgpPw0KPiA+ID4gDQo+ID4gDQo+ID4gWWVwLiBJZiBkZXZtX2FkZF9hY3Rp
b25fb3JfcmVzZXQoKSByZXR1cm5zIGFuIGVycm9yLCB3ZSB3aWxsIG5vdA0KPiA+IGNhbGwgcmVn
dWxhdG9yX2Rpc2FibGUoKSBieSBkZXZtIHN1YnN5c3RlbS4gSXQgbWVhbnMsIHdlIGhhdmUgdG8N
Cj4gPiBjYWxsIGl0IGRpcmVjdGx5Lg0KPiANCj4gTm8uDQo+IA0KPiBTZWUNCmh0dHBzOi8vZWxp
eGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y1LjE5L3NvdXJjZS9pbmNsdWRlL2xpbnV4L2RldmljZS5o
I0wyNDkNCj4gDQo+IElmIGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGZhaWxzLCAiYWN0aW9u
IiBpcyBjYWxsZWQuIFRoaXMgaXMgdGhlIG1lYW5pbmcNCj4gb2YgdGhlIF9vcl9yZXNldCBzdWZm
aXguDQo+IA0KPiBTbyBoZXJlLCBtc2EzMTFfdmRkX2Rpc2FibGUoKSB3b3VsZCBiZSBjYWxsZWQg
YW5kIHRoaXMgZnVuY3Rpb24gaXM6DQo+IA0KPiArc3RhdGljIHZvaWQgbXNhMzExX3ZkZF9kaXNh
YmxlKHZvaWQgKnZkZCkNCj4gK3sNCj4gKwlyZWd1bGF0b3JfZGlzYWJsZSh2ZGQpOw0KPiArfQ0K
PiANCj4gYW5kICJ2ZGQiIHdpbGwgYmUgdGhlIHZhbHVlIG9mICJtc2EzMTEtPnZkZCINCj4gDQo+
IFNvLCB1bmxlc3MgSSBtaXNzZWQgc29tZXRoaW5nIG9idmlvdXMsIHlvdXIgY29kZSB3aWxsIGNh
bGwgdHdpY2UNCj4gcmVndWxhdG9yX2Rpc2FibGUobXNhMzExLT52ZGQpLg0KPiANCj4gT25lIGlu
IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldCgpIGFuZCBvbmUgZXhwbGljaXRseSBhZnRlciB0aGUg
ImlmIChlcnIpIg0KPiANCg0KWW91IGFyZSB0b3RhbGx5IHJpZ2h0LCB0aGFua3MgYSBsb3QgZm9y
IHRoZSBleHBsYW5hdGlvbi4gSSB3aWxsIGZpeCB0aGF0DQppbiB0aGUgdjUuDQoNCj4gDQo+IEhv
cGluZyBJJ20gY2xlYXIgYW5kIHRoYXQgSSBkaWRuJ3QgbWlzcyBzb21ldGhpbmcgb2J2aW91cy4N
Cj4gDQo+IENKDQo+IA0KPiA+IA0KPiA+ID4gPiArCQkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2
LCBlcnIsDQo+ID4gPiA+ICsJCQkJCSAgICAgImNhbm5vdCBhZGQgdmRkIGRpc2FibGUgYWN0aW9u
XG4iKTsNCj4gPiA+ID4gKwkJfQ0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+ID4gPiArCWVy
ciA9IG1zYTMxMV9jaGVja19wYXJ0aWQobXNhMzExKTsNCj4gPiA+ID4gKwlpZiAoZXJyKQ0KPiA+
ID4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZXJyID0gbXNhMzExX3Nv
ZnRfcmVzZXQobXNhMzExKTsNCj4gPiA+ID4gKwlpZiAoZXJyKQ0KPiA+ID4gPiArCQlyZXR1cm4g
ZXJyOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJZXJyID0gbXNhMzExX3NldF9wd3JfbW9kZShtc2Ez
MTEsIE1TQTMxMV9QV1JfTU9ERV9OT1JNQUwpOw0KPiA+ID4gPiArCWlmIChlcnIpDQo+ID4gPiA+
ICsJCXJldHVybiBkZXZfZXJyX3Byb2JlKGRldiwgZXJyLA0KPiA+ID4gPiArCQkJCSAgICAgImZh
aWxlZCB0byBwb3dlciBvbiBkZXZpY2UgKCVkKVxuIiwgZXJyKTsNCj4gPiA+IA0KPiA+ID4gTm8g
bmVlZCBmb3IgIiglZCkiIGFuZCBlcnINCj4gPiANCj4gPiBBc2tlZCBmb3IgdGhlIGNsYXJpZmlj
YXRpb24gYWJvdmUuDQo+ID4gDQo+ID4gPiANCj4gPiA+IENKDQo+ID4gDQo+IA0KDQotLSANClRo
YW5rIHlvdSwNCkRtaXRyeQ==
