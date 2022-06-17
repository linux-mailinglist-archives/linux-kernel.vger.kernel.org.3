Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091BC54F690
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381483AbiFQLSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381091AbiFQLSn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:18:43 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0486C556
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:18:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGernka_1655464718;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VGernka_1655464718)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 19:18:39 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: [PATCH v1 3/3] MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver
Date:   Fri, 17 Jun 2022 19:18:25 +0800
Message-Id: <20220617111825.92911-4-xueshuai@linux.alibaba.com>
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
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1fc9ead83d2a..68e02d471758 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -733,6 +733,14 @@ S:	Maintained
 F:	Documentation/i2c/busses/i2c-ali1563.rst
 F:	drivers/i2c/busses/i2c-ali1563.c
 
+ALIBABA PMU DRIVER
+M:	Shuai Xue <xueshuai@linux.alibaba.com>
+M:	Hongbo Yao <yaohongbo@linux.alibaba.com>
+M:	Neng Chen <nengchen@linux.alibaba.com>
+S:	Supported
+F:	Documentation/admin-guide/perf/alibaba_pmu.rst
+F:	drivers/perf/alibaba_uncore_dwr_pmu.c
+
 ALIENWARE WMI DRIVER
 L:	Dell.Client.Kernel@dell.com
 S:	Maintained
-- 
2.20.1.12.g72788fdb

