Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934575AFFAF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbiIGIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 04:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbiIGIye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 04:54:34 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B8AF48F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 01:54:17 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b144so9160959pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 01:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=U5qUfa4Lgm6hhBC3Ke1utiFg4URrAIPI6E9fvOAWsXI=;
        b=MQ7NMUEslV3VIUJ66hoDMHQfDuJkUnpJAen7HiFiuTbputRUKwX5L1Fr3edDOGbpEI
         cxVcIECleckQZrSfvSXBeNKt3h8k99H66GK7CKXor2fgzeN7/YBWqbkIt3V2UsBGiayD
         e3D1vJTCbJwbANC1J7MU7n9bYxymCraeGsH531e0C5gNjSJHEAz7cuulbQUD7IL/Xt7w
         cAl/vX8uQZGDXRnUQ/bFYLhBCFc85/OCjUfGU0PI6pTSHmoQK4N0VD1nBfkprneose3Q
         OzapL9pGLhrmzMNWJTzM3iS9nyltjmVg+woULdMCa39YNBcI7bfq+WUmcckJpEtK3bKb
         y7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=U5qUfa4Lgm6hhBC3Ke1utiFg4URrAIPI6E9fvOAWsXI=;
        b=DhFmnhqLZh5pVm3+Jo0l6wzMjhvxmwkZtmD01FE4AAiKvQpEbF9kiP2THUz7Xuc6ep
         h8LR/uCus2ckyLBikxLNrZ70Nf0/61VVmy2UT56/BlgwzGtfChwvg6OshNyDQH7h2eva
         fCV3XBuJR7nnSy17Zy/4gTWtn1y0L6wBHPMVxMDVem8lz1a9rOnME/zSsL2UWYpdIo5k
         L3bnzPXa8xYn3BOs6Ds1dZlFgNWFOKECN/c3P4rsBlbEl4VFd7ibiTQXZzTxMwHJPdhy
         J06tL11d3KoWiljbXyUlwiSLVDTVJ/CN0uiiMLunWVSIQPuVkPM4k/9ZXX+rv+uVvVMk
         uYAA==
X-Gm-Message-State: ACgBeo0s0X1FooXrLhf/pAJHVsPOV03j02GYN6heDOgzpbUbUHs9cOVZ
        McXgQ+HFKqllJKMyG/KZoL3RWEoeCoBxpA==
X-Google-Smtp-Source: AA6agR5M11WYJL19TlZ6W51AfRZ+JLgFXH5YZxaS5byi54LlBPFRpOa3rzFRzPc2d3Y4LNg59x6HnQ==
X-Received: by 2002:a05:6a00:15ce:b0:537:24ee:cbcf with SMTP id o14-20020a056a0015ce00b0053724eecbcfmr2651312pfu.30.1662540856481;
        Wed, 07 Sep 2022 01:54:16 -0700 (PDT)
Received: from localhost.localdomain (lily-optiplex-3070.dynamic.ucsd.edu. [2607:f720:1300:3033::1:4dd])
        by smtp.googlemail.com with ESMTPSA id k5-20020a63d845000000b0042a713dd68csm10106384pgj.53.2022.09.07.01.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 01:54:16 -0700 (PDT)
From:   Li Zhong <floridsleeves@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com,
        rostedt@goodmis.org, ardb@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, Li Zhong <floridsleeves@gmail.com>
Subject: [PATCH v2] arch/x86/kernel: check the return value of insn_decode_kernel()
Date:   Wed,  7 Sep 2022 01:54:05 -0700
Message-Id: <20220907085405.2317461-1-floridsleeves@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

insn_decode() could fail and the insn.length could be invalid. So we
need to check the return value first.

Signed-off-by: Li Zhong <floridsleeves@gmail.com>
---
 arch/x86/kernel/jump_label.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/jump_label.c b/arch/x86/kernel/jump_label.c
index f5b8ef02d172..59385700f579 100644
--- a/arch/x86/kernel/jump_label.c
+++ b/arch/x86/kernel/jump_label.c
@@ -20,9 +20,10 @@
 int arch_jump_entry_size(struct jump_entry *entry)
 {
 	struct insn insn = {};
+	int ret;
 
-	insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
-	BUG_ON(insn.length != 2 && insn.length != 5);
+	ret = insn_decode_kernel(&insn, (void *)jump_entry_code(entry));
+	BUG_ON(ret < 0 || (insn.length != 2 && insn.length != 5));
 
 	return insn.length;
 }
-- 
2.25.1

