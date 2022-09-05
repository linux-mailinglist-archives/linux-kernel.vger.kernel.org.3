Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4BE5AC874
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 03:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiIEBPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 21:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIEBPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 21:15:36 -0400
Received: from m12-16.163.com (m12-16.163.com [220.181.12.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D13827FE8
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 18:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=0UuRi
        XnqG0+tWCBmLnMTBzneooWmRUaaLB3aIEKok50=; b=B/g2VYj4DClm3qOwnvLq7
        tOxL++OAJdWE7KTFeqsCUVEYo46j2OWmSurWdTy0WBh2+zmzZuakLA1yF0F8poZ8
        kfLoUppQgkPl4walQsJpDc5a8B7kq8SDHmbVTKEjph5kS+88Nb/hC5bplaMdMDkL
        xmLVDdRtEcBdQL2Zk+hnG0=
Received: from f00160-VMware-Virtual-Platform.localdomain (unknown [1.203.67.201])
        by smtp12 (Coremail) with SMTP id EMCowAAncaJ8TRVj3hDsJg--.51831S4;
        Mon, 05 Sep 2022 09:14:54 +0800 (CST)
From:   Jingyu Wang <jingyuwang_vip@163.com>
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        Xinhui.Pan@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        mario.limonciello@amd.com, hdegoede@redhat.com,
        rafael.j.wysocki@intel.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Jingyu Wang <jingyuwang_vip@163.com>
Subject: [PATCH] drm/amdgpu: cleanup coding style in amdgpu_acpi.c
Date:   Mon,  5 Sep 2022 09:14:31 +0800
Message-Id: <20220905011431.19818-1-jingyuwang_vip@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EMCowAAncaJ8TRVj3hDsJg--.51831S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7trykur48Xw1rZrWUJrWrKrg_yoW8uF4fpF
        ySqr1Fkry5uF12vFyjyFy8ZFn0yw4I934xWFWxZ34ag3W5ZFyrJa48Cw4Uur97JrZxua1x
        JFZrJ3yUuF4jvw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pEsXonUUUUU=
X-Originating-IP: [1.203.67.201]
X-CM-SenderInfo: 5mlqw5xxzd0whbyl1qqrwthudrp/xtbCoAdzF1zmWEIQ-gAAsN
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix everything checkpatch.pl complained about in amdgpu_acpi.c

Signed-off-by: Jingyu Wang <jingyuwang_vip@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
index 55402d238919..3da27436922c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_acpi.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: MIT
 /*
  * Copyright 2012 Advanced Micro Devices, Inc.
  *
@@ -849,6 +850,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 		if (amdgpu_device_has_dc_support(adev)) {
 #if defined(CONFIG_DRM_AMD_DC)
 			struct amdgpu_display_manager *dm = &adev->dm;
+
 			if (dm->backlight_dev[0])
 				atif->bd = dm->backlight_dev[0];
 #endif
@@ -863,6 +865,7 @@ int amdgpu_acpi_init(struct amdgpu_device *adev)
 				if ((enc->devices & (ATOM_DEVICE_LCD_SUPPORT)) &&
 				    enc->enc_priv) {
 					struct amdgpu_encoder_atom_dig *dig = enc->enc_priv;
+
 					if (dig->bl_dev) {
 						atif->bd = dig->bl_dev;
 						break;
@@ -919,9 +922,9 @@ static bool amdgpu_atif_pci_probe_handle(struct pci_dev *pdev)
 		return false;
 
 	status = acpi_get_handle(dhandle, "ATIF", &atif_handle);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		return false;
-	}
+
 	amdgpu_acpi_priv.atif.handle = atif_handle;
 	acpi_get_name(amdgpu_acpi_priv.atif.handle, ACPI_FULL_PATHNAME, &buffer);
 	DRM_DEBUG_DRIVER("Found ATIF handle %s\n", acpi_method_name);
@@ -954,9 +957,9 @@ static bool amdgpu_atcs_pci_probe_handle(struct pci_dev *pdev)
 		return false;
 
 	status = acpi_get_handle(dhandle, "ATCS", &atcs_handle);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		return false;
-	}
+
 	amdgpu_acpi_priv.atcs.handle = atcs_handle;
 	acpi_get_name(amdgpu_acpi_priv.atcs.handle, ACPI_FULL_PATHNAME, &buffer);
 	DRM_DEBUG_DRIVER("Found ATCS handle %s\n", acpi_method_name);

base-commit: e47eb90a0a9ae20b82635b9b99a8d0979b757ad8
-- 
2.34.1

