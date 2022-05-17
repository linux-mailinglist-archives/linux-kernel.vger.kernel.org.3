Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F882529BF2
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235045AbiEQIM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242707AbiEQILJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:11:09 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1BA11C3C
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 01:11:06 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 24H8AHJ20001829, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 24H8AHJ20001829
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 17 May 2022 16:10:18 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 16:10:17 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 17 May 2022 16:10:17 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::754e:2219:bbef:d0cd]) by
 RTEXMBS01.realtek.com.tw ([fe80::754e:2219:bbef:d0cd%5]) with mapi id
 15.01.2308.027; Tue, 17 May 2022 16:10:17 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Tom Rix <trix@redhat.com>
CC:     Nathan Chancellor <nathan@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>
Subject: RE: [PATCH] misc: rtsx: Set setting_reg2 before use.
Thread-Topic: [PATCH] misc: rtsx: Set setting_reg2 before use.
Thread-Index: AQHYaT2CKSbKZlIAOES1N3o6bLOYX60iT2gHgABmnsA=
Date:   Tue, 17 May 2022 08:10:17 +0000
Message-ID: <bab0c4250147420a842f3e966a8264a6@realtek.com>
References: <20220516130047.3887590-1-trix@redhat.com>
 <YoJ0I/XPoj1B/+mm@dev-arch.thelio-3990X>
 <d34498ad-0230-7c73-8f1f-9ca59fbf930f@redhat.com>
 <CAAd53p57APcectWW-NN_=HE6JkTQRk717cWNZ5iJcP+MtEYjog@mail.gmail.com>
In-Reply-To: <CAAd53p57APcectWW-NN_=HE6JkTQRk717cWNZ5iJcP+MtEYjog@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.103]
x-kse-serverinfo: RTEXDAG02.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?utf-8?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzUvMTcg5LiK5Y2IIDA2OjQ0OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLYWktSGVuZyBGZW5nIDxrYWku
aGVuZy5mZW5nQGNhbm9uaWNhbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIE1heSAxNywgMjAyMiA5
OjUzIEFNDQo+IFRvOiBUb20gUml4IDx0cml4QHJlZGhhdC5jb20+DQo+IENjOiBOYXRoYW4gQ2hh
bmNlbGxvciA8bmF0aGFuQGtlcm5lbC5vcmc+OyBhcm5kQGFybmRiLmRlOw0KPiBncmVna2hAbGlu
dXhmb3VuZGF0aW9uLm9yZzsgbmRlc2F1bG5pZXJzQGdvb2dsZS5jb207IFJpY2t5IFdVDQo+IDxy
aWNreV93dUByZWFsdGVrLmNvbT47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGxsdm1A
bGlzdHMubGludXguZGV2DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIG1pc2M6IHJ0c3g6IFNldCBz
ZXR0aW5nX3JlZzIgYmVmb3JlIHVzZS4NCj4gDQo+IE9uIFR1ZSwgTWF5IDE3LCAyMDIyIGF0IDE6
MDYgQU0gVG9tIFJpeCA8dHJpeEByZWRoYXQuY29tPiB3cm90ZToNCj4gPg0KPiA+DQo+ID4gT24g
NS8xNi8yMiA4OjU2IEFNLCBOYXRoYW4gQ2hhbmNlbGxvciB3cm90ZToNCj4gPiA+IE9uIE1vbiwg
TWF5IDE2LCAyMDIyIGF0IDA5OjAwOjQ3QU0gLTA0MDAsIFRvbSBSaXggd3JvdGU6DQo+ID4gPj4g
VGhlIGNsYW5nIGJ1aWxkIGZhaWxzIHdpdGgNCj4gPiA+PiBydHM1MjYxLmM6NDA2OjEzOiBlcnJv
cjogdmFyaWFibGUgJ3NldHRpbmdfcmVnMicgaXMgdXNlZCB1bmluaXRpYWxpemVkDQo+IHdoZW5l
dmVyICdpZicgY29uZGl0aW9uIGlzIGZhbHNlIFstV2Vycm9yLC1Xc29tZXRpbWVzLXVuaW5pdGlh
bGl6ZWRdDQo+ID4gPj4gICAgICAgICAgfSBlbHNlIGlmIChlZnVzZV92YWxpZCA9PSAwKSB7DQo+
ID4gPj4gICAgICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+DQo+ID4gPj4NCj4gPiA+
PiBzZXR0aW5nX3JlZzIgaXMgc2V0IGluIHRoaXMgYmxvY2sNCj4gPiA+PiAgICBpZiAoZWZ1c2Vf
dmFsaWQgPT0gMiB8fCBlZnVzZV92YWxpZCA9PSAzKSB7IC4uDQo+ID4gPj4gICAgfSBlbHNlIGlm
IChlZnVzZV92YWxpZCA9PSAwKSB7DQo+ID4gPj4gICAgICAvLyBkZWZhdWx0DQo+ID4gPj4gLi4N
Cj4gPiA+PiAgICB9DQo+ID4gPj4gQnV0IGVmdXNlX3ZhbGlkIGNhbiBhbHNvIGhhdmUgYSB2YWx1
ZSBvZiAxLg0KPiA+ID4+IENoYW5nZSB0aGUgJ2Vsc2UgaWYnIHRvICdlbHNlJyB0byBtYWtlIHRo
ZSBzZWNvbmQgYmxvY2sgdGhlIGRlZmF1bHQuDQo+ID4gPj4NCj4gPiA+PiBGaXhlczogYjFjNWYz
MDg1MTQ5ICgibWlzYzogcnRzeDogYWRkIHJ0czUyNjEgZWZ1c2UgZnVuY3Rpb24iKQ0KPiA+ID4+
IFNpZ25lZC1vZmYtYnk6IFRvbSBSaXggPHRyaXhAcmVkaGF0LmNvbT4NCj4gPiA+IEkgYW0gbm90
IHN1cmUgaWYgdGhpcyBmaXggaXMgY29ycmVjdCBmcm9tIGEgZnVuY3Rpb25hbCBzdGFuZHBvaW50
IChpLmUuDQo+ID4gPiBpcyB0cmVhdGluZyBlZnVzZV92YWxpZCA9PSAxIHRoZSBzYW1lIGFzIGVm
dXNlX3ZhbGlkID09IDAgY29ycmVjdD8pDQo+ID4gPiBidXQgaXQgaXMgYmV0dGVyIHRoYW4gbm90
IGhhbmRsaW5nIHRoaXMgdmFsdWUgYWx0b2dldGhlci4gRm9yIHdoYXQNCj4gPiA+IGl0J3MNCj4g
PiA+IHdvcnRoOg0KPiA+DQo+ID4gSSBsb29rZWQgYXQgaG93IHRoZSBjb2RlIHVzZWQgdG8gd29y
aywgdGhpcyBzZWVtZWQgYmV0dGVyIHRoYW4NCj4gPiBpbml0aWFsaXppbmcgdG8gTlVMTC4NCj4g
DQo+IE9yIG1heWJlIHVzZSBhIHNpbmdsZSBpZiBibG9jaz8NCj4gDQo+IHUxNiBzZXR0aW5nX3Jl
ZzEgPVBDUl9TRVRUSU5HX1JFRzEgLCBzZXR0aW5nX3JlZzIgPQ0KPiBQQ1JfU0VUVElOR19SRUcy
OyAuLi4NCj4gaWYgKChlZnVzZV92YWxpZCA9PSAyIHx8IGVmdXNlX3ZhbGlkID09IDMpICYmICh2
YWxpZCAhPSAzKSB7DQo+ICAgICBzZXR0aW5nX3JlZzEgPSBQQ1JfU0VUVElOR19SRUc0Ow0KPiAg
ICAgc2V0dGluZ19yZWcyID0gUENSX1NFVFRJTkdfUkVHNTsNCj4gfQ0KPiANCj4gS2FpLUhlbmcN
Cj4gDQo+ID4NCj4gPiA+DQo+ID4gPiBSZXZpZXdlZC1ieTogTmF0aGFuIENoYW5jZWxsb3IgPG5h
dGhhbkBrZXJuZWwub3JnPg0KPiA+ID4NCj4gPiA+IEFzIGEgc2lkZSBub3RlLCBpdCBpcyB1bmZv
cnR1bmF0ZSB0aGF0IHRoaXMgY2hhbmdlIG1hZGUgaXQgaW50bw0KPiA+ID4gLW5leHQgd2hlbiB0
aGVyZSB3YXMgYW4gb3V0c3RhbmRpbmcgcmVwb3J0IGFib3V0IHRoaXMgd2FybmluZzoNCj4gPg0K
PiA+ICBGcm9tIHRoZSBjbGFuZyBzaWRlLCB0aGlzIGlzIGEgYnVpbGQgYnJlYWsgYW5kIG15IHN0
YXRpYyBhbmFseXNpcw0KPiA+IGluZnJhIGdvZXMgZG93bi4NCj4gPg0KPiA+IFRoZXNlIGJ1aWxk
IGJyZWFrcyBzZWVtIHRvIGhhcHBlbmluZyBldmVyeSB3ZWVrLCBpcyB0aGVyZSBhIHByZWNvbW1p
dA0KPiA+IGNsYW5nIGdhdGluZyB0ZXN0IHRoYXQgY291bGQgYmUgZG9uZSBmb3IgLW5leHQgPw0K
PiA+DQo+ID4gVG9tDQo+ID4NCj4gPiA+DQo+ID4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy8y
MDIyMDUxMDAyMjAuV3lBeWhLYXAtbGtwQGludGVsLmNvbS8NCj4gPiA+DQo+ID4gPj4gLS0tDQo+
ID4gPj4gICBkcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjYxLmMgfCAyICstDQo+ID4gPj4g
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+Pg0K
PiA+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjYxLmMNCj4g
PiA+PiBiL2RyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0czUyNjEuYw0KPiA+ID4+IGluZGV4IDc0
OWNjNWE0NmQxMy4uZjIyNjM0YjE0ZGM4IDEwMDY0NA0KPiA+ID4+IC0tLSBhL2RyaXZlcnMvbWlz
Yy9jYXJkcmVhZGVyL3J0czUyNjEuYw0KPiA+ID4+ICsrKyBiL2RyaXZlcnMvbWlzYy9jYXJkcmVh
ZGVyL3J0czUyNjEuYw0KPiA+ID4+IEBAIC00MDMsNyArNDAzLDcgQEAgc3RhdGljIHZvaWQgcnRz
NTI2MV9pbml0X2Zyb21faHcoc3RydWN0IHJ0c3hfcGNyDQo+ICpwY3IpDQo+ID4gPj4gICAgICAg
ICAgICAgICAgICAgICAgc2V0dGluZ19yZWcxID0gUENSX1NFVFRJTkdfUkVHNDsNCj4gPiA+PiAg
ICAgICAgICAgICAgICAgICAgICBzZXR0aW5nX3JlZzIgPSBQQ1JfU0VUVElOR19SRUc1Ow0KPiA+
ID4+ICAgICAgICAgICAgICB9DQo+ID4gPj4gLSAgICB9IGVsc2UgaWYgKGVmdXNlX3ZhbGlkID09
IDApIHsNCj4gPiA+PiArICAgIH0gZWxzZSB7DQo+ID4gPj4gICAgICAgICAgICAgIC8vIGRlZmF1
bHQNCj4gPiA+PiAgICAgICAgICAgICAgc2V0dGluZ19yZWcxID0gUENSX1NFVFRJTkdfUkVHMTsN
Cj4gPiA+PiAgICAgICAgICAgICAgc2V0dGluZ19yZWcyID0gUENSX1NFVFRJTkdfUkVHMjsNCg0K
U29ycnkgZm9yIHRoZSB0cm91YmxlIA0KaGVyZSBjYW4gYmUgY2hhbmdlZCB0byANCi4uLg0KfSBl
bHNlIGlmIChlZnVzZV92YWxpZCA9PSAwKSB7DQoJCS8vIGRlZmF1bHQNCgkJc2V0dGluZ19yZWcx
ID0gUENSX1NFVFRJTkdfUkVHMTsNCgkJc2V0dGluZ19yZWcyID0gUENSX1NFVFRJTkdfUkVHMjsN
Cn0gZWxzZSB7DQogcmV0dXJuOw0KfQ0KQmVjYXVzZSBvdGhlciB2YWx1ZXMgYXJlIGludmFsaWQN
Cg0KDQo+ID4gPj4gLS0NCj4gPiA+PiAyLjI3LjANCj4gPiA+Pg0KPiA+ID4gQ2hlZXJzLA0KPiA+
ID4gTmF0aGFuDQo+ID4gPg0KPiA+DQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJv
bm1lbnQgYmVmb3JlIHByaW50aW5nIHRoaXMgZS1tYWlsLg0K
