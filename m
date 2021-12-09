Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A124F46E0DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 03:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbhLICaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:30:04 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:50582 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbhLICaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:30:03 -0500
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 1B92PvrC6024809, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 1B92PvrC6024809
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 9 Dec 2021 10:25:58 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 9 Dec 2021 10:25:57 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 18:25:57 -0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::38af:5429:2b43:3b95]) by
 RTEXMBS01.realtek.com.tw ([fe80::38af:5429:2b43:3b95%5]) with mapi id
 15.01.2308.015; Thu, 9 Dec 2021 10:25:57 +0800
From:   =?big5?B?U2h1bWluZyBbrVOu0bvKXQ==?= <shumingf@realtek.com>
To:     Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
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
        =?big5?B?RGVyZWsgW6TovHe4cV0=?= <derek.fang@realtek.com>,
        "Flove(HsinFu)" <flove@realtek.com>,
        Albert Chen <albertchen@realtek.com>
Subject: RE: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP playback output
Thread-Topic: [PATCH v2 1/1] ASoC: rt5682s: Add dapm switch to mute/unmute HP
 playback output
Thread-Index: AQHX7GWRR3qQB6aNxkO0lEkghrE7SKwpZXsA
Date:   Thu, 9 Dec 2021 02:25:56 +0000
Message-ID: <126eab881bb540bc84ecc5cb9c6865a8@realtek.com>
References: <20211208185517.1555884-1-AjitKumar.Pandey@amd.com>
 <20211208185517.1555884-2-AjitKumar.Pandey@amd.com>
In-Reply-To: <20211208185517.1555884-2-AjitKumar.Pandey@amd.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.102.209]
x-kse-serverinfo: RTEXMBS05.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzEyLzggpFWkyCAxMTozNzowMA==?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBbUEFUQ0ggdjIgMS8xXSBBU29DOiBydDU2ODJzOiBBZGQgZGFwbSBzd2l0Y2gg
dG8gbXV0ZS91bm11dGUgSFANCj4gcGxheWJhY2sgb3V0cHV0DQo+IA0KPiBBZGQgZGFwbSBzd2l0
Y2ggaW4gcGxheWJhY2sgcGF0aCB0byBtdXRlIG9yIHVubXV0ZSBIUCBvdXRwdXQgZGF0YS4NCj4g
V2Ugd2lsbCBzZXQgYW5kIHJlc2V0IE1VVEVfU0ZUIGJpdCBpbiBSVDU2ODJTX0hQX0NUUkxfMSBy
ZWdpc3RlciBiYXNlZCBvbg0KPiBzd2l0Y2ggdmFsdWUgdG8gbXV0ZSBvciB1bm11dGUgcmVzcGVj
dGl2ZSBjaGFubmVsLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWppdCBLdW1hciBQYW5kZXkgPEFq
aXRLdW1hci5QYW5kZXlAYW1kLmNvbT4NCj4gLS0tDQo+ICBzb3VuZC9zb2MvY29kZWNzL3J0NTY4
MnMuYyB8IDE5ICsrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9j
b2RlY3MvcnQ1Njgycy5jIGIvc291bmQvc29jL2NvZGVjcy9ydDU2ODJzLmMgaW5kZXgNCj4gZDQ5
YTRmNjg1NjZkLi4yMWFiNWY3ZGY0MjIgMTAwNjQ0DQo+IC0tLSBhL3NvdW5kL3NvYy9jb2RlY3Mv
cnQ1Njgycy5jDQo+ICsrKyBiL3NvdW5kL3NvYy9jb2RlY3MvcnQ1Njgycy5jDQo+IEBAIC0xNTcz
LDYgKzE1NzMsMTQgQEAgc3RhdGljIGNvbnN0IGNoYXIgKiBjb25zdA0KPiBydDU2ODJzX2FkY2Rh
dF9waW5fc2VsZWN0W10gPSB7DQo+ICAJIkFEQ0RBVDEiLCAiQURDREFUMiIsDQo+ICB9Ow0KPiAN
Cj4gKy8qIE91dCBTd2l0Y2ggKi8NCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9s
X25ldyBocG9sX3N3aXRjaCA9DQo+ICsJU09DX0RBUE1fU0lOR0xFX0FVVE9ESVNBQkxFKCJTd2l0
Y2giLCBSVDU2ODJTX0hQX0NUUkxfMSwNCj4gKwkJUlQ1NjgyU19MX01VVEVfU0ZULCAxLCAxKTsN
Cj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX2tjb250cm9sX25ldyBocG9yX3N3aXRjaCA9DQo+
ICsJU09DX0RBUE1fU0lOR0xFX0FVVE9ESVNBQkxFKCJTd2l0Y2giLCBSVDU2ODJTX0hQX0NUUkxf
MSwNCj4gKwkJUlQ1NjgyU19SX01VVEVfU0ZULCAxLCAxKTsNCj4gKw0KPiAgc3RhdGljIFNPQ19W
QUxVRV9FTlVNX1NJTkdMRV9ERUNMKHJ0NTY4MnNfYWRjZGF0X3Bpbl9lbnVtLA0KPiAgCVJUNTY4
MlNfR1BJT19DVFJMXzEsIFJUNTY4MlNfR1A0X1BJTl9TRlQsDQo+IFJUNTY4MlNfR1A0X1BJTl9N
QVNLLA0KPiAgCXJ0NTY4MnNfYWRjZGF0X3Bpbl9zZWxlY3QsIHJ0NTY4MnNfYWRjZGF0X3Bpbl92
YWx1ZXMpOyBAQCAtMTc0Niw2DQo+ICsxNzU0LDExIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25k
X3NvY19kYXBtX3dpZGdldA0KPiBydDU2ODJzX2RhcG1fd2lkZ2V0c1tdID0gew0KPiAgCVNORF9T
T0NfREFQTV9QR0FfUygiSFAgQW1wIiwgMSwgU05EX1NPQ19OT1BNLCAwLCAwLA0KPiBydDU2ODJz
X2hwX2FtcF9ldmVudCwNCj4gIAkJU05EX1NPQ19EQVBNX1BPU1RfUE1EIHwgU05EX1NPQ19EQVBN
X1BPU1RfUE1VKSwNCj4gDQo+ICsJU05EX1NPQ19EQVBNX1NXSVRDSCgiSFBPTCBQbGF5YmFjayIs
IFNORF9TT0NfTk9QTSwgMCwgMCwNCj4gKwkJJmhwb2xfc3dpdGNoKSwNCj4gKwlTTkRfU09DX0RB
UE1fU1dJVENIKCJIUE9SIFBsYXliYWNrIiwgU05EX1NPQ19OT1BNLCAwLCAwLA0KPiArCQkmaHBv
cl9zd2l0Y2gpLA0KPiArDQo+ICAJLyogQ0xLIERFVCAqLw0KPiAgCVNORF9TT0NfREFQTV9TVVBQ
TFkoIkNMS0RFVCBTWVMiLCBSVDU2ODJTX0NMS19ERVQsDQo+ICAJCVJUNTY4MlNfU1lTX0NMS19E
RVRfU0ZULCAwLCBOVUxMLCAwKSwgQEAgLTE4OTUsOCArMTkwOCwxMCBAQA0KPiBzdGF0aWMgY29u
c3Qgc3RydWN0IHNuZF9zb2NfZGFwbV9yb3V0ZSBydDU2ODJzX2RhcG1fcm91dGVzW10gPSB7DQo+
ICAJeyJIUCBBbXAiLCBOVUxMLCAiQ0xLREVUIFNZUyJ9LA0KPiAgCXsiSFAgQW1wIiwgTlVMTCwg
IlNBUiJ9LA0KPiANCj4gLQl7IkhQT0wiLCBOVUxMLCAiSFAgQW1wIn0sDQo+IC0JeyJIUE9SIiwg
TlVMTCwgIkhQIEFtcCJ9LA0KPiArCXsiSFBPTCBQbGF5YmFjayIsICJTd2l0Y2giLCAiSFAgQW1w
In0sDQo+ICsJeyJIUE9SIFBsYXliYWNrIiwgIlN3aXRjaCIsICJIUCBBbXAifSwNCj4gKwl7IkhQ
T0wiLCBOVUxMLCAiSFBPTCBQbGF5YmFjayJ9LA0KPiArCXsiSFBPUiIsIE5VTEwsICJIUE9SIFBs
YXliYWNrIn0sDQo+ICB9Ow0KDQpSVDU2ODJTIGVuYWJsZXMgdGhlIDEgYml0IGNvbnRyb2wgZm9y
IEhQIG91dHB1dC4NClRoZXJlZm9yZSwgdGhlIHNldHRpbmcgb2YgUlQ1NjgyU19IUF9DVFJMXzFb
MTVdWzddIHdpbGwgYmUgbm90IGVmZmVjdGl2ZS4NCg0KDQo=
