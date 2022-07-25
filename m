Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD59E57F88D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 06:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbiGYEAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 00:00:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiGYEAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 00:00:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AA63BC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658721610; x=1690257610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sjsYWSpI4AaYe5gbtAcmXnJCQxNbFyO5b+Od04NwJIk=;
  b=UvL9Tsr4sYwCouYEu4rCDkM2NoAOqBhdhWZ656XNaGjt7UQGrjzGZfQS
   c3jUcVHROqP8yX7F3e/O9//KP9fyqySAiDwf+Zs5aKDyQchihY8xsVTym
   cGEJn7TBz5sWD3+jGeaIw+lAirv8pEqhFi5C0SaYkpQTc4InIxruR+fSg
   OGVoJ4OmhvaSynxPixhQYNiPnQpyU+DupB0bSA/+SaM6XNuuuwEZybmJG
   4UfWARxkzXw5yQHVX+ZYRHJJw+OBwyfR9KBmXcX+qnp7JEEIPBum2tI5k
   9a18g4vpGjbJqG6UO1IBt6vvH6juJlV00VQkMsVJ1Gm0GuZMdGXsHQ6Ds
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288787530"
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="288787530"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 21:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,191,1654585200"; 
   d="scan'208";a="574882943"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.117])
  by orsmga006.jf.intel.com with ESMTP; 24 Jul 2022 21:00:07 -0700
From:   kah.jing.lee@intel.com
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        arnd@arndb.de
Cc:     rafael.j.wysocki@intel.com, tien.sung.ang@intel.com,
        dinh.nguyen@intel.com, Kah Jing Lee <kah.jing.lee@intel.com>,
        Zhou Furong <furong.zhou@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH v3 3/3] documentation: misc: intel_sysid: Add the system id sysfs documentation for Altera(Intel) FPGA platform
Date:   Mon, 25 Jul 2022 11:59:41 +0800
Message-Id: <20220725035940.649062-1-kah.jing.lee@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220721123258.416802-1-kah.jing.lee@intel.com>
References: <20220721123258.416802-1-kah.jing.lee@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
v2->v3:
- Updated kernel version & date
- Added format for sysid & builtime output
---
---
 .../testing/sysfs-devices-platform-soc-sysid  | 41 +++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-platform-soc-sysid

diff --git a/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
new file mode 100644
index 000000000000..6e40d154601f
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-platform-soc-sysid
@@ -0,0 +1,41 @@
+What:		/sys/devices/platform/soc@X/soc:base_fpga_region/
+soc:base_fpga_region:fpga_pr_region0/XXXXXXXX.sysid/
+Date:		July 2022
+KernelVersion:	v5.20
+Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
+Description:
+		The soc@X/soc:base_fpga_region/soc:base_fpga_region:fpga_pr_region0/
+		XXXXXXXX.sysid/ directory contains read-only attributes exposing
+		information about an System ID soft IP device. The X values could vary,
+		based on the FPGA platform System ID soft IP register address.
+
+What:		.../XXXXXXX.sysid/sysid
+Date:		July 2022
+KernelVersion:	v5.20
+Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
+Description:
+		The .../XXXXXXX.sysid/sysid file contains the System ID for the FPGA
+		platform which is unique for the platform type and can be used for
+		checking the platform type for software download purposes. Sysid value
+		reported is in numerical format, and can also be printed in hex format
+		for human-readable string.
+		E.g:
+			root@agilex:~# cat /sys/bus/platform/drivers/altera_sysid/
+				f9000900.sysid/sysid/id
+			4207856382
+			root@agilex:~# cat /sys/bus/platform/drivers/altera_sysid/
+				f9000900.sysid/sysid/id | xargs printf "0x%08x\n"
+			0xfacecafe
+
+What:		.../XXXXXXX.sysid/buildtime
+Date:		July 2022
+KernelVersion:	v5.20
+Contact:	Kah Jing Lee <kah.jing.lee@intel.com>
+Description:
+		The .../XXXXXXX.sysid/buildtime file contains the buildtime for the
+		FPGA board file generation. Buildtime value reported in
+		<Unix timestamp> (YYYY-mm-dd HH:MM:SS UTC) format.
+		E.g:
+			root@agilex:~# cat /sys/bus/platform/drivers/altera_sysid/
+				f9000900.sysid/sysid/timestamp
+			1637751409 (2021-11-24 10:56:49 UTC)
-- 
2.25.1

