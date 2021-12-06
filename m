Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 700D3469092
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 07:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238169AbhLFHAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 02:00:06 -0500
Received: from ms.asus.com ([103.10.4.13]:24029 "EHLO ms.asus.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238199AbhLFG77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 01:59:59 -0500
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Mon, 06 Dec 2021 01:59:58 EST
IronPort-Data: A9a23:q75AIanOfBzqFN+LlxcEn8vo5gyGJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIZDW2EbqqIYTCje4hwPNjipExV7Z7Wx9QxQABs/H8zRC4T+ZvOCOrCIxarNUt+DOWaFxs/s
 J92hvosjiwQZiWBzvt4GuW5xZVE/fjUAOK6UYYoAwgpLeNeYH5JZS9LwIbVvKY52bBVPCvQ4
 bsek+WHULNy82UsWo68w/vrRCJH5JweihtB1rANTakjUGvlqpUgJMl3yZddj5fPatI88uaSH
 44vxVwil4/T109F5tiNyt4XfqCWK1J70MfnZnd+AsCfbhZ+SiMa9o9ibacmRkNtinangut4k
 YpTs7jqYFJ8VkHMsLx1vxhwLxk7GIEDxuedZ3O4q9SVwlGAemDx2J2CDmlvYtdeoLwxXT4Ir
 KxwxDMlN3hvg8qMwbm7Q/NgseQ4MeHiJ4YStnBpizreCLA6XvgvRo2QtI8CgG9g3aiiG96GI
 MMjUzlIMijDZiNjNHcnGI4/sc630yyXnzpw7Qj9SbAMy2HVwBZwwf72MNfLcdyHQ8ZStkKZo
 H/WuWX/HhwecteYzFKt+GijgsfFki/2RsQKENWQ7fdwiVqVmDBLVUdHfVS+qPi9zEW5Xrp3L
 00S5zFosqE28EGqTPH5XhuxunnCuQQTM/JUEusn+ESC0qvTyxiWC3JCTTNbbtEi8sgsSlQC0
 l6PgsOsBjF1trCRYWyS+63Srj6oPyURa2gYakc5oRAtuoa55ttpyE6QCI8zeEKosuDI9fjL6
 2jihEADa3870abnC43TEYj7vg+R
IronPort-HdrOrdr: A9a23:oRU7yaA3BbMzxnvlHek755DYdb4zR+YMi2TDj3oBLiC8cqSj+P
 xG785rsyMc7wxhLU3I+OrwSpVoLkmslqKdjbN9AV7mZniDhILKFvAX0WKB+UyDJ8SWzIc0vs
 1dmupFebjN5DNB4/oSlTPZLz9W+ri6Gc6T6ds2hE0dND2CI5sQlzuRJDzraXGfHmR9dOAE/L
 nw3Ls7m9LhFE5nEfhSSBQ+Lpb+T5OgruOUXfa1aiRXlDWmnHe07LbhH1yC0g0DVi4n+8ZSzU
 HV1xH87r+u9+620QXd0Wi71eUnpOfc
Received: from unknown (HELO TP-MD-V02.corpnet.asus) ([172.22.47.18])
  by ms.asus.com with ESMTP; 06 Dec 2021 14:44:00 +0800
Received: from TP-MD-V01.corpnet.asus (172.22.47.17) by TP-MD-V02.corpnet.asus
 (172.22.47.18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Mon, 6 Dec
 2021 14:49:18 +0800
Received: from TP-MD-V01.corpnet.asus ([fe80::ec39:a96a:6470:e2d3]) by
 TP-MD-V01.corpnet.asus ([fe80::ec39:a96a:6470:e2d3%2]) with mapi id
 15.01.2375.012; Mon, 6 Dec 2021 14:49:18 +0800
From:   =?big5?B?UmljaGFyZCBIc3Uos1yofLn8KQ==?= 
        <Richard_Hsu@asmedia.com.tw>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        =?big5?B?UmljaGFyZCBIc3Uos1yofLn8KQ==?= 
        <Richard_Hsu@asmedia.com.tw>
CC:     Richard Hsu <saraon640529@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?big5?B?WWQgVHNlbmcotL+4zrlGKQ==?= <Yd_Tseng@asmedia.com.tw>,
        =?big5?B?Q2luZHkxIEhzdSizXLPNr/Qp?= <Cindy1_Hsu@asmedia.com.tw>,
        =?big5?B?QW5kcmV3IFN1KMSsq1S3vSk=?= <Andrew_Su@asmedia.com.tw>
Subject: RE: [PATCH] gpio Add my driver new id
Thread-Topic: [PATCH] gpio Add my driver new id
Thread-Index: AQHX6Cfr6x+ucL91W0GoSUy8H8/+z6wgBwwAgAC55ICABDJKMA==
Date:   Mon, 6 Dec 2021 06:49:18 +0000
Message-ID: <2c4a9ebf1adb4f198f5850eede186c37@asmedia.com.tw>
References: <20211203092609.8502-1-Richard_Hsu@asmedia.com.tw>
 <CAMRc=McwkKNUt4JZWcUVyd9uiAwJBk7SPw1C3X_F0RH_Qa=row@mail.gmail.com>
 <YaqKQVV1+8ksQInA@smile.fi.intel.com>
In-Reply-To: <YaqKQVV1+8ksQInA@smile.fi.intel.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.78.106.30]
x-tm-as-product-ver: SMEX-14.0.0.3092-8.6.1018-26572.002
x-tm-as-result: No-10--10.374000-8.000000
x-tmase-matchedrid: HrJsCrYHOqPUL3YCMmnG4hvgzEPRJaDEKQNhMboqZloTiSW9r3PknBkX
        +si55c+xNEWxillimf/Cp/fH792XOBLGlExWZk9XSHCU59h5KrHujGgmSxndopBz1ZAU7t9TbyG
        jLcND4qOMNUzDpMm+4dJCLoewhIUzrg9LB0uzcISEBxrrOwn79alwgXg3aMof8dKxvnT1xnd3Ib
        SSOjBC48ISpQJkUtdaMGTKD2Jd6LFw1ghGV72CBz2gUycsvOMF+W1UJfANmI5fRIo6rZ6scH43H
        V+1jEvwf7+bc+ChZL2TH1CW/TkdqiIF8KeAEpAE8eSmTJSmEv2CF6GkB9h+D7FbhhcWxNQO76d4
        tCBY3uXuJ7R4PI17kpr7paqOhC+E2Qo/2DsWrW4sIMJqMNlanfNkoMDX+kiuNWO9z3c712QphsV
        d6Tdth30tCKdnhB581kTfEkyaZdz6C0ePs7A07RD7Pzr2apMz0t0ccteCeDf9uEAqGo1DHdOZAO
        SnNlTXTphZwkciXisNfWpgxL9vuxyFdNnda6Rv
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--10.374000-8.000000
x-tmase-version: SMEX-14.0.0.3092-8.6.1018-26572.002
x-tm-snts-smtp: 7C7E4F3402127494796613A8E754E8F0E73D2E8C52DC589BA8BBA69AA40EDE4A2000:9
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgQW5keSAmIEJhcnRvc3ohDQogICAgU29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LiBOZXcgYWNw
aSBkZXZpY2UgQU1ESUYwMzEgaGF2ZSAyNCBncGlvIHBpbnMgYW5kIG9sZGVyIEFNREYwMzAvQU1E
SUYwMzAgaGF2ZSA4IGdwaW8gcGlucywgDQpJIHVzZSBhY3BpX2J1c19nZXRfZGV2aWNlKCkgdGhh
dCBjaGVjayBhY3BpIGRldmljZSBhbmQgZ2FpbiBhY3BpX2RldiBpbmZvIHRvIHJlcGxhY2UgdGhl
IG9yaWdpbmFsLiBUaGVuIHdlIGNoZWNrIGFuZCBjb21wYXJlIGRldmljZSBuYW1lIGZyb20gYWNw
aV9kZXZfbmFtZShhY3BpX2RldikuDQpJZiBBTURJRjAzMShwdF9ncGlvLT5nYy5uZ3BpbyA9IDI0
KSBvciBBTURGMDMwL0FNRElGMDMwIChwdF9ncGlvLT5nYy5uZ3BpbyA9IDgpLg0KDQpJIHdpbGwg
dHJ5IHRvIHVzZSAuZHJpdmVyX2RhdGEsIGFuZCBhZGQgY29tbWl0IG1lc3NhZ2VzIG9uIHRpdGxl
IGFuZCBjb2RlIHRoYXQgZXhwbGFpbiB3aGF0IHRoZSBjb2RlIGRvZXMgaW4gZGV0YWlsIGxhdGVy
DQoNClRoYW5rcw0KICAgICBSaWNoYXJkDQogICANCiAgICAgPiA+ICAjZGVmaW5lIFBUX1RPVEFM
X0dQSU8gOA0KPiA+ICsjZGVmaW5lIFBUX1RPVEFMX0dQSU9fRVggMjQNCg0KLi4uDQoNCj4gPiAr
ICAgICAgIHN0cnVjdCBhY3BpX2RldmljZSAqYWNwaV9kZXY7DQo+ID4gKyAgICAgICBhY3BpX2hh
bmRsZSBoYW5kbGUgPSBBQ1BJX0hBTkRMRShkZXYpOw0KDQo+ID4gLSAgICAgICBpZiAoIUFDUElf
Q09NUEFOSU9OKGRldikpIHsNCj4gPiArICAgICAgIGlmIChhY3BpX2J1c19nZXRfZGV2aWNlKGhh
bmRsZSwgJmFjcGlfZGV2KSkgew0KDQpXaGF0IHlvdSBhcmUgZG9pbmcgaGVyZSBpcyBvcGVuIGNv
ZGluZyB0aGUgQUNQSV9DT01QQU5JT04oKS4NCkJ1dCBzZWUgYmVsb3cuDQouLi4NCg0KPiA+ICsg
ICAgICAgaWYgKCFzdHJuY21wKGFjcGlfZGV2X25hbWUoYWNwaV9kZXYpLCAiQU1ESUYwMzEiLCA4
KSkNCj4gPiArICAgICAgICAgICAgICAgcHRfZ3Bpby0+Z2MubmdwaW8gPSBQVF9UT1RBTF9HUElP
X0VYOw0KPiA+ICsgICAgICAgZWxzZQ0KPiA+ICsgICAgICAgICAgICAgICBwdF9ncGlvLT5nYy5u
Z3BpbyA9IFBUX1RPVEFMX0dQSU87DQoNCkluc3RlYWQgb2YgZG9pbmcgdGhpcy4uLg0KDQoNCj4g
PiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBwdF9ncGlvX2FjcGlfbWF0Y2hb
XSA9IHsNCj4gPiAgICAgICAgIHsgIkFNREYwMzAiLCAwIH0sDQo+ID4gICAgICAgICB7ICJBTURJ
RjAzMCIsIDAgfSwNCj4gPiArICAgICAgIHsgIkFNRElGMDMxIiwgMCB9LA0KDQoNCi0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hl
bmtvQGxpbnV4LmludGVsLmNvbT4gDQpTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIgNCwgMjAyMSA1
OjIxIEFNDQpUbzogQmFydG9zeiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4NCkNjOiBSaWNo
YXJkIEhzdSA8c2FyYW9uNjQwNTI5QGdtYWlsLmNvbT47IExpbnVzIFdhbGxlaWogPGxpbnVzLndh
bGxlaWpAbGluYXJvLm9yZz47IFJpY2hhcmQgSHN1KLNcqHy5/CkgPFJpY2hhcmRfSHN1QGFzbWVk
aWEuY29tLnR3Pjsgb3BlbiBsaXN0OkdQSU8gU1VCU1lTVEVNIDxsaW51eC1ncGlvQHZnZXIua2Vy
bmVsLm9yZz47IExpbnV4IEtlcm5lbCBNYWlsaW5nIExpc3QgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+OyBZZCBUc2VuZyi0v7jOuUYpIDxZZF9Uc2VuZ0Bhc21lZGlhLmNvbS50dz47IENp
bmR5MSBIc3Uos1yzza/0KSA8Q2luZHkxX0hzdUBhc21lZGlhLmNvbS50dz47IEFuZHJldyBTdSjE
rKtUt70pIDxBbmRyZXdfU3VAYXNtZWRpYS5jb20udHc+DQpTdWJqZWN0OiBSZTogW1BBVENIXSBn
cGlvIEFkZCBteSBkcml2ZXIgbmV3IGlkDQoNCk9uIEZyaSwgRGVjIDAzLCAyMDIxIGF0IDExOjE1
OjQ2QU0gKzAxMDAsIEJhcnRvc3ogR29sYXN6ZXdza2kgd3JvdGU6DQo+IE9uIEZyaSwgRGVjIDMs
IDIwMjEgYXQgMTA6MjYgQU0gUmljaGFyZCBIc3UgPHNhcmFvbjY0MDUyOUBnbWFpbC5jb20+IHdy
b3RlOg0KDQpUaGFua3MsIEJhcnQsIGZvciBwb2ludGluZyBvdXQgdG8gdGhpcy4NCg0KPiA+ICAj
ZGVmaW5lIFBUX1RPVEFMX0dQSU8gOA0KPiA+ICsjZGVmaW5lIFBUX1RPVEFMX0dQSU9fRVggMjQN
Cg0KLi4uDQoNCj4gPiArICAgICAgIHN0cnVjdCBhY3BpX2RldmljZSAqYWNwaV9kZXY7DQo+ID4g
KyAgICAgICBhY3BpX2hhbmRsZSBoYW5kbGUgPSBBQ1BJX0hBTkRMRShkZXYpOw0KDQo+ID4gLSAg
ICAgICBpZiAoIUFDUElfQ09NUEFOSU9OKGRldikpIHsNCj4gPiArICAgICAgIGlmIChhY3BpX2J1
c19nZXRfZGV2aWNlKGhhbmRsZSwgJmFjcGlfZGV2KSkgew0KDQpXaGF0IHlvdSBhcmUgZG9pbmcg
aGVyZSBpcyBvcGVuIGNvZGluZyB0aGUgQUNQSV9DT01QQU5JT04oKS4NCkJ1dCBzZWUgYmVsb3cu
DQoNCi4uLg0KDQo+ID4gKyAgICAgICBpZiAoIXN0cm5jbXAoYWNwaV9kZXZfbmFtZShhY3BpX2Rl
diksICJBTURJRjAzMSIsIDgpKQ0KPiA+ICsgICAgICAgICAgICAgICBwdF9ncGlvLT5nYy5uZ3Bp
byA9IFBUX1RPVEFMX0dQSU9fRVg7DQo+ID4gKyAgICAgICBlbHNlDQo+ID4gKyAgICAgICAgICAg
ICAgIHB0X2dwaW8tPmdjLm5ncGlvID0gUFRfVE9UQUxfR1BJTzsNCg0KSW5zdGVhZCBvZiBkb2lu
ZyB0aGlzLi4uDQoNCj4gPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBwdF9n
cGlvX2FjcGlfbWF0Y2hbXSA9IHsNCj4gPiAgICAgICAgIHsgIkFNREYwMzAiLCAwIH0sDQo+ID4g
ICAgICAgICB7ICJBTURJRjAzMCIsIDAgfSwNCj4gPiArICAgICAgIHsgIkFNRElGMDMxIiwgMCB9
LA0KDQpKdXN0IHVzZSAuZHJpdmVyX2RhdGEgaGVyZSBhbmQgaWYgbmVlZGVkIGluIHRoZSBvdGhl
ciBJRCB0YWJsZXMgYW5kIHRoZW4gc2ltcGx5IHJldHJpZXZlIGl0ICh3L28gYW55IGNvbmRpdGlv
bnMpIGluIHRoZSBjb2RlIGFib3ZlOg0KDQoJcHRfZ3Bpby0+Z2MubmdwaW8gPSAodWludHB0cl90
KWRldmljZV9nZXRfbWF0Y2hfZGF0YShkZXYpOw0KDQo+ID4gICAgICAgICB7IH0sDQo+ID4gIH07
DQoNCj4gUGxlYXNlIENjIEFuZHkgbmV4dCB0aW1lIG9uIGFueSBHUElPIHN0dWZmIHJlbGF0ZWQg
dG8gQUNQSS4gSSdsbCBsZXQgDQo+IGhpbSBjb21tZW50IG9uIHRoZSBjb2RlLiBZb3VyIGNvbW1p
dCBtZXNzYWdlIG11c3QgYmUgbW9yZSBkZXNjcmlwdGl2ZQ0KPiAtIHRoZSB0aXRsZSBzaG91bGQg
c2F5ICJncGlvOiA8ZHJpdmVyIG5hbWU+OiA8ZG8gdGhpcyBhbmQgdGhhdD4iLg0KPiBQbGVhc2Ug
YWxzbyBhZGQgYSBjb21taXQgbWVzc2FnZSBleHBsYWluaW5nIHdoYXQgdGhlIGNvZGUgZG9lcyBp
biANCj4gZGV0YWlsLg0KDQotLQ0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpBbmR5IFNoZXZjaGVua28N
Cg0KDQo8cD48L3A+DQo=
