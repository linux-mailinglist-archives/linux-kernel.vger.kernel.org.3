Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4856246622D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357264AbhLBLV0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:21:26 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:65044 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357275AbhLBLVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:21:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1638443880; x=1669979880;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Qn9DS7hISPQiTe0ItoOGPSItTCkQ9fCzmpu8eWvFTQQ=;
  b=etP+8PcJpy4taOzm7CsMxIrQhkWLJe77VST6tSd9kTWGCET8pbJaqdc9
   nEAFUBVDqgDf9nSiLYutEneAeB+LEd0JZbuoD625wtl87KTjAm29R8rVx
   BUxGTRf3Kd1WRGhaBD1OAFpqRyzmScBSBnJJ0UxoPERgTw7Teo77WNvOJ
   kWJwuabNqb4jR1zmL/hzu8tWLejJffwTodw2QhG8ZjmgW0DIeCn8As1zQ
   nQQs6JXgKSxn95jGbC5//VIWSD0V0Xsin8KJjiPxso2WKJkMzsi9xAs5z
   t7DToBpEioPeWubvQFD5b8iCgg8Z20mTheRM//tCH8GIVJmHecJFom93+
   A==;
X-IronPort-AV: E=Sophos;i="5.87,281,1631548800"; 
   d="scan'208";a="299115602"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 02 Dec 2021 19:17:57 +0800
IronPort-SDR: /VWasmKFjDXcl23/wSPLz/j4dLBGKTOYexnnZy10T5qgg0FVQL2AUUNAfysoAYIYVVtPBWqHOW
 HyK2X3sXnYhHlHr8rNOx7jVd4pdPTAQ1lXo+zMrbmDw3yRBvTx10O4P1prP+XjcTFYBz/quaix
 OT59PVxt7Hbryl3fd7XsQnasGBLiZph4y9QZk9vANnq1ytALCY8fhrdvF5dDZfkSna48/sD6cG
 hteIiIN0oO8gITB5vg8IOuqWXL7F7BUIDV+pcV3tnaIm4EY4O4XMFKQihgl0VoM/xcpTfeE2IF
 6ZUGzuQP5uAQLI3/gRXvda0L
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 02:51:07 -0800
IronPort-SDR: mnpXDjrD5K27lye7wBHRP2XH3FC0vsMIGwrraZkZpFDqJuk/Pw9gg1pwr7wPEbQfg2nbN0VySr
 b3+VSM+E/Vv2VIfN7Whz4+VxMuJdGiFvhoyTmEDHxJUV3AfLQ2zJ/yp9J94m1S0a+ykUz6NRQj
 bte1ANGTRS1JgM/hcVCgXgMNsPh4ocCyRkyWPy3Hz12yxu5DPdPra62lzhQ3oYDDmSx2kC2GVo
 iXDQNELje+mgu4HbfgUDJsCmmxZ0q8YGRF4jnevYXb99YeZuVxc14w67UT5I+hw5Vvv71jLKXk
 sbs=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 03:17:57 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J4YN46V3Sz1TFlk
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:17:56 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1638443876; x=1641035877; bh=Qn9DS7hISPQiTe0Ito
        OGPSItTCkQ9fCzmpu8eWvFTQQ=; b=bzA8OoOXLo+BGprMmKNs9R0rF89h3Wxh0z
        DMRlt7TEXbomkdaxSiBBKrXlXgaV2YYfimBiiroVpZDG5Yn6Xk9RU2rEXdeYTvJs
        jgZQqhFJru1GSq6T0OonQh2FAMab/wyWtp3Op0sX/5NG9uTJcRtTQC5zwEpU9xdd
        cRGigCmRJVgOtPB5wcICs6/fEIxVzqbrpvbiNphC5Bkgf78HDq1W8yfWA++jKlmI
        oJAA55mb6gVIhwPgwFE8JxIiPzRiVLdCvaMLdDwoeQOt+y3rCH9A59bE7vuF6qF6
        hqsh7yI6ZjRzvxA6+bmbo43I3ogKNNcaRvHy1M3MiAxvWOwbikKg==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LcS8erosGNwG for <linux-kernel@vger.kernel.org>;
        Thu,  2 Dec 2021 03:17:56 -0800 (PST)
Received: from toolbox.alistair23.me (unknown [10.225.165.64])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J4YMv2VDsz1TF9q;
        Thu,  2 Dec 2021 03:17:46 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     jolsa@redhat.com, mingo@redhat.com, dave@stgolabs.net,
        linux-perf-users@vger.kernel.org, arnd@arndb.de,
        namhyung@kernel.org, alistair23@gmail.com, mark.rutland@arm.com,
        tglx@linutronix.de, acme@kernel.org,
        alexander.shishkin@linux.intel.com, peterz@infradead.org,
        dvhart@infradead.org, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v4 5/6] uapi: futex: Add a futex waitv syscall
Date:   Thu,  2 Dec 2021 21:16:58 +1000
Message-Id: <20211202111659.2077911-5-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
References: <20211202111659.2077911-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

This commit adds a futex waitv syscall wrapper that is exposed to
userspace.

Neither the kernel or glibc currently expose a futex wrapper, so
userspace is left performing raw syscalls. As the futex_waitv syscall
always expects a 64-bit time_t this can be tricky for 32-bit systems to
get correct.

In order to avoid userspace incorrectly passing the wrong timeouts let's
expose a public helper function that ensures the kernel is passed the
correct timeout struct.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/futex_syscall.h | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/include/uapi/linux/futex_syscall.h b/include/uapi/linux/fute=
x_syscall.h
index bac621eb319c..f637f05a3be0 100644
--- a/include/uapi/linux/futex_syscall.h
+++ b/include/uapi/linux/futex_syscall.h
@@ -89,4 +89,31 @@ __kernel_futex_syscall_nr_requeue(volatile uint32_t *u=
addr, int op, uint32_t val
 	return -1;
 }
=20
+/**
+ * __kernel_futex_syscall_waitv - Wait at multiple futexes, wake on any
+ * @waiters:    Array of waiters
+ * @nr_waiters: Length of waiters array
+ * @flags: Operation flags
+ * @timo:  Optional timeout for operation
+ */
+static inline int
+__kernel_futex_syscall_waitv(volatile struct futex_waitv *waiters, unsig=
ned long nr_waiters,
+			      unsigned long flags, struct timespec *timo, clockid_t clockid)
+{
+	/* futex_waitv expects a 64-bit time_t */
+	if (sizeof(*timo) =3D=3D sizeof(struct __kernel_timespec))
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, timo, clo=
ckid);
+
+	/* If the caller supplied a 32-bit time_t, convert it to 64-bit */
+	if (timo) {
+		struct __kernel_timespec ts_new;
+
+		ts_new.tv_sec =3D timo->tv_sec;
+		ts_new.tv_nsec =3D timo->tv_nsec;
+
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, &ts_new, =
clockid);
+	} else
+		return syscall(__NR_futex_waitv, waiters, nr_waiters, flags, NULL, clo=
ckid);
+}
+
 #endif /* _UAPI_LINUX_FUTEX_SYSCALL_H */
--=20
2.31.1

