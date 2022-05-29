Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F174F537177
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbiE2PMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiE2PMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:12:18 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4900413E04
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 08:12:15 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 29 May
 2022 23:06:53 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.20]
Date:   Sun, 29 May 2022 23:06:53 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     billm@melbpc.org.au, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: clean up warnings found by checkpatch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <6f4b4fa8.a91.181105b1395.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwA3QnANjJNigCY6AA--.694W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQARCmFEYxslrwAFsI
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkNsZWFuIHVwIGEgaGFuZGZ1bCBvZiBjaGVja3BhdGNoIHdhcm5pbmdzOgotIFdBUk5JTkc6IFBy
ZWZlciAnbG9uZycgb3ZlciAnbG9uZyBpbnQnIGFzIHRoZSBpbnQgaXMgdW5uZWNlc3NhcnkKLSBF
UlJPUjogImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKLSBXQVJOSU5HOiBVbm5lY2Vz
c2FyeSB0eXBlY2FzdCBvZiBjOTAgaW50IGNvbnN0YW50Ci0gJyh1bnNpZ25lZCBpbnQpMHhiNTA0
ZjMzNCcgY291bGQgYmUgJzB4YjUwNGYzMzRVJwotIFdBUk5JTkc6IFVubmVjZXNzYXJ5IHR5cGVj
YXN0IG9mIGM5MCBpbnQgY29uc3RhbnQKLSAnKHVuc2lnbmVkIGludCkweGFmYjBjY2MwJyBjb3Vs
ZCBiZSAnMHhhZmIwY2NjMFUnCgpTaWduZWQtb2ZmLWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWVi
aW5nQGphcmkuY24+Ci0tLQogYXJjaC94ODYvbWF0aC1lbXUvcG9seV9sMi5jIHwgMTYgKysrKysr
KystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9tYXRoLWVtdS9wb2x5X2wyLmMgYi9hcmNoL3g4Ni9t
YXRoLWVtdS9wb2x5X2wyLmMKaW5kZXggOThiNjk0OWJiODU0Li5mZmI1ZDg0NDY3ZDYgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L21hdGgtZW11L3BvbHlfbDIuYworKysgYi9hcmNoL3g4Ni9tYXRoLWVt
dS9wb2x5X2wyLmMKQEAgLTE5LDE0ICsxOSwxNCBAQAogI2luY2x1ZGUgInBvbHkuaCIKIAogc3Rh
dGljIHZvaWQgbG9nMl9rZXJuZWwoRlBVX1JFRyBjb25zdCAqYXJnLCB1X2NoYXIgYXJnc2lnbiwK
LQkJCVhzaWcgKiBhY2N1bV9yZXN1bHQsIGxvbmcgaW50ICpleHBvbik7CisJCQlYc2lnICogYWNj
dW1fcmVzdWx0LCBsb25nICpleHBvbik7CiAKIC8qLS0tIHBvbHlfbDIoKSAtLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKwogIHwgICBC
YXNlIDIgbG9nYXJpdGhtIGJ5IGEgcG9seW5vbWlhbCBhcHByb3hpbWF0aW9uLiAgICAgICAgICAg
ICAgICAgICAgICAgICB8CiAgKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSovCiB2b2lkIHBvbHlfbDIoRlBV
X1JFRyAqc3QwX3B0ciwgRlBVX1JFRyAqc3QxX3B0ciwgdV9jaGFyIHN0MV9zaWduKQogewotCWxv
bmcgaW50IGV4cG9uZW50LCBleHBvbiwgZXhwb25fZXhwb247CisJbG9uZyBleHBvbmVudCwgZXhw
b24sIGV4cG9uX2V4cG9uOwogCVhzaWcgYWNjdW11bGF0b3IsIGV4cG9uX2FjY3VtLCB5YWNjdW07
CiAJdV9jaGFyIHNpZ24sIGFyZ3NpZ247CiAJRlBVX1JFRyB4OwpAQCAtMzUsNyArMzUsNyBAQCB2
b2lkIHBvbHlfbDIoRlBVX1JFRyAqc3QwX3B0ciwgRlBVX1JFRyAqc3QxX3B0ciwgdV9jaGFyIHN0
MV9zaWduKQogCWV4cG9uZW50ID0gZXhwb25lbnQxNihzdDBfcHRyKTsKIAogCS8qIEZyb20gc3Qw
X3B0ciwgbWFrZSBhIG51bWJlciA+IHNxcnQoMikvMiBhbmQgPCBzcXJ0KDIpICovCi0JaWYgKHN0
MF9wdHItPnNpZ2ggPiAodW5zaWduZWQpMHhiNTA0ZjMzNCkgeworCWlmIChzdDBfcHRyLT5zaWdo
ID4gMHhiNTA0ZjMzNFUpIHsKIAkJLyogVHJlYXQgYXMgIHNxcnQoMikvMiA8IHN0MF9wdHIgPCAx
ICovCiAJCXNpZ25pZmljYW5kKCZ4KSA9IC1zaWduaWZpY2FuZChzdDBfcHRyKTsKIAkJc2V0ZXhw
b25lbnQxNigmeCwgLTEpOwpAQCAtMTA0LDEwICsxMDQsMTAgQEAgdm9pZCBwb2x5X2wyKEZQVV9S
RUcgKnN0MF9wdHIsIEZQVV9SRUcgKnN0MV9wdHIsIHVfY2hhciBzdDFfc2lnbikKICB8ICAgbG9n
Mih4KzEpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfAogICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLwogaW50IHBvbHlfbDJwMSh1X2No
YXIgc2lnbjAsIHVfY2hhciBzaWduMSwKLQkgICAgICBGUFVfUkVHICogc3QwX3B0ciwgRlBVX1JF
RyAqIHN0MV9wdHIsIEZQVV9SRUcgKiBkZXN0KQorCSAgICAgIEZQVV9SRUcgKnN0MF9wdHIsIEZQ
VV9SRUcgKnN0MV9wdHIsIEZQVV9SRUcgKmRlc3QpCiB7CiAJdV9jaGFyIHRhZzsKLQlsb25nIGlu
dCBleHBvbmVudDsKKwlsb25nIGV4cG9uZW50OwogCVhzaWcgYWNjdW11bGF0b3IsIHlhY2N1bTsK
IAogCWlmIChleHBvbmVudDE2KHN0MF9wdHIpIDwgMCkgewpAQCAtMTgwLDkgKzE4MCw5IEBAIHN0
YXRpYyBjb25zdCB1bnNpZ25lZCBsb25nIGxlYWR0ZXJtID0gMHhiODAwMDAwMDsKICB8ICAgbG9n
Mih4KzEpICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgfAogICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0qLwogc3RhdGljIHZvaWQgbG9nMl9r
ZXJuZWwoRlBVX1JFRyBjb25zdCAqYXJnLCB1X2NoYXIgYXJnc2lnbiwgWHNpZyAqYWNjdW1fcmVz
dWx0LAotCQkJbG9uZyBpbnQgKmV4cG9uKQorCQkJbG9uZyAqZXhwb24pCiB7Ci0JbG9uZyBpbnQg
ZXhwb25lbnQsIGFkajsKKwlsb25nIGV4cG9uZW50LCBhZGo7CiAJdW5zaWduZWQgbG9uZyBsb25n
IFhzcTsKIAlYc2lnIGFjY3VtdWxhdG9yLCBOdW1lciwgRGVub20sIGFyZ1NpZ25pZiwgYXJnX3Np
Z25pZjsKIApAQCAtMjEwLDcgKzIxMCw3IEBAIHN0YXRpYyB2b2lkIGxvZzJfa2VybmVsKEZQVV9S
RUcgY29uc3QgKmFyZywgdV9jaGFyIGFyZ3NpZ24sIFhzaWcgKmFjY3VtX3Jlc3VsdCwKICNpZm5k
ZWYgUEVDVUxJQVJfNDg2CiAJLyogU2hvdWxkIGNoZWNrIGhlcmUgdGhhdCAgfGxvY2FsX2FyZ3wg
IGlzIHdpdGhpbiB0aGUgdmFsaWQgcmFuZ2UgKi8KIAlpZiAoZXhwb25lbnQgPj0gLTIpIHsKLQkJ
aWYgKChleHBvbmVudCA+IC0yKSB8fCAoYXJnU2lnbmlmLm1zdyA+ICh1bnNpZ25lZCkweGFmYjBj
Y2MwKSkgeworCQlpZiAoKGV4cG9uZW50ID4gLTIpIHx8IChhcmdTaWduaWYubXN3ID4gMHhhZmIw
Y2NjMFUpKSB7CiAJCQkvKiBUaGUgYXJndW1lbnQgaXMgdG9vIGxhcmdlICovCiAJCX0KIAl9Ci0t
IAoyLjM2LjEK
