Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55674522F94
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbiEKJhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242054AbiEKJgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:36:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3E419C2B;
        Wed, 11 May 2022 02:36:16 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id gj17-20020a17090b109100b001d8b390f77bso4424251pjb.1;
        Wed, 11 May 2022 02:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BznJIgcH2FHe9+LIqk3U3GlU54Hnsk8ndUlGlHDJ1/o=;
        b=KXYgzGHmrq2VZCyMC0kGDUjNcPs/S+jrVhgGZWE80e6cRkvsYdnbA2jqX0dV3VD8AZ
         M2YPhLHQ+2GNrjp9HJQ93FKPDlhFzHJcisYb8kD6Gtigg9hMmK9ouRfm4ZyZxaZ8R0lO
         x8R63vVq8kug19KFTHRVzye0lj/LYZNjWFbZO+tkaqtEkwBam3EgFdbUV/KsVfKHfE/d
         GEtiFqd/7pTpIDGeNGDOiHzRgGsohHHQvKCJeg8Bcixpw1Dxto/ki08jpz09BQQSx0vo
         I876tEeDdUqPSp/juQsaKvly9HUHdifW0J6K3EgMcCEJQPth4FSlW1QbZR7ehb1etcMj
         RLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BznJIgcH2FHe9+LIqk3U3GlU54Hnsk8ndUlGlHDJ1/o=;
        b=qJBVekTAzQwmu7Bb3rr+IvFEEe3NJe6gS53dahotvWLaviBZVosqKcQtvRcdTEywdX
         2uCO42f9eBxy9TgJitCTVHIRK8gBWBpnnxRh3T+dVlIyfxBqmDBh+D0bICbIrN5HSmAg
         NqVWzaGj5a5A7EMrfaV+ofN4eMn0ywcPzbYEqjSBprqKBiZ2CnxSMe6GEKCX+qSZcc0d
         5lo+ssydFjf9JM5qD9rjXz0dtFlx3HdGYG6ld/JCPkBWOwbjkluOwb3/+XofxriHc3rc
         /HUuxn4nbSkn9OqS0OB5p2Yxuyeg5W9iGMyZzJ0khwTjI8xxa+dWpXm6BcedYv8TcCTI
         4H9Q==
X-Gm-Message-State: AOAM533s9yNHocSIcHYPmd2O4yBr+nTYW15jH5NuxOeqB5cn/yEHTe76
        KUms2ZwMheen+hlLh5f/PNrHZLzDYAj+6g==
X-Google-Smtp-Source: ABdhPJxRkToQA8CRbl99rnDYsK210mvXocl7mi6m9WiHTWNjHnlqiqDMvdNEHl2o8teBtHxogenXGA==
X-Received: by 2002:a17:90a:c908:b0:1dd:1c2e:b1f7 with SMTP id v8-20020a17090ac90800b001dd1c2eb1f7mr4443135pjt.198.1652261775551;
        Wed, 11 May 2022 02:36:15 -0700 (PDT)
Received: from localhost.localdomain ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p14-20020a17090a428e00b001dcf8960a13sm3492640pjg.40.2022.05.11.02.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 02:36:15 -0700 (PDT)
From:   Chanwoo Choi <cwchoi00@gmail.com>
X-Google-Original-From: Chanwoo Choi <cw00.choi@samsung.com>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     johnson.wang@mediatek.com, mka@chromium.org, wenst@chromium.org,
        jia-wei.chang@mediatek.com, andrew-sh.cheng@mediatek.com,
        hsinyi@chromium.org, saravanak@google.com, cw00.choi@samsung.com,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Subject: [PATCH v4 4/4] PM / devfreq: passive: Keep cpufreq_policy for possible cpus
Date:   Wed, 11 May 2022 18:35:54 +0900
Message-Id: <20220511093554.17535-5-cw00.choi@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511093554.17535-1-cw00.choi@samsung.com>
References: <20220511093554.17535-1-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The passive governor requires the cpu data to get the next target frequency
of devfreq device if depending on cpu. In order to reduce the unnecessary
memory data, keep cpufreq_policy data for possible cpus instead of NR_CPU.

Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Johnson Wang <johnson.wang@mediatek.com>
Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
---
 drivers/devfreq/governor.h         |  3 ++
 drivers/devfreq/governor_passive.c | 73 ++++++++++++++++++++++++------
 include/linux/devfreq.h            |  4 +-
 3 files changed, 63 insertions(+), 17 deletions(-)

diff --git a/drivers/devfreq/governor.h b/drivers/devfreq/governor.h
index 335c4a491254..0adfebc0467a 100644
--- a/drivers/devfreq/governor.h
+++ b/drivers/devfreq/governor.h
@@ -49,6 +49,7 @@
 
 /**
  * struct devfreq_cpu_data - Hold the per-cpu data
+ * @node:	list node
  * @dev:	reference to cpu device.
  * @first_cpu:	the cpumask of the first cpu of a policy.
  * @opp_table:	reference to cpu opp table.
@@ -60,6 +61,8 @@
  * This is auto-populated by the governor.
  */
 struct devfreq_cpu_data {
+	struct list_head node;
+
 	struct device *dev;
 	unsigned int first_cpu;
 
diff --git a/drivers/devfreq/governor_passive.c b/drivers/devfreq/governor_passive.c
index db02f5219684..331e93b9eb8d 100644
--- a/drivers/devfreq/governor_passive.c
+++ b/drivers/devfreq/governor_passive.c
@@ -18,6 +18,22 @@
 
 #define HZ_PER_KHZ	1000
 
+static struct devfreq_cpu_data *
+get_parent_cpu_data(struct devfreq_passive_data *p_data,
+		    struct cpufreq_policy *policy)
+{
+	struct devfreq_cpu_data *parent_cpu_data;
+
+	if (!p_data || !policy)
+		return NULL;
+
+	list_for_each_entry(parent_cpu_data, &p_data->cpu_data_list, node)
+		if (parent_cpu_data->first_cpu == cpumask_first(policy->related_cpus))
+			return parent_cpu_data;
+
+	return NULL;
+}
+
 static unsigned long get_target_freq_by_required_opp(struct device *p_dev,
 						struct opp_table *p_opp_table,
 						struct opp_table *opp_table,
@@ -50,14 +66,24 @@ static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
 	struct devfreq_passive_data *p_data =
 				(struct devfreq_passive_data *)devfreq->data;
 	struct devfreq_cpu_data *parent_cpu_data;
+	struct cpufreq_policy *policy;
 	unsigned long cpu, cpu_cur, cpu_min, cpu_max, cpu_percent;
 	unsigned long dev_min, dev_max;
 	unsigned long freq = 0;
+	int ret = 0;
 
 	for_each_online_cpu(cpu) {
-		parent_cpu_data = p_data->parent_cpu_data[cpu];
-		if (!parent_cpu_data || parent_cpu_data->first_cpu != cpu)
+		policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			ret = -EINVAL;
+			continue;
+		}
+
+		parent_cpu_data = get_parent_cpu_data(p_data, policy);
+		if (!parent_cpu_data) {
+			cpufreq_cpu_put(policy);
 			continue;
+		}
 
 		/* Get target freq via required opps */
 		cpu_cur = parent_cpu_data->cur_freq * HZ_PER_KHZ;
@@ -66,6 +92,7 @@ static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
 					devfreq->opp_table, cpu_cur);
 		if (freq) {
 			*target_freq = max(freq, *target_freq);
+			cpufreq_cpu_put(policy);
 			continue;
 		}
 
@@ -80,9 +107,10 @@ static int get_target_freq_with_cpufreq(struct devfreq *devfreq,
 		freq = dev_min + mult_frac(dev_max - dev_min, cpu_percent, 100);
 
 		*target_freq = max(freq, *target_freq);
+		cpufreq_cpu_put(policy);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int get_target_freq_with_devfreq(struct devfreq *devfreq,
@@ -167,12 +195,11 @@ static int cpufreq_passive_notifier_call(struct notifier_block *nb,
 	unsigned int cur_freq;
 	int ret;
 
-	if (event != CPUFREQ_POSTCHANGE || !freqs ||
-		!p_data->parent_cpu_data[freqs->policy->cpu])
+	if (event != CPUFREQ_POSTCHANGE || !freqs)
 		return 0;
 
-	parent_cpu_data = p_data->parent_cpu_data[freqs->policy->cpu];
-	if (parent_cpu_data->cur_freq == freqs->new)
+	parent_cpu_data = get_parent_cpu_data(p_data, freqs->policy);
+	if (!parent_cpu_data || parent_cpu_data->cur_freq == freqs->new)
 		return 0;
 
 	cur_freq = parent_cpu_data->cur_freq;
@@ -195,7 +222,7 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 	struct devfreq_passive_data *p_data
 			= (struct devfreq_passive_data *)devfreq->data;
 	struct devfreq_cpu_data *parent_cpu_data;
-	int cpu, ret;
+	int cpu, ret = 0;
 
 	if (p_data->nb.notifier_call) {
 		ret = cpufreq_unregister_notifier(&p_data->nb,
@@ -205,16 +232,26 @@ static int cpufreq_passive_unregister_notifier(struct devfreq *devfreq)
 	}
 
 	for_each_possible_cpu(cpu) {
-		parent_cpu_data = p_data->parent_cpu_data[cpu];
-		if (!parent_cpu_data)
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		if (!policy) {
+			ret = -EINVAL;
 			continue;
+		}
 
+		parent_cpu_data = get_parent_cpu_data(p_data, policy);
+		if (!parent_cpu_data) {
+			cpufreq_cpu_put(policy);
+			continue;
+		}
+
+		list_del(&parent_cpu_data->node);
 		if (parent_cpu_data->opp_table)
 			dev_pm_opp_put_opp_table(parent_cpu_data->opp_table);
 		kfree(parent_cpu_data);
+		cpufreq_cpu_put(policy);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
@@ -232,6 +269,9 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 	if (!p_data->this)
 		p_data->this = devfreq;
 
+	p_data->cpu_data_list
+		= (struct list_head)LIST_HEAD_INIT(p_data->cpu_data_list);
+
 	p_data->nb.notifier_call = cpufreq_passive_notifier_call;
 	ret = cpufreq_register_notifier(&p_data->nb, CPUFREQ_TRANSITION_NOTIFIER);
 	if (ret) {
@@ -241,15 +281,18 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 	}
 
 	for_each_possible_cpu(cpu) {
-		if (p_data->parent_cpu_data[cpu])
-			continue;
-
 		policy = cpufreq_cpu_get(cpu);
 		if (!policy) {
 			ret = -EPROBE_DEFER;
 			goto err;
 		}
 
+		parent_cpu_data = get_parent_cpu_data(p_data, policy);
+		if (parent_cpu_data) {
+			cpufreq_cpu_put(policy);
+			continue;
+		}
+
 		parent_cpu_data = kzalloc(sizeof(*parent_cpu_data),
 						GFP_KERNEL);
 		if (!parent_cpu_data) {
@@ -278,7 +321,7 @@ static int cpufreq_passive_register_notifier(struct devfreq *devfreq)
 		parent_cpu_data->min_freq = policy->cpuinfo.min_freq;
 		parent_cpu_data->max_freq = policy->cpuinfo.max_freq;
 
-		p_data->parent_cpu_data[cpu] = parent_cpu_data;
+		list_add_tail(&parent_cpu_data->node, &p_data->cpu_data_list);
 		cpufreq_cpu_put(policy);
 	}
 
diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
index b1e4a6f796ce..dc10bee75a72 100644
--- a/include/linux/devfreq.h
+++ b/include/linux/devfreq.h
@@ -309,7 +309,7 @@ enum devfreq_parent_dev_type {
  * @this:		the devfreq instance of own device.
  * @nb:			the notifier block for DEVFREQ_TRANSITION_NOTIFIER or
  *			CPUFREQ_TRANSITION_NOTIFIER list.
- * @parent_cpu_data:	the state min/max/current frequency of all online cpu's.
+ * @cpu_data_list:	the list of cpu frequency data for all cpufreq_policy.
  *
  * The devfreq_passive_data have to set the devfreq instance of parent
  * device with governors except for the passive governor. But, don't need to
@@ -329,7 +329,7 @@ struct devfreq_passive_data {
 	/* For passive governor's internal use. Don't need to set them */
 	struct devfreq *this;
 	struct notifier_block nb;
-	struct devfreq_cpu_data *parent_cpu_data[NR_CPUS];
+	struct list_head cpu_data_list;
 };
 #endif
 
-- 
2.25.1

