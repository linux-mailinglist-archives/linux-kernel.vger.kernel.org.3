Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8357657DEFD
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 12:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234675AbiGVJmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 05:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236688AbiGVJmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 05:42:15 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A2AF18E24;
        Fri, 22 Jul 2022 02:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=m1ECV
        qdnL9vLFAtg52t07cQoiFeiu+2qVlTbmuFFzyo=; b=R/NwpOBKUEajhZvsZNQbU
        HUH7IAWpE4JsXZ4anRX+3UZqaBRJIUQuki7IkIXePm7RLm/whwh34Z+IvjzsCE0J
        4pmZ24CWCxHPij+RdnDiVzbptk6x4M9K1inIQdYxdlx0eZQXFnTbDvfI842y4Amq
        XGmp1DP7zEkp7fLe+QxooA=
Received: from localhost.localdomain (unknown [112.97.59.29])
        by smtp3 (Coremail) with SMTP id G9xpCgCXZoCtbtpilxCSQg--.20714S2;
        Fri, 22 Jul 2022 17:32:30 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc:     linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] rtc: rs5c372: Fix typo 'the the' in comment
Date:   Fri, 22 Jul 2022 17:32:27 +0800
Message-Id: <20220722093227.77577-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgCXZoCtbtpilxCSQg--.20714S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1xtFy8Xw4ruw4rXwb_yoW3WFXEk3
        yfA34Ika1vvrs3Kw4UZrn5urWF9a1rWrn8Ar18Kasav3y3ur47Ja4kZrsrJr1YqrW5tF9x
        WrZ3X34kC3WUWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJb1jDUUUUU==
X-Originating-IP: [112.97.59.29]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/1tbiGRpGZFyPdmzQ2QABsg
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
 drivers/rtc/rtc-rs5c372.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-rs5c372.c b/drivers/rtc/rtc-rs5c372.c
index cb15983383f5..8d551e15b91a 100644
--- a/drivers/rtc/rtc-rs5c372.c
+++ b/drivers/rtc/rtc-rs5c372.c
@@ -150,7 +150,7 @@ static int rs5c_get_regs(struct rs5c372 *rs5c)
 	 * least 80219 chips; this works around that bug.
 	 *
 	 * The third method on the other hand doesn't work for the SMBus-only
-	 * configurations, so we use the the first method there, stripping off
+	 * configurations, so we use the first method there, stripping off
 	 * the extra register in the process.
 	 */
 	if (rs5c->smbus) {
-- 
2.25.1

