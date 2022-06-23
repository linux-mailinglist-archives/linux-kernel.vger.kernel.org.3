Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AAAD557A58
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiFWMaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiFWMao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:30:44 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA71C40935;
        Thu, 23 Jun 2022 05:30:39 -0700 (PDT)
X-QQ-mid: bizesmtp66t1655987394t2gj7nux
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 23 Jun 2022 20:29:49 +0800 (CST)
X-QQ-SSF: 01000000008000C0C000D00A0000000
X-QQ-FEAT: k0yT7W7BRd0RaG/4g7chcYNw6cG/LMMTM5aC3bPjYPncdxrM7vrxebJivwZp8
        JSCX9YiR4AySiurHY5jnyA3x6V+uldzxPQ61Tt7c+L5Oo0soqolujEoSWQ0HxE9U75eohIR
        EGivGTQZoZ1UCcRZyIyQi1QfL5pVjbQc7kSozZHIl0fQZbcvbm7Q5P8rRTU6Ow2FrXtJnZq
        y5uIrAZKBc7UeBcd2qfIFNUJ3gvi/dQaVSb1t2v8hLUDik4Ams24R7wer/ttEpgDzhQSp1p
        8NSXaWx3GPr6OapNElJ4wG/nZgbTGedHiFkNZIFIa/d9Q8q3WwAyFX/Y1A4JE4SfSynT1KU
        5G6WVZdF8ExHHbRu9J0uOZakn25pXHLErWXHo1S
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     mchehab@kernel.org
Cc:     hyun.kwon@xilinx.com, laurent.pinchart@ideasonboard.com,
        michal.simek@xilinx.com, linux-media@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] media: xilinx: drop unexpected word 'with' in comments
Date:   Thu, 23 Jun 2022 20:29:48 +0800
Message-Id: <20220623122948.54839-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'with' in the comments that need to be dropped

file - drivers/media/platform/xilinx/xilinx-vip.h
line -31

 * Pad IDs. IP cores with with multiple inputs or outputs should define

changed to:

 * Pad IDs. IP cores with multiple inputs or outputs should define

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/media/platform/xilinx/xilinx-vip.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/xilinx/xilinx-vip.h b/drivers/media/platform/xilinx/xilinx-vip.h
index d0b0e0600952..1c8dd59067fe 100644
--- a/drivers/media/platform/xilinx/xilinx-vip.h
+++ b/drivers/media/platform/xilinx/xilinx-vip.h
@@ -28,7 +28,7 @@ struct clk;
 #define XVIP_MAX_HEIGHT			7680
 
 /*
- * Pad IDs. IP cores with with multiple inputs or outputs should define
+ * Pad IDs. IP cores with multiple inputs or outputs should define
  * their own values.
  */
 #define XVIP_PAD_SINK			0
-- 
2.17.1

