Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E17583EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238678AbiG1Mha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbiG1Mh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:37:29 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18AB691CB;
        Thu, 28 Jul 2022 05:37:23 -0700 (PDT)
X-QQ-mid: bizesmtp71t1659011837tl5sm6cx
Received: from localhost.localdomain ( [171.223.98.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 28 Jul 2022 20:37:16 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: DQ0OCu3gog3WdyvVI/CPjQSC485SfJNAohL4WVgEQxO7BBzJQjirNeJ22EBIj
        MdPllWHsFL3gawWPeKcz0ktiSbsI3g0v8kaLdjVz4IHEvhZ8raxuMaBhnTFV+5pX96Z534X
        RHaLP7uuBMPaWDJuyTL0ncmvj/YXUYYbkeb/AmVl7qQxj/MnCp/CUJ6TZXUidktrBTCJSYZ
        4OIdVRHfJhtJjgk7yuM8OB31hyP4+eYL8epGFsXF9jStFZMALblNpeDEx7zD6tvPqnZVUqb
        gE7AZIIyLwc3GhgrdWq5eRoGfMXuInYp/zfHxd8z9+3h2xXiS7BNePy0w+2ATEH0KOGJ4KR
        1NVB/KFplW3L+Aadpy6Ixa2YIlMSaqYBVHrEtbi4diHDRYbi9bZIzTtoshlihQ8cB3Fr6fw
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] input: serio: Fix comment typo
Date:   Mon, 25 Jul 2022 12:35:23 +0800
Message-Id: <20220725043523.6513-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first `in' is a typo in the comment, change to `it'.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/input/serio/q40kbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/serio/q40kbd.c b/drivers/input/serio/q40kbd.c
index bd248398556a..b2b572079e67 100644
--- a/drivers/input/serio/q40kbd.c
+++ b/drivers/input/serio/q40kbd.c
@@ -81,7 +81,7 @@ static void q40kbd_stop(void)
 
 /*
  * q40kbd_open() is called when a port is open by the higher layer.
- * It allocates the interrupt and enables in in the chip.
+ * It allocates the interrupt and enables it in the chip.
  */
 
 static int q40kbd_open(struct serio *port)
-- 
2.35.1

