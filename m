Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC3C483AAE
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 03:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbiADCtR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 21:49:17 -0500
Received: from mx1.cqplus1.com ([113.204.237.245]:40234 "EHLO mx1.cqplus1.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229705AbiADCtR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 21:49:17 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by mx1.cqplus1.com with MailGates ESMTP Server V5.0(24939:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Tue, 04 Jan 2022 10:48:16 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 4 Jan 2022 10:48:17 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Tue, 4 Jan 2022 10:48:17 +0800
From:   =?utf-8?B?eHQuaHVb6IOh5YWI6Z+sXQ==?= <xt.hu@cqplus1.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?cWluamlhblvopoPlgaVd?= <qinjian@cqplus1.com>
Subject: RE: [PATCH v4 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Index: AQHX/HdP855TMpH9jEyra1LjiDLk4axPU+mAgALb2gA=
Date:   Tue, 4 Jan 2022 02:48:17 +0000
Message-ID: <eae1abf41ef44f1186c6c781a15516c9@cqplus1.com>
References: <20211229054308.63168-1-xt.hu@cqplus1.com>
 <20211229054308.63168-3-xt.hu@cqplus1.com>
 <20220102150027.GA2806117@roeck-us.net>
In-Reply-To: <20220102150027.GA2806117@roeck-us.net>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBHdWVudGVyIFJvZWNrIFttYWls
dG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFsZiBPZiBHdWVudGVyIFJvZWNrDQo+IFNlbnQ6
IFN1bmRheSwgSmFudWFyeSAyLCAyMDIyIDExOjAwIFBNDQo+IFRvOiB4dC5odVvog6HlhYjpn6xd
IDx4dC5odUBjcXBsdXMxLmNvbT4NCj4gQ2M6IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7IHAuemFi
ZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4
LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgV2VsbHMgTHUg5ZGC6Iqz6aiwDQo+IDx3ZWxscy5sdUBzdW5wbHVz
LmNvbT47IHFpbmppYW5b6KaD5YGlXSA8cWluamlhbkBjcXBsdXMxLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSCB2NCAyLzJdIHdhdGNoZG9nOiBBZGQgd2F0Y2hkb2cgZHJpdmVyIGZvciBTdW5w
bHVzIFNQNzAyMQ0KPiANCj4gT24gV2VkLCBEZWMgMjksIDIwMjEgYXQgMDE6NDM6MDhQTSArMDgw
MCwgWGlhbnRhbyBIdSB3cm90ZToNCj4gPiBTdW5wbHVzIFNQNzAyMSByZXF1aXJlcyB3YXRjaGRv
ZyB0aW1lciBzdXBwb3J0Lg0KPiA+IEFkZCB3YXRjaGRvZyBkcml2ZXIgdG8gZW5hYmxlIHRoaXMu
DQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFudGFvIEh1IDx4dC5odUBjcXBsdXMxLmNvbT4N
Cj4gPiAtLS0NCj4gPiBDaGFuZ2VzIGluIHY0DQo+ID4gIC0gRHJvcCB0aGUgdW51c2VkIHZhcmli
bGUgc3RydWN0IHJlc291cmNlICp3ZHRfcmVzLg0KPiA+ICAtIERyb3AgdGhlIG9wZXJhdGlvbnMg
cmVsYXRlZCB0byBhZGRyZXNzIDB4OWMwMDAyNzQuDQo+ID4gICAgUHV0IGl0IGluIGJvb3Rsb2Fk
ZXIgYmVmb3JlIGVudHJ5IGtlcm5lbCBib290IGluIHYzLg0KPiA+DQo+ID4uLi4NCj4gPiArew0K
PiA+ICsJd2Rldi0+dGltZW91dCA9IHRpbWVvdXQ7DQo+ID4gKwlzcF93ZHRfcGluZyh3ZGV2KTsN
Cj4gDQo+IFRoaXMgaXMgZXhhY3RseSB3aGF0IHRoZSBjYWxsaW5nIGNvZGUgZG9lcyBpZiB0aGVy
ZSBpcyBubyBzZXRfdGltZW91dA0KPiBmdW5jdGlvbiwgc28geW91IGNhbiBqdXN0IGRyb3AgdGhp
cyBmdW5jdGlvbiwNCj4gDQoNCk9LLiBJIHdpbGwgZHJvcCBpdC4NCg0KPiA+IC4uLg0KPiA+ICsN
Cj4gPiArCWVyciA9IGNsa19wcmVwYXJlX2VuYWJsZShwcml2LT5jbGspOw0KPiA+ICsJaWYgKGVy
cikgew0KPiA+ICsJCWRldl9lcnIoZGV2LCAiQ2xvY2sgY2FuJ3QgYmUgZW5hYmxlZCBjb3JyZWN0
bHlcbiIpOw0KPiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJLyogVGhl
IHRpbWVyIGFuZCB3YXRjaGRvZyBzaGFyZWQgdGhlIFNUQyByZXNldCAqLw0KPiA+ICsJcHJpdi0+
cnN0YyA9IGRldm1fcmVzZXRfY29udHJvbF9nZXRfc2hhcmVkKGRldiwgTlVMTCk7DQo+ID4gKwlp
ZiAoIUlTX0VSUihwcml2LT5yc3RjKSkNCj4gPiArCQlyZXNldF9jb250cm9sX2RlYXNzZXJ0KHBy
aXYtPnJzdGMpOw0KPiA+ICsNCj4gPiArCWVyciA9IGRldm1fYWRkX2FjdGlvbl9vcl9yZXNldChk
ZXYsIHNwX3Jlc2V0X2NvbnRyb2xfYXNzZXJ0LA0KPiA+ICsJCQkJICAgICAgIHByaXYtPnJzdGMp
Ow0KPiA+ICsJaWYgKGVycikNCj4gPiArCQlyZXR1cm4gZXJyOw0KPiA+ICsNCj4gDQo+IGRldm1f
YWRkX2FjdGlvbl9vcl9yZXNldCgpIGFib3ZlIHNob3VsZCBvbmx5IGJlIGNhbGxlZCBpZg0KPiBk
ZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X3NoYXJlZCBzdWNjZWVkcy4NCj4gDQoNCk9LLiBJIHdpbGwg
bW9kaWZ5IGl0Lg0KDQo+ID4gKwllcnIgPSBkZXZtX2FkZF9hY3Rpb25fb3JfcmVzZXQoZGV2LCBz
cF9jbGtfZGlzYWJsZV91bnByZXBhcmUsDQo+ID4gKwkJCQkgICAgICAgcHJpdi0+Y2xrKTsNCj4g
DQo+IFRoaXMgc2hvdWxkIGJlIGNhbGxlZCBpbW1lZGlhdGVseSBhZnRlciBjbGtfcHJlcGFyZV9l
bmFibGUoKS4NCj4gDQoNCk9LLiBJIHdpbGwgbW9kaWZ5IGl0Lg0KDQo+ID4gKwlpZiAoZXJyKQ0K
PiA+ICsJCXJldHVybiBlcnI7DQo+ID4gLi4uDQo=
