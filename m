Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC2247F268
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 07:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbhLYGcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 01:32:19 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:30107 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhLYGcP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 01:32:15 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4JLYt43qD3z1DK1X;
        Sat, 25 Dec 2021 14:29:00 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 25 Dec 2021 14:32:13 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 25 Dec
 2021 14:32:12 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <xuzaibo@huawei.com>,
        <yekai13@huawei.com>
Subject: [PATCH 2/3] Documentation: update debugfs doc for Hisilicon ZIP
Date:   Sat, 25 Dec 2021 14:27:17 +0800
Message-ID: <20211225062718.41155-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211225062718.41155-1-yekai13@huawei.com>
References: <20211225062718.41155-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation describing DebugFS for function's QoS limiting.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-zip | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-hisi-zip b/Documentation/ABI/testing/debugfs-hisi-zip
index 3034a2bf99ca..aff2edc24c94 100644
--- a/Documentation/ABI/testing/debugfs-hisi-zip
+++ b/Documentation/ABI/testing/debugfs-hisi-zip
@@ -26,6 +26,16 @@ Description:    One ZIP controller has one PF and multiple VFs, each function
 		has a QM. Select the QM which below qm refers to.
 		Only available for PF.
 
+What:           /sys/kernel/debug/hisi_zip/<bdf>/alg_qos
+Date:           Jun 2021
+Contact:        linux-crypto@vger.kernel.org
+Description:	The <bdf> is related the function for PF and VF.
+		ZIP driver supports to configure each function's QoS, the driver
+		supports to write <bdf> value to alg_qos in the host. Such as
+		"echo <bdf> value > alg_qos". The qos value is 1~1000, means
+		1/1000~1000/1000 of total QoS. The driver reading alg_qos to
+		get related QoS in the host and VM, Such as "cat alg_qos".
+
 What:           /sys/kernel/debug/hisi_zip/<bdf>/qm/regs
 Date:           Nov 2018
 Contact:        linux-crypto@vger.kernel.org
-- 
2.33.0

