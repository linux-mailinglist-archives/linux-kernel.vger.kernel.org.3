Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E0946622B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345845AbhLBLVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:21:02 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:63118 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357256AbhLBLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:21:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443858; x=1669979858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=SlKhXOYedERl0RnaiJfzDiGiWKuwt2kGz1yDJoQfWVE=;
  b=Bj1J2ApCCDJHnZltW2MVAxNEyz02id4tMB8PTzsPMPvIYmwvlLbIL+v5
   uIeU2g2IFXhKgKl1FQARdsOroTyWoMBRDtJJ9zDhgPlTmKsJLmO2Cngie
   chNdFLpwC8d6aM6jBOgQxCrj+vfBSYXqXwkYNWrYbdRwR4oPjePCDJsjt
   3crfRnZmB6Db1AtkTwMZLTAtJT5ZjNgzHWm4SKmJcWDaCDRZfABf1aTZK
   H3I8/4nN2Y1+yEcHGcKf94VRfhSLQ9TmyODO/jnCQGpeOVwp2FuGDGtag
   eXdc3lg4IK8QllToWvFUeIT7NP7bFXNGx/b39bG3ghNvVt4cPAN5bpH1x
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="192058051"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:17:37 +0800
IronPort-SDR: F8zJKkkmL83AnR5no3u2eRzm4N9JdOLPOFKsV4Fy2eX7wg9xMNf/SIQ6uJqlFRfgTXjNjU25Fr
 K8jOb0kd0O4VkZqHrqRHoO7fHpdaGxbBREvB0lapbF4WjV1gwTRCGm8yBMiSILp0zaqXMgUtsN
 B1jCQn8IkYvzH48eCCHdRYITMpwQDHJCZPAw4aSdM7Aus7FNlvGUGOHfc1viPTbN8Dhc4yXcdi
 yY+4QaUqzh3CC7kDKMEmS2PN3cOSNhfsaslluvm2KstoDEf3UtChpPrFfEdifpj9+z7ynZB6Kg
 sKvm3Vgy6qSqZ3eqs03JlHke
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:52:21 -0800
IronPort-SDR: tpL/tcdmuRbsn8iESAA3tB3wgVjXvXRzWXRRsCXcMWLM0V6zMpCtqzClzxSmMYDVrDbCTIOKG4
 quNydoUMRwU/l29hlPSCE94nD1B1cTOoz9Kh2N3ekobtTzsQlWIMFKxyn7roovuue8wJlKio7V
 kFiaM8ApF9SP8mMotux3KpKR9ic17gZIZoXD4WYg9gftjeIo33iI0QodS3mBR5aVj4bLmAE7Wp
 K+QFf/wGdYjXCJUDMt9dVCDLndfqPX6AarLeMhH2gzd3cTLXDQ6mvKwkioharHiKH06qjZ9N1r
 JQA=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:17:38 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YMj5vC5z1Rx0s
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:17:37 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443856; x=1641035857; bh=SlKhXOYedERl0RnaiJ
        fzDiGiWKuwt2kGz1yDJoQfWVE=; b=CY2cRPUP0lBfwygSrvVMkV5uRYrqjG1r9a
        oEKtk5mzFJhcU2c3STfhLxOUhayyKEkAEKaoVFFqYTacPpVt8FRsOrVxE9Wb5WqQ
        IikU//u+0QuizaeuIQvuWNNk188Pdu7ZzlrviyggjDzVzcNIDTvB1pS2gNcdmD6l
        p6vTPI0HDPcNHam8JwlNQSOY7TODr57+ByylaGjEObfuW/ZvDOadTf6Rg3QNHnlH
        oW7FzdDbYBg9uEB4XrzjcOYZexMXYHrnU3Z4kCRizjxOOT9X5uP0R0XbFcp+OH7g
        ENqLZxbPx1oXanBhQFUosotdjaEj0s4BWvOjAGYBiKVbbAGJs//g==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id YQn7a_QaKDmS for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 03:17:36 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YMW2tykz1RtVG;
        Thu,  2 Dec 2021 03:17:26 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 3/6] uapi: futex: Add a futex syscall
Date:   Thu,  2 Dec 2021 21:16:56 +1000
Message-Id: <20211202111659.2077911-3-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds two futex syscall wrappers that are exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. This has mostly been because
the overloading of one of the arguments makes it impossible to provide a
single type safe function.

Until recently the single syscall has worked fine. With the introduction
of a 64-bit time_t futex call on 32-bit architectures, this has become
more complex. The logic of handling the two possible futex syscalls is
complex and often implemented incorrectly.

This patch adds two futex syscall functions that correctly handle the
time_t complexity for userspace.

This idea is based on previous discussions:
https://lore.kernel.org/lkml/CAK8P3a3x_EyCiPDpMK54y=3DRtm-Wb08ym2TNiuAZgX=
hYrThcWTw@mail.gmail.com/

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 include/uapi/linux/futex_syscall.h | 92 ++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 include/uapi/linux/futex_syscall.h

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
new file mode 100644
index 000000000000..bac621eb319c
--- /dev/null
+++ b/include/uapi/linux/futex_syscall.h
@@ -0,0 +1,92 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Futex syscall helper functions
+ *
+ * Copyright (C) 2021 Western Digital.  All Rights Reserved.
+ *
+ * Author: Alistair Francis <alistair.francis@wdc.com>
+ */
+#ifndef _UAPI_LINUX_FUTEX_SYSCALL_H
+#define _UAPI_LINUX_FUTEX_SYSCALL_H
+
+#include <unistd.h>
+#include <errno.h>
+#include <linux/futex.h>
+#include <linux/types.h>
+#include <linux/time_types.h>
+#include <stdint.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <time.h>
+
+/**
+ * __kernel_futex_syscall_timeout() - __NR_futex/__NR_futex_time64 sysca=
ll wrapper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @timeout:  an absolute struct timespec
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_timeout(volatile uint32_t *uaddr, int op, uint32_=
t val,
+		      struct timespec *timeout, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	if (sizeof(*timeout) !=3D sizeof(struct __kernel_old_timespec)) {
+		int ret =3D syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2=
, val3);
+
+		if (ret =3D=3D 0 || errno !=3D ENOSYS)
+			return ret;
+	}
+#endif
+
+#if defined(__NR_futex)
+	if (sizeof(*timeout) =3D=3D sizeof(struct __kernel_old_timespec))
+		return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
+
+	if (timeout && timeout->tv_sec =3D=3D (long)timeout->tv_sec) {
+		struct __kernel_old_timespec ts_old;
+
+		ts_old.tv_sec =3D (__kernel_long_t) timeout->tv_sec;
+		ts_old.tv_nsec =3D (__kernel_long_t) timeout->tv_nsec;
+
+		return syscall(__NR_futex, uaddr, op, val, &ts_old, uaddr2, val3);
+	} else if (!timeout) {
+		return syscall(__NR_futex, uaddr, op, val, NULL, uaddr2, val3);
+	}
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+/**
+ * __kernel_futex_syscall_nr_requeue() - __NR_futex/__NR_futex_time64 sy=
scall wrapper
+ * @uaddr:  address of first futex
+ * @op:   futex op code
+ * @val:  typically expected value of uaddr, but varies by op
+ * @nr_requeue:  an op specific meaning
+ * @uaddr2: address of second futex for some ops
+ * @val3: varies by op
+ */
+static inline int
+__kernel_futex_syscall_nr_requeue(volatile uint32_t *uaddr, int op, uint=
32_t val,
+			 uint32_t nr_requeue, volatile uint32_t *uaddr2, int val3)
+{
+#if defined(__NR_futex_time64)
+	int ret =3D  syscall(__NR_futex_time64, uaddr, op, val, nr_requeue, uad=
dr2, val3);
+
+	if (ret =3D=3D 0 || errno !=3D ENOSYS)
+		return ret;
+#endif
+
+#if defined(__NR_futex)
+	return syscall(__NR_futex, uaddr, op, val, nr_requeue, uaddr2, val3);
+#endif
+
+	errno =3D ENOSYS;
+	return -1;
+}
+
+#endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

