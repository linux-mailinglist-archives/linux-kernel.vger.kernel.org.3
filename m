Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC30593407
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 19:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbiHOR1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 13:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiHOR0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 13:26:34 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A26B210554
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 10:26:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1660584392;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBiufZJ2yRKMSs7mTEaqgH84ejhGptk3Wuu2oCsibD4=;
        b=LUKEtSgJfkXe4vV/YyO8Fyyapa6eA+J+MvTXDrkIVnrotabbnH+qeBzCmbnDGjJaQGqBvo
        zTx25r17kUApB51J280r/r16+13hUlJkZ7sUlyfY5aI/+GbREYwLvrZLu/+hm7+v4UXcpm
        4xSxAvrWiiMI1pJ6q0wnLalqD6W7W4M=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH 11/11] MAINTAINERS: Add entry for printbufs
Date:   Mon, 15 Aug 2022 13:26:13 -0400
Message-Id: <20220815172613.621627-12-kent.overstreet@linux.dev>
In-Reply-To: <20220815172613.621627-1-kent.overstreet@linux.dev>
References: <20220815172613.621627-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

Printbufs are a new string building library; adding myself as the author
of this code.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7deb6e92a..d954af7a84 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16365,6 +16365,12 @@ S:	Maintained
 F:	include/linux/psi*
 F:	kernel/sched/psi.c
 
+PRINTBUF
+M:	Kent Overstreet <kent.overstreet@linux.dev>
+S:	Maintained
+F:	include/linux/printbuf.h
+F:	lib/printbuf.c
+
 PRINTK
 M:	Petr Mladek <pmladek@suse.com>
 M:	Sergey Senozhatsky <senozhatsky@chromium.org>
-- 
2.36.1

