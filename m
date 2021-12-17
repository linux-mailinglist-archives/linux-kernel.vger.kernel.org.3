Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 570FC478324
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 03:25:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbhLQCZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 21:25:43 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:53276 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhLQCZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 21:25:41 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1BH2P8DH0015207, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1BH2P8DH0015207
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Dec 2021 10:25:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 10:25:08 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 17 Dec 2021 10:25:07 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::1939:37f0:5383:397d]) by
 RTEXMBS01.realtek.com.tw ([fe80::1939:37f0:5383:397d%5]) with mapi id
 15.01.2308.015; Fri, 17 Dec 2021 10:25:07 +0800
From:   =?utf-8?B?RGVyZWsgW+aWueW+t+e+qV0=?= <derek.fang@realtek.com>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        =?utf-8?B?U2h1bWluZyBb6IyD5pu46YqYXQ==?= <shumingf@realtek.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     Oder Chiou <oder_chiou@realtek.com>,
        "Sunil-kumar.Dommati@amd.com" <Sunil-kumar.Dommati@amd.com>,
        open list <linux-kernel@vger.kernel.org>,
        "Basavaraj.Hiregoudar@amd.com" <Basavaraj.Hiregoudar@amd.com>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Vijendar.Mukunda@amd.com" <Vijendar.Mukunda@amd.com>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>,
        Jack Yu <jack.yu@realtek.com>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Albert Chen <albertchen@realtek.com>
Subject: RE: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP playback output
Thread-Topic: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP
 playback output
Thread-Index: AQHX7GWRI6k5NgtuD0uEox0/duGRXKwo6UkAgAucCICAAXxS8A==
Date:   Fri, 17 Dec 2021 02:25:07 +0000
Message-ID: <372f49bfa3cf45838ffa994a14e844c0@realtek.com>
References: <20211208185517.1555884-1-AjitKumar.Pandey@amd.com>
 <20211208185517.1555884-2-AjitKumar.Pandey@amd.com>
 <126eab881bb540bc84ecc5cb9c6865a8@realtek.com>
 <a08db422-7f51-4156-5e9e-62b7938dad29@amd.com>
In-Reply-To: <a08db422-7f51-4156-5e9e-62b7938dad29@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.142]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzE2IOS4i+WNiCAxMToyODowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMV0gQVNvQzogcnQ1NjgyczogQWRkIGRhcG0gc3dp
dGNoIHRvIG11dGUvdW5tdXRlDQo+IEhQIHBsYXliYWNrIG91dHB1dA0KPiANCj4gT24gMTIvOS8y
MDIxIDc6NTUgQU0sIFNodW1pbmcgW+iMg+abuOmKmF0gd3JvdGU6DQo+ID4gW0NBVVRJT046IEV4
dGVybmFsIEVtYWlsXQ0KPiA+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB2MiAxLzFdIEFTb0M6IHJ0
NTY4MnM6IEFkZCBkYXBtIHN3aXRjaCB0byBtdXRlL3VubXV0ZSBIUA0KPiA+PiBwbGF5YmFjayBv
dXRwdXQNCj4gPj4NCj4gPj4gQWRkIGRhcG0gc3dpdGNoIGluIHBsYXliYWNrIHBhdGggdG8gbXV0
ZSBvciB1bm11dGUgSFAgb3V0cHV0IGRhdGEuDQo+ID4+IFdlIHdpbGwgc2V0IGFuZCByZXNldCBN
VVRFX1NGVCBiaXQgaW4gUlQ1NjgyU19IUF9DVFJMXzEgcmVnaXN0ZXIgYmFzZWQgb24NCj4gPj4g
c3dpdGNoIHZhbHVlIHRvIG11dGUgb3IgdW5tdXRlIHJlc3BlY3RpdmUgY2hhbm5lbC4NCj4gPj4N
Cj4gPj4gU2lnbmVkLW9mZi1ieTogQWppdCBLdW1hciBQYW5kZXkgPEFqaXRLdW1hci5QYW5kZXlA
YW1kLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICAgc291bmQvc29jL2NvZGVjcy9ydDU2ODJzLmMgfCAx
OSArKysrKysrKysrKysrKysrKy0tDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlv
bnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9zb3VuZC9zb2Mv
Y29kZWNzL3J0NTY4MnMuYyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQ1Njgycy5jIGluZGV4DQo+ID4+
IGQ0OWE0ZjY4NTY2ZC4uMjFhYjVmN2RmNDIyIDEwMDY0NA0KPiA+PiAtLS0gYS9zb3VuZC9zb2Mv
Y29kZWNzL3J0NTY4MnMuYw0KPiA+PiArKysgYi9zb3VuZC9zb2MvY29kZWNzL3J0NTY4MnMuYw0K
PiA+PiBAQCAtMTU3Myw2ICsxNTczLDE0IEBAIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QNCj4g
Pj4gcnQ1Njgyc19hZGNkYXRfcGluX3NlbGVjdFtdID0gew0KPiA+PiAgICAgICAgIkFEQ0RBVDEi
LCAiQURDREFUMiIsDQo+ID4+ICAgfTsNCj4gPj4NCj4gPj4gKy8qIE91dCBTd2l0Y2ggKi8NCj4g
Pj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBocG9sX3N3aXRjaCA9DQo+
ID4+ICsgICAgIFNPQ19EQVBNX1NJTkdMRV9BVVRPRElTQUJMRSgiU3dpdGNoIiwgUlQ1NjgyU19I
UF9DVFJMXzEsDQo+ID4+ICsgICAgICAgICAgICAgUlQ1NjgyU19MX01VVEVfU0ZULCAxLCAxKTsN
Cj4gPj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBocG9yX3N3aXRjaCA9
DQo+ID4+ICsgICAgIFNPQ19EQVBNX1NJTkdMRV9BVVRPRElTQUJMRSgiU3dpdGNoIiwgUlQ1Njgy
U19IUF9DVFJMXzEsDQo+ID4+ICsgICAgICAgICAgICAgUlQ1NjgyU19SX01VVEVfU0ZULCAxLCAx
KTsNCj4gPj4gKw0KPiA+PiAgIHN0YXRpYyBTT0NfVkFMVUVfRU5VTV9TSU5HTEVfREVDTChydDU2
ODJzX2FkY2RhdF9waW5fZW51bSwNCj4gPj4gICAgICAgIFJUNTY4MlNfR1BJT19DVFJMXzEsIFJU
NTY4MlNfR1A0X1BJTl9TRlQsDQo+ID4+IFJUNTY4MlNfR1A0X1BJTl9NQVNLLA0KPiA+PiAgICAg
ICAgcnQ1Njgyc19hZGNkYXRfcGluX3NlbGVjdCwgcnQ1Njgyc19hZGNkYXRfcGluX3ZhbHVlcyk7
IEBADQo+IC0xNzQ2LDYNCj4gPj4gKzE3NTQsMTEgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBzbmRf
c29jX2RhcG1fd2lkZ2V0DQo+ID4+IHJ0NTY4MnNfZGFwbV93aWRnZXRzW10gPSB7DQo+ID4+ICAg
ICAgICBTTkRfU09DX0RBUE1fUEdBX1MoIkhQIEFtcCIsIDEsIFNORF9TT0NfTk9QTSwgMCwgMCwN
Cj4gPj4gcnQ1Njgyc19ocF9hbXBfZXZlbnQsDQo+ID4+ICAgICAgICAgICAgICAgIFNORF9TT0Nf
REFQTV9QT1NUX1BNRCB8DQo+IFNORF9TT0NfREFQTV9QT1NUX1BNVSksDQo+ID4+DQo+ID4+ICsg
ICAgIFNORF9TT0NfREFQTV9TV0lUQ0goIkhQT0wgUGxheWJhY2siLCBTTkRfU09DX05PUE0sIDAs
IDAsDQo+ID4+ICsgICAgICAgICAgICAgJmhwb2xfc3dpdGNoKSwNCj4gPj4gKyAgICAgU05EX1NP
Q19EQVBNX1NXSVRDSCgiSFBPUiBQbGF5YmFjayIsIFNORF9TT0NfTk9QTSwgMCwgMCwNCj4gPj4g
KyAgICAgICAgICAgICAmaHBvcl9zd2l0Y2gpLA0KPiA+PiArDQo+ID4+ICAgICAgICAvKiBDTEsg
REVUICovDQo+ID4+ICAgICAgICBTTkRfU09DX0RBUE1fU1VQUExZKCJDTEtERVQgU1lTIiwgUlQ1
NjgyU19DTEtfREVULA0KPiA+PiAgICAgICAgICAgICAgICBSVDU2ODJTX1NZU19DTEtfREVUX1NG
VCwgMCwgTlVMTCwgMCksIEBAIC0xODk1LDgNCj4gKzE5MDgsMTAgQEANCj4gPj4gc3RhdGljIGNv
bnN0IHN0cnVjdCBzbmRfc29jX2RhcG1fcm91dGUgcnQ1Njgyc19kYXBtX3JvdXRlc1tdID0gew0K
PiA+PiAgICAgICAgeyJIUCBBbXAiLCBOVUxMLCAiQ0xLREVUIFNZUyJ9LA0KPiA+PiAgICAgICAg
eyJIUCBBbXAiLCBOVUxMLCAiU0FSIn0sDQo+ID4+DQo+ID4+IC0gICAgIHsiSFBPTCIsIE5VTEws
ICJIUCBBbXAifSwNCj4gPj4gLSAgICAgeyJIUE9SIiwgTlVMTCwgIkhQIEFtcCJ9LA0KPiA+PiAr
ICAgICB7IkhQT0wgUGxheWJhY2siLCAiU3dpdGNoIiwgIkhQIEFtcCJ9LA0KPiA+PiArICAgICB7
IkhQT1IgUGxheWJhY2siLCAiU3dpdGNoIiwgIkhQIEFtcCJ9LA0KPiA+PiArICAgICB7IkhQT0wi
LCBOVUxMLCAiSFBPTCBQbGF5YmFjayJ9LA0KPiA+PiArICAgICB7IkhQT1IiLCBOVUxMLCAiSFBP
UiBQbGF5YmFjayJ9LA0KPiA+PiAgIH07DQo+ID4NCj4gPiBSVDU2ODJTIGVuYWJsZXMgdGhlIDEg
Yml0IGNvbnRyb2wgZm9yIEhQIG91dHB1dC4NCj4gPiBUaGVyZWZvcmUsIHRoZSBzZXR0aW5nIG9m
IFJUNTY4MlNfSFBfQ1RSTF8xWzE1XVs3XSB3aWxsIGJlIG5vdCBlZmZlY3RpdmUuDQo+ID4NCj4g
Pg0KPiBPaywgaXQgd2FzIGFjdHVhbGx5IGVmZmVjdGl2ZSBhbmQgbXV0ZWQgYXVkaW8gd2hlbiB3
ZSB0ZXN0IGluIG91cg0KPiBwbGF0Zm9ybSwgcG9zc2libGUgYmVjYXVzZSBpJ20gdGVhcmluZyBk
b3duIGRhcG0gcGF0aCBiYXNlZCBvbiBzd2l0Y2gNCj4gdmFsdWUuIElmIHdlIGRvbid0IGhhdmUg
cmVnaXN0ZXIgYml0cyBhdmFpbGFibGUgdG8gbXV0ZSBpJ2xsIHJlc3VibWl0DQo+IHRoZSBjaGFu
Z2Ugd2l0aCB2aXJ0dWFsIHN3aXRjaCB3aWRnZXQgdG8gZGlzYWJsZSBEQVBNIGFuZCBzdG9wIGF1
ZGlvLg0KPiANCldoYXQgcHVycG9zZSBkbyB5b3Ugd2FudCB0byBhZGQgYW4gYWRkaXRpb25hbCBz
d2l0Y2ggdG8gcG93ZXIgdXAvZG93biANCnRoZSBkYXBtIGluIHRoZSBjb2RlYyBkcml2ZXIgaW5z
dGVhZCBvZiB1c2luZyBleGlzdGluZyBjb250cm9scz8NCkFuZCB3ZSB0aG91Z2h0IHRoZSB2aXJ0
dWFsIHN3aXRjaCB5b3UgdGFsa2VkIGFib3V0IGNvdWxkIGJlIGltcGxlbWVudGVkIA0KaW4gdGhl
IG1hY2hpbmUgZHJpdmVyLg0K
