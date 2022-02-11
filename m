Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489524B25E4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 13:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350164AbiBKMgR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 07:36:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243958AbiBKMgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 07:36:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062BADB3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 04:36:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 918E361D64
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 12:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01FC340E9;
        Fri, 11 Feb 2022 12:36:07 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QBB72DiJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1644582967;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HyNsVaUyQWOPLIUs8NzWo56+7MmoIS24JC7SU4iNpOc=;
        b=QBB72DiJGxEYs11e7lVekH2F1M1hCb+/hTdG479c9LMVCqhsuU1HQ6JrtalBkbGogRWGyn
        oNrNjp1cAeGQEzsItFvCWb03iQSm7XhWl6/MCS77PZ23lbKdlKo8spVlFR+TSeGoNrZseg
        dc6E84C2EpEu7Ens84nQxbJqwnAHBcU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 75506883 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 11 Feb 2022 12:36:06 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux@dominikbrodowski.net
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/9] random: remove useless header comment
Date:   Fri, 11 Feb 2022 13:35:39 +0100
Message-Id: <20220211123546.474952-3-Jason@zx2c4.com>
In-Reply-To: <20220211123546.474952-1-Jason@zx2c4.com>
References: <20220211123546.474952-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This really adds nothing at all useful.

Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 include/linux/random.h | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/linux/random.h b/include/linux/random.h
index e92efb39779c..37e1e8c43d7e 100644
--- a/include/linux/random.h
+++ b/include/linux/random.h
@@ -1,9 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * include/linux/random.h
- *
- * Include file for the random number generator.
- */
+
 #ifndef _LINUX_RANDOM_H
 #define _LINUX_RANDOM_H
 
-- 
2.35.0

