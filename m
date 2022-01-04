Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628A1483E2E
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234114AbiADIeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:34:25 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:16683 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbiADIeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:34:21 -0500
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JSm656HnxzZdyJ;
        Tue,  4 Jan 2022 16:30:53 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500021.china.huawei.com (7.185.36.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 16:34:19 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 4 Jan
 2022 16:34:19 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <herbert@gondor.apana.org.au>, <linux-crypto@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <yekai13@huawei.com>
Subject: [PATCH v2 2/4] Documentation: update debugfs doc for Hisilicon SEC
Date:   Tue, 4 Jan 2022 16:29:17 +0800
Message-ID: <20220104082919.45742-3-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220104082919.45742-1-yekai13@huawei.com>
References: <20220104082919.45742-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation describing DebugFS for function's QoS limiting.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-sec | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-hisi-sec b/Documentation/ABI/testing/debugfs-hisi-sec
index 58cfa354534c..2bf84ced484b 100644
--- a/Documentation/ABI/testing/debugfs-hisi-sec
+++ b/Documentation/ABI/testing/debugfs-hisi-sec
@@ -14,6 +14,16 @@ Description:	One SEC controller has one PF and multiple VFs, each function
 		qm refers to.
 		Only available for PF.
 
+What:		/sys/kernel/debug/hisi_sec2/<bdf>/alg_qos
+Date:		Jun 2021
+Contact:	linux-crypto@vger.kernel.org
+Description:	The <bdf> is related the function for PF and VF.
+		SEC driver supports to configure each function's QoS, the driver
+		supports to write <bdf> value to alg_qos in the host. Such as
+		"echo <bdf> value > alg_qos". The qos value is 1~1000, means
+		1/1000~1000/1000 of total QoS. The driver reading alg_qos to
+		get related QoS in the host and VM, Such as "cat alg_qos".
+
 What:		/sys/kernel/debug/hisi_sec2/<bdf>/qm/qm_regs
 Date:		Oct 2019
 Contact:	linux-crypto@vger.kernel.org
-- 
2.33.0

