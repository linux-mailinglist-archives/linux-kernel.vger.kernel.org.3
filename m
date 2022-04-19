Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 043F35074AA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354948AbiDSQmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354764AbiDSQlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:41:55 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EBE5167E1;
        Tue, 19 Apr 2022 09:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650386351; x=1681922351;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=utZCRiqF7ikdREFmewY7FaeGHvf/w59lzGJRIW68qQI=;
  b=awxZO2s1YKnY5c3GQdJQ3hzxVlLziQDMhYKV6DC2iT9nni4rBQvbR+g+
   Pa2v+LlY8j2OyBz87Yc+UEmq2H7nV+Etp4dM3lfuqm+tn0RQYPl/Q44K3
   QxkdQeDMsGiG5UK+oSaPVm9Ad4w1SH+AFnJfCH/dVlBY6+cTwXD9iBfcv
   x0UeFGqkRVAZ38l1EY2Kel2KzEurTAEXmd5+smkvUBgKyYK9QGbp+ITMX
   x7AsBvyvg+jwu8bL7VNttlcUZmGCJBi0RmYD4lhPi6XOQIpH1N7mNqI1M
   cMUvfc/C8BJEkJk2gSL2+1l2LZ7fBRxfvOHTgCcWCYPypzs7x9wrFYjXK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="245702559"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="245702559"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:10 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="554802177"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 09:39:10 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     hdegoede@redhat.com, markgross@kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        corbet@lwn.net, gregkh@linuxfoundation.org,
        andriy.shevchenko@linux.intel.com, jithu.joseph@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com, rostedt@goodmis.org,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com
Subject: [PATCH v3 11/11] platform/x86/intel/ifs: add ABI documentation for IFS
Date:   Tue, 19 Apr 2022 09:38:59 -0700
Message-Id: <20220419163859.2228874-12-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419163859.2228874-1-tony.luck@intel.com>
References: <20220407191347.9681-1-jithu.joseph@intel.com>
 <20220419163859.2228874-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

Add the sysfs attributes in ABI/testing for In-Field Scan.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Co-developed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 .../ABI/testing/sysfs-platform-intel-ifs      | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-intel-ifs

diff --git a/Documentation/ABI/testing/sysfs-platform-intel-ifs b/Documentation/ABI/testing/sysfs-platform-intel-ifs
new file mode 100644
index 000000000000..7a753c9f2dd7
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -0,0 +1,39 @@
+What:		/sys/devices/platform/intel_ifs.<N>/run_test
+Date:		April 13, 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Write <cpu#> to trigger IFS test for one online core.
+		Note that the test is per core. The cpu# can be
+		for any thread on the core. Running on one thread
+		completes the test for the core containing that thread.
+		Example: to test the core containing cpu5: echo 5 >
+		/sys/devices/platform/intel_ifs.<N>/run_test
+
+What:		/sys/devices/platform/intel_ifs.<N>/status
+Date:		April 13, 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	The status of the last test. It can be one of "pass", "fail"
+		or "untested".
+
+What:		/sys/devices/system/cpu/cpu#/ifs.<N>/details
+Date:		April 13, 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Additional information regarding the last test. The details file reports
+		the hex value of the SCAN_STATUS MSR. Note that the error_code field
+		may contain driver defined software code not defined in the Intel SDM.
+
+What:		/sys/devices/platform/intel_ifs.<N>/image_version
+Date:		April 13, 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
+		is loaded reports "none".
+
+What:		/sys/bus/platform/drivers/intel_ifs.<N>/reload
+Date:		April 13, 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Write "1" > reload to reload IFS image from
+		/lib/firmware/intel/ifs/ff-mm-ss.scan.
-- 
2.35.1

