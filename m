Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CE6578383
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbiGRNS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234611AbiGRNS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:18:58 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CA8263A;
        Mon, 18 Jul 2022 06:18:53 -0700 (PDT)
X-QQ-mid: bizesmtp81t1658150324tyhblouv
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:18:42 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: +N0aDBfR9LXTO6ZJg5TfopyrXLWhhFXHRSu/cEfG7o3SlXbfc/MRy78YlqUPu
        zAR9y+jE/8N5zfGqVg6wJsNuU7PFLj8iqU1U3xnS1jCz4U3Pzy4JeW7Wes1fDAhp4GsUs17
        3Ohy7e9EfqmhORlLsOkH3rxUT4hG2nfrmkz1ICvPXv6kkmuxoQnhgxAhYsBWBgAS/Ld4uKY
        imBYSgr3LoIkjC7HkhZlyu674NiX9Kpr0w2qVDMrvpIOmb5dc6ergwwEfBgl2UzmDeY6HBa
        ghb7dCHVCFLjt6O0D8yiR0prclc/gfYTL+bqo16uEbwXrMFlzAf//weJmLooLmsy5A/fPry
        4r9KQaTZSyfX+GgLLmwY80V9dkx4rbLy4wGJvQ4PTwEZBPIgSZ2eeHh8UVJRb94LL0yUF5u
        g+L2g65w7ZoVV91bi/hR/w==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     sakari.ailus@linux.intel.com, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] media: mc-request.c: Fix comment typo
Date:   Fri, 15 Jul 2022 13:16:46 +0800
Message-Id: <20220715051646.30195-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `that' is duplicated in line 162, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/media/mc/mc-request.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/mc/mc-request.c b/drivers/media/mc/mc-request.c
index addb8f2d8939..752ea0bc804b 100644
--- a/drivers/media/mc/mc-request.c
+++ b/drivers/media/mc/mc-request.c
@@ -159,7 +159,7 @@ static long media_request_ioctl_queue(struct media_request *req)
 	 * state can only happen if either the driver changes the state or if
 	 * the user cancels the vb2 queue. The driver can only change the state
 	 * after each object is queued through the req_queue op (and note that
-	 * that op cannot fail), so setting the state to QUEUED up front is
+	 * op cannot fail), so setting the state to QUEUED up front is
 	 * safe.
 	 *
 	 * The other reason for changing the state is if the vb2 queue is
-- 
2.35.1

