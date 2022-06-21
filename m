Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91579553226
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbiFUMfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348993AbiFUMfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:35:16 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC41429341
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:34:26 -0700 (PDT)
X-QQ-mid: bizesmtp87t1655814728twrmhll2
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 20:32:05 +0800 (CST)
X-QQ-SSF: 0100000000700050B000B00A0000000
X-QQ-FEAT: u/aLP58xgttcFcH84cJrtKeZnFFmCAGSRkXFlj1XFCMVlCSWiIxhfjjyEOE9w
        g8wmGFBuX/HhWMv8NHsvgkSjjqBS8dXw0mQeekp5CSuHHpKheYH7m5Uy73UZtpDUWfEOmhN
        DQBIiRM9HImUOOL+Eheq+2WzIT0qgWC5IlAULSu+gQw+R2eJxyPnygkBCBKM4uxlZb5G61R
        oAH2mMND1+kYx+a7mLmBkDn47zW8a3w9k6b1Gk4fkQ30VuB5dznw0K5Ll+LBTQBtc+QjlAy
        p+kTGnDzeGOwkFYsP9O071m47a3Pj1NTc91oh72NQZ7Gsl74X7dS3hARYRle+ctw4GPqRtH
        xGRdR66t/QId3nSApw=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     dimitri.sivanich@hpe.com
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] misc: sgi-gru: grukservices: drop unexpected word "the" in the comments
Date:   Tue, 21 Jun 2022 20:32:03 +0800
Message-Id: <20220621123203.118488-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word "the" in the comments that need to be dropped
file: drivers/misc/sgi-gru/grukservices.c
line: 39
 * reserved whenever the the kernel context for the blade is loaded. Note
changed to
 * reserved whenever the kernel context for the blade is loaded. Note

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/misc/sgi-gru/grukservices.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sgi-gru/grukservices.c b/drivers/misc/sgi-gru/grukservices.c
index 19dbdad8ad8a..fa1f5a632e7f 100644
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -36,7 +36,7 @@
  * kernel/user requirements.
  *
  * Blade percpu resources reserved for kernel use. These resources are
- * reserved whenever the the kernel context for the blade is loaded. Note
+ * reserved whenever the kernel context for the blade is loaded. Note
  * that the kernel context is not guaranteed to be always available. It is
  * loaded on demand & can be stolen by a user if the user demand exceeds the
  * kernel demand. The kernel can always reload the kernel context but
-- 
2.17.1

