Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D15450F3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237688AbiFIPgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 11:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344512AbiFIPgk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 11:36:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721DE1BBAE2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 08:36:35 -0700 (PDT)
Date:   Thu, 9 Jun 2022 17:36:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1654788994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iJLDRN/h9a6TsMp3PIuWTyOIVOJlSDyFEwUAad066Gw=;
        b=U4XwiiNZirQ3HB+yhWRhGAkuBofcboeHYmPoNNQ8wwCi6JkVfrBb4NNnX0nH72X3uG5QA2
        rWSwv0QA2dXz+5mx1IgJNDpIBZ/1gtVpcXDEOFoDBIxqWSKy/XsGP6zGWjc+Ay0peZI+7x
        I/nKxr1w9g0+MWJP6gM2QPdTJnQhL/zula8A8cV53r3Lr2sC3ECwsbKpZvISsqUjBYYKh/
        R9Ro4PERRJGRdss8nWHXnVL8vQ57ZfqZLfka8g+mJuNAV3PHtuJ3GSIVMAxMKrb+9J2SCy
        8wiYbjLf4WF0uVeZvLb7xrSU1446JpQW0HIqkXdISv/10lPMBD5nP+DaM54Wcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1654788994;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=iJLDRN/h9a6TsMp3PIuWTyOIVOJlSDyFEwUAad066Gw=;
        b=gYSRkEg7oODpMqs1EW24VKJf9rtyuUyW+AosK8IaaD4lFPXa8SOHTYGSnnmYgzT7F9LpH4
        WtQ2RGsZ43AK1eAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [REPOST PATCH] locking/lockdep: Remove lockdep_init_map_crosslock.
Message-ID: <YqITgY+2aPITu96z@linutronix.de>
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
 include/linux/lockdep.h |    1 -
 1 file changed, 1 deletion(-)

--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -431,7 +431,6 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
 
-#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
