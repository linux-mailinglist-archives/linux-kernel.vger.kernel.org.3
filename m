Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98663597C2E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 05:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243074AbiHRDSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 23:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiHRDSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 23:18:39 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D31015801
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 20:18:36 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VMZAdFI_1660792712;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VMZAdFI_1660792712)
          by smtp.aliyun-inc.com;
          Thu, 18 Aug 2022 11:18:33 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     will@kernel.org, Jonathan.Cameron@Huawei.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     rdunlap@infradead.org, robin.murphy@arm.com, mark.rutland@arm.com,
        baolin.wang@linux.alibaba.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: [PATCH v4 3/3] MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver
Date:   Thu, 18 Aug 2022 11:18:22 +0800
Message-Id: <20220818031822.38415-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
References: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers for Alibaba PMU document and driver

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f512b430c7cb..64d95db9179a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -749,6 +749,12 @@ S:	Supported
 F:	drivers/infiniband/hw/erdma
 F:	include/uapi/rdma/erdma-abi.h
 
+ALIBABA PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/alibaba_pmu.rst
+F:	drivers/perf/alibaba_uncore_dwr_pmu.c
+
 ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
-- 
2.20.1.12.g72788fdb

