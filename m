Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848575A987F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiIANYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232405AbiIANX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:23:27 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4850C2ACE
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662038605; x=1693574605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TkYap6N2nVl+fHdzmVAB+UZ9ohSv0PHB/25HC4xpAyo=;
  b=JwDwlaOTAH0cfr5fndjxWp4oQsH5gvf3ERgRJUdLY19comGjpPJG1onH
   zVwEIq9UMH6SX1RPNjgyhHx0b/lRYh/RJnrWp48cxRG/GNRjYXROAOZyb
   c1zuhDkh5EvGGQPmzYKl2+Jq778cqFA24OHwI2Gtt+gBBoDCC0hsQ0asG
   VdwLTfuDd2APGJ7tCrrOUdzqn7P0fP4HMzEdxfOATA8jyoDjAkf5YkqEd
   Ke1UPZg0TFvsMLNbnvwQsAkyRyYgOcpfAU6T+Uh/TLhvHG8AdD6FLHjqX
   mKjIrZVkSLD+CWS7nK7+Ntrr0cqjm0OP85IJk13lTFd6iuIeB4dxJdg/4
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10457"; a="295719710"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="295719710"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2022 06:23:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="615333919"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 01 Sep 2022 06:23:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 7A69B1C3; Thu,  1 Sep 2022 16:23:38 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Rokosov <DDRokosov@sberdevices.ru>,
        linux-kernel@vger.kernel.org
Cc:     Mark Brown <broonie@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH v1 3/3] regmap: trace: Remove unneeded blank lines
Date:   Thu,  1 Sep 2022 16:23:36 +0300
Message-Id: <20220901132336.33234-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
References: <20220901132336.33234-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a few unneeded blank lines in some of event definitions,
remove them in order to make those definitions consistent with
the rest.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/regmap/trace.h | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/base/regmap/trace.h b/drivers/base/regmap/trace.h
index a0f83e44a9d1..704e106e5dbd 100644
--- a/drivers/base/regmap/trace.h
+++ b/drivers/base/regmap/trace.h
@@ -41,7 +41,6 @@ DEFINE_EVENT(regmap_reg, regmap_reg_write,
 		 unsigned int val),
 
 	TP_ARGS(map, reg, val)
-
 );
 
 DEFINE_EVENT(regmap_reg, regmap_reg_read,
@@ -50,7 +49,6 @@ DEFINE_EVENT(regmap_reg, regmap_reg_read,
 		 unsigned int val),
 
 	TP_ARGS(map, reg, val)
-
 );
 
 DEFINE_EVENT(regmap_reg, regmap_reg_read_cache,
@@ -59,7 +57,6 @@ DEFINE_EVENT(regmap_reg, regmap_reg_read_cache,
 		 unsigned int val),
 
 	TP_ARGS(map, reg, val)
-
 );
 
 DECLARE_EVENT_CLASS(regmap_bulk,
@@ -199,7 +196,6 @@ DEFINE_EVENT(regmap_bool, regmap_cache_only,
 	TP_PROTO(struct regmap *map, bool flag),
 
 	TP_ARGS(map, flag)
-
 );
 
 DEFINE_EVENT(regmap_bool, regmap_cache_bypass,
@@ -207,7 +203,6 @@ DEFINE_EVENT(regmap_bool, regmap_cache_bypass,
 	TP_PROTO(struct regmap *map, bool flag),
 
 	TP_ARGS(map, flag)
-
 );
 
 DECLARE_EVENT_CLASS(regmap_async,
@@ -239,7 +234,6 @@ DEFINE_EVENT(regmap_async, regmap_async_io_complete,
 	TP_PROTO(struct regmap *map),
 
 	TP_ARGS(map)
-
 );
 
 DEFINE_EVENT(regmap_async, regmap_async_complete_start,
@@ -247,7 +241,6 @@ DEFINE_EVENT(regmap_async, regmap_async_complete_start,
 	TP_PROTO(struct regmap *map),
 
 	TP_ARGS(map)
-
 );
 
 DEFINE_EVENT(regmap_async, regmap_async_complete_done,
@@ -255,7 +248,6 @@ DEFINE_EVENT(regmap_async, regmap_async_complete_done,
 	TP_PROTO(struct regmap *map),
 
 	TP_ARGS(map)
-
 );
 
 TRACE_EVENT(regcache_drop_region,
-- 
2.35.1

