Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B54D47E0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347541AbhLWJrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:47:20 -0500
Received: from mga04.intel.com ([192.55.52.120]:41987 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232539AbhLWJrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:47:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640252839; x=1671788839;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GsauAQwjD5atoSYDjklE01pETfOyrFYukvY6LDNLWJk=;
  b=Vpv6sgIHALghHa63UFc0XwqYG4Y0JFF1iJknCuiMF9O8bX0KSDZLRyFH
   qdccC15uH7muo/u3AGqhfQ5mw0KdPwoSBANJAL+Yccmd33r1nm476QMf+
   GZ/VtHMKLL+xKk7IsoiTfQEISDOIJbqUA7j5QF9+x4nJrgTGzCgEn5Cjt
   GVccTgyccl53S6wFhmHa26CRSx6XlMCgzvZojL4+eBqPGtEnpN8CxkZOo
   Jcx02zzxjtiLWNc6cZszndjSMRGtE+lcDBdZWSoj9FLlJFURHmy9IY37n
   HvSGU6Dsc9155c+7Mpna4YlXxM+Wr0IQegQlME0g7eYT3sgzHkNUSl3ge
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10206"; a="239549150"
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="239549150"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 01:47:19 -0800
X-IronPort-AV: E=Sophos;i="5.88,229,1635231600"; 
   d="scan'208";a="468484783"
Received: from twinkler-lnx.jer.intel.com ([10.12.91.141])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2021 01:47:17 -0800
From:   Tomas Winkler <tomas.winkler@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>
Subject: [char-misc-next 1/2] mei: add POWERING_DOWN into device state print
Date:   Thu, 23 Dec 2021 11:47:04 +0200
Message-Id: <20211223094705.204624-1-tomas.winkler@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexander Usyskin <alexander.usyskin@intel.com>

The POWERING_DOWN state string was missing from
the device states list, add it.

Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
---
 drivers/misc/mei/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/mei/init.c b/drivers/misc/mei/init.c
index 5c8cb679b997..f79076c67256 100644
--- a/drivers/misc/mei/init.c
+++ b/drivers/misc/mei/init.c
@@ -24,6 +24,7 @@ const char *mei_dev_state_str(int state)
 	MEI_DEV_STATE(ENABLED);
 	MEI_DEV_STATE(RESETTING);
 	MEI_DEV_STATE(DISABLED);
+	MEI_DEV_STATE(POWERING_DOWN);
 	MEI_DEV_STATE(POWER_DOWN);
 	MEI_DEV_STATE(POWER_UP);
 	default:
-- 
2.31.1

