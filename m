Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 783AC47C0C8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:32:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238231AbhLUNcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:32:23 -0500
Received: from mga17.intel.com ([192.55.52.151]:1068 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238218AbhLUNcV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640093541; x=1671629541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rv/o7yVP6FCOt5D/RoiaQiAdZaryTSELj/ufQY8FWPc=;
  b=C0KXNkR8Ws9nWGkYpq6BjAEbgn5IzrgwgTAHGGg2WSU4xDantNY0Vri0
   W390hi92zz7SJilIXbdvdkqYUR0cL6HkpdcBuSOmtg77vOGKpFn6A5tiE
   uNAYnxh9X2x6vqm9oVwaU9v5ceGerIXziqgEedontCGc79A1XolJePJM8
   LC0TwoAa6jOHrXD0+CohEq56Si3YXBTubGSTzuydBa2Leo+TDM52CYlAj
   S/FQsWiwrNu/YLdqK9pZsiWu+GP7Y30DwHiROAZ82R6CGQvsyaOtj3fvE
   ZR9IMBr9NcYEP7/VaTtkkq7U3fD4+g0Itj6MVcZ9ILY3tvWv6gZV6GF2c
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="221069161"
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="221069161"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 05:32:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,223,1635231600"; 
   d="scan'208";a="570211697"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 21 Dec 2021 05:32:18 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id CE68A190; Tue, 21 Dec 2021 15:32:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>
Subject: [PATCH v2 1/1] software node: Update MAINTAINERS data base
Date:   Tue, 21 Dec 2021 15:32:15 +0200
Message-Id: <20211221133215.8447-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two updates to the MAINTAINERS regarding to software node API:
- add Daniel Scally to be designated reviewer
- add Sakari Ailus to be designated reviewer
- add rather tightly related device property files to the list
- due to above adjust section name accordingly

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Daniel Scally <djrscally@gmail.com>
---

v2: added tags (Daniel, Heikki), added Sakari to the reviewers (Sakari)

Rafael, I guess it's the best if you can pick this up.

 MAINTAINERS | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c1260c..e36497cb7f40 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17666,12 +17666,17 @@ F:	drivers/firmware/arm_sdei.c
 F:	include/linux/arm_sdei.h
 F:	include/uapi/linux/arm_sdei.h
 
-SOFTWARE NODES
+SOFTWARE NODES AND DEVICE PROPERTIES
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
+R:	Daniel Scally <djrscally@gmail.com>
 R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+R:	Sakari Ailus <sakari.ailus@linux.intel.com>
 L:	linux-acpi@vger.kernel.org
 S:	Maintained
+F:	drivers/base/property.c
 F:	drivers/base/swnode.c
+F:	include/linux/fwnode.h
+F:	include/linux/property.h
 
 SOFTWARE RAID (Multiple Disks) SUPPORT
 M:	Song Liu <song@kernel.org>
-- 
2.34.1

