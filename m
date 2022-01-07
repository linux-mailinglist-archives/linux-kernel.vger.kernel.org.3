Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92650487EE1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 23:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbiAGWSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 17:18:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:41302 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230355AbiAGWSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 17:18:34 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-309-9B2oZdVrNoiElpUy5pZb3A-1; Fri, 07 Jan 2022 22:18:31 +0000
X-MC-Unique: 9B2oZdVrNoiElpUy5pZb3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Fri, 7 Jan 2022 22:18:30 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Fri, 7 Jan 2022 22:18:30 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        Pintu Agarwal <pintu.ping@gmail.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
CC:     Cyrill Gorcunov <gorcunov@gmail.com>,
        Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>,
        Linux API <linux-api@vger.kernel.org>
Subject: RE: [PATCH] sysinfo: include availram field in sysinfo struct
Thread-Topic: [PATCH] sysinfo: include availram field in sysinfo struct
Thread-Index: AQHYA+fIixjnSb16cEG6DC0DSDaBB6xYIBog
Date:   Fri, 7 Jan 2022 22:18:30 +0000
Message-ID: <c6abe87e4c284248985ea039428ab3fe@AcuMS.aculab.com>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain>
 <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
 <Ydcmk+WaBWKlLkAw@grain> <20220107120451.z2eqru2tm5mlhla3@wittgenstein>
 <CAOuPNLiJZu_HJQ+Hf5BJOgmT+v7DT96VLkiXrfx0MJQrkD3rSw@mail.gmail.com>
 <91d662f1-baf6-1114-f237-a66ebc164009@suse.cz>
In-Reply-To: <91d662f1-baf6-1114-f237-a66ebc164009@suse.cz>
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

PiA+IFRoZXNlIGFyZSB0aGUgaGVhZGVyIGNoYW5nZXMgZm9yIHF1aWNrIGxvb2s6DQo+ID4ge3t7
DQo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9zeXNpbmZvLmggYi9pbmNsdWRl
L3VhcGkvbGludXgvc3lzaW5mby5oDQo+ID4gaW5kZXggNmU3N2U5MC4uZmU4NGM2YSAxMDA2NDQN
Cj4gPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvc3lzaW5mby5oDQo+ID4gKysrIGIvaW5jbHVk
ZS91YXBpL2xpbnV4L3N5c2luZm8uaA0KPiA+IEBAIC0xMiw3ICsxMiw2IEBAIHN0cnVjdCBzeXNp
bmZvIHsNCj4gPiAgICAgICAgIF9fa2VybmVsX3Vsb25nX3QgZnJlZXJhbTsgICAgICAgLyogQXZh
aWxhYmxlIG1lbW9yeSBzaXplICovDQo+ID4gICAgICAgICBfX2tlcm5lbF91bG9uZ190IHNoYXJl
ZHJhbTsgICAgIC8qIEFtb3VudCBvZiBzaGFyZWQgbWVtb3J5ICovDQo+ID4gICAgICAgICBfX2tl
cm5lbF91bG9uZ190IGJ1ZmZlcnJhbTsgICAgIC8qIE1lbW9yeSB1c2VkIGJ5IGJ1ZmZlcnMgKi8N
Cj4gPiAtICAgICAgIF9fa2VybmVsX3Vsb25nX3QgYXZhaWxyYW07ICAgICAgLyogTWVtb3J5IGF2
YWlsYWJsZSBmb3IgYWxsb2NhdGlvbiAqLw0KPiA+ICAgICAgICAgX19rZXJuZWxfdWxvbmdfdCB0
b3RhbHN3YXA7ICAgICAvKiBUb3RhbCBzd2FwIHNwYWNlIHNpemUgKi8NCj4gPiAgICAgICAgIF9f
a2VybmVsX3Vsb25nX3QgZnJlZXN3YXA7ICAgICAgLyogc3dhcCBzcGFjZSBzdGlsbCBhdmFpbGFi
bGUgKi8NCj4gPiAgICAgICAgIF9fdTE2IHByb2NzOyAgICAgICAgICAgICAgICAgICAgLyogTnVt
YmVyIG9mIGN1cnJlbnQgcHJvY2Vzc2VzICovDQo+ID4gQEAgLTIwLDcgKzE5LDggQEAgc3RydWN0
IHN5c2luZm8gew0KPiA+ICAgICAgICAgX19rZXJuZWxfdWxvbmdfdCB0b3RhbGhpZ2g7ICAgICAv
KiBUb3RhbCBoaWdoIG1lbW9yeSBzaXplICovDQo+ID4gICAgICAgICBfX2tlcm5lbF91bG9uZ190
IGZyZWVoaWdoOyAgICAgIC8qIEF2YWlsYWJsZSBoaWdoIG1lbW9yeSBzaXplICovDQo+ID4gICAg
ICAgICBfX3UzMiBtZW1fdW5pdDsgICAgICAgICAgICAgICAgIC8qIE1lbW9yeSB1bml0IHNpemUg
aW4gYnl0ZXMgKi8NCj4gPiAtICAgICAgIGNoYXIgX2ZbMjAtMipzaXplb2YoX19rZXJuZWxfdWxv
bmdfdCktc2l6ZW9mKF9fdTMyKV07ICAgLyoNCj4gPiBQYWRkaW5nOiBsaWJjNSB1c2VzIHRoaXMu
LiAqLw0KPiA+ICsgICAgICAgX19rZXJuZWxfdWxvbmdfdCBhdmFpbHJhbTsgICAgICAvKiBNZW1v
cnkgYXZhaWxhYmxlIGZvciBhbGxvY2F0aW9uICovDQo+ID4gKyAgICAgICBjaGFyIF9mWzIwLTMq
c2l6ZW9mKF9fa2VybmVsX3Vsb25nX3QpLXNpemVvZihfX3UzMildOyAgIC8qDQo+ID4gUGFkZGlu
ZzogbGliYzUgdXNlcyB0aGlzLi4gKi8NCj4gPiAgfTsNCj4gPiB9fX0NCj4gPg0KPiA+IElmIHRo
aXMgaXMgZmluZSwgSSB3aWxsIHB1c2ggdGhlIG5ldyBwYXRjaCBzZXQuDQo+IA0KPiBQbGVhc2Ug
Q0MgbGludXgtYXBpQHZnZXIua2VybmVsLm9yZyBvbiB0aGUgbmV3IHBvc3RpbmcuDQoNClRoYXQg
aXMgcHJvYmFibHkgc3RpbGwgYnJva2VuLg0KSWYgX19rZXJuZWxfdWxvbmdfdCBpcyA2NGJpdCB0
aGVyZSBpcyBhcmNoaXRlY3R1cmUNCmRlcGVuZGFudCBwYWRkaW5nIGFmdGVyIG1lbV91bml0Lg0K
DQpJbiBwYXJ0aWN1bGFyIGEgMzJiaXQgeDg2IGFwcCBydW5uaW5nIG9uIGEgNjRiaXQga2VybmVs
DQp3aWxsIHByb2JhYmx5IHNlZSB0aGUgd3JvbmcgbGF5b3V0Lg0KDQpZb3UgZGVmaW5pdGVseSBu
ZWVkIGEgY29tcGlsZS10aW1lIGFzc2VydCBvbiB0aGUgdG90YWwgc3RydWN0dXJlIHNpemUuDQoN
CglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwg
TW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzog
MTM5NzM4NiAoV2FsZXMpDQo=

