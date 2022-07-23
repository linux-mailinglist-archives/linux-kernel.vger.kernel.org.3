Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4B757F154
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 22:28:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiGWU2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 16:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbiGWU2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 16:28:02 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B847140B9;
        Sat, 23 Jul 2022 13:28:01 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id B7266320024A;
        Sat, 23 Jul 2022 16:27:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 23 Jul 2022 16:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        invisiblethingslab.com; h=cc:cc:content-transfer-encoding:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm3; t=1658608078; x=
        1658694478; bh=JobHjI4vPeM2BF7bd/XNMmcC9Kn1HoQurkd99RcLsRk=; b=M
        WTbsxQI9l4G7tqQAiHf/K7oMTU8ufWVr4ldV3R0crGVCTUJE7fJXbX/llcvh7KRu
        lMPM4KBNzZXu+MCHVaVLJQ0vLXz6MvmZsaqgDYfLZ4LJ14ywaAxJBJmLhz8um+EW
        k7IzfudSehvF4XvP4qQma6b8jgN2bz148Fdt6Yt+6d8M5tufHxPp55tYcCM2qKUa
        AYxF2DvjnVWkrL/qH2HxZEmzjG/JCRLw22jYZo/5WVhG4frOZki37ELYn0CVoGO4
        7ORJfy/Cr/ZwsgiqTSIevzoBtjgL4Kf/ojeISpBEqc1eKHbu+qZhcF2WSCHN5rc5
        UqLNwgbiVCjkEGxQwZn/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1658608078; x=1658694478; bh=JobHjI4vPeM2BF7bd/XNMmcC9Kn1HoQurkd
        99RcLsRk=; b=BQzLN7kwQvOQTpo8U3OTqq0SwNGL/plAlnFsyOgbYUHXhPgDTuE
        Ow0WJS1uDHRgtvX6+v3V2jy+yZohTe8uG+k8qH/8cwoHhxr9rZZzpAnEE39A7F7U
        vmR/K50G5UxQFjvDe06/kn6PxIbeVr9nrDsPaaWJ85y6C7zKo7aJsfV2r05HpZwC
        FcNsswMDcMZsLMNOUVJF03H5qTfEl89C4kA999nfCRI30K+0Wa/kznBB5Z54GKnL
        /l9SClT6onhEurr+kr0nJEU5bp9RBu8qn8PoHk/0DRiMVahfQVcMcTtG6JhmzQ94
        N7EPeagF7IvLMo3QXMSu4z0uaeTP2PzmO2A==
X-ME-Sender: <xms:zVncYhja2YsMrz1pascGufrCx-vqsDs7MGodUpfU5PyD-sr2YADKBQ>
    <xme:zVncYmCIyWtQJbimb9qARN54THJuUyrg0YANqUKRC1MEbRaqcc0DIy_NSObJ2x4fn
    OA7cu7xiMabMbw>
X-ME-Received: <xmr:zVncYhGpNeWW41J4StWOV6iVK3bLRdtt3oXkt--Z3xypZtt4N-uIMUvsFM2j52Flw7UdtCyTH9OJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvddtgedgudehfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffvghmihcu
    ofgrrhhivgcuqfgsvghnohhurhcuoeguvghmihesihhnvhhishhisghlvghthhhinhhgsh
    hlrggsrdgtohhmqeenucggtffrrghtthgvrhhnpedvfeegkedvkefgffegkefhieejtdff
    keehhfelheefjeeutefgleeggfdtveeileenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpeguvghmihesihhnvhhishhisghlvghthhhinhhgshhl
    rggsrdgtohhm
X-ME-Proxy: <xmx:zVncYmSuTaxvkIgwjscXUi8qDgWXvKe6gD2lmBle3EWjy3oFhFI1NQ>
    <xmx:zVncYuzcNODMt62BbUfJJcV9PQx4ynVBof6lhT7Qyp7kT5mOx5dHyQ>
    <xmx:zVncYs60dMfNq7vzWLaR2BI0_Q09317PxJRuAe88bvcOZ_NfiHTrxQ>
    <xmx:zlncYi-mxStZ1a7CLztz4dQx6lLzHJqDKQf5N9ww0Zv3zFhmN0ogwA>
Feedback-ID: iac594737:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 23 Jul 2022 16:27:57 -0400 (EDT)
From:   Demi Marie Obenour <demi@invisiblethingslab.com>
To:     =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     Demi Marie Obenour <demi@invisiblethingslab.com>,
        xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] Implement diskseq checks in blkback
Date:   Sat, 23 Jul 2022 16:27:15 -0400
Message-Id: <20220723202715.1347-1-demi@invisiblethingslab.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This allows specifying a disk sequence number in XenStore.  If it does
not match the disk sequence number of the underlying device, the device
will not be exported and a warning will be logged.  Userspace can use
this to eliminate race conditions due to major/minor number reuse.
Older kernels will ignore this, so it is safe for userspace to set it
unconditionally.

Signed-off-by: Demi Marie Obenour <demi@invisiblethingslab.com>
---
I'm marking this patch as RFC because I have not tested it beyond
compiliation, and because I want to get feedback on the API before I put
more effort into it.

 drivers/block/xen-blkback/xenbus.c | 35 ++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/block/xen-blkback/xenbus.c b/drivers/block/xen-blkback/xenbus.c
index 97de13b14175eb8ced14d1649a3be461a464ee8a..cb531236b19709c791a82c868bfb4ed9aa284485 100644
--- a/drivers/block/xen-blkback/xenbus.c
+++ b/drivers/block/xen-blkback/xenbus.c
@@ -480,7 +480,7 @@ MODULE_PARM_DESC(feature_persistent,
 
 static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 			  unsigned major, unsigned minor, int readonly,
-			  int cdrom)
+			  bool cdrom, u64 diskseq)
 {
 	struct xen_vbd *vbd;
 	struct block_device *bdev;
@@ -508,6 +508,25 @@ static int xen_vbd_create(struct xen_blkif *blkif, blkif_vdev_t handle,
 		xen_vbd_free(vbd);
 		return -ENOENT;
 	}
+
+	if (diskseq != (u64)-1) {
+		struct gendisk *disk = bdev->bd_disk;
+		if (unlikely(disk == NULL)) {
+			pr_err("xen_vbd_create: device %08x has no gendisk\n",
+			       vbd->pdevice);
+			xen_vbd_free(vbd);
+			return -EFAULT;
+		}
+
+		if (unlikely(disk->diskseq != diskseq)) {
+			pr_warn("xen_vbd_create: device %08x has incorrect sequence "
+				"number 0x%llx (expected 0x%llx)\n",
+				vbd->pdevice, disk->diskseq, diskseq);
+			xen_vbd_free(vbd);
+			return -ENODEV;
+		}
+	}
+
 	vbd->size = vbd_sz(vbd);
 
 	if (cdrom || disk_to_cdi(vbd->bdev->bd_disk))
@@ -712,6 +731,7 @@ static void backend_changed(struct xenbus_watch *watch,
 	int cdrom = 0;
 	unsigned long handle;
 	char *device_type;
+	unsigned long long diskseq;
 
 	pr_debug("%s %p %d\n", __func__, dev, dev->otherend_id);
 
@@ -730,6 +750,17 @@ static void backend_changed(struct xenbus_watch *watch,
 		return;
 	}
 
+	err = xenbus_scanf(XBT_NIL, dev->nodename, "diskseq", "%llx", &diskseq);
+	if (err == -ENOENT) {
+		diskseq = (uint64_t)-1;
+	} else if (err != 1) {
+		xenbus_dev_fatal(dev, err, "reading diskseq");
+		return;
+	} else if (diskseq == (uint64_t)-1) {
+		xenbus_dev_fatal(dev, err, "UINT64_MAX is not a valid diskseq");
+		return;
+	}
+
 	if (be->major | be->minor) {
 		if (be->major != major || be->minor != minor)
 			pr_warn("changing physical device (from %x:%x to %x:%x) not supported.\n",
@@ -763,7 +794,7 @@ static void backend_changed(struct xenbus_watch *watch,
 	be->minor = minor;
 
 	err = xen_vbd_create(be->blkif, handle, major, minor,
-			     !strchr(be->mode, 'w'), cdrom);
+			     !strchr(be->mode, 'w'), cdrom, diskseq);
 
 	if (err)
 		xenbus_dev_fatal(dev, err, "creating vbd structure");
-- 
Sincerely,
Demi Marie Obenour (she/her/hers)
Invisible Things Lab
