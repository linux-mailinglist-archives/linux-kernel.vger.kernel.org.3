Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44ED64639F1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 16:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244170AbhK3P0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 10:26:37 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21372 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245526AbhK3PZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 10:25:16 -0500
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-33-CykIfUoTPdOQVMeGgLdI_g-1; Tue, 30 Nov 2021 15:21:54 +0000
X-MC-Unique: CykIfUoTPdOQVMeGgLdI_g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:994c:f5c2:35d6:9b65) with Microsoft SMTP
 Server (TLS) id 15.0.1497.26; Tue, 30 Nov 2021 15:21:48 +0000
Received: from AcuMS.Aculab.com ([fe80::994c:f5c2:35d6:9b65]) by
 AcuMS.aculab.com ([fe80::994c:f5c2:35d6:9b65%12]) with mapi id
 15.00.1497.026; Tue, 30 Nov 2021 15:21:48 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Vlastimil Babka' <vbabka@suse.cz>,
        Christoph Lameter <cl@gentwo.org>
CC:     Rustam Kovhaev <rkovhaev@gmail.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "rientjes@google.com" <rientjes@google.com>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "dvyukov@google.com" <dvyukov@google.com>
Subject: RE: [PATCH v4] slob: add size header to all allocations
Thread-Topic: [PATCH v4] slob: add size header to all allocations
Thread-Index: AQHX344YYrlQE8gw8k+1+rn2N9Qq+awQ435QgAtSF4CAAAG98A==
Date:   Tue, 30 Nov 2021 15:21:47 +0000
Message-ID: <e79cd6da011a412f8c68e132ba74dc5c@AcuMS.aculab.com>
References: <037227db-c869-7d9c-65e8-8f5f8682171d@suse.cz>
 <20211122013026.909933-1-rkovhaev@gmail.com>
 <alpine.DEB.2.22.394.2111221018070.202803@gentwo.de>
 <3c996e22-034f-1013-3978-1f786aae38fb@suse.cz>
 <alpine.DEB.2.22.394.2111221133110.204314@gentwo.de>
 <148d2774-77b9-bb25-c132-80b00e16ea06@suse.cz>
 <69fc0cead9774dfdba816a8e25f30a53@AcuMS.aculab.com>
 <d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz>
In-Reply-To: <d0927ca6-1710-5b2b-3682-6a80eb4e48d1@suse.cz>
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

RnJvbTogVmxhc3RpbWlsIEJhYmthDQo+IFNlbnQ6IDMwIE5vdmVtYmVyIDIwMjEgMTQ6NTYNCj4g
DQo+IE9uIDExLzIzLzIxIDExOjE4LCBEYXZpZCBMYWlnaHQgd3JvdGU6DQo+ID4gRnJvbTogVmxh
c3RpbWlsIEJhYmthDQo+ID4+IFNlbnQ6IDIyIE5vdmVtYmVyIDIwMjEgMTA6NDYNCj4gPj4NCj4g
Pj4gT24gMTEvMjIvMjEgMTE6MzYsIENocmlzdG9waCBMYW1ldGVyIHdyb3RlOg0KPiA+PiA+IE9u
IE1vbiwgMjIgTm92IDIwMjEsIFZsYXN0aW1pbCBCYWJrYSB3cm90ZToNCj4gPj4gPg0KPiA+PiA+
PiBCdXQgaXQgc2VlbXMgdGhlcmUncyBubyByZWFzb24gd2UgY291bGRuJ3QgZG8gYmV0dGVyPyBJ
LmUuIHVzZSB0aGUgdmFsdWUgb2YNCj4gPj4gPj4gU0xPQl9IRFJfU0laRSBvbmx5IHRvIGFsaWdu
IHRoZSBiZWdpbm5pbmcgb2YgYWN0dWFsIG9iamVjdCAoYW5kIG5hbWUgdGhlDQo+ID4+ID4+IGRl
ZmluZSBkaWZmZXJlbnQgdGhhbiBTTE9CX0hEUl9TSVpFKS4gQnV0IHRoZSBzaXplIG9mIHRoZSBo
ZWFkZXIsIHdoZXJlIHdlDQo+ID4+ID4+IHN0b3JlIHRoZSBvYmplY3QgbGVuZ2h0IGNvdWxkIGJl
IGp1c3QgYSBuYXRpdmUgd29yZCAtIDQgYnl0ZXMgb24gMzJiaXQsIDggb24NCj4gPj4gPj4gNjRi
aXQuIFRoZSBhZGRyZXNzIG9mIHRoZSBoZWFkZXIgc2hvdWxkbid0IGhhdmUgYSByZWFzb24gdG8g
YmUgYWxzbyBhbGlnbmVkDQo+ID4+ID4+IHRvIEFSQ0hfS01BTExPQ19NSU5BTElHTiAvIEFSQ0hf
U0xBQl9NSU5BTElHTiBhcyBvbmx5IFNMT0IgaXRzZWxmIHByb2Nlc3Nlcw0KPiA+PiA+PiBpdCBh
bmQgbm90IHRoZSBzbGFiIGNvbnN1bWVycyB3aGljaCByZWx5IG9uIHRob3NlIGFsaWdubWVudHM/
DQo+ID4+ID4NCj4gPj4gPiBXZWxsIHRoZSBiZXN0IHdheSB3b3VsZCBiZSB0byBwdXQgaXQgYXQg
dGhlIGVuZCBvZiB0aGUgb2JqZWN0IGluIG9yZGVyIHRvDQo+ID4+ID4gYXZvaWQgdGhlIGFsaWdu
bWVudCBwcm9ibGVtLiBUaGlzIGlzIGEgcGFydGljdWxhciBpc3N1ZSB3aXRoIFNMT0IgYmVjYXVz
ZQ0KPiA+PiA+IGl0IGFsbG93cyBtdWx0aXBsZSB0eXBlcyBvZiBvYmplY3RzIGluIGEgc2luZ2xl
IHBhZ2UgZnJhbWUuDQo+ID4+ID4NCj4gPj4gPiBJZiBvbmx5IG9uZSB0eXBlIG9mIG9iamVjdCB3
b3VsZCBiZSBhbGxvd2VkIHRoZW4gdGhlIG9iamVjdCBzaXplIGV0YyBjYW4NCj4gPj4gPiBiZSBz
dG9yZWQgaW4gdGhlIHBhZ2Ugc3RydWN0Lg0KPiA+DQo+ID4gT3IganVzdCBhIHNpbmdsZSBieXRl
IHRoYXQgaXMgdGhlIGluZGV4IG9mIHRoZSBhc3NvY2lhdGVkIGZyZWUgbGlzdCBzdHJ1Y3R1cmUu
DQo+ID4gRm9yIDMyYml0IGFuZCBmb3IgdGhlIHNtYWxsZXIga21hbGxvYygpIGFyZWEgaXQgbWF5
IGJlIHJlYXNvbmFibGUgdG8gaGF2ZQ0KPiA+IGEgc2VwYXJhdGUgYXJyYXkgaW5kZXhlZCBieSB0
aGUgcGFnZSBvZiB0aGUgYWRkcmVzcy4NCj4gPg0KPiA+PiA+IFNvIEkgZ3Vlc3MgcGxhY2VtZW50
IGF0IHRoZSBiZWdpbm5pbmcgY2Fubm90IGJlIGF2b2lkZWQuIFRoYXQgaW4gdHVybiBydW5zDQo+
ID4+ID4gaW50byB0cm91YmxlIHdpdGggdGhlIERNQSByZXF1aXJlbWVudHMgb24gc29tZSBwbGF0
Zm9ybXMgd2hlcmUgdGhlDQo+ID4+ID4gYmVnaW5uaW5nIG9mIHRoZSBvYmplY3QgaGFzIHRvIGJl
IGNhY2hlIGxpbmUgYWxpZ25lZC4NCj4gPj4NCj4gPj4gSXQncyBubyBwcm9ibGVtIHRvIGhhdmUg
dGhlIHJlYWwgYmVnaW5uaW5nIG9mIHRoZSBvYmplY3QgYWxpZ25lZCwgYW5kIHRoZQ0KPiA+PiBw
cmVwZW5kZWQgaGVhZGVyIG5vdC4NCj4gPg0KPiA+IEknbSBub3Qgc3VyZSB0aGF0IGhlbHBzLg0K
PiA+IFRoZSBoZWFkZXIgY2FuJ3Qgc2hhcmUgYSBjYWNoZSBsaW5lIHdpdGggdGhlIHByZXZpb3Vz
IGl0ZW0gKGJlY2F1c2UgaXQNCj4gPiBtaWdodCBiZSBtYXBwZWQgZm9yIERNQSkgc28gd2lsbCBh
bHdheXMgdGFrZSBhIGZ1bGwgY2FjaGUgbGluZS4NCj4gDQo+IFNvIGlmIHRoaXMgaXMgdHJ1ZSwg
dGhlbiBJIHRoaW5rIHdlIGFscmVhZHkgaGF2ZSBhIHByb2JsZW0gd2l0aCBTTE9CIHRvZGF5DQo+
IChhbmQgQUZBSUNTIGl0J3Mgbm90IGV2ZW4gZHVlIHRvIGNoYW5nZXMgZG9uZSBieSBteSAyMDE5
IGNvbW1pdCA1OWJiNDc5ODVjMWQNCj4gKCJtbSwgc2xbYW91XWI6IGd1YXJhbnRlZSBuYXR1cmFs
IGFsaWdubWVudCBmb3Iga21hbGxvYyhwb3dlci1vZi10d28pIiBidXQNCj4gb2xkZXIpLg0KPiAN
Cj4gTGV0J3Mgc2F5IHdlIGFyZSBvbiBhcm02NCB3aGVyZSAoQUZBSUNTKToNCj4gQVJDSF9LTUFM
TE9DX01JTkFMSUdOID0gQVJDSF9ETUFfTUlOQUxJR04gPSAxMjgNCj4gQVJDSF9TTEFCX01JTkFM
SUdOID0gNjQNCg0KSXMgdGhhdCB2YWxpZD8NCklzbid0IFNMQUIgYmVpbmcgdXNlZCB0byBpbXBs
ZW1lbnQga21hbGxvYygpIHNvIHRoZSBhcmNoaXRlY3R1cmUNCmRlZmluZWQgYWxpZ25tZW50IG11
c3QgYXBwbHk/DQoNCj4gVGhlIHBvaW50IGlzIHRoYXQgQVJDSF9TTEFCX01JTkFMSUdOIGlzIHNt
YWxsZXIgdGhhbiBBUkNIX0RNQV9NSU5BTElHTi4NCj4gDQo+IExldCdzIHNheSB3ZSBjYWxsIGtt
YWxsb2MoNjQpIGFuZCBnZXQgYSBjb21wbGV0ZWx5IGZyZXNoIHBhZ2UuDQo+IEluIFNMT0IsIGFs
bG9jKCkgb3IgcmF0aGVyIF9fZG9fa21hbGxvY19ub2RlKCkgd2lsbCBjYWxjdWxhdGUgbWluYWxp
Z24gdG8NCj4gbWF4KEFSQ0hfS01BTExPQ19NSU5BTElHTiwgQVJDSF9TTEFCX01JTkFMSUdOKSB0
aHVzIDEyOC4NCj4gSXQgd2lsbCBjYWxsIHNsb2JfYWxsb2MoKSBmb3Igc2l6ZSBvZiBzaXplK21p
bmFsaWduPTY0KzEyOD0xOTIsIGFsaWduIGFuZA0KPiBhbGlnbl9vZmZzZXQgPSAxMjgNCj4gVGh1
cyB0aGUgYWxsb2NhdGlvbiB3aWxsIHVzZSAxMjggYnl0ZXMgZm9yIHRoZSBoZWFkZXIsIDY0IGZv
ciB0aGUgb2JqZWN0Lg0KPiBCb3RoIHRoZSBoZWFkZXIgYW5kIG9iamVjdCBhbGlnbmVkIHRvIDEy
OCBieXRlcy4NCj4gQnV0IHRoZSByZW1haW5pbmcgNjQgYnl0ZXMgb2YgdGhlIHNlY29uZCAxMjgg
Ynl0ZXMgd2lsbCByZW1haW4gZnJlZSwgYXMgdGhlDQo+IGFsbG9jYXRlZCBzaXplIGlzIDE5MiBi
eXRlczoNCj4gDQo+IHwgMTI4QiBoZWFkZXIsIGFsaWduZWQgfCA2NEIgb2JqZWN0IHwgNjRCIGZy
ZWUgfCByZXN0IGFsc28gZnJlZSB8DQoNClRoYXQgaXMgaG9ycmlibHkgd2FzdGVmdWwgb24gbWVt
b3J5IDotKQ0KDQo+IElmIHRoZXJlJ3MgYW5vdGhlciBrbWFsbG9jIGFsbG9jYXRpb24sIHRoZSAx
MjggYnl0ZXMgYWxpZ21lbnQgZHVlIHRvDQo+IEFSQ0hfS01BTExPQ19NSU5BTElHTiB3aWxsIGF2
b2lkIGl0IGZyb20gdXNpbmcgdGhlc2UgNjQgYnl0ZXMsIHNvIHRoYXQncw0KPiBmaW5lLiBCdXQg
aWYgdGhlcmUncyBhIGttZW1fY2FjaGVfYWxsb2MoKSBmcm9tIGEgY2FjaGUgc2VydmluZyA8PTY0
Qg0KPiBvYmplY3RzLCBpdCB3aWxsIGJlIGFsaWduZWQgdG8gQVJDSF9TTEFCX01JTkFMSUdOIGFu
ZCBoYXBwaWx5IHVzZSB0aG9zZSA2NA0KPiBieXRlcyB0aGF0IHNoYXJlIHRoZSAxMjggYmxvY2sg
d2hlcmUgdGhlIHByZXZpb3VzIGttYWxsb2MgYWxsb2NhdGlvbiBsaWVzLg0KDQpJZiB0aGUgbWVt
b3J5IHJldHVybmVkIGJ5IGttZW1fY2FjaGVfYWxsb2MoKSBjYW4gYmUgdXNlZCBmb3IgRE1BIHRo
ZW4NCkFSQ0hfRE1BX01JTkFMSUdOIGhhcyB0byBhcHBseSB0byB0aGUgcmV0dXJuZWQgYnVmZmVy
cy4NClNvLCBtYXliZSwgdGhhdCBjYWNoZSBjYW4ndCBleGlzdD8NCg0KSSdkIGV4cGVjdCB0aGF0
IEFSQ0hfRE1BX01JTkFMSUdOIGZvcmNlcyBhbGxvY2F0aW9ucyB0byBiZSBhIG11bHRpcGxlDQpv
ZiB0aGF0IHNpemUuDQpNb3JlIHBhcnRpY3VsYXJseSB0aGUgcmVzdCBvZiB0aGUgYXJlYSBjYW4n
dCBiZSBhbGxvY2F0ZWQgdG8gYW55dGhpbmcgZWxzZS4NClNvIGl0IG91Z2h0IHRvIGJlIHZhbGlk
IHRvIHJldHVybiB0aGUgMm5kIGhhbGYgb2YgYSAxMjggYnl0ZSBjYWNoZSBsaW5lDQpwcm92aWRl
ZCB0aGUgZmlyc3QgaGFsZiBpc24ndCB3cml0dGVuIHdoaWxlIHRoZSBhbGxvY2F0aW9uIGlzIGFj
dGl2ZS4NCg0KQnV0IHRoYXQgQVJDSF9LTUFMTE9DX01JTkFMSUdOIG9ubHkgYXBwbGllcyB0byAn
bGFyZ2UnIGl0ZW1zPw0KU21hbGwgaXRlbXMgb25seSBuZWVkIGFsaWduaW5nIHRvIHRoZSBwb3dl
ciBvZiAyIGJlbG93IHRoZWlyIHNpemUuDQpTbyA4IGJ5dGVzIGl0ZW1zIG9ubHkgbmVlZCA4IGJ5
dGUgYWxpZ25tZW50IGV2ZW4gdGhvdWdoIGEgbGFyZ2VyDQppdGVtIG1pZ2h0IG5lZWQgKHNheSkg
NjQgYnl0ZSBhbGlnbm1lbnQuDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFr
ZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwg
VUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

