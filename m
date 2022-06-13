Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAED549C31
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:54:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344791AbiFMSxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245639AbiFMSw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:52:59 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AA8F5068;
        Mon, 13 Jun 2022 08:55:24 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id AD009431CB;
        Mon, 13 Jun 2022 11:55:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135720;
        bh=+Kb7VqzReS+e6rImoHVlRTixAEqb/MzeIUPpIes6Cpk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=mIiH/d/I0kiQpfpSEhfWHGHR3fPxtN+qNQtH/6hWBmo5NVxTDJMOHEfqB2jerxTzf
         ixpojPLrrtZWDz2wqa8bRxse1weWigI/ZfciRE082W3Lh1LvY4Mk6eu8twW2oTYCsO
         YohzCDMASTcijE7fLD23trDu+vJteqQXqC5wwufDID8poyQBrB+ZHlqG1+Qkr9I9cQ
         QkiNaXMuPx+peL6TPWT4a+UhpLyXcAAVMyff76Y7aPZbP5ZtI5WU+ftqXEQLtJ7/BY
         XVZOkv/F6VsMsG6Hqz4Hv+z6KdLaT141TI0cQTBGfmfMv7AM3wlVo+1Dadp3j+SAGD
         jP8XBCp1Zktqg==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:55:00 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 19/20] block, blksnap: Makefile
Date:   Mon, 13 Jun 2022 18:53:12 +0300
Message-ID: <1655135593-1900-20-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allows to build a module.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/Makefile | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)
 create mode 100644 drivers/block/blksnap/Makefile

diff --git a/drivers/block/blksnap/Makefile b/drivers/block/blksnap/Makefile
new file mode 100644
index 000000000000..18b6b9e8f944
--- /dev/null
+++ b/drivers/block/blksnap/Makefile
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0
+KERNEL_MODULE_NAME := blksnap
+
+$(KERNEL_MODULE_NAME)-y += big_buffer.o
+$(KERNEL_MODULE_NAME)-y += cbt_map.o
+$(KERNEL_MODULE_NAME)-y += chunk.o
+$(KERNEL_MODULE_NAME)-y += ctrl.o
+$(KERNEL_MODULE_NAME)-y += diff_io.o
+$(KERNEL_MODULE_NAME)-y += diff_area.o
+$(KERNEL_MODULE_NAME)-y += diff_buffer.o
+$(KERNEL_MODULE_NAME)-y += diff_storage.o
+$(KERNEL_MODULE_NAME)-y += event_queue.o
+$(KERNEL_MODULE_NAME)-y += main.o
+$(KERNEL_MODULE_NAME)-y += snapimage.o
+$(KERNEL_MODULE_NAME)-y += snapshot.o
+$(KERNEL_MODULE_NAME)-y += sysfs.o
+$(KERNEL_MODULE_NAME)-y += tracker.o
+$(KERNEL_MODULE_NAME)-y += memory_checker.o
+
+obj-m	 += $(KERNEL_MODULE_NAME).o
-- 
2.20.1

