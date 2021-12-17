Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71086478F55
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235239AbhLQPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:17:11 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:51504
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235100AbhLQPQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:16:55 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(9396:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Fri, 17 Dec 2021 23:16:59 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Fri, 17 Dec 2021 23:16:53 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Fri, 17 Dec 2021 23:16:53 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX7Nr0VlQujKq+xkKIOnlLCZbqnqwpZLYAgA1h0BA=
Date:   Fri, 17 Dec 2021 15:16:53 +0000
Message-ID: <5c01390c485a44b6913dcb42e3677ed1@sphcmbx02.sunplus.com.tw>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
In-Reply-To: <CAK8P3a2UGr6ZbHk6G=wh5XG_EGdJxGf6SfyN1sTb4aaUgiK8Lw@mail.gmail.com>
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

RGVhciBBcm5kOg0KDQo+IE9uIFRodSwgRGVjIDksIDIwMjEgYXQgOTo1OCBBTSBUb255IEh1YW5n
IDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gSU9QIChJ
TyBQcm9jZXNzb3IpIGVtYmVkZGVkIGluc2lkZSBTUDcwMjEgd2hpY2ggaXMgdXNlZCBhcyBQcm9j
ZXNzb3INCj4gPiBmb3IgSS9PIGNvbnRyb2wsIFJUQyB3YWtlLXVwIGFuZCBjb29wZXJhdGlvbiB3
aXRoIENQVSAmIFBNQyBpbiBwb3dlcg0KPiA+IG1hbmFnZW1lbnQgcHVycG9zZS4NCj4gPiBUaGUg
SU9QIGNvcmUgaXMgRFE4MDUxLCBzbyBhbHNvIG5hbWVkIElPUDgwNTEsIGl0IHN1cHBvcnRzIGRl
ZGljYXRlZA0KPiA+IEpUQUcgZGVidWcgcGlucyB3aGljaCBzaGFyZSB3aXRoIFNQNzAyMS4NCj4g
PiBJbiBzdGFuZGJ5IG1vZGUgb3BlcmF0aW9uLCB0aGUgcG93ZXIgc3BlYyByZWFjaCA0MDB1QS4N
Cj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdt
YWlsLmNvbT4NCj4gDQo+IFRoYW5rcyBmb3IgdGhlIGltcHJvdmVtZW50cywgdGhpcyBhZ2FpbiBs
b29rcyBiZXR0ZXIgdGhhbiB0aGUgcHJldmlvdXMgdmVyc2lvbi4NCj4gSSBzdGlsbCBoYXZlIHNv
bWUgbWlub3IgY29tbWVudHMsIGFuZCB0aGVyZSBhcmUgYSBjb3VwbGUgb2YgZGV0YWlscyBJIGhh
dmUNCj4gY29tbWVudGVkIG9uIGJlZm9yZSB0aGF0IHdvdWxkIG5lZWQgdG8gYmUgYWRkcmVzc2Vk
LCBidXQgbGV0J3MgZm9jdXMgb24gdGhlDQo+IG9uZSBtYWluIGlzc3VlIGZvciBub3c6DQo+IA0K
PiBUaGUgZHJpdmVyIHN0aWxsIGRvZXNuJ3QgYWN0dWFsbHkgL2RvLyBhbnl0aGluZzogeW91IGxv
YWQgdGhlIGZpcm13YXJlIHdoZW4gdGhlDQo+IGRyaXZlciBpcyBsb2FkZWQsIGFuZCB5b3Ugc2h1
dCBpdCBkb3duIHdoZW4gdGhlIGRyaXZlciBpcyByZW1vdmVkLCBidXQNCj4gb3RoZXJ3aXNlIHRo
ZXJlIGlzIG5vIHdheSB0byBpbnRlcmFjdCB3aXRoIHRoZSBpb3AuIFlvdSBoYWQgdGhlIG1pc2Nk
ZXZpY2UNCj4gZWFybGllciwgYW5kIHlvdSBzdGlsbCByZWdpc3RlciB0aGF0LCBidXQgdGhlcmUg
YXJlIG5vIGZpbGVfb3BlcmF0aW9ucyBhc3NvY2lhdGVkDQo+IHdpdGggaXQsIHNvIGl0IHN0aWxs
IGRvZXNuJ3QgaGF2ZSBhbnkgZWZmZWN0Lg0KPiANCj4gSW4gdGhlIG9yaWdpbmFsIHZlcnNpb24g
eW91IGhhZCBhIGNvdXBsZSBvZiB1c2VyLXNpZGUgaW50ZXJmYWNlcywgZm9yIHdoaWNoIEdyZWcN
Cj4gYW5kIEkgY29tbWVudGVkIHRoYXQgdGhleSB3ZXJlIG5vdCB1c2luZyB0aGUgY29ycmVjdCBh
YnN0cmFjdGlvbnMsIGFuZCB5b3UNCj4gc3RpbGwgbGlzdCB0aGVtIGluIHRoZSBjaGFuZ2Vsb2cg
dGV4dCBhcyAiSS9PIGNvbnRyb2wsIFJUQyB3YWtlLXVwIGFuZA0KPiBjb29wZXJhdGlvbiB3aXRo
IENQVSAmIFBNQyBpbiBwb3dlciBtYW5hZ2VtZW50Ii4NCj4gDQo+IElmIHlvdSB3YW50IHRvIG1h
a2UgYW55IHByb2dyZXNzIHdpdGggYWRkaW5nIHRoZSBkcml2ZXIsIEknZCBzYXkgeW91IHNob3Vs
ZA0KPiBpbXBsZW1lbnQgYXQgbGVhc3QgdHdvIG9mIHRob3NlIGhpZ2gtbGV2ZWwgaW50ZXJmYWNl
cyB0aGF0IGludGVyYWN0IHdpdGggdGhlDQo+IHJlc3BlY3RpdmUga2VybmVsIHN1YnN5c3RlbXMg
aW4gb3JkZXIgdG8gc2hvdyB0aGF0IHRoZSBhYnN0cmFjdGlvbiB3b3Jrcy4NCj4gDQoNClE6Indp
dGggcmVzcGVjdGl2ZSBrZXJuZWwgc3Vic3lzdGVtcyBpbiBvcmRlciB0byBzaG93IHRoYXQgdGhl
IGFic3RyYWN0aW9uIHdvcmtzLiINCk1heSBJIGFzayB5b3UgYWJvdXQgcmVwZWN0aXZlIGtlcm5l
bCBzdWJzeXN0ZW0uDQpJZiBJIHVzZSB0aGUgZmlsZV9vcGVyYXRpb24gbWV0aG9kDQpQcm92aWRl
IHVzZXIgY2FuIHJlYWQgYW5kIHdyaXRlIElPUCg4MDUxKSdzIHJlZ2lzdGVyLg0KSXMgdGhpcyBh
IHJlcGVjdGl2ZSBrZXJuZWwgc3Vic3lzdGVtPw0KaWYgbm90DQpUaGVyZSBhcmUgb3RoZXIgZHJp
dmVyIGNvZGUgY2FuIGdpdmUgbWUgcmVmZXJlbmNlDQoNCg==
