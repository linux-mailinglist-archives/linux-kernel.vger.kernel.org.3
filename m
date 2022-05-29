Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24019537186
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiE2PbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 11:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiE2PbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 11:31:01 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB9F83FBC4
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 08:31:00 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sun, 29 May
 2022 23:25:54 +0800 (GMT+08:00)
X-Originating-IP: [182.148.15.20]
Date:   Sun, 29 May 2022 23:25:54 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     dinguyen@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] nios2: clean up warnings found by checkpatch
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3132c1c.a93.181106c7d36.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3AG+CkJNisyc6AA--.685W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQABCmFEYxsmmAACsr
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CkNsZWFuIHVwIGEgaGFuZGZ1bCBvZiBjaGVja3BhdGNoIHdhcm5pbmdzOgotIFdBUk5JTkc6IFBy
ZWZlciAndW5zaWduZWQgbG9uZycgb3ZlciAndW5zaWduZWQgbG9uZyBpbnQnCiAgYXMgdGhlIGlu
dCBpcyB1bm5lY2Vzc2FyeQotIFdBUk5JTkc6IFByZWZlciAnbG9uZycgb3ZlciAnbG9uZyBpbnQn
IGFzIHRoZSBpbnQgaXMgdW5uZWNlc3NhcnkKLSBXQVJOSU5HOiBQcmVmZXIgJ3Vuc2lnbmVkIGlu
dCcgdG8gYmFyZSB1c2Ugb2YgJ3Vuc2lnbmVkJwoKU2lnbmVkLW9mZi1ieTogWHVlQmluZyBDaGVu
IDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGFyY2gvbmlvczIvbGliL21lbWNweS5jIHwgMTYg
KysrKysrKystLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgOCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL25pb3MyL2xpYi9tZW1jcHkuYyBiL2FyY2gvbmlv
czIvbGliL21lbWNweS5jCmluZGV4IDE3MTVmNWQyOGIxMS4uMjVhNTQxYjYwOWJhIDEwMDY0NAot
LS0gYS9hcmNoL25pb3MyL2xpYi9tZW1jcHkuYworKysgYi9hcmNoL25pb3MyL2xpYi9tZW1jcHku
YwpAQCAtMjIsNyArMjIsNyBAQAogLyogVHlwZSB0byB1c2UgZm9yIGFsaWduZWQgbWVtb3J5IG9w
ZXJhdGlvbnMuCiAgICBUaGlzIHNob3VsZCBub3JtYWxseSBiZSB0aGUgYmlnZ2VzdCB0eXBlIHN1
cHBvcnRlZCBieSBhIHNpbmdsZSBsb2FkCiAgICBhbmQgc3RvcmUuICAqLwotI2RlZmluZQlvcF90
CXVuc2lnbmVkIGxvbmcgaW50CisjZGVmaW5lCW9wX3QJdW5zaWduZWQgbG9uZwogI2RlZmluZSBP
UFNJWgkoc2l6ZW9mKG9wX3QpKQogCiAvKiBPcHRpbWFsIHR5cGUgZm9yIHN0b3JpbmcgYnl0ZXMg
aW4gcmVnaXN0ZXJzLiAgKi8KQEAgLTY5LDcgKzY5LDcgQEAgZG8gewkJCQkJCQkJCVwKICAgIGJs
b2NrIGJlZ2lubmluZyBhdCBEU1RQIHdpdGggTEVOIGBvcF90JyB3b3JkcyAobm90IExFTiBieXRl
cyEpLgogICAgQm90aCBTUkNQIGFuZCBEU1RQIHNob3VsZCBiZSBhbGlnbmVkIGZvciBtZW1vcnkg
b3BlcmF0aW9ucyBvbiBgb3BfdCdzLiAgKi8KIC8qIHN0cmVhbS1saW5lZCAocmVhZCB4OCArIHdy
aXRlIHg4KSAqLwotc3RhdGljIHZvaWQgX3dvcmRjb3B5X2Z3ZF9hbGlnbmVkKGxvbmcgaW50IGRz
dHAsIGxvbmcgaW50IHNyY3AsIHNpemVfdCBsZW4pCitzdGF0aWMgdm9pZCBfd29yZGNvcHlfZndk
X2FsaWduZWQobG9uZyBkc3RwLCBsb25nIHNyY3AsIHNpemVfdCBsZW4pCiB7CiAJd2hpbGUgKGxl
biA+IDcpIHsKIAkJcmVnaXN0ZXIgb3BfdCBhMCwgYTEsIGEyLCBhMywgYTQsIGE1LCBhNiwgYTc7
CkBAIC0xMDksNyArMTA5LDcgQEAgc3RhdGljIHZvaWQgX3dvcmRjb3B5X2Z3ZF9hbGlnbmVkKGxv
bmcgaW50IGRzdHAsIGxvbmcgaW50IHNyY3AsIHNpemVfdCBsZW4pCiAgICBEU1RQIHNob3VsZCBi
ZSBhbGlnbmVkIGZvciBtZW1vcnkgb3BlcmF0aW9ucyBvbiBgb3BfdCdzLCBidXQgU1JDUCBtdXN0
CiAgICAqbm90KiBiZSBhbGlnbmVkLiAgKi8KIC8qIHN0cmVhbS1saW5lZCAocmVhZCB4NCArIHdy
aXRlIHg0KSAqLwotc3RhdGljIHZvaWQgX3dvcmRjb3B5X2Z3ZF9kZXN0X2FsaWduZWQobG9uZyBp
bnQgZHN0cCwgbG9uZyBpbnQgc3JjcCwKK3N0YXRpYyB2b2lkIF93b3JkY29weV9md2RfZGVzdF9h
bGlnbmVkKGxvbmcgZHN0cCwgbG9uZyBzcmNwLAogCQkJCQlzaXplX3QgbGVuKQogewogCW9wX3Qg
YXA7CkBAIC0xNTksOCArMTU5LDggQEAgc3RhdGljIHZvaWQgX3dvcmRjb3B5X2Z3ZF9kZXN0X2Fs
aWduZWQobG9uZyBpbnQgZHN0cCwgbG9uZyBpbnQgc3JjcCwKIAogdm9pZCAqbWVtY3B5KHZvaWQg
KmRzdHBwLCBjb25zdCB2b2lkICpzcmNwcCwgc2l6ZV90IGxlbikKIHsKLQl1bnNpZ25lZCBsb25n
IGludCBkc3RwID0gKGxvbmcgaW50KSBkc3RwcDsKLQl1bnNpZ25lZCBsb25nIGludCBzcmNwID0g
KGxvbmcgaW50KSBzcmNwcDsKKwl1bnNpZ25lZCBsb25nIGRzdHAgPSAobG9uZykgZHN0cHA7CisJ
dW5zaWduZWQgbG9uZyBzcmNwID0gKGxvbmcpIHNyY3BwOwogCiAJLyogQ29weSBmcm9tIHRoZSBi
ZWdpbm5pbmcgdG8gdGhlIGVuZC4gICovCiAKQEAgLTE5MSwxMCArMTkxLDEwIEBAIHZvaWQgKm1l
bWNweSh2b2lkICpkc3RwcCwgY29uc3Qgdm9pZCAqc3JjcHAsIHNpemVfdCBsZW4pCiAJcmV0dXJu
IGRzdHBwOwogfQogCi12b2lkICptZW1jcHliKHZvaWQgKmRzdHBwLCBjb25zdCB2b2lkICpzcmNw
cCwgdW5zaWduZWQgbGVuKQordm9pZCAqbWVtY3B5Yih2b2lkICpkc3RwcCwgY29uc3Qgdm9pZCAq
c3JjcHAsIHVuc2lnbmVkIGludCBsZW4pCiB7Ci0JdW5zaWduZWQgbG9uZyBpbnQgZHN0cCA9IChs
b25nIGludCkgZHN0cHA7Ci0JdW5zaWduZWQgbG9uZyBpbnQgc3JjcCA9IChsb25nIGludCkgc3Jj
cHA7CisJdW5zaWduZWQgbG9uZyBkc3RwID0gKGxvbmcpIGRzdHBwOworCXVuc2lnbmVkIGxvbmcg
c3JjcCA9IChsb25nKSBzcmNwcDsKIAogCUJZVEVfQ09QWV9GV0QoZHN0cCwgc3JjcCwgbGVuKTsK
IAotLSAKMi4zNi4xCg==
