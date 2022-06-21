Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C90B455352D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 17:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352179AbiFUPEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 11:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiFUPEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 11:04:49 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A49C9275F4;
        Tue, 21 Jun 2022 08:04:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 65478165C;
        Tue, 21 Jun 2022 08:04:48 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 56E3F3F66F;
        Tue, 21 Jun 2022 08:04:47 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-acpi@vger.kernel.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Samer.El-Haj-Mahmoud@arm.com
Subject: [PATCH] Documentation: ACPI: Update links and references to DSD related docs
Date:   Tue, 21 Jun 2022 16:04:36 +0100
Message-Id: <20220621150436.3303431-1-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The existing references to DSD are stale and outdated. The new process
and guidance is maintained @https://github.com/UEFI/DSD-Guide

Update the existing documents to reflect the same.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 .../firmware-guide/acpi/DSD-properties-rules.rst      | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
index 8b2d8d0864c2..70442bc2521e 100644
--- a/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
+++ b/Documentation/firmware-guide/acpi/DSD-properties-rules.rst
@@ -21,7 +21,9 @@ specific type) associated with it.
 
 In the ACPI _DSD context it is an element of the sub-package following the
 generic Device Properties UUID in the _DSD return package as specified in the
-Device Properties UUID definition document [1]_.
+section titled "Well-Known _DSD UUIDs and Data Structure Formats" sub-section
+"Device Properties UUID" in _DSD (Device Specific Data) Implementation Guide
+document [1]_.
 
 It also may be regarded as the definition of a key and the associated data type
 that can be returned by _DSD in the Device Properties UUID sub-package for a
@@ -36,7 +38,9 @@ Property subsets are nested collections of properties.  Each of them is
 associated with an additional key (name) allowing the subset to be referred
 to as a whole (and to be treated as a separate entity).  The canonical
 representation of property subsets is via the mechanism specified in the
-Hierarchical Properties Extension UUID definition document [2]_.
+section titled "Well-Known _DSD UUIDs and Data Structure Formats" sub-section
+"Hierarchical Data Extension UUID" in _DSD (Device Specific Data)
+Implementation Guide document [1]_.
 
 Property sets may be hierarchical.  That is, a property set may contain
 multiple property subsets that each may contain property subsets of its
@@ -96,5 +100,4 @@ contents.
 References
 ==========
 
-.. [1] https://www.uefi.org/sites/default/files/resources/_DSD-device-properties-UUID.pdf
-.. [2] https://www.uefi.org/sites/default/files/resources/_DSD-hierarchical-data-extension-UUID-v1.1.pdf
+.. [1] https://github.com/UEFI/DSD-Guide
-- 
2.36.1

