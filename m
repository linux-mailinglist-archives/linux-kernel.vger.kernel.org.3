Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0573A479AEC
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 14:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbhLRNAt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 08:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233283AbhLRNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 08:00:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F6C061401
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 05:00:42 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so9416365wrd.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 05:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bFrG3jh1s5lAFnowWpm51QcHRy95WOWLO0hOKfLwkAQ=;
        b=h4X0nR9C/gIczMARHZo3uC+j/8Z2sId88Si8wlDGqCUt4kajYq+3wPntNdZyiy0fIX
         7S/+1HawPe87vjZtswRqbxXlQGZ6n9RT9cHanwSNaXlMvAq5G5qv7DZ+gFSeIV1ybF41
         VO+B5kODFNDtJMvvOax7rQHaSZFN6lVhWrOCWLI2UziVBb58Y+2hHA0yGp0tnr7WzBWE
         fNZPzY/lErvwKC+k1qE+ofcX7MIgLo8PPG66kaNErZrfrFuaR2WeV4aOq1l5vAB5btb3
         nTJgw2lAY55Jee6TEIeLOrWFc45Sd3yXJxxzf5cBYYOwWOFtbX+BT4IJ4nx7gRV+3DeZ
         rQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFrG3jh1s5lAFnowWpm51QcHRy95WOWLO0hOKfLwkAQ=;
        b=UBnnHbXbr//1yI57i8b0cvaX6QYfog8tmmnlDIZyjAvtfi9qI5n97U/15GK3x6lkTT
         ltjQ4HOETakWHJPONIcGAwXXcsMEgHWxLsuhCOE3y62bbLPDOJRl/IhrXQ6HuLwPpMtt
         IaJ+t2YvuyZBrZSQc2pg6Gd5xfRYFRQdwTsRZkuBYkMp8aFAOAZD0qCt3p/gqFEf43hw
         PVxa9AJEx2Vw4FuJOLQwOMXW4+f8SAeqBJ7h2d4sMrwA8TQWVzyM4y4QnrnmCsO9YB0p
         lfKDuJD/3sSUbDsbU48h8b4mBRVap3MOKQyB+nIJ7L82EO7HAtsWukM18wwtKjfAx0z4
         lKTw==
X-Gm-Message-State: AOAM532l+HNsCx+cTQxYIfrSNDVdXLDzbAXlrjOvuy+8VfNuym/mEmyI
        f52bKbLbL6XwqO2H7fgJVg1V9A==
X-Google-Smtp-Source: ABdhPJwQJq2AfoqfQVqk3a7iBERI4zg3RIYnxZCE9RJKE8RaDu3lhZqX9mQXoSWx5OoqfDCBv9GgdQ==
X-Received: by 2002:a05:6000:18ad:: with SMTP id b13mr6142117wri.195.1639832441000;
        Sat, 18 Dec 2021 05:00:41 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1f0f:c9b8:ee5c:5c2f])
        by smtp.gmail.com with ESMTPSA id j16sm1465785wms.12.2021.12.18.05.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Dec 2021 05:00:40 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rjw@rjwysocki.net
Cc:     lukasz.luba@arm.com, robh@kernel.org, heiko@sntech.de,
        arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/Rockchip SoC
        support),
        linux-rockchip@lists.infradead.org (open list:ARM/Rockchip SoC support)
Subject: [PATCH v5 5/6] rockchip/soc/drivers: Add DTPM description for rk3399
Date:   Sat, 18 Dec 2021 14:00:13 +0100
Message-Id: <20211218130014.4037640-6-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTPM framework does support now the hierarchy description.

The platform specific code can call the hierarchy creation function
with an array of struct dtpm_node pointing to their parent.

This patch provides a description of the big and Little CPUs and the
GPU and tie them together under a virtual package name. Only rk3399 is
described now.

The description could be extended in the future with the memory
controller with devfreq if it has the energy information.

The hierarchy uses the GPU devfreq with the panfrost driver, and this
one could be loaded as a module. If the hierarchy is created before
the panfrost driver is loaded, it will fail. For this reason the
Kconfig option depends on the panfrost Kconfig's option. If this one
is compiled as a module, automatically the dtpm hierarchy code will be
a module also. Module loading ordering will fix this chicken-egg
problem.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/soc/rockchip/Kconfig  |  8 +++++
 drivers/soc/rockchip/Makefile |  1 +
 drivers/soc/rockchip/dtpm.c   | 56 +++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 drivers/soc/rockchip/dtpm.c

diff --git a/drivers/soc/rockchip/Kconfig b/drivers/soc/rockchip/Kconfig
index 25eb2c1e31bb..a88fe6d3064a 100644
--- a/drivers/soc/rockchip/Kconfig
+++ b/drivers/soc/rockchip/Kconfig
@@ -34,4 +34,12 @@ config ROCKCHIP_PM_DOMAINS
 
           If unsure, say N.
 
+config ROCKCHIP_DTPM
+	tristate "Rockchip DTPM hierarchy"
+	depends on DTPM && DRM_PANFROST
+	help
+	 Describe the hierarchy for the Dynamic Thermal Power
+	 Management tree on this platform. That will create all the
+	 power capping capable devices.
+
 endif
diff --git a/drivers/soc/rockchip/Makefile b/drivers/soc/rockchip/Makefile
index 875032f7344e..05f31a4e743c 100644
--- a/drivers/soc/rockchip/Makefile
+++ b/drivers/soc/rockchip/Makefile
@@ -5,3 +5,4 @@
 obj-$(CONFIG_ROCKCHIP_GRF) += grf.o
 obj-$(CONFIG_ROCKCHIP_IODOMAIN) += io-domain.o
 obj-$(CONFIG_ROCKCHIP_PM_DOMAINS) += pm_domains.o
+obj-$(CONFIG_ROCKCHIP_DTPM) += dtpm.o
diff --git a/drivers/soc/rockchip/dtpm.c b/drivers/soc/rockchip/dtpm.c
new file mode 100644
index 000000000000..77edc565c110
--- /dev/null
+++ b/drivers/soc/rockchip/dtpm.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * DTPM hierarchy description
+ */
+#include <linux/dtpm.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+static struct dtpm_node __initdata rk3399_hierarchy[] = {
+	[0]{ .name = "rk3399" },
+	[1]{ .name = "package",
+	     .parent = &rk3399_hierarchy[0] },
+	[2]{ .name = "/cpus/cpu@0",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[3]{ .name = "/cpus/cpu@1",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[4]{ .name = "/cpus/cpu@2",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[5]{ .name = "/cpus/cpu@3",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[6]{ .name = "/cpus/cpu@100",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[7]{ .name = "/cpus/cpu@101",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[8]{ .name = "rockchip,rk3399-mali",
+	     .type = DTPM_NODE_DT,
+	     .parent = &rk3399_hierarchy[1] },
+	[9]{ },
+};
+
+static struct of_device_id __initdata rockchip_dtpm_match_table[] = {
+        { .compatible = "rockchip,rk3399", .data = rk3399_hierarchy },
+        {},
+};
+
+static int __init rockchip_dtpm_init(void)
+{
+	return dtpm_create_hierarchy(rockchip_dtpm_match_table);
+}
+late_initcall(rockchip_dtpm_init);
+
+MODULE_DESCRIPTION("Rockchip DTPM driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dtpm");
+MODULE_AUTHOR("Daniel Lezcano <daniel.lezcano@kernel.org");
-- 
2.25.1

