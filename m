Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7B0D4788B6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234734AbhLQKYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:24:45 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:47486 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232001AbhLQKYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:24:44 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(7106:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Fri, 17 Dec 2021 18:24:51 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 17 Dec 2021 18:24:50 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 17 Dec 2021 18:24:50 +0800
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
Thread-Index: AQHX8mCd69RkrTnSM0GRURxouCuBCKw1+gLA///W7ICAAIywUA==
Date:   Fri, 17 Dec 2021 10:24:50 +0000
Message-ID: <fdc6efc8c93f45b492930f75f97409e8@sphcmbx02.sunplus.com.tw>
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

RGVhciBBcm5kOg0KDQo+ID4gPj4NCj4gPiA+PiBJT1AgKElPIFByb2Nlc3NvcikgZW1iZWRkZWQg
aW5zaWRlIFNQNzAyMSB3aGljaCBpcyB1c2VkIGFzDQo+ID4gPj4gUHJvY2Vzc29yIGZvciBJL08g
Y29udHJvbCwgUlRDIHdha2UtdXAgYW5kIGNvb3BlcmF0aW9uIHdpdGggQ1BVICYNCj4gPiA+PiBQ
TUMgaW4gcG93ZXIgbWFuYWdlbWVudCBwdXJwb3NlLg0KPiA+ID4+IFRoZSBJT1AgY29yZSBpcyBE
UTgwNTEsIHNvIGFsc28gbmFtZWQgSU9QODA1MSwgaXQgc3VwcG9ydHMNCj4gPiA+PiBkZWRpY2F0
ZWQgSlRBRyBkZWJ1ZyBwaW5zIHdoaWNoIHNoYXJlIHdpdGggU1A3MDIxLg0KPiA+ID4+IEluIHN0
YW5kYnkgbW9kZSBvcGVyYXRpb24sIHRoZSBwb3dlciBzcGVjIHJlYWNoIDQwMHVBLg0KPiA+ID4+
DQo+ID4gPj4gU2lnbmVkLW9mZi1ieTogVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNAZ21h
aWwuY29tPg0KPiA+ID4+IC0tLQ0KPiA+ID4+IENoYW5nZXMgaW4gdjQ6DQo+ID4gPj4gIC0gQWRk
cmVzc2VkIGNvbW1lbnRzIGZyb20gQXJuZCBCZXJnbWFubi4NCj4gPg0KPiA+ID5JIGRvbid0IHRo
aW5rIHlvdSBkaWQ6IEkgYXNrZWQgeW91IHNwZWNpZmljYWxseSB0byBhZGQgY29kZSB0bw0KPiA+
ID5pbnRlcmFjdCB3aXRoIHRoZSBleGlzdGluZyBpbi1rZXJuZWwgaW50ZXJmYWNlcyB0byB1c2Ug
dGhlDQo+ID4gPmZ1bmN0aW9uYWxpdHkgcHJvdmlkZWQgYnkgdGhlIGRldmljZS4gUGljayBhbnkg
KGF0IGxlYXN0IHR3bykNCj4gPiA+c3Vic3lzdGVtcyBhbmQgYWRkIHN1cHBvcnQsIGJ1dCBsZWF2
ZSBvdXQgYW55IGN1c3RvbSB1c2VyIHNwYWNlDQo+ID4gPmludGVyZmFjZXMgKG1pc2NkZXZpY2Us
IGRlYnVnZnMsIHN5c2ZzLCAuLi4pIGZvciB0aGUgbW9tZW50Lg0KPiA+DQo+ID4NCj4gPg0KPiA+
IDEuIElPUCBjYW4gcnVuIHNwX2lvcF9wbGF0Zm9ybV9kcml2ZXJfc2h1ZG93bigpIHRocm91Z2gg
dGhlIHBvd2Vyb2ZmDQo+ID4gY29tbWFuZCBhbmQgdGhlIGtlcm5lbC4gUGVyZm9ybSBzeXN0ZW0g
cG93ZXItb2ZmIGFjdGlvbnMuDQo+IA0KPiBEbyB5b3UgbWVhbiB0aGF0IHRoaXMgbWV0aG9kIGEp
IGNsZWFubHkgc2h1dHMgZG93biB0aGUgaW9wIGJlZm9yZSB0aGUgc3lzdGVtDQo+IGlzIHBvd2Vy
ZWQgZG93biwgb3IgYikgdGhlIGRyaXZlcl9zaHV0ZG93bigpIGNhbGxiYWNrIGlzIHVzZWQgdG8g
aW5pdGlhdGUgdGhlDQo+IHBvd2VyZG93biBvZiB0aGUgc3lzdGVtIGl0c2VsZj8NCj4gDQo+IElu
IGNhc2Ugb2YgYSkgSSB3b3VsZCBub3QgY291bnQgdGhhdCBhcyBleHBvc2luZyBmdW5jdGlvbmFs
aXR5LCB3aGF0IHlvdSBkbyBoZXJlDQo+IGlzIGp1c3QgcGFydCBvZiBhbnkgZHJpdmVyLiBJZiBp
bnN0ZWFkIHlvdSBhcmUgdHJ5aW5nIHRvIHVzZSBiKSwgdGhpcyBpcyB0aGUgd3JvbmcNCj4gd2F5
IG9mIGRvaW5nIGl0LCBzZWUgZHJpdmVycy9wb3dlci9yZXNldC8gZm9yIGV4YW1wbGVzIG9mIGhv
dyB0byBkbyBpdCByaWdodC4NCj4gDQo+ID4gMi4gV2FrZSB1cCB0aGUgc3lzdGVtIGJ5IHJlbHlp
bmcgb24gdGhlIDgwNTEgaW50ZXJuYWwgUlRDIHdha2UtdXANCj4gPiBtZWNoYW5pc20gYW5kIGV4
dGVybmFsIEdQSU8gaW5wdXQgc2lnbmFscyB0byB3YWtlIHVwLg0KPiANCj4gSSB0aGluayB0aG9z
ZSBzaG91bGQgYmUgZXhwb3NlZCB3aXRoIGRyaXZlcnMvcnRjIGZvciB0aGUgUlRDIGFuZCBkcml2
ZXJzL2dwaW8vDQo+IGZvciB0aGUgR1BJTyBkcml2ZXIsIGFuZCB0aGVuIHlvdSBjYW4gdXNlIHRo
ZSBkZXZpY2UgdHJlZSB0byBjb25maWd1cmUgd2hpY2gNCj4gR1BJTyB0byB1c2UgYXMgYSB3YWtl
dXAgYW5kIGhvdyBpdCdzIGNvbm5lY3RlZCB0byB0aGUgUlRDLg0KPiANCg0KU1A3MDIxOg0KVGhl
IHN5c3RlbSBpcyBwb3dlcmVkIG9mZi4gQnV0IDgwNTEgc3RpbGwgaGFzIHBvd2VyLg0KVGhlIDgw
NTEgaGFzIGEgcmVnaXN0ZXIgdG8gY29udHJvbCB0aGUgcG93ZXItb24gYW5kIHBvd2VyLW9mZiBv
ZiB0aGUgc3lzdGVtLg0KODA1MSBoYXMgUlRDIHJlZ2lzdGVyLiBXaGVuIHRoZSB0aW1lIGlzIHVw
LCA4MDUxIHBvd2VycyBvbiB0aGUgc3lzdGVtLg0KVGhlIDgwNTEgY2FuIGRldGVjdCBHUElPMH43
IHBpbnMsIGFuZCBHUElPIHBpbiBoaWdoL2xvdyBjYW4gYmUgdXNlZCBhcyBhIHBvd2VyLW9uIGp1
ZGdtZW50IG1lY2hhbmlzbSBmb3IgdGhlIHN5c3RlbS4NCg0KPiA+IDMuU28geW91IGFzayBtZSB0
byBjb250cm9sIElPUCg4MDUxKSB0aHJvdWdoIGZpbGVfb3BlcmF0aW9ucywgbm90DQo+ID4gdGhy
b3VnaCBERVZJQ0VfQVRUUg0KPiANCj4gTm8sIG5laXRoZXIgb2YgdGhlbS4gVXNlIHRoZSBhcHBy
b3ByaWF0ZSBkcml2ZXJzLyovIHN1YnN5c3RlbXMgZm9yIGFueQ0KPiBmdW5jdGlvbmFsaXR5IHRo
YXQgaGFzIGFuIGV4aXN0aW5nIHN1YnN5c3RlbS4gSWYgdGhlcmUgaXMgc29tZXRoaW5nIHRoYXQg
dGhlIGlvcA0KPiBkb2VzIHRoYXQgZG9lcyBub3QgeWV0IGhhdmUgYSBzdWJzeXN0ZW0sIHRoYXQg
cmVxdWlyZXMgYSBtb3JlIHRob3JvdWdoIGRlc2lnbg0KPiBkaXNjdXNzaW9uIGZvciBjcmVhdGlu
ZyBhIG5ldyB1c2VyIGludGVyZmFjZSwgaWRlYWxseSBpbiBhIGhhcmR3YXJlLWluZGVwZW5kZW50
DQo+IHdheS4gWW91IHNob3VsZCBub3Qgc3RhcnQgd2l0aCB0aGF0IHVudGlsIGFsbCB0aGUgbm9y
bWFsIGZlYXR1cmVzIChydGMsIHdha2V1cCwNCj4gc3VzcGVuZCwgZ3BpbywgLi4uKSBhcmUgc3Vw
cG9ydGVkLg0KPiANCj4gICAgICAgIEFybmQNCg==
