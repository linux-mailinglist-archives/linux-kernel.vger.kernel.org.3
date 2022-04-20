Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AD35092DC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:31:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382835AbiDTWea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 18:34:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233746AbiDTWe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 18:34:27 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7CD38BD0;
        Wed, 20 Apr 2022 15:31:38 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id c1so2437894qvl.3;
        Wed, 20 Apr 2022 15:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=JkAWgCc0Ariq904m7dLeYqQKKm26PwFyxIrDf9VQTV0=;
        b=i3EeGYplHqaX/6BF5hGDWaJl+SokpIz6m+uzVc6YJIOo4cUHpEJdi2bm65lH9rwJ+p
         xdGzsSiIPmd0x0cUb/pXZAnD2NGqP2gAgAg0NtzGAOQP8YG0TqBiGwWPY03klOyjM5v3
         SdFhwK2xNDrTG2CsSqdHZadygkwSibX/cYpSw/njToNrNcbzC7PXYYxydSKuxKQt8inQ
         Qn0a81mbV/c3i3ji0eWJJWg/bkPCsPbwqR98h9ocYmi6AZDbjQLG2t16k4jhRw5rLarG
         lgEr1IDZwtiPU2y7NUe3MKsOni179QFgvqR8rrpW5WmHOw7iorlUnL437kYWhO49L4Wz
         mCdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=JkAWgCc0Ariq904m7dLeYqQKKm26PwFyxIrDf9VQTV0=;
        b=RW+WdOweXus7BpACpW86ldRYZvtLzoJ7YeulHlpTvDlbZ7uXTCAdNwUt4Y/JnmfeR3
         J/Zauj30fQOfKiGGC8iHA0VQjZ12lrWI0jMYiKc8M99vWNDKHQDC2JIIJ49a+2PXFgzF
         cVQMfRrUIJblTvzHH9q4U3mhRw8XE3Iit3uSc8fkb/DoeVZ2mo8sqFmbGX7tCMk3REtT
         KqOniXC+xoLMJfhwqA13uppwY2oFgr/b4QGelXmz/zWAf8DPmKEHB4MQxBlS8roD8/60
         QMyfV23CTor2/pTTixqWo6OeJFY3GeVcTxxIquOyLKa6nfGIv1F67FIiiqcE1gFl2Zph
         qvzg==
X-Gm-Message-State: AOAM530kSOmK10cFjVrDHJ3McxL23PJQiWb6z/PvtW5n4TH++qhYB18f
        6UzS0QtcDitt2tkFQGDuLL4=
X-Google-Smtp-Source: ABdhPJzZi1xjtO9ISM5ej4u/cEU1hebUojeb1U8IkKKqq5cAgYDdY5I+G2EhuycWqIYERwQiIu8d7Q==
X-Received: by 2002:a05:6214:1bc8:b0:446:65ca:8cc4 with SMTP id m8-20020a0562141bc800b0044665ca8cc4mr11040533qvc.70.1650493897348;
        Wed, 20 Apr 2022 15:31:37 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:cac:ed08:b92a:3a4b? ([2600:1700:2442:6db0:cac:ed08:b92a:3a4b])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b0069ea555b54dsm2068954qkf.128.2022.04.20.15.31.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 15:31:36 -0700 (PDT)
Message-ID: <0d5e74b1-f8aa-593b-8d8a-ded84f33662c@gmail.com>
Date:   Wed, 20 Apr 2022 17:31:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] of: overlay: rework overlay apply and remove
 kfree()s
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com,
        Slawomir Stepien <slawomir.stepien@nokia.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Slawomir Stepien <sst@poczta.fm>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
References: <20220420222505.928492-1-frowand.list@gmail.com>
 <20220420222505.928492-3-frowand.list@gmail.com>
In-Reply-To: <20220420222505.928492-3-frowand.list@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/20/22 17:25, frowand.list@gmail.com wrote:
> From: Frank Rowand <frank.rowand@sony.com>
> 

< snip >

The changes between v3 and v4, via interdiff:


diff -u b/drivers/of/overlay.c b/drivers/of/overlay.c
--- b/drivers/of/overlay.c
+++ b/drivers/of/overlay.c
@@ -60,10 +60,10 @@
  * @new_fdt:		Memory allocated to hold unflattened aligned FDT
  * @overlay_mem:	the memory chunk that contains @overlay_root
  * @overlay_root:	expanded device tree that contains the fragment nodes
+ * @notify_state:	most recent notify action used on overlay
  * @count:		count of fragment structures
  * @fragments:		fragment nodes in the overlay expanded device tree
  * @symbols_fragment:	last element of @fragments[] is the  __symbols__ node
- * @kfree_unsafe:	pointers into the @new_fdt or @overlay_mem may exist
  * @cset:		changeset to apply fragments to live device tree
  */
 struct overlay_changeset {
@@ -72,10 +72,10 @@
 	const void *new_fdt;
 	const void *overlay_mem;
 	struct device_node *overlay_root;
+	enum of_overlay_notify_action notify_state;
 	int count;
 	struct fragment *fragments;
 	bool symbols_fragment;
-	bool kfree_unsafe;
 	struct of_changeset cset;
 };
 
@@ -165,6 +165,8 @@
 	struct of_overlay_notify_data nd;
 	int i, ret;
 
+	ovcs->notify_state = action;
+
 	for (i = 0; i < ovcs->count; i++) {
 		struct fragment *fragment = &ovcs->fragments[i];
 
@@ -864,17 +866,17 @@
 	 * There should be no live pointers into ovcs->overlay_mem and
 	 * ovcs->new_fdt due to the policy that overlay notifiers are not
 	 * allowed to retain pointers into the overlay devicetree other
-	 * than during the window between OF_OVERLAY_PRE_APPLY overlay
-	 * notifiers and the OF_OVERLAY_POST_REMOVE overlay notifiers.
-	 * During the window, ovcs->kfree_unsafe will be true.
+	 * than during the window from OF_OVERLAY_PRE_APPLY overlay
+	 * notifiers until the OF_OVERLAY_POST_REMOVE overlay notifiers.
 	 *
-	 * A memory leak will occur here if ovcs->kfree_unsafe is true.
+	 * A memory leak will occur here if within the window.
 	 */
 
-	if (!ovcs->kfree_unsafe)
+	if (ovcs->notify_state == OF_OVERLAY_INIT ||
+	    ovcs->notify_state == OF_OVERLAY_POST_REMOVE) {
 		kfree(ovcs->overlay_mem);
-	if (!ovcs->kfree_unsafe)
 		kfree(ovcs->new_fdt);
+	}
 	kfree(ovcs);
 }
 
@@ -902,10 +904,8 @@
  * following attempt to apply or remove an overlay changeset will be
  * refused.
  *
- * Returns 0 on success, or a negative error number.  When references to
- * ovcs->new_fdt and ovcs->overlay_root may exist, ovcs->kfree_unsafe is
- * set to true.  On error return, the caller of of_overlay_apply() must
- * call free_overlay_changeset().
+ * Returns 0 on success, or a negative error number.  On error return,
+ * the caller of of_overlay_apply() must call free_overlay_changeset().
  */
 
 static int of_overlay_apply(struct overlay_changeset *ovcs)
@@ -926,12 +926,6 @@
 	if (ret)
 		goto out;
 
-	/*
-	 * After overlay_notify(), ovcs->overlay_root related pointers may have
-	 * leaked to drivers, so can not kfree() ovcs->overlay_mem and
-	 * ovcs->new_fdt until after OF_OVERLAY_POST_REMOVE notifiers.
-	 */
-	ovcs->kfree_unsafe = true;
 	ret = overlay_notify(ovcs, OF_OVERLAY_PRE_APPLY);
 	if (ret) {
 		pr_err("overlay changeset pre-apply notify error %d\n", ret);
@@ -1001,6 +995,11 @@
 	of_overlay_mutex_lock();
 	mutex_lock(&of_mutex);
 
+	/*
+	 * ovcs->notify_state must be set to OF_OVERLAY_INIT before allocating
+	 * ovcs resources, implicitly set by kzalloc() of ovcs
+	 */
+
 	ovcs->id = idr_alloc(&ovcs_idr, ovcs, 1, 0, GFP_KERNEL);
 	if (ovcs->id <= 0) {
 		ret = ovcs->id;
only in patch2:
unchanged:
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -1543,7 +1543,8 @@ static inline bool of_device_is_system_power_controller(const struct device_node
  */
 
 enum of_overlay_notify_action {
-	OF_OVERLAY_PRE_APPLY = 0,
+	OF_OVERLAY_INIT = 0,	/* kzalloc() of ovcs sets this value */
+	OF_OVERLAY_PRE_APPLY,
 	OF_OVERLAY_POST_APPLY,
 	OF_OVERLAY_PRE_REMOVE,
 	OF_OVERLAY_POST_REMOVE,

