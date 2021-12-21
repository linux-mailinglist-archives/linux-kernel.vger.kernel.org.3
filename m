Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0341347BA8A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 08:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhLUHOK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 02:14:10 -0500
Received: from mga07.intel.com ([134.134.136.100]:48744 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234839AbhLUHOJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 02:14:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640070849; x=1671606849;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VYviMeFO7+oLhFygQ1gEtw8dSLzuqgoRJEipX58modk=;
  b=LqoR0Rpb2r6kRuSdwVp6+kJyC6eDwz4s/VUpdsUIPK3mrTjjTRnrJnn6
   CVzd88cXpMPGKne+Wwt9ItFkJMlsaRv1oJuLBAmJEK19dMXwy+dAeEXQk
   Lco2a6QjCdzzjZnLzqSlR4PkkTGHCDwx++SI30spoPdS0DVenLS0q6PnV
   YM1y1Y0cO/Xijqe0IOLFXmqw496jsPuz5RqyYS/exGk6TRydZAzzmjtdD
   VNIo4JqDThFWGLfrHRF2pUSh+ugOPYQ39WSOvsaZxjS9NtOyK8a7KAdBy
   IAZWLBGMAUen60jSuk5+JD7GXSawYiJCoU2s7hqMZcNlebaxzEeMYZxVY
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="303712213"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="303712213"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 23:14:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="757678063"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 20 Dec 2021 23:14:06 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 01FAD190; Tue, 21 Dec 2021 09:14:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] software node: Update MAINTAINERS data base
Date:   Tue, 21 Dec 2021 09:14:09 +0200
Message-Id: <20211221071409.14361-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two updates to the MAINTAINERS regarding to software node API:
- add Dan Scally to be designated reviewer
- add rather tightly related device property files to the list
- adjust section name accordingly

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

Based on the latest Dan's involvement and amount of patches seen recently
I went ahead and added his name to the list. Dan, please tell me if it's
not appropriate.

 MAINTAINERS | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8912b2c1260c..ccb4aa744540 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17666,12 +17666,16 @@ F:	drivers/firmware/arm_sdei.c
 F:	include/linux/arm_sdei.h
 F:	include/uapi/linux/arm_sdei.h
 
-SOFTWARE NODES
+SOFTWARE NODES AND DEVICE PROPERTIES
 R:	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
 R:	Heikki Krogerus <heikki.krogerus@linux.intel.com>
+R:	Daniel Scally <djrscally@gmail.com>
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

