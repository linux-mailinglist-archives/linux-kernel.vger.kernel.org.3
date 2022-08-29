Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22A7A5A5009
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 17:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbiH2PRx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 11:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229698AbiH2PRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 11:17:51 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAB87A51B
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:17:50 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 6-20020a9d0106000000b0063963134d04so6112854otu.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 08:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=TIIRCQTI5+8sTLZAt+gwWaDMEai6TFCESURcivk8sXk=;
        b=KK0OKRp3n3acJdzvVa/LhTnV+B5ZPpI6IQDH0dJJtD62Txu8eChPpHTKOEBfALLFTx
         jHrf0VAArpmyKPonV+5EfeXIfRIx38O9wxfNkNw+gbO41t8XTFDAyUNF8+hsvNrLZvil
         AxSoeUHkbRrx66gw5PVwLE8le7L8X+AmXJ6szuztUq1ODHAhdfu7QrPsli3spdEPnSfR
         rpo0bPopGMXGWXYG0H2LoNedctn//W2VWmbXKmPvjZ695KpjmuSkh5a8HULNTI6oK7lz
         YWNtRCEFlFtqESh3QVhqyJK2tJwgLCjERm4zofWNSnB7hP7JUjmH7X8WWQtZalUe7QxN
         OHyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=TIIRCQTI5+8sTLZAt+gwWaDMEai6TFCESURcivk8sXk=;
        b=nzJmKiYL5viEg/3yr/gPkpWfrB4KZ86as7kETIZFHiSg7hHTyBYEYPay3UUWhM04eX
         j5CpaWBrpI3gywJs89fODgG2swKSgMaLdBjXcnflwtspwo7Ad4UpH+sveLPtXEObRgTh
         KEjH7dNxLzwnVDEsIDzmfbUNrHf5aeLEbVerkKKetj258TYValeReL4VzTSFyIiyCpI4
         QPmw4LEtRw+ZWXqaWnfyT38pS66DJvXMCmigFQXfNfQVezXQu+mjuMcRXf0Xggb6brDT
         n7lHp3Hkrl+bwTLSP2EsJPAvNq+WVGthjOoq0z+u0KlY1eB0luJgrGlzZY9f0SChh0If
         j4Gw==
X-Gm-Message-State: ACgBeo00V/QBL020DJ6582m8NMVGdxIjb0pfFxUcetVwPS+8So+DFD43
        WVz8cridWDoQxdzcEXMXzI27MA==
X-Google-Smtp-Source: AA6agR5S8o1tT/VGLJaD4FIAtZbeD1r9pbQ+nBZbaDlYAHn6L/xROPC/qny0BhP/cUMbEWleiUT7wA==
X-Received: by 2002:a05:6830:1bc4:b0:636:e925:c3b6 with SMTP id v4-20020a0568301bc400b00636e925c3b6mr7049000ota.86.1661786269797;
        Mon, 29 Aug 2022 08:17:49 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id z14-20020a056830128e00b006389650374dsm5771320otp.54.2022.08.29.08.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 08:17:49 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     linux-iio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, mranostay@ti.com,
        jpanis@baylibre.com, fabien.lahoudere@collabora.com,
        gwendal@chromium.org, enric.balletbo@collabora.com,
        bleung@chromium.org, groeck@chromium.org, jic23@kernel.org,
        david@lechnology.com, robertcnelson@gmail.com,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [RFC PATCH 1/2] counter: Consolidate Counter extension sysfs attribute creation
Date:   Mon, 29 Aug 2022 11:17:30 -0400
Message-Id: <a9bead589cdb322d66e76c6d8c823088b3810be9.1661785438.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <cover.1661785438.git.william.gray@linaro.org>
References: <cover.1661785438.git.william.gray@linaro.org>
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

Counter extensions are handled for the Device, Counts, and Signals. The
code loops through each Counter extension and creates the expected sysfs
attributes. This patch consolidates that code into functions to reduce
redundancy and make the intention of the code clearer.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/counter/counter-sysfs.c | 98 ++++++++++++++++-----------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/counter/counter-sysfs.c b/drivers/counter/counter-sysfs.c
index 04eac41dad33..026ea094d68e 100644
--- a/drivers/counter/counter-sysfs.c
+++ b/drivers/counter/counter-sysfs.c
@@ -580,6 +580,46 @@ static int counter_comp_id_attr_create(struct device *const dev,
 	return 0;
 }
 
+static int counter_ext_attrs_create(struct device *const dev,
+				    struct counter_attribute_group *const group,
+				    const struct counter_comp *const ext,
+				    const enum counter_scope scope,
+				    void *const parent, const size_t id)
+{
+	int err;
+
+	/* Create main extension attribute */
+	err = counter_attr_create(dev, group, ext, scope, parent);
+	if (err < 0)
+		return err;
+
+	/* Create extension id attribute */
+	return counter_comp_id_attr_create(dev, group, ext->name, id);
+}
+
+static int counter_sysfs_exts_add(struct device *const dev,
+				  struct counter_attribute_group *const group,
+				  const struct counter_comp *const exts,
+				  const size_t num_ext,
+				  const enum counter_scope scope,
+				  void *const parent)
+{
+	size_t i;
+	const struct counter_comp *ext;
+	int err;
+
+	/* Create attributes for each extension */
+	for (i = 0; i < num_ext; i++) {
+		ext = &exts[i];
+		err = counter_ext_attrs_create(dev, group, ext, scope, parent,
+					       i);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static struct counter_comp counter_signal_comp = {
 	.type = COUNTER_COMP_SIGNAL_LEVEL,
 	.name = "signal",
@@ -593,8 +633,6 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Signal attribute */
 	comp = counter_signal_comp;
@@ -608,21 +646,9 @@ static int counter_signal_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < signal->num_ext; i++) {
-		ext = &signal->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, signal);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Signal extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, signal->ext,
+				      signal->num_ext, scope, signal);
 }
 
 static int counter_sysfs_signals_add(struct counter_device *const counter,
@@ -707,8 +733,6 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	struct device *const dev = &counter->dev;
 	int err;
 	struct counter_comp comp;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Create main Count attribute */
 	comp = counter_count_comp;
@@ -731,21 +755,9 @@ static int counter_count_attrs_create(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < count->num_ext; i++) {
-		ext = &count->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, count);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
-
-	return 0;
+	/* Add Count extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, count->ext,
+				      count->num_ext, scope, count);
 }
 
 static int counter_sysfs_counts_add(struct counter_device *const counter,
@@ -838,8 +850,6 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	const enum counter_scope scope = COUNTER_SCOPE_DEVICE;
 	struct device *const dev = &counter->dev;
 	int err;
-	size_t i;
-	struct counter_comp *ext;
 
 	/* Add Signals sysfs attributes */
 	err = counter_sysfs_signals_add(counter, cattr_group);
@@ -876,19 +886,9 @@ static int counter_sysfs_attr_add(struct counter_device *const counter,
 	if (err < 0)
 		return err;
 
-	/* Create an attribute for each extension */
-	for (i = 0; i < counter->num_ext; i++) {
-		ext = &counter->ext[i];
-
-		err = counter_attr_create(dev, cattr_group, ext, scope, NULL);
-		if (err < 0)
-			return err;
-
-		err = counter_comp_id_attr_create(dev, cattr_group, ext->name,
-						  i);
-		if (err < 0)
-			return err;
-	}
+	/* Add device extensions */
+	return counter_sysfs_exts_add(dev, cattr_group, counter->ext,
+				      counter->num_ext, scope, NULL);
 
 	return 0;
 }
-- 
2.37.2

