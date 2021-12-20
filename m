Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6604B47A397
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 03:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237233AbhLTCTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 21:19:12 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:16831 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233948AbhLTCTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 21:19:11 -0500
Received: from dggpeml500022.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JHNY9470Xz91pm;
        Mon, 20 Dec 2021 10:18:21 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 20 Dec 2021 10:19:09 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 20 Dec
 2021 10:19:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH] MAINTAINERS: update SEC2 driver maintainers list
Date:   Mon, 20 Dec 2021 10:14:18 +0800
Message-ID: <20211220021418.2512-1-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Kai Ye as SEC2 maintainer.

Signed-off-by: Kai Ye <yekai13@huawei.com>
Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 00475646e3e3..81d8db03bac2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8628,6 +8628,7 @@ F:	drivers/scsi/hisi_sas/
 
 HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
 M:	Zaibo Xu <xuzaibo@huawei.com>
+M:	Kai Ye <yekai13@huawei.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
 F:	Documentation/ABI/testing/debugfs-hisi-sec
-- 
2.33.0

