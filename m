Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E3CC5738C2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 16:26:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbiGMOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGMOZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 10:25:41 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84FF33341
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 07:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657722340; x=1689258340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPnnb0fU/qVJlOwgD1izgy0CaO2aldoMjVq4ZHg4Azw=;
  b=mqytc9ks9JCBEX5f2+FE1WX11Wjwu3IKHDSNrNv8c8joZGhkwRJxjp7B
   d8lxex7uc3taQJw6H/OvNeKRqjP2BJuwoTyE1Z923sWq0sXSrmi1dFGUY
   h86spSK6ths3QjwGg1nqsmGexUE8hvyeBnUXYIxjJDTgpGfGKFxBes4Jk
   pFD/+Y55I6IvOyxG5dG4VfeRjYEfEP41FEwq0uwRUhvUTfDRR0RYtASiY
   qIfNUu34afPKx4tQ7EOec4I6dbLy8dyO8Xx9AsIaO/7PA+2I4NvjWNu7n
   dL3s4QNG+O8W7/q0Cj/YmyK+Bg/Znhc/UKI3IftWFLdwep5D4S1MOotLM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10407"; a="285968186"
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="285968186"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:25:40 -0700
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="570643753"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2022 07:25:38 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: bus: rename sdw_ida as sdw_bus_ida
Date:   Wed, 13 Jul 2022 22:25:27 +0800
Message-Id: <20220713142529.17323-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
References: <20220713142529.17323-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

To avoid confusions with follow-up patches using a IDA mechanism for
peripheral 'device number' allocation, rename sdw_ida as sdw_bus_ida.

Pure rename, no functionality change.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/bus.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/soundwire/bus.c b/drivers/soundwire/bus.c
index 8d4000664fa3..37638c20c804 100644
--- a/drivers/soundwire/bus.c
+++ b/drivers/soundwire/bus.c
@@ -11,11 +11,11 @@
 #include "bus.h"
 #include "sysfs_local.h"
 
-static DEFINE_IDA(sdw_ida);
+static DEFINE_IDA(sdw_bus_ida);
 
 static int sdw_get_id(struct sdw_bus *bus)
 {
-	int rc = ida_alloc(&sdw_ida, GFP_KERNEL);
+	int rc = ida_alloc(&sdw_bus_ida, GFP_KERNEL);
 
 	if (rc < 0)
 		return rc;
@@ -179,7 +179,7 @@ void sdw_bus_master_delete(struct sdw_bus *bus)
 	sdw_master_device_del(bus);
 
 	sdw_bus_debugfs_exit(bus);
-	ida_free(&sdw_ida, bus->id);
+	ida_free(&sdw_bus_ida, bus->id);
 }
 EXPORT_SYMBOL(sdw_bus_master_delete);
 
-- 
2.25.1

