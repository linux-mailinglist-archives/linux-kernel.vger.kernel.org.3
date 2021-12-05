Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB01C468E11
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:17:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241138AbhLEXVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241121AbhLEXUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:20:00 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504E5C061D5F
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:16:32 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id c4so18596321wrd.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 15:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fWuS4fsoE295izAUB6ZNtsBDKP7xWapSH98WYNQuHlc=;
        b=mKH01d/1LEslm2VcVdUh0Uf1LmXkfi8RgV20iu7I3e80lrOkFzG6jhWGyyIRdkoVXX
         IOffNKXZCbrb6P0aazQ5H8Kv5L9suLhKhYIEPDqjYRGI8EBAAv3xXYn3k3RaIsv33hGv
         0JP4dQR7GfdJIhCVL5Ix7FSwKeKIn3fxsN1/FW+iZrxAhyj/16RzRwz17htTBD3uzptr
         NvrIar9wN7i4UVz2jvXJTrdEm04jh7M3oBMMjNKFnh/UWTXLrn0+g4c2nRTw9uHz8Lkt
         OrsmIDcQr3WRM1Ade58I04m+d5eZFrcdRqFMzs9s07rIxC4WO31t5t8NV9W6jtVyyBYK
         s8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fWuS4fsoE295izAUB6ZNtsBDKP7xWapSH98WYNQuHlc=;
        b=EnRpoRQS2luBHz6/IiQqnBKPQ1DxeLhXWxd0fNPNdbTtPd7d6yQyz4u+BThxkMJ1wx
         8Z5KoDyysF5jl3abTPgnf8kNQNpWrfTeCg+k1Wslk1/Mqe7uXLdoOsH+7KKOdpcOR6bD
         cQyGHpVJXi6FMeQJVK8dVYO7LoC/e76GrWZldmHIpwHZWFou/rJ1OoexnNFqYRz0ZA+F
         de6nQ5KpUKwc3tw+WuvLG/V0Kw9ng6c1Ka75GE0YaHDZUJ5ikXdoUqJfDLVdzGkZZMz7
         cGnNu1Xz3kzeaprmxIoIr/zPxH+A/ExDAbRMQQ8tAj4OZXKiFTRAUTYkOF4s6/3qqcK7
         YcCw==
X-Gm-Message-State: AOAM533+oXkIHoKVExFIA2qxe+9ntAgjPN2D2X+k2EsxcPmSjAEMrfsD
        LT+oOGjWBNwTE0CgCr0P09IemQ==
X-Google-Smtp-Source: ABdhPJzG8iSh53R4eaNFgzlwXBsReAOb4tRo1rNoBX3qOaJR4toiC2oDHs3yF4TC/PYnKNmKJDrZQA==
X-Received: by 2002:adf:d1e2:: with SMTP id g2mr39594535wrd.179.1638746190796;
        Sun, 05 Dec 2021 15:16:30 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1cec:4235:bb04:b944])
        by smtp.gmail.com with ESMTPSA id c10sm10715312wrb.81.2021.12.05.15.16.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:16:30 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, robh@kernel.org
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Chanwoo Choi <cwchoi00@gmail.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Subject: [PATCH v4 5/5] powercap/drivers/dtpm: Add dtpm devfreq with energy model support
Date:   Mon,  6 Dec 2021 00:15:57 +0100
Message-Id: <20211205231558.779698-5-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211205231558.779698-1-daniel.lezcano@linaro.org>
References: <20211205231558.779698-1-daniel.lezcano@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dtpm supports the CPUs via cpufreq and the energy
model. This change provides the same for the device which supports
devfreq.

Each device supporting devfreq and having an energy model will be
added to the hierarchy if the corresponding powerzone is described in
the DT.

The concept is the same as the cpufreq DTPM support: the QoS is used
to aggregate the requests and the energy model gives the value of the
instantaneous power consumption ponderated by the load of the device.

Cc: Chanwoo Choi <cwchoi00@gmail.com>
Cc: Lukasz Luba <lukasz.luba@arm.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V2:
     - Fixed missing prototype warning reported by lkp@
   V1: Initial post
---
 drivers/powercap/Kconfig        |   7 ++
 drivers/powercap/Makefile       |   1 +
 drivers/powercap/dtpm_devfreq.c | 201 ++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 drivers/powercap/dtpm_devfreq.c

diff --git a/drivers/powercap/Kconfig b/drivers/powercap/Kconfig
index b1ca339957e3..515e3ceb3393 100644
--- a/drivers/powercap/Kconfig
+++ b/drivers/powercap/Kconfig
@@ -57,4 +57,11 @@ config DTPM_CPU
 	help
 	  This enables support for CPU power limitation based on
 	  energy model.
+
+config DTPM_DEVFREQ
+	bool "Add device power capping based on the energy model"
+	depends on DTPM && ENERGY_MODEL
+	help
+	  This enables support for device power limitation based on
+	  energy model.
 endif
diff --git a/drivers/powercap/Makefile b/drivers/powercap/Makefile
index fabcf388a8d3..494617cdad88 100644
--- a/drivers/powercap/Makefile
+++ b/drivers/powercap/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-$(CONFIG_DTPM) += dtpm.o
 obj-$(CONFIG_DTPM_CPU) += dtpm_cpu.o
+obj-$(CONFIG_DTPM_DEVFREQ) += dtpm_devfreq.o
 obj-$(CONFIG_POWERCAP)	+= powercap_sys.o
 obj-$(CONFIG_INTEL_RAPL_CORE) += intel_rapl_common.o
 obj-$(CONFIG_INTEL_RAPL) += intel_rapl_msr.o
diff --git a/drivers/powercap/dtpm_devfreq.c b/drivers/powercap/dtpm_devfreq.c
new file mode 100644
index 000000000000..a1273eb54e80
--- /dev/null
+++ b/drivers/powercap/dtpm_devfreq.c
@@ -0,0 +1,201 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright 2021 Linaro Limited
+ *
+ * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
+ *
+ * The devfreq device combined with the energy model and the load can
+ * give an estimation of the power consumption as well as limiting the
+ * power.
+ *
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpumask.h>
+#include <linux/devfreq.h>
+#include <linux/dtpm.h>
+#include <linux/energy_model.h>
+#include <linux/of.h>
+#include <linux/pm_qos.h>
+#include <linux/slab.h>
+#include <linux/units.h>
+
+struct dtpm_devfreq {
+	struct dtpm dtpm;
+	struct dev_pm_qos_request qos_req;
+	struct devfreq *devfreq;
+};
+
+static struct dtpm_devfreq *to_dtpm_devfreq(struct dtpm *dtpm)
+{
+	return container_of(dtpm, struct dtpm_devfreq, dtpm);
+}
+
+static int update_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+
+	dtpm->power_min = pd->table[0].power;
+	dtpm->power_min *= MICROWATT_PER_MILLIWATT;
+
+	dtpm->power_max = pd->table[pd->nr_perf_states - 1].power;
+	dtpm->power_max *= MICROWATT_PER_MILLIWATT;
+
+	return 0;
+}
+
+static u64 set_pd_power_limit(struct dtpm *dtpm, u64 power_limit)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+	unsigned long freq;
+	u64 power;
+	int i;
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		if (power > power_limit)
+			break;
+	}
+
+	freq = pd->table[i - 1].frequency;
+
+	dev_pm_qos_update_request(&dtpm_devfreq->qos_req, freq);
+
+	power_limit = pd->table[i - 1].power * MICROWATT_PER_MILLIWATT;
+
+	return power_limit;
+}
+
+static void _normalize_load(struct devfreq_dev_status *status)
+{
+	if (status->total_time > 0xfffff) {
+		status->total_time >>= 10;
+		status->busy_time >>= 10;
+	}
+
+	status->busy_time <<= 10;
+	status->busy_time /= status->total_time ? : 1;
+
+	status->busy_time = status->busy_time ? : 1;
+	status->total_time = 1024;
+}
+
+static u64 get_pd_power_uw(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+	struct devfreq *devfreq = dtpm_devfreq->devfreq;
+	struct device *dev = devfreq->dev.parent;
+	struct em_perf_domain *pd = em_pd_get(dev);
+	struct devfreq_dev_status status;
+	unsigned long freq;
+	u64 power;
+	int i;
+
+	mutex_lock(&devfreq->lock);
+	status = devfreq->last_status;
+	mutex_unlock(&devfreq->lock);
+
+	freq = DIV_ROUND_UP(status.current_frequency, HZ_PER_KHZ);
+	_normalize_load(&status);
+
+	for (i = 0; i < pd->nr_perf_states; i++) {
+
+		if (pd->table[i].frequency < freq)
+			continue;
+
+		power = pd->table[i].power * MICROWATT_PER_MILLIWATT;
+		power *= status.busy_time;
+		power >>= 10;
+
+		return power;
+	}
+
+	return 0;
+}
+
+static void pd_release(struct dtpm *dtpm)
+{
+	struct dtpm_devfreq *dtpm_devfreq = to_dtpm_devfreq(dtpm);
+
+	if (dev_pm_qos_request_active(&dtpm_devfreq->qos_req))
+		dev_pm_qos_remove_request(&dtpm_devfreq->qos_req);
+
+	kfree(dtpm_devfreq);
+}
+
+static struct dtpm_ops dtpm_ops = {
+	.set_power_uw = set_pd_power_limit,
+	.get_power_uw = get_pd_power_uw,
+	.update_power_uw = update_pd_power_uw,
+	.release = pd_release,
+};
+
+static int __dtpm_devfreq_setup(struct devfreq *devfreq, struct dtpm *parent)
+{
+	struct device *dev = devfreq->dev.parent;
+	struct dtpm_devfreq *dtpm_devfreq;
+	struct em_perf_domain *pd;
+	int ret = -ENOMEM;
+
+	pd = em_pd_get(dev);
+	if (!pd) {
+		ret = dev_pm_opp_of_register_em(dev, NULL);
+		if (ret) {
+			pr_err("No energy model available for '%s'\n", dev_name(dev));
+			return -EINVAL;
+		}
+	}
+
+	dtpm_devfreq = kzalloc(sizeof(*dtpm_devfreq), GFP_KERNEL);
+	if (!dtpm_devfreq)
+		return -ENOMEM;
+
+	dtpm_init(&dtpm_devfreq->dtpm, &dtpm_ops);
+
+	dtpm_devfreq->devfreq = devfreq;
+
+	ret = dtpm_register(dev_name(dev), &dtpm_devfreq->dtpm, parent);
+	if (ret) {
+		pr_err("Failed to register '%s': %d\n", dev_name(dev), ret);
+		goto out_dtpm_devfreq;
+	}
+
+	ret = dev_pm_qos_add_request(dev, &dtpm_devfreq->qos_req,
+				     DEV_PM_QOS_MAX_FREQUENCY,
+				     PM_QOS_MAX_FREQUENCY_DEFAULT_VALUE);
+	if (ret) {
+		pr_err("Failed to add QoS request: %d\n", ret);
+		goto out_dtpm_unregister;
+	}
+
+	dtpm_update_power(&dtpm_devfreq->dtpm);
+
+	return 0;
+
+out_dtpm_unregister:
+	dtpm_unregister(&dtpm_devfreq->dtpm);
+out_dtpm_devfreq:
+	kfree(dtpm_devfreq);
+
+	return ret;
+}
+
+static int __init dtpm_devfreq_setup(struct dtpm *dtpm, struct device_node *np)
+{
+	struct devfreq *devfreq;
+
+	devfreq = devfreq_get_devfreq_by_node(np);
+	if (IS_ERR(devfreq))
+		return 0;
+
+	return __dtpm_devfreq_setup(devfreq, dtpm);
+}
+
+DTPM_DECLARE(dtpm_dev, NULL, dtpm_devfreq_setup);
-- 
2.25.1

