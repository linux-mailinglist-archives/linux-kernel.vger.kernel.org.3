Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB3354F68C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 13:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381564AbiFQLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381258AbiFQLSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 07:18:39 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763CB6B021
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 04:18:38 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0VGerni7_1655464707;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VGerni7_1655464707)
          by smtp.aliyun-inc.com;
          Fri, 17 Jun 2022 19:18:35 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        will@kernel.org, mark.rutland@arm.com
Cc:     baolin.wang@linux.alibaba.com, yaohongbo@linux.alibaba.com,
        nengchen@linux.alibaba.com, zhuo.song@linux.alibaba.com
Subject: [PATCH v1 0/3] drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710 SoC
Date:   Fri, 17 Jun 2022 19:18:22 +0800
Message-Id: <20220617111825.92911-1-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
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

This patchset adds support for Yitian 710 DDR Sub-System Driveway PMU driver,
which custom-built by Alibaba Group's chip development business, T-Head.

Shuai Xue (3):
  docs: perf: Add description for Alibaba's T-Head PMU driver
  drivers/perf: add DDR Sub-System Driveway PMU driver for Yitian 710
    SoC
  MAINTAINERS: add maintainers for Alibaba' T-Head PMU driver

 .../admin-guide/perf/alibaba_pmu.rst          |  94 +++
 Documentation/admin-guide/perf/index.rst      |   1 +
 MAINTAINERS                                   |   8 +
 drivers/perf/Kconfig                          |   8 +
 drivers/perf/Makefile                         |   1 +
 drivers/perf/alibaba_uncore_drw_pmu.c         | 771 ++++++++++++++++++
 6 files changed, 883 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/alibaba_pmu.rst
 create mode 100644 drivers/perf/alibaba_uncore_drw_pmu.c

-- 
2.20.1.12.g72788fdb

