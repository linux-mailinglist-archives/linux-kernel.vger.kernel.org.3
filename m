Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD2DA595CAD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235231AbiHPNCf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:02:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiHPNAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:00:52 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31CBC696C1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 06:00:15 -0700 (PDT)
X-QQ-mid: bizesmtp86t1660654807tkv6gq1o
Received: from localhost.localdomain ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 16 Aug 2022 21:00:05 +0800 (CST)
X-QQ-SSF: 01000000002000B0D000B00A0000000
X-QQ-FEAT: ILHsT53NKPiwfveQKIMlSb8uUNjcT61ZAfBArjaWHDMA2e/AYZKCPLqaoxIaV
        5zms3kfliKaieI0WWHfpZ+sSDdPowLYuurOdn22sOLGELG1/iwa58Qdo+dqgGIZSyn91qZ9
        v/DB5RsnAsFYICXOWwnl7/3Z8xDKBfaY1an0wi1pKxu2YbeqaPHrvxfm8Ykxbj0MftC734J
        bXE4kVWNEdoECTeHSK0+rTHalup8+3DzJ+VNWx7Ok5waUXuqXdxk8kYDsGx+XXmGfMr/DKR
        yyJxE3A2oG2njxFuYYsqOWFyakR3cb1UkoPJPinVrVG6XV908McHBNE/hS9Q151rd4Opqjs
        iK01MYPhN/qEaDU3Tr5zCph8CTxJ7g7wdqjo31KmfPAIRXD/pmDL1MUby2L9VRRlu2hhfpy
        3nAonOYC1zM=
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] drivers/virtio: fix repeated words in comments
Date:   Tue, 16 Aug 2022 20:59:59 +0800
Message-Id: <20220816125959.23737-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'the'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/virtio/virtio_mmio.c           | 2 +-
 drivers/virtio/virtio_pci_modern_dev.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index f9a36bc7ac27..f638142654e6 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -255,7 +255,7 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
 
 	/*
 	 * Per memory-barriers.txt, wmb() is not needed to guarantee
-	 * that the the cache coherent memory writes have completed
+	 * that the cache coherent memory writes have completed
 	 * before writing to the MMIO region.
 	 */
 	writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index a0fa14f28a7f..b790f30b2b56 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -469,7 +469,7 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
 
 	/*
 	 * Per memory-barriers.txt, wmb() is not needed to guarantee
-	 * that the the cache coherent memory writes have completed
+	 * that the cache coherent memory writes have completed
 	 * before writing to the MMIO region.
 	 */
 	vp_iowrite8(status, &cfg->device_status);
-- 
2.36.1

