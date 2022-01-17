Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493E9490099
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 04:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiAQDf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 22:35:27 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:37121 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbiAQDf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 22:35:26 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 20H3YAqC4007879, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 20H3YAqC4007879
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 17 Jan 2022 11:34:10 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 11:34:09 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 17 Jan 2022 11:34:09 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::a5c6:3ded:8fd8:286a]) by
 RTEXMBS01.realtek.com.tw ([fe80::a5c6:3ded:8fd8:286a%5]) with mapi id
 15.01.2308.020; Mon, 17 Jan 2022 11:34:09 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "yang.lee@linux.alibaba.com" <yang.lee@linux.alibaba.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] misc: rtsx: modify rtd3 flow
Thread-Topic: [PATCH] misc: rtsx: modify rtd3 flow
Thread-Index: AQHYCGrv53PrNO0bY0ew2A940nWAjKxgS6OAgAHF0KD//4hngIAAjolw//+/xwCABKG+0A==
Date:   Mon, 17 Jan 2022 03:34:09 +0000
Message-ID: <443ba7631c234a73822990fc8bf5fee5@realtek.com>
References: <c4525b4738f94483b9b8f8571fc80646@realtek.com>
 <CAAd53p6gzZVNov0L-abZ_N=FoD-JpfWp2W096SrVva=FfEv=aw@mail.gmail.com>
 <3bae27438b4b4d1eb367baefa7898060@realtek.com>
 <CAAd53p6GFqMbp-xMDf0qufxfpb8wes8S8VVdghZnNdV5Mr4s7w@mail.gmail.com>
 <ccb30393c86e42f489c2d7445e3534a9@realtek.com>
 <CAAd53p7nHqaKcZx7+asZz5k2jRJK-nJeCM21Nhvw6AeVE3=Qpw@mail.gmail.com>
In-Reply-To: <CAAd53p7nHqaKcZx7+asZz5k2jRJK-nJeCM21Nhvw6AeVE3=Qpw@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.97]
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEvMTcg5LiK5Y2IIDAxOjMwOjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWku
aGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgSmFudWFyeSAxNCwgMjAy
MiA4OjA5IFBNDQo+IFRvOiBSaWNreSBXVSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+IENjOiBh
cm5kQGFybmRiLmRlOyBncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZzsNCj4gY2hyaXN0b3BoZS5q
YWlsbGV0QHdhbmFkb28uZnI7IHlhbmcubGVlQGxpbnV4LmFsaWJhYmEuY29tOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1pc2M6IHJ0c3g6
IG1vZGlmeSBydGQzIGZsb3cNCj4gDQo+IE9uIEZyaSwgSmFuIDE0LCAyMDIyIGF0IDQ6NTEgUE0g
Umlja3kgV1UgPHJpY2t5X3d1QHJlYWx0ZWsuY29tPiB3cm90ZToNCj4gW3NuaXBdDQo+ID4gPiA+
DQo+ID4gPiA+IFdlIGRvbuKAmXQgd2FudCB0byBlbnRyeSBEMyBmcmVxdWVudGx5IFNvIHdlIG5l
ZWQgdG8gY2FsbA0KPiA+ID4gPiBwbV9ydW50aW1lX2dldCgpIGF0IHN0YXJ0IEFuZCBjYWxsIHBt
X3J1bnRpbWVfcHV0KCkgaW4gZGVsYXktd29yaw0KPiA+ID4gPiAocnRkM193b3JrKQ0KPiA+ID4N
Cj4gPiA+IE1heWJlIHVzZSAnY2FuY2VsX2RlbGF5ZWRfd29yaygmcGNyLT5ydGQzX3dvcmspJyBs
aWtlIHdoYXQNCj4gPiA+IHJ0c3hfcGNpX3J1bnRpbWVfc3VzcGVuZCgpIGRvZXM/DQo+ID4gPiBB
bmQgZm9yIHRoaXMgY2FzZSBtYXliZSBjYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoKSBpcyBtb3Jl
IHByZWZlcnJlZC4NCj4gPiA+DQo+ID4NCj4gPiBJIHRoaW5rIHlvdSBtaXN1bmRlcnN0YW5kIHdo
YXQgSSBtZWFucyBUaGlzIGRlbGF5X3dvcmsoKSBpcyBmb3Igbm90DQo+ID4gZW50ZXIgRDMgPC0+
IEQwIGZyZXF1ZW50bHkNCj4gDQo+IFRoaXMgaXMgZG9hYmxlIHdpdGggY3VycmVudCBwbV9ydW50
aW1lXyooKSBoZWxwZXJzLg0KPiANCj4gPiBUaGF0IGRlbGF5IGlzIHdlIG5lZWQsIHdlIGRvbuKA
mXQgd2FudCB0byBwb3dlcl9vbiBhbmQgcG93ZXJfb2ZmDQo+ID4gZnJlcXVlbnRseSBvbiBvdXIg
ZGV2aWNlDQo+IA0KPiBJcyB0aGlzIHRvIGF2b2lkIHRoZSBwbV9ydW50aW1lX3Jlc3VtZSgpIGNh
bGwgYmVmb3JlIHN5c3RlbSBzdXNwZW5kPw0KPiBJT1csIHRvIGF2b2lkIEQzIC0+IEQwIC0+IEQz
IGZvciBTMz8NCj4gDQoNCk5vLCB0aGlzIG9ubHkgZm9yIG1ha2Ugc3VyZSBvdXIgZGV2aWNlIEQw
IC0+IEQzIGF0IGxlYXN0IDEwIHNlYywgdGhpcyBvbmx5IGFib3V0IGRldmljZSBzdGF0dXMNCm5v
dCBhZmZlY3QgU3lzdGVtIHN1c3BlbmQgKFMzKQ0KWW91IGNhbiBzZWUgdGhlIGN1cnJlbnQgY29k
ZSBydHN4X3BjaV9pZGxlX3dvcmsoc3RydWN0IHdvcmtfc3RydWN0ICp3b3JrKQ0KDQpTeXN0ZW0g
c3VzcGVuZCAoUzMpIGZsb3cgaXMgZGlmZmVyZW50IGl0IHdpbGwgY2FsbCBydHN4X3BjaV9zdXNw
ZW5kKCkNCg0KPiA+DQo+ID4gVGhpcyBwYXRjaCB3YW50IHRvIHNvbHZlIHBjci0+aXNfcnVudGlt
ZV9zdXNwZW5kZWQgdGhpcyB2YWx1ZSBiZWNhdXNlDQo+ID4gd2UgbmVlZCB0byBzZXQgbW9yZSBy
ZWdpc3RlciBhdCBwb3dlcl9kb3duIGZsb3cgd2hlbiBEZXZpY2Ugc3VwcG9ydCBEMw0KPiA+IGFu
ZCBTeXN0ZW0gZ29pbmcgdG8gUzMNCj4gDQo+IFNvIGlzIGl0IHBvc3NpYmxlIHRvIGludHJvZHVj
ZSBhIG5ldyBwYXJhbWV0ZXIgZm9yIGZvcmNlX3Bvd2VyX2Rvd24oKSBhbmQgZ2V0DQo+IHJpZCBv
ZiBpc19ydW50aW1lX3N1c3BlbmRlZCBjb21wbGV0ZWx5Pw0KPiANCg0KVGhpcyBqdXN0IGRpc3Rp
bmd1aXNoIDUyNGEsIDUyNWEgZ28gdG8gdGhlIG5ldyBwb3dlciBkb3duIGZsb3cNCkFkZCBtb3Jl
IHJlZ2lzdGVyIHNldHRpbmcgZm9yIFJURDMgZW5hYmxlIA0KDQo+ID4NCj4gPiA+ID4NCj4gPiA+
ID4gQnV0IHdlIGZvdW5kIElmIHdlIGtlZXAgdGhpcyBpZiBzdGF0ZW1lbnQgaW4gc3RhcnRfcnVu
IGlmDQo+ID4gPiA+IChwY3ItPmlzX3J1bnRpbWVfc3VzcGVuZGVkKSB7DQo+ID4gPiA+ICAgcG1f
cnVudGltZV9nZXQoJihwY3ItPnBjaS0+ZGV2KSk7DQo+ID4gPiA+ICAgcGNyLT5pc19ydW50aW1l
X3N1c3BlbmRlZCA9IGZhbHNlOyB9DQo+ID4gPiA+IHBjci0+aXNfcnVudGltZV9zdXNwZW5kZWQg
dGhpcyBzdGF0dXMgYXJlIG5vdCBjb3JyZWN0IHdoZW4gZW50ZXINCj4gPiA+ID4gcGNyLT5TMw0K
PiA+ID4gPiBiZWNhdXNlIGVudGVyIFMzIG5vdCBjYWxsIHN0YXJ0X3J1bigpDQo+ID4gPg0KPiA+
ID4gTWF5YmUgYmVjYXVzZSB0aGUgZHJpdmVyIGlzIHRyeWluZyB0byB0cmljayB0aGUgcnVudGlt
ZSBQTSBjb3JlIG9uDQo+ID4gPiBpdHMgcmVhbCBwb3dlciBzdGF0dXM/DQo+ID4gPiBJLmUuIHRo
ZSBkcml2ZXIgaXMgbWFpbnRhaW5pbmcgaXRzIG93biBQTSBzdGF0ZSBtYWNoaW5lLiBGdWxseQ0K
PiA+ID4gY29vcGVyYXRpbmcgdGhlIGRyaXZlciB3aXRoIFBNIGNvcmUgc2hvdWxkIHNvbHZlIHRo
ZSBpc3N1ZS4NCj4gPiA+DQo+ID4NCj4gPiBTeXN0ZW0gbm90IGNhbGwgc3RhcnRfcnVuKCkgYmVj
YXVzZSBkbyBub3QgaGF2ZSBhbnkgc2RfcmVxdWVzdCBhdCB0aGF0DQo+ID4gdGltZSwgc28gd2Ug
bmVlZCB0byB1cGRhdGUgdmFsdWUocGNyLT5pc19ydW50aW1lX3N1c3BlbmRlZCkgYXQNCj4gPiBy
dHN4X3BjaV9ydW50aW1lX3Jlc3VtZSBidXQgaWYgd2Ugb25seSB1cGRhdGUgdmFsdWUgaGVyZSBu
b3QgdG8gY2FsbA0KPiA+IHBtX3J1bnRpbWVfZ2V0KCksIHRoZSBpZi1zdGF0ZW1lbnQgYWx3YXlz
IGJlIEZBTFNFIGF0IHN0YXJ0X3J1bigpDQo+IA0KPiBTb3VuZHMgbGlrZSB0aGUgUlBNIHJlZmNv
dW50IGdvZXMgdG8gemVybyBzbyBpdCB3YXMgcnVudGltZSBzdXNwZW5kZWQgYWdhaW4uDQo+IFRo
ZSBjb3JyZWN0IHVzYWdlIHNob3VsZCBiZSBtZXJnaW5nIHJ0c3hfcGNpX3N0YXJ0X3J1bigpIHdp
dGgNCj4gcnRzeF9wY2lfcnVudGltZV9yZXN1bWUoKSwgdGhlbiBndWFyZCBlYWNoIG9wIG9mIG1t
Y19ob3N0X29wcyB3aXRoDQo+IHBtX3J1bnRpbWVfZ2V0X3N5bmMoKSBhdCB0aGUgYmVnaW5uaW5n
IGFuZCBwbV9ydW50aW1lX2lkbGUoKSBhdCBhbmQgZW5kIG9mDQo+IGVhY2ggb3BzLg0KPiANCj4g
SW5jcmVhc2UgdGhlIFJQTSByZWZjb3VudCBpbiBydW50aW1lIHJlc3VtZSByb3V0aW5lIHRvIHBy
ZXZlbnQgdGhlIGRyaXZlcg0KPiBmcm9tIHN1c3BlbmRpbmcgZG9lc24ndCByZWFsbHkgbWFrZSBz
ZW5zZSB0byBtZS4NCj4gDQo+IEthaS1IZW5nDQoNCg0KV2Ugd2FudCB0byBjb250cm9sIHRoZSBp
bnRlcnZhbCB0aW1lIGJldHdlZW4gRDAtPkQzDQpUaGlzIGlzIGZvciBnb29kIHVzZXIgZXhwZXJp
ZW5jZSBhbmQgbW9yZSBzdGFibGUgZm9yIG91ciBkZXZpY2UuDQpBbmQgdGhpcyBjb21wbGV0ZWx5
IHVuYWZmZWN0ZWQgU3lzdGVtIHN1c3BlbmQsIGJlY2F1c2UgU3lzdGVtIHdhbnQgdG8gZW50ZXIg
UzMNCm5lZWQgdG8gbWFrZSBzdXJlIERldmljZSBiYWNrIHRvIEQwIGFuZCB0aGVuIGdvIHRvIFMz
IGFuZCBwdXQgRGV2aWNlIHRvIEQzIGlmIERldmljZSBzdXBwb3J0IEQzDQoNCg0KPiANCj4gPiB0
aGF0IGlzIHdoeSB3ZSBtb3ZlIHRoaXMgaWYtc3RhdGVtZW50IGZyb20gc3RhcnRfcnVuKCkgdG8N
Cj4gPiBydHN4X3BjaV9ydW50aW1lX3Jlc3VtZSgpDQo+ID4NCj4gPiA+ID4gPg0KPiA+ID4gPiA+
ID4gKw0KPiA+ID4gPiA+ID4gICAgICAgICBtdXRleF9sb2NrKCZwY3ItPnBjcl9tdXRleCk7DQo+
ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gICAgICAgICBydHN4X3BjaV93cml0ZV9yZWdpc3Rlcihw
Y3IsIEhPU1RfU0xFRVBfU1RBVEUsIDB4MDMsDQo+ID4gPiA+ID4gPiAweDAwKTsgZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0c3hfcGNyLmgNCj4gPiA+ID4gPiA+IGIvZHJp
dmVycy9taXNjL2NhcmRyZWFkZXIvcnRzeF9wY3IuaA0KPiA+ID4gPiA+ID4gaW5kZXggZGFmMDU3
YzRlZWE2Li5iOTM5NzUyNjhlNmQgMTAwNjQ0DQo+ID4gPiA+ID4gPiAtLS0gYS9kcml2ZXJzL21p
c2MvY2FyZHJlYWRlci9ydHN4X3Bjci5oDQo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL21pc2Mv
Y2FyZHJlYWRlci9ydHN4X3Bjci5oDQo+ID4gPiA+ID4gPiBAQCAtMjUsNiArMjUsNyBAQA0KPiA+
ID4gPiA+ID4gICNkZWZpbmUgUkVHX0VGVVNFX1BPV0VST0ZGICAgICAgICAgICAgIDB4MDANCj4g
PiA+ID4gPiA+ICAjZGVmaW5lIFJUUzUyNTBfQ0xLX0NGRzMgICAgICAgICAgICAgICAweEZGNzkN
Cj4gPiA+ID4gPiA+ICAjZGVmaW5lIFJUUzUyNUFfQ0ZHX01FTV9QRCAgICAgICAgICAgICAweEYw
DQo+ID4gPiA+ID4gPiArI2RlZmluZSBSVFM1MjRBX0FVVE9MT0FEX0NGRzEgIDB4RkY3Qw0KPiA+
ID4gPiA+ID4gICNkZWZpbmUgUlRTNTI0QV9QTV9DVFJMMyAgICAgICAgICAgICAgIDB4RkY3RQ0K
PiA+ID4gPiA+ID4gICNkZWZpbmUgUlRTNTI1QV9CSU9TX0NGRyAgICAgICAgICAgICAgIDB4RkYy
RA0KPiA+ID4gPiA+ID4gICNkZWZpbmUgUlRTNTI1QV9MT0FEX0JJT1NfRkxBRyAweDAxDQo+ID4g
PiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gMi4yNS4xDQo+ID4gPiA+ID4gLS0tLS0tUGxlYXNlIGNv
bnNpZGVyIHRoZSBlbnZpcm9ubWVudCBiZWZvcmUgcHJpbnRpbmcgdGhpcyBlLW1haWwuDQo=
