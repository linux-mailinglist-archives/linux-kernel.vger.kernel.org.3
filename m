Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C257B5A853C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 20:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiHaSOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 14:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiHaSNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 14:13:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2855EDF663;
        Wed, 31 Aug 2022 11:12:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D454261C58;
        Wed, 31 Aug 2022 18:12:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F339DC43148;
        Wed, 31 Aug 2022 18:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661969532;
        bh=UfgC0TnAMojW9BPApDiZOMQioOSmMjDrtGha0d9H3ys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iNXjlPDmqlcjMfkbH4V1ViLpxZfHrJPigIg3k6fIjltq8cjc8e7llmkMXnfxBoR9O
         SN9KrjTBUr5eT/pddiY47XdFzSKZiYl/zYX+ufgxIAlYYiV44e1RN3MQnNRbBdrv7m
         ekM31Qm0OfIrtmZUdhDwo0FGp8V8V1JVQJS8jxOFscfw+cjhWvS6iVHI0S4Sce5Zt4
         eaA6NSmQ9FlhX99JquvC/ra6pJWRw2PYtt2PxKYSSjDL62knKgDErtNjJoFuNvWCiO
         Ft5NFJzyl/z5EEQRv+6KGPGhD0YsfFiNQoDQq1oaDrjQfoubImAbr87C6FXWq6H5sP
         CXIvanZmQOmbQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6A69C5C0A6B; Wed, 31 Aug 2022 11:12:11 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/25] rcu: Remove blank line from poll_state_synchronize_rcu() docbook header
Date:   Wed, 31 Aug 2022 11:11:55 -0700
Message-Id: <20220831181210.2695080-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
References: <20220831181207.GA2694717@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the blank line preceding the oldstate parameter to
the docbook header for the poll_state_synchronize_rcu() function and
marks uses of this parameter later in that header.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 89572385fd1aa..0a24ef4d6b823 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3662,11 +3662,10 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
 
 /**
  * poll_state_synchronize_rcu - Has the specified RCU grace period completed?
- *
  * @oldstate: value from get_state_synchronize_rcu() or start_poll_synchronize_rcu()
  *
  * If a full RCU grace period has elapsed since the earlier call from
- * which oldstate was obtained, return @true, otherwise return @false.
+ * which @oldstate was obtained, return @true, otherwise return @false.
  * If @false is returned, it is the caller's responsibility to invoke this
  * function later on until it does return @true.  Alternatively, the caller
  * can explicitly wait for a grace period, for example, by passing @oldstate
@@ -3675,7 +3674,7 @@ EXPORT_SYMBOL_GPL(start_poll_synchronize_rcu_full);
  * Yes, this function does not take counter wrap into account.
  * But counter wrap is harmless.  If the counter wraps, we have waited for
  * more than a billion grace periods (and way more on a 64-bit system!).
- * Those needing to keep oldstate values for very long time periods
+ * Those needing to keep old state values for very long time periods
  * (many hours even on 32-bit systems) should check them occasionally and
  * either refresh them or set a flag indicating that the grace period has
  * completed.  Alternatively, they can use get_completed_synchronize_rcu()
-- 
2.31.1.189.g2e36527f23

