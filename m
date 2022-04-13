Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358854FF650
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 13:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiDMMBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiDMMBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:01:37 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF72C673;
        Wed, 13 Apr 2022 04:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649851156; x=1681387156;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3UyuAIcJnXsr3KhEUp8X0PPk2b1/lXGl93FQhPP3cuE=;
  b=AtH6Nv0uQUnsclcndUzxkI0y5JYTLySpNIQETzT/TqxOq2lg/Cm1Zwcp
   3LAgVCaOeOa4jvofsDYf/g+iGIF2AIAOrThPbwjRNssRIvyo3/HvEj3KX
   dYWo8QDi7NC61EatFdKr9PX3eoqxI45iwzFVL77o9EpMYS8N7nXITlcSO
   vFyRlDESOf4JKfGmxyMTofw7GoIdYFA2BjXNjsg5BMzVDMpEPqbWWcU1U
   jI7uGjNy0mhWn8XnSNkvFqxUwTU8MHOWtJcI9ZMK/X69+ZKffW/iDMJ23
   MW/EqX8AZughuBF98HB88lX+qQk/j2tUHTygf/P/hHtpkO3nwdrV3Cz5t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261492458"
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="261492458"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 04:59:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,256,1643702400"; 
   d="scan'208";a="645138487"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Apr 2022 04:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A5CCD14F; Wed, 13 Apr 2022 14:59:14 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Subject: [PATCH v1 1/1] ACPI: docs: enumeration: Unify Package () for properties (part 2)
Date:   Wed, 13 Apr 2022 14:59:12 +0300
Message-Id: <20220413115912.41893-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unify Package () representation for properties:
 - make them one line where it's possible
 - add spaces between parentheses and curly braces
 - drop the explicit size of package

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 Documentation/firmware-guide/acpi/enumeration.rst | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
index 47fb4d6d4557..6b62425ef9cd 100644
--- a/Documentation/firmware-guide/acpi/enumeration.rst
+++ b/Documentation/firmware-guide/acpi/enumeration.rst
@@ -167,8 +167,7 @@ The table below shows an example of its usage::
         Name (_DSD, Package () {
             ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
             Package () {
-                Package () {"interrupt-names",
-                Package (2) {"default", "alert"}},
+                Package () { "interrupt-names", Package () { "default", "alert" } },
             }
         ...
         })
-- 
2.35.1

