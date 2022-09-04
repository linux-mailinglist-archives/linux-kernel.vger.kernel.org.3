Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600135AC37F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 10:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbiIDI4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 04:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiIDIz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 04:55:58 -0400
X-Greylist: delayed 907 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 04 Sep 2022 01:55:56 PDT
Received: from m12-18.163.com (m12-18.163.com [220.181.12.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C84D41993
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 01:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=trq9m
        Cm5wrYfaBcrg7Qyz492XenZKTBbpI4PqsuVuQ0=; b=hhQoOPJVi/p645MTP0flY
        tkojayRrsVYSvtlLbJr4cXrPm9CZddeNkDZ8HMBMYBLsakYSQc66rVLIJ4r7GcdL
        FDlMC8SZCY8fWKKCfUZDKNaPLcfieoB26ORBgSGIEe51R64i/cwV+k36S6uIIM1E
        b1xb5nq9jd3j5AVi1dGkLA=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp14 (Coremail) with SMTP id EsCowABHmfQ0ZBRjya_EDg--.56376S4;
        Sun, 04 Sep 2022 16:40:32 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        evan.quan@amd.com, mario.limonciello@amd.com,
        Hawking.Zhang@amd.com, andrey.grodzovsky@amd.com,
        solomon.chiu@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm: amd: This is a patch to the amdgpu_drv.c file that fixes some warnings and errors found by the checkpatch.pl tool
Date:   Sun,  4 Sep 2022 16:39:12 +0800
Message-Id: <20220904083912.1006262-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EsCowABHmfQ0ZBRjya_EDg--.56376S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxtr4rCFW8tF1DuF4xGr1UGFg_yoWxWFyxpF
        WfCr97trWxZr42qryDJrs3WFn0ga48XrW8XayDZrW2gwn7GFn5Ga1xtasYgF9rWrs3ur4x
        XrykJ3y7Wa4FvaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEVc_7UUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbBaR9yF1Xly0hTpwACsW
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 40 ++++++++++++-------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index de7144b06e93..5c2ac8123450 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -140,8 +140,8 @@ uint amdgpu_pcie_lane_cap;
 u64 amdgpu_cg_mask = 0xffffffffffffffff;
 uint amdgpu_pg_mask = 0xffffffff;
 uint amdgpu_sdma_phase_quantum = 32;
-char *amdgpu_disable_cu = NULL;
-char *amdgpu_virtual_display = NULL;
+char *amdgpu_disable_cu;
+char *amdgpu_virtual_display;
 
 /*
  * OverDrive(bit 14) disabled by default
@@ -287,9 +287,9 @@ module_param_named(msi, amdgpu_msi, int, 0444);
  * jobs is 10000. The timeout for compute is 60000.
  */
 MODULE_PARM_DESC(lockup_timeout, "GPU lockup timeout in ms (default: for bare metal 10000 for non-compute jobs and 60000 for compute jobs; "
-		"for passthrough or sriov, 10000 for all jobs."
-		" 0: keep default value. negative: infinity timeout), "
-		"format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
+		"for passthrough or sriov, 10000 for all jobs.
+		0: keep default value. negative: infinity timeout),
+		format: for bare metal [Non-Compute] or [GFX,Compute,SDMA,Video]; "
 		"for passthrough or sriov [all jobs] or [GFX,Compute,SDMA,Video].");
 module_param_string(lockup_timeout, amdgpu_lockup_timeout, sizeof(amdgpu_lockup_timeout), 0444);
 
@@ -502,7 +502,7 @@ module_param_named(virtual_display, amdgpu_virtual_display, charp, 0444);
  * Set how much time allow a job hang and not drop it. The default is 0.
  */
 MODULE_PARM_DESC(job_hang_limit, "how much time allow a job hang and not drop it (default 0)");
-module_param_named(job_hang_limit, amdgpu_job_hang_limit, int ,0444);
+module_param_named(job_hang_limit, amdgpu_job_hang_limit, int, 0444);
 
 /**
  * DOC: lbpw (int)
@@ -565,8 +565,8 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
  */
 #ifdef CONFIG_DRM_AMDGPU_SI
 
-#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_si_support = 0;
+#if IS_ENABLED(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
+int amdgpu_si_support;
 MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
 #else
 int amdgpu_si_support = 1;
@@ -584,8 +584,8 @@ module_param_named(si_support, amdgpu_si_support, int, 0444);
  */
 #ifdef CONFIG_DRM_AMDGPU_CIK
 
-#if defined(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_cik_support = 0;
+#if IS_ENABLED(CONFIG_DRM_RADEON) || defined(CONFIG_DRM_RADEON_MODULE)
+int amdgpu_cik_support;
 MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
 #else
 int amdgpu_cik_support = 1;
@@ -601,8 +601,8 @@ module_param_named(cik_support, amdgpu_cik_support, int, 0444);
  * E.g. 0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte. The default is 0 (disabled).
  */
 MODULE_PARM_DESC(smu_memory_pool_size,
-	"reserve gtt for smu debug usage, 0 = disable,"
-		"0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
+	"reserve gtt for smu debug usage, 0 = disable,
+		0x1 = 256Mbyte, 0x2 = 512Mbyte, 0x4 = 1 Gbyte, 0x8 = 2GByte");
 module_param_named(smu_memory_pool_size, amdgpu_smu_memory_pool_size, uint, 0444);
 
 /**
@@ -772,9 +772,9 @@ module_param(hws_gws_support, bool, 0444);
 MODULE_PARM_DESC(hws_gws_support, "Assume MEC2 FW supports GWS barriers (false = rely on FW version check (Default), true = force supported)");
 
 /**
-  * DOC: queue_preemption_timeout_ms (int)
-  * queue preemption timeout in ms (1 = Minimum, 9000 = default)
-  */
+ * DOC: queue_preemption_timeout_ms (int)
+ * queue preemption timeout in ms (1 = Minimum, 9000 = default)
+ */
 int queue_preemption_timeout_ms = 9000;
 module_param(queue_preemption_timeout_ms, int, 0644);
 MODULE_PARM_DESC(queue_preemption_timeout_ms, "queue preemption timeout in ms (1 = Minimum, 9000 = default)");
@@ -799,7 +799,7 @@ MODULE_PARM_DESC(no_system_mem_limit, "disable system memory limit (false = defa
  * DOC: no_queue_eviction_on_vm_fault (int)
  * If set, process queues will not be evicted on gpuvm fault. This is to keep the wavefront context for debugging (0 = queue eviction, 1 = no queue eviction). The default is 0 (queue eviction).
  */
-int amdgpu_no_queue_eviction_on_vm_fault = 0;
+int amdgpu_no_queue_eviction_on_vm_fault;
 MODULE_PARM_DESC(no_queue_eviction_on_vm_fault, "No queue eviction on VM fault (0 = queue eviction, 1 = no queue eviction)");
 module_param_named(no_queue_eviction_on_vm_fault, amdgpu_no_queue_eviction_on_vm_fault, int, 0444);
 #endif
@@ -1609,7 +1609,7 @@ static const u16 amdgpu_unsupported_pciidlist[] = {
 };
 
 static const struct pci_device_id pciidlist[] = {
-#ifdef  CONFIG_DRM_AMDGPU_SI
+#ifdef CONFIG_DRM_AMDGPU_SI
 	{0x1002, 0x6780, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6784, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
 	{0x1002, 0x6788, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_TAHITI},
@@ -2289,7 +2289,6 @@ static void amdgpu_drv_delayed_reset_work_handler(struct work_struct *work)
 			amdgpu_amdkfd_device_init(adev);
 		amdgpu_ttm_set_buffer_funcs_status(adev, true);
 	}
-	return;
 }
 
 static int amdgpu_pmops_prepare(struct device *dev)
@@ -2478,6 +2477,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	/* wait for all rings to drain before suspending */
 	for (i = 0; i < AMDGPU_MAX_RINGS; i++) {
 		struct amdgpu_ring *ring = adev->rings[i];
+
 		if (ring && ring->sched.ready) {
 			ret = amdgpu_fence_wait_empty(ring);
 			if (ret)
@@ -2600,6 +2600,7 @@ long amdgpu_drm_ioctl(struct file *filp,
 	struct drm_file *file_priv = filp->private_data;
 	struct drm_device *dev;
 	long ret;
+
 	dev = file_priv->minor->dev;
 	ret = pm_runtime_get_sync(dev->dev);
 	if (ret < 0)
@@ -2664,9 +2665,8 @@ int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv)
 	if (!filp)
 		return -EINVAL;
 
-	if (filp->f_op != &amdgpu_driver_kms_fops) {
+	if (filp->f_op != &amdgpu_driver_kms_fops)
 		return -EINVAL;
-	}
 
 	file = filp->private_data;
 	*fpriv = file->driver_priv;
-- 
2.34.1

