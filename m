Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9995152318D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 13:28:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237540AbiEKL1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243060AbiEKL0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 07:26:30 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18CE61CFC8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 04:26:26 -0700 (PDT)
Date:   Wed, 11 May 2022 13:26:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652268384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RXcxCcCEHYkua10Jt4BwYI9HJhbTvBsUxwTZHrgO7K4=;
        b=q75ytNBn4bykp/jOp4U3FG3izwIWTY3LryDZkV2a/wTHWiWW4ZlN1pkx5JU8/PAM2cwaJD
        0hh96LH12motU9DOhE9PTob/7TdoYMdvSVbR2lnJTXtTco/GKUXFy6zn2B13Pgnz19jAO0
        j5aCj1v1PopI0PnxQXh30x+kloctElA6CoDk8agwqtLJlVHF+GgZhN7DzedbZO49xJn+yg
        mIdB69A6HQf3EDUxeOc2+3kPb5gJtymsO8O2GaM0vGLSjzDGgrmLtyBVbNrROPqNzxfswD
        ogkLLTTM9DMeVCQjhx8SBviIJW+4uOXWJjwYc32Kq2emhF+Wze1y3lcPHnnNAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652268384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=RXcxCcCEHYkua10Jt4BwYI9HJhbTvBsUxwTZHrgO7K4=;
        b=n6eJkXQe2mt1Vf01pSRVLE3JSONdl3kUlfJEH394bWQ7MBONWNJ7FP4S/aK/7ui50u9hIn
        Qge0DxdKp22UPhBg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [REPOST PATCH] locking/lockdep: Remove lockdep_init_map_crosslock.
Message-ID: <YnudX+1Wb8Px/t0y@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cross-release bits have been removed, lockdep_init_map_crosslock() is
a leftover.

Remove lockdep_init_map_crosslock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20220311164457.46461-1-bigeasy@linutronix.de
---
 include/linux/lockdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 37951c17908e7..e4cfee37d5986 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -427,7 +427,6 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
-#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
-- 
2.36.1

