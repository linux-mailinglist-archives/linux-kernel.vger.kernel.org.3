Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9078592C38
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbiHOJSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241666AbiHOJRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:17:53 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Aug 2022 02:17:52 PDT
Received: from rcdn-iport-1.cisco.com (rcdn-iport-1.cisco.com [173.37.86.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27229220FF;
        Mon, 15 Aug 2022 02:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=1852; q=dns/txt; s=iport;
  t=1660555072; x=1661764672;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QpiiM3DbmqyBkHT2kZF2nZitt5ASAzlJNOnL9SvqktM=;
  b=PVvRZpYd4WK+1mFHJ1YwD6rVp8cbLv4Q3juDokyIJ5YEj7MCwkmw1kQA
   E8ZUe9CckzWZ1zdZypNpHazoz2/HRUHNUkCYuGyNxsoQx753XX7KJkOv3
   B0l8Qz9GUYyxV5c3afW8FQxawtPWpRsZABd7ubOxBgiMm1ofbDYGLIdcw
   w=;
IronPort-Data: =?us-ascii?q?A9a23=3AY7G1CaK0b7FTBaysFE+RbZclxSXFcZb7ZxGr2?=
 =?us-ascii?q?PjKsXjdYENS3zMEzGYcWWvVOfbbMGr8Kt8nb9yy8BlVv8fcxoBmTFAd+CA2R?=
 =?us-ascii?q?RqmiyZq6fd1j6vI0qj7wvTrFCqL1O1DLIiZRCwIZiWE/E31b+G/9SAUOZygH?=
 =?us-ascii?q?9IQNsaVYkideic8IMsRoUoLd98R2uaEs/Dga+++kYuaT/nkBbOQ82Uc3lT4R?=
 =?us-ascii?q?E60gEgHUPza4Fv0t7GlDBxBlAe2e3I9VPrzKUwtRkYUTLW4HsbiLwrC5Kuy8?=
 =?us-ascii?q?mWc9BA3B5b71L36aUYNBLXVOGBiiFIPBPPk2UcE93d0i/tkXBYfQR8/ZzGhk?=
 =?us-ascii?q?8J4x9JXqJ2YQgYyNaqKk+MYO/VdO3gmYfIWp+6ecCPXXcu7iheun2HX69BjC?=
 =?us-ascii?q?k5wGYww5edxDXtP6/ECbjsKa3irg+Ow3aL+SeR2gMknBNfkMZlZuXx6yzzdS?=
 =?us-ascii?q?/E8TvjrR6TM+M8d3TY3rt5BEOyYZMcDbzdrKhPabHVnJxEUDJ8/murthX7yd?=
 =?us-ascii?q?TxXgEqYo6Uq/3LUyg1hlrTgWPLRc8aRbcBYgk+WoWWA82mRKhMbP4bE4TmI6?=
 =?us-ascii?q?HShgqnIhyyTcKcTH72x+/osoFCVwGEJCRYWfVK9qP2+hQi1XNc3FqC+0kLCt?=
 =?us-ascii?q?oAo/0CtC9L6RRD9/jiPvwUXXJxbFOhS1e1E8YKMiy7xO4TOZmMphAQaifIL?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3Aa0ie3au/IpkwDzoGlZnXaT+J7skDd9V00z?=
 =?us-ascii?q?EX/kB9WHVpmwKj+PxG+85rsSMc6QxhPU3I9urgBEDtex7hHP1OkOss1MmZPD?=
 =?us-ascii?q?UO0VHAROoJ0WKI+VPd8kPFmtK1rZ0QEJSXzLbLfD5HZQGQ2njeL+od?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A5AAB2bIJi/51dJa1aHQEBAQEJARI?=
 =?us-ascii?q?BBQUBQIE7CAELAYIqgUs9Q4ROiCGIapxngXwLAQEBDQEBQgQBAYUChUACJTQ?=
 =?us-ascii?q?JDgECBAEBARIBAQUBAQECAQcEgQkThWgNhmwECwFGMAUCJgIuMgkJgn2DGKt?=
 =?us-ascii?q?Wen8ygQGIGYFlgRAsAYlDgQGEQhyBSUSEfYFQhkqCZQSVYzsDCQYHBTmBBRK?=
 =?us-ascii?q?BIXEBCAYGBwoFMgYCDBgUBAITElMMEgITDAocDg5GGQwPAxIDEQEHAgsSCBU?=
 =?us-ascii?q?sCAMCAwgDAgMjCwIDGAkHCgMdCAocEhAUAgQTHwsIAxofLQkCBA4DQwgLCgM?=
 =?us-ascii?q?RBAMTGAsWCBAEBgMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQ?=
 =?us-ascii?q?jHQMDBSYDAgIbBwICAwIGFwYCAkAxCigNCAQIBBweJQ4FBQIHMQUELwIeBAU?=
 =?us-ascii?q?GEQkCFgIGBAUCBAQWAgISCAIIJxsHFjYZAQVdBgsJIxwsEQUGFgMmUgYiHAG?=
 =?us-ascii?q?WcD4zARZuCoFxDL9fgi2DVp9wGjGDdZMckUUBkTiFLiCiOYQlAgQGBQIWgWE?=
 =?us-ascii?q?8gVkzGggbFYMjURkPlViHGEQxOwIGAQoBAQMJkRoBAQ?=
X-IronPort-AV: E=Sophos;i="5.91,230,1647302400"; 
   d="scan'208";a="1047879193"
Received: from rcdn-core-6.cisco.com ([173.37.93.157])
  by rcdn-iport-1.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 15 Aug 2022 09:16:48 +0000
Received: from sjc-ads-9103.cisco.com (sjc-ads-9103.cisco.com [10.30.208.113])
        by rcdn-core-6.cisco.com (8.15.2/8.15.2) with ESMTPS id 27F9GlH3015491
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 15 Aug 2022 09:16:48 GMT
Received: by sjc-ads-9103.cisco.com (Postfix, from userid 487941)
        id 698EACC128E; Mon, 15 Aug 2022 02:16:47 -0700 (PDT)
From:   Denys Zagorui <dzagorui@cisco.com>
To:     Meng.Li@windriver.com, jic23@kernel.org
Cc:     lars@metafoo.de, Michael.Hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] iio: ltc2497: Fix reading conversion results
Date:   Mon, 15 Aug 2022 09:16:47 +0000
Message-Id: <20220815091647.1523532-1-dzagorui@cisco.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.30.208.113, sjc-ads-9103.cisco.com
X-Outbound-Node: rcdn-core-6.cisco.com
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

After the result of the previous conversion is read the chip
automatically starts a new conversion and doesn't accept new i2c
transfers until this conversion is completed which makes the function
return failure.

So add an early return iff the programming of the new address isn't
needed. Note this will not fix the problem in general, but all cases
that are currently used. Once this changes we get the failure back, but
this can be addressed when the need arises.

Fixes: 69548b7c2c4f ("iio: adc: ltc2497: split protocol independent part in a separate module ")
Reported-by: Meng Li <Meng.Li@windriver.com>
Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Tested-by: Denys Zagorui <dzagorui@cisco.com>
---
 drivers/iio/adc/ltc2497.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
index f7c786f37ceb..78b93c99cc47 100644
--- a/drivers/iio/adc/ltc2497.c
+++ b/drivers/iio/adc/ltc2497.c
@@ -41,6 +41,19 @@ static int ltc2497_result_and_measure(struct ltc2497core_driverdata *ddata,
 		}
 
 		*val = (be32_to_cpu(st->buf) >> 14) - (1 << 17);
+
+		/*
+		 * The part started a new conversion at the end of the above i2c
+		 * transfer, so if the address didn't change since the last call
+		 * everything is fine and we can return early.
+		 * If not (which should only happen when some sort of bulk
+		 * conversion is implemented) we have to program the new
+		 * address. Note that this probably fails as the conversion that
+		 * was triggered above is like not complete yet and the two
+		 * operations have to be done in a single transfer.
+		 */
+		if (ddata->addr_prev == address)
+			return 0;
 	}
 
 	ret = i2c_smbus_write_byte(st->client,
-- 
2.28.0

