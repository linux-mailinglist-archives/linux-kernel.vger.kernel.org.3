Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E1EF48882B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 06:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbiAIF4l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 00:56:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiAIF4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 00:56:40 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C43BC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 21:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hfHrbUWm53dg29/Yt/DorGtbkOF3vLQS4YQI309TBF8=; b=dCiq4W+I7kpVX5gUrWPbvtZPNt
        KNILE6QUj75niBGjjHP4cATCifniKUqcpkEfUaOkB0TGA8lUjr63COe5ypjSYgeBUDR4p3U6A7SUU
        Ck9dKXJoTNvSz0xqSCXwSrZdoABfZCCm5JJYy4nVWjCMeHIEDi1Yf9KVUzOlBckNpfukXIJC7Yuph
        cuUGxDBDEl9n86hYLvuIvBWa+4m68Ht2DryC6Y5+Nb4z5rVRSbgWerN73SENS5Tl4LdMEg/i9vrE3
        SLUss9mgRLwHt44i6Wx2aEplwcnNvt/e0x9i5k1DW8wDEBxYumhl+zpalK4TeykrJuDgJG4ukGliY
        zG+LgGHQ==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6RC1-007Of2-8G; Sun, 09 Jan 2022 05:56:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: [PATCH] sysctl: documentation: fix table format warning
Date:   Sat,  8 Jan 2022 21:56:35 -0800
Message-Id: <20220109055635.6999-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix malformed table warning in sysctl documentation:
(don't use ':'s)

Documentation/admin-guide/sysctl/kernel.rst:798: WARNING: Malformed table.
Text in column margin in table line 7.

=====  ============================================
bit 0  print all tasks info
bit 1  print system memory info
bit 2  print timer info
bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
bit 4  print ftrace buffer
bit 5: print all printk messages in buffer
bit 6: print all CPUs backtrace (if available in the arch)

Fixes: 934d51cad60c ("docs: sysctl/kernel: add missing bit to panic_print")
Fixes: addc64999934 ("panic: add option to dump all CPUs backtraces in panic_print")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Guilherme G. Piccoli <gpiccoli@igalia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
---
 Documentation/admin-guide/sysctl/kernel.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20220107.orig/Documentation/admin-guide/sysctl/kernel.rst
+++ linux-next-20220107/Documentation/admin-guide/sysctl/kernel.rst
@@ -795,8 +795,8 @@ bit 1  print system memory info
 bit 2  print timer info
 bit 3  print locks info if ``CONFIG_LOCKDEP`` is on
 bit 4  print ftrace buffer
-bit 5: print all printk messages in buffer
-bit 6: print all CPUs backtrace (if available in the arch)
+bit 5  print all printk messages in buffer
+bit 6  print all CPUs backtrace (if available in the arch)
 =====  ============================================
 
 So for example to print tasks and memory info on panic, user can::
