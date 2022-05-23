Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0C205309E5
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 09:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiEWHTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiEWHTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:19:42 -0400
X-Greylist: delayed 1778 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 May 2022 00:11:16 PDT
Received: from jari.cn (unknown [218.92.28.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F7D52EA15;
        Mon, 23 May 2022 00:11:15 -0700 (PDT)
Received: by ajax-webmail-localhost.localdomain (Coremail) ; Mon, 23 May
 2022 14:29:38 +0800 (GMT+08:00)
X-Originating-IP: [182.148.13.40]
Date:   Mon, 23 May 2022 14:29:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   =?UTF-8?B?6ZmI5a2m5YW1?= <chenxuebing@jari.cn>
To:     jejb@linux.ibm.com
Cc:     martin.petersen@oracle.com, manoj@linux.ibm.com,
        mrochs@linux.ibm.com, ukrishn@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: cxlflash:Fix syntax errors in comments
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT6.0.1 build 20210329(c53f3fee)
 Copyright (c) 2002-2022 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <a9fe3b4.9f7.180ef9b5e98.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwAXIW_SKYti2y03AA--.619W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAOCmFEYxsksAADsP
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

RGVsZXRlIHRoZSByZWR1bmRhbnQgd29yZCAnZmxhZ3MnCgpTaWduZWQtb2ZmLWJ5OiBDaGVueHVl
YmluZyA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL3Njc2kvY3hsZmxhc2gvc2lz
bGl0ZS5oIHwgMiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9u
KC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3NpL2N4bGZsYXNoL3Npc2xpdGUuaCBiL2RyaXZl
cnMvc2NzaS9jeGxmbGFzaC9zaXNsaXRlLmgKaW5kZXggYWIzMTVjNTk1MDViLi5kNGNmZDQ2YjYy
MTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9jeGxmbGFzaC9zaXNsaXRlLmgKKysrIGIvZHJp
dmVycy9zY3NpL2N4bGZsYXNoL3Npc2xpdGUuaApAQCAtNTMxLDcgKzUzMSw3IEBAIHN0cnVjdCBz
aXNsX3JodF9lbnRyeV9mMSB7CiAjZGVmaW5lIFNJU0xfUkhUX0ZQKGZtdCwgcGVybSkgKCgoZm10
KSA8PCA0KSB8IChwZXJtKSkKIAogLyogbWFrZSB0aGUgZnAgYnl0ZSBmb3IgYSBjbG9uZSBmcm9t
IGEgc291cmNlIGZwIGFuZCBjbG9uZSBmbGFncwotICogZmxhZ3MgbXVzdCBiZSBvbmx5IDIgTFNC
IGJpdHMuCisgKiBtdXN0IGJlIG9ubHkgMiBMU0IgYml0cy4KICAqLwogI2RlZmluZSBTSVNMX1JI
VF9GUF9DTE9ORShzcmNfZnAsIGNsbl9mbGFncykgKChzcmNfZnApICYgKDB4RkMgfCAoY2xuX2Zs
YWdzKSkpCiAKLS0gCjIuMzYuMQo=
