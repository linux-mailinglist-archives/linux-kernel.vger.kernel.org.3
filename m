Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82E3A4D9617
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbiCOIZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243406AbiCOIZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:25:05 -0400
Received: from mg.sunplus.com (unknown [113.196.136.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE0BF340D6;
        Tue, 15 Mar 2022 01:23:51 -0700 (PDT)
X-MailGates: (flag:3,DYNAMIC,RELAY,NOHOST:PASS)(compute_score:DELIVER,40
        ,3)
Received: from 172.17.9.202
        by mg01.sunplus.com with MailGates ESMTP Server V5.0(10881:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Tue, 15 Mar 2022 16:24:10 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx01.sunplus.com.tw (172.17.9.202) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Tue, 15 Mar 2022 16:24:10 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Tue, 15 Mar 2022 16:24:10 +0800
From:   =?utf-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "derek.kiernan@xilinx.com" <derek.kiernan@xilinx.com>,
        "dragan.cvetic@xilinx.com" <dragan.cvetic@xilinx.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     =?utf-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Subject: RE: [PATCH v11 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v11 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHYNiyKiBFvNpr0A0KKYrwIrulEkay8iyaAgAHZLPD//5sJAIABr8lg///ZOICAAJbp0A==
Date:   Tue, 15 Mar 2022 08:24:10 +0000
Message-ID: <0d615380aa85444c81e9b93f4a216232@sphcmbx02.sunplus.com.tw>
References: <cover.1647095774.git.tonyhuang.sunplus@gmail.com>
 <07f507a84a9e39d3cd8393f41d1292c250e07642.1647095774.git.tonyhuang.sunplus@gmail.com>
 <00362767-080a-aa7f-672f-22b83ab35e61@kernel.org>
 <42f5f710077b40d7b6fde45789f46732@sphcmbx02.sunplus.com.tw>
 <e4ed4b50-c16f-5c46-7d64-f5b2f36f8f44@kernel.org>
 <58fd70a3fa3d44229edd849cab49eadf@sphcmbx02.sunplus.com.tw>
 <f3c7af9b-85a0-1148-6096-30345f1a1478@kernel.org>
In-Reply-To: <f3c7af9b-85a0-1148-6096-30345f1a1478@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.25.108.54]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGVhciBLcnp5c3p0b2Y6DQoNCg0KPiA+Pj4+IE9uIDEyLzAzLzIwMjIgMTc6MTYsIFRvbnkgSHVh
bmcgd3JvdGU6DQo+ID4+Pj4+IFRoaXMgZHJpdmVyIGlzIGxvYWQgODA1MSBiaW4gY29kZS4NCj4g
Pj4+Pj4gVGhlIElPUCBjb3JlIGlzIERRODA1MSwgc28gYWxzbyBuYW1lZCBJT1A4MDUxLg0KPiA+
Pj4+PiBOZWVkIEluc3RhbGwgRFE4MDUxLCBUaGUgRFE4MDUxIGJpbiBmaWxlIGdlbmVyYXRlZCBi
eSBrZWlsIEMuDQo+ID4+Pj4+IFdlIHdpbGwgcHJvdmlkZSB1c2VycyB3aXRoIDgwNTEgbm9ybWFs
IGFuZCBwb3dlciBvZmYgc291cmNlIGNvZGUuDQo+ID4+Pj4+IFBhdGg6DQo+ID4+Pj4+IGh0dHBz
Oi8vc3VucGx1cy5hdGxhc3NpYW4ubmV0L3dpa2kvc3BhY2VzL2RvYy9wYWdlcy82MTAxNzI5MzMv
DQo+ID4+Pj4+DQo+ID4+Pj4NCj4gPj4NCj4gSG93K3RvK3VzZStJK08rcHJvY2Vzc29yKzgwNTEr
b2YrU1A3MDIxIzUuLVdyaXRlLUMtb3ItYXNzZW1ibHktc291cmNlDQo+ID4+Pj4gSG93K3RvK3Vz
ZStJK08rcHJvY2Vzc29yKzgwNTErb2YrLQ0KPiA+Pj4+PiBmaWxlcy1mb3ItSU9QDQo+ID4+Pj4+
IFVzZXJzIGNhbiBmb2xsb3cgdGhlIG9wZXJhdGlvbiBzdGVwcyB0byBnZW5lcmF0ZSBub3JtYWwu
YmluIGFuZA0KPiA+Pj4+PiBwb3dlcm9mZi5iaW4uDQo+ID4+Pj4+IFBhdGg6DQo+ID4+Pj4+IGh0
dHBzOi8vc3VucGx1cy5hdGxhc3NpYW4ubmV0L3dpa2kvc3BhY2VzL2RvYy9wYWdlcy80NjYxOTAz
MzgNCj4gPj4+Pj4gLzI2LitJT1A4MDUxIDI2LjU/SG93IFRvIENyZWF0ZSA4MDUxIGJpbiBmaWxl
DQo+ID4+Pj4+DQo+ID4+Pj4+IFBNQyBpbiBwb3dlciBtYW5hZ2VtZW50IHB1cnBvc2U6DQo+ID4+
Pj4+IEFkZCBzcF9pb3BfcG93ZXJvZmYoKSBmdW5jdGlvbi4gcG1fcG93ZXJfb2ZmPXNwX2lvcF9w
b3dlcm9mZi4NCj4gPj4+Pj4gV2hlbiB0aGUgcG93ZXIgb2ZmIGNvbW1hbmQgaXMgZXhlY3V0ZWQu
DQo+ID4+Pj4+IFRoZSA4MDUxIGhhcyBhIHJlZ2lzdGVyKERFRl9QV1JfRU5fMD0wKSB0byBjb250
cm9sIHRoZSBwb3dlci1vbg0KPiA+Pj4+PiBhbmQgcG93ZXItb2ZmIG9mIHRoZSBzeXN0ZW0uDQo+
ID4+Pj4+DQo+ID4+Pj4+IFNpZ25lZC1vZmYtYnk6IFRvbnkgSHVhbmcgPHRvbnlodWFuZy5zdW5w
bHVzQGdtYWlsLmNvbT4NCj4gPj4+Pj4gLS0tDQo+ID4+Pj4+IENoYW5nZXMgaW4gdjExOg0KPiA+
Pj4+PiAgLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBBcm5kIEJlcmdtYW5uLg0KPiA+Pj4+DQo+
ID4+Pj4gSG93IGRpZCB5b3UgYWRkcmVzcyBBcm5kJ3MgY29tbWVudHMgYWJvdXQgc3BsaXR0aW5n
IHRoZSBkcml2ZXIgdG8NCj4gPj4+PiBwcm9wZXIgcGFydHM/IGRyaXZlcnMvY2xrIGFuZCBkcml2
ZXJzL3Bvd2VyL3Jlc2V0Pw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4gZHJpdmVycy9jbGsgOiBTUDcw
MjEgc3lzdGVtIGhhcyBjbG9jayBkZXZpY2UgZHJpdmVyIChjbGstc3A3MDIxLmMpLg0KPiA+Pj4g
U28gSSBzZXQgdGhlIElPUCBjbG9jayB0aHJvdWdoIHRoZSBmb2xsb3dpbmcgZnVuY3Rpb24uDQo+
ID4+PiBjbGtfcHJlcGFyZV9lbmFibGUoaW9wLT5pb3BjbGspOw0KPiA+Pj4gY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKGlvcC0+aW9wY2xrKTsNCj4gPj4+DQo+ID4+PiBkcml2ZXJzL3Bvd2VyL3Jlc2V0
IDogU1A3MDIxIHN5c3RlbSBkb2VzIG5vdCBoYXZlIGEgcG93ZXIgb2ZmIGRldmljZQ0KPiBkcml2
ZXIuDQo+ID4+DQo+ID4+IFdoYXQgZG9lcyBpdCBtZWFuPyBUaGUgZmVlZGJhY2sgd2FzIHRvIHNw
bGl0IGNsayBhbmQgcmVzZXQgZmVhdHVyZXMNCj4gPj4gdG8gc2VwYXJhdGUgZHJpdmVycyBhbmQg
SSBzdGlsbCBzZWUgb25seSB0d28gcGF0Y2hlcyBoZXJlIHdpdGggYSBtaXNjDQo+ID4+IGRyaXZl
ci4gU28gaG93IGlzIGhpcyBjb21tZW50cyBhZGRyZXNzZWQ/IFlvdSBkaWQgbm90IHJlcGx5IGlu
IHRoYXQgdGhyZWFkLg0KPiA+Pg0KPiA+DQo+ID4gSSBmaW5pc2hlZCByZXBseWluZyB0byBBcm5k
Lg0KPiA+DQo+ID4+Pg0KPiA+Pj4+PiAgLSBBZGRyZXNzZWQgY29tbWVudHMgZnJvbSBrcnp5c3p0
b2YuDQo+ID4+Pj4+DQo+ID4+Pj4+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ID4+Pj4+ICBkcml2ZXJzL21pc2MvS2NvbmZpZyAgICAgICB8ICAyMyArKysNCj4gPj4+Pj4g
IGRyaXZlcnMvbWlzYy9NYWtlZmlsZSAgICAgIHwgICAxICsNCj4gPj4+Pj4gIGRyaXZlcnMvbWlz
Yy9zdW5wbHVzX2lvcC5jIHwgNDExDQo+ID4+Pj4+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKw0KPiA+Pj4+DQo+ID4+Pj4gVGhlIGRyaXZlciBsb29rcyBsaWtl
IFNvQyBzcGVjaWZpYyBkcml2ZXIuIFdoeSBkaWQgeW91IHB1dCBpdCBpbg0KPiA+Pj4+IGRyaXZl
cnMvbWlzYy8sIG5vdCBpbiB1c3VhbCBwbGFjZSAtIGRyaXZlcnMvc29jLz8NCj4gPj4+DQo+ID4+
PiA4MDUxIGlzIGRlc2lnbmVkIGZvciBwcm9jZXNzaW5nIEkvTyBldmVudHMsIGxpa2UgcmVjZWl2
aW5nIElSIHNpZ25hbA0KPiA+Pj4gZnJvbQ0KPiA+PiByZW1vdGUgY29udHJvbGxlciwNCj4gPj4+
IHRha2luZyBjYXJlIG9mIHBvd2VyIG9uIG9yIG9mZiByZXF1ZXN0cyBmcm9tIFJUQywgb3Igb3Ro
ZXIgaGFyZHdhcmUNCj4gPj4+IGV2ZW50cw0KPiA+PiBvZiBleHRlcm5hbCBwZXJpcGhlcmFscw0K
PiA+Pj4gZXZlbiB3aGVuIHBvd2VyIG9mIG1haW4gc3lzdGVtIGlzIG9mZi4NCj4gPj4+IFNvIEkg
cHV0IGl0IGluIGRyaXZlcnMvbWlzYy4NCj4gPj4NCj4gPj4gSXMgSU9QODA2MSBhIHNlcGFyYXRl
IGRldmljZT8gWW91ciBkYXRhc2hlZXQgaXMgc2F5aW5nIGl0cyBlbWJlZGRlZA0KPiA+PiBpbg0K
PiA+PiBTUDcwMjEgU29DLCBzbyBpdCBpcyBhIHNvYyBkcml2ZXIuIFRoaXMgZG9lcyBub3QgZml0
IG1pc2MgZHJpdmVyDQo+ID4+IGRlc2NyaXB0aW9uIChhICJzdHJhbmdlIGRldmljZSIpIGJ1dCBh
IFNvQyBkcml2ZXIgZGVzY3JpcHRpb24uDQo+ID4+DQo+ID4NCj4gPiBJT1AgaXMgYSBzZXBhcmF0
ZSBkZXZpY2UuIENQVSBpcyA4MDUxLg0KPiA+IFNQNzAyMSBjb250YWlucyB0aHJlZSBraW5kcyBv
ZiBDUFUuDQo+ID4gUXVhZC1jb3JlIEFSTSBDb3J0ZXgtQTcgKENBNykNCj4gPiBBUk05MjYgcmVh
bC10aW1lIGNvcmUNCj4gPiA4MDUxIGxvdy1wb3dlciBjb3JlDQo+ID4NCj4gPj4+DQo+ID4+Pj4g
c3BfaW9wX3Bvd2Vyb2ZmIGlzIHN0aWxsIGhlcmUuDQo+ID4+Pg0KPiA+Pj4gc3BfaW9wX3Bvd2Vy
b2ZmKCk6IFNQNzAyMSBzeXN0ZW0gZG9lcyBub3QgaGF2ZSBhIHBvd2VyIG9mZiBkZXZpY2UgZHJp
dmVyLg0KPiA+Pj4gCQkJCUkgaGF2ZSB0byBwdXQgaXQgaGVyZS4NCj4gPj4NCj4gPj4gVGhpcyBz
aG91bGQgYmUgcmF0aGVyIGluIGEgcmVzZXQgZHJpdmVyLCBub3QgaW4gYSBtaXNjIG9uZS4gV2hh
dCBpcw0KPiA+PiB5b3VyIHBsYW4gZm9yIHRoaXMgZHJpdmVyPyBZb3UgZGVzY3JpYmVkIHRoZSBo
YXJkd2FyZSBhbmQganVkZ2luZyBieQ0KPiA+PiBpdCwgdGhlcmUgd2lsbCBiZSBxdWl0ZSBhIGxv
dCBvZiBzZXBhcmF0ZSBmZWF0dXJlcyBzbyBpdCdzIHJlYXNvbmFibGUNCj4gPj4gdG8gc3BsaXQg
dGhlIGRyaXZlciBpbnRvIHNlcGFyYXRlIGxvZ2ljYWwgZWxlbWVudHMuIEhvd2V2ZXIga2VlcGlu
Zw0KPiA+PiBhbGwgaW4gdGhlIHNhbWUgcGxhY2Ugd291bGQgYmUgb2ssIGlmIHlvdSBkbyBub3Qg
cGxhbiB0byBhZGQgYW55IG1vcmUNCj4gZmVhdHVyZXMuDQo+ID4+IFRoaXMgd291bGQgbWVhbiB0
aGUgZHJpdmVyIHdpbGwgaGFuZGxlICpvbmx5KiByZXNldCBhbmQgRlcgbG9hZGluZy4NCj4gPj4N
Cj4gPg0KPiA+IENhbiBJIHB1dCBzcF9pb3BfcG93ZXJvZmYoKSBoZXJlIGZvciBub3c/DQo+ID4g
V2hlbiBwb3dlciBvZmYgZGV2aWNlIGRyaXZlciBpcyBhZGRlZCBpbiAvZHJpdmVyL3Bvd2VyL3Jl
c2V0IGlzIGNvbXBsZXRlLA0KPiB3ZSB3aWxsIG1vdmUgdG8gaXQuDQo+IA0KPiBOb3QgcmVhbGx5
LCBiZWNhdXNlIG1pc2MgZHJpdmVycyBpcyBub3QgYSBwbGFjZSBmb3IgcG93ZXIgb2ZmIGRyaXZl
cnMuDQo+IFRoZSBkcml2ZXIgaGVyZSBsb29rcyBub3cgbGlrZSByZXNwb25zaWJsZSBvbmx5IGZv
ciBzeXN0ZW0gcG93ZXIgbWFuYWdlbWVudA0KPiBvZiBhIFNvQywgc28gbW9zdCBsaWtlbHkgZHJp
dmVycy9zb2MuIEhvd2V2ZXIgaXQgaGFzIGV2ZW4gbGVzcyBzZW5zZSB0byBhZGQNCj4gc29tZSBm
ZWF0dXJlIGhlcmUgYW5kIGltbWVkaWF0ZWx5IG1vdmUgaXQgc29tZXdoZXJlIG1vcmUgYXBwcm9w
cmlhdGUNCj4gKGluc3RlYWQganVzdCBhZGQgaXQgdG8gdGhlIGFwcHJvcHJpYXRlIHBsYWNlKS4N
Cj4gDQo+IFlvdXIgbW92aW5nIG9mIHBhcnRzIG9mIGl0IHRvIGRyaXZlcnMvcG93ZXIvcmVzZXQg
aXMgbm93IGNvbmZ1c2luZy4gV2hhdCB3aWxsDQo+IGJlIGxlZnQgaGVyZT8gUGxlYXNlIHNlbmQg
ZW50aXJlIHNldCBub3QganVzdCBwaWVjZXMuDQo+IA0KDQpJIG1heSBub3QgZnVsbHkgdW5kZXJz
dGFuZCB5b3VyIHJlcXVpcmVtZW50cy4JCQkJDQpZb3U6IFdoYXQgaXMgeW91ciBwbGFuIGZvciB0
aGlzIGRyaXZlcj8gCQkJCQ0KPCAtLS0tLSByZXNldCBkcml2ZXI/IE1pc2MgZHJpdmVyPwkJCQkN
CllvdTogSG93ZXZlciBrZWVwaW5nIGFsbCBpbiB0aGUgc2FtZSBwbGFjZSB3b3VsZCBiZSBvaywg
aWYgeW91IGRvIG5vdCBwbGFuIHRvIGFkZCBhbnkgbW9yZSBmZWF0dXJlcy4JCQkJDQpUaGlzIHdv
dWxkIG1lYW4gdGhlIGRyaXZlciB3aWxsIGhhbmRsZSAqb25seSogcmVzZXQgYW5kIEZXIGxvYWRp
bmcuCQkJCQ0KPCAtLS0tLS0gCSBCZWNhdXNlIHN5c3RlbSBkb2VzIG5vdCBoYXZlIGEgcG93ZXIg
b2ZmIGRldmljZSBkcml2ZXIuCQkJDQoJc3BfaW9wX3Bvd2Vyb2ZmKCkgY2FuIGJlIHBsYWNlZCBp
biBpb3AgZHJpdmVyPwkJCQ0KDQo=
