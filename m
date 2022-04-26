Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B45B50FF1F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350989AbiDZNhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350985AbiDZNhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:37:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9242FE54
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:34:11 -0700 (PDT)
Received: from kwepemi100021.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KnjX06sWPzhYfw;
        Tue, 26 Apr 2022 21:33:52 +0800 (CST)
Received: from kwepemm600016.china.huawei.com (7.193.23.20) by
 kwepemi100021.china.huawei.com (7.221.188.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 21:34:09 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600016.china.huawei.com (7.193.23.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 21:34:09 +0800
From:   Guangbin Huang <huangguangbin2@huawei.com>
To:     <john.garry@huawei.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <f.fangjian@huawei.com>, <huangguangbin2@huawei.com>,
        <lipeng321@huawei.com>, <shenjian15@huawei.com>
Subject: [PATCH V5 0/2] drivers/perf: hisi: Add driver for HNS3 PMU
Date:   Tue, 26 Apr 2022 21:28:20 +0800
Message-ID: <20220426132822.51735-1-huangguangbin2@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600016.china.huawei.com (7.193.23.20)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch-set adds driver for HNS3(HiSilicon network system version 3)
PMU and doc to descript it.

Change logs:
V4 -> V5:
 - Add COMPILE_TEST and include io-64-nonatomic-hi-lo.h as suggestion of
   John Garry.
V3 -> V4:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220329113930.37631-1-huangguangbin2@huawei.com/
V2 -> V3:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220228123955.30284-1-huangguangbin2@huawei.com/
V1 -> V2:
 - Modify the comments of John Garry.
 - Link: https://lore.kernel.org/linux-arm-kernel/20220117015222.9617-1-huangguangbin2@huawei.com/

Guangbin Huang (2):
  drivers/perf: hisi: Add description for HNS3 PMU driver
  drivers/perf: hisi: add driver for HNS3 PMU

 Documentation/admin-guide/perf/hns3-pmu.rst |  136 ++
 MAINTAINERS                                 |    6 +
 drivers/perf/hisilicon/Kconfig              |   10 +
 drivers/perf/hisilicon/Makefile             |    1 +
 drivers/perf/hisilicon/hns3_pmu.c           | 1660 +++++++++++++++++++
 include/linux/cpuhotplug.h                  |    1 +
 6 files changed, 1814 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hns3-pmu.rst
 create mode 100644 drivers/perf/hisilicon/hns3_pmu.c

-- 
2.33.0

