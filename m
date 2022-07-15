Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EBD578358
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiGRNNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGRNNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:13:32 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D6275CA;
        Mon, 18 Jul 2022 06:13:27 -0700 (PDT)
X-QQ-mid: bizesmtp80t1658150004t303q46c
Received: from localhost.localdomain ( [171.223.96.21])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 18 Jul 2022 21:13:22 +0800 (CST)
X-QQ-SSF: 01000000002000E0U000C00A0000020
X-QQ-FEAT: NGMqyHdgFPYih54HgxchLV4QAfvY8I3Ixxjj3u69KjT8cFwuwKxiuH3dVYBLh
        1/UqjzXkp5akF0h7ZnWoHoW12c9DI/A2zPwoYCuDeea8v89bl+Ujpvh0NtMo4PptAbw1VD5
        RmPh7TSbBXS0Jvm3z5Yr2qG77Qm1/vmqZMSgAe5aEmOIx4B7hKgvqUZS62Mvz2J19bOi+2C
        SmETUdHDcH+pRYnJKkXYH+aC/Lk4jxV0VA7Kfv38YuRkaDbxHteE+i9JIjW6M3Po+8STipv
        2yTMZgeizk5fsvqIp9yxV0Hqo02mRP+aFDvOiRjnNbKdbcliwj7+eSq98T9XZRt5h5hxpt1
        pQLk9jHDVx1N04EFjX4CJ5Qn2y3Pq1Ll/cEqD+3LbFvVaNSXs/ojZc1Esxv/qe/8THdd5Fu
        NVmgVfi7UIs=
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] power: supply: Fix comment typo
Date:   Fri, 15 Jul 2022 13:11:26 +0800
Message-Id: <20220715051126.28394-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,SPF_PASS,
        T_SPF_HELO_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in line 445, remove one.

Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
---
 drivers/power/supply/power_supply_sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 4239591e1522..5369abaceb5c 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -442,7 +442,7 @@ static int add_prop_uevent(struct device *dev, struct kobj_uevent_env *env,
 	if (ret == -ENODEV || ret == -ENODATA) {
 		/*
 		 * When a battery is absent, we expect -ENODEV. Don't abort;
-		 * send the uevent with at least the the PRESENT=0 property
+		 * send the uevent with at least the PRESENT=0 property
 		 */
 		return 0;
 	}
-- 
2.35.1

