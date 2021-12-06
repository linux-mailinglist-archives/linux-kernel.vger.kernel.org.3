Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FC469087
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbhLFGwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 01:52:22 -0500
Received: from 113.196.136.162.ll.static.sparqnet.net ([113.196.136.162]:56810
        "EHLO mg.sunplus.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231181AbhLFGwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:52:16 -0500
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(5127:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 06 Dec 2021 14:48:46 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 6 Dec 2021 14:48:46 +0800
Received: from sphcmbx02.sunplus.com.tw ([::1]) by sphcmbx02.sunplus.com.tw
 ([fe80::f8bb:bd77:a854:5b9e%14]) with mapi id 15.00.1497.023; Mon, 6 Dec 2021
 14:48:46 +0800
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
Thread-Index: AQHX5/jPsCYr7BDcdE2zYDyk9FgNIqwgDf+AgAT8TFA=
Date:   Mon, 6 Dec 2021 06:48:46 +0000
Message-ID: <5ab2710b37784d51a3f4f90f625ae907@sphcmbx02.sunplus.com.tw>
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <Yanz1xpZamJVZ0LE@kroah.com>
In-Reply-To: <Yanz1xpZamJVZ0LE@kroah.com>
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

RGVhciBHcmVnIEtILCBBcm5kOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZy
b206IEdyZWcgS0ggPGdyZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPg0KPiBTZW50OiBGcmlkYXks
IERlY2VtYmVyIDMsIDIwMjEgNjozOSBQTQ0KPiBUbzogVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1
bnBsdXNAZ21haWwuY29tPg0KPiBDYzogZGVyZWsua2llcm5hbkB4aWxpbnguY29tOyBkcmFnYW4u
Y3ZldGljQHhpbGlueC5jb207IGFybmRAYXJuZGIuZGU7DQo+IGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc7IHJvYmgrZHRAa2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7
DQo+IFdlbGxzIEx1IKdmqtrEyyA8d2VsbHMubHVAc3VucGx1cy5jb20+OyBUb255IEh1YW5nILbA
w2ircA0KPiA8dG9ueS5odWFuZ0BzdW5wbHVzLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2
MiAyLzJdIG1pc2M6IEFkZCBpb3AgZHJpdmVyIGZvciBTdW5wbHVzIFNQNzAyMQ0KPiANCj4gT24g
RnJpLCBEZWMgMDMsIDIwMjEgYXQgMTE6NDg6NDVBTSArMDgwMCwgVG9ueSBIdWFuZyB3cm90ZToN
Cj4gPiBJT1AgKElPIFByb2Nlc3NvcikgZW1iZWRkZWQgaW5zaWRlIFNQNzAyMSB3aGljaCBpcyB1
c2VkIGFzIFByb2Nlc3Nvcg0KPiA+IGZvciBJL08gY29udHJvbCwgUlRDIHdha2UtdXAgYW5kIGNv
b3BlcmF0aW9uIHdpdGggQ1BVICYgUE1DIGluIHBvd2VyDQo+ID4gbWFuYWdlbWVudCBwdXJwb3Nl
Lg0KPiA+IFRoZSBJT1AgY29yZSBpcyBEUTgwNTEsIHNvIGFsc28gbmFtZWQgSU9QODA1MSwgaXQg
c3VwcG9ydHMgZGVkaWNhdGVkDQo+ID4gSlRBRyBkZWJ1ZyBwaW5zIHdoaWNoIHNoYXJlIHdpdGgg
U1A3MDIxLg0KPiA+IEluIHN0YW5kYnkgbW9kZSBvcGVyYXRpb24sIHRoZSBwb3dlciBzcGVjIHJl
YWNoIDQwMHVBLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogVG9ueSBIdWFuZyA8dG9ueWh1YW5n
LnN1bnBsdXNAZ21haWwuY29tPg0KPiA+IC0tLQ0KPiA+IENoYW5nZXMgaW4gdjI6DQo+ID4gIC0g
QWRkcmVzc2VkIGNvbW1lbnRzIGZyb20gQXJuZCBCZXJnbWFubi4NCj4gPiAgLSBBZGRyZXNzZWQg
Y29tbWVudHMgZnJvbSBHcmVnIEtILg0KPiA+ICAtIEFkZHJlc3NlZCBjb21tZW50cyBmcm9tIGtl
cm5lbCB0ZXN0IHJvYm90Lg0KPiA+DQo+ID4gIE1BSU5UQUlORVJTICAgICAgICAgICAgICAgICAg
ICB8ICAgMSArDQo+ID4gIGRyaXZlcnMvbWlzYy9LY29uZmlnICAgICAgICAgICB8ICAgMSArDQo+
ID4gIGRyaXZlcnMvbWlzYy9NYWtlZmlsZSAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMv
bWlzYy9pb3AvS2NvbmZpZyAgICAgICB8ICAxMyArKw0KPiA+ICBkcml2ZXJzL21pc2MvaW9wL01h
a2VmaWxlICAgICAgfCAgIDYgKw0KPiANCj4gV2h5IGRvIHlvdSBuZWVkIGEgc3ViZGlyZWN0b3J5
IGZvciBhIHNpbmdsZSAuYyBmaWxlPw0KPiANCg0KMS4gQ3VycmVudGx5IG15IGJpbiBmaWxlIGlz
IHBsYWNlZCBpbiB0aGUgcm9vdCBmaWxlIHN5c3RlbS4gSSBuZWVkIHRvIHdhaXQgZm9yIHRoZSBr
ZXJuZWwgYm9vdGluZyB0byBzdWNjZWVkIGJlZm9yZSBsb2FkaW5nIHRoZSBiaW4gY29kZS4NCjIu
IEluIGFkZGl0aW9uLCBJIG5lZWQgdGhlIGtlcm5lbCBib290aW5nIHByb2Nlc3MgdG8gYmUgYWJs
ZSB0byBtb3VudCB0aGUgaW9wIG1vZHVsZSBhbmQgbG9hZCBiaW4gZmlsZS5JIG5lZWQgdG8gcHV0
IGJpbiBmaWxlIGluIC9pb3AuDQpEbyB5b3UgaGF2ZSBhIGdvb2Qgd2F5IHRvIGxvYWQgYmluIGNv
ZGUgZHVyaW5nIGtlcm5lbCBib290aW5nPw0KDQpUaGFua3MNCg==
