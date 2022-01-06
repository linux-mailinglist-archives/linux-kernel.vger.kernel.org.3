Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6751485E7C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344646AbiAFCQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:16:11 -0500
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:53618 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344590AbiAFCQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:16:10 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0V13r89o_1641435367;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0V13r89o_1641435367)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 06 Jan 2022 10:16:07 +0800
From:   Yang Li <yang.lee@linux.alibaba.com>
To:     rafael@kernel.org
Cc:     viresh.kumar@linaro.org, ray.huang@amd.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next] cpufreq: amd-pstate: Fix struct amd_cpudata kernel-doc comment
Date:   Thu,  6 Jan 2022 10:16:05 +0800
Message-Id: <20220106021605.93341-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the description of @req and @boost_supported in struct amd_cpudata
kernel-doc comment to remove warnings found by running scripts/kernel-doc,
which is caused by using 'make W=1'.

drivers/cpufreq/amd-pstate.c:104: warning: Function parameter or member
'req' not described in 'amd_cpudata'
drivers/cpufreq/amd-pstate.c:104: warning: Function parameter or member
'boost_supported' not described in 'amd_cpudata'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/cpufreq/amd-pstate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/amd-pstate.c b/drivers/cpufreq/amd-pstate.c
index 40ceb031abf5..9ce75ed11f8e 100644
--- a/drivers/cpufreq/amd-pstate.c
+++ b/drivers/cpufreq/amd-pstate.c
@@ -68,6 +68,7 @@ static struct cpufreq_driver amd_pstate_driver;
 /**
  * struct amd_cpudata - private CPU data for AMD P-State
  * @cpu: CPU number
+ * @req: constraint request to apply
  * @cppc_req_cached: cached performance request hints
  * @highest_perf: the maximum performance an individual processor may reach,
  *		  assuming ideal conditions
@@ -80,6 +81,7 @@ static struct cpufreq_driver amd_pstate_driver;
  * @min_freq: the frequency that mapped to lowest_perf
  * @nominal_freq: the frequency that mapped to nominal_perf
  * @lowest_nonlinear_freq: the frequency that mapped to lowest_nonlinear_perf
+ * @boost_supported: check whether the Processor or SBIOS supports boost mode
  *
  * The amd_cpudata is key private data for each CPU thread in AMD P-State, and
  * represents all the attributes and goals that AMD P-State requests at runtime.
-- 
2.20.1.7.g153144c

