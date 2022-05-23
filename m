Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84E67531628
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiEWSug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 14:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239398AbiEWSiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 14:38:02 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC28C168D32;
        Mon, 23 May 2022 11:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653329840; x=1684865840;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=j6PmUFEBfihBJn4L9py22kWT+PelQuFH5/63xz2cOMU=;
  b=h3CitwUcFNkH3uCVncnSOU9C2DHG1+0R/2w0QsDqmeH4TmPz1+3pQ1T7
   gR1e9Y5O1O3AxDBVeZ9bjw070riHFxkIwto5l+Szy4Tv+kfC1kMVlNaKP
   2SrBda00m72a6eJUKNMWhjjJGUOSPVrnd5gCsVw0PBa4SbZ8KM4oiJK/v
   zFAAGHOR8fLqFlbGTp4V1vBxbhjdwl5sZ+VZhQMZEVc+ci4RMypg0o4Dj
   dnr2vNYGVFWNvyICEY6hUV/olfdRMPm2C9/t3PIYpAjqUhFBaMIozUlL3
   roNThknhxetw9IlqfqmhP1MAbZXCnwF/+Gi2wPLuYB0YRNiFgR6wF3QBf
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="260920336"
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="260920336"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 11:16:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="744865243"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga005.jf.intel.com with ESMTP; 23 May 2022 11:16:58 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, corbet@lwn.net, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     lenb@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, prarit@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] Documentation: admin-guide: pm: Add Out of Band mode
Date:   Mon, 23 May 2022 11:16:55 -0700
Message-Id: <20220523181655.2352470-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation for using the tool to support performance level
change via OOB (Out of Band) interface.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2:
As suggested by Jonathan
- Indent literal block
- Show output of command

 .../admin-guide/pm/intel-speed-select.rst     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/admin-guide/pm/intel-speed-select.rst b/Documentation/admin-guide/pm/intel-speed-select.rst
index 0a1fbdb54bfe..a2bfb971654f 100644
--- a/Documentation/admin-guide/pm/intel-speed-select.rst
+++ b/Documentation/admin-guide/pm/intel-speed-select.rst
@@ -262,6 +262,28 @@ Which shows that the base frequency now increased from 2600 MHz at performance
 level 0 to 2800 MHz at performance level 4. As a result, any workload, which can
 use fewer CPUs, can see a boost of 200 MHz compared to performance level 0.
 
+Changing performance level via BMC Interface
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+It is possible to change SST-PP level using out of band (OOB) agent (Via some
+remote management console, through BMC "Baseboard Management Controller"
+interface). This mode is supported from the Sapphire Rapids processor
+generation. The kernel and tool change to support this mode is added to Linux
+kernel version 5.18. To enable this feature, kernel config
+"CONFIG_INTEL_HFI_THERMAL" is required. The minimum version of the tool
+is "v1.12" to support this feature, which is part of Linux kernel version 5.18.
+
+To support such configuration, this tool can be used as a daemon. Add
+a command line option --oob::
+
+ # intel-speed-select --oob
+ Intel(R) Speed Select Technology
+ Executing on CPU model:143[0x8f]
+ OOB mode is enabled and will run as daemon
+
+In this mode the tool will online/offline CPUs based on the new performance
+level.
+
 Check presence of other Intel(R) SST features
 ---------------------------------------------
 
-- 
2.35.1

