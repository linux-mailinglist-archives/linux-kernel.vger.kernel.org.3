Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08C6658E347
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 00:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiHIWex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 18:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbiHIWeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 18:34:23 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBEE065657
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 15:34:12 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v131-20020a1cac89000000b003a4bb3f786bso166192wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lYcuc9rgeB5uU+5i7r38Aemp+oMPCEAMe0bEyvRkXHU=;
        b=fOlX3zHl2q80OBOqjiYyKhFLa4DgXfSYcCGD1jD5SGQ6VL7Lwf2UCoPUK441ibe+tR
         blFN8JJPuPmWHcFHj/Gs7SvCORuGrTfcnoJljmTqrmlXUPpFXD3L1EQwW0DNLaEsp8w1
         vADIQeYQvLVBxkUoqUZ4O0/tJhRMxqBKFLmxZSNsMamd3YhSlFVTMomzdyDNxV7wRF2b
         MgMmkpeg17cn9S+WXTbh6mxT4W33nMA2thiDctH80kUEWcDa1zrhZ84n8exLggN5oANj
         /zuxb2Rdc3WQqiQbeA320yYuJxIZpJa8nf9DqEqy3W3jUiVyEunpOJ6Lh53io4C0VlJg
         NWLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lYcuc9rgeB5uU+5i7r38Aemp+oMPCEAMe0bEyvRkXHU=;
        b=fVYuxd9Ukbc8jDzt0zt+CRiMvBSOy1+6JTdwYT3/gmvqfLMWhvuZP9gjzoLlfQaDN0
         DwV4mPwkKiJlCFg30SGcYeqpgLlD3Vp5426BvaIYVE9STNcX5EItqaO43CQAXdbuQAGe
         OVdC4lh6wXwpm10/SHtyBvd4TUOO0bVoqhJasTgrE9FrkEWBngjJT+MAb94s7dQJ81vQ
         q+lE8vKrGpORoJg3hCPfTM35INxc4U9ygVq4qQBmUAlggWIeyEYg+3B7HJtKx3XYGVOU
         uaJ2bUrPSEokqA26rgFIYQKbH4xqA//Z+kdKA06HifWxpjvxGWNoZ0zH5m+npNkzqoV3
         FDTA==
X-Gm-Message-State: ACgBeo1B8pKM9rJBQ9nhtu8eWwjxWHDeYg+0qeOyrBTklbV5EarNlaDK
        2nwdDhKBPxeW+GZe8ydkMqjQvw==
X-Google-Smtp-Source: AA6agR6F4IYAkHtVjEr2KwObCL/Q2qWfMR30WbELGiwB3CHUe/Xi0FMBwikyvYrxnFu0xk/83MT3aA==
X-Received: by 2002:a7b:c003:0:b0:39c:5642:e415 with SMTP id c3-20020a7bc003000000b0039c5642e415mr299673wmb.111.1660084451168;
        Tue, 09 Aug 2022 15:34:11 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:a6:74a6:5a0e:f3e2])
        by smtp.gmail.com with ESMTPSA id e20-20020a05600c4b9400b003a2cf1ba9e2sm311650wmp.6.2022.08.09.15.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 15:34:10 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH v3 05/13] coresight: etm3x: Update ETM3 driver to use Trace ID API
Date:   Tue,  9 Aug 2022 23:33:53 +0100
Message-Id: <20220809223401.24599-6-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220809223401.24599-1-mike.leach@linaro.org>
References: <20220809223401.24599-1-mike.leach@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the TraceID API to allocate ETM trace IDs dynamically.

As with the etm4x we allocate on enable / disable for perf,
allocate on enable / reset for sysfs.

Additionally we allocate on sysfs file read as both perf and sysfs
can read the ID before enabling the hardware.

Remove sysfs option to write trace ID - which is inconsistent with
both the dynamic allocation method and the fixed allocation method
previously used.

Signed-off-by: Mike Leach <mike.leach@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm.h   |  2 +
 .../coresight/coresight-etm3x-core.c          | 77 +++++++++++++++++--
 .../coresight/coresight-etm3x-sysfs.c         | 27 ++-----
 3 files changed, 79 insertions(+), 27 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
index f3ab96eaf44e..3667428d38b6 100644
--- a/drivers/hwtracing/coresight/coresight-etm.h
+++ b/drivers/hwtracing/coresight/coresight-etm.h
@@ -287,4 +287,6 @@ int etm_get_trace_id(struct etm_drvdata *drvdata);
 void etm_set_default(struct etm_config *config);
 void etm_config_trace_mode(struct etm_config *config);
 struct etm_config *get_etm_config(struct etm_drvdata *drvdata);
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata);
+void etm_release_trace_id(struct etm_drvdata *drvdata);
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
index d0ab9933472b..c4e7b3337a5c 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
@@ -32,6 +32,7 @@
 
 #include "coresight-etm.h"
 #include "coresight-etm-perf.h"
+#include "coresight-trace-id.h"
 
 /*
  * Not really modular but using module_param is the easiest way to
@@ -490,18 +491,67 @@ static int etm_trace_id(struct coresight_device *csdev)
 	return etm_get_trace_id(drvdata);
 }
 
+int etm_read_alloc_trace_id(struct etm_drvdata *drvdata)
+{
+	int trace_id;
+
+	/* trace id function has its own lock */
+	trace_id = coresight_trace_id_get_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id))
+		drvdata->traceid = (u8)trace_id;
+	else
+		dev_err(&drvdata->csdev->dev,
+			"Failed to allocate trace ID for %s on CPU%d\n",
+			dev_name(&drvdata->csdev->dev), drvdata->cpu);
+	return trace_id;
+}
+
+static int etm_set_current_trace_id(struct etmv4_drvdata *drvdata)
+{
+	int trace_id;
+
+	/*
+	 * Set the currently allocated trace ID - perf allocates IDs
+	 * as part of setup_aux for all CPUs it may use.
+	 */
+	trace_id = coresight_trace_id_read_cpu_id(drvdata->cpu);
+	if (IS_VALID_ID(trace_id)) {
+		drvdata->traceid = (u8)trace_id;
+		return 0;
+	}
+
+	dev_err(&drvdata->csdev->dev, "Failed to set trace ID for %s on CPU%d\n",
+		dev_name(&drvdata->csdev->dev), drvdata->cpu);
+
+	return -EINVAL;
+}
+
+void etm_release_trace_id(struct etm_drvdata *drvdata)
+{
+	coresight_trace_id_put_cpu_id(drvdata->cpu);
+}
+
 static int etm_enable_perf(struct coresight_device *csdev,
 			   struct perf_event *event)
 {
 	struct etm_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
+	int ret;
 
 	if (WARN_ON_ONCE(drvdata->cpu != smp_processor_id()))
 		return -EINVAL;
 
 	/* Configure the tracer based on the session's specifics */
 	etm_parse_event_config(drvdata, event);
+
+	/* perf allocates cpu IDs in setup aux - set the current on device */
+	ret = etm_set_current_trace_id(drvdata);
+	if (ret < 0)
+		return ret;
+
 	/* And enable it */
-	return etm_enable_hw(drvdata);
+	ret = etm_enable_hw(drvdata);
+
+	return ret;
 }
 
 static int etm_enable_sysfs(struct coresight_device *csdev)
@@ -512,6 +562,11 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 
 	spin_lock(&drvdata->spinlock);
 
+	/* sysfs needs to allocate and set a trace ID */
+	ret = etm_read_alloc_trace_id(drvdata);
+	if (ret < 0)
+		goto unlock_enable_sysfs;
+
 	/*
 	 * Configure the ETM only if the CPU is online.  If it isn't online
 	 * hw configuration will take place on the local CPU during bring up.
@@ -528,6 +583,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev)
 		ret = -ENODEV;
 	}
 
+	if (ret)
+		etm_release_trace_id(drvdata);
+
+unlock_enable_sysfs:
 	spin_unlock(&drvdata->spinlock);
 
 	if (!ret)
@@ -611,6 +670,9 @@ static void etm_disable_perf(struct coresight_device *csdev)
 	coresight_disclaim_device_unlocked(csdev);
 
 	CS_LOCK(drvdata->base);
+
+	/* The perf event will release trace ids when it is destroyed */
+
 }
 
 static void etm_disable_sysfs(struct coresight_device *csdev)
@@ -635,6 +697,13 @@ static void etm_disable_sysfs(struct coresight_device *csdev)
 	spin_unlock(&drvdata->spinlock);
 	cpus_read_unlock();
 
+	/*
+	 * we only release trace IDs when resetting sysfs.
+	 * This permits sysfs users to read the trace ID after the trace
+	 * session has completed. This maintains operational behaviour with
+	 * prior trace id allocation method
+	 */
+
 	dev_dbg(&csdev->dev, "ETM tracing disabled\n");
 }
 
@@ -781,11 +850,6 @@ static void etm_init_arch_data(void *info)
 	CS_LOCK(drvdata->base);
 }
 
-static void etm_init_trace_id(struct etm_drvdata *drvdata)
-{
-	drvdata->traceid = coresight_get_trace_id(drvdata->cpu);
-}
-
 static int __init etm_hp_setup(void)
 {
 	int ret;
@@ -871,7 +935,6 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (etm_arch_supported(drvdata->arch) == false)
 		return -EINVAL;
 
-	etm_init_trace_id(drvdata);
 	etm_set_default(&drvdata->config);
 
 	pdata = coresight_get_platform_data(dev);
diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
index 68fcbf4ce7a8..fde028e43c92 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
@@ -85,6 +85,7 @@ static ssize_t reset_store(struct device *dev,
 		}
 
 		etm_set_default(config);
+		etm_release_trace_id(drvdata);
 		spin_unlock(&drvdata->spinlock);
 	}
 
@@ -1189,30 +1190,16 @@ static DEVICE_ATTR_RO(cpu);
 static ssize_t traceid_show(struct device *dev,
 			    struct device_attribute *attr, char *buf)
 {
-	unsigned long val;
-	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
-
-	val = etm_get_trace_id(drvdata);
-
-	return sprintf(buf, "%#lx\n", val);
-}
-
-static ssize_t traceid_store(struct device *dev,
-			     struct device_attribute *attr,
-			     const char *buf, size_t size)
-{
-	int ret;
-	unsigned long val;
+	int trace_id;
 	struct etm_drvdata *drvdata = dev_get_drvdata(dev->parent);
 
-	ret = kstrtoul(buf, 16, &val);
-	if (ret)
-		return ret;
+	trace_id = etm_read_alloc_trace_id(drvdata);
+	if (trace_id < 0)
+		return trace_id;
 
-	drvdata->traceid = val & ETM_TRACEID_MASK;
-	return size;
+	return sysfs_emit(buf, "%#x\n", trace_id);
 }
-static DEVICE_ATTR_RW(traceid);
+static DEVICE_ATTR_RO(traceid);
 
 static struct attribute *coresight_etm_attrs[] = {
 	&dev_attr_nr_addr_cmp.attr,
-- 
2.17.1

