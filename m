Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BE7E4D6423
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 15:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349686AbiCKOyC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 09:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349439AbiCKOx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 09:53:57 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67B19BE63;
        Fri, 11 Mar 2022 06:52:53 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id u1so13292774wrg.11;
        Fri, 11 Mar 2022 06:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=zXbQhDsb4KeIHJF68pqLMN1JbVnR3P47zU5x8xmbukY=;
        b=BSANDLIqhwKqPBrb7Qys22MwnO6tUlv/4n97D6C6X5Xo7C0ubhSTuXrHjbCMsBJEm8
         vmPhN2Koys66YJNxCfSmp+wBXlE+eJuOg6kODRnr6pMIoth0zpdaqu1ilC64Fj0yKH38
         RthvqcRt3yNJAR9BT1UzW04Ux/o89D7N86AEIm7yZxKDtgFjLn4lzGWY8VLmAN/Bga+B
         pZsS9dpYySIl/qfRzxYPYGJifxR9SDNeBc5s8yJnJGVegL7LHXyPDgnQnOq0tH91dFW4
         8Evma8cK5v5z1t1ppjbgDxvCCen/LmKduf4oXjcfhNsNzMZ5mwu4BccW4yFxlUQ+zVk+
         dsUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zXbQhDsb4KeIHJF68pqLMN1JbVnR3P47zU5x8xmbukY=;
        b=FQpnxvQBqOGaidusiacIIH3+ws05K35pFlr7cfVLo39samG0QUV8089ly1gEyCefUe
         F2Rt6Gnbsqf+CkGbIodvzXfGw6ha5Nyctvd8XTiYCSHS14HhCA37Qinc5SvPmkqYu7GR
         /lJyMLVXRQiz9ZmpDhQFxqVHvxS3Q7enTQqXxNBgIhH/mz6ILiNwxmSF37TqAuQ0nRfV
         1WZCFnltcR3/ZLsL1vAmafkkoPe73yxBBHxiffg4osXXsEx01YD9GKmQWbxcEQo82alx
         7TQIzV+J4vzvpIhN+dmldZHs9GXWfSS4LO2ASTfwHpe+bimi/cDIx8XpMSOhZCDl8qH0
         CnYQ==
X-Gm-Message-State: AOAM530xFMZiKvA3TIwABDMmIrGCP8XNOCgt8+3LCjwoSUCzPIy2Juxr
        WFLgQkuO++IttE7rQpTrGYU=
X-Google-Smtp-Source: ABdhPJzHH8NgnMxZ4xQfDUIJUUso04P4Zd8QBxBCn/z6kuDzIy8sTogfhut+UHhuw2kIN85qtVoNrQ==
X-Received: by 2002:adf:fbd0:0:b0:1e6:8ec3:570 with SMTP id d16-20020adffbd0000000b001e68ec30570mr8040941wrs.396.1647010371688;
        Fri, 11 Mar 2022 06:52:51 -0800 (PST)
Received: from felia.fritz.box (200116b826a9a900147fc2a0771e144b.dip.versatel-1u1.de. [2001:16b8:26a9:a900:147f:c2a0:771e:144b])
        by smtp.gmail.com with ESMTPSA id n8-20020adf8b08000000b001f046cc8891sm7037812wra.24.2022.03.11.06.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 06:52:51 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] mfd: ab8500: clean up definitions in header after debugfs removal
Date:   Fri, 11 Mar 2022 15:52:09 +0100
Message-Id: <20220311145209.17346-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3d4d1266597c ("mfd: ab8500: Drop debugfs module") removes the config
AB8500_DEBUG in drivers/mfd/Kconfig, but missed a reference to this config
in include/linux/mfd/abx500/ab8500.h.

The functions ab8500_dump_all_banks() and ab8500_debug_register_interrupt()
in the ab8500 header, previously with definitions conditioned on
AB8500_DEBUG, are now completely needless to define and handle at all.

The function ab8500_debug_register_interrupt() is not used at all and can
just be removed.

The function ab8500_dump_all_banks() is just registered in the abx500_ops
struct in the dump_all_banks field, but this is then not further referenced
anywhere else at all. So, safely drop the dump_all_banks field from
abx500_ops and delete the ab8500_dump_all_banks() definition.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Linus, Lee, please pick this clean-up on top of the commit above.

 drivers/mfd/ab8500-core.c         | 3 +--
 include/linux/mfd/abx500.h        | 1 -
 include/linux/mfd/abx500/ab8500.h | 9 ---------
 3 files changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index 6a059270acdc..9049030a0c82 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -328,8 +328,7 @@ static struct abx500_ops ab8500_ops = {
 	.set_register_page = NULL,
 	.mask_and_set_register = ab8500_mask_and_set_register,
 	.event_registers_startup_state_get = NULL,
-	.startup_irq_enabled = NULL,
-	.dump_all_banks = ab8500_dump_all_banks,
+	.startup_irq_enabled = NULL
 };
 
 static void ab8500_irq_lock(struct irq_data *data)
diff --git a/include/linux/mfd/abx500.h b/include/linux/mfd/abx500.h
index 7f07cfe44753..507e3d2f062f 100644
--- a/include/linux/mfd/abx500.h
+++ b/include/linux/mfd/abx500.h
@@ -63,7 +63,6 @@ struct abx500_ops {
 	int (*mask_and_set_register) (struct device *, u8, u8, u8, u8);
 	int (*event_registers_startup_state_get) (struct device *, u8 *);
 	int (*startup_irq_enabled) (struct device *, unsigned int);
-	void (*dump_all_banks) (struct device *);
 };
 
 int abx500_register_ops(struct device *core_dev, struct abx500_ops *ops);
diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 302a330c5c84..42fd5da7d8a7 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -503,13 +503,4 @@ static inline int is_ab9540_2p0_or_earlier(struct ab8500 *ab)
 
 void ab8500_override_turn_on_stat(u8 mask, u8 set);
 
-#ifdef CONFIG_AB8500_DEBUG
-extern int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
-void ab8500_dump_all_banks(struct device *dev);
-void ab8500_debug_register_interrupt(int line);
-#else
-static inline void ab8500_dump_all_banks(struct device *dev) {}
-static inline void ab8500_debug_register_interrupt(int line) {}
-#endif
-
 #endif /* MFD_AB8500_H */
-- 
2.17.1

