Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1F158F447
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 00:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbiHJWTg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 18:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHJWTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 18:19:34 -0400
Received: from esa3.hc3370-68.iphmx.com (esa3.hc3370-68.iphmx.com [216.71.145.155])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DB460503
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 15:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1660169973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eFrhBRp0ThMJsKuM0aei5bWPTKxEibJ4KGXezHXrJ7w=;
  b=U4u3Zosm7hMw2GTrHTI94h5+5JSxxwunWKbCUEw8r+eppy34Lk0F7m2X
   gAiv7FYHDGsWFnDoWxMz0v0WaGwiIzeDNTji3LJxCxI7Ce6pxlHGRQNec
   BQcJQs9MLOlwYVsUsWJbAdrUKDl8MLK3bn04BPcEfD3YNxU7i3VihC39b
   o=;
Authentication-Results: esa3.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
X-SBRS: 2.7
X-MesageID: 77826260
X-Ironport-Server: esa3.hc3370-68.iphmx.com
X-Remote-IP: 162.221.156.83
X-Policy: $RELAYED
IronPort-Data: A9a23:RIYB9660jpZnXr+vWT3+KwxRtPHHchMFZxGqfqrLsTDasY5as4F+v
 jFOUWqEOK7bYDPyf4ggPt62oEsEupbdmN5jT1duq383Hi5G8cbLO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yM6jclkf5KkYMbcICd9WAR4fykojBNnioYRj5VhxNO0GGthg
 /uryyHkEALjimUc3l48sfrZ8ks/5ayq41v0g3RlDRx1lA6G/5UqJMp3yZGZdxPQXoRSF+imc
 OfPpJnRErTxpkpF5nuNy94XQ2VSKlLgFVHmZkl+AsBOtiNqtC0qupvXAdJHAathZ5dlqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJH4IMrxCpPhbOmxT+
 6xGcRFTXi7foP3jldpXSsE07igiBMziPYdZsXB81zDJS/0hRPgvQY2Tu4Uehm1pwJkTQ7COP
 KL1ahI2BPjESzRJNk0aF9QVm+Cwi2OkWzZZtEiUtew85G27IAlZj+e9aoSPJITiqcN9hHzIg
 FyexEDALAgGN9XCwCaHwl7wmbqa9c/8cN1LT+DpnhJwu3Wfz3IeTh0fU0C2p9G9i0ijS5ReL
 VAZ/mwlqq1a3Fz7EPH+Uge+rXrCuQQTM/JVGvc/4RuAyYLV5RiYHWkOSjNdaN0gu9QyTDZs3
 ViM9/vjHRRmtLyYTyLb+rr8hTezPzUFaGwPfykJSSMb7NT55oI+lBTCSpBkCqHdpsH6HSHYx
 zGMsTQkgLMSnYgH2s2T+FHBjDWEvJXFTgcpoA7QWwqYAhhRPdD/IdbysB6CsKgGfN3xokS9U
 GYspPaR3bpQE722mTGDELtUPe+Z2aqiL2iJ6bJwJKXN5whB6lb6I94IuGAhfR43WioXUWS3O
 RGO4Gu98LcWZSL3NvEvPupdHuxwlcDd+cLZuuc4hzakSrx4b0e58S5nfiZ8NEi9wRF3wcnT1
 Xp2GPtA7Er26ow9lVJav89HjdcWKtkWnAs/v6zTwRW9yqa5b3WIU7oDO1bmRrlnsvvc/12Mo
 oYCbZHiJ/BjvArWPEHqHXM7dwhWfRDX+7ivwyCoSgJzClU/QzxwYxMg6bggZ5Zkj8xoqws8x
 VnkAxcw4Aeu2hX6xfCiMC8LhEXHAcki9hrW/EUEYT6V5pTUSd32tfhGJsBvLeNPGS4K5accc
 sTpsv6oWpxnIgkrMRxEBXUhhOSOrCiWuD8=
IronPort-HdrOrdr: A9a23:nCV+IKH8DCf1jGfMpLqE5MeALOsnbusQ8zAXP0AYc3Jom6uj5q
 eTdZUgpHvJYVkqOE3I9ertBEDiewK4yXcW2/hzAV7KZmCP0wHEEGgL1/qF/9SKIUzDH4Bmup
 uIC5IOauHNMQ==
X-IronPort-AV: E=Sophos;i="5.93,228,1654574400"; 
   d="scan'208";a="77826260"
From:   Andrew Cooper <andrew.cooper3@citrix.com>
To:     LKML <linux-kernel@vger.kernel.org>
CC:     Andrew Cooper <andrew.cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
Subject: [PATCH] x86/fpu/xstate: Fix XSTATE_WARN_ON() to emit relevant diagnostics
Date:   Wed, 10 Aug 2022 23:19:09 +0100
Message-ID: <20220810221909.12768-1-andrew.cooper3@citrix.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"XSAVE consistency problem" has been reported under Xen, but that's the extent
of my divination skills.

Modify XSTATE_WARN_ON() to force the caller to provide relevant diagnostic
information, and modify each caller suitably.

For check_xstate_against_struct(), this removes a double WARN() where one will
do perfectly fine.

Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
---
CC: Thomas Gleixner <tglx@linutronix.de>
CC: Ingo Molnar <mingo@redhat.com>
CC: Borislav Petkov <bp@alien8.de>
CC: Dave Hansen <dave.hansen@linux.intel.com>
CC: x86@kernel.org
CC: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>

RFC: CC stable?  This has been wonky debugging for 7 years.

Apparently "size 832 != kernel_size 0" so let the debugging continue...
---
 arch/x86/kernel/fpu/xstate.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..28b6478ea531 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -440,8 +440,8 @@ static void __init __xstate_dump_leaves(void)
 	}
 }
 
-#define XSTATE_WARN_ON(x) do {							\
-	if (WARN_ONCE(x, "XSAVE consistency problem, dumping leaves")) {	\
+#define XSTATE_WARN_ON(x, fmt, ...) do {					\
+	if (WARN_ONCE(x, "XSAVE consistency problem: " fmt, ##__VA_ARGS__)) {	\
 		__xstate_dump_leaves();						\
 	}									\
 } while (0)
@@ -554,8 +554,7 @@ static bool __init check_xstate_against_struct(int nr)
 	    (nr >= XFEATURE_MAX) ||
 	    (nr == XFEATURE_PT_UNIMPLEMENTED_SO_FAR) ||
 	    ((nr >= XFEATURE_RSRVD_COMP_11) && (nr <= XFEATURE_RSRVD_COMP_16))) {
-		WARN_ONCE(1, "no structure for xstate: %d\n", nr);
-		XSTATE_WARN_ON(1);
+		XSTATE_WARN_ON(1, "No structure for xstate: %d\n", nr);
 		return false;
 	}
 	return true;
@@ -598,12 +597,13 @@ static bool __init paranoid_xstate_size_valid(unsigned int kernel_size)
 		 * XSAVES.
 		 */
 		if (!xsaves && xfeature_is_supervisor(i)) {
-			XSTATE_WARN_ON(1);
+			XSTATE_WARN_ON(1, "Got supervisor feature %d, but XSAVES not advertised\n", i);
 			return false;
 		}
 	}
 	size = xstate_calculate_size(fpu_kernel_cfg.max_features, compacted);
-	XSTATE_WARN_ON(size != kernel_size);
+	XSTATE_WARN_ON(size != kernel_size,
+		       "size %u != kernel_size %u\n", size, kernel_size);
 	return size == kernel_size;
 }
 
-- 
2.11.0

