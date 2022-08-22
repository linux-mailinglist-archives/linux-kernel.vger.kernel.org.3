Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559659BF87
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbiHVMdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230503AbiHVMdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:33:03 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75ABEBF4A;
        Mon, 22 Aug 2022 05:33:01 -0700 (PDT)
X-QQ-mid: bizesmtp70t1661171567tc67godh
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 22 Aug 2022 20:32:45 +0800 (CST)
X-QQ-SSF: 01000000002000C0D000B00A0000000
X-QQ-FEAT: W+onFc5Tw4PahOvmZM6UxUA85VWZnx9QqbYzIamVuUUXjg8BOThf6BNm9i319
        BZwr7n9YaL1n8XSgUYJZk4r86k4+2jNhEPaC+PyMi2V+ZuQBgfNm7VFQgZyDApLhJTz+XaH
        IYm1UlOUL10FB8W0NV4Yw9S95TUBRQcAp7RrYl0+OoJqJTQAuHPUTSOYockMk2XaAccdx6E
        mI52Nq5HnDPPLGMX2488Z1R/M1x4/m3Pd+xXYLCr+PMufhe9nzBO7en5h4g7khKmslzIdZE
        Gf9c1SKUZ0iTcHPy7rSMGTCdf4516lRUYr/KC/WRI4hZSfsZc1o9W+SP5av6SOxANRU9Dfk
        l5MlAn1afuu2CVzePTQbp/5sgcmuiVKdK9AeoXd7PG984NQDw81dofse5aOpszYm3cNh/gP
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     amit.kachhap@gmail.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, lukasz.luba@arm.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/thermal: fix repeated words in comments
Date:   Mon, 22 Aug 2022 20:32:39 +0800
Message-Id: <20220822123239.28400-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_00,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,
        RCVD_IN_XBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  1.3 RCVD_IN_BL_SPAMCOP_NET RBL: Received via a relay in
        *      bl.spamcop.net
        *      [Blocked - see <https://www.spamcop.net/bl.shtml?43.154.54.12>]
        *  3.3 RCVD_IN_SBL_CSS RBL: Received via a relay in Spamhaus SBL-CSS
        *      [43.154.54.12 listed in zen.spamhaus.org]
        *  0.4 RCVD_IN_XBL RBL: Received via a relay in Spamhaus XBL
        *  3.3 RCVD_IN_PBL RBL: Received via a relay in Spamhaus PBL
        * -1.9 BAYES_00 BODY: Bayes spam probability is 0 to 1%
        *      [score: 0.0000]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [43.154.54.12 listed in wl.mailspike.net]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'device'.
 Delete the redundant word 'which'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/thermal/cpufreq_cooling.c | 2 +-
 drivers/thermal/thermal_of.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpufreq_cooling.c b/drivers/thermal/cpufreq_cooling.c
index b8151d95a806..13551b386e72 100644
--- a/drivers/thermal/cpufreq_cooling.c
+++ b/drivers/thermal/cpufreq_cooling.c
@@ -495,7 +495,7 @@ static struct thermal_cooling_device_ops cpufreq_cooling_ops = {
 
 /**
  * __cpufreq_cooling_register - helper function to create cpufreq cooling device
- * @np: a valid struct device_node to the cooling device device tree node
+ * @np: a valid struct device_node to the cooling device tree node
  * @policy: cpufreq policy
  * Normally this should be same as cpufreq policy->related_cpus.
  * @em: Energy Model of the cpufreq policy
diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index b65d435cb92f..91bbed308305 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -651,7 +651,7 @@ EXPORT_SYMBOL_GPL(devm_thermal_zone_of_sensor_register);
 /**
  * devm_thermal_zone_of_sensor_unregister - Resource managed version of
  *				thermal_zone_of_sensor_unregister().
- * @dev: Device for which which resource was allocated.
+ * @dev: Device for which resource was allocated.
  * @tzd: a pointer to struct thermal_zone_device where the sensor is registered.
  *
  * This function removes the sensor callbacks and private data from the
-- 
2.36.1

