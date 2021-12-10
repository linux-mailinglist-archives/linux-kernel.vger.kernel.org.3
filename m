Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1877046F85B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbhLJBXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:23:03 -0500
Received: from mswedge1.sunplus.com ([60.248.182.113]:44472 "EHLO
        mg.sunplus.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231239AbhLJBXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:23:03 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(5128:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Fri, 10 Dec 2021 09:19:23 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Fri, 10 Dec 2021 09:19:24 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Fri, 10 Dec
 2021 09:19:25 +0800
From:   =?big5?B?VG9ueSBIdWFuZyC2wMNoq3A=?= <tony.huang@sunplus.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        =?big5?B?V2VsbHMgTHUgp2aq2sTL?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v3 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHX7Nr0VlQujKq+xkKIOnlLCZbqnqwpakSAgAGDliA=
Date:   Fri, 10 Dec 2021 01:19:25 +0000
Message-ID: <e27e199247d44e31bb71a80ba14f833d@sphcmbx02.sunplus.com.tw>
References: <cover.1639039163.git.tonyhuang.sunplus@gmail.com>
 <bc15d5e8d7a5ec96582799fe513de4ace6fd4b8b.1639039163.git.tonyhuang.sunplus@gmail.com>
 <YbHWKx6AU4z/TJS1@kroah.com>
In-Reply-To: <YbHWKx6AU4z/TJS1@kroah.com>
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

RGVhciBHcmVnOg0KDQo+IE9uIFRodSwgRGVjIDA5LCAyMDIxIGF0IDA0OjU4OjA5UE0gKzA4MDAs
IFRvbnkgSHVhbmcgd3JvdGU6DQo+ID4gKwl3aGlsZSAoMSkgew0KPiA+ICsJCWlmIChwX2lvcF9y
ZWctPmlvcF9kYXRhNyA9PSAweGFhYWEpDQo+ID4gKwkJCWJyZWFrOw0KPiA+ICsJfQ0KPiANCj4g
WW91IGNhbiBub3QgY3JlYXRlIGEgbG9vcCB0aGF0IGNvdWxkIG5ldmVyIGV4aXQuICBQbGVhc2Ug
Zml4Lg0KPiANCg0KT0ssIEkgd2lsbCBtb2RpZnkgaXQuDQoNCj4gQWxzbywgd2hhdCBwcmV2ZW50
cyB0aGUgY29tcGlsZXIgZnJvbSBvcHRpbWl6aW5nIHRoaXMgYXdheSBpbnRvIG5vdGhpbmc/DQo+
IFRoaXMgY29kZSBkb2VzIG5vdCBsb29rIGNvcnJlY3QgYXQgYWxsLg0KPiANCj4gPiArDQo+ID4g
Kwl3cml0ZWwoMHhkZCwgJnBfaW9wX3JlZy0+aW9wX2RhdGExKTsvLzgwNTEgYmluIGZpbGUgY2Fs
bCBVbHRyYSBsb3cNCj4gZnVuY3Rpb24uDQo+ID4gKwltZGVsYXkoMTApOw0KPiA+ICt9DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgaW50ICBzcF9pb3BfZ2V0X25vcm1hbF9jb2RlKHN0cnVjdCBkZXZpY2Ug
KmRldiwgc3RydWN0IHNwX2lvcA0KPiA+ICsqaW9wKSB7DQo+ID4gKwljb25zdCBzdHJ1Y3QgZmly
bXdhcmUgKmZ3Ow0KPiA+ICsJc3RhdGljIGNvbnN0IGNoYXIgZmlsZVtdID0gIm5vcm1hbC5iaW4i
Ow0KPiA+ICsJdW5zaWduZWQgaW50IGVyciwgaTsNCj4gPiArDQo+ID4gKwlkZXZfaW5mbyhkZXYs
ICJub3JtYWwgY29kZVxuIik7DQo+IA0KPiBQbGVhc2UgYWx3YXlzIGRlbGV0ZSB5b3VyIGRlYnVn
Z2luZyBjb2RlIGJlZm9yZSBzdWJtaXR0aW5nIGEgcGF0Y2guDQo+IA0KDQpPSywgSSB3aWxsIGRl
bGV0ZSBpdC4NCg0KPiBBbHNvLCBwbGVhc2UgcnVuIGNoZWNrcGF0Y2gucGwgb24geW91ciBjaGFu
Z2VzIGJlZm9yZSBzdWJtaXR0aW5nIHRoZW0uDQo+IA0KPiB0aGFua3MsDQo+IA0KPiBncmVnIGst
aA0K
