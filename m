Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD4347E038
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 09:16:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346918AbhLWIQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 03:16:19 -0500
Received: from mga01.intel.com ([192.55.52.88]:28533 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239315AbhLWIQR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 03:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640247377; x=1671783377;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCLhPm/H03yOkTIscFco8BLBYGHhEbUqjfz5Q53NPNY=;
  b=dMTGUA7G0opQaICkwSv3N9t27JbV/FWhHSoXxZHAkY8Grv/lBBZZwbSV
   f9TD4bVrW+jkkNgFgZXU+L81q/c1V9FkWTrZEJcAQ7VMZ7fTT0jf3KIdm
   8r2lcej5x1yQSkjF6HtTW0dr4JWXUXPTmJu0C5PFqza9346DsxUdLYqHK
   3KdGeOsZ6Tz5tz32SUoDod/j6liId0kK3fS7QzvFXI5MqDZ3juJmJt7O9
   HOSEWJFwetGGkkkRCaC0p2Qk1hGb2BN34OM/lmjQ4yKS+MvKia7fDjiRw
   i+JrNAmIb6lTpvK6Vf+AVWZ4zji39yRIWj0Cx7up/k42IphQ4GDKMlvx2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="264990661"
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="264990661"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 00:16:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,228,1635231600"; 
   d="scan'208";a="664515515"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 23 Dec 2021 00:16:14 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/5] acpi: Export acpi_bus_type
Date:   Thu, 23 Dec 2021 11:16:16 +0300
Message-Id: <20211223081620.45479-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
References: <20211223081620.45479-1-heikki.krogerus@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So we can use bus_for_each_dev() and others from modules.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/acpi/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index dd535b4b9a160..572588bc6ede0 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1043,6 +1043,7 @@ struct bus_type acpi_bus_type = {
 	.remove		= acpi_device_remove,
 	.uevent		= acpi_device_uevent,
 };
+EXPORT_SYMBOL_GPL(acpi_bus_type);
 
 /* --------------------------------------------------------------------------
                              Initialization/Cleanup
-- 
2.34.1

