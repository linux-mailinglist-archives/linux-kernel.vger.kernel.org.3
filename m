Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15BCC57DA56
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 08:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiGVGeH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 02:34:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiGVGeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 02:34:01 -0400
Received: from mail-m974.mail.163.com (mail-m974.mail.163.com [123.126.97.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FF784D4E5;
        Thu, 21 Jul 2022 23:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=QSsw+
        n12VZ5Mt9M8vjVWAmnvanUDHuoSYkmFZCbq7AY=; b=hRouYzf4/ggxwt5AfsHZV
        cFQluoPp/JOWo9U+Bf4Vf7JrALvukRL9CuJbAR2AsatDcxcydNyQGtsfTBX4JUNQ
        KEKRrqt6sRGrvtZP+x9w4Wg8Cz7RlSGxLLgcFb3t/9V2IyjmaovpvtY5rPJ6T6KF
        /ZsXbm6LcTGyRwIr6+ubec=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp4 (Coremail) with SMTP id HNxpCgD3L3DGRNpigOxlQA--.19561S2;
        Fri, 22 Jul 2022 14:33:44 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     prabhakar.csengg@gmail.com, mchehab@kernel.org,
        laurent.pinchart@ideasonboard.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] media: platform: ti: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 14:33:41 +0800
Message-Id: <20220722063341.69913-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HNxpCgD3L3DGRNpigOxlQA--.19561S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFyDXFy8ZFyUJrWxWr4xXrb_yoW8WFWUpF
        WDK3yxArWqgr1qqw4DAw1kuFW3Aw1SvFWjkry3u3s3uan8ZFWqyr18tFySyF9rXFWfZFy3
        JF1rtw13WFs5ur7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEyxRnUUUUU=
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbivwhGZFWB0jrEuAAAsV
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace 'the the' with 'the' in the comment.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
---
 drivers/media/platform/ti/davinci/vpbe.c | 2 +-
 drivers/media/platform/ti/omap3isp/isp.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/ti/davinci/vpbe.c b/drivers/media/platform/ti/davinci/vpbe.c
index 5f0aeb744e81..509ecc84624e 100644
--- a/drivers/media/platform/ti/davinci/vpbe.c
+++ b/drivers/media/platform/ti/davinci/vpbe.c
@@ -280,7 +280,7 @@ static int vpbe_set_default_output(struct vpbe_device *vpbe_dev)
  * vpbe_get_output - Get output
  * @vpbe_dev: vpbe device ptr
  *
- * return current vpbe output to the the index
+ * return current vpbe output to the index
  */
 static unsigned int vpbe_get_output(struct vpbe_device *vpbe_dev)
 {
diff --git a/drivers/media/platform/ti/omap3isp/isp.c b/drivers/media/platform/ti/omap3isp/isp.c
index 4c937f3f323e..f99dda7337b9 100644
--- a/drivers/media/platform/ti/omap3isp/isp.c
+++ b/drivers/media/platform/ti/omap3isp/isp.c
@@ -1528,7 +1528,7 @@ void omap3isp_print_status(struct isp_device *isp)
  * To solve this problem power management support is split into prepare/complete
  * and suspend/resume operations. The pipelines are stopped in prepare() and the
  * ISP clocks get disabled in suspend(). Similarly, the clocks are re-enabled in
- * resume(), and the the pipelines are restarted in complete().
+ * resume(), and the pipelines are restarted in complete().
  *
  * TODO: PM dependencies between the ISP and sensors are not modelled explicitly
  * yet.
-- 
2.25.1

