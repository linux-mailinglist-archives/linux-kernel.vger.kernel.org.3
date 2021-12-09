Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 453E946F7C9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 00:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234694AbhLJADV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 19:03:21 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:29418 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbhLJADU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:03:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1639094386; x=1670630386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTuTMZR7mHk5WuMQ4CKbLXlaRLZp274pvCDzMBGKakM=;
  b=mowRx144Tyzs6KnBw5uYp1dRLppJZEC8G5d+U9NjlUj4s3GKk1po6nTa
   L00ph+CiGHjB5Lzh/R5FvUebYLYl/kX3WeXdrItkC6eCG8PO0ggjRJAeX
   57lF9EUV1pRJZRH/kKg46e4smJei61Juc/UG8n8v24Nyoc8cA9D4IO9yS
   ApE9lfeMiD7gfItv0NZlkaxzHk9Zgx/sKmfarcSySCC+arGSRGTrwF3zN
   SsTKrNctdczk/sknFeNK9xkK5pqUwAxCcV5Sp7zIDVAO8D7lsFXoaSFbp
   xjDkPjidfZEVTiCfXO4e54eOU8Y0jNETeMzW5va1AjxvJHa2l3q+AZuSi
   Q==;
X-IronPort-AV: E=Sophos;i="5.88,194,1635177600"; 
   d="scan'208";a="187890309"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2021 07:59:45 +0800
IronPort-SDR: OtzsPoLZ4xufbaBHYURvgTw75KAMtlanU6bxsi/wX9vUPUwAzigpuC+yX9TTSsgomfYAFf23xw
 D4PzwKNl49R5VCkv0/Kafo4xkLJ1qLequKFK9QSdSw+wDtNwxQTQZYZ1Zuoxr5M83y7Xp9IeMW
 QGUUHVGA7HBrc6Ng6yIqNNBaj6zHtAYaJgnjF8uWtOsTIq9V4QJR3RJi9VWXpdwCM+FIwaB1HL
 yaG8yX6485Jriwb1Sp604TODWwwj445b7g4yFeKYL00+2NiWZvn7ZLcziAa+qrIv6O828OlW8/
 QqX64we9YozaXtknRbQH2Um3
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:32:48 -0800
IronPort-SDR: JYiamMB3tL85SUaztTIyXw5/LjkVAzrwVqifsoJ407rAc/pJpGd+oV6Etsu5Q7CZbEyFs2pv5l
 gsBUWeT+zJOoEShxalmqBEBPfqkyjkprlpJEbe4DxnZOnqv5149W2BY1W3VH+3rLKugeooryuC
 obX0NI1nUjBXPONt/XrJXME9+N95eI5GnV1pmhKSetqmCdVA2RCdim+2HpsVOVsZogPxp5T+S0
 9zJX6dTpO2JZTHcP4xdGG9KwQdLg158MnE0Wwrlnp/NUi8dnY8Bl2KOrfHWD9ZmmAmo4Iwsal3
 hMk=
WDCIronportException: Internal
Received: from usg-ed-osssrv.wdc.com ([10.3.10.180])
  by uls-op-cesaip02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 15:59:47 -0800
Received: from usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTP id 4J99xt2jjXz1Rwvd
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:59:46 -0800 (PST)
Authentication-Results: usg-ed-osssrv.wdc.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)"
        header.d=opensource.wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        opensource.wdc.com; h=content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:subject:to
        :from; s=dkim; t=1639094385; x=1641686386; bh=aTuTMZR7mHk5WuMQ4C
        KbLXlaRLZp274pvCDzMBGKakM=; b=naFMWJRgT8HcYrJKe1X6vFz3B6Ic6P3j1c
        H1CgQemTYBfygs9/5dGRz4ntX1UV/kRLhNdFF2w38pG42XethEJR0RjYJaHXj5Kl
        bZLb0rMsAD4kQXWO7j2QO4rgksihuv0HzAFeiGLt1TB5Mjs83lwtGKS1bqJyQ1tM
        iPV6DsgCdr6NcX7ibLhrir0IIw16pd9GE3eqUSqF2zHO2f44Kir0yx6H8/f7ODZh
        XXgYbKoC8xnEl1Lgv7TSarVD+sg/yga+I0MYyqTsQGef33PnbV4+eSAPgXkG/cMr
        ghhj1if7D6gxmGZ+RXCLgayjG19Iv0swvG1pJmqgc/cOwvUF20Aw==
X-Virus-Scanned: amavisd-new at usg-ed-osssrv.wdc.com
Received: from usg-ed-osssrv.wdc.com ([127.0.0.1])
        by usg-ed-osssrv.wdc.com (usg-ed-osssrv.wdc.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fsm96QcE-PWA for <linux-kernel@vger.kernel.org>;
        Thu,  9 Dec 2021 15:59:45 -0800 (PST)
Received: from localhost.localdomain (unknown [10.225.165.65])
        by usg-ed-osssrv.wdc.com (Postfix) with ESMTPSA id 4J99xj4ZGVz1RvTh;
        Thu,  9 Dec 2021 15:59:37 -0800 (PST)
From:   Alistair Francis <alistair.francis@opensource.wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     dave@stgolabs.net, dvhart@infradead.org, arnd@arndb.de,
        alistair23@gmail.com, namhyung@kernel.org, acme@kernel.org,
        jolsa@redhat.com, linux-perf-users@vger.kernel.org,
        alexander.shishkin@linux.intel.com, mark.rutland@arm.com,
        mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v5 4/6] selftests: futex: Add support for 32-bit systems with 64-bit time_t
Date:   Fri, 10 Dec 2021 09:58:55 +1000
Message-Id: <20211209235857.423773-4-alistair.francis@opensource.wdc.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
References: <20211209235857.423773-1-alistair.francis@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Francis <alistair.francis@wdc.com>

Using the new __kernel_futex_syscall*() functions let's add support for
32-bit systems with a 64-bit time_t. We can just direclty call the
publically exposed __kernel_futex_syscall_timeout() and
__kernel_futex_syscall_nr_requeue() functions to do this.

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 2 +-
 tools/testing/selftests/futex/include/futextest.h           | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c =
b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
index 1ee5518ee6b7..556bf3e74755 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -294,7 +294,7 @@ int unit_test(int broadcast, long lock, int third_par=
ty_owner, long timeout_ns)
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		info("ts.tv_sec  =3D %lld\n", (long long) ts.tv_sec);
 		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/te=
sting/selftests/futex/include/futextest.h
index c786fffecb8a..1686f94667b1 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -21,6 +21,7 @@
 #include <sys/syscall.h>
 #include <sys/types.h>
 #include <linux/futex.h>
+#include <linux/futex_syscall.h>
=20
 typedef volatile u_int32_t futex_t;
 #define FUTEX_INITIALIZER 0
@@ -69,14 +70,14 @@ static inline int
 futex_syscall(volatile u_int32_t *uaddr, int op, u_int32_t val, struct t=
imespec *timeout,
 	      volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, timeout, uaddr2, va=
l3);
+	return __kernel_futex_syscall_timeout(uaddr, op | opflags, val, timeout=
, uaddr2, val3);
 }
=20
 static inline int
 futex_syscall_nr_requeue(volatile u_int32_t *uaddr, int op, u_int32_t va=
l, int nr_requeue,
 			 volatile u_int32_t *uaddr2, int val3, int opflags)
 {
-	return syscall(SYS_futex, uaddr, op | opflags, val, nr_requeue, uaddr2,=
 val3);
+	return __kernel_futex_syscall_nr_requeue(uaddr, op | opflags, val, nr_r=
equeue, uaddr2, val3);
 }
=20
 /**
--=20
2.31.1

