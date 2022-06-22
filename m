Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01855508F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 17:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376341AbiFVP7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 11:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358806AbiFVP7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 11:59:36 -0400
Received: from smtpbg.qq.com (smtpbg139.qq.com [175.27.65.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45EE424A5;
        Wed, 22 Jun 2022 08:56:07 -0700 (PDT)
X-QQ-mid: bizesmtp72t1655913349t5adrqbn
Received: from ubuntu.localdomain ( [106.117.78.84])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 22 Jun 2022 23:55:45 +0800 (CST)
X-QQ-SSF: 01000000008000B0C000E00A0000000
X-QQ-FEAT: 4LFlwc+MlXkWqkXPuo69O6o31VcC4iuyusTuvZLpaC9WVGwA3erFPe5o2KJZR
        LXr0vAZL7Fmh5GGJcSgQxrrgKFl221Czj/8h9QyRG4AQaCLSEGDmA/Yec46IpYXXTwwmFwE
        UCrQHw74rOsEr1XkEjXOcD1o+BMJ44qcwWDnaAM/aQtBppLG7sHRzmOsv9TZUxU6j7TQRra
        aNp88TmL63uc5RnxhHe2ro9UO5l3JsxYprLms56KKF3YAAfie3lKIPuhNBBPjwr9SJZKN1C
        HA4lqolxLcOBxfBh30lwhoAFqtihUIqnmknpSILFPgXRDeH9zeA9+bX6zx34SeiGQRLePYF
        s53tAfi9Ht3ipxefgIccdZq6jayw9UInOkzubgx
X-QQ-GoodBg: 0
From:   Jiang Jian <jiangjian@cdjrlc.com>
To:     rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jiang Jian <jiangjian@cdjrlc.com>
Subject: [PATCH] thermal: intel: drop unexpected word 'is' in the comments
Date:   Wed, 22 Jun 2022 23:55:43 +0800
Message-Id: <20220622155543.9780-1-jiangjian@cdjrlc.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

there is an unexpected word 'is' in the comments that need to be dropped

file: ./drivers/thermal/intel/x86_pkg_temp_thermal.c
line: 108

* tj-max is is interesting because threshold is set relative to this

changed to:

* tj-max is interesting because threshold is set relative to this

Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
---
 drivers/thermal/intel/x86_pkg_temp_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/x86_pkg_temp_thermal.c b/drivers/thermal/intel/x86_pkg_temp_thermal.c
index 4d8edc61a78b..a0e234fce71a 100644
--- a/drivers/thermal/intel/x86_pkg_temp_thermal.c
+++ b/drivers/thermal/intel/x86_pkg_temp_thermal.c
@@ -105,7 +105,7 @@ static struct zone_device *pkg_temp_thermal_get_dev(unsigned int cpu)
 }
 
 /*
-* tj-max is is interesting because threshold is set relative to this
+* tj-max is interesting because threshold is set relative to this
 * temperature.
 */
 static int get_tj_max(int cpu, u32 *tj_max)
-- 
2.17.1

