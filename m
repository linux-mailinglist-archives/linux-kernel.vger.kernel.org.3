Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDBC156D0BB
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 20:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiGJSZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiGJSZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 14:25:28 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0B0713D1C;
        Sun, 10 Jul 2022 11:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657477527; x=1689013527;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2ag19OIdVMzRzdhqat/O5TJVp4xTWh8Hj62iiQEx2/c=;
  b=cbQwHZ8si09JjTfPBhF4Slfgx7b28ygGKx9WlhvcamgaG51Td5o0E/Gh
   I6c+OjyFpBOL55hbeXtledBzQrjAqAGao9t+qmDGKjYs+G2XE2uxB4OcL
   aLJNPWsEAIRLARZ54CrBi2GgpAzbYJugWKRcDpOJlHkgSdLXOvk+d95em
   tSvd6E2ANTblHEgZmEt5OPKtWZ3gx5B5TeVHc41Mk9wWd8ixliP5UZVOe
   hC4tMFLne1agDhXFa4slx+Sg50vQwIM+thBM89s/lh2EqdC5Kt8Al9kQ4
   Fwd6D3AN3ZKJE6KXHvb3uYyNjWCK/jtblFBJ2O8EfqlnN74YKX1pcdW+4
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10404"; a="282081437"
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="282081437"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:25:26 -0700
X-IronPort-AV: E=Sophos;i="5.92,261,1650956400"; 
   d="scan'208";a="736864829"
Received: from agluck-desk3.sc.intel.com ([172.25.222.78])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2022 11:25:26 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "Joseph, Jithu" <jithu.joseph@intel.com>, markgross@kernel.org,
        ashok.raj@intel.com, ravi.v.shankar@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, Tony Luck <tony.luck@intel.com>
Subject: [PATCH 1/2] Documentation: Correct IFS reload documentation
Date:   Sun, 10 Jul 2022 11:25:20 -0700
Message-Id: <20220710182521.60642-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220710182521.60642-1-tony.luck@intel.com>
References: <c416b93b-8adc-d9a8-ef0d-594cce6d9a9d@redhat.com>
 <20220710182521.60642-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jithu Joseph <jithu.joseph@intel.com>

The location where the scan image is stored is incorrect
in the current documentation. Fix this.

Fixes: 34604d289167("Documentation: In-Field Scan")
Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 drivers/platform/x86/intel/ifs/ifs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
index 73c8e91cf144..622a246b62cb 100644
--- a/drivers/platform/x86/intel/ifs/ifs.h
+++ b/drivers/platform/x86/intel/ifs/ifs.h
@@ -39,7 +39,7 @@
  *   # echo 1 > /sys/devices/virtual/misc/intel_ifs_0/reload
  *
  * Similar to microcode, the current version of the scan tests is stored
- * in a fixed location: /lib/firmware/intel/ifs.0/family-model-stepping.scan
+ * in a fixed location: /lib/firmware/intel/ifs/family-model-stepping.scan
  *
  * Running tests
  * -------------
-- 
2.35.3

