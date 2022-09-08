Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 839E45B1D9B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 14:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbiIHMtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 08:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiIHMs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 08:48:59 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDC6D074E;
        Thu,  8 Sep 2022 05:48:57 -0700 (PDT)
X-QQ-mid: bizesmtp67t1662641330thnapd60
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 20:48:49 +0800 (CST)
X-QQ-SSF: 0100000000200090C000B00A0000000
X-QQ-FEAT: HHPuPN/BfjVZ87LLtIqzA1WJs/RhE45BrrvU28FNKKd3VpTotRvMZBtDG26UI
        Qw86oCfzQM8VysWhi7AyYgw6BtnzsyCFZvEHP+vNVLus/e1m6aM5JmRvD9W2c+vaYs3oKL3
        BQIhp/JpAmQ74bJytgj9Hr922WxfyQPI6IsJn8KKi8bBpjqpiAYqo9BgxiWOD/xehrZmcrQ
        uKuOvxQqBnwECkJCdLYL2vDj6y6bxKb+ANj4FcMxGdU6g2/uv7Ec2rP8BqmTpQpc0PtrLfs
        dWnhbL14+N3cyvRWE4LCHRu7/L/7hWzRyQVEo5SBPq2vGSP3aYqe/VDpJIsJKLFJxVHMZzf
        SB7g5HzibljYgZlDi+kUapRMs2HEoHpYetLYXjIWlEXjZD6s/XaqnxbolJcvg==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     damien.lemoal@opensource.wdc.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/ata: fix repeated words in comments
Date:   Thu,  8 Sep 2022 20:48:42 +0800
Message-Id: <20220908124842.25435-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/ata/sata_dwc_460ex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
index e3263e961045..a4c83a6e5631 100644
--- a/drivers/ata/sata_dwc_460ex.c
+++ b/drivers/ata/sata_dwc_460ex.c
@@ -1087,7 +1087,7 @@ static struct scsi_host_template sata_dwc_sht = {
 	/*
 	 * test-only: Currently this driver doesn't handle NCQ
 	 * correctly. We enable NCQ but set the queue depth to a
-	 * max of 1. This will get fixed in in a future release.
+	 * max of 1. This will get fixed in a future release.
 	 */
 	.sg_tablesize		= LIBATA_MAX_PRD,
 	/* .can_queue		= ATA_MAX_QUEUE, */
-- 
2.36.1

