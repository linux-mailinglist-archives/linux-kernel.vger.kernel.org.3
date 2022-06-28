Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD9455CA11
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344070AbiF1JIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234062AbiF1JIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:08:44 -0400
Received: from mail4.swissbit.com (mail4.swissbit.com [176.95.1.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1828B7D4;
        Tue, 28 Jun 2022 02:08:41 -0700 (PDT)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 9D700122D60;
        Tue, 28 Jun 2022 11:08:39 +0200 (CEST)
Received: from mail4.swissbit.com (localhost [127.0.0.1])
        by DDEI (Postfix) with ESMTP id 8D20A1210A3;
        Tue, 28 Jun 2022 11:08:39 +0200 (CEST)
X-TM-AS-ERS: 10.149.2.84-127.5.254.253
X-TM-AS-SMTP: 1.0 ZXguc3dpc3NiaXQuY29t Y2xvZWhsZUBoeXBlcnN0b25lLmNvbQ==
X-DDEI-TLS-USAGE: Used
Received: from ex.swissbit.com (SBDEEX02.sbitdom.lan [10.149.2.84])
        by mail4.swissbit.com (Postfix) with ESMTPS;
        Tue, 28 Jun 2022 11:08:39 +0200 (CEST)
Received: from sbdeex04.sbitdom.lan (10.149.2.42) by sbdeex02.sbitdom.lan
 (10.149.2.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 28 Jun
 2022 11:08:39 +0200
Received: from sbdeex02.sbitdom.lan (10.149.2.84) by sbdeex04.sbitdom.lan
 (10.149.2.42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.9; Tue, 28 Jun
 2022 11:08:38 +0200
Received: from sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74]) by
 sbdeex02.sbitdom.lan ([fe80::e0eb:ade8:2d90:1f74%8]) with mapi id
 15.02.1118.009; Tue, 28 Jun 2022 11:08:38 +0200
From:   =?utf-8?B?Q2hyaXN0aWFuIEzDtmhsZQ==?= <CLoehle@hyperstone.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Avri Altman <Avri.Altman@wdc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv2] mmc: block: Add single read for 4k sector cards
Thread-Topic: [PATCHv2] mmc: block: Add single read for 4k sector cards
Thread-Index: AdiKzna0+g5AvjvkSNCt642mggS2Cg==
Date:   Tue, 28 Jun 2022 09:08:38 +0000
Message-ID: <e0cce326393645d3b4a163ce65c89fb9@hyperstone.com>
Accept-Language: en-US, de-DE
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.153.3.44]
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-TMASE-Version: DDEI-5.1-9.0.1002-26982.006
X-TMASE-Result: 10--9.728500-10.000000
X-TMASE-MatchedRID: Q8pJWSpPf0PUL3YCMmnG4pTQgFTHgkhZC/ExpXrHizxHpEd1UrzmFXMI
        apaDo9OK8gY29qvMyB/Uw09eu4b0WPXNEkgZOg/OF3wQ0cu1bTNiMNd0z/HZU8wCk4rhHwXiOZI
        W98PNU9gsmvr/DPyX3OaffHI8kAmiHY/bzRmIaZHknMSTG9lH+PG6GRFYrbYYvn+2qfQyWg0tbE
        BnKg+1LQ3TW6V9v+MAS5wwTxCFN2wTr1kBttf31MfIK2dgWYWGCAqv0AzE/rHd59OkzfbBsn8Ro
        blyFKn4l/NSQGlzTvaBlRaBjYqALsScaqsh62EWngIgpj8eDcDBa6VG2+9jFNQdB5NUNSsi1GcR
        AJRT6POOhzOa6g8KrXkQRMIhHnpd6Od4oFRB8273hyzdkbT3W8oEhXwiImkUi3sq9MEA0ZI=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-TMASE-INERTIA: 0-0;;;;
X-TMASE-XGENCLOUD: c5272a02-4134-495b-8483-b56ec401e14c-0-0-200-0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBDYXJkcyB3aXRoIDRrIG5hdGl2ZSBzZWN0b3Igc2l6ZSBtYXkgb25seSBiZSByZWFkIDRrLWFs
aWduZWQsDQo+PiBhY2NvbW1vZGF0ZSBmb3IgdGhpcyBpbiB0aGUgc2luZ2xlIHJlYWQgcmVjb3Zl
cnkgYW5kIHVzZSBpdC4NCj4NCj5UaGFua3MgZm9yIHRoZSBwYXRjaC4NCj4NCj4+IA0KPj4gRml4
ZXM6IDgxMTk2OTc2ZWQ5NDYgKG1tYzogYmxvY2s6IEFkZCBibGstbXEgc3VwcG9ydCkNCj4+IFNp
Z25lZC1vZmYtYnk6IENocmlzdGlhbiBMb2VobGUgPGNsb2VobGVAaHlwZXJzdG9uZS5jb20+DQo+
DQo+RllJIGNoZWNrcGF0Y2ggc2F5czoNCj4NCj5XQVJOSU5HOiBGcm9tOi9TaWduZWQtb2ZmLWJ5
OiBlbWFpbCBuYW1lIG1pc21hdGNoOiAnRnJvbTogIkNocmlzdGlhbiBMw7ZobGUiIDxDTG9laGxl
QGh5cGVyc3RvbmUuY29tPicgIT0gJ1NpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBMb2VobGUgPGNs
b2VobGVAaHlwZXJzdG9uZS5jb20+Jw0KDQpXaWxsIGJlIGZpeGVkIGluIG15IGZ1dHVyZSBwYXRj
aGVzLCB0aGFua3MgZm9yIHRoZSBoaW50Lg0KDQo+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL21tYy9j
b3JlL2Jsb2NrLmMgfCAyNSArKysrKysrKysrKystLS0tLS0tLS0tLS0tDQo+PiAgMSBmaWxlIGNo
YW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygtKQ0KPj4gDQo+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9tbWMvY29yZS9ibG9jay5jIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5j
DQo+PiBpbmRleCBmNGExMjgxNjU4ZGIuLmE3NWEyMDhjZTIwMyAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvbW1jL2NvcmUvYmxvY2suYw0KPj4gKysrIGIvZHJpdmVycy9tbWMvY29yZS9ibG9jay5j
DQo+PiBAQCAtMTc2LDcgKzE3Niw3IEBAIHN0YXRpYyBpbmxpbmUgaW50IG1tY19ibGtfcGFydF9z
d2l0Y2goc3RydWN0IG1tY19jYXJkICpjYXJkLA0KPj4gIAkJCQkgICAgICB1bnNpZ25lZCBpbnQg
cGFydF90eXBlKTsNCj4+ICBzdGF0aWMgdm9pZCBtbWNfYmxrX3J3X3JxX3ByZXAoc3RydWN0IG1t
Y19xdWV1ZV9yZXEgKm1xcnEsDQo+PiAgCQkJICAgICAgIHN0cnVjdCBtbWNfY2FyZCAqY2FyZCwN
Cj4+IC0JCQkgICAgICAgaW50IGRpc2FibGVfbXVsdGksDQo+PiArCQkJICAgICAgIGludCByZWNv
dmVyeV9tb2RlLA0KPj4gIAkJCSAgICAgICBzdHJ1Y3QgbW1jX3F1ZXVlICptcSk7DQo+PiAgc3Rh
dGljIHZvaWQgbW1jX2Jsa19oc3FfcmVxX2RvbmUoc3RydWN0IG1tY19yZXF1ZXN0ICptcnEpOw0K
Pj4gIA0KPj4gQEAgLTEzMDIsNyArMTMwMiw3IEBAIHN0YXRpYyB2b2lkIG1tY19ibGtfZXZhbF9y
ZXNwX2Vycm9yKHN0cnVjdCBtbWNfYmxrX3JlcXVlc3QgKmJycSkNCj4+ICB9DQo+PiAgDQo+PiAg
c3RhdGljIHZvaWQgbW1jX2Jsa19kYXRhX3ByZXAoc3RydWN0IG1tY19xdWV1ZSAqbXEsIHN0cnVj
dCBtbWNfcXVldWVfcmVxICptcXJxLA0KPj4gLQkJCSAgICAgIGludCBkaXNhYmxlX211bHRpLCBi
b29sICpkb19yZWxfd3JfcCwNCj4+ICsJCQkgICAgICBpbnQgcmVjb3ZlcnlfbW9kZSwgYm9vbCAq
ZG9fcmVsX3dyX3AsDQo+PiAgCQkJICAgICAgYm9vbCAqZG9fZGF0YV90YWdfcCkNCj4+ICB7DQo+
PiAgCXN0cnVjdCBtbWNfYmxrX2RhdGEgKm1kID0gbXEtPmJsa2RhdGE7DQo+PiBAQCAtMTM3Miw4
ICsxMzcyLDggQEAgc3RhdGljIHZvaWQgbW1jX2Jsa19kYXRhX3ByZXAoc3RydWN0IG1tY19xdWV1
ZSAqbXEsIHN0cnVjdCBtbWNfcXVldWVfcmVxICptcXJxLA0KPj4gIAkJICogYXQgYSB0aW1lIGlu
IG9yZGVyIHRvIGFjY3VyYXRlbHkgZGV0ZXJtaW5lIHdoaWNoDQo+PiAgCQkgKiBzZWN0b3JzIGNh
biBiZSByZWFkIHN1Y2Nlc3NmdWxseS4NCj4+ICAJCSAqLw0KPj4gLQkJaWYgKGRpc2FibGVfbXVs
dGkpDQo+PiAtCQkJYnJxLT5kYXRhLmJsb2NrcyA9IDE7DQo+PiArCQlpZiAocmVjb3ZlcnlfbW9k
ZSkNCj4+ICsJCQlicnEtPmRhdGEuYmxvY2tzID0gbW1jX2xhcmdlX3NlY3RvcihjYXJkKSA/IDgg
OiAxOw0KPg0KPkkgc3VnZ2VzdCBjaGFuZ2luZyB0byB1c2UgcXVldWVfcGh5c2ljYWxfYmxvY2tf
c2l6ZSgpIGhlcmUgYW5kIGZ1cnRoZXIgYmVsb3cNCg0KVGhpcyBwYXJ0IEknbSBpbXBhcnRpYWwg
YWJvdXQsIG5vdCBzdXJlIGlmIGl0IG1ha2VzIGl0IG1vcmUgcmVhZGFibGUsIGhvcGVmdWxseSB3
ZSBuZXZlciBoYXZlIHRvIHN1cHBvcnQgYW5vdGhlciAibmF0aXZlIHNlY3RvciBzaXplIiBhcGFy
dCBmcm9tIHRoZSB0d28uDQpBbnl3YXkgSSB3aWxsIHNlbmQgdGhlIG5leHQgcGF0Y2ggd2l0aCBx
dWV1ZV9waHlzaWNhbF9ibG9ja19zaXplKCkNCg0KPg0KPgkJCWJycS0+ZGF0YS5ibG9ja3MgPSBx
dWV1ZV9waHlzaWNhbF9ibG9ja19zaXplKHJlcS0+cSkgPj4gU0VDVE9SX1NISUZUOw0KDQpEbyB3
ZSB3YW50IHRvIHN3aXRjaCB0byBTRUNUT1JfU0hJRlQgaW5zdGVhZCBvZiA5PyBTbyBmYXIgU0VD
VE9SX1NISUZUIGlzIG5vdCB1c2VkIGF0IGFsbCBpbiBtbWMgY29yZS4NCklmIHNvIEkgd291bGQg
Z28gYWhlYWQgYW5kIGNoYW5nZSBhbGwgdGhlIG90aGVycyBpbiBhbm90aGVyIHBhdGNoOg0KcXVl
dWUuYzoxODc6CXEtPmxpbWl0cy5kaXNjYXJkX2dyYW51bGFyaXR5ID0gY2FyZC0+cHJlZl9lcmFz
ZSA8PCA5Ow0KY29yZS5jOjEwMzoJZGF0YS0+Ynl0ZXNfeGZlcmVkID0gKHByYW5kb21fdTMyKCkg
JSAoZGF0YS0+Ynl0ZXNfeGZlcmVkID4+IDkpKSA8PCA5Ow0KbW1jLmM6NzkyOk1NQ19ERVZfQVRU
UihlcmFzZV9zaXplLCAiJXVcbiIsIGNhcmQtPmVyYXNlX3NpemUgPDwgOSk7DQptbWMuYzo3OTM6
TU1DX0RFVl9BVFRSKHByZWZlcnJlZF9lcmFzZV9zaXplLCAiJXVcbiIsIGNhcmQtPnByZWZfZXJh
c2UgPDwgOSk7DQptbWNfdGVzdC5jOjE1NTc6CXN6ID0gKHVuc2lnbmVkIGxvbmcpdGVzdC0+Y2Fy
ZC0+cHJlZl9lcmFzZSA8PCA5Ow0KbW1jX3Rlc3QuYzoxNTcwOgkJdC0+bWF4X3RmciA9IHRlc3Qt
PmNhcmQtPmhvc3QtPm1heF9ibGtfY291bnQgPDwgOTsNCm1tY190ZXN0LmM6MjQ2MToJaWYgKHJl
cGVhdF9jbWQgJiYgKHQtPmJsb2NrcyArIDEpIDw8IDkgPiB0LT5tYXhfdGZyKQ0Kc2QuYzo3MDc6
TU1DX0RFVl9BVFRSKGVyYXNlX3NpemUsICIldVxuIiwgY2FyZC0+ZXJhc2Vfc2l6ZSA8PCA5KTsN
CnNkLmM6NzA4Ok1NQ19ERVZfQVRUUihwcmVmZXJyZWRfZXJhc2Vfc2l6ZSwgIiV1XG4iLCBjYXJk
LT5wcmVmX2VyYXNlIDw8IDkpOw0KYmxvY2suYzoxNDE3OgkJaW50IGksIGRhdGFfc2l6ZSA9IGJy
cS0+ZGF0YS5ibG9ja3MgPDwgOTsNCmJsb2NrLmM6MTg1MToJCQlicnEtPmRhdGEuYnl0ZXNfeGZl
cmVkID0gYmxvY2tzIDw8IDk7DQoNCg0KDQoNCkh5cGVyc3RvbmUgR21iSCB8IFJlaWNoZW5hdXN0
ci4gMzlhICB8IDc4NDY3IEtvbnN0YW56Ck1hbmFnaW5nIERpcmVjdG9yOiBEci4gSmFuIFBldGVy
IEJlcm5zLgpDb21tZXJjaWFsIHJlZ2lzdGVyIG9mIGxvY2FsIGNvdXJ0czogRnJlaWJ1cmcgSFJC
MzgxNzgy

