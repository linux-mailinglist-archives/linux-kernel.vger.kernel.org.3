Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B29958C1BF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 04:42:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243905AbiHHCmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 22:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241980AbiHHClk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 22:41:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04E925C8;
        Sun,  7 Aug 2022 19:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=gzcS+2g8qckyZYIbV9gGRltqepY9Wqdgqqh++TVUMKc=; b=LhxYf0PPJIbN0YuEmB1f0e3VgE
        P1xTVDnQvAPJHX89BkXP4kHoCf3BKzomhlrXrvRlI7gkvQr4xZFerWQHDbfdD2RQIwkCBi5Zz9Pa2
        mdMG5Y4fUAa/7R5x5jHHnEJszfwNKz5Sfh01olXYyT51emzASbl7aImEk434uLv1MZzo+a/fjblfx
        /TxNUjfNLkR/eOKZIZ1EQRk2HT3OUR8Kc3nB3elhNx0YyP8bL7RDAGcAldyB1LcrcPfIpnoJmPmFw
        Q15p6yrVxgqxtjJ5W9QIlcMt+htSsHpIbHW5GdL4fzYW9/6HWL1DWYm/SvKMtHZzLs+ZbdZJms0Mm
        9H3/c/9A==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oKshz-00DVSr-1Y; Mon, 08 Aug 2022 02:41:35 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-kernel@vger.kernel.org, pmladek@suse.com,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-acpi@vger.kernel.org
Subject: [PATCH v5 30/32] ACPI/APEI: Add missing include
Date:   Mon,  8 Aug 2022 03:41:26 +0100
Message-Id: <20220808024128.3219082-31-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220808024128.3219082-1-willy@infradead.org>
References: <20220808024128.3219082-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

The upcoming patch to switch tracing from seq_buf to printbuf means
we're no longer pulling in headers that we used to; this adds a missing
include so things don't break.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: linux-acpi@vger.kernel.org
---
 drivers/acpi/apei/erst-dbg.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/apei/erst-dbg.c b/drivers/acpi/apei/erst-dbg.c
index 8bc71cdc2270..370993c9c381 100644
--- a/drivers/acpi/apei/erst-dbg.c
+++ b/drivers/acpi/apei/erst-dbg.c
@@ -11,6 +11,7 @@
  *   Author: Huang Ying <ying.huang@intel.com>
  */
 
+#include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/uaccess.h>
-- 
2.35.1

