Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7559E479BE2
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 18:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233675AbhLRRa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 12:30:58 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:54096
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229552AbhLRRa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 12:30:57 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(9382:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Sun, 19 Dec 2021 01:30:58 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Sun, 19 Dec 2021 01:30:52 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Sun, 19 Dec 2021 01:30:52 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     gregkh <gregkh@linuxfoundation.org>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX7Nr0VlQujKq+xkKIOnlLCZbqnqwpZLYAgA1h0BD//4/vAIABgUbA///oT4CAAM4ogA==
Date:   Sat, 18 Dec 2021 17:30:52 +0000
Message-ID: <f4d45bcf7ddd45ceaf8ab06e088c69b9@sphcmbx02.sunplus.com.tw>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
 <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
 <YbytSBN+4M2JKAuJ@kroah.com>
 <6257a7c929064569aa46826d1bba9a2f@sphcmbx02.sunplus.com.tw>
 <Yb3cmUmXRhc16iEl@kroah.com>
In-Reply-To: <Yb3cmUmXRhc16iEl@kroah.com>
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

RGVhciBncmVna2gsIGFybmQ6DQoNCg0KPiA+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4g
Pg0KPiA+ID4gPiA+ID4gSU9QIChJTyBQcm9jZXNzb3IpIGVtYmVkZGVkIGluc2lkZSBTUDcwMjEg
d2hpY2ggaXMgdXNlZCBhcw0KPiA+ID4gPiA+ID4gUHJvY2Vzc29yIGZvciBJL08gY29udHJvbCwg
UlRDIHdha2UtdXAgYW5kIGNvb3BlcmF0aW9uIHdpdGgNCj4gPiA+ID4gPiA+IENQVSAmIFBNQyBp
biBwb3dlciBtYW5hZ2VtZW50IHB1cnBvc2UuDQo+ID4gPiA+ID4gPiBUaGUgSU9QIGNvcmUgaXMg
RFE4MDUxLCBzbyBhbHNvIG5hbWVkIElPUDgwNTEsIGl0IHN1cHBvcnRzDQo+ID4gPiA+ID4gPiBk
ZWRpY2F0ZWQgSlRBRyBkZWJ1ZyBwaW5zIHdoaWNoIHNoYXJlIHdpdGggU1A3MDIxLg0KPiA+ID4g
PiA+ID4gSW4gc3RhbmRieSBtb2RlIG9wZXJhdGlvbiwgdGhlIHBvd2VyIHNwZWMgcmVhY2ggNDAw
dUEuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogVG9ueSBIdWFuZyA8
dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gVGhhbmtz
IGZvciB0aGUgaW1wcm92ZW1lbnRzLCB0aGlzIGFnYWluIGxvb2tzIGJldHRlciB0aGFuIHRoZQ0K
PiA+ID4gPiA+IHByZXZpb3VzDQo+ID4gPiB2ZXJzaW9uLg0KPiA+ID4gPiA+IEkgc3RpbGwgaGF2
ZSBzb21lIG1pbm9yIGNvbW1lbnRzLCBhbmQgdGhlcmUgYXJlIGEgY291cGxlIG9mDQo+ID4gPiA+
ID4gZGV0YWlscyBJIGhhdmUgY29tbWVudGVkIG9uIGJlZm9yZSB0aGF0IHdvdWxkIG5lZWQgdG8g
YmUNCj4gPiA+ID4gPiBhZGRyZXNzZWQsIGJ1dCBsZXQncyBmb2N1cyBvbiB0aGUgb25lIG1haW4g
aXNzdWUgZm9yIG5vdzoNCj4gPiA+ID4gPg0KPiA+ID4gPiA+IFRoZSBkcml2ZXIgc3RpbGwgZG9l
c24ndCBhY3R1YWxseSAvZG8vIGFueXRoaW5nOiB5b3UgbG9hZCB0aGUNCj4gPiA+ID4gPiBmaXJt
d2FyZSB3aGVuIHRoZSBkcml2ZXIgaXMgbG9hZGVkLCBhbmQgeW91IHNodXQgaXQgZG93biB3aGVu
DQo+ID4gPiA+ID4gdGhlIGRyaXZlciBpcyByZW1vdmVkLCBidXQgb3RoZXJ3aXNlIHRoZXJlIGlz
IG5vIHdheSB0byBpbnRlcmFjdA0KPiA+ID4gPiA+IHdpdGggdGhlIGlvcC4gWW91IGhhZCB0aGUg
bWlzY2RldmljZSBlYXJsaWVyLCBhbmQgeW91IHN0aWxsDQo+ID4gPiA+ID4gcmVnaXN0ZXIgdGhh
dCwgYnV0IHRoZXJlIGFyZSBubyBmaWxlX29wZXJhdGlvbnMgYXNzb2NpYXRlZCB3aXRoDQo+ID4g
PiA+ID4gaXQsIHNvIGl0IHN0aWxsIGRvZXNuJ3QNCj4gPiA+IGhhdmUgYW55IGVmZmVjdC4NCj4g
PiA+ID4gPg0KPiA+ID4gPiA+IEluIHRoZSBvcmlnaW5hbCB2ZXJzaW9uIHlvdSBoYWQgYSBjb3Vw
bGUgb2YgdXNlci1zaWRlDQo+ID4gPiA+ID4gaW50ZXJmYWNlcywgZm9yIHdoaWNoIEdyZWcgYW5k
IEkgY29tbWVudGVkIHRoYXQgdGhleSB3ZXJlIG5vdA0KPiA+ID4gPiA+IHVzaW5nIHRoZSBjb3Jy
ZWN0IGFic3RyYWN0aW9ucywgYW5kIHlvdSBzdGlsbCBsaXN0IHRoZW0gaW4gdGhlDQo+ID4gPiA+
ID4gY2hhbmdlbG9nIHRleHQgYXMgIkkvTyBjb250cm9sLCBSVEMgd2FrZS11cCBhbmQgY29vcGVy
YXRpb24gd2l0aA0KPiA+ID4gPiA+IENQVSAmIFBNQyBpbiBwb3dlcg0KPiA+ID4gbWFuYWdlbWVu
dCIuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJZiB5b3Ugd2FudCB0byBtYWtlIGFueSBwcm9ncmVz
cyB3aXRoIGFkZGluZyB0aGUgZHJpdmVyLCBJJ2Qgc2F5DQo+ID4gPiA+ID4geW91IHNob3VsZCBp
bXBsZW1lbnQgYXQgbGVhc3QgdHdvIG9mIHRob3NlIGhpZ2gtbGV2ZWwgaW50ZXJmYWNlcw0KPiA+
ID4gPiA+IHRoYXQgaW50ZXJhY3Qgd2l0aCB0aGUgcmVzcGVjdGl2ZSBrZXJuZWwgc3Vic3lzdGVt
cyBpbiBvcmRlciB0bw0KPiA+ID4gPiA+IHNob3cgdGhhdCB0aGUNCj4gPiA+IGFic3RyYWN0aW9u
IHdvcmtzLg0KPiA+ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFE6IndpdGggcmVzcGVjdGl2ZSBr
ZXJuZWwgc3Vic3lzdGVtcyBpbiBvcmRlciB0byBzaG93IHRoYXQgdGhlDQo+ID4gPiA+IGFic3Ry
YWN0aW9uDQo+ID4gPiB3b3Jrcy4iDQo+ID4gPiA+IE1heSBJIGFzayB5b3UgYWJvdXQgcmVwZWN0
aXZlIGtlcm5lbCBzdWJzeXN0ZW0uDQo+ID4gPiA+IElmIEkgdXNlIHRoZSBmaWxlX29wZXJhdGlv
biBtZXRob2QgUHJvdmlkZSB1c2VyIGNhbiByZWFkIGFuZCB3cml0ZQ0KPiA+ID4gPiBJT1AoODA1
MSkncyByZWdpc3Rlci4NCj4gPiA+ID4gSXMgdGhpcyBhIHJlcGVjdGl2ZSBrZXJuZWwgc3Vic3lz
dGVtPw0KPiA+ID4gPiBpZiBub3QNCj4gPiA+ID4gVGhlcmUgYXJlIG90aGVyIGRyaXZlciBjb2Rl
IGNhbiBnaXZlIG1lIHJlZmVyZW5jZQ0KPiA+ID4gPg0KPiA+ID4NCj4gPiA+IEkgc3RpbGwgZG8g
bm90IHVuZGVyc3RhbmQgd2hhdCB0aGUgZ29hbCBvZiB0aGlzIGRyaXZlciBpcy4NCj4gPiA+DQo+
ID4NCj4gPiBXaGVuIHRoZSBwb3dlcm9mZiBjb21tYW5kIGlzIGV4ZWN1dGVkLg0KPiANCj4gV2hh
dCBleGFjdGx5IGRvIHlvdSBtZWFuIGJ5IHRoaXM/ICBUaGUgcG93ZXIgb2ZmIGNvbW1hbmQgdGhh
dCBpcyBzZW50IHRvDQo+IHRoZSBrZXJuZWwgZnJvbSB1c2Vyc3BhY2U/DQo+IA0KDQpJIHR5cGUg
InBvd2Vyb2ZmIiBpbiBjb21tYW5kIGxpbmUuDQoNCj4gPiAxLlRoZSA4MDUxIGhhcyBhIHJlZ2lz
dGVyIHRvIGNvbnRyb2wgdGhlIHBvd2VyLW9uIGFuZCBwb3dlci1vZmYgb2YgdGhlDQo+IHN5c3Rl
bShMaW51eCBrZXJuZWwpLg0KPiA+ICBJZiB5b3UgdHVybiBvZmYgdGhlIHBvd2VyIHRocm91Z2gg
dGhlIDgwNTEgcmVnaXN0ZXIoREVGX1BXUl9FTl8wPTApLA0KPiA+IFRoZSBjdXJyZW50IG1lYXN1
cmVkIGJ5IHRoZSBjaXJjdWl0IGJvYXJkIGlzIDAuNG1BIG9ubHkuIEluIG9yZGVyIHRvIHNhdmUN
Cj4gcG93ZXIuDQo+ID4gMi5UaGUgcG93ZXIgaXMgbm90IHR1cm5lZCBvZmYgdGhyb3VnaCB0aGUg
ODA1MSByZWdpc3Rlci4NCj4gPiAgVGhlIGN1cnJlbnQgbWVhc3VyZWQgb24gdGhlIGNpcmN1aXQg
Ym9hcmQgaXMgMzNtQSAzLldoZW4gdGhlIHN5c3RlbQ0KPiA+IGxpbnV4IGtlcmVubCBpcyBwb3dl
cmVkIG9mZi4gL2RyaXZlci9ydGMsIC9kcml2ZXIvZ3BpbyBjYW5ub3Qgb3BlcmF0ZS4NCj4gPiAg
IDgwNTEgaXMgc3RpbGwgYWxpdmUgYW5kIG9wZXJhdGlvbmFsDQo+ID4gICA4MDUxIGhhcyBSVEMg
cmVnaXN0ZXIuIFdoZW4gdGhlIHRpbWUgaXMgdXAsIDgwNTEgcG93ZXJzIG9uIHRoZSBzeXN0ZW0N
Cj4gPiAgIFRoZSA4MDUxIGNhbiBkZXRlY3QgR1BJTzB+NyBwaW5zLCBhbmQgR1BJTyBwaW4gaGln
aC9sb3cgY2FuIGJlIHVzZWQgYXMNCj4gYSBwb3dlci1vbiBqdWRnbWVudCBtZWNoYW5pc20gZm9y
IHRoZSBzeXN0ZW0uDQo+IA0KPiBTbyB3aGF0IGRvIHlvdSBuZWVkIHRvIGRvPyAgV2hlbiB0aGUg
a2VybmVsIG5lZWRzIHRvIHNodXQgZG93biB0aGUgc3lzdGVtLA0KPiBzZW5kIGEgbWVzc2FnZSB0
byB0aGlzIGhhcmR3YXJlIGRldmljZT8gIElmIHNvLCBncmVhdCwganVzdCB0aWUgaW50byB0aGUg
bm9ybWFsDQo+IHBvd2VyZG93biBzZXF1ZW5jZSwgdGhpcyBpcyBub3RoaW5nIG5ldy4NCj4gDQoN
ClllcywgCQkJCQkJCQkJDQpwb3dlcm9mZiBjb21tYW5kIC0tLT4gcnVuIG1pc2Mvc3VucGx1c19p
b2MuYy9zcF9pb3BfcGxhdGZvcm1fZHJpdmVyX3NodXRkb3duKCktLS0tPnN3aXRjaCBzdGFuZGJ5
LmJpbiBmb3IgODA1MS0tLT5zZXR0aW5nIDgwNTEgUE1DIHJlZ2lzdGVyLS0tPiBzZW50IGEgbWVz
c2FnZSB0byA4MDUxCQkJDQpROldoeSBuZWVkIHN3aXRjaCBzdGFuZGJ5LmJpbiBmb3IgODA1MT8N
CkE6IDgwNTEgaGFzIHR3byBiaW4gZmlsZXMsIG5vcm1hbC5iaW4gYW5kIHN0YW5kYnkuYmluIGlu
IHJvb3Rmcy4NCk5vcm1hbGx5LCA4MDUxIGV4ZWN1dGVzIG5vcm1hbC5iaW4gY29kZS4gTm9ybWFs
LmJpbiBjb2RlIHNpemUgY2FuIGV4Y2VlZCAxNksuDQpXaGVuIHN5c3RlbSBsaW51eCBrZXJuZWwg
aXMgc2h1dGRvd24sIDgwNTEgaXMgdG8gZXhlY3V0ZSBzdGFuZGJ5LmJpbiBjb2RlLg0KU3RhbmRi
eS5iaW4gY29kZSBjYW5ub3QgZXhjZWVkIDE2SyBieXRlcy4gQmVjYXVzZSA4MDUxIEljYWNoZSBz
aXplIGlzIDE2aw0KODA1MSBydW5zIHdpdGggc3RhbmRieS5iaW4gY29kZSBpbiB0aGUgSWNhY2hl
IGJlZm9yZSB0aGUgc3lzdGVtKGxpbnV4IGtlcm5lbCkgaXMgcG93ZXJvZmYuDQpTbyBJIG5lZWQg
bWlzYy9zdW5wbHVzX2lvcC5jIGludGVyZmFjZSB0byBzd2l0Y2ggYmluIGNvZGUgYW5kIHNlbmRz
IG1lc3NhZ2UgdG8gODA1MS4NCg0KVGhhbmtzDQo=
