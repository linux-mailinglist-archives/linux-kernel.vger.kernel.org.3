Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C394705B4
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 17:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhLJQdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 11:33:43 -0500
Received: from mga05.intel.com ([192.55.52.43]:59996 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235118AbhLJQdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 11:33:42 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="324639499"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="324639499"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 08:30:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="750869561"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 10 Dec 2021 08:30:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A84F1109; Fri, 10 Dec 2021 18:30:11 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Corentin Chary <corentin.chary@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/3] platform/x86: asus-wmi: Join string literals back
Date:   Fri, 10 Dec 2021 18:30:07 +0200
Message-Id: <20211210163009.19894-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For easy grepping on debug purposes join string literals back in
the messages.

No functional change.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/platform/x86/asus-wmi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
index 6fa4b0be8e76..30e0de9e0d81 100644
--- a/drivers/platform/x86/asus-wmi.c
+++ b/drivers/platform/x86/asus-wmi.c
@@ -1154,12 +1154,10 @@ static void asus_rfkill_hotplug(struct asus_wmi *asus)
 		absent = (l == 0xffffffff);
 
 		if (blocked != absent) {
-			pr_warn("BIOS says wireless lan is %s, "
-				"but the pci device is %s\n",
+			pr_warn("BIOS says wireless lan is %s, but the pci device is %s\n",
 				blocked ? "blocked" : "unblocked",
 				absent ? "absent" : "present");
-			pr_warn("skipped wireless hotplug as probably "
-				"inappropriate for this model\n");
+			pr_warn("skipped wireless hotplug as probably inappropriate for this model\n");
 			goto out_unlock;
 		}
 
-- 
2.33.0

