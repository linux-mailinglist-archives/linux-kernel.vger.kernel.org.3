Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A152C5ACBD7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236372AbiIEHAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236269AbiIEHAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:00:22 -0400
Received: from mail-m975.mail.163.com (mail-m975.mail.163.com [123.126.97.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE51822B14;
        Mon,  5 Sep 2022 00:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=G9PRu
        m1izor0nngmVMOFcOHtkmJgD11qKZ6kZyikhek=; b=FgfKLRQ8WjPqaOqWnvYPu
        M7NLW0gX4jvMiAvSsSV+G9hVBY//eZF+k771vG5tbV8/wDa+B1O81BS9zdEmi6di
        Aq5zR9F0+uFJdGCTnul0DnogisFYFiDLivQ7lPYHBIaFHQ6Q4BXecAZFkmMm8wKC
        B0aK2QCivBL+fsWpdlt760=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp5 (Coremail) with SMTP id HdxpCgAnRDk7nhVjrtvGZw--.51372S2;
        Mon, 05 Sep 2022 14:59:08 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     david@lechnology.com, mturquette@baylibre.com, sboyd@kernel.org
Cc:     nsekhar@ti.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] clk: davinci: pll: fix spelling typo in comment
Date:   Mon,  5 Sep 2022 14:58:33 +0800
Message-Id: <20220905065833.1831473-1-13667453960@163.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HdxpCgAnRDk7nhVjrtvGZw--.51372S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5Gr4ruF1Utrb_yoW3KFc_WF
        W8W34DW398KFsav3Wjq3yFqFyFyFs5uF97W3WYva1fJ3y5Z39rG3yvqw1Iv342krWUWF9F
        y3Wayr15Crn8ZjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbuOJ7UUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizRxz+1c7OAtEywAAsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 drivers/clk/davinci/pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/davinci/pll.c b/drivers/clk/davinci/pll.c
index 0d750433eb42..c53dd4ff8530 100644
--- a/drivers/clk/davinci/pll.c
+++ b/drivers/clk/davinci/pll.c
@@ -98,7 +98,7 @@
  * @hw: clk_hw for the pll
  * @base: Base memory address
  * @pllm_min: The minimum allowable PLLM[PLLM] value
- * @pllm_max: The maxiumum allowable PLLM[PLLM] value
+ * @pllm_max: The maximum allowable PLLM[PLLM] value
  * @pllm_mask: Bitmask for PLLM[PLLM] value
  */
 struct davinci_pll_clk {
-- 
2.27.0


No virus found
		Checked by Hillstone Network AntiVirus

