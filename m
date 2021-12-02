Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FD465D8D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355666AbhLBErO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:47:14 -0500
Received: from mga12.intel.com ([192.55.52.136]:24211 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1355582AbhLBErB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:47:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="216640185"
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="216640185"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:18 -0800
X-IronPort-AV: E=Sophos;i="5.87,281,1631602800"; 
   d="scan'208";a="477788584"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 20:43:17 -0800
From:   ira.weiny@intel.com
To:     Jonathan Corbet <corbet@lwn.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 5/7] Documentation/auxiliary_bus: Add example code for module_auxiliary_driver()
Date:   Wed,  1 Dec 2021 20:43:03 -0800
Message-Id: <20211202044305.4006853-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202044305.4006853-1-ira.weiny@intel.com>
References: <20211202044305.4006853-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Add an example code snipit to the module_auxiliary_driver()
documentation which is consistent with the other example code in the
elsewhere in the documentation.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 include/linux/auxiliary_bus.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/auxiliary_bus.h b/include/linux/auxiliary_bus.h
index fc51d45f106b..605b27aab693 100644
--- a/include/linux/auxiliary_bus.h
+++ b/include/linux/auxiliary_bus.h
@@ -66,6 +66,10 @@ void auxiliary_driver_unregister(struct auxiliary_driver *auxdrv);
  * Helper macro for auxiliary drivers which do not do anything special in
  * module init/exit. This eliminates a lot of boilerplate. Each module may only
  * use this macro once, and calling it replaces module_init() and module_exit()
+ *
+ * .. code-block:: c
+ *
+ *	module_auxiliary_driver(my_drv);
  */
 #define module_auxiliary_driver(__auxiliary_driver) \
 	module_driver(__auxiliary_driver, auxiliary_driver_register, auxiliary_driver_unregister)
-- 
2.31.1

