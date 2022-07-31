Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46A1A58605C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 20:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237626AbiGaS2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 14:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236933AbiGaS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 14:28:07 -0400
Received: from aer-iport-6.cisco.com (aer-iport-6.cisco.com [173.38.203.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86129B860
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 11:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=2937; q=dns/txt; s=iport;
  t=1659292085; x=1660501685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=D9m7kq1fReHlbow7GitzumxzaApHbmLWYIlSA1IxXgo=;
  b=iRjyEpLrhIZxQtKn8smHLEiysF2DQ2CBHgUU2IAdupQI2qGtxtK/acpA
   17sqnZuHOdIzoEHKtDWq70T1YrQTeUeU3PslVeTtVz5RUf3/OdYeJ2mH9
   G2JYu/SvBwUKQY+Bj2oDtHkAUVTDahln5KJwoMV8hdADRsrgU3TNIDr0d
   E=;
X-IPAS-Result: =?us-ascii?q?A0ACAADAyOZilxbLJq1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAYF7BgEBAQsBgyRWLBJFjG1fiA0DiyCRWYF8CwEBAQ83CwQBAYUGAoR1J?=
 =?us-ascii?q?jQJDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEHBBQBAQEBAQEBAQkbBgwFE?=
 =?us-ascii?q?DWFaA2GQwMDMgFGECAxITYZgn0BgmUDMgMQpl2CK4EBg08Bg1gNgkyBPQGGM?=
 =?us-ascii?q?oNGhSc9BoFJRIEVgTyCLIIggnGFbgSHHI0+gysDCQQHBUpEAwssDxYFCAkXE?=
 =?us-ascii?q?hAQAgQRGgsGAxY/CQIEDgNACA0DEQQDDxgJEggQBAYDMQwlCwMUDAEGAwYFA?=
 =?us-ascii?q?wEDGwMUAwUkBwMcDyMNDQQfHQMDBSUDAgIbBwICAwIGFQYCAjYYOQgECAQrI?=
 =?us-ascii?q?w8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFgIQCAIIJxcHEzMZAQVZEAkhHA4aE?=
 =?us-ascii?q?AUGEwMgbwUHPg8oMzU8Kx8bCoESKisVAwQEAwIGGAMDIgIQLjEDFQYpExItC?=
 =?us-ascii?q?Sp1CQIDIm0DAwQMHi4DCSEfBwlNlkSBbCB7EytRgQqWRQGYZJF4LGyDW4sij?=
 =?us-ascii?q?neFZRoxhUajIS2HB49IhHqIPoNfkROFKoFhghVNIxWDIwkKPhkPjjkeiE+FT?=
 =?us-ascii?q?EIxAgEBNwIGCwEBAwmPBgEB?=
IronPort-Data: A9a23:femIEqpZuK0G4wvIn3Eaq9BN3+heBmKlZRIvgKrLsJaIsI4StFCzt
 garIBnUOfqJYWb1Ld10Ydvl90hV757Um99iQAI5pHw1FXlG+ePIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7xdOCn9xGQ7InQLlbGILas1htZGEk1E0/NtTo5w7Rj2tEz2IDga++wk
 YqaT/P3aQfNNwFcagr424rbwP+4lK2v0N+wlgVWicFj5DcypVFMZH4sDf3Zw0/Df2VhNrXSq
 9AvY12O1jixEx8FUrtJm1tgG6EAaua60QOm0hK6V0U+6/RPjnRa70o1CBYTQWxokDa2s8x+9
 IxMq4PpdzcmB6GVtftIBnG0EwkmVUFH0LbKOz20ttaeihSAeHr3yPIoB0YzVWEa0r8oWicVp
 bpCcGtLNErra+GemNpXTsFsi8s/MsTnIKsUu2prynfSCvNOrZXrHfiSvoAGtNs2ruIJM87Yd
 uQrUDNiQhPbeUZjZQoWJY1ryY9EgVGmI2EH9zp5v5Ef/2/J0gV13KPFNNvTZ8zPS8JImEqRu
 mPB+SL+GB5yHNWc0T+t9nOqm/+KkyTmXo4bCLy/8LhtmlL77nAUEgYKWF39ofi9gFS/UNJ3M
 EEf5ywjse4580nDZsf8Wx21pHvCsQQVSvJfFuQ77EeGza+8yxqWAngsSj9HdcA8s8k3VXom2
 zehndTkLSRiqraVRGnb/bCRxRu7PSwUNmgETSsDTRYZ5Nqlpowv5jreU8xyVqiylNrrMT71y
 jGO6iM5gt07h8kR0bmh9F3IjiiEqpWPTwQwoA7QWwqN4Rl0a42lT4ip70XL4/FdKoqQUliGu
 j4Dgcf2xOQPC4yd0S+AWuMAGJm36Pufdj7Rm1hiG98m7TvFxpK4VYld+nR/PEBzLoMCcCOva
 07IsgQX75hWVJe3UUNpS6mOEMcV4bTvKY3kSO+NUOpBW5QoWRDSqUmCenWs92zqlUEtl4Q2N
 pGabdugAB4mNEh38Nalb7xCjuJzl0jS0UuWFM+rlU32uVaLTCfNEe9tDbeYUgwuAEq5TOTpH
 zR3apLiJ/Z3CbOWjszrHWk7dwpiEJTDLcqqw/G7j8baSuacJEkvCuXK3ZQqcJF/kqJem4/gp
 y/gCxUAlQqj3SSZcm1mj0yPjpuxBf6TSlpmbUQR0aqAgBDPnK72tv5ELstrFVXZ3LU7kqQco
 wY5lzWoW6QTFWuvF8U1Zpjmp4sqbwWwmQ+LJEKYjMsXIfZdq/jy0oa8JGPHrXBWZgLu7JtWi
 +Dwh2vzHMtYLyw/XZm+VR5a5w7o1ZTrsLkpBBWgzxg6UBiEzbWG3ASr1qFseJFQcEmSrtZYv
 i7PaSolSSD2i9dd2LH0aWqs9u9Fz8MW8pJmIlTm
IronPort-HdrOrdr: A9a23:LjOXaq1DqQVESe1QKBKuCgqjBLckLtp133Aq2lEZdPWaSKClfq
 eV7ZAmPHDP5gr5NEtLpTnEAtjifZq+z+8R3WBuB9aftWDd0QPCEGgh1/qB/9SKIULDH4BmuJ
 uIC5IfNDU1ZmIK6/oTJ2KDYrEd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,206,1654560000"; 
   d="scan'208";a="650376"
Received: from aer-iport-nat.cisco.com (HELO aer-core-1.cisco.com) ([173.38.203.22])
  by aer-iport-6.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 31 Jul 2022 18:26:58 +0000
Received: from hce-anki.rd.cisco.com ([10.47.79.243])
        by aer-core-1.cisco.com (8.15.2/8.15.2) with ESMTP id 26VIQpXv008219;
        Sun, 31 Jul 2022 18:26:57 GMT
From:   Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yury Norov <yury.norov@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Torsten Hilbrich <torsten.hilbrich@secunet.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [v4.9 PATCH 1/6] include/uapi/linux/swab.h: fix userspace breakage, use __BITS_PER_LONG for swap
Date:   Sun, 31 Jul 2022 20:26:31 +0200
Message-Id: <20220731182635.1910069-2-hegtvedt@cisco.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220731182635.1910069-1-hegtvedt@cisco.com>
References: <20220731182635.1910069-1-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.47.79.243, [10.47.79.243]
X-Outbound-Node: aer-core-1.cisco.com
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIMWL_WL_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        SPF_HELO_NONE,SPF_NONE,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Borntraeger <borntraeger@de.ibm.com>

QEMU has a funny new build error message when I use the upstream kernel
headers:

      CC      block/file-posix.o
    In file included from /home/cborntra/REPOS/qemu/include/qemu/timer.h:4,
                     from /home/cborntra/REPOS/qemu/include/qemu/timed-average.h:29,
                     from /home/cborntra/REPOS/qemu/include/block/accounting.h:28,
                     from /home/cborntra/REPOS/qemu/include/block/block_int.h:27,
                     from /home/cborntra/REPOS/qemu/block/file-posix.c:30:
    /usr/include/linux/swab.h: In function `__swab':
    /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:34: error: "sizeof" is not defined, evaluates to 0 [-Werror=undef]
       20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
          |                                  ^~~~~~
    /home/cborntra/REPOS/qemu/include/qemu/bitops.h:20:41: error: missing binary operator before token "("
       20 | #define BITS_PER_LONG           (sizeof (unsigned long) * BITS_PER_BYTE)
          |                                         ^
    cc1: all warnings being treated as errors
    make: *** [/home/cborntra/REPOS/qemu/rules.mak:69: block/file-posix.o] Error 1
    rm tests/qemu-iotests/socket_scm_helper.o

This was triggered by commit d5767057c9a ("uapi: rename ext2_swab() to
swab() and share globally in swab.h").  That patch is doing

  #include <asm/bitsperlong.h>

but it uses BITS_PER_LONG.

The kernel file asm/bitsperlong.h provide only __BITS_PER_LONG.

Let us use the __ variant in swap.h

Link: http://lkml.kernel.org/r/20200213142147.17604-1-borntraeger@de.ibm.com
Fixes: d5767057c9a ("uapi: rename ext2_swab() to swab() and share globally in swab.h")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Yury Norov <yury.norov@gmail.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Joe Perches <joe@perches.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: Torsten Hilbrich <torsten.hilbrich@secunet.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
(cherry picked from commit 467d12f5c7842896d2de3ced74e4147ee29e97c8)
---
 include/uapi/linux/swab.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/swab.h b/include/uapi/linux/swab.h
index 1f42d110987..51502eabdb0 100644
--- a/include/uapi/linux/swab.h
+++ b/include/uapi/linux/swab.h
@@ -134,9 +134,9 @@ static inline __attribute_const__ __u32 __fswahb32(__u32 val)
 
 static __always_inline unsigned long __swab(const unsigned long y)
 {
-#if BITS_PER_LONG == 64
+#if __BITS_PER_LONG == 64
 	return __swab64(y);
-#else /* BITS_PER_LONG == 32 */
+#else /* __BITS_PER_LONG == 32 */
 	return __swab32(y);
 #endif
 }
-- 
2.34.1

