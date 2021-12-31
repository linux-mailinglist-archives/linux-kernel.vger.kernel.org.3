Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2E5E4821C3
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 04:20:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242591AbhLaDUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 22:20:39 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:57970 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229590AbhLaDUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 22:20:38 -0500
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24952:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Fri, 31 Dec 2021 10:50:45 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 31 Dec 2021 10:50:42 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Fri, 31 Dec 2021 10:50:41 +0800
From:   =?utf-8?B?eHQuaHVb6IOh5YWI6Z+sXQ==?= <xt.hu@cqplus1.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>,
        Rob Herring <robh@kernel.org>
Subject: RE: [PATCH v4 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Index: Adf96zGpMiWEfywATSCQ2rqHRhcaXQ==
Date:   Fri, 31 Dec 2021 02:50:41 +0000
Message-ID: <17803809bef1499fb051cf79fc3c7245@cqplus1.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.28.110.16]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQ2hydXN0b3BoZSwNCg0KCVRoYW5rcyBmb3IgeW91ciByZXNwb25kLg0KDQpCZXN0IFJlZ2Fy
ZHMsDQpYaWFudGFvDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IENocmlz
dG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI+DQo+IFRvOiBYaWFu
dGFvIEh1IDx4dC5odUBjcXBsdXMxLmNvbT4sDQo+CXdpbUBsaW51eC13YXRjaGRvZy5vcmcsIHAu
emFiZWxAcGVuZ3V0cm9uaXguZGUsDQo+CWxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcsIGxp
bnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZywNCj4JbGludXhAcm9lY2stdXMubmV0LCByb2Jo
K2R0QGtlcm5lbC5vcmcsDQo+CWRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnDQo+IENjOiB3ZWxs
cy5sdUBzdW5wbHVzLmNvbSwgcWluamlhbkBjcXBsdXMxLmNvbQ0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIHY0IDIvMl0gd2F0Y2hkb2c6IEFkZCB3YXRjaGRvZyBkcml2ZXIgZm9yIFN1bnBsdXMgU1A3
MDIxDQo+IERhdGU6IFdlZCwgMjkgRGVjIDIwMjEgMTA6Mzk6MDggKzAxMDAJW3RocmVhZCBvdmVy
dmlld10NCj4gTWVzc2FnZS1JRDogPDBiMTAyZmEwLWNiZmMtYTk3ZS04ZTdmLWNjZTgxNDY0NTBi
Y0B3YW5hZG9vLmZyPiAocmF3KQ0KPiBJbi1SZXBseS1UbzogPDIwMjExMjI5MDU0MzA4LjYzMTY4
LTMteHQuaHVAY3FwbHVzMS5jb20+DQo+DQo+Li4uDQo+DQo+ID4gK3N0YXRpYyBpbnQgc3Bfd2R0
X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlzdHJ1Y3Qgc3Bfd2R0X3ByaXYgKnBy
aXY7DQo+ID4gKwlpbnQgZXJyOw0KPiA+ICsNCj4gPiArCXByaXYgPSBkZXZtX2t6YWxsb2MoZGV2
LCBzaXplb2YoKnByaXYpLCBHRlBfS0VSTkVMKTsNCj4gPiArCWlmICghcHJpdikNCj4gPiArCQly
ZXR1cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlwcml2LT5jbGsgPSBkZXZtX2Nsa19nZXQoZGV2
LCBOVUxMKTsNCj4gPiArCWlmIChJU19FUlIocHJpdi0+Y2xrKSkgew0KPiA+ICsJCWRldl9lcnIo
ZGV2LCAiQ2FuJ3QgZmluZCBjbG9jayBzb3VyY2VcbiIpOw0KPiA+ICsJCXJldHVybiBQVFJfRVJS
KHByaXYtPmNsayk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZXJyID0gY2xrX3ByZXBhcmVfZW5h
YmxlKHByaXYtPmNsayk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJD
bG9jayBjYW4ndCBiZSBlbmFibGVkIGNvcnJlY3RseVxuIik7DQo+ID4gKwkJcmV0dXJuIGVycjsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gKwkvKiBUaGUgdGltZXIgYW5kIHdhdGNoZG9nIHNoYXJlZCB0
aGUgU1RDIHJlc2V0ICovDQo+ID4gKwlwcml2LT5yc3RjID0gZGV2bV9yZXNldF9jb250cm9sX2dl
dF9zaGFyZWQoZGV2LCBOVUxMKTsNCj4gPiArCWlmICghSVNfRVJSKHByaXYtPnJzdGMpKQ0KPiA+
ICsJCXJlc2V0X2NvbnRyb2xfZGVhc3NlcnQocHJpdi0+cnN0Yyk7DQo+ID4gKw0KPiA+ICsJZXJy
ID0gZGV2bV9hZGRfYWN0aW9uX29yX3Jlc2V0KGRldiwgc3BfcmVzZXRfY29udHJvbF9hc3NlcnQs
DQo+ID4gKwkJCQkgICAgICAgcHJpdi0+cnN0Yyk7DQo+ID4gKwlpZiAoZXJyKQ0KPiA+ICsJCXJl
dHVybiBlcnI7DQo+IFRoaXMgbG9va3Mgb2RkLg0KPiBXZSBjb3VsZCB1bmRvIHNvbWV0aGluZyB0
aGF0IHdhcyBub3QgZG9uZS4gKGlmIElTX0VSUihwcml2LT5yc3RjKSkNCj4gVGhpcyBpcyBhbHNv
IG5vdCByZWFsbHkgY29uc2lzdGVudCB3aXRoIHdoYXQgaXMgZG9uZSBpbiBzdXNwZWRuL3Jlc3Vt
ZS4NCj4gSW4gdGhlc2UgZnVuY3Rpb25zLCB3ZSBkb24ndCBjaGVjayBmb3IgSVNfRVJSKHByaXYt
PnJzdGMpLg0KPg0KDQpIZXJlIEkgcmVmZXIgdG8gbXQ3NjIxX3dkdC5jLiBJJ20gc3VyZSBJIG5l
ZWQgZGVhc3NlcnQgcmVzZXQgdG8gcmVzZXQgDQp3YXRjaGRvZyByZWdpc3RlciB2YWx1ZSB3aGVu
IGRyaXZlciBwcm9iZS4gYWNjb3JkaW5nbHkgSSBhc3NlcnQgcmVzZXQgDQppbiBkZXZtX2FkZF9h
Y3Rpb25fb3JfcmVzZXQoKSB0byBlbnN1cmUgdGhhdCB0aGUgcmVnaXN0ZXJzIG9mIHdhdGNoZG9n
IA0KY2FuJ3QgYmUgb3BlcmF0ZWQgYWZ0ZXIgbW9kdWxlIHJlbW92ZS4NCg0KPiA+ICsNCj4gPiAr
CWVyciA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChkZXYsIHNwX2Nsa19kaXNhYmxlX3VucHJl
cGFyZSwNCj4gPiArCQkJCSAgICAgICBwcml2LT5jbGspOw0KPiA+ICsJaWYgKGVycikNCj4gPiAr
CQlyZXR1cm4gZXJyOw0KPiBTaG91bGRuJ3QgdGhpcyBiZSBqdXN0IGFmdGVyIGNsa19wcmVwYXJl
X2VuYWJsZSgpPw0KDQpJIHRlc3RlZCB0aGUgb3JkZXIgb2YgZXhlY3V0aW9uIG9mIHRoZSBhZGRl
ZCBmdW5jdGlvbnMgd2hpY2ggaXMgc2ltaWxhciB0byANCnB1c2ggYW5kIHBvcC4gRmlyc3QgaW4s
IGxhc3Qgb3V0LiBJIHRoaW5rIEkgc2hvdWxkIGRpc2FibGUgY2xvY2sgbGFzdC4NCg==
