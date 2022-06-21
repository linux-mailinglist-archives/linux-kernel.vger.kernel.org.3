Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3031552B15
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 08:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345411AbiFUGkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 02:40:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242106AbiFUGkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 02:40:05 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509A918B23;
        Mon, 20 Jun 2022 23:40:00 -0700 (PDT)
X-QQ-mid: bizesmtp64t1655793517tmrm8rur
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 14:38:26 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: HDjpALELSmHSkcqf/eUCTnznWl2xwjSNZKVZJ/yeu8A2thDJ7WFAVIIIf5HXV
        Sb+Teo0lPjW4DuGNPJQF1kfMoJPUH7j6SNA2aRXtb5bOMcMz6X2fXDEckxM3cr6HeC7Ft3q
        +D9jjC6MN79oWrpo65Hhqkiab1+1V+yi9++04Qs0Y2YRei7wZUjIxkyZU0ptGYJfw9370eq
        LJndK3hG7R8sKEuHfdSEAStuyCk+IH0LhCwseIiBiR4mnupXLJNZ1Rw+StrhpZ41eDiSbSJ
        +B2vVpqQgGbZQ0aw4mp51CUjy8UKraaeT5Ym/5WgamWIELEGwX4vy9GiKxtmH9jVjKhrJpM
        2wZneF6
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     deller@gmx.de
Cc:     James.Bottomley@HansenPartnership.com, keescook@chromium.org,
        jiangjian@cdjrlc.com, linux-parisc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: aligned '*' in comments
Date:   Tue, 21 Jun 2022 14:38:23 +0800
Message-Id: <20220621063823.22064-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam8
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider * alignment in comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 arch/parisc/math-emu/decode_exc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/parisc/math-emu/decode_exc.c b/arch/parisc/math-emu/decode_exc.c
index 494ca41df05d..d41ddb3430b5 100644
--- a/arch/parisc/math-emu/decode_exc.c
+++ b/arch/parisc/math-emu/decode_exc.c
@@ -102,7 +102,7 @@ decode_fpu(unsigned int Fpu_register[], unsigned int trap_counts[])
      * that happen.  Want to keep this overhead low, but still provide
      * some information to the customer.  All exits from this routine
      * need to restore Fpu_register[0]
-    */
+     */
 
     bflags=(Fpu_register[0] & 0xf8000000);
     Fpu_register[0] &= 0x07ffffff;
-- 
2.17.1

