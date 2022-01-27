Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3640349E791
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:32:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbiA0Qct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:32:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:21477 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231582AbiA0Qcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:32:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643301168; x=1674837168;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qHtnmHHl44LJl67NSL8iI4+OJQIdTqauFcVwcSBgZAw=;
  b=gK1Taf3fJH0sZ5i+Gk9nDy1oq7EvJgi5xeUupfhtITCG6y6sRrtI2NLl
   vzFgF4ytgN0x0ApbMkv7l+GfXs9r/ftYHPLfPph9vkrp5SKfkRlevv/mX
   CFK2bQ51qGt1BTItsJbE+7tVaVakSC4rgphdi0ezvr5//bK7t9DLaJeq+
   yADzoJMmf361ozD1nhOiJ36esFKkoItgw47HrAlEnCv+f3YYdaaZiaQxs
   mnYHUmnvLtUjC/nPAkBUoqh9Yw3uwRzRYu73TzJTT6e+ozqRKH6sndrLE
   dd7oNcMpSIdonWb7g2+IIUszsKq+Z2PIbGFrmO06oeX4XTC3M/6vIQB7b
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246681475"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246681475"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 08:32:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="696715228"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Jan 2022 08:32:46 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8F894167; Thu, 27 Jan 2022 18:32:59 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Florian Eckert <fe@dev.tdt.de>
Subject: [PATCH v2 1/1] docs: process: submitting-patches: Clarify the Reported-by usage
Date:   Thu, 27 Jan 2022 18:32:58 +0200
Message-Id: <20220127163258.48482-1-andriy.shevchenko@linux.intel.com>
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
v2: rephrased as suggested by Jonathan
 Documentation/process/submitting-patches.rst | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/process/submitting-patches.rst b/Documentation/process/submitting-patches.rst
index 31ea120ce531..fb496b2ebfd3 100644
--- a/Documentation/process/submitting-patches.rst
+++ b/Documentation/process/submitting-patches.rst
@@ -495,7 +495,8 @@ Using Reported-by:, Tested-by:, Reviewed-by:, Suggested-by: and Fixes:
 The Reported-by tag gives credit to people who find bugs and report them and it
 hopefully inspires them to help us again in the future.  Please note that if
 the bug was reported in private, then ask for permission first before using the
-Reported-by tag.
+Reported-by tag. The tag is intended for bugs; please do not use it to credit
+feature requests.
 
 A Tested-by: tag indicates that the patch has been successfully tested (in
 some environment) by the person named.  This tag informs maintainers that
-- 
2.34.1

