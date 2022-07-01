Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9115563654
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 16:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231529AbiGAO66 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 10:58:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiGAO6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 10:58:45 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B17A4201BD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 07:58:43 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id n16-20020a17090ade9000b001ed15b37424so2929519pjv.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 07:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hIdc06536EvjjLsoqRfohQ/ZCe/C8j+YPNHn85t6hM=;
        b=q7HWIMZvh60Apx4LQTpxKWOE9Dj+2VLr/WjgoxYJVQbxtAfKniIJTNEZOGBor5b259
         to2xcpGKJOZ0WGpGDFVMUxBOuVKQm7bUqIfLBDIjEfUaMLBHpFiN6HVsV+oiBWKiCFgC
         E32Zvk8/w9QPCrCyO6DpQTJXvk8NyecUo9YL99/bfUHVdSJZEDyO5DpCXbi99M7L2e47
         5zzSIFD3IugLHDmSYp/kd0jL0KtZUgaQSJXFZ/XTQ8A/65Gb1IYzlIDOptJMJsYoHdth
         mHQDKE6CfqOtDiYqgIR/MAXo78FpHFsQW79CHleg9mDB+t60loU86Lr8t0yxm3acjY/U
         0+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hIdc06536EvjjLsoqRfohQ/ZCe/C8j+YPNHn85t6hM=;
        b=UvfWi/qtY6JRcvQBTUvkwYeKgOfcogvVCvItpkVZYr86DRyLW/IjhJRQgjuW6JpGz0
         f2MIaSzgdmUXUxIY2d86JK7kpIx2iI0wgtPWGxHg9HPDwDi9xWZ1JowqWsa0/ngM57Hg
         7zP/1meCKvVRECOSY3Q5hNrESUcTaZigcVQjIrfMD9QuEoT8uT3HSsoJqKAW9K14tacb
         Rjdt7/liLsxBuoiaac6YoTciqTpTAs+Q0GlfyEuk30yluVZHoZUzw4HdtzpxI3BvUHlZ
         bvvGDnLxKfk7thKD/wwq+2hY/1Asc3EZp62aRwSQesDs77fZYrPBHRj1c+EqZia7lxqU
         tRMw==
X-Gm-Message-State: AJIora/B0fp/iHdM8qXdQ9JayBGLAWEOGQgAjNt9smZzx6eKFKHCn4WU
        reDBDhY4ovhv5A5VGT7er34Uyg==
X-Google-Smtp-Source: AGRyM1s6jUyThf3G/awD0LL8w9JOibyTggJ9r61XRVP4tSdpRtCH7ARM7+JuOcI1IOzbj56ZpQuUNg==
X-Received: by 2002:a17:90b:33cc:b0:1ec:b279:69fa with SMTP id lk12-20020a17090b33cc00b001ecb27969famr19551091pjb.70.1656687523352;
        Fri, 01 Jul 2022 07:58:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1c5e:e6c0:8e75:c988:f80f:8bec])
        by smtp.gmail.com with ESMTPSA id y19-20020a170902e19300b0016b844cd7e9sm9641399pla.115.2022.07.01.07.58.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 07:58:43 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-pm@vger.kernel.org
Cc:     bhupesh.sharma@linaro.org, bhupesh.linux@gmail.com,
        linux-kernel@vger.kernel.org, bjorn.andersson@linaro.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 3/3] thermal: qcom: tsens: Implement re-initialization workaround quirk
Date:   Fri,  1 Jul 2022 20:28:15 +0530
Message-Id: <20220701145815.2037993-4-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
References: <20220701145815.2037993-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since for some QCoM tsens controllers, its suggested to
monitor the controller health periodically and in case an
issue is detected, to re-initialize the tsens controller
via trustzone, add the support for the same in the
qcom tsens driver.

Note that Once the tsens controller is reset using scm call,
all SROT and TM region registers will enter the reset mode.

While all the SROT registers will be re-programmed and
re-enabled in trustzone prior to the scm call exit, the TM
region registers will not re-initialized in trustzone and thus
need to be handled by the tsens driver.

Cc: Amit Kucheria <amitk@kernel.org>
Cc: Thara Gopinath <thara.gopinath@gmail.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 drivers/thermal/qcom/tsens-v2.c |   3 +
 drivers/thermal/qcom/tsens.c    | 237 +++++++++++++++++++++++++++++++-
 drivers/thermal/qcom/tsens.h    |   6 +
 3 files changed, 239 insertions(+), 7 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index 61d38a56d29a..9bb542f16482 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -88,6 +88,9 @@ static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 
 	/* TRDY: 1=ready, 0=in progress */
 	[TRDY] = REG_FIELD(TM_TRDY_OFF, 0, 0),
+
+	/* FIRST_ROUND_COMPLETE: 1=complete, 0=not complete */
+	[FIRST_ROUND_COMPLETE] = REG_FIELD(TM_TRDY_OFF, 3, 3),
 };
 
 static const struct tsens_ops ops_generic_v2 = {
diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index 97f4d4454f20..28d42ae0eb47 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -7,6 +7,7 @@
 #include <linux/debugfs.h>
 #include <linux/err.h>
 #include <linux/io.h>
+#include <linux/qcom_scm.h>
 #include <linux/module.h>
 #include <linux/nvmem-consumer.h>
 #include <linux/of.h>
@@ -21,6 +22,8 @@
 #include "../thermal_hwmon.h"
 #include "tsens.h"
 
+LIST_HEAD(tsens_device_list);
+
 /**
  * struct tsens_irq_data - IRQ status and temperature violations
  * @up_viol:        upper threshold violated
@@ -594,19 +597,159 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 	regmap_field_write(priv->rf[INT_EN], 0);
 }
 
+static int tsens_reenable_hw_after_scm(struct tsens_priv *priv)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->ul_lock, flags);
+
+	/* Re-enable watchdog, unmask the bark and
+	 * disable cycle completion monitoring.
+	 */
+	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 1);
+	regmap_field_write(priv->rf[WDOG_BARK_CLEAR], 0);
+	regmap_field_write(priv->rf[WDOG_BARK_MASK], 0);
+	regmap_field_write(priv->rf[CC_MON_MASK], 1);
+
+	/* Re-enable interrupts */
+	tsens_enable_irq(priv);
+
+	spin_unlock_irqrestore(&priv->ul_lock, flags);
+
+	return 0;
+}
+
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
-	struct tsens_priv *priv = s->priv;
+	struct tsens_priv *priv = s->priv, *priv_reinit;
 	int hw_id = s->hw_id;
 	u32 temp_idx = LAST_TEMP_0 + hw_id;
 	u32 valid_idx = VALID_0 + hw_id;
 	u32 valid;
-	int ret;
+	int ret, trdy, first_round, tsens_ret, sw_reg;
+	unsigned long timeout;
+	static atomic_t in_tsens_reinit;
 
 	/* VER_0 doesn't have VALID bit */
 	if (tsens_version(priv) == VER_0)
 		goto get_temp;
 
+	/* For some tsens controllers, its suggested to
+	 * monitor the controller health periodically
+	 * and in case an issue is detected to reinit
+	 * tsens controller via trustzone.
+	 */
+	if (priv->needs_reinit_wa) {
+		/* First check if TRDY is SET */
+		timeout = jiffies + usecs_to_jiffies(TIMEOUT_US);
+		do {
+			ret = regmap_field_read(priv->rf[TRDY], &trdy);
+			if (ret)
+				goto err;
+			if (!trdy)
+				continue;
+		} while (time_before(jiffies, timeout));
+
+		if (!trdy) {
+			ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE], &first_round);
+			if (ret)
+				goto err;
+
+			if (!first_round) {
+				if (atomic_read(&in_tsens_reinit)) {
+					dev_dbg(priv->dev, "tsens re-init is in progress\n");
+					ret = -EAGAIN;
+					goto err;
+				}
+
+				/* Wait for 2 ms for tsens controller to recover */
+				timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
+				do {
+					ret = regmap_field_read(priv->rf[FIRST_ROUND_COMPLETE],
+								&first_round);
+					if (ret)
+						goto err;
+
+					if (first_round) {
+						dev_dbg(priv->dev, "tsens controller recovered\n");
+						goto sensor_read;
+					}
+				} while (time_before(jiffies, timeout));
+
+				/*
+				 * tsens controller did not recover,
+				 * proceed with SCM call to re-init it
+				 */
+				if (atomic_read(&in_tsens_reinit)) {
+					dev_dbg(priv->dev, "tsens re-init is in progress\n");
+					ret = -EAGAIN;
+					goto err;
+				}
+
+				atomic_set(&in_tsens_reinit, 1);
+
+				/*
+				 * Invoke scm call only if SW register write is
+				 * reflecting in controller. Try it for 2 ms.
+				 */
+				timeout = jiffies + msecs_to_jiffies(RESET_TIMEOUT_MS);
+				do {
+					ret = regmap_field_write(priv->rf[INT_EN], BIT(2));
+					if (ret)
+						goto err_unset;
+
+					ret = regmap_field_read(priv->rf[INT_EN], &sw_reg);
+					if (ret)
+						goto err_unset;
+
+					if (!(sw_reg & BIT(2)))
+						continue;
+				} while (time_before(jiffies, timeout));
+
+				if (!(sw_reg & BIT(2))) {
+					ret = -ENOTRECOVERABLE;
+					goto err_unset;
+				}
+
+				ret = qcom_scm_tsens_reinit(&tsens_ret);
+				if (ret || tsens_ret) {
+					dev_err(priv->dev, "tsens reinit scm call failed (%d : %d)\n",
+							ret, tsens_ret);
+					if (tsens_ret)
+						ret = -ENOTRECOVERABLE;
+
+					goto err_unset;
+				}
+
+				/* After the SCM call, we need to re-enable
+				 * the interrupts and also set active threshold
+				 * for each sensor.
+				 */
+				list_for_each_entry(priv_reinit,
+						&tsens_device_list, list) {
+					ret = tsens_reenable_hw_after_scm(priv_reinit);
+					if (ret) {
+						dev_err(priv->dev,
+							"tsens re-enable after scm call failed (%d)\n",
+							ret);
+						ret = -ENOTRECOVERABLE;
+						goto err_unset;
+					}
+				}
+
+				atomic_set(&in_tsens_reinit, 0);
+
+				/* Notify reinit wa worker */
+				list_for_each_entry(priv_reinit,
+						&tsens_device_list, list) {
+					queue_work(priv_reinit->reinit_wa_worker,
+							&priv_reinit->reinit_wa_notify);
+				}
+			}
+		}
+	}
+
+sensor_read:
 	/* Valid bit is 0 for 6 AHB clock cycles.
 	 * At 19.2MHz, 1 AHB clock is ~60ns.
 	 * We should enter this loop very, very rarely.
@@ -623,6 +766,12 @@ int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 	*temp = tsens_hw_to_mC(s, temp_idx);
 
 	return 0;
+
+err_unset:
+	atomic_set(&in_tsens_reinit, 0);
+
+err:
+	return ret;
 }
 
 int get_temp_common(const struct tsens_sensor *s, int *temp)
@@ -860,6 +1009,14 @@ int __init init_common(struct tsens_priv *priv)
 		goto err_put_device;
 	}
 
+	priv->rf[FIRST_ROUND_COMPLETE] = devm_regmap_field_alloc(dev,
+								priv->tm_map,
+								priv->fields[FIRST_ROUND_COMPLETE]);
+	if (IS_ERR(priv->rf[FIRST_ROUND_COMPLETE])) {
+		ret = PTR_ERR(priv->rf[FIRST_ROUND_COMPLETE]);
+		goto err_put_device;
+	}
+
 	/* This loop might need changes if enum regfield_ids is reordered */
 	for (j = LAST_TEMP_0; j <= UP_THRESH_15; j += 16) {
 		for (i = 0; i < priv->feat->max_sensors; i++) {
@@ -1097,6 +1254,43 @@ static int tsens_register(struct tsens_priv *priv)
 	return ret;
 }
 
+static void tsens_reinit_worker_notify(struct work_struct *work)
+{
+	int i, ret, temp;
+	struct tsens_irq_data d;
+	struct tsens_priv *priv = container_of(work, struct tsens_priv,
+					       reinit_wa_notify);
+
+	for (i = 0; i < priv->num_sensors; i++) {
+		const struct tsens_sensor *s = &priv->sensor[i];
+		u32 hw_id = s->hw_id;
+
+		if (!s->tzd)
+			continue;
+		if (!tsens_threshold_violated(priv, hw_id, &d))
+			continue;
+
+		ret = get_temp_tsens_valid(s, &temp);
+		if (ret) {
+			dev_err(priv->dev, "[%u] %s: error reading sensor\n",
+				hw_id, __func__);
+			continue;
+		}
+
+		tsens_read_irq_state(priv, hw_id, s, &d);
+
+		if ((d.up_thresh < temp) || (d.low_thresh > temp)) {
+			dev_dbg(priv->dev, "[%u] %s: TZ update trigger (%d mC)\n",
+				hw_id, __func__, temp);
+			thermal_zone_device_update(s->tzd,
+						   THERMAL_EVENT_UNSPECIFIED);
+		} else {
+			dev_dbg(priv->dev, "[%u] %s: no violation:  %d\n",
+				hw_id, __func__, temp);
+		}
+	}
+}
+
 static int tsens_probe(struct platform_device *pdev)
 {
 	int ret, i;
@@ -1139,6 +1333,19 @@ static int tsens_probe(struct platform_device *pdev)
 	priv->dev = dev;
 	priv->num_sensors = num_sensors;
 	priv->needs_reinit_wa = data->needs_reinit_wa;
+
+	if (priv->needs_reinit_wa && !qcom_scm_is_available())
+		return -EPROBE_DEFER;
+
+	if (priv->needs_reinit_wa) {
+		priv->reinit_wa_worker = alloc_workqueue("tsens_reinit_work",
+							 WQ_HIGHPRI, 0);
+		if (!priv->reinit_wa_worker)
+			return -ENOMEM;
+
+		INIT_WORK(&priv->reinit_wa_notify, tsens_reinit_worker_notify);
+	}
+
 	priv->ops = data->ops;
 	for (i = 0;  i < priv->num_sensors; i++) {
 		if (data->hw_ids)
@@ -1151,13 +1358,15 @@ static int tsens_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, priv);
 
-	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp)
-		return -EINVAL;
+	if (!priv->ops || !priv->ops->init || !priv->ops->get_temp) {
+		ret = -EINVAL;
+		goto free_wq;
+	}
 
 	ret = priv->ops->init(priv);
 	if (ret < 0) {
 		dev_err(dev, "%s: init failed\n", __func__);
-		return ret;
+		goto free_wq;
 	}
 
 	if (priv->ops->calibrate) {
@@ -1165,11 +1374,23 @@ static int tsens_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			if (ret != -EPROBE_DEFER)
 				dev_err(dev, "%s: calibration failed\n", __func__);
-			return ret;
+
+			goto free_wq;
 		}
 	}
 
-	return tsens_register(priv);
+	ret = tsens_register(priv);
+	if (ret < 0) {
+		dev_err(dev, "%s: registration failed\n", __func__);
+		goto free_wq;
+	}
+
+	list_add_tail(&priv->list, &tsens_device_list);
+	return 0;
+
+free_wq:
+	destroy_workqueue(priv->reinit_wa_worker);
+	return ret;
 }
 
 static int tsens_remove(struct platform_device *pdev)
@@ -1181,6 +1402,8 @@ static int tsens_remove(struct platform_device *pdev)
 	if (priv->ops->disable)
 		priv->ops->disable(priv);
 
+	destroy_workqueue(priv->reinit_wa_worker);
+
 	return 0;
 }
 
diff --git a/drivers/thermal/qcom/tsens.h b/drivers/thermal/qcom/tsens.h
index 48a7bda902c1..c7279a50cf9b 100644
--- a/drivers/thermal/qcom/tsens.h
+++ b/drivers/thermal/qcom/tsens.h
@@ -14,6 +14,7 @@
 #define SLOPE_FACTOR		1000
 #define SLOPE_DEFAULT		3200
 #define TIMEOUT_US		100
+#define RESET_TIMEOUT_MS	2
 #define THRESHOLD_MAX_ADC_CODE	0x3ff
 #define THRESHOLD_MIN_ADC_CODE	0x0
 
@@ -167,6 +168,7 @@ enum regfield_ids {
 	/* ----- TM ------ */
 	/* TRDY */
 	TRDY,
+	FIRST_ROUND_COMPLETE,
 	/* INTERRUPT ENABLE */
 	INT_EN,	/* v2+ has separate enables for crit, upper and lower irq */
 	/* STATUS */
@@ -565,6 +567,10 @@ struct tsens_priv {
 	struct regmap			*srot_map;
 	u32				tm_offset;
 	bool				needs_reinit_wa;
+	struct workqueue_struct		*reinit_wa_worker;
+	struct work_struct		reinit_wa_notify;
+
+	struct list_head		list;
 
 	/* lock for upper/lower threshold interrupts */
 	spinlock_t			ul_lock;
-- 
2.35.3

