Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185964D980A
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:49:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346814AbiCOJuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbiCOJuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:50:10 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D574ECD6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:48:58 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nU3nJ-0004sX-UN; Tue, 15 Mar 2022 10:48:45 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nU3nI-000oTA-SH; Tue, 15 Mar 2022 10:48:43 +0100
Received: from pza by lupine with local (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1nU3nG-0002bJ-TX; Tue, 15 Mar 2022 10:48:42 +0100
Message-ID: <daecd30e4798e7d1e4b74dfe37d67b74a6f3cde1.camel@pengutronix.de>
Subject: Re: [PATCH V2] mmc: sdhci-msm: Reset GCC_SDCC_BCR register for SDHC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>,
        adrian.hunter@intel.com, agross@kernel.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        chris@printf.net, gdjakov@mm-sol.com
Cc:     linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_asutoshd@quicinc.com,
        quic_rampraka@quicinc.com, quic_pragalla@quicinc.com,
        quic_sartgarg@quicinc.com, quic_nitirawa@quicinc.com,
        quic_sayalil@quicinc.com
Date:   Tue, 15 Mar 2022 10:48:42 +0100
In-Reply-To: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
References: <1646926823-5362-1-git-send-email-quic_c_sbhanu@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU2FqaWRhLAoKT24gRG8sIDIwMjItMDMtMTAgYXQgMjE6MTAgKzA1MzAsIFNoYWlrIFNhamlk
YSBCaGFudSB3cm90ZToKWy4uLl0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS1tc20uYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktCj4gbXNtLmMKPiBpbmRleCA1MGM3MWUw
Li5jYjMzYzlhIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktbXNtLmMKPiAr
KysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLW1zbS5jClsuLi5dCj4gQEAgLTI0ODIsNiArMjQ4
NCw0NSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgc2RoY2lfbXNtX2dldF9vZl9wcm9wZXJ0eShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LAo+IMKgwqDCoMKgwqDCoMKgwqBvZl9wcm9wZXJ0eV9y
ZWFkX3UzMihub2RlLCAicWNvbSxkbGwtY29uZmlnIiwgJm1zbV9ob3N0LT5kbGxfY29uZmlnKTsK
PiDCoH0KPiDCoAo+ICtzdGF0aWMgaW50IHNkaGNpX21zbV9nY2NfcmVzZXQoc3RydWN0IHBsYXRm
b3JtX2RldmljZSAqcGRldiwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHNk
aGNpX2hvc3QgKmhvc3QpCj4gK3sKPiArwqDCoMKgwqDCoMKgwqBzdHJ1Y3Qgc2RoY2lfcGx0Zm1f
aG9zdCAqcGx0Zm1faG9zdCA9IHNkaGNpX3ByaXYoaG9zdCk7Cj4gK8KgwqDCoMKgwqDCoMKgc3Ry
dWN0IHNkaGNpX21zbV9ob3N0ICptc21faG9zdCA9IHNkaGNpX3BsdGZtX3ByaXYocGx0Zm1faG9z
dCk7Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHJldCA9IDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoG1z
bV9ob3N0LT5jb3JlX3Jlc2V0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldF9vcHRpb25hbF9leGNs
dXNpdmUoJnBkZXYtPmRldiwgImNvcmVfcmVzZXQiKTsKCkkgdGhpbmsgdGhlICJfcmVzZXQiIHBh
cnQgaW4gdGhlIG5hbWUgaXMgc3VwZXJmbHVvdXMgYW5kIHRoaXMgcmVzZXQKY29udHJvbCBzaG91
bGQgYmUgY2FsbGVkICJjb3JlIi4gSXMgdGhpcyBkb2N1bWVudGVkIGluIHRoZSBzZGhjaS1tc20K
ZGV2aWNlIHRyZWUgYmluZGluZyBkb2N1bWVudD8KCj4gK8KgwqDCoMKgwqDCoMKgaWYgKElTX0VS
Uihtc21faG9zdC0+Y29yZV9yZXNldCkpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgcmV0ID0gUFRSX0VSUihtc21faG9zdC0+Y29yZV9yZXNldCk7Cj4gK8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoGRldl9lcnIoJnBkZXYtPmRldiwgImNvcmVfcmVzZXQgdW5hdmFpbGFi
bGUgKCVkKVxuIiwgcmV0KTsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgbXNtX2hv
c3QtPmNvcmVfcmVzZXQgPSBOVUxMOwoKQXMgQmpvcm4gcG9pbnRlZCBvdXQsIHRoaXMgZXJyb3Ig
c2hvdWxkIGJlIHJldHVybmVkLgpyZXNldF9jb250cm9sX2dldF9vcHRpb25hbCByZXR1cm5zIE5V
TEwgaWYgdGhlIG9wdGlvbmFsIHJlc2V0IGNvbnRyb2wKaXMgbm90IHNwZWNpZmllZCBpbiB0aGUg
ZGV2aWNlIHRyZWUsIHNvIHdlIG9ubHkgbGFuZCBoZXJlIGlmIHRoZXJlJ3MgYQpyZWFsIGVycm9y
LgoKWy4uLl0KPiBAQCAtMjUyOSw2ICsyNTcwLDEzIEBAIHN0YXRpYyBpbnQgc2RoY2lfbXNtX3By
b2JlKHN0cnVjdAo+IHBsYXRmb3JtX2RldmljZSAqcGRldikKPiDCoAo+IMKgwqDCoMKgwqDCoMKg
wqBtc21faG9zdC0+c2F2ZWRfdHVuaW5nX3BoYXNlID0gSU5WQUxJRF9UVU5JTkdfUEhBU0U7Cj4g
wqAKPiArwqDCoMKgwqDCoMKgwqByZXQgPSBzZGhjaV9tc21fZ2NjX3Jlc2V0KHBkZXYsIGhvc3Qp
Owo+ICvCoMKgwqDCoMKgwqDCoGlmIChyZXQpIHsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgZGV2X2VycigmcGRldi0+ZGV2LCAiY29yZV9yZXNldCBhc3NlcnQvZGVhc3NlcnQgZmFp
bGVkICglZClcbiIsCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCk7Cj4gK8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoGdvdG8gcGx0Zm1fZnJlZTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4g
Kwo+IMKgwqDCoMKgwqDCoMKgwqAvKiBTZXR1cCBTRENDIGJ1cyB2b3RlciBjbG9jay4gKi8KPiDC
oMKgwqDCoMKgwqDCoMKgbXNtX2hvc3QtPmJ1c19jbGsgPSBkZXZtX2Nsa19nZXQoJnBkZXYtPmRl
diwgImJ1cyIpOwo+IMKgwqDCoMKgwqDCoMKgwqBpZiAoIUlTX0VSUihtc21faG9zdC0+YnVzX2Ns
aykpIHsKCkkgbm90aWNlIHRoYXQgdGhpcyBkcml2ZXIgcmVxdWVzdHMgcmVzb3VyY2VzIHN1Y2gg
YXMgY2xvY2tzIGFuZCByZXNldHMKYW5kIHRoZW4gaW1tZWRpYXRlbHkgdXNlcyB0aGVtLCBvbmUg
Ynkgb25lLiBJdCB3b3VsZCBiZSBiZXR0ZXIgdG8KcmVxdWVzdCBhbGwgcmVzb3VyY2VzIGZpcnN0
LCBhbmQgb25seSB0aGVuIHN0YXJ0IGludGVyYWN0aW5nIHdpdGggdGhlCmhhcmR3YXJlLiBUaGlz
IGlzIG5vdCBhbiBpc3N1ZSB0aGF0IGNhbiBiZSBmaXhlZCBpbiB0aGlzIHBhdGNoLAphbHRob3Vn
aCBtYXliZSBpdCBjb3VsZCBiZSBwcmVwYXJlZCBmb3IgaXQgYnkgc2VwYXJhdGluZyB0aGUKcmVz
ZXRfY29udHJvbF9nZXQgZnJvbSB0aGUgX2Fzc2VydC9kZWFzc2VydC4KCnJlZ2FyZHMKUGhpbGlw
cAo=

