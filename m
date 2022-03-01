Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E93264C953B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 20:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbiCAT5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 14:57:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236985AbiCAT4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 14:56:38 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1966D4EA;
        Tue,  1 Mar 2022 11:55:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646164556; x=1677700556;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=XLKybxN7zciO2WXoGtuDgQD2mqkuZlXQf8E59ZXt5Es=;
  b=PNSan40XMbcMUS7buMvRb+LugAbSQgBBlcc0mn3U2YHeaPhca+D64DCe
   Tx3YNDnCbKhRBSI6ekOQb9nwcA48HpOnR/G8LwSVJ8OTMCf6BB2yenNlV
   Jd2brfRTA2+1F4WG+XpbAfnZBV/x1r21Tz2H2TXDD5CCk16UKwb8IqPQm
   FF3zTN84msu71q1pVLFmxo1hJr8XYtqRAA3u+O9ndYyMrEwkHIgQ0q2wd
   ShOwgshPXoVUKwthfNzvKONwzeAFMB/WIrMQ07++xq5v0FUVo/sgc6tq6
   m5GHSeHLCoaS4vVXJtEtq498z/ZhGuIFk/4uHBRiiI3qUvUdmN0soroK/
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10273"; a="233194903"
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="233194903"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
X-IronPort-AV: E=Sophos;i="5.90,146,1643702400"; 
   d="scan'208";a="630133180"
Received: from coffy.sc.intel.com ([10.3.79.166])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2022 11:55:54 -0800
From:   Jithu Joseph <jithu.joseph@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com
Subject: [RFC 09/10] platform/x86/intel/ifs: add ABI documentation for IFS
Date:   Tue,  1 Mar 2022 11:54:56 -0800
Message-Id: <20220301195457.21152-10-jithu.joseph@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220301195457.21152-1-jithu.joseph@intel.com>
References: <20220301195457.21152-1-jithu.joseph@intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the sysfs attributes in ABI/stable for In-Field Scan.

Originally-by: Kyung Min Park <kyung.min.park@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Reviewed-by: Ashok Raj <ashok.raj@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 Documentation/ABI/stable/sysfs-driver-ifs | 85 +++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 Documentation/ABI/stable/sysfs-driver-ifs

diff --git a/Documentation/ABI/stable/sysfs-driver-ifs b/Documentation/ABI/stable/sysfs-driver-ifs
new file mode 100644
index 000000000000..8b6b9472f57e
--- /dev/null
+++ b/Documentation/ABI/stable/sysfs-driver-ifs
@@ -0,0 +1,85 @@
+What:		/sys/devices/system/cpu/ifs/run_test
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	echo 1 to trigger ifs test for all online cores.
+
+What:		/sys/devices/system/cpu/ifs/status
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	Global status. Shows the most serious status across
+		all cores (fail > untested > pass)
+
+What:		/sys/devices/system/cpu/ifs/image_version
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	Version of loaded IFS binary image.
+
+What:		/sys/devices/system/cpu/ifs/reload
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	echo 1 to reload IFS image.
+
+What:		/sys/devices/system/cpu/ifs/cpu_pass_list
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	List of cpus which passed the IFS test.
+
+What:		/sys/devices/system/cpu/ifs/cpu_fail_list
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	List of cpus which failed the IFS test.
+
+What:		/sys/devices/system/cpu/ifs/cpu_untested_list
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	List of cpus which could not be tested.
+
+What:		/sys/module/intel_ifs/parameters/noint
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	SAF tunable parameter that user can modify before
+		the scan run if they wish to override default value.
+
+		When set, system interrupts are not allowed to interrupt an IFS. The
+		default state for this parameter is set.
+
+What:		/sys/module/intel_ifs/parameters/retry
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	SAF tunable parameter that user can modify at
+		load time if they wish to override default value.
+
+		Maximum retry counter when the test is not executed due to an
+		event such as interrupt. The default value is 5, it can be set to any
+		value from 1 to 20.
+
+What:		/sys/devices/system/cpu/cpu#/ifs/run_test
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	IFS target core testing. echo 1 to trigger scan test on cpu#.
+
+What:		/sys/devices/system/cpu/cpu#/ifs/status
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	The status of IFS test on a specific cpu#. It can be one of "pass", "fail"
+		or "untested".
+
+What:		/sys/devices/system/cpu/cpu#/ifs/details
+Date:		Feb 28, 2022
+KernelVersion:	5.18.0
+Contact:	linux-kernel@vger.kernel.org
+Description:	The details file reports the hex value of the SCAN_STATUS MSR. Note that
+		the error_code field may contain driver defined software code not defined
+		in the Intel SDM.
+
-- 
2.17.1

