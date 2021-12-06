Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1B0246915E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbhLFIZt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 03:25:49 -0500
Received: from 113.196.136.146.ll.static.sparqnet.net ([113.196.136.146]:33236
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S239064AbhLFIZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:25:48 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(31407:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 06 Dec 2021 16:22:01 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 6 Dec 2021 16:22:01 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Mon, 6 Dec 2021
 16:22:01 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     Tony Huang <tonyhuang.sunplus@gmail.com>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX5/jPsCYr7BDcdE2zYDyk9FgNIqwgDf+AgAT8TFD//5ALgIAAiHcw
Date:   Mon, 6 Dec 2021 08:22:01 +0000
Message-ID: <2e7d5df0cbe74f2697709ed3e8c94b0b@sphcmbx02.sunplus.com.tw>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <Yanz1xpZamJVZ0LE@kroah.com>
 <5ab2710b37784d51a3f4f90f625ae907@sphcmbx02.sunplus.com.tw>
 <Ya3EjykU5RMaRbkt@kroah.com>
In-Reply-To: <Ya3EjykU5RMaRbkt@kroah.com>
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

RGVhciBHcmVnIEtIOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdy
ZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBNb25kYXksIERlY2Vt
YmVyIDYsIDIwMjEgNDowNyBQTQ0KPiBUbzogVG9ueSBIdWFuZyDpu4Pmh7fljpogPHRvbnkuaHVh
bmdAc3VucGx1cy5jb20+DQo+IENjOiBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFp
bC5jb20+OyBkZXJlay5raWVybmFuQHhpbGlueC5jb207DQo+IGRyYWdhbi5jdmV0aWNAeGlsaW54
LmNvbTsgYXJuZEBhcm5kYi5kZTsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gcm9i
aCtkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgV2VsbHMgTHUg5ZGC
6Iqz6aiwDQo+IDx3ZWxscy5sdUBzdW5wbHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAyLzJdIG1pc2M6IEFkZCBpb3AgZHJpdmVyIGZvciBTdW5wbHVzIFNQNzAyMQ0KPiANCj4gT24g
TW9uLCBEZWMgMDYsIDIwMjEgYXQgMDY6NDg6NDZBTSArMDAwMCwgVG9ueSBIdWFuZyDpu4Pmh7fl
jpogd3JvdGU6DQo+ID4gRGVhciBHcmVnIEtILCBBcm5kOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTogR3JlZyBLSCA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+DQo+ID4gPiBTZW50OiBGcmlkYXksIERlY2VtYmVyIDMsIDIwMjEgNjozOSBQTQ0K
PiA+ID4gVG86IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVzQGdtYWlsLmNvbT4NCj4gPiA+
IENjOiBkZXJlay5raWVybmFuQHhpbGlueC5jb207IGRyYWdhbi5jdmV0aWNAeGlsaW54LmNvbTsN
Cj4gPiA+IGFybmRAYXJuZGIuZGU7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHJvYmgr
ZHRAa2VybmVsLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBXZWxscyBM
dSDlkYLoirPpqLAgPHdlbGxzLmx1QHN1bnBsdXMuY29tPjsNCj4gPiA+IFRvbnkgSHVhbmcg6buD
5oe35Y6aDQo+ID4gPiA8dG9ueS5odWFuZ0BzdW5wbHVzLmNvbT4NCj4gPiA+IFN1YmplY3Q6IFJl
OiBbUEFUQ0ggdjIgMi8yXSBtaXNjOiBBZGQgaW9wIGRyaXZlciBmb3IgU3VucGx1cyBTUDcwMjEN
Cj4gPiA+DQo+ID4gPiBPbiBGcmksIERlYyAwMywgMjAyMSBhdCAxMTo0ODo0NUFNICswODAwLCBU
b255IEh1YW5nIHdyb3RlOg0KPiA+ID4gPiBJT1AgKElPIFByb2Nlc3NvcikgZW1iZWRkZWQgaW5z
aWRlIFNQNzAyMSB3aGljaCBpcyB1c2VkIGFzDQo+ID4gPiA+IFByb2Nlc3NvciBmb3IgSS9PIGNv
bnRyb2wsIFJUQyB3YWtlLXVwIGFuZCBjb29wZXJhdGlvbiB3aXRoIENQVSAmDQo+ID4gPiA+IFBN
QyBpbiBwb3dlciBtYW5hZ2VtZW50IHB1cnBvc2UuDQo+ID4gPiA+IFRoZSBJT1AgY29yZSBpcyBE
UTgwNTEsIHNvIGFsc28gbmFtZWQgSU9QODA1MSwgaXQgc3VwcG9ydHMNCj4gPiA+ID4gZGVkaWNh
dGVkIEpUQUcgZGVidWcgcGlucyB3aGljaCBzaGFyZSB3aXRoIFNQNzAyMS4NCj4gPiA+ID4gSW4g
c3RhbmRieSBtb2RlIG9wZXJhdGlvbiwgdGhlIHBvd2VyIHNwZWMgcmVhY2ggNDAwdUEuDQo+ID4g
PiA+DQo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5wbHVz
QGdtYWlsLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gPiA+
ICAtIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIEFybmQgQmVyZ21hbm4uDQo+ID4gPiA+ICAtIEFk
ZHJlc3NlZCBjb21tZW50cyBmcm9tIEdyZWcgS0guDQo+ID4gPiA+ICAtIEFkZHJlc3NlZCBjb21t
ZW50cyBmcm9tIGtlcm5lbCB0ZXN0IHJvYm90Lg0KPiA+ID4gPg0KPiA+ID4gPiAgTUFJTlRBSU5F
UlMgICAgICAgICAgICAgICAgICAgIHwgICAxICsNCj4gPiA+ID4gIGRyaXZlcnMvbWlzYy9LY29u
ZmlnICAgICAgICAgICB8ICAgMSArDQo+ID4gPiA+ICBkcml2ZXJzL21pc2MvTWFrZWZpbGUgICAg
ICAgICAgfCAgIDEgKw0KPiA+ID4gPiAgZHJpdmVycy9taXNjL2lvcC9LY29uZmlnICAgICAgIHwg
IDEzICsrDQo+ID4gPiA+ICBkcml2ZXJzL21pc2MvaW9wL01ha2VmaWxlICAgICAgfCAgIDYgKw0K
PiA+ID4NCj4gPiA+IFdoeSBkbyB5b3UgbmVlZCBhIHN1YmRpcmVjdG9yeSBmb3IgYSBzaW5nbGUg
LmMgZmlsZT8NCj4gPiA+DQo+ID4NCj4gPiAxLiBDdXJyZW50bHkgbXkgYmluIGZpbGUgaXMgcGxh
Y2VkIGluIHRoZSByb290IGZpbGUgc3lzdGVtLiBJIG5lZWQgdG8NCj4gPiB3YWl0IGZvciB0aGUg
a2VybmVsIGJvb3RpbmcgdG8gc3VjY2VlZCBiZWZvcmUgbG9hZGluZyB0aGUgYmluIGNvZGUuDQo+
IA0KPiBXaGF0ICJiaW4gZmlsZSI/DQo+IA0KDQpJT1AgTU9EVUxFIEVYRUNVVEVTIDgwNTEgQ09E
RQ0KU291cmNlIGNvZGUgc2hvdWxkIHJlc2VydmUgU0RSQU0gbWVtb3J5IGFyZWEgZm9yIElPUCBt
b2R1bGUgY29kZS4gODA1MSBiaW4gZmlsZSBub3JtYWwgY29kZSBhbmQgc3RhbmRieSBjb2RlIGNh
biBiZSBwbGFjZWQgaW4gdGhpcyBhcmVhLiBUaGUgbG9jYXRpb24gYXJlYSBjYW4gYmUgc2VsZWN0
IGJ5IHVzZXIuDQpOb3JtYWwgY29kZTogTW9uaXRvciBDUFUgY29tbWFuZHMuDQpTdGFuZGJ5IGNv
ZGU6IEZvciBSVEMgd2FrZSB1cCwgY29vcGVyYXRpb24gd2l0aCBDUFUmUE1DIGluIHBvd2VyIG1h
bmFnZW1lbnQgV2hlbiB0aGUgc3lzdGVtIGVudGVycyBzdGFuZGJ5IG1vZGUsIDgwNTEgYmluIGZp
bGUgc2hvdWxkIGJlIG1vdmVkIHRvIElfQ2FjaGUuDQpJX0NhY2hlIGhhcyAxNksgb25seS4gU3Rh
bmRieSBjb2RlIGNhbm5vdCBleGNlZWQgMTZLLg0KV2hlbiB0aGUgSU9QIG1vZHVsZSBpcyBtb3Vu
dGVkLCBDUFUgbG9hZCA4MDUxIGNvZGVzIChub3JtYWwuYmluKSBpbnRvIG1lbW9yeS4NCklvcF9i
YXNlX2FkZHJfbCBhbmQgaW9wX2Jhc2VfYWRkcl9oIHNwZWNpZnkgYWRkcmVzcy4NCkR1cmluZyBz
eXN0ZW0gYm9vdCB1cCwgd2hlbiB0aGUgSU9QIGlzIG1vdW50ZWQsIGl0IHdpbGwgbG9hZCA4MDUx
IG5vcm1hbCBjb2RlIGFuZCBzdGFydCBleGVjdXRlIDgwNTEgY29kZS4NCg0KPiA+IDIuIEluIGFk
ZGl0aW9uLCBJIG5lZWQgdGhlIGtlcm5lbCBib290aW5nIHByb2Nlc3MgdG8gYmUgYWJsZSB0byBt
b3VudA0KPiA+IHRoZSBpb3AgbW9kdWxlIGFuZCBsb2FkIGJpbiBmaWxlLkkgbmVlZCB0byBwdXQg
YmluIGZpbGUgaW4gL2lvcC4NCj4gDQo+IFRoYXQgaXMgYW4gb2RkIGRpcmVjdG9yeSBsb2NhdGlv
bi4NCj4gDQo+ID4gRG8geW91IGhhdmUgYSBnb29kIHdheSB0byBsb2FkIGJpbiBjb2RlIGR1cmlu
ZyBrZXJuZWwgYm9vdGluZz8NCj4gDQo+IElzIHRoaXMgZmlybXdhcmU/ICBQdXQgaXQgaW4gdGhl
IG5vcm1hbCBsb2NhdGlvbiBmb3IgZmlyd2FyZSB0aGF0IHRoZSBrZXJuZWwNCj4gZXhwZWN0cyB0
byBzZWUuDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGstaA0K
