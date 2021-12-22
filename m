Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE3D47CD7A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 08:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbhLVHUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 02:20:00 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:48896
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231422AbhLVHT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 02:19:59 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(4628:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Wed, 22 Dec 2021 15:20:08 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Wed, 22 Dec 2021 15:20:03 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Wed, 22 Dec 2021 15:20:03 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        =?utf-8?B?6buD5oe35Y6a?= <tonyhuang.sunplus@gmail.com>
Subject: RE: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v4 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX8mCd69RkrTnSM0GRURxouCuBCKw1+gLA///W7ICACDps4A==
Date:   Wed, 22 Dec 2021 07:20:03 +0000
Message-ID: <a45cf55f836c4befa65510e30440016c@sphcmbx02.sunplus.com.tw>
References: <cover.1639557112.git.tonyhuang.sunplus@gmail.com>
 <c3a3b64c38807b2f344c3df500eb4c60b885eadf.1639557112.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0CnCK-Dfodp-jTzZApM_1NpdY7DV2fRqnO=gaju5xGwg@mail.gmail.com>
 <CAHpW4oQmtd-gG1HYZT-Dk=QAvXKsKebzcOaVtrEeoujwoL9zSg@mail.gmail.com>
 <316c16afbff74160b07bd74444f3b8e1@sphcmbx02.sunplus.com.tw>
 <CAK8P3a0cA7iL=ug6hiqWAV1-qFSoCN-R7jrXv0cqByUDJV4x0Q@mail.gmail.com>
In-Reply-To: <CAK8P3a0cA7iL=ug6hiqWAV1-qFSoCN-R7jrXv0cqByUDJV4x0Q@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBBcm5kOg0KDQo+ID4gPj4gSU9QIChJTyBQcm9jZXNzb3IpIGVtYmVkZGVkIGluc2lkZSBT
UDcwMjEgd2hpY2ggaXMgdXNlZCBhcw0KPiA+ID4+IFByb2Nlc3NvciBmb3IgSS9PIGNvbnRyb2ws
IFJUQyB3YWtlLXVwIGFuZCBjb29wZXJhdGlvbiB3aXRoIENQVSAmDQo+ID4gPj4gUE1DIGluIHBv
d2VyIG1hbmFnZW1lbnQgcHVycG9zZS4NCj4gPiA+PiBUaGUgSU9QIGNvcmUgaXMgRFE4MDUxLCBz
byBhbHNvIG5hbWVkIElPUDgwNTEsIGl0IHN1cHBvcnRzDQo+ID4gPj4gZGVkaWNhdGVkIEpUQUcg
ZGVidWcgcGlucyB3aGljaCBzaGFyZSB3aXRoIFNQNzAyMS4NCj4gPiA+PiBJbiBzdGFuZGJ5IG1v
ZGUgb3BlcmF0aW9uLCB0aGUgcG93ZXIgc3BlYyByZWFjaCA0MDB1QS4NCj4gPiA+Pg0KPiA+ID4+
IFNpZ25lZC1vZmYtYnk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4N
Cj4gPiA+PiAtLS0NCj4gPiA+PiBDaGFuZ2VzIGluIHY0Og0KPiA+ID4+ICAtIEFkZHJlc3NlZCBj
b21tZW50cyBmcm9tIEFybmQgQmVyZ21hbm4uDQo+ID4NCj4gPiA+SSBkb24ndCB0aGluayB5b3Ug
ZGlkOiBJIGFza2VkIHlvdSBzcGVjaWZpY2FsbHkgdG8gYWRkIGNvZGUgdG8NCj4gPiA+aW50ZXJh
Y3Qgd2l0aCB0aGUgZXhpc3RpbmcgaW4ta2VybmVsIGludGVyZmFjZXMgdG8gdXNlIHRoZQ0KPiA+
ID5mdW5jdGlvbmFsaXR5IHByb3ZpZGVkIGJ5IHRoZSBkZXZpY2UuIFBpY2sgYW55IChhdCBsZWFz
dCB0d28pDQo+ID4gPnN1YnN5c3RlbXMgYW5kIGFkZCBzdXBwb3J0LCBidXQgbGVhdmUgb3V0IGFu
eSBjdXN0b20gdXNlciBzcGFjZQ0KPiA+ID5pbnRlcmZhY2VzIChtaXNjZGV2aWNlLCBkZWJ1Z2Zz
LCBzeXNmcywgLi4uKSBmb3IgdGhlIG1vbWVudC4NCj4gPg0KPiA+DQo+ID4NCj4gPiAxLiBJT1Ag
Y2FuIHJ1biBzcF9pb3BfcGxhdGZvcm1fZHJpdmVyX3NodWRvd24oKSB0aHJvdWdoIHRoZSBwb3dl
cm9mZg0KPiA+IGNvbW1hbmQgYW5kIHRoZSBrZXJuZWwuIFBlcmZvcm0gc3lzdGVtIHBvd2VyLW9m
ZiBhY3Rpb25zLg0KPiANCj4gRG8geW91IG1lYW4gdGhhdCB0aGlzIG1ldGhvZCBhKSBjbGVhbmx5
IHNodXRzIGRvd24gdGhlIGlvcCBiZWZvcmUgdGhlIHN5c3RlbQ0KPiBpcyBwb3dlcmVkIGRvd24s
IG9yIGIpIHRoZSBkcml2ZXJfc2h1dGRvd24oKSBjYWxsYmFjayBpcyB1c2VkIHRvIGluaXRpYXRl
IHRoZQ0KPiBwb3dlcmRvd24gb2YgdGhlIHN5c3RlbSBpdHNlbGY/DQo+IA0KPiBJbiBjYXNlIG9m
IGEpIEkgd291bGQgbm90IGNvdW50IHRoYXQgYXMgZXhwb3NpbmcgZnVuY3Rpb25hbGl0eSwgd2hh
dCB5b3UgZG8gaGVyZQ0KPiBpcyBqdXN0IHBhcnQgb2YgYW55IGRyaXZlci4gSWYgaW5zdGVhZCB5
b3UgYXJlIHRyeWluZyB0byB1c2UgYiksIHRoaXMgaXMgdGhlIHdyb25nDQo+IHdheSBvZiBkb2lu
ZyBpdCwgc2VlIGRyaXZlcnMvcG93ZXIvcmVzZXQvIGZvciBleGFtcGxlcyBvZiBob3cgdG8gZG8g
aXQgcmlnaHQuDQo+IA0KPiA+IDIuIFdha2UgdXAgdGhlIHN5c3RlbSBieSByZWx5aW5nIG9uIHRo
ZSA4MDUxIGludGVybmFsIFJUQyB3YWtlLXVwDQo+ID4gbWVjaGFuaXNtIGFuZCBleHRlcm5hbCBH
UElPIGlucHV0IHNpZ25hbHMgdG8gd2FrZSB1cC4NCj4gDQo+IEkgdGhpbmsgdGhvc2Ugc2hvdWxk
IGJlIGV4cG9zZWQgd2l0aCBkcml2ZXJzL3J0YyBmb3IgdGhlIFJUQyBhbmQgZHJpdmVycy9ncGlv
Lw0KPiBmb3IgdGhlIEdQSU8gZHJpdmVyLCBhbmQgdGhlbiB5b3UgY2FuIHVzZSB0aGUgZGV2aWNl
IHRyZWUgdG8gY29uZmlndXJlIHdoaWNoDQo+IEdQSU8gdG8gdXNlIGFzIGEgd2FrZXVwIGFuZCBo
b3cgaXQncyBjb25uZWN0ZWQgdG8gdGhlIFJUQy4NCj4gDQoNCkkgaGF2ZSBhIHF1ZXN0aW9uIHRv
IGFzayB5b3U6CQ0KVGhlcmUgYXJlIHR3byB3YXlzIHRvIHdha2UgdXAgdGhlIExpbnV4IGtlcm5l
bCBzeXN0ZW0gaW4gODA1MS4JCQkJCQkJCQ0KMSlSVEMgd2FrZXVwOgkJCQkJCQkJDQpUaGUgU1A3
MDIxIHN5c3RlbSBtb3VudHMgdGhlIFJUQyBkZXZpY2UgZHJpdmVyLgkJCQkJCQkJDQpJIHNldCB0
aGUgUlRDIHdha2UtdXAgdGltZSBieSB0eXBlIGNvbW1hbmRzIGluIGNvbW1hbmQgbGluZS4JCQkJ
CQkJCQ0KRXhhbXBsZTogDQplY2hvIDAgPiAvc3lzL2NsYXNzL3J0Yy9ydGMwL3dha2VhbGFybSAm
JiBubm49YGRhdGUgJyslcydgICYmIGVjaG8gJG5ubiAmJiBubm49YGV4cHIgJG5ubiArIDEwYCAm
JiBlY2hvICRubm4gPiAvc3lzL2NsYXNzL3J0Yy9ydGMwL3dha2VhbGFybQkJCQkJCQkJDQpXaGVu
IHRoZSBsaW51eCBrZXJuZWwgc3lzdGVtIGhhcyBubyBwb3dlci4gODA1MSBjYW4gcmVhZCBSVEMg
cmVzZ2lzdGVyIGFuZCByZWNlaXZlIFJUQyB3YWtldXAgaW50ZXJydXB0LgkJCQkJCQkJDQpEbyBJ
IG5lZWQgdG8gYWRkIFJUQyBzdWJzeXN0ZW0gZnVuY3Rpb25hIHRvIHRoZSBJT1AgY29kZT8JCQkJ
CQkJCQ0KCQkJCQkJCQkNCjIpR1BJTyB3YWtldXA6CQkJCQkJCQkNCkFjY29yZGluZyB0byB5b3Vy
IHN1Z2dlc3Rpb24JCQkJCQkJCQ0KSSB1c2Ugb2ZfZ2V0X25hbWVfZ3BpbygpIHRvIGdldCBHUElP
IG51bWJlciBmcm9tIGRldmljZSB0cmVlIGR1cmluZyB0aGUgSU9QIHByb2JlIHByb2Nlc3MuCQkJ
CQkJCQkNClBhc3MgaXQgdG8gODA1MSBmb3IgdXNlLgkJCQkJCQkJDQoNClRoYW5rcw0KDQo=
