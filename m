Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA9F854F4C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 12:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381367AbiFQKCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 06:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiFQKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 06:02:50 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C713CFD1C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 03:02:46 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Fri, 17 Jun
 2022 17:57:21 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.60]
Date:   Fri, 17 Jun 2022 17:57:21 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     sammy@sammy.net, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] m68k/sun3: use __func__ to get funcion's name in an output
 message
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <3461c09c.be8.1817118854e.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwAHEW8BUKxi1atBAA--.765W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAACmFEYxssuAACsA
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
biA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBhcmNoL202OGsvc3VuMy9tbXVfZW11LmMgfCA4
ICsrKystLS0tCiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2FyY2gvbTY4ay9zdW4zL21tdV9lbXUuYyBiL2FyY2gvbTY4ay9zdW4z
L21tdV9lbXUuYwppbmRleCA3ZWMyMDgxN2MwYzkuLjUxNDgwZjcwM2RjOCAxMDA2NDQKLS0tIGEv
YXJjaC9tNjhrL3N1bjMvbW11X2VtdS5jCisrKyBiL2FyY2gvbTY4ay9zdW4zL21tdV9lbXUuYwpA
QCAtMjExLDcgKzIxMSw3IEBAIHZvaWQgY2xlYXJfY29udGV4dCh1bnNpZ25lZCBsb25nIGNvbnRl
eHQpCiAKICAgICAgaWYoY29udGV4dCkgewogCSAgICAgaWYoIWN0eF9hbGxvY1tjb250ZXh0XSkK
LQkJICAgICBwYW5pYygiY2xlYXJfY29udGV4dDogY29udGV4dCBub3QgYWxsb2NhdGVkXG4iKTsK
KwkJICAgICBwYW5pYygiJXM6IGNvbnRleHQgbm90IGFsbG9jYXRlZFxuIiwgX19mdW5jX18pOwog
CiAJICAgICBjdHhfYWxsb2NbY29udGV4dF0tPmNvbnRleHQgPSBTVU4zX0lOVkFMSURfQ09OVEVY
VDsKIAkgICAgIGN0eF9hbGxvY1tjb250ZXh0XSA9IChzdHJ1Y3QgbW1fc3RydWN0ICopMDsKQEAg
LTI2MSw3ICsyNjEsNyBAQCB1bnNpZ25lZCBsb25nIGdldF9mcmVlX2NvbnRleHQoc3RydWN0IG1t
X3N0cnVjdCAqbW0pCiAJCX0KIAkJLy8gY2hlY2sgdG8gbWFrZSBzdXJlIG9uZSB3YXMgcmVhbGx5
IGZyZWUuLi4KIAkJaWYobmV3ID09IENPTlRFWFRTX05VTSkKLQkJCXBhbmljKCJnZXRfZnJlZV9j
b250ZXh0OiBmYWlsZWQgdG8gZmluZCBmcmVlIGNvbnRleHQiKTsKKwkJCXBhbmljKCIlczogZmFp
bGVkIHRvIGZpbmQgZnJlZSBjb250ZXh0IiwgX19mdW5jX18pOwogCX0KIAogCWN0eF9hbGxvY1tu
ZXddID0gbW07CkBAIC0zNjksNyArMzY5LDcgQEAgaW50IG1tdV9lbXVfaGFuZGxlX2ZhdWx0ICh1
bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgcmVhZF9mbGFnLCBpbnQga2VybmVsX2ZhdWx0KQogCX0K
IAogI2lmZGVmIERFQlVHX01NVV9FTVUKLQlwcl9pbmZvKCJtbXVfZW11X2hhbmRsZV9mYXVsdDog
dmFkZHI9JWx4IHR5cGU9JXMgY3JwPSVwXG4iLAorCXByX2luZm8oIiVzOiB2YWRkcj0lbHggdHlw
ZT0lcyBjcnA9JXBcbiIsIF9fZnVuY19fLAogCQl2YWRkciwgcmVhZF9mbGFnID8gInJlYWQiIDog
IndyaXRlIiwgY3JwKTsKICNlbmRpZgogCkBAIC0zNzcsNyArMzc3LDcgQEAgaW50IG1tdV9lbXVf
aGFuZGxlX2ZhdWx0ICh1bnNpZ25lZCBsb25nIHZhZGRyLCBpbnQgcmVhZF9mbGFnLCBpbnQga2Vy
bmVsX2ZhdWx0KQogCW9mZnNldCAgPSAodmFkZHIgPj4gU1VOM19QVEVfU0laRV9CSVRTKSAmIDB4
RjsKIAogI2lmZGVmIERFQlVHX01NVV9FTVUKLQlwcl9pbmZvKCJtbXVfZW11X2hhbmRsZV9mYXVs
dDogc2VnbWVudD0lbHggb2Zmc2V0PSVseFxuIiwgc2VnbWVudCwKKwlwcl9pbmZvKCIlczogc2Vn
bWVudD0lbHggb2Zmc2V0PSVseFxuIiwgX19mdW5jX18sIHNlZ21lbnQsCiAJCW9mZnNldCk7CiAj
ZW5kaWYKIAotLSAKMi4zNi4xCgoKCg==
