Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E444B51EE52
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 16:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234215AbiEHOuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 10:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiEHOuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 10:50:11 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B0AA1B4;
        Sun,  8 May 2022 07:46:20 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z19so13586904edx.9;
        Sun, 08 May 2022 07:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVozbydKoqpL/1R/q8/zXiCSBF+WnkNpgE75DzzSMhE=;
        b=f1uwoG0j7PprLpJsPc7sO0GeKbuiY/c+WAkisrhcJURHL95Kn4RELVGSzkZKE5PHVk
         w7nqXkUFatTxfveUgprKveTEuJQon6fbEWiJWjqf2OIaj8XC3TI/IBOmGa48zID7h+2Q
         ilAFcbiXIDAg4VnhoLPclZkx44ikUzRbskouwczdJtB0CF0iq7LovY5Sh5wXOG0lD1E6
         Ztj61VeTpHG66+G37s5sTw2DM/DBGN7tZnxVSlT35ivZNyY46iNswhNQZZRMIOHf75z6
         kNTNGWIyxWMdh14c2f5wSrJjrimTq4jYIVX2VVuTYeJBLuDCj03AavDeyMtQPpdSZ6fm
         ZTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yVozbydKoqpL/1R/q8/zXiCSBF+WnkNpgE75DzzSMhE=;
        b=eN+2xwJ5kfSsGD8dvW8qv/4WbwkPLi7PVJwP17hYQYOX5TnGJ5UUObCeiqdqxv7CA5
         +UVk4FAHlq7+0T1LwVzHO4ZpuSIS2iZQeao+5hsyytDk1Xnh4zywUCTopAzbHPPKcdEJ
         mpTgzzU80XlBJ1pFr8EhKICSTShbXP9yMreogJb2A2n8KW818WsqqSACicsdiKtToecB
         2d2O1eSJCwI6T/fcldj8L+Ng5bz0MN3sDmqI9PU1fwFzaZ/jNe/pyn4Hct8iRCeB5EJy
         YA0wL46OOcSvOOVBdM9re7YfkX32qw61LCMWgcUE/0R/hRoDvG4mDY6yhcnnEbOVyn90
         t2Kg==
X-Gm-Message-State: AOAM531iKJXdz1GKlKPjoJU58FW+e8EtyCgFodkHzazum1zR4BOfuqC/
        0P0KADyhl8555tiBeuQ/gSgKuHf4cHdxKA==
X-Google-Smtp-Source: ABdhPJxbAQMyAAXvrmdZ46Lt8wonE1TP7eCF2BLaBNu1iml/9eK5lcTlqBmR8JBgnAZvzE8/LLeI5A==
X-Received: by 2002:a05:6402:1592:b0:425:edec:992d with SMTP id c18-20020a056402159200b00425edec992dmr12699630edv.283.1652021179258;
        Sun, 08 May 2022 07:46:19 -0700 (PDT)
Received: from debian-gnu-linux-10.localdomain (dynamic-095-115-108-204.95.115.pool.telefonica.de. [95.115.108.204])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906140900b006f3ef214dcdsm4109383ejc.51.2022.05.08.07.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 07:46:18 -0700 (PDT)
From:   Karl Mehltretter <kmehltretter@gmail.com>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     Karl Mehltretter <kmehltretter@gmail.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hwmon: (lm83) Remove unused include directives
Date:   Sun,  8 May 2022 16:46:01 +0200
Message-Id: <20220508144601.22796-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some include directives are no longer necessary due to previous driver
changes. Remove them now to further improve driver code clarity.

Mutex usage has ceased since commit 719af4f1a40b ("hwmon: (lm83) Use
regmap").

Ever since commit a0ac840d99fa ("hwmon: (lm83) Convert to use
devm_hwmon_device_register_with_groups") functions sysfs_create_group
and sysfs_remove_group are no longer used by the driver.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/hwmon/lm83.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/lm83.c b/drivers/hwmon/lm83.c
index 12370dcef..905f5689f 100644
--- a/drivers/hwmon/lm83.c
+++ b/drivers/hwmon/lm83.c
@@ -24,10 +24,8 @@
 #include <linux/init.h>
 #include <linux/hwmon.h>
 #include <linux/module.h>
-#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
-#include <linux/sysfs.h>
 
 /*
  * Addresses to scan
-- 
2.20.1

