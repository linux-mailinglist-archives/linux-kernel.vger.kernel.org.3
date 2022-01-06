Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFB64868E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:42:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242189AbiAFRmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:42:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151]:31064 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242165AbiAFRmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:42:07 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-178-0nBXEbIUPNqqgpk94EfVKQ-1; Thu, 06 Jan 2022 17:41:59 +0000
X-MC-Unique: 0nBXEbIUPNqqgpk94EfVKQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Thu, 6 Jan 2022 17:41:59 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Thu, 6 Jan 2022 17:41:59 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Pintu Agarwal' <pintu.ping@gmail.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>
CC:     Pintu Kumar <quic_pintu@quicinc.com>,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "christian.brauner@ubuntu.com" <christian.brauner@ubuntu.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "legion@kernel.org" <legion@kernel.org>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "chris.hyser@oracle.com" <chris.hyser@oracle.com>,
        "ccross@google.com" <ccross@google.com>,
        "pcc@google.com" <pcc@google.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "caoxiaofeng@yulong.com" <caoxiaofeng@yulong.com>,
        "david@redhat.com" <david@redhat.com>
Subject: RE: [PATCH] sysinfo: include availram field in sysinfo struct
Thread-Topic: [PATCH] sysinfo: include availram field in sysinfo struct
Thread-Index: AQHYAx1/ixjnSb16cEG6DC0DSDaBB6xWQlhg
Date:   Thu, 6 Jan 2022 17:41:59 +0000
Message-ID: <14316cf852784a32b5214119a9d976cf@AcuMS.aculab.com>
References: <1641483250-18839-1-git-send-email-quic_pintu@quicinc.com>
 <YdcUttZWaqYQpR1K@grain>
 <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
In-Reply-To: <CAOuPNLifYFPU4Gt2+1sOSsYNNLQq7U2aGVaYknrhaMc-CVx8vg@mail.gmail.com>
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

RnJvbTogUGludHUgQWdhcndhbA0KPiBTZW50OiAwNiBKYW51YXJ5IDIwMjIgMTY6NTANCj4gDQo+
IE9uIFRodSwgNiBKYW4gMjAyMiBhdCAyMTo0MSwgQ3lyaWxsIEdvcmN1bm92IDxnb3JjdW5vdkBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gVGh1LCBKYW4gMDYsIDIwMjIgYXQgMDk6MDQ6
MTBQTSArMDUzMCwgUGludHUgS3VtYXIgd3JvdGU6DQo+ID4gPiBUaGUgc3lzaW5mbyBtZW1iZXIg
ZG9lcyBub3QgaGF2ZSBhbnkgImF2YWlsYWJsZSByYW0iIGZpZWxkIGFuZA0KPiA+ID4gdGhlIGJ1
ZmZlcnJhbSBmaWVsZCBpcyBub3QgbXVjaCBoZWxwZnVsIGVpdGhlciwgdG8gZ2V0IGEgcm91Z2gN
Cj4gPiA+IGVzdGltYXRlIG9mIGF2YWlsYWJsZSByYW0gbmVlZGVkIGZvciBhbGxvY2F0aW9uLg0K
PiA+ID4NCj4gPiA+IE9uZSBuZWVkcyB0byBwYXJzZSBNZW1BdmFpbGFibGUgZmllbGQgc2VwYXJh
dGVseSBmcm9tIC9wcm9jL21lbWluZm8NCj4gPiA+IHRvIGdldCB0aGlzIGluZm8gaW5zdGVhZCBv
ZiBkaXJlY3RseSBnZXR0aW5nIGlmIGZyb20gc3lzaW5mbyBpdHNlbGYuDQo+ID4gPg0KPiA+ID4g
VGh1cywgdGhpcyBwYXRjaCBpbnRyb2R1Y2UgYSBuZXcgZmllbGQgYXMgYXZhaWxyYW0gaW4gc3lz
aW5mbw0KPiA+ID4gc28gdGhhdCBhbGwgdGhlIGluZm8gdG90YWwvZnJlZS9hdmFpbGFibGUgY2Fu
IGJlIHJldHJpZXZlZCBmcm9tDQo+ID4gPiBvbmUgcGxhY2UgaXRzZWxmLg0KPiA+ID4NCj4gPiA+
IFRoZXJlIGFyZSBjb3VwbGUgb2YgcGxhY2VzIGluIGtlcm5lbCBhcyB3ZWxsIHdoZXJlIHRoaXMg
Y2FuIGJlIGltcHJvdmVkLg0KPiA+ID4gRm9yIGV4YW1wbGU6DQo+ID4gPiBJbiBmcy9wcm9jL21l
bWluZm8uYzoNCj4gPiA+IG1lbWluZm9fcHJvY19zaG93Og0KPiA+ID4gICAgc2lfbWVtaW5mbygm
aSk7DQo+ID4gPiAgICBhdmFpbGFibGUgPSBzaV9tZW1fYXZhaWxhYmxlKCk7DQo+ID4gPiBOb3cg
d2l0aCB0aGlzIGNoYW5nZSB0aGUgc2Vjb25kIGNhbGwgYmUgYXZvaWRlZC4NCj4gPiA+IFRodXMs
IHdlIGNhbiBkaXJlY3RseSBkbzoNCj4gPiA+IHNob3dfdmFsX2tiKG0sICJNZW1BdmFpbGFibGU6
ICAgIiwgaS5hdmFpbHJhbSk7DQo+ID4gPg0KPiA+ID4gTm90ZSwgdGhpcyBhbHNvIHJlcXVpcmVz
IHVwZGF0ZSBpbiBwcm9jZnMgZm9yIGZyZWUgYW5kIG90aGVyIGNvbW1hbmRzLg0KPiA+ID4gTGlr
ZSBpbiBmcmVlIGNvbW1hbmQgYXMgd2VsbCB3ZSBmcmlzdCBjYWxsIHN5c2luZm8gdGhlbiBhZ2Fp
biBwYXJzZQ0KPiA+ID4gL3Byb2MvbWVtaW5mbyB0byBnZXQgYXZhaWxhYmxlIGZpZWxkLg0KPiA+
ID4gVGhpcyBjYW4gYmUgYXZvaWRlZCB0b28gd2l0aCBoaWdoZXIga2VybmVsIHZlcnNpb24uDQo+
ID4gPg0KPiA+ID4gQSBzYW1wbGUgb3V0cHV0IHdpdGggc2luZ2xlIHN5c2luZm8gY2FsbCBpcyBz
aG93biBiZWxvdzoNCj4gPiA+IFRvdGFsIFJBTTogMjQ4Mzc2IGtCDQo+ID4gPiAgRnJlZSBSQU06
IDIzMTU0MCBrQg0KPiA+ID4gQXZhaWwgUkFNOiAyMzA0NDgga0INCj4gPiA+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBQaW50dSBLdW1hciA8cXVpY19waW50dUBxdWljaW5jLmNvbT4NCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IFBpbnR1IEFnYXJ3YWwgPHBpbnR1LnBpbmdAZ21haWwuY29tPg0KPiA+ID4g
LS0tDQo+ID4gPiAgaW5jbHVkZS91YXBpL2xpbnV4L3N5c2luZm8uaCB8IDEgKw0KPiA+ID4gIGtl
cm5lbC9zeXMuYyAgICAgICAgICAgICAgICAgfCA0ICsrKysNCj4gPiA+ICBtbS9wYWdlX2FsbG9j
LmMgICAgICAgICAgICAgIHwgMiArKw0KPiA+ID4gIDMgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51eC9zeXNp
bmZvLmggYi9pbmNsdWRlL3VhcGkvbGludXgvc3lzaW5mby5oDQo+ID4gPiBpbmRleCA0MzVkNWMy
Li42ZTc3ZTkwIDEwMDY0NA0KPiA+ID4gLS0tIGEvaW5jbHVkZS91YXBpL2xpbnV4L3N5c2luZm8u
aA0KPiA+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3N5c2luZm8uaA0KPiA+ID4gQEAgLTEy
LDYgKzEyLDcgQEAgc3RydWN0IHN5c2luZm8gew0KPiA+ID4gICAgICAgX19rZXJuZWxfdWxvbmdf
dCBmcmVlcmFtOyAgICAgICAvKiBBdmFpbGFibGUgbWVtb3J5IHNpemUgKi8NCj4gPiA+ICAgICAg
IF9fa2VybmVsX3Vsb25nX3Qgc2hhcmVkcmFtOyAgICAgLyogQW1vdW50IG9mIHNoYXJlZCBtZW1v
cnkgKi8NCj4gPiA+ICAgICAgIF9fa2VybmVsX3Vsb25nX3QgYnVmZmVycmFtOyAgICAgLyogTWVt
b3J5IHVzZWQgYnkgYnVmZmVycyAqLw0KPiA+ID4gKyAgICAgX19rZXJuZWxfdWxvbmdfdCBhdmFp
bHJhbTsgICAgICAvKiBNZW1vcnkgYXZhaWxhYmxlIGZvciBhbGxvY2F0aW9uICovDQo+ID4gPiAg
ICAgICBfX2tlcm5lbF91bG9uZ190IHRvdGFsc3dhcDsgICAgIC8qIFRvdGFsIHN3YXAgc3BhY2Ug
c2l6ZSAqLw0KPiA+ID4gICAgICAgX19rZXJuZWxfdWxvbmdfdCBmcmVlc3dhcDsgICAgICAvKiBz
d2FwIHNwYWNlIHN0aWxsIGF2YWlsYWJsZSAqLw0KPiA+ID4gICAgICAgX191MTYgcHJvY3M7ICAg
ICAgICAgICAgICAgICAgICAvKiBOdW1iZXIgb2YgY3VycmVudCBwcm9jZXNzZXMgKi8NCj4gPg0K
PiA+IEhpISBTb3JyeSwgYnV0IEkgZG9uJ3QgdW5kZXJzdGFuZCAtLSB0aGUgc3lzaW5mbyBzdHJ1
Y3R1cmUgc2VlbXMgdG8NCj4gPiBiZSBwYXJ0IG9mIHVzZXIgQVBJLCBubz8gRG9uJ3Qgd2UgYnJl
YWsgaXQgdXAgaGVyZT8NCj4gDQo+IFllcywgdGhlIGNvcnJlc3BvbmRpbmcgdXNlciBzcGFjZSBo
ZWFkZXIgL3Vzci9pbmNsdWRlL2xpbnV4L3N5c2luZm8uaA0KPiBhbHNvIG5lZWRzIHRvIGJlIHVw
ZGF0ZWQuDQo+IFdoZW4gd2UgZ2VuZXJhdGUgdGhlIGtlcm5lbCBoZWFkZXIgaXQgd2lsbCBiZSB1
cGRhdGVkIGF1dG9tYXRpY2FsbHkuDQoNCllvdSBjYW4ndCBhZGQgYSBmaWVsZCBpbiB0aGUgbWlk
ZGxlIG9mIGEgVUFQSSBzdHJ1Y3R1cmUuDQpJdCBicmVha3MgY29tcGF0aWJpbGl0eSBmb3Igb2xk
IGJpbmFyaWVzLg0KDQpEZXBlbmRpbmcgb24gdGhlIGludGVyZmFjZSBkZWZpbml0aW9uIHlvdSBt
YXkgYmUgYWJsZSB0byBhZGQgb25lIGF0IHRoZSBlbmQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3Rl
cmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtl
eW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

