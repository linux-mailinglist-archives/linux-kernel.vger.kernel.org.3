Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E715542D1
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349157AbiFVGW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346528AbiFVGWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:22:24 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C282F38D;
        Tue, 21 Jun 2022 23:22:18 -0700 (PDT)
X-QQ-mid: bizesmtp81t1655878869t181i2yu
Received: from ubuntu.localdomain ( [106.117.99.132])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 14:21:02 +0800 (CST)
X-QQ-SSF: 01000000008000B0B000C00A0000000
X-QQ-FEAT: fcnEXZ5FDbAnAJejYmtcrh5DkYv2MYCFGgWhCa76GN8OmI7nE6R04jtj8l1GO
        I42J37IpP/BYWsBp4N1xhUMQuBXYA5FcxzISO/mcwgmhxpDEGh2BPmF5JWx/DsMNNUftMoV
        7zkrnPQtx5UfQBtc9YAzJT4PQt+t9zmVaJ/TpyFxFyxykE1kTdAW/PQXSng6U9cneSoi207
        tqB0TKQ4/iWKw4X81DpMhlGtq+n7+VlC4KVwkw8shaiZlJwZvT8pA3CaQbzmTwGk3pLcMho
        t471frnhTRV1dzvF0870cI5+5UQuiBfCm1VMOSUqGyvDXI7j4q+n7/TivpObASW/iqpjB+t
        Z6mPZxmSkwC8vZ1TTdbqItgPw4MPg==
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     dmitry.torokhov@gmail.com
Cc:     jiangjian@cdjrlc.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Input: gpio_mouse - fix typos in comments
Date:   Wed, 22 Jun 2022 14:21:00 +0800
Message-Id: <20220622062100.19490-1-jiangjian@cdjrlc.com>
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

Drop a redundant word 'the' in the comments of function gpio_mouse_scan.

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/input/mouse/gpio_mouse.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/mouse/gpio_mouse.c b/drivers/input/mouse/gpio_mouse.c
index 23507fce3a2b..18ccbd45004a 100644
--- a/drivers/input/mouse/gpio_mouse.c
+++ b/drivers/input/mouse/gpio_mouse.c
@@ -41,7 +41,7 @@ struct gpio_mouse {
 
 /*
  * Timer function which is run every scan_ms ms when the device is opened.
- * The dev input variable is set to the the input_dev pointer.
+ * The dev input variable is set to the input_dev pointer.
  */
 static void gpio_mouse_scan(struct input_dev *input)
 {
-- 
2.17.1

