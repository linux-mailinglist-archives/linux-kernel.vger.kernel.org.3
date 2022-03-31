Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E764ED636
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 10:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbiCaIwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 04:52:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233293AbiCaIvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 04:51:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E8B13DA41
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 01:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ACDBFB82003
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 08:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2635BC340EE;
        Thu, 31 Mar 2022 08:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648716593;
        bh=Go6bo2O/o5mG79CQFHS7po2/ozyrPmkNdOWGq8t4XBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=camqJMKk2RLO8LNiWsFkfH/vm8rVMiFD6jA41IigOQw6kTTMtiiyaOTv9Ho4zkJHM
         8dV1xUJTelWjQYzVReVbw7T4LSDCgZOAgtMeR7zDWkTBAmCDkHjflXu0s/quWnA8Hl
         GUvdxrXwf18OobcetEIX9fTOPcc2vcqfJbOF7PRdFWhwG3xaVB9LTvFtq6iIYcuc5x
         FyprBE/L3s2A3+O/nsrMqU9iir1f/mndgRSNIBEeL2dyLjmzDf7PSqO7zHJZHpDutY
         hAWwkFW2bhmh9Tosr2ehXJou+vSxe7yr+obn6qXem2jrDK9yI0TCmUVDqpg6tf6/L1
         Gnhb+gJAtk6fw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     andreyknvl@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for-mm 1/3] arch/arm64/Kconfig: Fix a typo
Date:   Thu, 31 Mar 2022 08:49:37 +0000
Message-Id: <20220331084939.26749-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220331084939.26749-1-sj@kernel.org>
References: <20220331084939.26749-1-sj@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in 'linux-next-rejects.patch' of linux-mm patches, which
causes build warning below:

    arch/arm64/Kconfig:199:warning: ignoring unsupported character '+'

This commit fixes it.

Fixes: d93aa6fbfc68 ("linux-next-rejects") of -mm
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 arch/arm64/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index b53bb0bfbde8..d9325dd95eba 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -196,7 +196,7 @@ config ARM64
 	select HAVE_PERF_USER_STACK_DUMP
 	select HAVE_PREEMPT_DYNAMIC_KEY
 	select HAVE_REGS_AND_STACK_ACCESS_API
-+	select HAVE_RUST
+	select HAVE_RUST
 	select HAVE_POSIX_CPU_TIMERS_TASK_WORK
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select MMU_GATHER_RCU_TABLE_FREE
-- 
2.17.1

