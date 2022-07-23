Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1F157EFF8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 17:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238392AbiGWPI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 11:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237394AbiGWPIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 11:08:25 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918E91A814;
        Sat, 23 Jul 2022 08:08:23 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id F41DF122FCF;
        Sat, 23 Jul 2022 17:08:20 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id DCB43122F7D;
        Sat, 23 Jul 2022 17:08:20 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Sat, 23 Jul 2022 17:08:20 +0200 (CEST)
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Sat, 23 Jul
 2022 17:08:20 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Sat, 23 Jul 2022 17:08:20 +0200
From:   Christian Loehle <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Avri Altman <Avri.Altman@wdc.com>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mmc: block: Dont report successful writes with errors
Thread-Topic: [PATCH] mmc: block: Dont report successful writes with errors
Thread-Index: Adibg9VERWQQSIdlTuivPV3k9XDqxwC0zsEAABMWzRA=
Date:   Sat, 23 Jul 2022 15:08:19 +0000
Message-ID: <a66fe29560f545e18b91af57f4d0dddb@hyperstone.com>
References: <ca06b94aa48a484d965744e64e17a4ef@hyperstone.com>
 <992cc198-6c7c-977a-1af8-56665e939cc9@intel.com>
In-Reply-To: <992cc198-6c7c-977a-1af8-56665e939cc9@intel.com>
Accept-Language: en-US, de-DE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.242.2.2]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-27034.000
X-TMASE-Result: 10--4.711100-10.000000
X-TMASE-MatchedRID: 1GZI+iG+Mtc4HKI/yaqRm65i3jK3KDOon5nfR7I2dFOHOV1iX68qKZ7Y
        WhVRsZwuIvrftAIhWmLy9zcRSkKatU5gqNn1dvU1HPYwOJi6PLmZIt4iAQN6P7wYtb0g7YwtBjZ
        Q69nTLPVuf5ur5byPpRQ8VZs5oN9QYLmTo2ikrFg6N/cDgNNi4flSepWcgdLP6qtOp7YOMMlQCs
        mfAegbdDn/DTK/G3ZxulzBJJSWP21LbsC+B4mg0CrLqyE6Ur/jfXuxEzIWjBGlc781fidezAscY
        S3HCNn/YTwbBN/UFRUT7Tkc5T/JSErr3NDc5w2WqhcdnP91eXEzNsXWBvGVBi37aLwPsRkKo8WM
        kQWv6iUVR7DQWX/WkQGLeSok4rrZC24oEZ6SpSkj80Za3RRg8OMGRmokYZ2no23odnq30xqsDWA
        6LWYOMzradVtJbrOo2+HkU2X4rVw=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: 1d0dd61e-ded5-4032-b68a-dd49c6f8bbe4-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDE5LzA3LzIyIDE4OjM0LCBDaHJpc3RpYW4gTG9laGxlIHdyb3RlOg0KPj4gQmUgYXMgY29u
c2VydmF0aXZlIGFib3V0IHN1Y2Nlc3NmdWwgd3JpdGUgcmVwb3J0aW5nIHRvIHRoZSBibG9jayBs
YXllciANCj4+IGZvciBTUEkgYXMgd2l0aCBub3JtYWwgU0QgYW5kIE1NQy4NCj4+IFRoYXQgbWVh
bnMgb24gYW55IGVycm9ycyBieXRlc194ZmVyZWQgaXMgaWdub3JlZCBhbmQgdGhlIHdob2xlIHdy
aXRlIA0KPj4gbXVzdCBiZSByZXBlYXRlZC4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0
aWFuIExvZWhsZSA8Y2xvZWhsZUBoeXBlcnN0b25lLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZlcnMv
bW1jL2NvcmUvYmxvY2suYyB8IDYgKysrKystDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDUgaW5zZXJ0
aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMv
Y29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGluZGV4IA0KPj4gZjRhMTI4
MTY1OGRiLi42M2QxYzA1NTgyYTkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL21tYy9jb3JlL2Js
b2NrLmMNCj4+ICsrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPj4gQEAgLTE3NjUsOCAr
MTc2NSwxMiBAQCBzdGF0aWMgYm9vbCBtbWNfYmxrX3N0YXR1c19lcnJvcihzdHJ1Y3QgcmVxdWVz
dCAqcmVxLCB1MzIgc3RhdHVzKQ0KPj4gIAlzdHJ1Y3QgbW1jX3F1ZXVlICptcSA9IHJlcS0+cS0+
cXVldWVkYXRhOw0KPj4gIAl1MzIgc3RvcF9lcnJfYml0czsNCj4+ICANCj4+ICsJLyoNCj4+ICsJ
ICogRWl0aGVyIHdyaXRlIHRpbWVkIG91dCBkdXJpbmcgYnVzeSBhbmQgZGF0YS0+ZXJyb3IgaXMg
c2V0DQo+PiArCSAqIG9yIHdlIGFjdHVhbGx5IHJlY2VpdmVkIGEgdmFsaWQgUjIgYW5kIGNoZWNr
IGZvciBlcnJvciBiaXRzLg0KPj4gKwkgKi8NCj4+ICAJaWYgKG1tY19ob3N0X2lzX3NwaShtcS0+
Y2FyZC0+aG9zdCkpDQo+PiAtCQlyZXR1cm4gZmFsc2U7DQo+PiArCQlyZXR1cm4gYnJxLT5kYXRh
LmVycm9yIHx8ICEhc3RhdHVzOw0KPg0KPlRoaXMgZnVuY3Rpb24gaXMgZm9yIGNoZWNraW5nIHN0
YXR1cywgc28gYnJxLT5kYXRhLmVycm9yIGRvZXMgbm90IGJlbG9uZyBoZXJlLiAgQWxzbyBpdCB3
b3VsZCBiZSBtb3JlIHJlYWRhYmxlIHRvIHVzZSBhIGRlZmluZSBlLmcuDQo+DQo+CQlyZXR1cm4g
c3RhdHVzICYgU1BJX1IyX0VSUk9SUzsNCj4NCj5JIHRoaW5rIGNsZWFyaW5nIGJ5dGVzX3hmZXJl
ZCBmb3IgU1BJIGJycS0+ZGF0YS5lcnJvciBzaG91bGQgYmUgYSBzZXBhcmF0ZSBwYXRjaCwgYW5k
IHlvdSB3b3VsZCBuZWVkIHRvIGV4cGxhaW4gYSBiaXQgbW9yZSBmb3IgdGhhdCBjYXNlIHRvby4N
Cg0KSSB1bmRlcnN0YW5kIHRoYXQsIGJ1dCB0aGVyZSBpcyBubyB3YXkgb2YgY2hlY2tpbmcgc3Rh
dHVzIGluIFNQSSBtb2RlLg0KVGhlIGJlaGF2aW9yIG9mIG1tYyBibG9jayBpcyBvbmx5IGNoYW5n
ZWQgaW4gYSBtaW5vciB3YXkgaGVyZSBhbnl3YXksIHRoYXQgaXMsIGNoZWNraW5nIGZvciBzdGF0
dXMgaXMgZG9uZSBvbmUgbW9yZSB0aW1lIHRoYW4gYmVmb3JlLg0KSWYgYnJxLT5kYXRhLmVycm9y
IGlzIHNldCBkaXJlY3RseSBhZnRlciBhIHdyaXRlIGUuZy4gdGhlbiBieXRlc194ZmVyZWQgaXMg
YWxyZWFkeSAwLg0KTXkgaW50ZW50aW9uIHdhcyBtb3N0bHkgdG8gaW1wcm92ZSBvbiB0aGUgZmxv
dyBvZiB0aGUgcmVjb3ZlcnkgYW5kIGdldCB0aGUgbW1jX2lzX2hvc3Rfc3BpIG91dCBvZiB0aGVy
ZSBmb3IgdGhlIG1vc3QgcGFydCB3aXRoIGZ1dHVyZSBwYXRjaGVzLg0KQWZ0ZXIgYWxsIGl0IGZl
ZWxzIHdlaXJkIHRvIGRvIGEgc2luZ2xlIHN0ZXAgcmVhZCByZXRyeSBiZWZvcmUgZW5zdXJpbmcg
YSBmaXhfc3RhdGUsIGFuZCBJIHJhbiBpbnRvIHRoYXQgcXVpdGUgb2Z0ZW4uDQpVbmZvcnR1bmF0
ZWx5LCBJIG5vdyByZWFsaXplZCB0aGF0IGZpeF9zdGF0ZSBjYW5ub3QgcHJvcGVybHkgYmUgaW1w
bGVtZW50ZWQgd2l0aGluIHRoZSBzcGVjIG9yIGV2ZW4gcmVhbC13b3JsZCBjYXJkJ3MgYmVoYXZp
b3IgYW5kIEkgd29uJ3QgYmUgdGFraW5nIHRoaXMgZnVydGhlci4NClRoZSBiZXN0IGF0dGVtcHQg
SSBjYW1lIHVwIHdpdGggaXMgZG9pbmcgYSBsb29wIG9mIENNRDEyIGFuZCBDTUQxMyBpbiBTUEkg
YW5kIGlmIENNRDEyIHdhcyBJTExFR0FMIGFuZCBDTUQxMiBoYXMgbm8gYml0cyBzZXQsIHN0YXRl
IGlzIGZpeGVkLg0KQnV0IENNRDEyIGlzIG9ubHkgZGVmaW5lZCBmb3IgbXVsdGlwbGUgYmxvY2sg
dHJhbnNmZXJzIGluIFNQSSBhbmQgY2FyZHMgdHJlYXQgaXQgZGlmZmVyZW50bHkgb24gZS5nLiBD
TUQxNyB0cmFuc2ZlcnMuDQpJbnN0ZWFkIEkgd291bGQganVzdCBkbyBhIHNvZnQgcmVzZXQgZm9y
IFNQSSBhbmQgcmV0cnkgYW5kIG1heWJlIGluY3JlYXNlIHRoZSByZWFkIHRpbWVvdXQgb2YgMTAw
bXMgd2hpY2ggbGFyZ2VyIFNEIGNhcmRzIGNhbiBmYWlsIHNvbWV0aW1lcy4NCkFueXdheSBzaW5j
ZSBTUEkgaW5pdGlhbGl6YXRpb24gaXMgcXVpdGUgZmFzdCwgZXNwZWNpYWxseSBmb3Igc29mdCBy
ZXNldHMgdGhlcmUgaXMgbGlrZWx5IG5vIHJlY292ZXJ5IHRvIGJlYXQgdGhhdCBwZXJmb3JtYW5j
ZS13aXNlLg0KSSB3aWxsIHNlbmQgYW4gUkZDIGZvciB0aGUgc29mdCByZXNldCBpbiB0aGUgY29t
aW5nIGRheXMuDQpJZiBub3QgSSB3b3VsZCBhdCBsZWFzdCBhZGQgdGhlICFtbWNfaXNfaG9zdF9z
cGkgY29uZGl0aW9uIGZvciBjYWxsaW5nIG1tY19ibGtfc3RhdHVzX2Vycm9yIHRvIG1ha2UgaXQg
YSBiaXQgbW9yZSBjbGVhciB0aGF0IHRoaXMgZnVuY3Rpb24gZG9lcyBkbyB3aGF0IGlzIGludGVu
ZGVkIGZvciBTUEkgY2FyZHMuDQoNClJlZ2FyZHMsDQpDaHJpc3RpYW4NCg0KSHlwZXJzdG9uZSBH
bWJIIHwgUmVpY2hlbmF1c3RyLiAzOWEgIHwgNzg0NjcgS29uc3RhbnoKTWFuYWdpbmcgRGlyZWN0
b3I6IERyLiBKYW4gUGV0ZXIgQmVybnMuCkNvbW1lcmNpYWwgcmVnaXN0ZXIgb2YgbG9jYWwgY291
cnRzOiBGcmVpYnVyZyBIUkIzODE3ODI=

