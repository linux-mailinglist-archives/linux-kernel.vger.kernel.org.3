Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8484758F4
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242566AbhLOMgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:36:38 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:48934 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242572AbhLOMgg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:36:36 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 523514382B;
        Wed, 15 Dec 2021 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-type:content-type
        :content-language:accept-language:in-reply-to:references
        :message-id:date:date:subject:subject:from:from:received
        :received:received:received:received; s=mta-01; t=1639571794; x=
        1641386195; bh=vYjW8XrgnwJ5djB3iYo4jM09bOlWQU/PIRsmeJ0i0vg=; b=n
        46q9AEkWrYlHbHDzxf5EMfQtQsqI+xHhjvxeBVRyWjtBXxwvFfsFXni+BGk1eb/q
        74Cr1DJDB4U1HSAhAVmv/Wok86/SH6xzXD0ni/9O+FCAdRdSdT6aKvN/b8wKAU3y
        1X+XG/8Lg3u5bjOw+qN/EbRp+HRSq3YTURhEvIRdRA=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Gk4kjZDlEaU3; Wed, 15 Dec 2021 15:36:34 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id A57D443828;
        Wed, 15 Dec 2021 15:36:33 +0300 (MSK)
Received: from T-EXCH-06.corp.yadro.com (172.17.10.110) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 15 Dec 2021 15:36:33 +0300
Received: from T-Exch-05.corp.yadro.com (172.17.10.109) by
 T-EXCH-06.corp.yadro.com (172.17.10.110) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 15 Dec 2021 15:36:33 +0300
Received: from T-Exch-05.corp.yadro.com ([fe80::a43b:5159:cc52:9ad8]) by
 T-Exch-05.corp.yadro.com ([fe80::a43b:5159:cc52:9ad8%14]) with mapi id
 15.02.0792.003; Wed, 15 Dec 2021 15:36:33 +0300
From:   Arseny Demidov <a.demidov@yadro.com>
To:     Guenter Roeck <linux@roeck-us.net>,
        Arseny Demidov <arsdemal@gmail.com>
CC:     Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hwmon : (mr75203) fix macro typo
Thread-Topic: [PATCH] hwmon : (mr75203) fix macro typo
Thread-Index: AQHX8adVWLaP7HAg3kCtAegOS1jXr6wzQLyAgAAJCICAADLCIA==
Date:   Wed, 15 Dec 2021 12:36:32 +0000
Message-ID: <c1d036c0cfa14fbb9c289f792780f003@yadro.com>
References: <20211215113023.2945-1-a.demidov@yadro.com>
 <0baa6133-5903-ffd8-69a0-99fb9f69665d@roeck-us.net>
 <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net>
In-Reply-To: <06d7c6ee-2db5-f250-50f7-9a47e33a35b5@roeck-us.net>
Accept-Language: en-US
Content-Language: ru-RU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.17.4.118]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzLCBJIGhhdmUgYWNjZXNzIHRvIHRoZSBkYXRhc2hlZXQgYW5kIGNhdWdodCBhbiBlcnJvciBv
biBzaW11bGF0aW9uIElQLWJsb2NrLg0KVGhlIGRhdGFzaGVldCBzYXlzIHRoYXQgcmVnaXN0ZXIg
IkV4cHJlc3NlZCBpbiB1bml0cyBvZiBJUCBjbGsgY3ljbGVzLiINClR5cGljYWwgcG93ZXItdXAg
ZGVsYXlzIGZvciBUZW1wZXJhdHVyZSBTZW5zb3IgYXJlIDI1NiBjeWNsZXMgaS4gZS4gMHgxMDAN
Cg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IEd1ZW50ZXIgUm9lY2sgPGdyb2Vj
azdAZ21haWwuY29tPiBPbiBCZWhhbGYgT2YgR3VlbnRlciBSb2Vjaw0KU2VudDogV2VkbmVzZGF5
LCBEZWNlbWJlciAxNSwgMjAyMSAzOjMxIFBNDQpUbzogQXJzZW55IERlbWlkb3YgPGFyc2RlbWFs
QGdtYWlsLmNvbT4NCkNjOiBBcnNlbnkgRGVtaWRvdiA8YS5kZW1pZG92QHlhZHJvLmNvbT47IEpl
YW4gRGVsdmFyZSA8amRlbHZhcmVAc3VzZS5jb20+OyBsaW51eC1od21vbkB2Z2VyLmtlcm5lbC5v
cmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3
bW9uIDogKG1yNzUyMDMpIGZpeCBtYWNybyB0eXBvDQoNCk9uIDEyLzE1LzIxIDM6NTkgQU0sIEd1
ZW50ZXIgUm9lY2sgd3JvdGU6DQo+IE9uIDEyLzE1LzIxIDM6MzAgQU0sIEFyc2VueSBEZW1pZG92
IHdyb3RlOg0KPj4gSW4gdGhlIGZpbGUgbXI3NTIwMy5jIHdlIGhhdmUgYSBtYWNybyBuYW1lZCBQ
T1dFUl9ERUxBWV9DWUNMRV8yNTYsIA0KPj4gdGhlIGNvcnJlY3QgdmFsdWUgc2hvdWxkIGJlIDB4
MTAwDQo+Pg0KPiANCj4gSG93IGRvIHlvdSBrbm93IHRoYXQgPyBEbyB5b3UgaGF2ZSBhY2Nlc3Mg
dG8gdGhlIGRhdGFzaGVldCwgb3IgaXMgaXQgDQo+IGp1c3QgYW4gYXNzdW1wdGlvbiBiYXNlZCBv
biB0aGUgbmFtZSBvZiB0aGUgZGVmaW5lID8NCj4gDQoNCkFsc28sIGhvdyBkbyB5b3Uga25vdyB0
aGF0IHRoZSB2YWx1ZSBpcyB3cm9uZywgbm90IHRoZSBuYW1lIG9mIHRoZSBkZWZpbmUgPw0KDQpH
dWVudGVyDQoNCj4gR3VlbnRlcg0KPiANCj4+IFNpZ25lZC1vZmYtYnk6IEFyc2VueSBEZW1pZG92
IDxhLmRlbWlkb3ZAeWFkcm8uY29tPg0KPj4gLS0tDQo+PiDCoCBkcml2ZXJzL2h3bW9uL21yNzUy
MDMuYyB8IDIgKy0NCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxl
dGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2h3bW9uL21yNzUyMDMuYyBiL2Ry
aXZlcnMvaHdtb24vbXI3NTIwMy5jIGluZGV4IA0KPj4gODY4MjQzZGJhMWVlLi4xYmExZTMxNDU5
NjkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2h3bW9uL21yNzUyMDMuYw0KPj4gKysrIGIvZHJp
dmVycy9od21vbi9tcjc1MjAzLmMNCj4+IEBAIC05Myw3ICs5Myw3IEBADQo+PiDCoCAjZGVmaW5l
IFZNX0NIX1JFUcKgwqDCoCBCSVQoMjEpDQo+PiDCoCAjZGVmaW5lIElQX1RNUsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMHgwNQ0KPj4gLSNkZWZpbmUgUE9XRVJfREVMQVlfQ1lDTEVfMjU2wqDCoMKg
IDB4ODANCj4+ICsjZGVmaW5lIFBPV0VSX0RFTEFZX0NZQ0xFXzI1NsKgwqDCoCAweDEwMA0KPj4g
wqAgI2RlZmluZSBQT1dFUl9ERUxBWV9DWUNMRV82NMKgwqDCoCAweDQwDQo+PiDCoCAjZGVmaW5l
IFBWVF9QT0xMX0RFTEFZX1VTwqDCoMKgIDIwDQo+Pg0KPiANCg0K
