Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DBC552C69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347669AbiFUHyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345332AbiFUHyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:54:37 -0400
Received: from smtpbg.qq.com (smtpbg123.qq.com [175.27.65.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2081F240B4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:54:28 -0700 (PDT)
X-QQ-mid: bizesmtp86t1655798054tf9gvo1j
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 15:54:05 +0800 (CST)
X-QQ-SSF: 01000000007000109000B00A0000000
X-QQ-FEAT: ZA+dlOho4nsaQV4YZdXLYVPh0safDqYp4DLARGcdlGQ77BbfgLWz7Lp8cXSIh
        xfXnCmiFrqftNjrFigh7SZvHYx1Wz4HyMSoYOX+jvAjINLOrKcR8la9Psxov+jT3c+sLNpu
        JoEVKI/VZ0fwll8DUAhlMi4JggvM6p/jaqTG7gNp7HjB5urmBMfud2CeXNSy+JmseBGpITK
        9CqoP+R0KAf+9f+INisWiYDP9lX91AyeGlm9jygRZ9AhAZq0/pAb4Opk/23ZjiHL0kdhXzc
        a4OPCPXcoGT6jdoa2GIQVXKDyKKUNk2DxrJPVvhzSmuBaBwTRGvfPvI05IPrikrC6oPnvH4
        kQNVQ+9uKA+m5iBJz8=
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     arnd@arndb.de, palmer@rivosinc.com, guoren@kernel.org
Cc:     jiangjian@cdjrlc.com, linux-kernel@vger.kernel.org
Subject: [PATCH] uapi: remove unexpected word "the"
Date:   Tue, 21 Jun 2022 15:54:02 +0800
Message-Id: <20220621075402.37678-1-jiangjian@cdjrlc.com>
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

Remove unexpected word "the" in comments

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 tools/include/uapi/asm-generic/fcntl.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/uapi/asm-generic/fcntl.h b/tools/include/uapi/asm-generic/fcntl.h
index 0197042b7dfb..826afd9192d8 100644
--- a/tools/include/uapi/asm-generic/fcntl.h
+++ b/tools/include/uapi/asm-generic/fcntl.h
@@ -140,7 +140,7 @@
  * record  locks, but are "owned" by the open file description, not the
  * process. This means that they are inherited across fork() like BSD (flock)
  * locks, and they are only released automatically when the last reference to
- * the the open file against which they were acquired is put.
+ * the open file against which they were acquired is put.
  */
 #define F_OFD_GETLK	36
 #define F_OFD_SETLK	37
-- 
2.17.1

