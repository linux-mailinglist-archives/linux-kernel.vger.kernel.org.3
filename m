Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07F0578CF0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 23:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236076AbiGRVhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 17:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiGRVhM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 17:37:12 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF1E2C645
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:37:10 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id r2so17896307wrs.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 14:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcM5H7LuUZitM810U87o0MrCS82Ja03oEXoUJfTqLZY=;
        b=VCNsKWDEVGSOr0DAmTVUV+kKqkmZzWwuFY+4pOy87ryML5i3PJS9d0BQOaglD3oPh7
         nZ63sBJOqdDQURw0VKQvtr06U/Sa0Hb70A26EV6vK0klNSK1+vGCQdKeG+QRNjAzt+7V
         QKdtwCdbxsStYu8Q/st3ILHBdpMnkv2v7N8kDo2bkmEnxgayPgq76ecjRxVWlmd773VE
         q3OTRr7bIA/8KQ1dN+WkyfIqU1zg4aRMoyM8Mqg+mIOI3Kb3TwQLw1ExOgLVJXxMPSvC
         yb3RY9poDsyWQ2Em31/WRcjRBiazUMYhtTPiK+wA5mkULPIjew5b0Zw7VXJLvTAn8xF9
         JyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fcM5H7LuUZitM810U87o0MrCS82Ja03oEXoUJfTqLZY=;
        b=e8gk2PEAdOoYyBWdEgk/PC0h5gR+tH1iPzHRJhdCaCTNtKkQj/79c954WjggsatC7v
         Cm+k3BQZYMf/iiB/B5ejCXynlZKP8Ac8WWefTR4dzeO8FcpNuxJfXIsRvi3bBqZw9ck3
         sPLopWoNAWjS0xZo8k53O8b3bEtYywV7dro7A+7Eb6yp7pr0cIvXCo9tleJb75LH47ma
         hGviCCt3QjIBvSOoXVD0y2cXAyCnrZ7NfjWIVcsV51bOZ8p0Ae9dcxwT1xs/FqBRHxBX
         TXZ5aPzM+Cw/ONI9RTnqKZZpmAxBHQHZz6l0jcG8MUUmt45ahT16wQmtb9oDPkH6RdUi
         T8Qg==
X-Gm-Message-State: AJIora9cEvLcLLiNkcGYzJMRo5w7RmvyE7agZKgbmM3KbLJWL36cGQBg
        H8GROEAHKkSWRUzFPD2sypUlFQ==
X-Google-Smtp-Source: AGRyM1vBobWMgtTC2//bIax1kcof9pKqyUnqASrXceKn9r4UVb6G6Qqrt8Z2o3QIlsyhgI54nMvMIw==
X-Received: by 2002:a05:6000:702:b0:21d:7f65:f1b5 with SMTP id bs2-20020a056000070200b0021d7f65f1b5mr24197748wrb.555.1658180228794;
        Mon, 18 Jul 2022 14:37:08 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:496e:2d41:fd5a:4e5e])
        by smtp.gmail.com with ESMTPSA id ay10-20020a05600c1e0a00b003a32167b8d4sm991527wmb.13.2022.07.18.14.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 14:37:08 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de
Cc:     thierry.reding@gmail.com, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org, kkartik@nvidia.com
Subject: [PATCH] clocksource/drivers/tegra186: Put Kconfig option 'tristate' to 'bool'
Date:   Mon, 18 Jul 2022 23:36:57 +0200
Message-Id: <20220718213657.1303538-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocksource are built-in, not as module. We don't know if the core
time framework is ready for that.

Revert back this option to 'bool'.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 2dcdf02239c3..d7c7912cdd78 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -151,7 +151,7 @@ config TEGRA_TIMER
 	  Enables support for the Tegra driver.
 
 config TEGRA186_TIMER
-	tristate "NVIDIA Tegra186 timer driver"
+	bool "NVIDIA Tegra186 timer driver"
 	depends on ARCH_TEGRA || COMPILE_TEST
 	depends on WATCHDOG && WATCHDOG_CORE
 	help
-- 
2.25.1

