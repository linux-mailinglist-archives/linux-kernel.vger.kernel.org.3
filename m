Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5F9F460FB2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 09:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242224AbhK2IE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 03:04:29 -0500
Received: from [113.204.237.245] ([113.204.237.245]:55212 "EHLO
        test.cqplus1.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S240884AbhK2ICX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 03:02:23 -0500
X-MailGates: (flag:1,DYNAMIC,RELAY,NOHOST,LAN:PASS)(compute_score:DELIVE
        R,40,3)
Received: from 172.27.96.203
        by cqmailgates with MailGates ESMTP Server V5.0(21485:0:AUTH_RELAY)
        (envelope-from <xt.hu@cqplus1.com>); Mon, 29 Nov 2021 15:57:04 +0800 (CST)
Received: from CQEXMAIL01.cqplus1.com (172.27.96.203) by
 CQEXMAIL01.cqplus1.com (172.27.96.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 29 Nov 2021 15:57:03 +0800
Received: from CQEXMAIL01.cqplus1.com ([::1]) by CQEXMAIL01.cqplus1.com
 ([::1]) with mapi id 15.01.2375.017; Mon, 29 Nov 2021 15:57:03 +0800
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
Subject: RE: [PATCH v2 1/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Topic: [PATCH v2 1/2] watchdog: Add watchdog driver for Sunplus SP7021
Thread-Index: AQHX4SAshE/roTn600ef7AgHipZV4awSNd0AgAE7tVD//68hAIAG+5Kw
Date:   Mon, 29 Nov 2021 07:57:02 +0000
Message-ID: <8604284aa38d4ab6bc263d4881107e13@cqplus1.com>
References: <20211112105952.216280-1-xt.hu@cqplus1.com>
 <20211124104149.361019-1-xt.hu@cqplus1.com>
 <20211124104149.361019-2-xt.hu@cqplus1.com>
 <20211124142522.GA3939252@roeck-us.net>
 <0024d27919c04c84a3f13ecba86a3c70@cqplus1.com>
 <f69d663a-982b-5876-08c9-b1a4f35e8098@roeck-us.net>
In-Reply-To: <f69d663a-982b-5876-08c9-b1a4f35e8098@roeck-us.net>
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

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEd1ZW50ZXIgUm9lY2sgW21h
aWx0bzpncm9lY2s3QGdtYWlsLmNvbV0gT24gQmVoYWxmIE9mIEd1ZW50ZXIgUm9lY2sNCj4gU2Vu
dDogVGh1cnNkYXksIE5vdmVtYmVyIDI1LCAyMDIxIDEyOjI2IFBNDQo+IFRvOiB4dC5odVvog6Hl
hYjpn6xdIDx4dC5odUBjcXBsdXMxLmNvbT4NCj4gQ2M6IHdpbUBsaW51eC13YXRjaGRvZy5vcmc7
IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+
IGxpbnV4LXdhdGNoZG9nQHZnZXIua2VybmVsLm9yZzsgcm9iaCtkdEBrZXJuZWwub3JnOyBkZXZp
Y2V0cmVlQHZnZXIua2VybmVsLm9yZzsgV2VsbHMgTHUg5ZGC6Iqz6aiwDQo+IDx3ZWxscy5sdUBz
dW5wbHVzLmNvbT47IHFpbmppYW5b6KaD5YGlXSA8cWluamlhbkBjcXBsdXMxLmNvbT4NCj4gU3Vi
amVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIHdhdGNoZG9nOiBBZGQgd2F0Y2hkb2cgZHJpdmVyIGZv
ciBTdW5wbHVzIFNQNzAyMQ0KPiANCj4gT24gMTEvMjQvMjEgNjo0MiBQTSwgeHQuaHVb6IOh5YWI
6Z+sXSB3cm90ZToNCj4gPiBIaQ0KPiA+IAlUaGFua3MgZm9yIHlvdXIgcmV2aWV3LiBJIGV4cGxh
aW4gdGhpcyBpbiBkZXRhaWwgYmVsb3cgdGhlIGNvbW1lbnQuDQo+ID4NCj4gPiBCZXN0IFJlZ2Fy
ZHMsDQo+ID4gWGlhbnRhbw0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBG
cm9tOiBHdWVudGVyIFJvZWNrIFttYWlsdG86Z3JvZWNrN0BnbWFpbC5jb21dIE9uIEJlaGFsZiBP
ZiBHdWVudGVyIFJvZWNrDQo+ID4+IFNlbnQ6IFdlZG5lc2RheSwgTm92ZW1iZXIgMjQsIDIwMjEg
MTA6MjUgUE0NCj4gPj4gVG86IHh0Lmh1W+iDoeWFiOmfrF0gPHh0Lmh1QGNxcGx1czEuY29tPg0K
PiA+PiBDYzogd2ltQGxpbnV4LXdhdGNoZG9nLm9yZzsgcC56YWJlbEBwZW5ndXRyb25peC5kZTsg
bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4gbGludXgtd2F0Y2hkb2dAdmdlci5r
ZXJuZWwub3JnOyByb2JoK2R0QGtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
OyBXZWxscyBMdSDlkYLoirMNCj4g6aiwDQo+ID4+IDx3ZWxscy5sdUBzdW5wbHVzLmNvbT47IHFp
bmppYW5b6KaD5YGlXSA8cWluamlhbkBjcXBsdXMxLmNvbT4NCj4gPj4gU3ViamVjdDogUmU6IFtQ
QVRDSCB2MiAxLzJdIHdhdGNoZG9nOiBBZGQgd2F0Y2hkb2cgZHJpdmVyIGZvciBTdW5wbHVzIFNQ
NzAyMQ0KPiA+Pg0KPiA+PiBPbiBXZWQsIE5vdiAyNCwgMjAyMSBhdCAwNjo0MTo0OFBNICswODAw
LCBYaWFudGFvIEh1IHdyb3RlOg0KPiA+Pj4gU3VucGx1cyBTUDcwMjEgcmVxdWlyZXMgd2F0Y2hk
b2cgdGltZXIgc3VwcG9ydC4NCj4gPj4+IEFkZCB3YXRjaGRvZyBkcml2ZXIgdG8gZW5hYmxlIHRo
aXMuDQo+ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogWGlhbnRhbyBIdSA8eHQuaHVAY3FwbHVz
MS5jb20+DQo+ID4+PiAtLS0NCj4gPj4+ICsNCj4gPj4+ICsJcHJpdi0+YmFzZSA9IGRldm1fcGxh
dGZvcm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gPj4+ICsJaWYgKElTX0VSUihwcml2
LT5iYXNlKSkNCj4gPj4+ICsJCXJldHVybiBQVFJfRVJSKHByaXYtPmJhc2UpOw0KPiA+Pj4gKw0K
PiA+Pj4gKwkvKiBUaGUgcmVnaXN0ZXJzIGFjY2Vzc2VkIGhlcmUgc2hhcmVkIGJ5IG11bHRpcGxl
IGRyaXZlcnMuICovDQo+ID4+PiArCXdkdF9yZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2UocGRl
diwgSU9SRVNPVVJDRV9NRU0sIDEpOw0KPiA+Pg0KPiA+PiBUaGlzIGlzIHVudXN1YWwuIFdoeSB3
b3VsZCBvdGhlciBkcml2ZXJzIGFjY2VzcyBXRFRfQ1RSTCBhbmQgV0RUX0NOVCByZWdpc3RlcnMs
IGFuZCBob3cgaXMgaXQNCj4gPj4gZW5zdXJlZCB0aGF0IHRoZSBvdGhlciBkcml2ZXJzIGRvIG5v
dCBpbnRlcmZlciB3aXRoIHRoZSBhY2Nlc3NlcyBieSB0aGlzIGRyaXZlciA/DQo+ID4+DQo+ID4+
IE5vcm1hbGx5IHN1Y2ggYSByZXNvdXJjZSB3b3VsZCBiZSBzaGFyZWQgdGhyb3VnaCBhIHBhcmVu
dCBkcml2ZXIgd2l0aCBhcHByb3ByaWF0ZSBhY2Nlc3MgZnVuY3Rpb25zDQo+IHRvDQo+ID4+IGVu
c3VyZSB0aGF0IGFjY2Vzc2VzIGFyZSBzeW5jaHJvbml6ZWQuDQo+ID4+DQo+ID4NCj4gPiBUaGUg
cmVnaXN0ZXIgdXNlZCBieSB0aGlzIGRyaXZlciBjb25zaXN0cyBvZiB0d28gcGFydHMuIFRoZSBm
aXJzdCBwYXJ0IHdoaWNoIGNvbnRhaW5zIFdEVF9DVFJMIGFuZA0KPiBXRFRfQ05UDQo+ID4gcmVn
aXN0ZXJzIGlzIGV4Y2x1c2l2ZSBieSB3YXRjaGRvZy4NCj4gPiBJbiBzcGVjaWFsbHksIHRoZSBz
ZWNvbmQgcGFydCBpcyBiZWxvbmcgdG8gYSBtdWx0aWZ1bmN0aW9uYWwgcmVnaXN0ZXIgZ3JvdXAg
d2hpY2ggY29udHJvbCBJUCBhbmQgYnVzLg0KPiBSZWZlciB0bw0KPiA+IHJlZ2lzdGVyIG1hbnVh
bCBiZWxvdzoNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gTU8xX1NU
Q19XREdfUlNUX0VOCTQJUlcJCVNUQyBXYXRjaGRvZyBUaW1lb3V0IFRyaWdnZXIgU3lzdGVtIFJl
c2V0IEVuYWJsZQ0KPiA+IAkJCQkJCQkJCTA6IFNUQyB3YXRjaGRvZyAyIHRpbWVvdXQgd2lsbCBu
b3QgdHJpZ2dlciBzeXN0ZW0NCj4gcmVzZXQoZGVmYXVsdCkNCj4gPiAJCQkJCQkJCQkxOiBTVEMg
d2F0Y2hkb2cgMiB0aW1lb3V0IHdpbGwgdHJpZ2dlciBzeXN0ZW0gcmVzZXQNCj4gPiBNTzFfUklf
V0RHX1JTVF9FTgkJMQlSVwkJUkJVUyBXYXRjaGRvZyBUaW1lb3V0IFRyaWdnZXIgU3lzdGVtIFJl
c2V0IEVuYWJsZQ0KPiA+IAkJCQkJCQkJCTA6IFJCVVMgd2F0Y2hkb2cgdGltZW91dCB3aWxsIG5v
dCB0cmlnZ2VyIHN5c3RlbQ0KPiByZXNldChkZWZhdWx0KQ0KPiA+IAkJCQkJCQkJCTE6IFJCVVMg
d2F0Y2hkb2cgdGltZW91dCB3aWxsIHRyaWdnZXIgc3lzdGVtIHJlc2V0DQo+ID4gTU8xX1RJTUVS
X1NUQU5EX0JZX0VOCTAJUlcJCVRpbWVyIFN0YW5kYnkgTW9kZSBFbmFibGUNCj4gPiAJCQkJCQkJ
CQkwOiBEaXNhYmxlIChkZWZhdWx0KQ0KPiA+IAkJCQkJCQkJCTE6IEVuYWJsZSBBY3RpdmUgaGln
aCB0byBlbnRlciB0aW1lciBzdGFuZGJ5IG1vZGUsDQo+ID4gCQkJCQkJCQkJCQlkZWZhdWx0IG5v
dCBpbiBzdGFuZGJ5IG1vZGUNCj4gPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+
ID4gWW91IGNhbiBzZWUgdGhhdCBpbiBhZGRpdGlvbiB0byB0aGUgYml0cyBmb3Igd2F0Y2hkb2cg
dGhlcmUgYXJlIGJpdCBmaWVsZHMgZm9yIG90aGVyIG1vZHVsZXMuDQo+ID4gSSB1c2UgdGhpcyBy
ZWdpc3RlciBiaXQ0IGFuZCBiaXQxLiBEZWZhdWx0IHZhbHVlIGlzIDAgdGhhdCB3YXRjaGRvZyBp
bnRlcm5hbCBpbnRlcnJ1cHQgc2lnbmFsIGNhbid0IHRyaWdnZXINCj4gc3lzdGVtDQo+ID4gYW5k
IFJCVVMgcmVzZXQuIEkgbmVlZCBzZXQgMSB3aGVuIHdhdGNoZG9nIHByb2JlLiBFYXJseSBJIGlt
cGxlbWVudCB0aGUgb3BlcmF0aW9uIGluDQo+ID4gYXJjaC9hcm0vbWFjaC1zdW5wbHVzL3NwNzAy
MS5jIGFuZCBjb25maWd1cmUgYnkgbWFjcm8uIEJ1dCBpbiBhcmNoL2FybTY0LCBkaXJlY3Rvcnkg
bWFjaC1YWFggaXMNCj4gcmVtb3ZlZC4NCj4gPiBTbyBJIHNvbHZlIGluIHRoaXMgd2F5LiBBbnkg
YmV0dGVyIHdheT8NCj4gPg0KPiBJZiB0aGUgcmVnaXN0ZXIgYXQgMHg5QzAwMDI3NCBpcyBhY2Nl
c3NlZCBieSBvdGhlciBkcml2ZXJzLCBhY2Nlc3Nlcw0KPiB0byBpdCBtdXN0IGJlIHByb3RlY3Rl
ZCBhZ2FpbnN0IGVhY2ggb3RoZXIgdG8gYXZvaWQgcmFjZSBjb25kaXRpb25zLg0KPiBIb3cgdG8g
ZG8gdGhhdCB3b3VsZCBiZSB1cCB0byB5b3UuDQo+IA0KSGkgR3VlbnRlciwNCg0KRnJvbSB0aGUg
cGVyc3BlY3RpdmUgb2Ygc29mdHdhcmUsIDB4OUMwMDAyNzQgaXMgb25seSBhY2Nlc3NlZCBkdXJp
bmcNCmRyaXZlciBwcm9iZS4gSWYgdGhlIGRyaXZlciBpcyBidWlsZC1pbiBhbmQgb25seSBvbmUg
Y29yZSBpcyBydW5uaW5nIGF0IGtlcm5lbCANCnN0YXJ0dXAuIFRoZXJlIGlzIG5vIGNvbXBldGl0
aW9uLg0KVGhlIG9ubHkgcG9zc2liaWxpdHkgb2YgYW4gZXJyb3IgaXMgdG8gY29tcGlsZSB0aGUg
ZHJpdmVyIGludG8gYSBtb2R1bGUuIEluIHRoaXMgDQpjYXNlLCB0aGUgcmVnaXN0ZXIgYXQgMHg5
QzAwMDI3NCBvZmZlciBNQVNLX0JJVFNbMzE6MTZdIHdoaWNoIHdyaXRlIHZhbGlkIA0KYml0IGZv
ciBlYWNoIExTQiAxNiBiaXRzLiBSZWZlciB0byB0aGUgZGVmaW5lIGluIGRyaXZlcjoNCiNkZWZp
bmUgTUFTS19TRVQobWFzaykJCSgobWFzaykgfCAobWFzayA8PCAxNikpDQpFdmVuIGlmIGJvdGgg
ZHJpdmVycyBhY2Nlc3MgdGhlIHJlZ2lzdGVyIGF0IHRoZSBzYW1lIHRpbWUsIHRoZSBpbnN0cnVj
dGlvbnMgYXJlIA0KZXhlY3V0ZWQgaW4gb3JkZXIgb24gdGhlIFJCVVMuIFNvIGFzIGxvbmcgYXMg
dGhlIHNhbWUgYml0IGluIHRoZSBzYW1lIHJlZ2lzdGVyIA0KaXMgbm90IGFjY2Vzc2VkIGF0IHRo
ZSBzYW1lIHRpbWUsIG5vIGVycm9yIHdpbGwgb2NjdXIuDQoNCkJlc3QgUmVnYXJkcywNClhpYW50
YW8NCg0KPiBHdWVudGVyDQo=
