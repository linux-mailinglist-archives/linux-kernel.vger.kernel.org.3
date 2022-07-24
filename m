Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D84157F39B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 09:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiGXHOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 03:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiGXHOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 03:14:41 -0400
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FC817AA3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 00:14:33 -0700 (PDT)
X-QQ-mid: bizesmtp82t1658646861tfpjqeg1
Received: from localhost.localdomain ( [125.70.163.183])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 24 Jul 2022 15:14:20 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: 7jw2iSiCazp69tT+f4E81zq3rVd3a8D7IVyLs5HY8A4DQ/X7/uaB5yXKiVA/v
        KRsmFd0ppSx/eKWTZk2TReA+YL2fM2ubRaX0m1D9vM3g8FGiV9L5hommEhDI+QVaoKwbhC8
        J7jxJQJhOtgP/r4JTeMwFm8mE5jzTvgVniVnRPeE9KNFc/IfyawuWnNmW7aSacIDZur4PJb
        Tl/JIYOJ6yUYhq3cur+hvdFtPi5NmRlJE1f+u89gvvDfVrUIUsnhnvwzIsTSpDXwk4ss9Pj
        R8RFaAarlN/JJCm+S/xgjeaK9hQdktRknl5oxVQN9oK+GXgn3JakkNYCsDTbp1ltHt0RffK
        bmVC/6dsQZ7AnMjvW+A9cWMpQNWOYCJRF/Q2rYKkjrE9Tm2QeY=
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] pci/asihpi: fix repeated words in comments
Date:   Sun, 24 Jul 2022 15:14:13 +0800
Message-Id: <20220724071413.10085-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'in'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 sound/pci/asihpi/hpi6000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/asihpi/hpi6000.c b/sound/pci/asihpi/hpi6000.c
index aa4d06353126..88d902997b74 100644
--- a/sound/pci/asihpi/hpi6000.c
+++ b/sound/pci/asihpi/hpi6000.c
@@ -388,7 +388,7 @@ void HPI_6000(struct hpi_message *phm, struct hpi_response *phr)
 /* SUBSYSTEM */
 
 /* create an adapter object and initialise it based on resource information
- * passed in in the message
+ * passed in the message
  * NOTE - you cannot use this function AND the FindAdapters function at the
  * same time, the application must use only one of them to get the adapters
  */
-- 
2.36.1

