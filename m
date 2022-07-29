Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EBC584941
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 03:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiG2BLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 21:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiG2BLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 21:11:17 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D3D1A06C
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 18:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659057076; x=1690593076;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YNlJolEurApgTUkIs0/evgOyk6Uz5HPUuX//m5/T024=;
  b=hADBLNTvipkxz2l9LDFEbnLd+x3Z9Z+wssM2xZbb0fns/CFR7aZRZroC
   VmJitMzBO2qjhb9gR9JkbtJLvv7aMFjmy37wghev0P7nG58VmaZeYUVZu
   JBN7rBzHUTtCcOrSBvr0E4GP56PvBewOjZon6r8dlbRzSt9d0WfU+IRRz
   ayqfwSvxi3p91GTI66Ni4Z73Oz5TCRptWHvB7JY364mgHBQ+sXXswL357
   Fxbv3jooFpCgklmY/ty1BwFXsTkTWooCPez3e3A/kjmKjaIoZBOA9RHO3
   4sLnd/Adq4lUYoS5a61yG9zaODwUDiGwijZlsgzo7IfrZcQnwHnqsVqPz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="289860028"
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="289860028"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 18:11:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,199,1654585200"; 
   d="scan'208";a="551558686"
Received: from q.bj.intel.com ([10.238.154.102])
  by orsmga003.jf.intel.com with ESMTP; 28 Jul 2022 18:11:14 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] memblock test: Modify the obsolete description in README
Date:   Fri, 29 Jul 2022 10:11:25 -0600
Message-Id: <20220729161125.190845-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shaoqin Huang <shaoqin.huang@intel.com>

The VERBOSE option in Makefile has been moved, but there still have the
description left in README. For now, we use `-v` options when running
memblock test to print information, so using the new to replace the
obsolete items.

Signed-off-by: Shaoqin Huang <shaoqin.huang@intel.com>
---
Changelog:
----------
v3:
  - Using `build options` replace `options` to make it more clear.
v2:
  - Tweak the sentence to make it more clear and continuesly.
  - Commit log changes.

 tools/testing/memblock/README | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
index 058146b528a5..72162b5f4a76 100644
--- a/tools/testing/memblock/README
+++ b/tools/testing/memblock/README
@@ -33,20 +33,23 @@ To run the tests, build the main target and run it:
 
 $ make && ./main
 
-A successful run produces no output. It is also possible to override different
-configuration parameters. For example, to include verbose output, specify the
-VERBOSE flag when building the main target:
+A successful run produces no output. It is possible to control the behavior
+by passing options from command line. For example, to include verbose output,
+append the `-v` options when you run the tests:
 
-$ make VERBOSE=1
+$ ./main -v
 
 This will print information about which functions are being tested and the
 number of test cases that passed.
 
-To simulate enabled NUMA, use:
+For the full list of options from command line, see `./main --help`.
+
+It is also possible to override different configuration parameters to change it
+test functions. For example, To simulate enabled NUMA, use:
 
 $ make NUMA=1
 
-For the full list of options, see `make help`.
+For the full list of build options, see `make help`.
 
 Project structure
 =================
-- 
2.30.2

