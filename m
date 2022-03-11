Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2674D66A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 17:45:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350438AbiCKQqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 11:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236353AbiCKQqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 11:46:10 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724171BA17B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 08:45:06 -0800 (PST)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647017104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D5m+mY7LjFu1LZHLdb3mluOsfB8pNaI1pal4+RRYv2E=;
        b=SWeeXMJSQ28tX1elR/DuG9YXTi0cCnZolwU6BmPEI8dnrcvIgCG13Lxo8iCaFQqcZVcM90
        XLnhvDTOoZ4FyZC7xWy7gUx3COVtY6UdIIO57Z/m2EDLp5rTlI+L/iVXlwx5nzOIGGfpXG
        hLkhUNKeGNJuTd+18IXbkMM5GIDG2dYYCUUS1gBcMMMoAIokep6++2BtmWuUJMLd7m8zE+
        oKFkDMYWnW8dM+BJe+Pjs31Qzv0oJ8ddgdU+bCq2+uSy/k/XwXoSP6Ciq0itzKi2F6tO8N
        ZWt/BcPheKPoVkbpa6p8B72jqtU61YTQAaEDsnHhFHiLqYQYR0Y0QeifkqnxCA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647017104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=D5m+mY7LjFu1LZHLdb3mluOsfB8pNaI1pal4+RRYv2E=;
        b=2GOsxnk1cvK2asBFPv6XI1LCJAvudDUEaDO2dKp0pcj8H1NxTy7eylQ2SPSmml3Eq6VUPo
        RRSQ84ro8jnEKICg==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] locking/lockdep: Remove lockdep_init_map_crosslock.
Date:   Fri, 11 Mar 2022 17:44:57 +0100
Message-Id: <20220311164457.46461-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cross-release bits have been removed, lockdep_init_map_crosslock() is
a leftover.

Remove lockdep_init_map_crosslock.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/lockdep.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
index 467b94257105e..3d948f001f182 100644
--- a/include/linux/lockdep.h
+++ b/include/linux/lockdep.h
@@ -431,7 +431,6 @@ enum xhlock_context_t {
 	XHLOCK_CTX_NR,
 };
=20
-#define lockdep_init_map_crosslock(m, n, k, s) do {} while (0)
 /*
  * To initialize a lockdep_map statically use this macro.
  * Note that _name must not be NULL.
--=20
2.35.1

