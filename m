Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9F085782CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 14:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiGRMwe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 08:52:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiGRMwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 08:52:33 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0444720F58;
        Mon, 18 Jul 2022 05:52:27 -0700 (PDT)
X-QQ-mid: bizesmtp78t1658148731tqqb4zg9
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 20:52:09 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: NGMqyHdgFPbaNTVeTs5zTJ7hcVIsbSD3IiF5EnK79Zzp6CUj7j821TpuyYjT1
        x3GOZ2LHdfRNbJc25haYA72wU75f6CM6hTqxCic16vHY5Cj7j2eOqNQZ3mw0NRziEWWxAW6
        kZk0DVDcPNRYWksqTYqdvi5Rns5Z6trjP5KPfMX1ylAQAw8+moK6gfORMO4cbhzOLPQ0t35
        luO+vEGGVgQWCusWB3OiGtGKXUHzrNaZKtVhFxULUrocwzE8b39ndMc8MPXneBLqmOZ7lsm
        09GlVNSIqMpx6EdvvoC7tmbQdoIL2hqyCZ9C4HcwFahhPypX34X5vz0DYaJGkJTIzASkZnC
        B7xXwwyUK7KR5AGTWES8mQwnfAmTgvLgE6jDfUKPQ7nPNDs9pObR9KRnWEI/UCFuINnFhuW
        mcUbEsVS4BQ=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     davem@davemloft.net
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] crypto: Fix comment typo
Date:   Fri, 15 Jul 2022 12:50:07 +0800
Message-Id: <20220715045007.21447-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 301, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 crypto/twofish_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/twofish_common.c b/crypto/twofish_common.c
index d23fa531b91f..f921f30334f4 100644
--- a/crypto/twofish_common.c
+++ b/crypto/twofish_common.c
@@ -298,7 +298,7 @@ static const u32 mds[4][256] = {
  * multiplication is inefficient without hardware support.  To multiply
  * faster, I make use of the fact x is a generator for the nonzero elements,
  * so that every element p of GF(2)[x]/w(x) is either 0 or equal to (x)^n for
- * some n in 0..254.  Note that that caret is exponentiation in GF(2^8),
+ * some n in 0..254.  Note that caret is exponentiation in GF(2^8),
  * *not* polynomial notation.  So if I want to compute pq where p and q are
  * in GF(2^8), I can just say:
  *    1. if p=0 or q=0 then pq=0
-- 
2.35.1

