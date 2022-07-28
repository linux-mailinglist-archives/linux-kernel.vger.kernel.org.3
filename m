Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 653775823E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiG0KKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiG0KKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:10:48 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBCFE625A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 03:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658916647; x=1690452647;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eJqnjBLXed5Sycp5HsRP/0/nQuHyMkYLa+orQZuUTn8=;
  b=D1KYpzrATyrnuNeqW7f/1ZJWSSJIROFMr3oj5i4WFp/iqbBEacAmwF+f
   1HDqjZfy8fshuRRBsCdDCpcKjIm/ZDaFugelAcfMxwCqKWDs3B8RwGcGk
   JHScEenX0JCa/DeCdU7gCzWMYiIvI5D/rLLNy+SAHt6UADwdupBQBQWAg
   FLh67mXQo++xV4cl5+paPdWECkbOVBNpIoJDnRAOR0ja21X5CBLsb4t6z
   jWWL0pnY6i51p+72t8DvlHW044PBWPhZyzdqxksJSEHZ3hhJUfzCgeL7K
   +CCJIBNArHWOioIfznVTvvQJKMQ/Nz4YwAppcQOdfMqTVkRXIdU4uXLT6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="288206887"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="288206887"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 03:09:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="927730299"
Received: from q.bj.intel.com ([10.238.154.102])
  by fmsmga005.fm.intel.com with ESMTP; 27 Jul 2022 03:09:50 -0700
From:   shaoqin.huang@intel.com
To:     rppt@kernel.org
Cc:     Shaoqin Huang <shaoqin.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] memblock test: Modify the obsolete description in README
Date:   Wed, 27 Jul 2022 19:12:28 -0600
Message-Id: <20220728011228.23691-1-shaoqin.huang@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
v2:
  - Tweak the sentence to make it more clear and continuesly.
  - Commit log changes.

 tools/testing/memblock/README | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/testing/memblock/README b/tools/testing/memblock/README
index 058146b528a5..d3875e7065fd 100644
--- a/tools/testing/memblock/README
+++ b/tools/testing/memblock/README
@@ -33,16 +33,19 @@ To run the tests, build the main target and run it:
 
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
 
-- 
2.30.2

