Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F144C2A87
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 12:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233845AbiBXLNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 06:13:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233958AbiBXLNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 06:13:15 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE412905B1;
        Thu, 24 Feb 2022 03:12:43 -0800 (PST)
Received: from kwepemi500022.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K49Fr2qGpzdZXK;
        Thu, 24 Feb 2022 19:11:28 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 kwepemi500022.china.huawei.com (7.221.188.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.18; Thu, 24 Feb 2022 19:12:40 +0800
Received: from localhost.localdomain (10.67.164.66) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Feb 2022 19:12:40 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <john.garry@huawei.com>,
        <acme@kernel.org>
CC:     <linux-perf-users@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH v2 0/2] Add Support for HiSilicon CPA PMU
Date:   Thu, 24 Feb 2022 19:11:27 +0800
Message-ID: <20220224111129.41416-1-liuqi115@huawei.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600003.china.huawei.com (7.193.23.202)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Support for HiSilicon CPA PMU, including PMU driver and json
file in perf tool.

Change since v1:
- Address the comments from John.
- Link: https://lore.kernel.org/linux-arm-kernel/20220214114228.40859-1-liuqi115@huawei.com/

Qi Liu (2):
  drivers/perf: hisi: Add Support for CPA PMU
  perf jevents: Add support for HiSilicon CPA PMU aliasing

 drivers/perf/hisilicon/Makefile               |   2 +-
 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c  | 401 ++++++++++++++++++
 include/linux/cpuhotplug.h                    |   1 +
 .../arm64/hisilicon/hip09/sys/uncore-cpa.json |  81 ++++
 tools/perf/pmu-events/jevents.c               |   1 +
 5 files changed, 485 insertions(+), 1 deletion(-)
 create mode 100644 drivers/perf/hisilicon/hisi_uncore_cpa_pmu.c
 create mode 100644 tools/perf/pmu-events/arch/arm64/hisilicon/hip09/sys/uncore-cpa.json

-- 
2.24.0

