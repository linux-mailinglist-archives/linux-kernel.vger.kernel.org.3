Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BC25441CA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237494AbiFIDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiFIDLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:11:16 -0400
Received: from ssh248.corpemail.net (ssh248.corpemail.net [210.51.61.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CEA262F2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:11:13 -0700 (PDT)
Received: from ([60.208.111.195])
        by ssh248.corpemail.net ((D)) with ASMTP (SSL) id DZU00008;
        Thu, 09 Jun 2022 11:11:08 +0800
Received: from localhost.localdomain (10.200.104.97) by
 jtjnmail201612.home.langchao.com (10.100.2.12) with Microsoft SMTP Server id
 15.1.2308.27; Thu, 9 Jun 2022 11:11:09 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <mst@redhat.com>, <jasowang@redhat.com>
CC:     <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Bo Liu <liubo03@inspur.com>
Subject: [PATCH] virtio: Fix all occurences of the "the the" typo
Date:   Wed, 8 Jun 2022 23:11:06 -0400
Message-ID: <20220609031106.2161-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.200.104.97]
tUid:   2022609111108a920feee96772a42879107ac0cc7e9e7
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are double "the" in message in file virtio_mmio.c
and virtio_pci_modern_dev.c, fix it.

Signed-off-by: Bo Liu <liubo03@inspur.com>
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
2.27.0

