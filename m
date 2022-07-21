Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4295B57CAAB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 14:33:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233618AbiGUMdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 08:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGUMdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 08:33:14 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9CC743C4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 05:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658406794; x=1689942794;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9Mastm4bVBpgeITeul311rbm3Z4aqMWvLnpkTWQve5Q=;
  b=OJSP0q9ssN1S2rjiNsljXOHqaAno/TNMr3Br+Z+VY8lwyD1lGFVmA5dK
   Xhy4yeAPQNhyzCH3sNeTb3rUNiuEEJhdNJGSgvKI6g8gGOltx3jhbEYNW
   a55q0B0FV15QtgpPhAXMUW1tzEhsfQ27/45SEs+JX1D1DphzvSQQdGtjq
   GPaO2g/bzuueM8fwtOmb6LYAq0MWdYRau2M2aAXjRjGSt2So4S60wqzQT
   ADT7YSDggangEkogZy3Zfnzz9b9zoGbqRXT4B0Ewkak6++7UIFnAesi7D
   Bhf4buuKjWd7p/Fr4dEMr1pbK+6Hc4EIxZaSWwR2QLKz442IIuMWu5igm
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="373332458"
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="373332458"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 05:33:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,289,1650956400"; 
   d="scan'208";a="573720813"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga006.jf.intel.com with ESMTP; 21 Jul 2022 05:33:11 -0700
From:   kah.jing.lee@intel.com
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v2 3/3] documentation: misc: intel_sysid: Add the system id sysfs documentation for Altera(Intel) FPGA platform
Date:   Thu, 21 Jul 2022 20:32:59 +0800
Message-Id: <20220721123258.416802-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721123017.416438-1-kah.jing.lee@intel.com>
References: <20220721123017.416438-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kah Jing Lee <kah.jing.lee@intel.com>

This sysfs documentation is created for Altera(Intel) FPGA platform
System ID soft IP. The Altera(Intel) Sysid component is generally
part of an FPGA design.
The component can be hotplugged when the FPGA is reconfigured.

Based on an initial contribution from Ley Foon Tan at Altera
Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
Reviewed-by: Zhou Furong <furong.zhou@intel.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 .../testing/sysfs-devices-platform-soc-sysid  | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-soc-sysid

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
new file mode 100644
index 000000000000..9fa58fd88dc0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
@@ -0,0 +1,27 @@
+What:		/sys/devices/platform/soc@X/soc:base_fpga_region/
+soc:base_fpga_region:fpga_pr_region0/XXXXXXXX.sysid/
+Date:		May 2022
+KernelVersion:	v5.18
+Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
+Description:
+		The soc@X/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/
+		XXXXXXXX.sysid/ directory contains read-only attributes exposing
+		information about an System ID soft IP device. The X values could vary,
+		based on the FPGA platform System ID soft IP register address.
+
+What:		.../XXXXXXX.sysid/sysid
+Date:		May 2022
+KernelVersion:	v5.18
+Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
+Description:
+		The .../XXXXXXX.sysid/sysid file contains the System ID for the FPGA
+		platform which is unique for the platform type and can be used for
+		checking the platform type for software download purposes.
+
+What:		.../XXXXXXX.sysid/buildtime
+Date:		May 2022
+KernelVersion:	v5.18
+Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
+Description:
+		The .../XXXXXXX.sysid/buildtime file contains the buildtime for the
+		FPGA board file generation.
-- 
2.25.1

