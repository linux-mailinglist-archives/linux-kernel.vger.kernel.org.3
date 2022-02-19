Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453034BC4B2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 03:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbiBSBxi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 20:53:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240726AbiBSBxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 20:53:36 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051FE1AF042
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:53:17 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id c14so18230363qvl.12
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 17:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIgEQ0FX8Uoh/Ijzl5Ipgw5nJJm58Az1+UC8LiuAMCA=;
        b=Eaa4Xd6fFypDsnxzHkO10y5/S6JYYkF98IpIPleEujybF9lX4TPvlCfO9WwsVuZIwH
         kVjU/l8eUrcOF6STLLDC+kAyHQ9bFcSSRQQzmylrhXZ0vb8JxjFdN/ri+1zLhodRqnNf
         huQm6liV33qTseVXdsElKgP1WZxQJcbpkRdD0IAVyPxbebS/+ZEkxJ/VSwfL+BCzFpvP
         MHwUxBHauTQv0yh/yzKc5AzMwYaPqVxot3cHT+3dBLkySMi3vpO5u927PhMlDuR7/uyu
         9Q92XmEkP1KfpqX6OblUPQAooS/WBbbADMy48R4U0riHz5UToKY47UD56CXCx6EG5x/U
         F69A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LIgEQ0FX8Uoh/Ijzl5Ipgw5nJJm58Az1+UC8LiuAMCA=;
        b=7+Y8nTltBeMijyU0M0gjXIGeScQHrIevaQE1A6aZOEBN0uIThaQi7lrpqCyNtC1lev
         /CePdiOKhtMzjKo+nMmoovDCYOYSPmhigNLPjo3NpuTOD+d3X57f4L1z1wE6zCXRWx+7
         3zNG7r3y96DITTBH4mXnMs8VBF3IO37uTccTqPiCvjTPWs32WU+PGhFTEOmX1BgvaaTo
         KaQo6xMXf/zzwT8pYZCw3QV7lMIuAUBm8YHGneNdXmBdY702TLqIdpoNykM6bNa1HBjL
         GZrdXgT46M732KOPLzLNGWOqXHUGJ8sBPkQHQMHnUG7vJmqsKqdZIfAS7ai04fq01y3B
         QGzw==
X-Gm-Message-State: AOAM530jE+46G3gcc9wqLqv19Z8IEQIiOTTS2FP9ST+c65iBpPMUIF7k
        9b26MlHh6P6inJSmwS8q79atzN8QeVTo5Q==
X-Google-Smtp-Source: ABdhPJztXcN9wy3h1VMOcOvbUu+XKVJfSTniF2KRS9fQXRkbyypnaGFrau38Bo5tSq/Wdm3s3pRmFQ==
X-Received: by 2002:ac8:5419:0:b0:2d7:2929:ca79 with SMTP id b25-20020ac85419000000b002d72929ca79mr9129208qtq.302.1645235596465;
        Fri, 18 Feb 2022 17:53:16 -0800 (PST)
Received: from bellerophon.hsd1.nh.comcast.net ([2601:187:8080:344:e980:8c1a:fcb8:8b2c])
        by smtp.gmail.com with ESMTPSA id az34sm23095832qkb.41.2022.02.18.17.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 17:53:16 -0800 (PST)
From:   Daroc Alden <setupminimal@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Daroc Alden <setupminimal@gmail.com>
Subject: [PATCH] Remove linux/version.h where versioncheck indicates
Date:   Fri, 18 Feb 2022 20:53:07 -0500
Message-Id: <20220219015307.142337-1-setupminimal@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

`make versioncheck` lists several files that include linux/version.h
unnecessarily. This patch removes them.

Signed-off-by: Daroc Alden <setupminimal@gmail.com>
---
 arch/csky/include/asm/io.h                                | 1 -
 arch/csky/kernel/process.c                                | 1 -
 arch/csky/mm/dma-mapping.c                                | 1 -
 drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h   | 1 -
 drivers/net/ethernet/qlogic/qede/qede.h                   | 1 -
 drivers/net/ethernet/qlogic/qede/qede_ethtool.c           | 1 -
 drivers/scsi/cxgbi/libcxgbi.h                             | 1 -
 drivers/scsi/mpi3mr/mpi3mr.h                              | 1 -
 drivers/scsi/qedi/qedi_dbg.h                              | 1 -
 drivers/staging/media/atomisp/include/linux/atomisp.h     | 1 -
 init/version.c                                            | 1 -
 sound/soc/codecs/cs42l42.c                                | 1 -
 tools/testing/selftests/bpf/progs/dev_cgroup.c            | 1 -
 tools/testing/selftests/bpf/progs/netcnt_prog.c           | 1 -
 tools/testing/selftests/bpf/progs/test_map_lock.c         | 1 -
 tools/testing/selftests/bpf/progs/test_send_signal_kern.c | 1 -
 tools/testing/selftests/bpf/progs/test_spin_lock.c        | 1 -
 tools/testing/selftests/bpf/progs/test_tcp_estats.c       | 1 -
 tools/testing/selftests/wireguard/qemu/init.c             | 1 -
 19 files changed, 19 deletions(-)

diff --git a/arch/csky/include/asm/io.h b/arch/csky/include/asm/io.h
index f82654053dc0..ed53f0b47388 100644
--- a/arch/csky/include/asm/io.h
+++ b/arch/csky/include/asm/io.h
@@ -5,7 +5,6 @@
 
 #include <linux/pgtable.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 /*
  * I/O memory access primitives. Reads are ordered relative to any
diff --git a/arch/csky/kernel/process.c b/arch/csky/kernel/process.c
index 3d0ca22cd0e2..5de04707aa07 100644
--- a/arch/csky/kernel/process.c
+++ b/arch/csky/kernel/process.c
@@ -2,7 +2,6 @@
 // Copyright (C) 2018 Hangzhou C-SKY Microsystems co.,ltd.
 
 #include <linux/module.h>
-#include <linux/version.h>
 #include <linux/sched.h>
 #include <linux/sched/task_stack.h>
 #include <linux/sched/debug.h>
diff --git a/arch/csky/mm/dma-mapping.c b/arch/csky/mm/dma-mapping.c
index c3a775a7e8f9..82447029feb4 100644
--- a/arch/csky/mm/dma-mapping.c
+++ b/arch/csky/mm/dma-mapping.c
@@ -9,7 +9,6 @@
 #include <linux/mm.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
-#include <linux/version.h>
 #include <asm/cache.h>
 
 static inline void cache_op(phys_addr_t paddr, size_t size,
diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h
index 5ab7ca448cf9..f8d97841f366 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-common.h
@@ -13,7 +13,6 @@
 #include <linux/dvb/dmx.h>
 #include <linux/dvb/frontend.h>
 #include <linux/gpio.h>
-#include <linux/version.h>
 
 #include <media/dmxdev.h>
 #include <media/dvb_demux.h>
diff --git a/drivers/net/ethernet/qlogic/qede/qede.h b/drivers/net/ethernet/qlogic/qede/qede.h
index f90dcfe9ee68..6ff1bd48d2aa 100644
--- a/drivers/net/ethernet/qlogic/qede/qede.h
+++ b/drivers/net/ethernet/qlogic/qede/qede.h
@@ -7,7 +7,6 @@
 #ifndef _QEDE_H_
 #define _QEDE_H_
 #include <linux/compiler.h>
-#include <linux/version.h>
 #include <linux/workqueue.h>
 #include <linux/netdevice.h>
 #include <linux/interrupt.h>
diff --git a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
index 8284c4c1528f..2de8725477a7 100644
--- a/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
+++ b/drivers/net/ethernet/qlogic/qede/qede_ethtool.c
@@ -4,7 +4,6 @@
  * Copyright (c) 2019-2020 Marvell International Ltd.
  */
 
-#include <linux/version.h>
 #include <linux/types.h>
 #include <linux/netdevice.h>
 #include <linux/etherdevice.h>
diff --git a/drivers/scsi/cxgbi/libcxgbi.h b/drivers/scsi/cxgbi/libcxgbi.h
index 3687b5c0cf90..d8fc7beafa20 100644
--- a/drivers/scsi/cxgbi/libcxgbi.h
+++ b/drivers/scsi/cxgbi/libcxgbi.h
@@ -24,7 +24,6 @@
 #include <linux/scatterlist.h>
 #include <linux/skbuff.h>
 #include <linux/vmalloc.h>
-#include <linux/version.h>
 #include <scsi/scsi_device.h>
 #include <scsi/libiscsi_tcp.h>
 
diff --git a/drivers/scsi/mpi3mr/mpi3mr.h b/drivers/scsi/mpi3mr/mpi3mr.h
index 2cc42432bd0c..4668a4fbc937 100644
--- a/drivers/scsi/mpi3mr/mpi3mr.h
+++ b/drivers/scsi/mpi3mr/mpi3mr.h
@@ -29,7 +29,6 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <linux/utsname.h>
-#include <linux/version.h>
 #include <linux/workqueue.h>
 #include <asm/unaligned.h>
 #include <scsi/scsi.h>
diff --git a/drivers/scsi/qedi/qedi_dbg.h b/drivers/scsi/qedi/qedi_dbg.h
index 37d084086fd4..fdda12ef13b0 100644
--- a/drivers/scsi/qedi/qedi_dbg.h
+++ b/drivers/scsi/qedi/qedi_dbg.h
@@ -11,7 +11,6 @@
 #include <linux/kernel.h>
 #include <linux/compiler.h>
 #include <linux/string.h>
-#include <linux/version.h>
 #include <linux/pci.h>
 #include <linux/delay.h>
 #include <scsi/scsi_transport.h>
diff --git a/drivers/staging/media/atomisp/include/linux/atomisp.h b/drivers/staging/media/atomisp/include/linux/atomisp.h
index 22c4103b0385..89524f507ce6 100644
--- a/drivers/staging/media/atomisp/include/linux/atomisp.h
+++ b/drivers/staging/media/atomisp/include/linux/atomisp.h
@@ -20,7 +20,6 @@
 #define _ATOM_ISP_H
 
 #include <linux/types.h>
-#include <linux/version.h>
 
 /* struct media_device_info.hw_revision */
 #define ATOMISP_HW_REVISION_MASK	0x0000ff00
diff --git a/init/version.c b/init/version.c
index 1a356f5493e8..8735730382e2 100644
--- a/init/version.c
+++ b/init/version.c
@@ -14,7 +14,6 @@
 #include <linux/uts.h>
 #include <linux/utsname.h>
 #include <generated/utsrelease.h>
-#include <linux/version.h>
 #include <linux/proc_ns.h>
 
 struct uts_namespace init_uts_ns = {
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a63fba4e6c9c..2cfd15060a13 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -11,7 +11,6 @@
 
 #include <linux/module.h>
 #include <linux/moduleparam.h>
-#include <linux/version.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
diff --git a/tools/testing/selftests/bpf/progs/dev_cgroup.c b/tools/testing/selftests/bpf/progs/dev_cgroup.c
index 79b54a4fa244..13da5dc9e71d 100644
--- a/tools/testing/selftests/bpf/progs/dev_cgroup.c
+++ b/tools/testing/selftests/bpf/progs/dev_cgroup.c
@@ -6,7 +6,6 @@
  */
 
 #include <linux/bpf.h>
-#include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
 SEC("cgroup/dev")
diff --git a/tools/testing/selftests/bpf/progs/netcnt_prog.c b/tools/testing/selftests/bpf/progs/netcnt_prog.c
index f718b2c212dc..099ce4e94e16 100644
--- a/tools/testing/selftests/bpf/progs/netcnt_prog.c
+++ b/tools/testing/selftests/bpf/progs/netcnt_prog.c
@@ -1,6 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/bpf.h>
-#include <linux/version.h>
 
 #include <bpf/bpf_helpers.h>
 #include "netcnt_common.h"
diff --git a/tools/testing/selftests/bpf/progs/test_map_lock.c b/tools/testing/selftests/bpf/progs/test_map_lock.c
index b5c07ae7b68f..c08adc847133 100644
--- a/tools/testing/selftests/bpf/progs/test_map_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_map_lock.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include <linux/bpf.h>
-#include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
 #define VAR_NUM 16
diff --git a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
index b4233d3efac2..e81e122d083a 100644
--- a/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_send_signal_kern.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include <linux/bpf.h>
-#include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
 __u32 sig = 0, pid = 0, status = 0, signal_thread = 0;
diff --git a/tools/testing/selftests/bpf/progs/test_spin_lock.c b/tools/testing/selftests/bpf/progs/test_spin_lock.c
index 0d31a3b3505f..2a9ffe0e0e56 100644
--- a/tools/testing/selftests/bpf/progs/test_spin_lock.c
+++ b/tools/testing/selftests/bpf/progs/test_spin_lock.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 // Copyright (c) 2019 Facebook
 #include <linux/bpf.h>
-#include <linux/version.h>
 #include <bpf/bpf_helpers.h>
 
 struct hmap_elem {
diff --git a/tools/testing/selftests/bpf/progs/test_tcp_estats.c b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
index 2c5c602c6011..45a3dd00cf3b 100644
--- a/tools/testing/selftests/bpf/progs/test_tcp_estats.c
+++ b/tools/testing/selftests/bpf/progs/test_tcp_estats.c
@@ -34,7 +34,6 @@
 #include <string.h>
 #include <linux/bpf.h>
 #include <linux/ipv6.h>
-#include <linux/version.h>
 #include <sys/socket.h>
 #include <bpf/bpf_helpers.h>
 
diff --git a/tools/testing/selftests/wireguard/qemu/init.c b/tools/testing/selftests/wireguard/qemu/init.c
index c9698120ac9d..4bdbce07794f 100644
--- a/tools/testing/selftests/wireguard/qemu/init.c
+++ b/tools/testing/selftests/wireguard/qemu/init.c
@@ -22,7 +22,6 @@
 #include <sys/sendfile.h>
 #include <sys/sysmacros.h>
 #include <linux/random.h>
-#include <linux/version.h>
 
 __attribute__((noreturn)) static void poweroff(void)
 {
-- 
2.33.1

