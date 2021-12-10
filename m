Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E506646FB9A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 08:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbhLJHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 02:37:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:61711 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229609AbhLJHhI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 02:37:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639121613; x=1670657613;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3dgij29B/NfHaJNdI2BgpUVz41YB6dQPXaYOWy9NegE=;
  b=fbxQhkXYtBtleiBD1wPhxx9R1NhRmUms7v5BJMxYID7PT1k9r5OzqiiB
   8FMrJHgAuLRyXu4LS2Aq7JZAiubM9e38eXGirI2nqoDeSVWzyWotEbesx
   4ybWscf8lonQHP/fChVQRlW+3+sLrUYLi3BC0XjEUn5aTZjiw2iK8/Y6Y
   OPGrjsTQyCI6cWkmoPamQsl972IJBrXc/uVvFEW3XD/kumu7/dyuXC11l
   YPZ7vaB8do5MGdq8t1qBmTvYLk4flbzRtMezu/W0EYs3WzWqNKJn5f2bD
   wqgFBsXi/3YhS92urlBYBClaArJ8P4HEoembtDfyw9ps0yM7wfsPtECg9
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="235808702"
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="235808702"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 23:33:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,194,1635231600"; 
   d="scan'208";a="612842976"
Received: from dmi-pnp-i7.sh.intel.com ([10.239.159.101])
  by orsmga004.jf.intel.com with ESMTP; 09 Dec 2021 23:33:30 -0800
From:   Dapeng Mi <dapeng1.mi@intel.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Dapeng Mi <dapeng1.mi@intel.com>
Subject: [PATCH] virtio: fix a typo in function "vp_modern_remove" comments.
Date:   Fri, 10 Dec 2021 15:35:46 +0800
Message-Id: <20211210073546.700783-1-dapeng1.mi@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function name "vp_modern_remove" in comments is written to
"vp_modern_probe" incorrectly. Change it.

Signed-off-by: Dapeng Mi <dapeng1.mi@intel.com>
---
 drivers/virtio/virtio_pci_modern_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index e11ed748e661..e8b3ff2b9fbc 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -345,7 +345,7 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
 EXPORT_SYMBOL_GPL(vp_modern_probe);
 
 /*
- * vp_modern_probe: remove and cleanup the modern virtio pci device
+ * vp_modern_remove: remove and cleanup the modern virtio pci device
  * @mdev: the modern virtio-pci device
  */
 void vp_modern_remove(struct virtio_pci_modern_device *mdev)
-- 
2.30.2

