Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA986587BDE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 13:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiHBL7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 07:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHBL7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:59:07 -0400
Received: from smtpbg.qq.com (unknown [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB404AD7A;
        Tue,  2 Aug 2022 04:59:02 -0700 (PDT)
X-QQ-mid: bizesmtp84t1659441538tj0c0ae5
Received: from kali.lan ( [125.69.43.47])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 02 Aug 2022 19:58:57 +0800 (CST)
X-QQ-SSF: 01000000002000F0U000B00A0000020
X-QQ-FEAT: 9HtJsxgr54datqEXUeQB6lWqj7M8XmxfamxeBZhaFjmaYazurIKwFMpHR8BQ+
        a1YbvD5GH+b9KyiatH5e4jU1IRvNfMlt3OVyuzs/BU2kpvXlMnzwvb6pvosrYgdv3OzpwiX
        A5wrPYcftWZLUl99QAl4p4q3HwGWUlO9xalFnn8qaq+r/kpKtl3UDPj63n1iSmPP75rOXSd
        oSNr3Tk9P46u3Y4xX5MxcTQemfxzeoCXc5Z1q9gJKGSwL5+uLkx34zei8ZsYupRmFF5FmFQ
        2zsOyB1CcDfg9UQR41xR0CYnAoOn1C8k5mWrgCSpsGj6W7bCSiA/KNUyQXAyBcvttK4qrwv
        ScFfWBePjfqHhD/QM9VvlYK0CLUCtJk/+Xns/408PQg1mVHaTcn4T9ENRmUSg==
X-QQ-GoodBg: 0
From:   Jason Wang <wangborong@cdjrlc.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Wang <wangborong@cdjrlc.com>
Subject: [PATCH] power: supply: core: Fix comment typo
Date:   Wed,  3 Aug 2022 03:58:51 +0800
Message-Id: <20220802195851.4672-1-wangborong@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RDNS_NONE,SPF_PASS,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

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

