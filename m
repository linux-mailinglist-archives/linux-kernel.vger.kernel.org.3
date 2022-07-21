Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1362157C771
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiGUJUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbiGUJUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:20:19 -0400
Received: from m12-13.163.com (m12-13.163.com [220.181.12.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6C2F5D116
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 02:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=3faKH
        9iZ1YE/3vFKw8FVWn94kkO5pkrMiSqboxAQq9U=; b=foRQjK37a9tnRPDHBqBb6
        B1vibPtvnyaKoAHuCbpUGyoVxo+sh0q0lB532vURPzm5Ijer5s/5/1pvoavmDfjX
        vX14JldW+OzZ52EUFpwZoOTaULYXm+1MKJIf5R4pabtOh2EDKKxLcTn2ssjHEcHJ
        Qnxjgqtu3ppNLTcnHF3zu8=
Received: from localhost.localdomain (unknown [223.104.68.234])
        by smtp9 (Coremail) with SMTP id DcCowAAXeQ5CGtliACBwRA--.54777S2;
        Thu, 21 Jul 2022 17:20:03 +0800 (CST)
From:   Slark Xiao <slark_xiao@163.com>
To:     jassisinghbrar@gmail.com
Cc:     linux-kernel@vger.kernel.org, Slark Xiao <slark_xiao@163.com>
Subject: [PATCH] mailbox: Fix typo 'the the' in comment
Date:   Thu, 21 Jul 2022 17:20:00 +0800
Message-Id: <20220721092000.51230-1-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DcCowAAXeQ5CGtliACBwRA--.54777S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZFWUWr1ruF17KF43urWrAFb_yoW3WFc_Gw
        1DXr4xuF40yFy5Krs0qayrZr12gayruryS9Fn5Kwnaq34xZrZFgryDJr4fJw47WwsrZFyF
        v3y8Aw1UAw17GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUj1lk5UUUUU==
X-Originating-IP: [223.104.68.234]
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCdQRFZGBbEbBJlwAAsU
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
 drivers/mailbox/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mailbox/Kconfig b/drivers/mailbox/Kconfig
index 05d6fae800e3..089ef39a71fa 100644
--- a/drivers/mailbox/Kconfig
+++ b/drivers/mailbox/Kconfig
@@ -66,7 +66,7 @@ config ARMADA_37XX_RWTM_MBOX
 	depends on ARCH_MVEBU || COMPILE_TEST
 	depends on OF
 	help
-	  Mailbox implementation for communication with the the firmware
+	  Mailbox implementation for communication with the firmware
 	  running on the Cortex-M3 rWTM secure processor of the Armada 37xx
 	  SOC. Say Y here if you are building for such a device (for example
 	  the Turris Mox router).
-- 
2.25.1

