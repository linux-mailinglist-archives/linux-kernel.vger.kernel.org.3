Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7DCD4886C8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 23:35:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234956AbiAHWfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 17:35:32 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:33901 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229899AbiAHWfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 17:35:30 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-273-98gkTIwGNSu2nY5srYZbTQ-1; Sat, 08 Jan 2022 22:35:25 +0000
X-MC-Unique: 98gkTIwGNSu2nY5srYZbTQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Sat, 8 Jan 2022 22:35:24 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Sat, 8 Jan 2022 22:35:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pintu Agarwal' <pintu.ping@gmail.com>
CC:     Pintu Kumar <quic_pintu@quicinc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>
Subject: RE: [PATCH v2] sysinfo: include availram field in sysinfo struct
Thread-Topic: [PATCH v2] sysinfo: include availram field in sysinfo struct
Thread-Index: AQHYA/GqnIwLmHPdn0+moS7Mf5DX3axYIclAgAE2xoCAAF134A==
Date:   Sat, 8 Jan 2022 22:35:24 +0000
Message-ID: <5aa1e8c55cf84436b35ee5557a508e8d@AcuMS.aculab.com>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <1641578854-14232-1-git-send-email-quic_pintu@quicinc.com>
 <19cce51e24584c2a8090b618c580a0bd@AcuMS.aculab.com>
 <CAOuPNLh-WLxJ7w=_C7zKXArgZLbO7OahHHhuwAyN9E1yZvNTdQ@mail.gmail.com>
In-Reply-To: <CAOuPNLh-WLxJ7w=_C7zKXArgZLbO7OahHHhuwAyN9E1yZvNTdQ@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogUGludHUgQWdhcndhbA0KPiBTZW50OiAwOCBKYW51YXJ5IDIwMjIgMTY6NTMNCj4gDQo+
IE9uIFNhdCwgOCBKYW4gMjAyMiBhdCAwMzo1MiwgRGF2aWQgTGFpZ2h0IDxEYXZpZC5MYWlnaHRA
YWN1bGFiLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBQaW50dSBLdW1hcg0KPiA+ID4gU2Vu
dDogMDcgSmFudWFyeSAyMDIyIDE4OjA4DQo+ID4gPg0KPiA+ID4gVGhlIHN5c2luZm8gbWVtYmVy
IGRvZXMgbm90IGhhdmUgYW55ICJhdmFpbGFibGUgcmFtIiBmaWVsZCBhbmQNCj4gPiA+IHRoZSBi
dWZmZXJyYW0gZmllbGQgaXMgbm90IG11Y2ggaGVscGZ1bCBlaXRoZXIsIHRvIGdldCBhIHJvdWdo
DQo+ID4gPiBlc3RpbWF0ZSBvZiBhdmFpbGFibGUgcmFtIG5lZWRlZCBmb3IgYWxsb2NhdGlvbi4N
Cj4gPiA+DQo+ID4gPiBPbmUgbmVlZHMgdG8gcGFyc2UgTWVtQXZhaWxhYmxlIGZpZWxkIHNlcGFy
YXRlbHkgZnJvbSAvcHJvYy9tZW1pbmZvDQo+ID4gPiB0byBnZXQgdGhpcyBpbmZvIGluc3RlYWQg
b2YgZGlyZWN0bHkgZ2V0dGluZyBpZiBmcm9tIHN5c2luZm8gaXRzZWxmLg0KPiA+ID4NCj4gPiA+
IFRodXMsIHRoaXMgcGF0Y2ggaW50cm9kdWNlIGEgbmV3IGZpZWxkIGFzIGF2YWlscmFtIGluIHN5
c2luZm8NCj4gPiA+IHNvIHRoYXQgYWxsIHRoZSBpbmZvIHRvdGFsL2ZyZWUvYXZhaWxhYmxlIGNh
biBiZSByZXRyaWV2ZWQgZnJvbQ0KPiA+ID4gb25lIHBsYWNlIGl0c2VsZi4NCj4gPiA+DQo+ID4g
Li4uDQo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3N5c2luZm8uaCBiL2lu
Y2x1ZGUvdWFwaS9saW51eC9zeXNpbmZvLmgNCj4gPiA+IGluZGV4IDQzNWQ1YzIuLmZlODRjNmEg
MTAwNjQ0DQo+ID4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvc3lzaW5mby5oDQo+ID4gPiAr
KysgYi9pbmNsdWRlL3VhcGkvbGludXgvc3lzaW5mby5oDQo+ID4gPiBAQCAtMTksNyArMTksOCBA
QCBzdHJ1Y3Qgc3lzaW5mbyB7DQo+ID4gPiAgICAgICBfX2tlcm5lbF91bG9uZ190IHRvdGFsaGln
aDsgICAgIC8qIFRvdGFsIGhpZ2ggbWVtb3J5IHNpemUgKi8NCj4gPiA+ICAgICAgIF9fa2VybmVs
X3Vsb25nX3QgZnJlZWhpZ2g7ICAgICAgLyogQXZhaWxhYmxlIGhpZ2ggbWVtb3J5IHNpemUgKi8N
Cj4gPiA+ICAgICAgIF9fdTMyIG1lbV91bml0OyAgICAgICAgICAgICAgICAgLyogTWVtb3J5IHVu
aXQgc2l6ZSBpbiBieXRlcyAqLw0KPiA+ID4gLSAgICAgY2hhciBfZlsyMC0yKnNpemVvZihfX2tl
cm5lbF91bG9uZ190KS1zaXplb2YoX191MzIpXTsgICAvKiBQYWRkaW5nOiBsaWJjNSB1c2VzIHRo
aXMuLiAqLw0KPiA+DQo+ID4gVGhlcmUgYXJlIDQgcGFkIGJ5dGVzIGhlcmUgb24gbW9zdCA2NGJp
dCBhcmNoaXRlY3R1cmVzLg0KPiA+DQo+ID4gPiArICAgICBfX2tlcm5lbF91bG9uZ190IGF2YWls
cmFtOyAgICAgIC8qIE1lbW9yeSBhdmFpbGFibGUgZm9yIGFsbG9jYXRpb24gKi8NCj4gPiA+ICsg
ICAgIGNoYXIgX2ZbMjAtMypzaXplb2YoX19rZXJuZWxfdWxvbmdfdCktc2l6ZW9mKF9fdTMyKV07
ICAgLyogUGFkZGluZzogbGliYzUgdXNlcyB0aGlzLi4gKi8NCj4gPiA+ICB9Ow0KPiA+DQo+ID4g
WW91J3ZlIG5vdCBjb21waWxlLXRpbWUgdGVzdGVkIHRoZSBzaXplIG9mIHRoZSBzdHJ1Y3R1cmUu
DQo+ID4NCj4gV2l0aCAiMzIiIGluc3RlYWQgb2YgIjIwIiBpbiBwYWRkaW5nIEkgZ2V0IHRoZXNl
IHNpemUgb2Ygc3lzaW5mbzoNCj4gSW4geDg2LTY0IGtlcm5lbCwgd2l0aCBhcHAgNjQtYml0OiBT
aXplIG9mIHN5c2luZm8gPSAxMjgNCj4gSW4geDg2LTY0IGtlcm5lbCwgd2l0aCBhcHAgMzItYml0
OjogU2l6ZSBvZiBzeXNpbmZvID0gNzYNCj4gSW4gYXJtLTY0IGtlcm5lbCwgd2l0aCBhcHAgMzIt
Yml0OiBTaXplIG9mIHN5c2luZm8gPSA3Ng0KDQpZb3UgbmVlZCB0byBjb21wYXJlIHRoZSBzaXpl
cyBiZWZvcmUgYW5kIGFmdGVyIHlvdXIgcGF0Y2gNCnRvIGVuc3VyZSBpdCBkb2Vzbid0IGNoYW5n
ZSBvbiBhbnkgYXJjaGl0ZWN0dXJlLg0KDQo+IE9rYXkgdGhlIHN5cyByb2JvdCByZXBvcnRlZCBz
b21lIGlzc3VlIGluIDY0LWJpdCBidWlsZC4NCj4ge3t7DQo+ID4+IGluY2x1ZGUvdWFwaS9saW51
eC9zeXNpbmZvLmg6MjM6MTQ6IGVycm9yOiBzaXplIG9mIGFycmF5ICdfZicgaXMgdG9vIGxhcmdl
DQo+ID4+ICAgIDIzIHwgICAgICAgICBjaGFyIF9mWzIwLTMqc2l6ZW9mKF9fa2VybmVsX3Vsb25n
X3QpLXNpemVvZihfX3UzMildOyAgIC8qIFBhZGRpbmc6IGxpYmM1IHVzZXMNCj4gdGhpcy4uICov
DQo+ID4+ICAgICAgIHwgICAgICAgICAgICAgIF5+DQo+IH19fQ0KPiANCj4gQWxzbywgSSBnb3Qg
dGhlIHNhbWUgaXNzdWUgd2hpbGUgYnVpbGRpbmcgZm9yIGFybTY0LCBzbyBJIHRyaWVkIHRvDQo+
IGFkanVzdCBsaWtlIHRoaXM6DQo+IGNoYXIgX2ZbMzItMypzaXplb2YoX19rZXJuZWxfdWxvbmdf
dCktc2l6ZW9mKF9fdTMyKV07DQo+IA0KPiBXaXRoIHRoaXMgdGhlIGJ1aWxkIHdvcmtzIG9uIGJv
dGggMzIvNjQgYnV0IG91dHB1dCBmYWlscyB3aGVuIHJ1bm5pbmcNCj4gMzItYml0IHByb2dyYW0g
b24gNjQtYml0IGtlcm5lbC4NCj4gQWxzbywgdGhlIGZyZWUgY29tbWFuZCBvbiA2NC1iaXQgcmVw
b3J0cyAic3RhY2sgc21hc2hpbmcgZXJyb3IiLi4NCj4gDQo+IEhvdyBkbyB3ZSByZXNvbHZlIHRo
aXMgaXNzdWUgdG8gbWFrZSBpdCB3b3JrIG9uIGJvdGggYXJjaCA/DQo+IEFsc28sIEkgZG9uJ3Qg
cmVhbGx5IHVuZGVyc3RhbmQgdGhlIHNpZ25pZmljYW5jZSBvZiB0aGF0IG51bWJlciAiMjAiDQo+
IGluIHBhZGRpbmcgPw0KDQpNeSBndWVzcyBpcyB0aGF0IHNvbWVvbmUgYWRkZWQgYSBjaGFyIF9m
WzIwXSBwYWQgdG8gYWxsb3cgZm9yIGV4cGFuc2lvbi4NClRoZW4gdHdvIF9fa2VybmVsX3Vsb25n
X3QgYW5kIG9uZSBfX3UzMiBmaWVsZCB3ZXJlIGFkZGVkLCBzbyB0aGUNCnNpemUgb2YgdGhlIHBh
ZCB3YXMgcmVkdWNlZC4NCldoZW4gX19rZXJuZWxfdWxvbmdfdCBpcyA2NGJpdCB0aGVuIGl0IHNl
ZW1zIHRvIGJlIGNoYXIgX2ZbMF0NCi0gd2hpY2ggbWlnaHQgZ2VuZXJhdGUgYSBjb21waWxlIHdh
cm5pbmcgc2luY2UgeW91IGFyZSBzdXBwb3NlZA0KdG8gdXNlIGNoYXIgX2ZbXSB0byBpbmRpY2F0
ZSBhbiBleHRlbnNpYmxlIHN0cnVjdHVyZS4NClRoZXJlIGlzLCBob3dldmVyLCA0IGJ5dGVzIG9m
IHBhZCBhZnRlciB0aGUgX2ZbXSBvbiBtb3N0IDY0Yml0DQphcmNoaXRlY3R1cmVzLg0KDQpTbyBh
Y3R1YWxseSB0aGVyZSBpc24ndCBlbm91Z2ggc3BhY2UgdG8gYW55dGhpbmcgdXNlZnVsIGF0IGFs
bC4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBS
b2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9u
IE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

