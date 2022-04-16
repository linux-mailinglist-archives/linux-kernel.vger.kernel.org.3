Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0750B503609
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 12:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiDPKyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 06:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiDPKyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 06:54:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD8753A73F;
        Sat, 16 Apr 2022 03:51:46 -0700 (PDT)
Received: from kwepemi500001.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgVPW0B02zgY9w;
        Sat, 16 Apr 2022 18:51:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (7.193.23.164) by
 kwepemi500001.china.huawei.com (7.221.188.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:51:45 +0800
Received: from localhost.localdomain (10.67.165.24) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 18:51:44 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 1/4] crypto: hisilicon/qm - remove unused function declaration
Date:   Sat, 16 Apr 2022 18:45:56 +0800
Message-ID: <20220416104559.10826-2-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220416104559.10826-1-qianweili@huawei.com>
References: <20220416104559.10826-1-qianweili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'hisi_qm_get_hw_version' function is unused, so remove the function
declaration.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 include/linux/hisi_acc_qm.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/hisi_acc_qm.h b/include/linux/hisi_acc_qm.h
index 177f7b7cd414..0b1585bc37f9 100644
--- a/include/linux/hisi_acc_qm.h
+++ b/include/linux/hisi_acc_qm.h
@@ -441,7 +441,6 @@ int hisi_qp_send(struct hisi_qp *qp, const void *msg);
 int hisi_qm_get_free_qp_num(struct hisi_qm *qm);
 int hisi_qm_get_vft(struct hisi_qm *qm, u32 *base, u32 *number);
 void hisi_qm_debug_init(struct hisi_qm *qm);
-enum qm_hw_ver hisi_qm_get_hw_version(struct pci_dev *pdev);
 void hisi_qm_debug_regs_clear(struct hisi_qm *qm);
 int hisi_qm_sriov_enable(struct pci_dev *pdev, int max_vfs);
 int hisi_qm_sriov_disable(struct pci_dev *pdev, bool is_frozen);
-- 
2.33.0

