Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7AD057D55F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 23:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbiGUVB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 17:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUVBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 17:01:25 -0400
Received: from luna (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net [86.15.83.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E322AE8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 14:01:23 -0700 (PDT)
Received: from ben by luna with local (Exim 4.96)
        (envelope-from <ben@luna.fluff.org>)
        id 1oEdIP-001std-11;
        Thu, 21 Jul 2022 22:01:21 +0100
From:   Ben Dooks <ben-linux@fluff.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, sre@kernel.org,
        Ben Dooks <ben-linux@fluff.org>
Subject: [PATCH] power: supply: bq27xxx: fix NULL vs 0 warnings
Date:   Thu, 21 Jul 2022 22:01:20 +0100
Message-Id: <20220721210120.449340-1-ben-linux@fluff.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,KHOP_HELO_FCRDNS,RCVD_IN_SORBS_DUL,RDNS_DYNAMIC,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver has a lot of sparse warnings for using 0 as a NULL
pointer when NULL would be appropriate. Change the 0 values
to NULL to fix the warnings, some of which are shown here:

drivers/power/supply/bq27xxx_battery.c:984:23: warning: Using plain integer as NULL pointer
drivers/power/supply/bq27xxx_battery.c:985:23: warning: Using plain integer as NULL pointer
drivers/power/supply/bq27xxx_battery.c:986:23: warning: Using plain integer as NULL pointer
drivers/power/supply/bq27xxx_battery.c:987:23: warning: Using plain integer as NULL pointer
drivers/power/supply/bq27xxx_battery.c:988:23: warning: Using plain integer as NULL pointer

Signed-off-by: Ben Dooks <ben-linux@fluff.org>
---
 drivers/power/supply/bq27xxx_battery.c | 54 +++++++++++++-------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/power/supply/bq27xxx_battery.c b/drivers/power/supply/bq27xxx_battery.c
index 35e6a394c0df..dccc2683455a 100644
--- a/drivers/power/supply/bq27xxx_battery.c
+++ b/drivers/power/supply/bq27xxx_battery.c
@@ -868,11 +868,11 @@ enum bq27xxx_dm_reg_id {
 	BQ27XXX_DM_TERMINATE_VOLTAGE,
 };
 
-#define bq27000_dm_regs 0
-#define bq27010_dm_regs 0
-#define bq2750x_dm_regs 0
-#define bq2751x_dm_regs 0
-#define bq2752x_dm_regs 0
+#define bq27000_dm_regs NULL
+#define bq27010_dm_regs NULL
+#define bq2750x_dm_regs NULL
+#define bq2751x_dm_regs NULL
+#define bq2752x_dm_regs NULL
 
 #if 0 /* not yet tested */
 static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
@@ -881,24 +881,24 @@ static struct bq27xxx_dm_reg bq27500_dm_regs[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 48, 2, 1000, 32767 },
 };
 #else
-#define bq27500_dm_regs 0
+#define bq27500_dm_regs NULL
 #endif
 
 /* todo create data memory definitions from datasheets and test on chips */
-#define bq27510g1_dm_regs 0
-#define bq27510g2_dm_regs 0
-#define bq27510g3_dm_regs 0
-#define bq27520g1_dm_regs 0
-#define bq27520g2_dm_regs 0
-#define bq27520g3_dm_regs 0
-#define bq27520g4_dm_regs 0
-#define bq27521_dm_regs 0
-#define bq27530_dm_regs 0
-#define bq27531_dm_regs 0
-#define bq27541_dm_regs 0
-#define bq27542_dm_regs 0
-#define bq27546_dm_regs 0
-#define bq27742_dm_regs 0
+#define bq27510g1_dm_regs NULL
+#define bq27510g2_dm_regs NULL
+#define bq27510g3_dm_regs NULL
+#define bq27520g1_dm_regs NULL
+#define bq27520g2_dm_regs NULL
+#define bq27520g3_dm_regs NULL
+#define bq27520g4_dm_regs NULL
+#define bq27521_dm_regs NULL
+#define bq27530_dm_regs NULL
+#define bq27531_dm_regs NULL
+#define bq27541_dm_regs NULL
+#define bq27542_dm_regs NULL
+#define bq27546_dm_regs NULL
+#define bq27742_dm_regs NULL
 
 #if 0 /* not yet tested */
 static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
@@ -907,7 +907,7 @@ static struct bq27xxx_dm_reg bq27545_dm_regs[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 80, 67, 2, 2800,  3700 },
 };
 #else
-#define bq27545_dm_regs 0
+#define bq27545_dm_regs NULL
 #endif
 
 static struct bq27xxx_dm_reg bq27411_dm_regs[] = {
@@ -937,7 +937,7 @@ static struct bq27xxx_dm_reg bq27426_dm_regs[] = {
 #if 0 /* not yet tested */
 #define bq27441_dm_regs bq27421_dm_regs
 #else
-#define bq27441_dm_regs 0
+#define bq27441_dm_regs NULL
 #endif
 
 #if 0 /* not yet tested */
@@ -947,13 +947,13 @@ static struct bq27xxx_dm_reg bq27621_dm_regs[] = {
 	[BQ27XXX_DM_TERMINATE_VOLTAGE] = { 82, 9, 2, 2500,  3700 },
 };
 #else
-#define bq27621_dm_regs 0
+#define bq27621_dm_regs NULL
 #endif
 
-#define bq27z561_dm_regs 0
-#define bq28z610_dm_regs 0
-#define bq34z100_dm_regs 0
-#define bq78z100_dm_regs 0
+#define bq27z561_dm_regs NULL
+#define bq28z610_dm_regs NULL
+#define bq34z100_dm_regs NULL
+#define bq78z100_dm_regs NULL
 
 #define BQ27XXX_O_ZERO		BIT(0)
 #define BQ27XXX_O_OTDC		BIT(1) /* has OTC/OTD overtemperature flags */
-- 
2.35.1

