Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7E5C575955
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 04:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbiGOB7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 21:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiGOB7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 21:59:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D341C70990
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 18:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=vEceNqWArc9rT1foO9LbA90xHmJT6qECUMcexpErQZc=; b=r0cZgQvWX92In1JSfLUXd2FT7G
        YtOI9zSR2/JPOBrGkCnAi8CJDylr83DzNtZ+njh8jysPjp/mBP6ph0AD10mR99CicqHs5CAiNgFDD
        TPgN+0IpOPRhSsEGH/doz0pSHUgxsV4qMLybv4ajpiOecZnSokoPZY1LQ2aQBsKktG2NsYBHItdsC
        zbFOb9uK+u0roBk5rxR4a2GCXeWCsqhv8imleed8eM5pPF/j+gxzS8uLIftLwuUbu1oO1PBXWhVwk
        SjbMsA6hyP/10kYbeL8McnJUJrG0mKOlLleh110cHBDg9Tmf12Zr9jg1FrNGWqKQQqnG9y5zhsgZa
        3c3YaxFA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oCAcL-009sZa-2D; Fri, 15 Jul 2022 01:59:45 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] coresight: trbe: fix Kconfig "its" grammar
Date:   Thu, 14 Jul 2022 18:59:25 -0700
Message-Id: <20220715015925.12569-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the possessive "its" instead of the contraction "it's"
where appropriate.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/hwtracing/coresight/Kconfig |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwtracing/coresight/Kconfig
+++ b/drivers/hwtracing/coresight/Kconfig
@@ -193,10 +193,10 @@ config CORESIGHT_TRBE
 	depends on ARM64 && CORESIGHT_SOURCE_ETM4X
 	help
 	  This driver provides support for percpu Trace Buffer Extension (TRBE).
-	  TRBE always needs to be used along with it's corresponding percpu ETE
+	  TRBE always needs to be used along with its corresponding percpu ETE
 	  component. ETE generates trace data which is then captured with TRBE.
 	  Unlike traditional sink devices, TRBE is a CPU feature accessible via
-	  system registers. But it's explicit dependency with trace unit (ETE)
+	  system registers. But its explicit dependency with trace unit (ETE)
 	  requires it to be plugged in as a coresight sink device.
 
 	  To compile this driver as a module, choose M here: the module will be
