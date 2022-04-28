Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53FA512FAF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiD1Jtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiD1Jgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:36:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C4195486;
        Thu, 28 Apr 2022 02:33:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id u6-20020a17090a1f0600b001d86bd69427so3876822pja.5;
        Thu, 28 Apr 2022 02:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NM66A5OAYldkjcIb7EpGVNaXhKoeVCq/L19afQaEiL8=;
        b=hh5ezwk8i9ar3NTDhQHy0zyGei9208iSfcYM4YKq7O7K0RrZv8nlLNVmZC5WZjFeyG
         wSX/vbgQt2Owd+lFxbpKWcSA8srI+fqG+qf+la3Z5DnRkViqZk9izZXHExD0DrFrdU6g
         znQ5hG8nP1Qm/IlUv5O9ZnAEjDc0HzgE7Joasu9VCfXtqikXU5Mf1J6AjzQuQCYMFEJX
         8XnAzmx4tNgZn8QLBihX54lO8xfa9WhADOdlOAG/dWZIgCLDmQ7YEYe4LKRiFPa2NU6z
         rjv+mv8su9wKGjN9xhgry1eXts98AoZqtZSFfEafhAowpMyfOrW4ALy/NGCPxvkZWxoh
         4Cfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NM66A5OAYldkjcIb7EpGVNaXhKoeVCq/L19afQaEiL8=;
        b=V1BfJDNxJwk/vt0o9D8Y81/BdVUlIS2khedUccd/9TB5uv5nrbJ5YsBX21zRUu23SK
         Lv3NK0AjH5GsrAHvLOKOEwIQqw8v9P3QaU3SUWrTJHT0JqpsOoOkxpNKXRnMGYriEF4j
         TW8zT/hCNAv4asOi6gFxlJG5jCm4ND2G0lj2Ci/jdDZR1TIHS+i5kZnRwyN40MEaMypc
         Yl+90A+6qiuW0LRQ5HhGJOomknEiNZU+lspSqREx7UbvAX50i5PYhSspJtdgzcmXibuV
         gzq637OC0zmes+gSPw7ngOAQXGVAajDdgIhfM+lB4jRlNgg3eYptjA8y4YcdLBfgn98Q
         WvXw==
X-Gm-Message-State: AOAM533gwMHMLhypRTVIUwIGQMm2wnJwCg98iJlFOAwD8cFYiv5odDXV
        NBMUuND72RoOzqIHmoseciw=
X-Google-Smtp-Source: ABdhPJy/iXJqbVKjkw099C2uzmg24SKXb49S4CmFSCjXdPCaT9YW/nJ4DtvBfrGPZAG8YdZqZYDZvw==
X-Received: by 2002:a17:902:8c81:b0:156:7fee:643b with SMTP id t1-20020a1709028c8100b001567fee643bmr32899635plo.59.1651138398072;
        Thu, 28 Apr 2022 02:33:18 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:569:2b1f:d169:337e:6359:8ff7])
        by smtp.gmail.com with ESMTPSA id i66-20020a628745000000b0050d36a5fe70sm15457932pfe.127.2022.04.28.02.33.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 02:33:17 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     pavel@ucw.cz, matthias.bgg@gmail.com
Cc:     cy_huang@richtek.com, jacek.anaszewski@gmail.com,
        gene_chen@richtek.com, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] leds: flash: mt6360: Remove unused dependency in Kconfig
Date:   Thu, 28 Apr 2022 17:32:43 +0800
Message-Id: <1651138365-17362-3-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
References: <1651138365-17362-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Kconfig already guarantee LED_CLASS_FLASH will be selected.
Remove useless dependency for LEDS_CLASS/LEDS_CLASS_FLASH.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---
 drivers/leds/flash/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index d3eb689..38b325c 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -50,8 +50,7 @@ config LEDS_MAX77693
 
 config LEDS_MT6360
 	tristate "LED Support for Mediatek MT6360 PMIC"
-	depends on LEDS_CLASS && OF
-	depends on LEDS_CLASS_FLASH || !LEDS_CLASS_FLASH
+	depends on OF
 	depends on LEDS_CLASS_MULTICOLOR || !LEDS_CLASS_MULTICOLOR
 	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
 	depends on MFD_MT6360
-- 
2.7.4

