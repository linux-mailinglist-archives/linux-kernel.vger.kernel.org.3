Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB83955A84A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiFYI46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiFYI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:56:57 -0400
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A757C3F8A2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:56:56 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Sat, 25 Jun
 2022 16:51:35 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.206]
Date:   Sat, 25 Jun 2022 16:51:35 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject:  [PATCH] mm: sparsemem: drop unexpected word 'a' in comments
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <24fbdae3.c86.1819a0f31b9.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwA3QW+YzLZi2TVEAA--.778W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAICmFEYxsvNQAIsM
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

CnRoZXJlIGlzIGFuIHVuZXhwZWN0ZWQgd29yZCAnYScgaW4gdGhlIGNvbW1lbnRzIHRoYXQgbmVl
ZCB0byBiZSBkcm9wcGVkCgpTaWduZWQtb2ZmLWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWViaW5n
QGphcmkuY24+Ci0tLQogbW0vc3BhcnNlLXZtZW1tYXAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2Vk
LCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL21tL3NwYXJzZS12
bWVtbWFwLmMgYi9tbS9zcGFyc2Utdm1lbW1hcC5jCmluZGV4IDhlZDE5MzI0OWU4NC4uMzNjNTA4
ZWM1ODQ2IDEwMDY0NAotLS0gYS9tbS9zcGFyc2Utdm1lbW1hcC5jCisrKyBiL21tL3NwYXJzZS12
bWVtbWFwLmMKQEAgLTU0OCw3ICs1NDgsNyBAQCBwdGVfdCAqIF9fbWVtaW5pdCB2bWVtbWFwX3B0
ZV9wb3B1bGF0ZShwbWRfdCAqcG1kLCB1bnNpZ25lZCBsb25nIGFkZHIsIGludCBub2RlLAogCQl9
IGVsc2UgewogCQkJLyoKIAkJCSAqIFdoZW4gYSBQVEUvUE1EIGVudHJ5IGlzIGZyZWVkIGZyb20g
dGhlIGluaXRfbW0KLQkJCSAqIHRoZXJlJ3MgYSBhIGZyZWVfcGFnZXMoKSBjYWxsIHRvIHRoaXMg
cGFnZSBhbGxvY2F0ZWQKKwkJCSAqIHRoZXJlJ3MgYSBmcmVlX3BhZ2VzKCkgY2FsbCB0byB0aGlz
IHBhZ2UgYWxsb2NhdGVkCiAJCQkgKiBhYm92ZS4gVGh1cyB0aGlzIGdldF9wYWdlKCkgaXMgcGFp
cmVkIHdpdGggdGhlCiAJCQkgKiBwdXRfcGFnZV90ZXN0emVybygpIG9uIHRoZSBmcmVlaW5nIHBh
dGguCiAJCQkgKiBUaGlzIGNhbiBvbmx5IGNhbGxlZCBieSBjZXJ0YWluIFpPTkVfREVWSUNFIHBh
dGgsCi0tIAoyLjE3LjEK
