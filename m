Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 121E257172E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 12:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232597AbiGLKVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 06:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiGLKVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 06:21:33 -0400
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0B8ADD4D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 03:21:29 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 12 Jul 2022 18:21:28 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 26CALNsx077982;
        Tue, 12 Jul 2022 18:21:23 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from CSBMAIL1.internal.ite.com.tw (192.168.65.58) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Tue, 12 Jul 2022 18:21:24 +0800
Received: from CSBMAIL1.internal.ite.com.tw ([fe80::dd22:b444:859b:61c7]) by
 CSBMAIL1.internal.ite.com.tw ([fe80::dd22:b444:859b:61c7%18]) with mapi id
 15.01.2176.014; Tue, 12 Jul 2022 18:21:24 +0800
From:   <allen.chen@ite.com.tw>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <treapking@google.com>, <Jau-Chih.Tseng@ite.com.tw>,
        <Hermes.Wu@ite.com.tw>, <Kenneth.Hung@ite.com.tw>,
        <allen-kh.cheng@mediatek.corp-partner.google.com>,
        <treapking@chromium.org>, <andrzej.hajda@intel.com>,
        <narmstrong@baylibre.com>, <robert.foss@linaro.org>,
        <Laurent.pinchart@ideasonboard.com>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <matthias.bgg@gmail.com>, <dri-devel@lists.freedesktop.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: RE: [PATCH] drm/bridge: add it6505 driver read config from dt
 property
Thread-Topic: [PATCH] drm/bridge: add it6505 driver read config from dt
 property
Thread-Index: AQHYiiU2sEhaoVt2QkuGqiQ1tO5jFa16nKiw
Date:   Tue, 12 Jul 2022 10:21:24 +0000
Message-ID: <3adce6f63a41434ea0b127bb9e793446@ite.com.tw>
References: <20220623093154.52701-1-allen.chen@ite.com.tw>
 <7f565036-df78-a4e7-db5e-259115daaf79@collabora.com>
In-Reply-To: <7f565036-df78-a4e7-db5e-259115daaf79@collabora.com>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.70.46]
x-tm-snts-smtp: 267CFC6B8D3D45475EDCB01AC192F3F5A0981F48C11BA41AE24501DA5024DE4C2002:8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MAIL: mse.ite.com.tw 26CALNsx077982
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5nZWxvR2lvYWNjaGlubw0KDQpBY2NvcmRpbmcgdG8gdmlkZW8taW50ZXJmYWNlcy55YW1s
LCBwcm9wZXJ0eSBkYXRhLWxhbmVzIHNob3VsZCBpbiB0aGUgZW5kcG9pbnQuIEl0NjUwNSBoYXMg
ZHBpIGlucHV0IGFuZCBubyBkYXRhLWxhbmVzIHBhcmFtZXRlcnMuIEl0NjUwNSBoYXMgZHAgb3V0
cHV0IGFuZCBoYXMgZGF0YS1sYW5lcyBwYXJhbWV0ZXJzLiBXZSB3YW50IHRvIHVzZSBkYXRhLWxh
bmVzIGluIHRoZSBvdXRwdXQsIGJ1dCBvdXRwdXQgcG9pbnQgdXNlIGV4dGNvbiBpbnN0ZWFkIG9m
IGVuZHBvaW50LiBEbyBub3QgaGF2ZSBvdXRwdXQgZW5kcG9pbnQuDQpXaGljaCBsaW5lIGluIGR0
cyBzaG91bGQgZGF0YS1sYW5lcyBiZSBpbj8NCkJlbG93IGlzIGl0NjUwNSBkdHMgDQoNClRoYW5r
cyBmb3IgeW91ciBzdWdnZXN0aW9uIQ0KDQpkcC1icmlkZ2VANWMgew0KICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJpdGUsaXQ2NTA1IjsNCiAgICAgICAgICAgIGludGVycnVwdHMgPSA8MTUyIElS
UV9UWVBFX0VER0VfRkFMTElORyAxNTIgMD47DQogICAgICAgICAgICByZWcgPSA8MHg1Yz47DQog
ICAgICAgICAgICBwaW5jdHJsLW5hbWVzID0gImRlZmF1bHQiOw0KICAgICAgICAgICAgcGluY3Ry
bC0wID0gPCZpdDY1MDVfcGlucz47DQogICAgICAgICAgICBvdmRkLXN1cHBseSA9IDwmbXQ2MzU4
X3ZzaW0xX3JlZz47DQogICAgICAgICAgICBwd3IxOC1zdXBwbHkgPSA8Jml0NjUwNV9wcDE4X3Jl
Zz47DQogICAgICAgICAgICByZXNldC1ncGlvcyA9IDwmcGlvIDE3OSAxPjsNCiAgICAgICAgICAg
IGV4dGNvbiA9IDwmdXNiY19leHRjb24+Ow0KDQogICAgICAgICAgICBwb3J0IHsNCiAgICAgICAg
ICAgICAgICBpdDY1MDVfaW46IGVuZHBvaW50IHsNCiAgICAgICAgICAgICAgICAgICAgcmVtb3Rl
LWVuZHBvaW50ID0gPCZkcGlfb3V0PjsNCiAgICAgICAgICAgICAgICB9Ow0KICAgICAgICAgICAg
fTsNCiAgICAgICAgfTsNCg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogQW5n
ZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPGFuZ2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFi
b3JhLmNvbT4gDQpTZW50OiBNb25kYXksIEp1bmUgMjcsIDIwMjIgODo1NSBQTQ0KVG86IEFsbGVu
IENoZW4gKOmZs+afj+WuhykgPGFsbGVuLmNoZW5AaXRlLmNvbS50dz4NCkNjOiBQaW4teWVuIExp
biA8dHJlYXBraW5nQGdvb2dsZS5jb20+OyBKYXUtQ2hpaCBUc2VuZyAo5pu+5pit5pm6KSA8SmF1
LUNoaWguVHNlbmdAaXRlLmNvbS50dz47IEhlcm1lcyBXdSAo5ZCz5L2z5a6PKSA8SGVybWVzLld1
QGl0ZS5jb20udHc+OyBLZW5uZXRoIEh1bmcgKOa0quWutuWAqykgPEtlbm5ldGguSHVuZ0BpdGUu
Y29tLnR3PjsgQWxsZW4ta2ggQ2hlbmcgPGFsbGVuLWtoLmNoZW5nQG1lZGlhdGVrLmNvcnAtcGFy
dG5lci5nb29nbGUuY29tPjsgUGluLXllbiBMaW4gPHRyZWFwa2luZ0BjaHJvbWl1bS5vcmc+OyBB
bmRyemVqIEhhamRhIDxhbmRyemVqLmhhamRhQGludGVsLmNvbT47IE5laWwgQXJtc3Ryb25nIDxu
YXJtc3Ryb25nQGJheWxpYnJlLmNvbT47IFJvYmVydCBGb3NzIDxyb2JlcnQuZm9zc0BsaW5hcm8u
b3JnPjsgTGF1cmVudCBQaW5jaGFydCA8TGF1cmVudC5waW5jaGFydEBpZGVhc29uYm9hcmQuY29t
PjsgSm9uYXMgS2FybG1hbiA8am9uYXNAa3dpYm9vLnNlPjsgSmVybmVqIFNrcmFiZWMgPGplcm5l
ai5za3JhYmVjQGdtYWlsLmNvbT47IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT47IERh
bmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD47IE1hdHRoaWFzIEJydWdnZXIgPG1hdHRoaWFz
LmJnZ0BnbWFpbC5jb20+OyBvcGVuIGxpc3Q6RFJNIERSSVZFUlMgPGRyaS1kZXZlbEBsaXN0cy5m
cmVlZGVza3RvcC5vcmc+OyBvcGVuIGxpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
OyBtb2RlcmF0ZWQgbGlzdDpBUk0vTWVkaWF0ZWsgU29DIHN1cHBvcnQgPGxpbnV4LWFybS1rZXJu
ZWxAbGlzdHMuaW5mcmFkZWFkLm9yZz47IG1vZGVyYXRlZCBsaXN0OkFSTS9NZWRpYXRlayBTb0Mg
c3VwcG9ydCA8bGludXgtbWVkaWF0ZWtAbGlzdHMuaW5mcmFkZWFkLm9yZz4NClN1YmplY3Q6IFJl
OiBbUEFUQ0hdIGRybS9icmlkZ2U6IGFkZCBpdDY1MDUgZHJpdmVyIHJlYWQgY29uZmlnIGZyb20g
ZHQgcHJvcGVydHkNCg0KSWwgMjMvMDYvMjIgMTE6MzEsIGFsbGVuIGhhIHNjcml0dG86DQo+IEZy
b206IGFsbGVuIGNoZW4gPGFsbGVuLmNoZW5AaXRlLmNvbS50dz4NCj4gDQo+IGFkZCByZWFkIG1h
eC1sYW5lIGFuZCBtYXgtcGl4ZWwtY2xvY2sgZnJvbSBkdCBwcm9wZXJ0eQ0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQWxsZW4ta2ggQ2hlbmcgDQo+IDxhbGxlbi1raC5jaGVuZ0BtZWRpYXRlay5jb3Jw
LXBhcnRuZXIuZ29vZ2xlLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogUGluLXllbiBMaW4gPHRyZWFw
a2luZ0BjaHJvbWl1bS5vcmc+DQoNCkhlbGxvIEFsbGVuLA0KDQphcyBTYW0gYWxzbyBwb2ludGVk
IG91dCwgcGxlYXNlIGZpeCB5b3VyIFMtby1iIGVtYWlsOiBpdCBoYXMgdG8gbWF0Y2ggd2l0aCB0
aGUgYXV0aG9yIG9uZS4NCg0KQW55d2F5LCB5b3UncmUgYWRkaW5nIGRldmljZXRyZWUgcHJvcGVy
dGllcywgc28gdGhpcyBpbXBsaWVzIHRoYXQgeW91IHNob3VsZCBhbHNvIGNoYW5nZSB0aGUgZHQt
YmluZGluZ3MgZG9jdW1lbnRhdGlvbiBmb3IgdGhpcyBkcml2ZXIuLi4gYW5kIGFsc28sIEkgaGF2
ZSBzb21lIG1vcmUgY29tbWVudHMsIGNoZWNrIGJlbG93Og0KDQo+IC0tLQ0KPiAgIGRyaXZlcnMv
Z3B1L2RybS9icmlkZ2UvaXRlLWl0NjUwNS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysr
KystLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMo
LSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1pdDY1MDUu
YyANCj4gYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1pdDY1MDUuYw0KPiBpbmRleCA0YjY3
M2M0NzkyZDc3Li5jOTEyMWQ0NjM1YTUyIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2dwdS9kcm0v
YnJpZGdlL2l0ZS1pdDY1MDUuYw0KPiArKysgYi9kcml2ZXJzL2dwdS9kcm0vYnJpZGdlL2l0ZS1p
dDY1MDUuYw0KPiBAQCAtNDM2LDYgKzQzNiw4IEBAIHN0cnVjdCBpdDY1MDUgew0KPiAgIAlib29s
IHBvd2VyZWQ7DQo+ICAgCWJvb2wgaHBkX3N0YXRlOw0KPiAgIAl1MzIgYWZlX3NldHRpbmc7DQo+
ICsJdTMyIG1heF9kcGlfcGl4ZWxfY2xvY2s7DQo+ICsJdTMyIG1heF9sYW5lX2NvdW50Ow0KPiAg
IAllbnVtIGhkY3Bfc3RhdGUgaGRjcF9zdGF0dXM7DQo+ICAgCXN0cnVjdCBkZWxheWVkX3dvcmsg
aGRjcF93b3JrOw0KPiAgIAlzdHJ1Y3Qgd29ya19zdHJ1Y3QgaGRjcF93YWl0X2tzdl9saXN0OyBA
QCAtMTQ2Niw3ICsxNDY4LDggQEAgc3RhdGljIA0KPiB2b2lkIGl0NjUwNV9wYXJzZV9saW5rX2Nh
cGFiaWxpdGllcyhzdHJ1Y3QgaXQ2NTA1ICppdDY1MDUpDQo+ICAgCWl0NjUwNS0+bGFuZV9jb3Vu
dCA9IGxpbmstPm51bV9sYW5lczsNCj4gICAJRFJNX0RFVl9ERUJVR19EUklWRVIoZGV2LCAiU2lu
ayBzdXBwb3J0ICVkIGxhbmVzIHRyYWluaW5nIiwNCj4gICAJCQkgICAgIGl0NjUwNS0+bGFuZV9j
b3VudCk7DQo+IC0JaXQ2NTA1LT5sYW5lX2NvdW50ID0gbWluX3QoaW50LCBpdDY1MDUtPmxhbmVf
Y291bnQsIE1BWF9MQU5FX0NPVU5UKTsNCj4gKwlpdDY1MDUtPmxhbmVfY291bnQgPSBtaW5fdChp
bnQsIGl0NjUwNS0+bGFuZV9jb3VudCwNCj4gKwkJCQkgICBpdDY1MDUtPm1heF9sYW5lX2NvdW50
KTsNCj4gICANCj4gICAJaXQ2NTA1LT5icmFuY2hfZGV2aWNlID0gZHJtX2RwX2lzX2JyYW5jaChp
dDY1MDUtPmRwY2QpOw0KPiAgIAlEUk1fREVWX0RFQlVHX0RSSVZFUihkZXYsICJTaW5rICVzYnJh
bmNoIGRldmljZSIsIEBAIC0yODk1LDcgDQo+ICsyODk4LDcgQEAgaXQ2NTA1X2JyaWRnZV9tb2Rl
X3ZhbGlkKHN0cnVjdCBkcm1fYnJpZGdlICpicmlkZ2UsDQo+ICAgCWlmIChtb2RlLT5mbGFncyAm
IERSTV9NT0RFX0ZMQUdfSU5URVJMQUNFKQ0KPiAgIAkJcmV0dXJuIE1PREVfTk9fSU5URVJMQUNF
Ow0KPiAgIA0KPiAtCWlmIChtb2RlLT5jbG9jayA+IERQSV9QSVhFTF9DTEtfTUFYKQ0KPiArCWlm
IChtb2RlLT5jbG9jayA+IGl0NjUwNS0+bWF4X2RwaV9waXhlbF9jbG9jaykNCj4gICAJCXJldHVy
biBNT0RFX0NMT0NLX0hJR0g7DQo+ICAgDQo+ICAgCWl0NjUwNS0+dmlkZW9faW5mby5jbG9jayA9
IG1vZGUtPmNsb2NrOyBAQCAtMzA1Nyw2ICszMDYwLDggQEAgDQo+IHN0YXRpYyB2b2lkIGl0NjUw
NV9wYXJzZV9kdChzdHJ1Y3QgaXQ2NTA1ICppdDY1MDUpDQo+ICAgew0KPiAgIAlzdHJ1Y3QgZGV2
aWNlICpkZXYgPSAmaXQ2NTA1LT5jbGllbnQtPmRldjsNCj4gICAJdTMyICphZmVfc2V0dGluZyA9
ICZpdDY1MDUtPmFmZV9zZXR0aW5nOw0KPiArCXUzMiAqbWF4X2xhbmVfY291bnQgPSAmaXQ2NTA1
LT5tYXhfbGFuZV9jb3VudDsNCj4gKwl1MzIgKm1heF9kcGlfcGl4ZWxfY2xvY2sgPSAmaXQ2NTA1
LT5tYXhfZHBpX3BpeGVsX2Nsb2NrOw0KPiAgIA0KPiAgIAlpdDY1MDUtPmxhbmVfc3dhcF9kaXNh
YmxlZCA9DQo+ICAgCQlkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGRldiwgIm5vLWxhbmVzd2Fw
Iik7IEBAIC0zMDcyLDcgKzMwNzcsMzEgDQo+IEBAIHN0YXRpYyB2b2lkIGl0NjUwNV9wYXJzZV9k
dChzdHJ1Y3QgaXQ2NTA1ICppdDY1MDUpDQo+ICAgCX0gZWxzZSB7DQo+ICAgCQkqYWZlX3NldHRp
bmcgPSAwOw0KPiAgIAl9DQo+IC0JRFJNX0RFVl9ERUJVR19EUklWRVIoZGV2LCAidXNpbmcgYWZl
X3NldHRpbmc6ICVkIiwgKmFmZV9zZXR0aW5nKTsNCj4gKw0KPiArCWlmIChkZXZpY2VfcHJvcGVy
dHlfcmVhZF91MzIoZGV2LCAibWF4LWxhbmUtY291bnQiLA0KDQpQbGVhc2UgdXNlIHRoZSBzdGFu
ZGFyZCBwcm9wZXJ0eSAiZGF0YS1sYW5lcyIgZnJvbSB2aWRlby1pbnRlcmZhY2VzLnlhbWwuDQoN
Cj4gKwkJCQkgICAgIG1heF9sYW5lX2NvdW50KSA9PSAwKSB7DQo+ICsJCWlmICgqbWF4X2xhbmVf
Y291bnQgPiA0IHx8ICptYXhfbGFuZV9jb3VudCA9PSAzKSB7DQo+ICsJCQlkZXZfZXJyKGRldiwg
Im1heCBsYW5lIGNvdW50IGVycm9yLCB1c2UgZGVmYXVsdCIpOw0KPiArCQkJKm1heF9sYW5lX2Nv
dW50ID0gTUFYX0xBTkVfQ09VTlQ7DQo+ICsJCX0NCj4gKwl9IGVsc2Ugew0KPiArCQkqbWF4X2xh
bmVfY291bnQgPSBNQVhfTEFORV9DT1VOVDsNCj4gKwl9DQo+ICsNCj4gKwlpZiAoZGV2aWNlX3By
b3BlcnR5X3JlYWRfdTMyKGRldiwgIm1heC1kcGktcGl4ZWwtY2xvY2siLA0KPiArCQkJCSAgICAg
bWF4X2RwaV9waXhlbF9jbG9jaykgPT0gMCkgew0KDQpXaGF0IGFib3V0ICJtYXgtcGl4ZWwtY2xv
Y2sta2h6IiBvciAibWF4LXBpeGVsLWNsb2NrLWh6Ij8NCg0KDQpSZWdhcmRzLA0KQW5nZWxvDQo=
