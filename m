Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26504525FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 12:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379536AbiEMKhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 06:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379459AbiEMKhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 06:37:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6883B60AAC;
        Fri, 13 May 2022 03:37:03 -0700 (PDT)
Date:   Fri, 13 May 2022 10:37:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652438222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+6pwxEenLKGaPGjNNRp3SQ+cWg2Gm1CGru+j2rWuUc=;
        b=tEtT506f+Vjk/eANx62GChQwQSFq2lO4QBzJCRco5iJ3P39eBvSJAG4CltUsMSzZmWgw0d
        MT8BZ25bodbHgL6fxxPAmAd+Gg0+WmOqkSq0iEsHfRPTH9Bw+9xbL2w2q8xGnPPPDseaTH
        GH5hWkOAnYqSdmHsbwFZiq6dWVqZZbaW0lhRv+aHqikfmOvC90c4jJXP7KupERZtnSFu59
        LlHv6eHTSwObVxOu8rB27bb1Omse1FudWuTj92BV3l+3gwqmEtX7sfXUBtgnNbbBJN6u/s
        sJIAvKjHjU95LZuRyYqpsHnULWcT+Jq09NKd9SFaeO+YxLzvSGGWaRCtM637bA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652438222;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3+6pwxEenLKGaPGjNNRp3SQ+cWg2Gm1CGru+j2rWuUc=;
        b=bFGI4YeEEmrhtwSZsrav4AZ1klW3vfe4XWY2Ae6IE2JpJ5gQD3D43CFGGnt6lYjO89/YdP
        cfJsnXfdkSxpH+AQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/debugobjects] debugobjects: Convert to SPDX license identifier
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87v8udpy3u.ffs@tglx>
References: <87v8udpy3u.ffs@tglx>
MIME-Version: 1.0
Message-ID: <165243822065.4207.13231431702184056192.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/debugobjects branch of tip:

Commit-ID:     9e4a51ad8eee1d263666fd31ced39bd8e3770822
Gitweb:        https://git.kernel.org/tip/9e4a51ad8eee1d263666fd31ced39bd8e3770822
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 May 2022 10:53:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 May 2022 12:35:17 +02:00

debugobjects: Convert to SPDX license identifier

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/87v8udpy3u.ffs@tglx

---
 lib/debugobjects.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/lib/debugobjects.c b/lib/debugobjects.c
index 6946f8e..337d797 100644
--- a/lib/debugobjects.c
+++ b/lib/debugobjects.c
@@ -1,11 +1,8 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Generic infrastructure for lifetime debugging of objects.
  *
- * Started by Thomas Gleixner
- *
  * Copyright (C) 2008, Thomas Gleixner <tglx@linutronix.de>
- *
- * For licencing details see kernel-base/COPYING
  */
 
 #define pr_fmt(fmt) "ODEBUG: " fmt
