Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEFFA4FA5B0
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 10:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239049AbiDIILU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 04:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiDIILS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 04:11:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A043B2B262;
        Sat,  9 Apr 2022 01:09:11 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kb72J2nwbzBs58;
        Sat,  9 Apr 2022 16:04:56 +0800 (CST)
Received: from dggpeml100012.china.huawei.com (7.185.36.121) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 9 Apr 2022 16:09:10 +0800
Received: from huawei.com (10.67.165.24) by dggpeml100012.china.huawei.com
 (7.185.36.121) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Sat, 9 Apr
 2022 16:09:09 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 05/11] Documentation: update debugfs doc for Hisilicon HPRE
Date:   Sat, 9 Apr 2022 16:03:22 +0800
Message-ID: <20220409080328.15783-6-yekai13@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220409080328.15783-1-yekai13@huawei.com>
References: <20220409080328.15783-1-yekai13@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100012.china.huawei.com (7.185.36.121)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update documentation describing DebugFS that could help
to check the change of register values.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 Documentation/ABI/testing/debugfs-hisi-hpre | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/debugfs-hisi-hpre b/Documentation/ABI/testing/debugfs-hisi-hpre
index 396de7bc735d..82abf92df429 100644
--- a/Documentation/ABI/testing/debugfs-hisi-hpre
+++ b/Documentation/ABI/testing/debugfs-hisi-hpre
@@ -104,6 +104,20 @@ Description:	Dump the status of the QM.
 		Four states: initiated, started, stopped and closed.
 		Available for both PF and VF, and take no other effect on HPRE.
 
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/qm/diff_regs
+Date:		Mar 2022
+Contact:	linux-crypto@vger.kernel.org
+Description:	QM debug registers(regs) read hardware register value. This
+		node is used to show the change of the qm register values. This
+		node can be help users to check the change of register values.
+
+What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/diff_regs
+Date:		Mar 2022
+Contact:	linux-crypto@vger.kernel.org
+Description:	HPRE debug registers(regs) read hardware register value. This
+		node is used to show the change of the register values. This
+		node can be help users to check the change of register values.
+
 What:		/sys/kernel/debug/hisi_hpre/<bdf>/hpre_dfx/send_cnt
 Date:		Apr 2020
 Contact:	linux-crypto@vger.kernel.org
-- 
2.33.0

