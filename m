Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C68515441B6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 04:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237333AbiFIC6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 22:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIC6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 22:58:10 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3664E119926;
        Wed,  8 Jun 2022 19:58:06 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LJTGM1skZzRhb9;
        Thu,  9 Jun 2022 10:54:51 +0800 (CST)
Received: from huawei.com (10.145.46.56) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 9 Jun
 2022 10:58:03 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
CC:     <qianweili@huawei.com>, <shenyang39@huawei.com>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH] MAINTAINERS: update HiSilicon ZIP and QM maintainers
Date:   Thu, 9 Jun 2022 02:56:39 +0000
Message-ID: <20220609025639.3280804-1-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.145.46.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch splits QM and ZIP in MAINTAINERS, then add Weili Qian for QM
driver and Yang Shen for ZIP driver. This patch adds missing Kconfig and
Makefile files as well.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
---
 MAINTAINERS | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6d3bd9d2a8d..b04fb3324837 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8936,16 +8936,25 @@ F:	Documentation/admin-guide/perf/hisi-pcie-pmu.rst
 F:	Documentation/admin-guide/perf/hisi-pmu.rst
 F:	drivers/perf/hisilicon
 
-HISILICON QM AND ZIP Controller DRIVER
+HISILICON QM DRIVER
+M:	Weili Qian <qianweili@huawei.com>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
-F:	Documentation/ABI/testing/debugfs-hisi-zip
+F:	drivers/crypto/hisilicon/Kconfig
+F:	drivers/crypto/hisilicon/Makefile
 F:	drivers/crypto/hisilicon/qm.c
 F:	drivers/crypto/hisilicon/sgl.c
-F:	drivers/crypto/hisilicon/zip/
 F:	include/linux/hisi_acc_qm.h
 
+HISILICON ZIP Controller DRIVER
+M:	Yang Shen <shenyang39@huawei.com>
+M:	Zhou Wang <wangzhou1@hisilicon.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	Documentation/ABI/testing/debugfs-hisi-zip
+F:	drivers/crypto/hisilicon/zip/
+
 HISILICON ROCE DRIVER
 M:	Wenpeng Liang <liangwenpeng@huawei.com>
 M:	Weihang Li <liweihang@huawei.com>
-- 
2.34.1

