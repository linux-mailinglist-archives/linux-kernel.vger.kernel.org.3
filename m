Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA4354FAAC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 17:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382960AbiFQP4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 11:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234143AbiFQPz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:55:59 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9D8421273
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 08:55:56 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Fri, 17 Jun
 2022 23:50:19 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.60]
Date:   Fri, 17 Jun 2022 23:50:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org,
        seanjc@google.com, clg@kaod.org, aik@ozlabs.ru
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] KVM: PPC: use __func__ to get funcion's name in an output
 message
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <13b2c857.beb.181725bad35.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3AG+8oqxiEL9BAA--.788W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAACmFEYxssuAAGsE
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

ClByZWZlciB1c2luZyAnIiVzLi4uIiwgX19mdW5jX18nIHRvIGdldCBjdXJyZW50IGZ1bmN0aW9u
J3MgbmFtZSBpbgphbiBvdXRwdXQgbWVzc2FnZS4KClNpZ25lZC1vZmYtYnk6IFh1ZUJpbmcgQ2hl
biA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBhcmNoL3Bvd2VycGMva3ZtL2Jvb2szc182NF9t
bXVfaHYuYyB8IDcgKysrLS0tLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc182NF9tbXVf
aHYuYyBiL2FyY2gvcG93ZXJwYy9rdm0vYm9vazNzXzY0X21tdV9odi5jCmluZGV4IDBhZWI1MTcz
OGNhOS4uZTc5NWVkM2QxMzQ2IDEwMDY0NAotLS0gYS9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc182
NF9tbXVfaHYuYworKysgYi9hcmNoL3Bvd2VycGMva3ZtL2Jvb2szc182NF9tbXVfaHYuYwpAQCAt
MTE5NCw3ICsxMTk0LDcgQEAgc3RhdGljIGludCByZXNpemVfaHB0X2FsbG9jYXRlKHN0cnVjdCBr
dm1fcmVzaXplX2hwdCAqcmVzaXplKQogCWlmIChyYyA8IDApCiAJCXJldHVybiByYzsKIAotCXJl
c2l6ZV9ocHRfZGVidWcocmVzaXplLCAicmVzaXplX2hwdF9hbGxvY2F0ZSgpOiBIUFQgQCAweCVs
eFxuIiwKKwlyZXNpemVfaHB0X2RlYnVnKHJlc2l6ZSwgIiVzKCk6IEhQVCBAIDB4JWx4XG4iLCBf
X2Z1bmNfXywKIAkJCSByZXNpemUtPmhwdC52aXJ0KTsKIAogCXJldHVybiAwOwpAQCAtMTQzNSw3
ICsxNDM1LDcgQEAgc3RhdGljIHZvaWQgcmVzaXplX2hwdF9wcmVwYXJlX3dvcmsoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQogCQkgKi8KIAkJbXV0ZXhfdW5sb2NrKCZrdm0tPmFyY2gubW11X3Nl
dHVwX2xvY2spOwogCi0JCXJlc2l6ZV9ocHRfZGVidWcocmVzaXplLCAicmVzaXplX2hwdF9wcmVw
YXJlX3dvcmsoKTogb3JkZXIgPSAlZFxuIiwKKwkJcmVzaXplX2hwdF9kZWJ1ZyhyZXNpemUsICIl
cygpOiBvcmRlciA9ICVkXG4iLCBfX2Z1bmNfXywKIAkJCQkgcmVzaXplLT5vcmRlcik7CiAKIAkJ
ZXJyID0gcmVzaXplX2hwdF9hbGxvY2F0ZShyZXNpemUpOwpAQCAtMTg3OSw4ICsxODc5LDcgQEAg
c3RhdGljIHNzaXplX3Qga3ZtX2h0YWJfd3JpdGUoc3RydWN0IGZpbGUgKmZpbGUsIGNvbnN0IGNo
YXIgX191c2VyICpidWYsCiAJCQlyZXQgPSBrdm1wcGNfdmlydG1vZGVfZG9faF9lbnRlcihrdm0s
IEhfRVhBQ1QsIGksIHYsIHIsCiAJCQkJCQkJIHRtcCk7CiAJCQlpZiAocmV0ICE9IEhfU1VDQ0VT
UykgewotCQkJCXByX2Vycigia3ZtX2h0YWJfd3JpdGUgcmV0ICVsZCBpPSVsZCB2PSVseCAiCi0J
CQkJICAgICAgICJyPSVseFxuIiwgcmV0LCBpLCB2LCByKTsKKwkJCQlwcl9lcnIoIiVzIHJldCAl
bGQgaT0lbGQgdj0lbHggcj0lbHhcbiIsIF9fZnVuY19fLCByZXQsIGksIHYsIHIpOwogCQkJCWdv
dG8gb3V0OwogCQkJfQogCQkJaWYgKCFtbXVfcmVhZHkgJiYgaXNfdnJtYV9ocHRlKHYpKSB7Ci0t
IAoyLjM2LjEK
