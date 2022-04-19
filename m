Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86C6506151
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 03:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243750AbiDSAuD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241160AbiDSApS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C5042AC79
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 17:42:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B964561440
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 00:42:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998E6C341D3;
        Tue, 19 Apr 2022 00:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650328948;
        bh=VCheLsDbUv9AaqHGhZiKBpac43Rz0zXEHf/ilfBdNqU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e4hJT24yZw9wE4FxsSykCMJV7wUXRdIOwpWdohcQKDOOk8F845ggDwWY91oisDJwy
         t6zlfpMbRwZVBHp1lWeDp+FzlnMlZ6puB/91l0QLqwMBuUah0UhK1xsP07yGpJiF50
         eSJzHFctje+8vrzWHerXW86C9T6vZE4I/l1xnCkRf/T0vrAu4SJ8sC+O4+G2L6Icn8
         paXtouvzlXeYhUd0ZHrsgkd9eGlhvY88oQEMEoGPstSv5oz04DOFQwvMtiwFLPGejv
         U7sKh4oC6njrJ7nnV4xyWgO5LU2DgHtngbaK/XXCOuBSyBn4mtUWHt+MnJ+z9kVd7c
         TqNlHJtConTbw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 67BAA5C323F; Mon, 18 Apr 2022 17:42:27 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@fb.com, w@lwt.eu,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 53/61] tools/nolibc: x86-64: Update System V ABI document link
Date:   Mon, 18 Apr 2022 17:42:17 -0700
Message-Id: <20220419004225.3952530-53-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
References: <20220419004219.GA3952301@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ammar Faizi <ammarfaizi2@gnuweeb.org>

The old link no longer works, update it.

Acked-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-x86_64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/arch-x86_64.h b/tools/include/nolibc/arch-x86_64.h
index fe517c16cd4d..a7b70ea51b68 100644
--- a/tools/include/nolibc/arch-x86_64.h
+++ b/tools/include/nolibc/arch-x86_64.h
@@ -61,7 +61,7 @@ struct sys_stat_struct {
  *   - see also x86-64 ABI section A.2 AMD64 Linux Kernel Conventions, A.2.1
  *     Calling Conventions.
  *
- * Link x86-64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/x86-64-psABI
+ * Link x86-64 ABI: https://gitlab.com/x86-psABIs/x86-64-ABI/-/wikis/home
  *
  */
 
-- 
2.31.1.189.g2e36527f23

