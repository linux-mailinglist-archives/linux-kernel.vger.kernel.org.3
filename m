Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79C64E48C7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbiCVWDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:03:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiCVWDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:03:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BA9DF39
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:02:11 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id l8so19367029pfu.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=subject:date:message-id:mime-version:content-transfer-encoding:cc
         :from:to;
        bh=VBuD14D9jss6ixku9sfUZCOqSJnBe9a9BQaCUrE6LQQ=;
        b=fJanGXUXVx10X/Hm8J+xyICVn7kqq20SrCD9VC2HonNhM5J96ddWdrsnDr9l4C5SCp
         BixK8QDMURjn/re5FJYUWaGa6OFVJj9D09ML74yyt91zxTtXapvjcqgXOeac8bhYj37v
         FZw7oRQPSDEus3fHFeHmWWqibnBUawlUTx/zEuRBII3qxBJ0eDRxDZ0CgRrxg4yhpiKP
         CymunO5wgk+eqjp19SjkOTUT/uzdDtFH326xKSvUG3dz2XFzxEQi6YhA8QTdFCopPYAQ
         N5TKjEm+Ea6zxwUG9EVLlypVshR5xWi6iQfNUYM8YzhUMvyT2woYYCF8asiKAsdwlECR
         xpYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:date:message-id:mime-version
         :content-transfer-encoding:cc:from:to;
        bh=VBuD14D9jss6ixku9sfUZCOqSJnBe9a9BQaCUrE6LQQ=;
        b=dXQ1tm1ZBunZrE21v4gRPzY0qY2c4oLl4Vmu8VCzWXU1bSrrNuTS8L++kiLAHtU1MO
         7T7f83fUcOKxxiLaOtpRsBAfPi8Mj8qEnuMnOiY1vgu6jpp2P4nAzcMgtLFLTq814w1/
         +M1iVZuFpbX3W6mUBxRVoxj3+6TBi/Awy2So4KpmDYcOMaH+UdJt2rQXEuBQLaNjjiqB
         enk5qxRwGHrNipfkG5IwFDVNVKCzU5845pravfuH2xxM4tV247z90l8EpVOSg9IVZ4VL
         gCJts/Hsaaq+wSR1RnQ+M9Oz3UW3jS8cvZWgkYQzS9PPvmXu2IjD+zYci10J25QZW3cL
         SmVw==
X-Gm-Message-State: AOAM530QFHFud/S1vrlIWNQ/YzHuPzubS50b6JZuLXi0pihjU1an3Moo
        2ok5asvDInuqFZX3hW+sG/mP6w==
X-Google-Smtp-Source: ABdhPJx1LeSLhNrfW7PIt93i5dhi5I1vv8HguPlKaZ8N+dB0Bhq3Yn9TyDdhCJPMmQ6dEeEEbFooAA==
X-Received: by 2002:a05:6a00:3309:b0:4fa:950b:d011 with SMTP id cq9-20020a056a00330900b004fa950bd011mr14139644pfb.24.1647986530494;
        Tue, 22 Mar 2022 15:02:10 -0700 (PDT)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id q20-20020a056a00151400b004fa99ba6654sm10332924pfu.115.2022.03.22.15.02.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Mar 2022 15:02:10 -0700 (PDT)
Subject: [PATCH] perf: RISC-V: Remove non-kernel-doc ** comments
Date:   Tue, 22 Mar 2022 15:01:47 -0700
Message-Id: <20220322220147.11407-1-palmer@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Cc:     atishp@atishpatra.org, anup@brainfault.org,
        Will Deacon <will@kernel.org>, mark.rutland@arm.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmer@rivosinc.com>,
        kernel test robot <lkp@intel.com>
From:   Palmer Dabbelt <palmer@rivosinc.com>
To:         linux-riscv@lists.infradead.org,
            Atish Patra <atishp@rivosinc.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Palmer Dabbelt <palmer@rivosinc.com>

This will presumably trip up some tools that try to parse the comments
as kernel doc when they're not.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 4905ec2fb7e6 ("RISC-V: Add sscofpmf extension support")
Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

--

These recently landed in for-next, but I'm trying to avoid rewriting
history as there's a lot in flight right now.
---
 drivers/perf/riscv_pmu_sbi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index a1317a483512..dca3537a8dcc 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -35,7 +35,7 @@ union sbi_pmu_ctr_info {
 	};
 };
 
-/**
+/*
  * RISC-V doesn't have hetergenous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
  */
@@ -477,7 +477,7 @@ static int pmu_sbi_get_ctrinfo(int nctr)
 
 static inline void pmu_sbi_stop_all(struct riscv_pmu *pmu)
 {
-	/**
+	/*
 	 * No need to check the error because we are disabling all the counters
 	 * which may include counters that are not enabled yet.
 	 */
@@ -494,7 +494,7 @@ static inline void pmu_sbi_stop_hw_ctrs(struct riscv_pmu *pmu)
 		  cpu_hw_evt->used_hw_ctrs[0], 0, 0, 0, 0);
 }
 
-/**
+/*
  * This function starts all the used counters in two step approach.
  * Any counter that did not overflow can be start in a single step
  * while the overflowed counters need to be started with updated initialization
@@ -563,7 +563,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	/* Overflow status register should only be read after counter are stopped */
 	overflow = csr_read(CSR_SSCOUNTOVF);
 
-	/**
+	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
 	 * all the counters to avoid any race condition.
 	 */
-- 
2.34.1

