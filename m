Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72C7647B8B2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 03:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234150AbhLUC5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 21:57:02 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:59614 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233864AbhLUC4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 21:56:53 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0V.INquO_1640055410;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V.INquO_1640055410)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Dec 2021 10:56:51 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     peda@axentia.se
Cc:     a-govindraju@ti.com, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] mux: Fix struct mux_state kernel-doc comment
Date:   Tue, 21 Dec 2021 10:56:49 +0800
Message-Id: <20211221025649.119456-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A warning is reported because a colon was dropped, it is found by running
scripts/kernel-doc, which is caused by using 'make W=1'.
drivers/mux/core.c:44: warning: Function parameter or member 'state' not
described in 'mux_state'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Fixes: f20e55504ef4 ("mux: Add support for reading mux state from consumer DT node")
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/mux/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mux/core.c b/drivers/mux/core.c
index 7d38e7c0c02e..c0cf27582299 100644
--- a/drivers/mux/core.c
+++ b/drivers/mux/core.c
@@ -33,7 +33,7 @@
  * struct mux_state -	Represents a mux controller state specific to a given
  *			consumer.
  * @mux:		Pointer to a mux controller.
- * @state		State of the mux to be selected.
+ * @state:		State of the mux to be selected.
  *
  * This structure is specific to the consumer that acquires it and has
  * information specific to that consumer.
-- 
2.20.1.7.g153144c

