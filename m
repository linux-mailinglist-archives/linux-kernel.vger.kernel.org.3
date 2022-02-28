Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBCB4C794E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiB1T6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiB1T6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:58:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1E42E09F;
        Mon, 28 Feb 2022 11:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646078284; x=1677614284;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e74w0OEGEp4eOrov/OjcyDae/25MPuueAdebpU/hUcQ=;
  b=ekRJ1tF2gWP1QPvuPq1PyyGsV2P+Ptui/NaQ45NYzJ4k/tivbC5UpwjM
   /rWenSHjGZXMtGk/Uh4jJHPYwCf4r8F6wfzBxawNAi4PMMeRA2CkNBJsY
   vYHPig/L/MIr5P2dUIdaioBrQ1F0Q+JUV+mpQezml1oft9JUCWRQiZIkk
   /JeZpu5MUjWWaP6qUE6nWLXb8NTytlKU1vmMapgSHmEm4v+sAy1FK3hmE
   hTaCjEqSIQ2u9wSh4r3nWqviNQH0Sn5tdPr5t99zRlm7a4SQHOXo99RX0
   i9atYcmfOXqIVeQL+0h1tHy5wNgGExNf11yVsL3wQrN442b4AGkkupI/f
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10272"; a="339406630"
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="339406630"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2022 11:58:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,144,1643702400"; 
   d="scan'208";a="685459499"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 28 Feb 2022 11:58:02 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     corbet@lwn.net, rafael@kernel.org, hdegoede@redhat.com,
        markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Add additional file to uncore frequency control
Date:   Mon, 28 Feb 2022 11:58:00 -0800
Message-Id: <20220228195800.1422004-2-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220228195800.1422004-1-srinivas.pandruvada@linux.intel.com>
References: <20220228195800.1422004-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional Documentation file in the list of files.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
New patch to add file to maintainers list.

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc4a1370ef1b..d36a51dee153 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9891,6 +9891,7 @@ INTEL UNCORE FREQUENCY CONTROL
 M:	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
+F:	Documentation/admin-guide/pm/intel_uncore_frequency_scaling.rst
 F:	drivers/platform/x86/intel/uncore-frequency.c
 
 INTEL VENDOR SPECIFIC EXTENDED CAPABILITIES DRIVER
-- 
2.34.1

