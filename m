Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60F084CA108
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 10:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiCBJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 04:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbiCBJn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 04:43:59 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 048583FBE1;
        Wed,  2 Mar 2022 01:43:13 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 2229h2yQ5018936, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 2229h2yQ5018936
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 2 Mar 2022 17:43:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 2 Mar 2022 17:43:02 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 2 Mar 2022 17:43:02 +0800
Received: from RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026]) by
 RTEXMBS01.realtek.com.tw ([fe80::a0f1:14d7:38a1:7026%5]) with mapi id
 15.01.2308.021; Wed, 2 Mar 2022 17:43:02 +0800
From:   Ricky WU <ricky_wu@realtek.com>
To:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "tommyhebb@gmail.com" <tommyhebb@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Ricky WU <ricky_wu@realtek.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] mmc: rtsx: add 74 Clocks in power on flow
Thread-Topic: [PATCH v2] mmc: rtsx: add 74 Clocks in power on flow
Thread-Index: AQHYLhiam9g55Mvmak6rZ30/oxnp2g==
Date:   Wed, 2 Mar 2022 09:43:01 +0000
Message-ID: <1badf10aba764191a1a752edcbf90389@realtek.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.81.102]
x-kse-serverinfo: RTEXMBS04.realtek.com.tw, 9
x-kse-attachmentfiltering-interceptor-info: no applicable attachment filtering
 rules found
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvMiCkV6TIIDA3OjU0OjAw?=
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
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

U0Qgc3BlYyBkZWZpbml0aW9uOg0KIkhvc3QgcHJvdmlkZXMgYXQgbGVhc3QgNzQgQ2xvY2tzIGJl
Zm9yZSBpc3N1aW5nIGZpcnN0IGNvbW1hbmQiDQpBZnRlciAxbXMgZm9yIHRoZSB2b2x0YWdlIHN0
YWJsZSB0aGVuIHN0YXJ0IGlzc3VpbmcgdGhlIENsb2NrIHNpZ25hbHMNCg0KaWYgUE9XRVIgU1RB
VEUgaXMNCk1NQ19QT1dFUl9PRkYgdG8gTU1DX1BPV0VSX1VQIHRvIGlzc3VlIENsb2NrIHNpZ25h
bCB0byBjYXJkDQpNTUNfUE9XRVJfVVAgdG8gTU1DX1BPV0VSX09OIHRvIHN0b3AgaXNzdWluZyBz
aWduYWwgdG8gY2FyZA0KDQpTaWduZWQtb2ZmLWJ5OiBSaWNreSBXdSA8cmlja3lfd3VAcmVhbHRl
ay5jb20+DQotLS0NCnYyOg0KbW9kaWZ5IGNvbW1pdCBtZXNzYWdlDQptb3ZlIG1kZWxheSg1KSB0
byBob3N0LT5wb3dlcl9kZWxheV9tcw0KcmVwbGFjZSBob3N0LT5wb3dlcl9zdGF0ZSB3aXRoIGhv
c3QtPnByZXZfcG93ZXJfc3RhdGUNCi0tLQ0KIGRyaXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2Rt
bWMuYyB8IDI5ICsrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQogMSBmaWxlIGNoYW5nZWQs
IDE5IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9tbWMvaG9zdC9ydHN4X3BjaV9zZG1tYy5jIGIvZHJpdmVycy9tbWMvaG9zdC9ydHN4X3BjaV9z
ZG1tYy5jDQppbmRleCAyYTNmMTRhZmU5ZjguLmQyNjgwM2QzZjRjYSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvbW1jL2hvc3QvcnRzeF9wY2lfc2RtbWMuYw0KKysrIGIvZHJpdmVycy9tbWMvaG9zdC9y
dHN4X3BjaV9zZG1tYy5jDQpAQCAtMzgsMTAgKzM4LDcgQEAgc3RydWN0IHJlYWx0ZWtfcGNpX3Nk
bW1jIHsNCiAJYm9vbAkJCWRvdWJsZV9jbGs7DQogCWJvb2wJCQllamVjdDsNCiAJYm9vbAkJCWlu
aXRpYWxfbW9kZTsNCi0JaW50CQkJcG93ZXJfc3RhdGU7DQotI2RlZmluZSBTRE1NQ19QT1dFUl9P
TgkJMQ0KLSNkZWZpbmUgU0RNTUNfUE9XRVJfT0ZGCQkwDQotDQorCWludAkJCXByZXZfcG93ZXJf
c3RhdGU7DQogCWludAkJCXNnX2NvdW50Ow0KIAlzMzIJCQljb29raWU7DQogCWludAkJCWNvb2tp
ZV9zZ19jb3VudDsNCkBAIC05MDksNyArOTA2LDcgQEAgc3RhdGljIGludCBzZF9zZXRfYnVzX3dp
ZHRoKHN0cnVjdCByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCwNCiAJcmV0dXJuIGVycjsNCiB9DQog
DQotc3RhdGljIGludCBzZF9wb3dlcl9vbihzdHJ1Y3QgcmVhbHRla19wY2lfc2RtbWMgKmhvc3Qp
DQorc3RhdGljIGludCBzZF9wb3dlcl9vbihzdHJ1Y3QgcmVhbHRla19wY2lfc2RtbWMgKmhvc3Qs
IHVuc2lnbmVkIGNoYXIgcG93ZXJfbW9kZSkNCiB7DQogCXN0cnVjdCBydHN4X3BjciAqcGNyID0g
aG9zdC0+cGNyOw0KIAlzdHJ1Y3QgbW1jX2hvc3QgKm1tYyA9IGhvc3QtPm1tYzsNCkBAIC05MTcs
OSArOTE0LDE0IEBAIHN0YXRpYyBpbnQgc2RfcG93ZXJfb24oc3RydWN0IHJlYWx0ZWtfcGNpX3Nk
bW1jICpob3N0KQ0KIAl1MzIgdmFsOw0KIAl1OCB0ZXN0X21vZGU7DQogDQotCWlmIChob3N0LT5w
b3dlcl9zdGF0ZSA9PSBTRE1NQ19QT1dFUl9PTikNCisJaWYgKGhvc3QtPnByZXZfcG93ZXJfc3Rh
dGUgPT0gTU1DX1BPV0VSX09OKQ0KIAkJcmV0dXJuIDA7DQogDQorCWlmIChob3N0LT5wcmV2X3Bv
d2VyX3N0YXRlID09IE1NQ19QT1dFUl9VUCkgew0KKwkJcnRzeF9wY2lfd3JpdGVfcmVnaXN0ZXIo
cGNyLCBTRF9CVVNfU1RBVCwgU0RfQ0xLX1RPR0dMRV9FTiwgMCk7DQorCQlnb3RvIGZpbmlzaDsN
CisJfQ0KKw0KIAltc2xlZXAoMTAwKTsNCiANCiAJcnRzeF9wY2lfaW5pdF9jbWQocGNyKTsNCkBA
IC05NDAsMTAgKzk0MiwxNSBAQCBzdGF0aWMgaW50IHNkX3Bvd2VyX29uKHN0cnVjdCByZWFsdGVr
X3BjaV9zZG1tYyAqaG9zdCkNCiAJaWYgKGVyciA8IDApDQogCQlyZXR1cm4gZXJyOw0KIA0KKwlt
ZGVsYXkoMSk7DQorDQogCWVyciA9IHJ0c3hfcGNpX3dyaXRlX3JlZ2lzdGVyKHBjciwgQ0FSRF9P
RSwgU0RfT1VUUFVUX0VOLCBTRF9PVVRQVVRfRU4pOw0KIAlpZiAoZXJyIDwgMCkNCiAJCXJldHVy
biBlcnI7DQogDQorCS8qIHNlbmQgYXQgbGVhc3QgNzQgY2xvY2tzICovDQorCXJ0c3hfcGNpX3dy
aXRlX3JlZ2lzdGVyKHBjciwgU0RfQlVTX1NUQVQsIFNEX0NMS19UT0dHTEVfRU4sIFNEX0NMS19U
T0dHTEVfRU4pOw0KKw0KIAlpZiAoUENJX1BJRChwY3IpID09IFBJRF81MjYxKSB7DQogCQkvKg0K
IAkJICogSWYgdGVzdCBtb2RlIGlzIHNldCBzd2l0Y2ggdG8gU0QgRXhwcmVzcyBtYW5kYXRvcmls
eSwNCkBAIC05NjgsNyArOTc1LDggQEAgc3RhdGljIGludCBzZF9wb3dlcl9vbihzdHJ1Y3QgcmVh
bHRla19wY2lfc2RtbWMgKmhvc3QpDQogCQl9DQogCX0NCiANCi0JaG9zdC0+cG93ZXJfc3RhdGUg
PSBTRE1NQ19QT1dFUl9PTjsNCitmaW5pc2g6DQorCWhvc3QtPnByZXZfcG93ZXJfc3RhdGUgPSBw
b3dlcl9tb2RlOw0KIAlyZXR1cm4gMDsNCiB9DQogDQpAQCAtOTc3LDcgKzk4NSw3IEBAIHN0YXRp
YyBpbnQgc2RfcG93ZXJfb2ZmKHN0cnVjdCByZWFsdGVrX3BjaV9zZG1tYyAqaG9zdCkNCiAJc3Ry
dWN0IHJ0c3hfcGNyICpwY3IgPSBob3N0LT5wY3I7DQogCWludCBlcnI7DQogDQotCWhvc3QtPnBv
d2VyX3N0YXRlID0gU0RNTUNfUE9XRVJfT0ZGOw0KKwlob3N0LT5wcmV2X3Bvd2VyX3N0YXRlID0g
TU1DX1BPV0VSX09GRjsNCiANCiAJcnRzeF9wY2lfaW5pdF9jbWQocGNyKTsNCiANCkBAIC0xMDAz
LDcgKzEwMTEsNyBAQCBzdGF0aWMgaW50IHNkX3NldF9wb3dlcl9tb2RlKHN0cnVjdCByZWFsdGVr
X3BjaV9zZG1tYyAqaG9zdCwNCiAJaWYgKHBvd2VyX21vZGUgPT0gTU1DX1BPV0VSX09GRikNCiAJ
CWVyciA9IHNkX3Bvd2VyX29mZihob3N0KTsNCiAJZWxzZQ0KLQkJZXJyID0gc2RfcG93ZXJfb24o
aG9zdCk7DQorCQllcnIgPSBzZF9wb3dlcl9vbihob3N0LCBwb3dlcl9tb2RlKTsNCiANCiAJcmV0
dXJuIGVycjsNCiB9DQpAQCAtMTUwNiwxMCArMTUxNCwxMSBAQCBzdGF0aWMgaW50IHJ0c3hfcGNp
X3NkbW1jX2Rydl9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KIA0KIAlob3N0
ID0gbW1jX3ByaXYobW1jKTsNCiAJaG9zdC0+cGNyID0gcGNyOw0KKwltbWMtPmlvcy5wb3dlcl9k
ZWxheV9tcyA9IDU7DQogCWhvc3QtPm1tYyA9IG1tYzsNCiAJaG9zdC0+cGRldiA9IHBkZXY7DQog
CWhvc3QtPmNvb2tpZSA9IC0xOw0KLQlob3N0LT5wb3dlcl9zdGF0ZSA9IFNETU1DX1BPV0VSX09G
RjsNCisJaG9zdC0+cHJldl9wb3dlcl9zdGF0ZSA9IE1NQ19QT1dFUl9PRkY7DQogCUlOSVRfV09S
SygmaG9zdC0+d29yaywgc2RfcmVxdWVzdCk7DQogCXBsYXRmb3JtX3NldF9kcnZkYXRhKHBkZXYs
IGhvc3QpOw0KIAlwY3ItPnNsb3RzW1JUU1hfU0RfQ0FSRF0ucF9kZXYgPSBwZGV2Ow0KLS0gDQoy
LjI1LjENCg==
