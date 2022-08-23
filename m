Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA30B59D02F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 06:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbiHWEqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 00:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239292AbiHWEqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 00:46:17 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9ECF52FEE
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 21:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661229976; x=1692765976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IPnnb0fU/qVJlOwgD1izgy0CaO2aldoMjVq4ZHg4Azw=;
  b=aUifaUWa+1n45Omla3+aDpL51Q5KH0zpvNWZGhHWXoBkjwUE6lnSuF06
   GGnqVHSAD4Si1Cq6r6RQ2xMDSkY/u2lB9fmxR0rrK9TlfNZULWwQadhg5
   WtM1+yogXg99n9J5m4ViUGNsrhRZiEIs3U6li9yeihn6dYnVqNnCDSE5+
   FL/mJyHc0oRvCO+zKolKFK57VqftiFBw7bW/qhQR9jdtkQxdArHT9Dvu/
   bPduXDjeZ6C0I6CBy7y/AqZzAp/9ZYMoeJFo18ZuH7TXDBKnZsosrorFp
   H8vyQCYrFAEacbc+wWeJ75yzzx8eIPtH6mkPeB3YyqpOR0j3PqvmwMwwG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291146781"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291146781"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:16 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="669855093"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 21:46:15 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 1/3] soundwire: bus: rename sdw_ida as sdw_bus_ida
Date:   Tue, 23 Aug 2022 12:50:02 +0800
Message-Id: <20220823045004.2670658-2-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
References: <20220823045004.2670658-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

