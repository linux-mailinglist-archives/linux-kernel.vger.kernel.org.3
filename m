Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D723534E8C
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 13:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346440AbiEZLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiEZLo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 07:44:58 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41461D8090
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:52 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e66so1122949pgc.8
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 04:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gAxtECM05PzG/Tji4CAVaBCkNnxvwBxiF1rKgSbAS7k=;
        b=IjQikfoaO7L/MsZ9JQx/BST3wDHalycaIFjh7JZMnim1nvhyRMqMCOKENl+sdy0fo8
         BRDbsF6yLDdx7IZid3mbTMxB8kRqmFW+vKiwa3Wm3uFWjiy3QURC7rfiP8+mhijN/gq0
         iuDDSX544E5hxNx7Q6Pv3NVMWYX3IUExUwxmt9fd6fE9GmcZgIPZ9jV6dJzWcNir2ikH
         aut7Dgsm/FL3RPvEkZAY1GfJeT0Ury7eGcIGjh5zM345Zmzv0AwLL2FhWCHqobE3IBVj
         8qcEtqVxELs0mm0xvc+rb6NvXy70Ox+4wZ1OJCG+a8Pp7otfDtjdyBi0Hs0TrDT7dBEV
         zYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gAxtECM05PzG/Tji4CAVaBCkNnxvwBxiF1rKgSbAS7k=;
        b=Ti4JfKBoR3PdjO9x4TKOMKv2stEmAWBn3VpttWZOvRhm6w6ORwy8/u1NU0nGfErV6y
         QnTh0HxI3vx5pE4R16KJ3BEjb53Ot7U2MCQ2JdQ4nT+O8WYUma3PqOJ803VpUbWCbean
         ni5RAnc6afHmijRqTlhLdkFhB0YdZTAFFd7Lc07m2Z5CtnSWitOpJMNer2g9LT9mq8xu
         /IKgQou8BiyesWmempNjC4x8XnQLC1CXUoRl7RpWmAEK9Fo/gTzU4mpMDLC3XN5HZ//s
         HM7i9kOffi1bhihYSZa2a4HRSLEe3aI5abmZZvpnQTpe55VM8zi29NYKzMFE7Vc8nWxJ
         qTPw==
X-Gm-Message-State: AOAM5303uu4yePmk2dkS3+VR9unD5rj8jdm0NrtxhpAq01kqEGtQ5phv
        F54FnlIqJ+ftqsp7J8mZ9Dcc+Q==
X-Google-Smtp-Source: ABdhPJzWLutPUzX6PUXXIQ+ONdk7t8pldnwM+fEQ3bXC4gZ/bxFrAIy/sLqyWwcbQFrAIIOKbkgMeQ==
X-Received: by 2002:a65:63c4:0:b0:3f6:3a63:3148 with SMTP id n4-20020a6563c4000000b003f63a633148mr30750750pgv.33.1653565491496;
        Thu, 26 May 2022 04:44:51 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id mm12-20020a17090b358c00b001cd4989ff62sm1270324pjb.41.2022.05.26.04.44.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 04:44:51 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 27/31] OPP: Remove dev_pm_opp_set_clkname() and friends
Date:   Thu, 26 May 2022 17:12:26 +0530
Message-Id: <8b51e3f21c469472f2dbe43fef8963b911fde135.1653564321.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.31.1.272.g89b43f80a514
In-Reply-To: <cover.1653564321.git.viresh.kumar@linaro.org>
References: <cover.1653564321.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that everyone has migrated to dev_pm_opp_set_config(), remove the
public interface for dev_pm_opp_set_clkname() and friends.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/core.c     | 93 ++++++++++--------------------------------
 include/linux/pm_opp.h | 15 -------
 2 files changed, 21 insertions(+), 87 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 07cb8ff33a6d..c2590c0c05a0 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2152,7 +2152,7 @@ static void _opp_put_regulators(struct opp_table *opp_table)
 }
 
 /**
- * dev_pm_opp_set_clkname() - Set clk name for the device
+ * _opp_set_clkname() - Set clk name for the device
  * @dev: Device for which clk name is being set.
  * @name: Clk name.
  *
@@ -2163,93 +2163,41 @@ static void _opp_put_regulators(struct opp_table *opp_table)
  *
  * This must be called before any OPPs are initialized for the device.
  */
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
+static int _opp_set_clkname(struct opp_table *opp_table, struct device *dev,
+			    const char *name)
 {
-	struct opp_table *opp_table;
-	int ret;
-
-	opp_table = _add_opp_table(dev, false);
-	if (IS_ERR(opp_table))
-		return opp_table;
-
-	/* This should be called before OPPs are initialized */
-	if (WARN_ON(!list_empty(&opp_table->opp_list))) {
-		ret = -EBUSY;
-		goto err;
-	}
-
 	/* Another CPU that shares the OPP table has set the clkname ? */
 	if (opp_table->clk_configured)
-		return opp_table;
+		return 0;
 
 	/* clk shouldn't be initialized at this point */
-	if (WARN_ON(opp_table->clk)) {
-		ret = -EBUSY;
-		goto err;
-	}
+	if (WARN_ON(opp_table->clk))
+		return -EBUSY;
 
 	/* Find clk for the device */
 	opp_table->clk = clk_get(dev, name);
 	if (IS_ERR(opp_table->clk)) {
-		ret = dev_err_probe(dev, PTR_ERR(opp_table->clk),
+		return dev_err_probe(dev, PTR_ERR(opp_table->clk),
 				    "%s: Couldn't find clock\n", __func__);
-		goto err;
 	}
 
 	opp_table->clk_configured = true;
 
-	return opp_table;
-
-err:
-	dev_pm_opp_put_opp_table(opp_table);
-
-	return ERR_PTR(ret);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_set_clkname);
-
-/**
- * dev_pm_opp_put_clkname() - Releases resources blocked for clk.
- * @opp_table: OPP table returned from dev_pm_opp_set_clkname().
- */
-void dev_pm_opp_put_clkname(struct opp_table *opp_table)
-{
-	if (unlikely(!opp_table))
-		return;
-
-	clk_put(opp_table->clk);
-	opp_table->clk = ERR_PTR(-EINVAL);
-	opp_table->clk_configured = false;
-
-	dev_pm_opp_put_opp_table(opp_table);
-}
-EXPORT_SYMBOL_GPL(dev_pm_opp_put_clkname);
-
-static void devm_pm_opp_clkname_release(void *data)
-{
-	dev_pm_opp_put_clkname(data);
+	return 0;
 }
 
 /**
- * devm_pm_opp_set_clkname() - Set clk name for the device
- * @dev: Device for which clk name is being set.
- * @name: Clk name.
- *
- * This is a resource-managed variant of dev_pm_opp_set_clkname().
- *
- * Return: 0 on success and errorno otherwise.
+ * _opp_put_clkname() - Releases resources blocked for clk.
+ * @opp_table: OPP table returned from _opp_set_clkname().
  */
-int devm_pm_opp_set_clkname(struct device *dev, const char *name)
+static void _opp_put_clkname(struct opp_table *opp_table)
 {
-	struct opp_table *opp_table;
-
-	opp_table = dev_pm_opp_set_clkname(dev, name);
-	if (IS_ERR(opp_table))
-		return PTR_ERR(opp_table);
-
-	return devm_add_action_or_reset(dev, devm_pm_opp_clkname_release,
-					opp_table);
+	if (opp_table->clk_configured) {
+		clk_put(opp_table->clk);
+		opp_table->clk = ERR_PTR(-EINVAL);
+		opp_table->clk_configured = false;
+	}
 }
-EXPORT_SYMBOL_GPL(devm_pm_opp_set_clkname);
 
 /**
  * dev_pm_opp_register_set_opp_helper() - Register custom set OPP helper
@@ -2549,9 +2497,11 @@ struct opp_table *dev_pm_opp_set_config(struct device *dev,
 
 	// Configure clock
 	if (config->clk_name) {
-		ret = dev_pm_opp_set_clkname(dev, config->clk_name);
-		if (IS_ERR(ret))
+		err = _opp_set_clkname(opp_table, dev, config->clk_name);
+		if (err) {
+			ret = ERR_PTR(err);
 			goto err;
+		}
 	}
 
 	// Configure property names
@@ -2633,8 +2583,7 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table)
 	if (opp_table->prop_name)
 		dev_pm_opp_put_prop_name(opp_table);
 
-	if (opp_table->clk_configured)
-		dev_pm_opp_put_clkname(opp_table);
+	_opp_put_clkname(opp_table);
 
 	dev_pm_opp_put_opp_table(opp_table);
 }
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index b80982e5a067..7afa8160590d 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -186,9 +186,6 @@ void dev_pm_opp_clear_config(struct opp_table *opp_table);
 
 struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, const char *name);
 void dev_pm_opp_put_prop_name(struct opp_table *opp_table);
-struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name);
-void dev_pm_opp_put_clkname(struct opp_table *opp_table);
-int devm_pm_opp_set_clkname(struct device *dev, const char *name);
 struct opp_table *dev_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
 void dev_pm_opp_unregister_set_opp_helper(struct opp_table *opp_table);
 int devm_pm_opp_register_set_opp_helper(struct device *dev, int (*set_opp)(struct dev_pm_set_opp_data *data));
@@ -387,18 +384,6 @@ static inline struct opp_table *dev_pm_opp_set_prop_name(struct device *dev, con
 
 static inline void dev_pm_opp_put_prop_name(struct opp_table *opp_table) {}
 
-static inline struct opp_table *dev_pm_opp_set_clkname(struct device *dev, const char *name)
-{
-	return ERR_PTR(-EOPNOTSUPP);
-}
-
-static inline void dev_pm_opp_put_clkname(struct opp_table *opp_table) {}
-
-static inline int devm_pm_opp_set_clkname(struct device *dev, const char *name)
-{
-	return -EOPNOTSUPP;
-}
-
 static inline struct opp_table *dev_pm_opp_attach_genpd(struct device *dev, const char * const *names, struct device ***virt_devs)
 {
 	return ERR_PTR(-EOPNOTSUPP);
-- 
2.31.1.272.g89b43f80a514

