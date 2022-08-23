Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F99459E912
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiHWRWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239664AbiHWRVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:06 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51A7BE4CD;
        Tue, 23 Aug 2022 07:57:20 -0700 (PDT)
X-QQ-mid: bizesmtp71t1661266636t5qkwjew
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 23 Aug 2022 22:57:15 +0800 (CST)
X-QQ-SSF: 0100000000200040B000B00A0000000
X-QQ-FEAT: ILHsT53NKPjSG0RvvxCOryIyJPMeWQzLFoVN31CgGr2K2bM5sfmUKIYf+jm4E
        059+SGarD/IRmG3SeENZNVHWqWbUEbdHjW6ta03lO+Q6FNHchsyCzqf5xqrIR6Haln/FR6P
        y1nwUYfzaw3ph+m1bJcLp8mlNlNJ6K8oNlWshmXtMPyKOnaOjZ6EhGu99MaLGR8OpsDRJqv
        Yfv3XXXHa9f0PuyH4lrVHeC5JL6psL/tP7UoyTGbi05tMrouCCJiOhDvFbXaueAVNzxnJ0N
        H1GRvDUixLatiLfa6lVDNwz9Q/+RBf0LwTiNR1RtlCJrQtVQSliJs/UwwXeG5svjVGpjxKn
        1rUZs3jumuC8kOZs84qpQ+kXtbrYqXr5qUoUab4Ya3sa5JIXb7d8t29p1UKKK7//OxBXyQJ
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/saa7164: fix repeated words in comments
Date:   Tue, 23 Aug 2022 22:57:09 +0800
Message-Id: <20220823145709.46069-1-wangjianli@cdjrlc.com>
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

Delete the redundant word 'the'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/media/pci/saa7164/saa7164-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/pci/saa7164/saa7164-core.c b/drivers/media/pci/saa7164/saa7164-core.c
index 7973ae42873a..d5f32e3ff544 100644
--- a/drivers/media/pci/saa7164/saa7164-core.c
+++ b/drivers/media/pci/saa7164/saa7164-core.c
@@ -626,7 +626,7 @@ static irqreturn_t saa7164_irq(int irq, void *dev_id)
 	portf = &dev->ports[SAA7164_PORT_VBI2];
 
 	/* Check that the hardware is accessible. If the status bytes are
-	 * 0xFF then the device is not accessible, the the IRQ belongs
+	 * 0xFF then the device is not accessible, the IRQ belongs
 	 * to another driver.
 	 * 4 x u32 interrupt registers.
 	 */
-- 
2.36.1

