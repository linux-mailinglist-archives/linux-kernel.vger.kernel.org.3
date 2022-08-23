Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B89959D08C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 07:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240079AbiHWFfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 01:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240039AbiHWFe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 01:34:58 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26195E326
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 22:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661232897; x=1692768897;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zUZCrvll5EIj8yMSFdHa9CHP1hiI8H8cuO2HX4044Po=;
  b=KC27MgJS5U/buiXOTftl113Dnmd0j8YbSklQ+X6NXG2nydba2SfwT0np
   adKLNbkmvC0PQvLd1/9MEsR204J4mpjKA8nVsgIqxX5Igw7ZVJ4JPHJAV
   7CGwXF2ZBjpzchQx7FRJjeswRTWBTinx/UEHOfQzBQGEiktvWEN7xNIpb
   gk1gpJvveWMgzhgk5KNozJejFAPCDFJh075rOp1uNEnk4ecfjmsePxPMG
   jJkSqxOZ0aos74qVuL76vdOw4En8GBjpdJ2wY7kTfqZJNnW2E56rQy8Sv
   ZocGtCZa3VZe1RbATWvqNTV9lbnSg/lnpzMHHBoCmS3lgOT1R2Q3zGb3j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="280568565"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="280568565"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:57 -0700
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="698558266"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 22:34:55 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 03/11] soundwire: intel: remove IPPTR unused definition
Date:   Tue, 23 Aug 2022 13:38:38 +0800
Message-Id: <20220823053846.2684635-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
References: <20220823053846.2684635-1-yung-chuan.liao@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

This read-only register only defines an offset which is known already
and a version which isn't used.

Remove unused definition.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 include/linux/soundwire/sdw_intel.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/soundwire/sdw_intel.h b/include/linux/soundwire/sdw_intel.h
index d9f51f43e42c..581a9ba32f82 100644
--- a/include/linux/soundwire/sdw_intel.h
+++ b/include/linux/soundwire/sdw_intel.h
@@ -27,7 +27,6 @@
 #define SDW_SHIM_LCTL_CPA		BIT(8)
 #define SDW_SHIM_LCTL_CPA_MASK		GENMASK(11, 8)
 
-#define SDW_SHIM_IPPTR			0x8
 #define SDW_SHIM_SYNC			0xC
 
 #define SDW_SHIM_CTLSCAP(x)		(0x010 + 0x60 * (x))
-- 
2.25.1

