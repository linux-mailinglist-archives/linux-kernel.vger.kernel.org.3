Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F24CE83E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 03:14:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232328AbiCFCOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 21:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiCFCOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 21:14:45 -0500
Received: from smtpbg152.qq.com (smtpbg152.qq.com [13.245.186.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629C82558F
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 18:13:52 -0800 (PST)
X-QQ-mid: bizesmtp81t1646532791ty7g9dcd
Received: from localhost.localdomain ( [114.222.120.105])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 06 Mar 2022 10:13:07 +0800 (CST)
X-QQ-SSF: 01400000002000B0I000B00A0000000
X-QQ-FEAT: F3yR32iATbgoKmRa+/ACZ5tBy7VQO2f62uNr8Pg/PwvjBE9cLNkKrbP0hJphd
        R8j7S/FzfONMY+lSUcXuiLgtrrk104nsOWLgQKrHnT6e3GK+uYfA/AO3zc4u6BvDNcuJ7Y5
        STiT7blnPgM3+WI8Bteg+sKhk67HfrKHIktlXhU6QkM6jCV9iRyXbWXKHD/RjS5CQU3W0Qy
        yy4JURuJaa9zvQ+5BxIt1aljtCjfjEcKQM+ZEMhmNlFuClX2R3Dzt8EZr0BUX7hgwJyuf3b
        kpRo2oYdPt3r9ZvRPcG2lsDj/SPK5desWXBgV5ulYIN3ZdJUS7zHMDx6X1+bj3uimkHj2Wc
        aR9/GYYoTFg/v74f7E=
X-QQ-GoodBg: 2
From:   zhanglianjie <zhanglianjie@uniontech.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanglianjie <zhanglianjie@uniontech.com>
Subject: [PATCH 2/2] cpufreq: use helper macro __ATTR_XX
Date:   Sun,  6 Mar 2022 10:12:50 +0800
Message-Id: <20220306021250.64315-2-zhanglianjie@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220306021250.64315-1-zhanglianjie@uniontech.com>
References: <20220306021250.64315-1-zhanglianjie@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro __ATTR_XX  to make code more clear.
Minor readability improvement.

Signed-off-by: zhanglianjie <zhanglianjie@uniontech.com>

diff --git a/drivers/cpufreq/cpufreq_governor.h b/drivers/cpufreq/cpufreq_governor.h
index 65ecf32ba4f8..a5a0bc3cc23e 100644
--- a/drivers/cpufreq/cpufreq_governor.h
+++ b/drivers/cpufreq/cpufreq_governor.h
@@ -68,12 +68,10 @@ static ssize_t file_name##_show						\
 }

 #define gov_attr_ro(_name)						\
-static struct governor_attr _name =					\
-__ATTR(_name, 0444, _name##_show, NULL)
+static struct governor_attr _name = __ATTR_RO(_name)

 #define gov_attr_rw(_name)						\
-static struct governor_attr _name =					\
-__ATTR(_name, 0644, _name##_show, _name##_store)
+static struct governor_attr _name = __ATTR_RW(_name)

 /* Common to all CPUs of a policy */
 struct policy_dbs_info {
--
2.20.1



