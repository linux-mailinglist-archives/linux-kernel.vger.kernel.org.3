Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A9450C465
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbiDVWLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231981AbiDVWJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:09:35 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE932D823C;
        Fri, 22 Apr 2022 13:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650660986; x=1682196986;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cwJd5e6aeRwgU9xPsGnRNV1wC06YL4Fz8JBExprqrBA=;
  b=MzL1M7mrxG9O455ycAVFH0PzUG2znA0DkXqw9Wgm3CdpcZsN9QJq/ma7
   cp2mIJuZGHVgCuclLckCx0PpqFLQlLNHY4YFNZoz3SEoIfbtDFvMoszUb
   mH8zdtBxQspUqbCr8wUbhbBqRsy30JjXpJ5A0r7zPN7wUGHO0sVMM2avP
   lMVfHcdhGXJODsQqWTjVz3o1/R3hw3KfEOeA04Cj1MyV1XojLQqhT5Jiv
   n5p6rQ97Sh03sMCOc1Lo1AU6hY37B7ZkS/gvsSZXgy9scpKxzvIGyGrCZ
   VdAftODcfUtZahnwW1I6CcESz8rVd/+XS/cVzcaoXS2Azkit7BP/pnpfL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="289897476"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="289897476"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="511719367"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 13:02:29 -0700
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
Subject: [PATCH v4 10/10] platform/x86/intel/ifs: add ABI documentation for IFS
Date:   Fri, 22 Apr 2022 13:02:19 -0700
Message-Id: <20220422200219.2843823-11-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422200219.2843823-1-tony.luck@intel.com>
References: <20220419163859.2228874-1-tony.luck@intel.com>
 <20220422200219.2843823-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 000000000000..486d6d2ff8a0
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-platform-intel-ifs
@@ -0,0 +1,39 @@
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/run_test
+Date:		April 21 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Write <cpu#> to trigger IFS test for one online core.
+		Note that the test is per core. The cpu# can be
+		for any thread on the core. Running on one thread
+		completes the test for the core containing that thread.
+		Example: to test the core containing cpu5: echo 5 >
+		/sys/devices/platform/intel_ifs.<N>/run_test
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/status
+Date:		April 21 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	The status of the last test. It can be one of "pass", "fail"
+		or "untested".
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/details
+Date:		April 21 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Additional information regarding the last test. The details file reports
+		the hex value of the SCAN_STATUS MSR. Note that the error_code field
+		may contain driver defined software code not defined in the Intel SDM.
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/image_version
+Date:		April 21 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Version (hexadecimal) of loaded IFS binary image. If no scan image
+		is loaded reports "none".
+
+What:		/sys/devices/virtual/misc/intel_ifs_<N>/reload
+Date:		April 21 2022
+KernelVersion:	5.19
+Contact:	"Jithu Joseph" <jithu.joseph@intel.com>
+Description:	Write "1" (or "y" or "Y") to reload the IFS image from
+		/lib/firmware/intel/ifs/ff-mm-ss.scan.
-- 
2.35.1

