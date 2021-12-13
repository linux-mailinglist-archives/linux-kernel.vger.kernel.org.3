Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A01472672
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 10:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237810AbhLMJwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 04:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbhLMJpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 04:45:39 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33872C08EB1F
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:57 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id k64so14398836pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 01:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+PLgOGUr24N3pCfDF0pm4vBw2jPEHVpOf1ojIAGQtAc=;
        b=TCXK6mvqNJC7RUZVwMT8njl9FfId+1tDmDUOhMpo9QmLfg9Idm63tAxC/8kUYCtSpa
         6w0N7qb/e01yjEnKfRFzcAS4fvSEIn8npxTL++nHc2ThpwxVe4DDU2IdLkRZMi5yYWdX
         7As7ZhM0Bd4P1WpM/rYtYMumJSeCAvzJnIsIY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+PLgOGUr24N3pCfDF0pm4vBw2jPEHVpOf1ojIAGQtAc=;
        b=DsDwdfIyM8WzpErP4lrsESY43HoV+O8K3DdXYxohP+jjoh5L5Pjc9jzWlF/0D54X4n
         nrV26tA90fj/U4y3/YBy9pL1owXYCturi8fLBcVME3x/K08MpE8LoMSdzLrcuKigWL6g
         yHr7ywtgfk9amau0YMsASvEzXQbO+DfdnDY/30H6hT0C1/QqCXkG/XXhTWbIxoy3IAA2
         uBa3ucNSuYWYX2IRxahzjy+MsEgwg9uXeGSjA8y8/y+z4mmzXo1PVqEBvOXcfhk/hPLk
         Tkqmquf3/dpqhQvhPoBMwGAOyfEkJQxgsMf1SC5CJbz24FYu5twC536GxNpHdwmd47Mf
         Fnvw==
X-Gm-Message-State: AOAM5334xDxUYtfCEYKkdr59QXOEdn7eZ0hUSJs+hKKIj85YFAw3wKVW
        LZ/dOu4Uvka3dmzQiBeiEHgQqA==
X-Google-Smtp-Source: ABdhPJwnIC/1GG8HGXvC3beYsltFQ8bMno1f7ktTReaDdiWgvDzepwh8gUYFEaTxeqRdekJDmu2ciQ==
X-Received: by 2002:a62:7803:0:b0:494:64ef:7bd7 with SMTP id t3-20020a627803000000b0049464ef7bd7mr32508766pfc.85.1639388456397;
        Mon, 13 Dec 2021 01:40:56 -0800 (PST)
Received: from shiro.work (p864106-ipngn200510sizuokaden.shizuoka.ocn.ne.jp. [180.9.58.106])
        by smtp.googlemail.com with ESMTPSA id d195sm10237609pga.41.2021.12.13.01.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 01:40:55 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v3 3/5] gpio: msc313: Code clean ups
Date:   Mon, 13 Dec 2021 18:40:34 +0900
Message-Id: <20211213094036.1787950-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211213094036.1787950-1-daniel@0x0f.com>
References: <20211213094036.1787950-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Remove the unneeded assignment of ret before returning it.
- Remove an unneeded blank line

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/gpio/gpio-msc313.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-msc313.c b/drivers/gpio/gpio-msc313.c
index da31a5ff7a2b..a894bafbd4c3 100644
--- a/drivers/gpio/gpio-msc313.c
+++ b/drivers/gpio/gpio-msc313.c
@@ -344,7 +344,6 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	struct irq_domain *parent_domain;
 	struct device_node *parent_node;
 	struct device *dev = &pdev->dev;
-	int ret;
 
 	match_data = of_device_get_match_data(dev);
 	if (!match_data)
@@ -399,8 +398,7 @@ static int msc313_gpio_probe(struct platform_device *pdev)
 	gpioirqchip->handler = handle_bad_irq;
 	gpioirqchip->default_type = IRQ_TYPE_NONE;
 
-	ret = devm_gpiochip_add_data(dev, gpiochip, gpio);
-	return ret;
+	return devm_gpiochip_add_data(dev, gpiochip, gpio);
 }
 
 static int msc313_gpio_remove(struct platform_device *pdev)
@@ -456,5 +454,4 @@ static struct platform_driver msc313_gpio_driver = {
 	.probe = msc313_gpio_probe,
 	.remove = msc313_gpio_remove,
 };
-
 builtin_platform_driver(msc313_gpio_driver);
-- 
2.34.1

