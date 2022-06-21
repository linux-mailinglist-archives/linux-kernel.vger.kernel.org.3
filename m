Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C223553681
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353009AbiFUPmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352981AbiFUPmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:42:40 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B642F2B27A;
        Tue, 21 Jun 2022 08:42:35 -0700 (PDT)
X-QQ-mid: bizesmtp84t1655826148tzkp4njf
Received: from ubuntu.localdomain ( [106.117.99.68])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 21 Jun 2022 23:42:24 +0800 (CST)
X-QQ-SSF: 0100000000700080B000E00A0000000
X-QQ-FEAT: HoyAXBWgsknanSWZcWN00IISLxs+jEQAg/Ts8xjC0YrVNWLL5zWmCO+pKLt/g
        HLqNsVNOLfPhRiOusn8F0tDBxlm3rR2YSKe/8WQ89s6Ob7ymF2SvdC6pbFQYrkAkzS2pcW7
        sZVSJ1rknkYrsjRpKerdjcBZ1f5zyLSQMaJer2MLRZAk/UPbS6S4qJH4ZcUM7W1qpe6DpwM
        EWc6yvZ8XN9bx/wM8icJVkeQEj3J/xG+VRS/8LrPnJLcKIQnSZhYxWcBYIUu6+oVyhulNBb
        9jkm03vwQ6lTXal8MuowaA0u1sQHU377NrPcJY1ryEHyi4+IK3UlYw5+4IUMj8qqqyIzmPH
        Vk+FPdB
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     robh+dt@kernel.org, frowand.list@gmail.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] of: device - Remove duplicate 'of' in two places.
Date:   Tue, 21 Jun 2022 23:42:22 +0800
Message-Id: <20220621154222.13714-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

file: ./drivers/of/device.c
line: 22
 * @matches: array of of device match structures to search in
changed to
 * @matches: array of device match structures to search in

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/of/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 874f031442dc..1582388156a9 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -19,7 +19,7 @@
 
 /**
  * of_match_device - Tell if a struct device matches an of_device_id list
- * @matches: array of of device match structures to search in
+ * @matches: array of device match structures to search in
  * @dev: the of device structure to match against
  *
  * Used by a driver to check whether an platform_device present in the
-- 
2.17.1

