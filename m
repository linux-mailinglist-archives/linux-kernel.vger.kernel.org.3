Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE256C9C6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 16:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiGIOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiGIOEa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 10:04:30 -0400
X-Greylist: delayed 2133 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 09 Jul 2022 07:04:29 PDT
Received: from mx.treblig.org (mx.treblig.org [46.43.15.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF45F583;
        Sat,  9 Jul 2022 07:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
        ; s=bytemarkmx; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Xy8ubJM19l5B+/jHiAaZkPSjAzrfLOLGuvhstO9qrAk=; b=cztDcspyhTOeNsgI5YLGRPBoLs
        7ORAAkFzzar3DzyXA3lLZP2be9UXbVO2hniHdlS9X/e8zb+Zv/vuU6JDQBLlqQHCz8Na9D1grPi0b
        TdGQBS3tN1XXSk89bz1Zo9sNtG2r+HWafog3AiBbDjn/9OrDd2q/S+P9O65D0k0bSPo4ag7LLlNVn
        5iwgYV1IfMGKTsVRybGHadSCiM47YsOhtw9Ra3YwKiDwIFSLdmfSMtAr/lTNTiQgsrEOSz9ftj5cD
        iuF9EDwgG4Hbp3JKFwDJzi3GSbDWOkEW8RlcfOujpJ1XpOcoipTbtMYiyJdIWqTvAg9C8KheiNGot
        wdPWpgHA==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
        by mx.treblig.org with esmtp (Exim 4.94.2)
        (envelope-from <linux@treblig.org>)
        id 1oAAVt-009EjG-Pe; Sat, 09 Jul 2022 14:28:48 +0100
From:   linux@treblig.org
To:     linux-kernel@vger.kernel.org, corbet@lwn.net, davem@davemloft.net,
        jgg@ziepe.ca
Cc:     linux-doc@vger.kernel.org,
        "Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] typos: Fix 'namespace' typos
Date:   Sat,  9 Jul 2022 14:28:30 +0100
Message-Id: <20220709132830.9869-1-linux@treblig.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Dr. David Alan Gilbert" <linux@treblig.org>

'namespace' is creatively typo'd in a few different places

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

---
I've added 'namesapce' to codespell: https://github.com/codespell-project/codespell/commit/cfe751aedb234e262d7e32c1d568939c2ccd4e36
I wasn't sure if it was worth splitting this into 3 patches given the
different areas; please advise.
---
 Documentation/driver-api/nvdimm/nvdimm.rst | 2 +-
 Documentation/filesystems/proc.rst         | 2 +-
 Documentation/networking/sysfs-tagging.rst | 2 +-
 drivers/infiniband/core/device.c           | 2 +-
 include/linux/nd.h                         | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/driver-api/nvdimm/nvdimm.rst b/Documentation/driver-api/nvdimm/nvdimm.rst
index be8587a558e1e..ca16b5acbf30d 100644
--- a/Documentation/driver-api/nvdimm/nvdimm.rst
+++ b/Documentation/driver-api/nvdimm/nvdimm.rst
@@ -82,7 +82,7 @@ LABEL:
   Metadata stored on a DIMM device that partitions and identifies
   (persistently names) capacity allocated to different PMEM namespaces. It
   also indicates whether an address abstraction like a BTT is applied to
-  the namepsace.  Note that traditional partition tables, GPT/MBR, are
+  the namespace.  Note that traditional partition tables, GPT/MBR, are
   layered on top of a PMEM namespace, or an address abstraction like BTT
   if present, but partition support is deprecated going forward.
 
diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
index 1bc91fb8c321a..335d028752d45 100644
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -2187,7 +2187,7 @@ are not related to tasks.
 Chapter 5: Filesystem behavior
 ==============================
 
-Originally, before the advent of pid namepsace, procfs was a global file
+Originally, before the advent of pid namespace, procfs was a global file
 system. It means that there was only one procfs instance in the system.
 
 When pid namespace was added, a separate procfs instance was mounted in
diff --git a/Documentation/networking/sysfs-tagging.rst b/Documentation/networking/sysfs-tagging.rst
index 83647e10c2078..65307130ab633 100644
--- a/Documentation/networking/sysfs-tagging.rst
+++ b/Documentation/networking/sysfs-tagging.rst
@@ -43,6 +43,6 @@ Users of this interface:
 
   - current_ns() which returns current's namespace
   - netlink_ns() which returns a socket's namespace
-  - initial_ns() which returns the initial namesapce
+  - initial_ns() which returns the initial namespace
 
 - call kobj_ns_exit() when an individual tag is no longer valid
diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
index d275db195f1a1..0af50a1f53418 100644
--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -132,7 +132,7 @@ MODULE_PARM_DESC(netns_mode,
  * rdma_dev_access_netns() - Return whether an rdma device can be accessed
  *			     from a specified net namespace or not.
  * @dev:	Pointer to rdma device which needs to be checked
- * @net:	Pointer to net namesapce for which access to be checked
+ * @net:	Pointer to net namespace for which access to be checked
  *
  * When the rdma device is in shared mode, it ignores the net namespace.
  * When the rdma device is exclusive to a net namespace, rdma device net
diff --git a/include/linux/nd.h b/include/linux/nd.h
index b9771ba1ef879..7095faf4a0c85 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -179,7 +179,7 @@ static inline int nvdimm_read_bytes(struct nd_namespace_common *ndns,
  * @buf: buffer to drain
  * @size: transfer length
  *
- * NVDIMM Namepaces disks do not implement sectors internally.  Depending on
+ * NVDIMM Namespaces disks do not implement sectors internally.  Depending on
  * the @ndns, the contents of @buf may be in cpu cache, platform buffers,
  * or on backing memory media upon return from this routine.  Flushing
  * to media is handled internal to the @ndns driver, if at all.
-- 
2.36.1

