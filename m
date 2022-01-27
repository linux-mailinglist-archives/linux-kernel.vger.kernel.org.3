Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00C49E6BD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243298AbiA0Px3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:53:29 -0500
Received: from mga06.intel.com ([134.134.136.31]:3117 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237754AbiA0Px2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:53:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643298808; x=1674834808;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WdEb1ilNidCIDGY6NLsRhMxlByQjbKF0GxWuJf1/mhY=;
  b=WVg0fNtt84MNxam9Ox2t0o2DL8Pt1SZ22RJtxmTQqgrYVo/qXT7KbpN6
   3Wmy4XjUAcrl8l5z+hIwhNbwYjFJuAmZFqp1XuNrEkeL5ijZx9gTLr9gc
   LjlGP04dbdI5GwkQnYb60I8skXM6d9l0MFGwW8ZR46dJR+/gLtU+yPI+N
   m3nIx4pn4BZ0NWmvsKtF17OH3jtFNx5yOhDBglX8bq6pV2Zljr2aYi4gs
   R8Ejp26UaPPUjltbenjT/ZsT3eThbNAweeT4lWhT4TyKiiSHrawesKguT
   AhaAy3h7YiFiPTILkpXj5uFfhnVGy26uW4VIrT0ZTG64Ft0EUFIC7fUl0
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307603734"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="307603734"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 07:53:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674757728"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jan 2022 07:53:26 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CCD67167; Thu, 27 Jan 2022 17:53:39 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v1 1/1] docs: process: submitting-patches: Clarify the Reported-by usage
Date:   Thu, 27 Jan 2022 17:53:34 +0200
Message-Id: <20220127155334.47154-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's unclear from "Submitting Patches" documentation that Reported-by
is not supposed to be used against new features. (It's more clear
in the section 5.4 "Patch formatting and changelogs" of the "A guide
to the Kernel Development Process", where it suggests that change
should fix something existing in the kernel. Clarify the Reported-by
usage in the "Submitting Patches".

Reported-by: Florian Eckert <fe@dev.tdt.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/process/submitting-patches.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 31ea120ce531..24c1a5565385 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
 The Reported-by tag gives credit to people who find bugs and report them and it
 hopefully inspires them to help us again in the future.  Please note that if
 the bug was reported in private, then ask for permission first before using the
-Reported-by tag.
+Reported-by tag. A new feature can't be reported since there is no code in the
+kernel to fix.
 
 A Tested-by: tag indicates that the patch has been successfully tested (in
 some environment) by the person named.  This tag informs maintainers that
-- 
2.34.1

