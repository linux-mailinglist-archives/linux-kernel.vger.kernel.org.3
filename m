Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C49468FCD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 04:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhLFDxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 22:53:40 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:42304 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236642AbhLFDxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 22:53:39 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.112
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(5121:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 06 Dec 2021 11:50:08 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 6 Dec 2021 11:50:03 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Mon, 6 Dec 2021
 11:50:03 +0800
From:   =?big5?B?VG9ueSBIdWFuZyC2wMNoq3A=?= <tony.huang@sunplus.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX5/jPsCYr7BDcdE2zYDyk9FgNIqwgDd6AgATJzeA=
Date:   Mon, 6 Dec 2021 03:50:03 +0000
Message-ID: <4bd765590e3e4a5da2cf79be921bac5b@sphcmbx02.sunplus.com.tw>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <Yanzu7/J75n/OCUY@kroah.com>
In-Reply-To: <Yanzu7/J75n/OCUY@kroah.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBHcmVnIEtIOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEdy
ZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBGcmlkYXksIERlY2Vt
YmVyIDMsIDIwMjEgNjozOSBQTQ0KPiBUbzogVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNA
Z21haWwuY29tPg0KPiBDYzogZGVyZWsua2llcm5hbkB4aWxpbnguY29tOyBkcmFnYW4uY3ZldGlj
QHhpbGlueC5jb207IGFybmRAYXJuZGIuZGU7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IFdl
bGxzIEx1IKdmqtrEyyA8d2VsbHMubHVAc3VucGx1cy5jb20+OyBUb255IEh1YW5nILbAw2ircA0K
PiA8dG9ueS5odWFuZ0BzdW5wbHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzJd
IG1pc2M6IEFkZCBpb3AgZHJpdmVyIGZvciBTdW5wbHVzIFNQNzAyMQ0KPiANCj4gT24gRnJpLCBE
ZWMgMDMsIDIwMjEgYXQgMTE6NDg6NDVBTSArMDgwMCwgVG9ueSBIdWFuZyB3cm90ZToNCj4gPiAr
I2RlZmluZSBOT1JNQUxfQ09ERV9NQVhfU0laRSAwWDEwMDANCj4gPiArI2RlZmluZSBTVEFOREJZ
X0NPREVfTUFYX1NJWkUgMHg0MDAwDQo+ID4gK3Vuc2lnbmVkIGNoYXIgaW9wX25vcm1hbF9jb2Rl
W05PUk1BTF9DT0RFX01BWF9TSVpFXTsNCj4gPiArdW5zaWduZWQgY2hhciBpb3Bfc3RhbmRieV9j
b2RlW1NUQU5EQllfQ09ERV9NQVhfU0laRV07DQo+IA0KPiBQbGVhc2UgbWFrZSB5b3VyIGxvY2Fs
IHZhcmlhYmxlcyBzdGF0aWMgc28gdGhhdCB5aG91IGRvIG5vdCBwb2x1dGUgdGhlIGtlcm5lbCdz
DQo+IGdsb2JhbCBzeW1ib2wgdGFibGUuDQo+IA0KDQpJIHdpbGwgbW9kaWZ5IGl0Lg0KDQo+ID4g
Ky8qDQo+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+ICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tICov
IHJlc291cmNlX3NpemVfdCBTUF9JT1BfUkVTRVJWRV9CQVNFOw0KPiA+ICtyZXNvdXJjZV9zaXpl
X3QgU1BfSU9QX1JFU0VSVkVfU0laRTsNCj4gPiArLyoNCj4gPiArLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4g
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gKi8NCj4gDQo+IEFnYWluLCBzdGF0aWMuDQo+IA0K
PiBBbmQgd2h5IHRoZSBvZGQgY29tbWVudCBsaW5lcz8NCj4gDQoNCkkgd2lsbCByZW1vdmUgaXQu
DQoNCj4gQW5kIHRob3NlIGFyZSBub3QgZ29vZCB2YXJpYWJsZSBuYW1lcy4NCj4gDQo+ID4gK3N0
cnVjdCBzcF9pb3Agew0KPiA+ICsJc3RydWN0IG1pc2NkZXZpY2UgZGV2OwkJCS8vIGlvcCBkZXZp
Y2UNCj4gPiArCXN0cnVjdCBtdXRleCB3cml0ZV9sb2NrOw0KPiA+ICsJdm9pZCBfX2lvbWVtICpp
b3BfcmVnczsNCj4gPiArCXZvaWQgX19pb21lbSAqcG1jX3JlZ3M7DQo+ID4gKwl2b2lkIF9faW9t
ZW0gKm1vb24wX3JlZ3M7DQo+ID4gKwlpbnQgaXJxOw0KPiA+ICt9Ow0KPiA+DQo+ICsvKioqKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioN
Cj4gKioqDQo+ID4gKyAqCQkJCQkJICBHIEwgTyBCIEEgTAkgRCBBIFQgQQ0KPiA+ICsNCj4gKioq
KioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioq
KioqKg0KPiAqKi8NCj4gDQo+IEdsb2JhbCB3aGVyZT8gIFdoYXQgYWJvdXQgdGhlIG9uZXMgYWJv
dmU/ICA6KQ0KPiANCg0KSSB3aWxsIHJlbW92ZSBpdC4NCg0KPiA+ICtzdGF0aWMgc3RydWN0IHNw
X2lvcCAqaW9wOw0KPiANCj4gV2h5IGRvIHlvdSB0aGluayB5b3Ugb25seSBoYXZlIG9uZSBkZXZp
Y2UgaW4gdGhlIHN5c3RlbT8gIFBsZWFzZSBkbyBub3QgdXNlDQo+IGEgc2luZ2xlIHZhcmlhYmxl
IGxpa2UgdGhpcy4gIEl0IGlzIGVhc3kgdG8gbWFrZSB5b3VyIGRyaXZlciBoYW5kbGUgYW4gdW5s
aW1pdGVkDQo+IG51bWJlciBvZiBkZXZpY2VzIGp1c3QgYXMgZWFzeSBhcyB0byBoYW5kbGUgMSBk
ZXZpY2UuDQo+IFBsZWFzZSBkbyB0aGF0IGluc3RlYWQgYW5kIGhhbmcgeW91ciBkZXZpY2Utc3Bl
Y2lmaWMgZGF0YSBvZmYgb2YgdGhlIGNvcnJlY3QNCj4gZGF0YSBzdHJ1Y3R1cmVzIHRoYXQgdGhl
IGRyaXZlciBjb3JlIGdpdmVzIHlvdS4NCj4gDQoNCkkgd2lsbCBtb2RpZnkgaXQuDQoNCj4gPiAr
DQo+ID4gK3ZvaWQgaW9wX25vcm1hbF9tb2RlKHZvaWQpDQo+IA0KPiBEaWQgeW91IHJ1biBzcGFy
c2Ugb24gdGhpcyBjb2RlPyAgUGxlYXNlIGRvIHNvLg0KPiANCj4gQWxzbywgbm8gbmVlZCBmb3Ig
YSAuaCBmaWxlIGZvciBhIGRyaXZlciB0aGF0IG9ubHkgaGFzIG9uZSAuYyBmaWxlLg0KPiANCg0K
SSBuZWVkIHRvIGtlZXAgc3VucGx1c19pb3AuaC4gT3RoZXIgZmlsZXMgd2lsbCB1c2Ugc3BfaW9w
X3BsYXRmb3JtX2RyaXZlcl9wb3dlcm9mZih2b2lkKSBpbiBwb3dlcm9mZiBmbG93Lg0KDQo+IHRo
YW5rcywNCj4gDQo+IGdyZWcgay1oDQo=
