Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEEE595442
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiHPH5l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiHPH4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:56:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35E6DB7ED;
        Mon, 15 Aug 2022 22:12:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660626774; x=1692162774;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=uNmyJGFQ0sIPiZsSeZdd651qCRfEeR1fmTyxguCl9bY=;
  b=WiU607FOLSw+SPGbfyQBWNdhaazxcoHui9/vt7osQprx1JV7i/HVlPxJ
   6oAD+JdHutU8YMzk/jQZ1UfFC7b0CZuIUtnqElS5cjU3DFcR5qgVhi4It
   htG2RZvNr/mrT6AlBBFZgv5Ydot/T3SR6zFo/8BAHViT75gPuHpdL9Rdv
   6lVw3407NGFaoyTr48Cp+7tmz4PlXSZX7+x/tF07A1l6o6wOEUqyPYg8b
   gMkgd3/469TAslPRhou0Nviak8GJ2uFOx3voyZqk+ROFBd0LDdhXDz/+6
   teXCP8QWvmiu5U2LRT1BKkOKKc+L3hmeYrwxU7hbVYTN4mERHyAOcQYnc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="356130141"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="356130141"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 22:12:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="666953455"
Received: from power-sh.sh.intel.com ([10.239.183.122])
  by fmsmga008.fm.intel.com with ESMTP; 15 Aug 2022 22:12:51 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com, rui.zhang@intel.com
Subject: [PATCH V2 2/8] hwmon/coretemp: Rename indx to index
Date:   Tue, 16 Aug 2022 13:16:27 +0800
Message-Id: <20220816051633.17775-3-rui.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816051633.17775-1-rui.zhang@intel.com>
References: <20220816051633.17775-1-rui.zhang@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use variable name 'index' instead of 'indx' for the index in the
core_data[] array.

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/hwmon/coretemp.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
index ccf0af5b988a..bfdcfe8ccb34 100644
--- a/drivers/hwmon/coretemp.c
+++ b/drivers/hwmon/coretemp.c
@@ -515,15 +515,15 @@ coretemp_add_core(struct platform_device *pdev, unsigned int cpu, int pkg_flag)
 		dev_err(&pdev->dev, "Adding Core %u failed\n", cpu);
 }
 
-static void coretemp_remove_core(struct platform_data *pdata, int indx)
+static void coretemp_remove_core(struct platform_data *pdata, int index)
 {
-	struct temp_data *tdata = pdata->core_data[indx];
+	struct temp_data *tdata = pdata->core_data[index];
 
 	/* Remove the sysfs attributes */
 	sysfs_remove_group(&pdata->hwmon_dev->kobj, &tdata->attr_group);
 
-	kfree(pdata->core_data[indx]);
-	pdata->core_data[indx] = NULL;
+	kfree(pdata->core_data[index]);
+	pdata->core_data[index] = NULL;
 }
 
 static int coretemp_probe(struct platform_device *pdev)
@@ -647,7 +647,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	struct platform_device *pdev = coretemp_get_pdev(cpu);
 	struct platform_data *pd;
 	struct temp_data *tdata;
-	int indx, target;
+	int index, target;
 
 	/*
 	 * Don't execute this on suspend as the device remove locks
@@ -661,12 +661,12 @@ static int coretemp_cpu_offline(unsigned int cpu)
 		return 0;
 
 	/* The core id is too big, just return */
-	indx = TO_ATTR_NO(cpu);
-	if (indx > MAX_CORE_DATA - 1)
+	index = TO_ATTR_NO(cpu);
+	if (index > MAX_CORE_DATA - 1)
 		return 0;
 
 	pd = platform_get_drvdata(pdev);
-	tdata = pd->core_data[indx];
+	tdata = pd->core_data[index];
 
 	cpumask_clear_cpu(cpu, &pd->cpumask);
 
@@ -677,7 +677,7 @@ static int coretemp_cpu_offline(unsigned int cpu)
 	 */
 	target = cpumask_any_and(&pd->cpumask, topology_sibling_cpumask(cpu));
 	if (target >= nr_cpu_ids) {
-		coretemp_remove_core(pd, indx);
+		coretemp_remove_core(pd, index);
 	} else if (tdata && tdata->cpu == cpu) {
 		mutex_lock(&tdata->update_lock);
 		tdata->cpu = target;
-- 
2.25.1

