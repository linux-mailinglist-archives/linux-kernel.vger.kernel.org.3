Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B2A47D3B9
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 15:33:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245698AbhLVOdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 09:33:03 -0500
Received: from mga03.intel.com ([134.134.136.65]:11411 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237095AbhLVOc7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 09:32:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640183579; x=1671719579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QCLhPm/H03yOkTIscFco8BLBYGHhEbUqjfz5Q53NPNY=;
  b=F4Zqpk6PR9SW15VixuE2+rZ+HLFF/tHOSqYj4fO4dqQ0k8joo+OZTNOg
   orpTZGuE3yDGmzqiWUryB6V5JC9JDIWMlgvBzJ/y/zmsODNeKInz6Edth
   LXTSxWfofXqtVGsrvvG1hFOMnppRPKXgwPPBzCXfVfD3YjZ5/2i7SQXMp
   IKW8hnvJ94QOcIIoReRoB9oxIKXc2G3XrCGThJypu/rq36iZV0+pEiu+s
   dctS2ZI2TnOLPap5nV9FBdO8QrIgDSifMlsYfJDA8Q1iKxoxQZiydUlYI
   tLIhX806vkCYZ/QD7bPkTOmWZ7WgVoCkIWgJGcus56YpWViUlxW7sd2+n
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="240580544"
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="240580544"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2021 06:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,226,1635231600"; 
   d="scan'208";a="664285120"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 22 Dec 2021 06:32:52 -0800
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Prashant Malani <pmalani@chromium.org>,
        linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/5] acpi: Export acpi_bus_type
Date:   Wed, 22 Dec 2021 17:32:54 +0300
Message-Id: <20211222143258.82305-2-heikki.krogerus@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
References: <20211222143258.82305-1-heikki.krogerus@linux.intel.com>
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

