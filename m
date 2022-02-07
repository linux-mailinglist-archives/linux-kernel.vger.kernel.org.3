Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E534AB6D3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbiBGIoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:44:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349441AbiBGIdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:33:39 -0500
X-Greylist: delayed 232 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:33:31 PST
Received: from mg.sunplus.com (unknown [113.196.136.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64954C0401DE;
        Mon,  7 Feb 2022 00:33:30 -0800 (PST)
X-MailGates: (compute_score:DELIVER,40,3)
Received: from 172.17.9.112
        by mg02.sunplus.com with MailGates ESMTP Server V5.0(3704:0:AUTH_RELAY)
        (envelope-from <tony.huang@sunplus.com>); Mon, 07 Feb 2022 16:29:46 +0800 (CST)
Received: from sphcmbx02.sunplus.com.tw (172.17.9.112) by
 sphcmbx02.sunplus.com.tw (172.17.9.112) with Microsoft SMTP Server (TLS) id
 15.0.1497.26; Mon, 7 Feb 2022 16:29:40 +0800
Received: from sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd]) by
 sphcmbx02.sunplus.com.tw ([fe80::fd3d:ad1a:de2a:18bd%14]) with mapi id
 15.00.1497.026; Mon, 7 Feb 2022 16:29:40 +0800
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
Subject: RE: [PATCH v8 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Topic: [PATCH v8 2/2] misc: Add iop driver for Sunplus SP7021
Thread-Index: AQHYG+w0qjrtNxJPQEafszlxiITuIayHMAsAgACPEOA=
Date:   Mon, 7 Feb 2022 08:29:40 +0000
Message-ID: <b440dc1dbb044a8c81d083d52774ad6b@sphcmbx02.sunplus.com.tw>
References: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
 <b96f039dc071b1d32bb52fa283fd8afc6d3349cc.1644212476.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0zNeaeOzC_tPb1KDbyktLpjUJCdEu=C6t_QX4pB9TKnQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0zNeaeOzC_tPb1KDbyktLpjUJCdEu=C6t_QX4pB9TKnQ@mail.gmail.com>
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

RGVhciBBcm5kOg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFybmQg
QmVyZ21hbm4gPGFybmRAYXJuZGIuZGU+DQo+IFNlbnQ6IE1vbmRheSwgRmVicnVhcnkgNywgMjAy
MiAzOjQ4IFBNDQo+IFRvOiBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+
DQo+IENjOiBSb2IgSGVycmluZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsgRFRNTCA8ZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmc+Ow0KPiBMaW51eCBLZXJuZWwgTWFpbGluZyBMaXN0IDxsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnPjsgRGVyZWsgS2llcm5hbg0KPiA8ZGVyZWsua2llcm5hbkB4
aWxpbnguY29tPjsgRHJhZ2FuIEN2ZXRpYyA8ZHJhZ2FuLmN2ZXRpY0B4aWxpbnguY29tPjsgQXJu
ZA0KPiBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT47IGdyZWdraCA8Z3JlZ2toQGxpbnV4Zm91bmRh
dGlvbi5vcmc+OyBUb255DQo+IEh1YW5nIOm7g+aHt+WOmiA8dG9ueS5odWFuZ0BzdW5wbHVzLmNv
bT47IFdlbGxzIEx1IOWRguiKs+mosA0KPiA8d2VsbHMubHVAc3VucGx1cy5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjggMi8yXSBtaXNjOiBBZGQgaW9wIGRyaXZlciBmb3IgU3VucGx1cyBT
UDcwMjENCj4gDQo+IE9uIE1vbiwgRmViIDcsIDIwMjIgYXQgNzozMCBBTSBUb255IEh1YW5nDQo+
IDx0b255aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gSU9QKDgwNTEp
IGVtYmVkZGVkIGluc2lkZSBTUDcwMjEgd2hpY2ggaXMgdXNlZCBhcyBQcm9jZXNzb3IgZm9yIEkv
Tw0KPiA+IGNvbnRyb2wsIG1vbml0b3IgUlRDIGludGVycnVwdCBhbmQgY29vcGVyYXRpb24gd2l0
aCBDUFUgJiBQTUMgaW4gcG93ZXINCj4gPiBtYW5hZ2VtZW50IHB1cnBvc2UuDQo+ID4gVGhlIElP
UCBjb3JlIGlzIERRODA1MSwgc28gYWxzbyBuYW1lZCBJT1A4MDUxLCBpdCBzdXBwb3J0cyBkZWRp
Y2F0ZWQNCj4gPiBKVEFHIGRlYnVnIHBpbnMgd2hpY2ggc2hhcmUgd2l0aCBTUDcwMjEuDQo+ID4g
SW4gc3RhbmRieSBtb2RlIG9wZXJhdGlvbiwgdGhlIHBvd2VyIHNwZWMgcmVhY2ggNDAwdUEuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBUb255IEh1YW5nIDx0b255aHVhbmcuc3VucGx1c0BnbWFp
bC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBpbiB2ODoNCj4gPiAgLSBBZGRyZXNzZWQgY29t
bWVudHMgZnJvbSBHcmVnIEtILg0KPiA+DQo+ID4gIERvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
c3lzZnMtcGxhdGZvcm0tc29jQEIgfCAgMjggKysNCj4gPiAgTUFJTlRBSU5FUlMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gIGRyaXZlcnMvbWlzYy9LY29u
ZmlnICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMjAgKysNCj4gPiAgZHJpdmVycy9taXNj
L01ha2VmaWxlICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMSArDQo+ID4gIGRyaXZlcnMv
bWlzYy9zdW5wbHVzX2lvcC5jICAgICAgICAgICAgICAgICAgICAgfCA0NjMNCj4gKysrKysrKysr
KysrKysrKysrKysrKysrKw0KPiA+ICA1IGZpbGVzIGNoYW5nZWQsIDUxNCBpbnNlcnRpb25zKCsp
DQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL0FCSS90ZXN0aW5nL3N5c2Zz
LXBsYXRmb3JtLXNvY0BCDQo+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL21pc2Mvc3Vu
cGx1c19pb3AuYw0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rp
bmcvc3lzZnMtcGxhdGZvcm0tc29jQEINCj4gPiBiL0RvY3VtZW50YXRpb24vQUJJL3Rlc3Rpbmcv
c3lzZnMtcGxhdGZvcm0tc29jQEINCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+IGluZGV4
IDAwMDAwMDAuLmQyNmQ2ZjUNCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4gKysrIGIvRG9jdW1lbnRh
dGlvbi9BQkkvdGVzdGluZy9zeXNmcy1wbGF0Zm9ybS1zb2NAQg0KPiA+IEBAIC0wLDAgKzEsMjgg
QEANCj4gPiArV2hhdDoNCj4gL3N5cy9kZXZpY2VzL3BsYXRmb3JtL3NvY0BCLzljMDAwNDAwLmlv
cC9zcF9pb3BfbWFpbGJveA0KPiA+ICtEYXRlOiAgICAgICAgICBKYW51YXJ5IDIwMjINCj4gPiAr
S2VybmVsVmVyc2lvbjogNS4xNg0KPiA+ICtDb250YWN0OiAgICAgICBUb255IEh1YW5nIDx0b255
aHVhbmcuc3VucGx1c0BnbWFpbC5jb20+DQo+ID4gK0Rlc2NyaXB0aW9uOg0KPiA+ICsgICAgICAg
ICAgICAgICBTaG93IElPUCdzIG1haWxib3gwIHJlZ2lzdGVyIGRhdGEuDQo+ID4gKyAgICAgICAg
ICAgICAgIEZvcm1hdDogJXgNCj4gPiArDQo+ID4gK1doYXQ6DQo+IC9zeXMvZGV2aWNlcy9wbGF0
Zm9ybS9zb2NAQi85YzAwMDQwMC5pb3Avc3BfaW9wX21vZGUNCj4gPiArRGF0ZTogICAgICAgICAg
SmFudWFyeSAyMDIyDQo+ID4gK0tlcm5lbFZlcnNpb246IDUuMTYNCj4gPiArQ29udGFjdDogICAg
ICAgVG9ueSBIdWFuZyA8dG9ueWh1YW5nLnN1bnBsdXNAZ21haWwuY29tPg0KPiA+ICtEZXNjcmlw
dGlvbjoNCj4gPiArICAgICAgICAgICAgICAgUmVhZC1Xcml0ZS4NCj4gPiArDQo+ID4gKyAgICAg
ICAgICAgICAgIFdyaXRlIHRoaXMgZmlsZS4NCj4gPiArICAgICAgICAgICAgICAgT3BlcmF0aW9u
IG1vZGUgb2YgSU9QIGlzIHN3aXRjaGVkIHRvIHN0YW5kYnkgbW9kZSBieQ0KPiB3cml0aW5nDQo+
ID4gKyAgICAgICAgICAgICAgICIxIiB0byBzeXNmcy4NCj4gPiArICAgICAgICAgICAgICAgT3Bl
cmF0aW9uIG1vZGUgb2YgSU9QIGlzIHN3aXRjaGVkIHRvIG5vcm1hbCBtb2RlIGJ5DQo+IHdyaXRp
bmcNCj4gPiArICAgICAgICAgICAgICAgIjAiIHRvIHN5c2ZzLg0KPiA+ICsgICAgICAgICAgICAg
ICBXcml0aW5nIG9mIG90aGVyIHZhbHVlcyBpcyBpbnZhbGlkLg0KPiA+ICsNCj4gPiArICAgICAg
ICAgICAgICAgUmVhZCB0aGlzIGZpbGUuDQo+ID4gKyAgICAgICAgICAgICAgIFNob3cgb3BlcmF0
aW9uIG1vZGUgb2YgSU9QLiAiMCIgaXMgbm9ybWFsIG1vZGUuICIxIiBpcw0KPiBzdGFuZGJ5DQo+
ID4gKyAgICAgICAgICAgICAgIG1vZGUuDQo+ID4gKyAgICAgICAgICAgICAgIEZvcm1hdDogJXgN
Cj4gDQo+IEFzIGRpc2N1c3NlZCBiZWZvcmUsIEkgd291bGQgc3VnZ2VzdCBsZWF2aW5nIG91dCBh
bGwgY3VzdG9tIGF0dHJpYnV0ZXMgZm9yIG5vdywNCj4gYW5kIGZpcnN0IGhvb2tpbmcgdXAgdGhl
IGRyaXZlciB0byBhbGwgdGhlIGluLWtlcm5lbCBzdWJzeXN0ZW1zLg0KPiANCj4gVGhlIG1haWxi
b3gwIHJlZ2lzdGVyIGRhdGEgZGVmaW5pdGVseSBmZWVscyBsaWtlIGFuIGltcGxlbWVudGF0aW9u
IGRldGFpbCwgbm90DQo+IHNvbWV0aGluZyB0aGF0IHNob3VsZCBiZSBleHBvc2VkIHRvIHVzZXIg
c3BhY2UgYXMgYW4gaW50ZXJmYWNlLg0KPiANCj4gRm9yIHN0YW5kYnkgbW9kZSwgdGhpcyB3b3Vs
ZCBub3JtYWxseSBiZSBoYW5kbGVkIGJ5IHRoZSBwb3dlciBtYW5hZ2VtZW50DQo+IHN1YnN5c3Rl
bSBpbiB0aGUga2VybmVsLiBub3QgYSBjdXN0b20gaW50ZXJmYWNlLiBGcm9tIHlvdXIgZWFybGll
ciBkZXNjcmlwdGlvbiwNCj4gSSBhc3N1bWUgdGhpcyBpbnRlcmZhY2UgcHV0cyB0aGUgbWFpbiBD
UFUgaW50byBzdGFuZGJ5IG1vZGUsIG5vdCB0aGUgSU9QLA0KPiByaWdodD8NCj4gDQo+IENQVSBz
dGFuZGJ5IGlzIGhhbmRsZWQgYnkgdGhlIGNwdWlkbGUgc3Vic3lzdGVtLCBzbyB5b3UgbmVlZCBh
IGRyaXZlciBpbg0KPiBkcml2ZXJzL2NwdWlkbGUvIHRvIHJlcGxhY2UgeW91ciBzeXNmcyBhdHRy
aWJ1dGUuDQo+IElmIHlvdSBwbGFuIHRvIGhvb2sgdXAgdGhlIGRyaXZlciB0byBtdWx0aXBsZSBz
dWJzeXN0ZW1zLCBrZWVwaW5nIGEgZ2VuZXJpYw0KPiBkcml2ZXIgZmlsZSBpcyBvaywgc28gIHlv
dSdsbCBlbmQgdXAgd2l0aCB0d28gZHJpdmVyIG1vZHVsZXMsIHdpdGggb25lIG9mIHRoZW0NCj4g
Y2FsbGluZyBpbnRvIHRoZSBvdGhlciwgdXNpbmcNCj4gRVhQT1JUX1NZTUJPTCgpIHRvIGxpbmsg
YmV0d2VlbiB0aGVtLg0KPiANCg0KVGhlIHB1cnBvc2Ugb2YgYWRkaW5nIHN5c2ZzIGlzIG9ubHkg
Zm9yIHVzZXJzIHRvIGRlYnVnLg0KU28gdGhpcyBpcyBub3QgbmVlZGVkPw0KDQpUaGFua3MNCg==
