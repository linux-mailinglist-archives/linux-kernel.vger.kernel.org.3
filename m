Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF2F4D4300
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 10:01:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbiCJJCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 04:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiCJJCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 04:02:21 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9371127D7A;
        Thu, 10 Mar 2022 01:01:19 -0800 (PST)
Received: from quad ([82.142.8.122]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MCbMz-1nJfxQ2NO7-009fKb; Thu, 10
 Mar 2022 10:00:51 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-rtc@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-m68k@lists.linux-m68k.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v15 1/5] m68k: add asm/config.h
Date:   Thu, 10 Mar 2022 10:00:44 +0100
Message-Id: <20220310090048.1933020-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220310090048.1933020-1-laurent@vivier.eu>
References: <20220310090048.1933020-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:NVAyxhIaFhSnhVUPtAGuUUWJ2S1EaOMARMVMR9+rpMk+aFNWC1C
 Zfx3J6BubT+RE1g8ev1BFj+l0t1kuPCi1FcEJ6R1hny+Qupn/jGR8pz/rrgWrTojEDc0KPS
 gwNz7Y/fI0tgonYBSM8Je5iP1f92ajiHg+o9UCbF78UZRUjeGWwVQuaBClRMfSZjTePpGs+
 2n7CPi/KxMXvExpVYCBCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHua8UYunr4=:S0iOWJbR6IhYNUuiz+bqn1
 wVQsJWiiY9CBUReZ2tOfcrLOqQcT8plLSs7vY9KtwZemHN6WgCBlLSihlQnw/P4YMEYkr27+A
 hVzRuDb7uK9t1M9ozwnJyW005wGTN+3x2Ewu0BPo7yxvSnAg+dtRsOaocUtMqgEL1Mi5gOSy0
 3K9p5W4LmPC7kmX7tNRiB1+rqU2lNmSho5+MDKeJdsd6XRel/1yN9SpYbx/NvE825rXBerlZ1
 TyN9+FwCkkMGoFjiiTRQABITbUfmsIcypeX0uMAKsDzBanejVn827+08waWqDNuPL+gD81kw7
 QRuc/CkwXn61c9W1qLFyKww7U2Gw+4MT6kRpcmaThzAR2aJm9tsxYgeTv9aYQqQi4I/5WSToE
 g1mQyfvKt5ID+2lTh8BlfO8BVaP591KnIz6+skFxoz8FwEVjNFSlXb7LpZMdyNz2kC+nbqal1
 WCJd1EAlbN8QZLdlzV+UkzA0PIKYk3fGfadhUZt8nbLsGlt9BE4DQuk4YDLCIqsy+8rqeceIo
 xRTAPxEkhL5NHS+VerkKUeK6zOUUkwnK6XysoLd0HJlABDmfWbS0zmB4cpybEoMuJRqr6ZICA
 FLS0n8NCRsrc99gycwyosZxMfSAmsclAOIXZVIZqKcGbsO01Ehpq75ulbTp/3uBjlrvh1JM4V
 iN8RTaqWKrc34WCMbyBcP7/Diu185H2hqxDgx4V4BCOkgFonCPv0YU5yWH/stIjDjO5s=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid 'warning: no previous prototype for' error, declare all
the parse_bootinfo and config functions prototypes into asm/config.h
and include it in arch/m68k/kernel/setup_mm.c and arch/m68k/*/config.c

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/amiga/config.c       |  1 +
 arch/m68k/apollo/config.c      |  1 +
 arch/m68k/atari/config.c       |  1 +
 arch/m68k/bvme6000/config.c    |  1 +
 arch/m68k/hp300/config.c       |  1 +
 arch/m68k/include/asm/config.h | 33 +++++++++++++++++++++++++++++++++
 arch/m68k/kernel/setup_mm.c    | 23 +----------------------
 arch/m68k/mac/config.c         |  1 +
 arch/m68k/mvme147/config.c     |  1 +
 arch/m68k/mvme16x/config.c     |  1 +
 arch/m68k/q40/config.c         |  1 +
 11 files changed, 43 insertions(+), 22 deletions(-)
 create mode 100644 arch/m68k/include/asm/config.h

diff --git a/arch/m68k/amiga/config.c b/arch/m68k/amiga/config.c
index be2dfab48fd4..3137b45750df 100644
--- a/arch/m68k/amiga/config.c
+++ b/arch/m68k/amiga/config.c
@@ -37,6 +37,7 @@
 #include <asm/irq.h>
 #include <asm/machdep.h>
 #include <asm/io.h>
+#include <asm/config.h>
 
 static unsigned long amiga_model;
 
diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 581a5f68d102..42a8b8e2b664 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -16,6 +16,7 @@
 #include <asm/apollohw.h>
 #include <asm/irq.h>
 #include <asm/machdep.h>
+#include <asm/config.h>
 
 u_long sio01_physaddr;
 u_long sio23_physaddr;
diff --git a/arch/m68k/atari/config.c b/arch/m68k/atari/config.c
index 261a0f57cc9a..38a7c0578105 100644
--- a/arch/m68k/atari/config.c
+++ b/arch/m68k/atari/config.c
@@ -46,6 +46,7 @@
 #include <asm/machdep.h>
 #include <asm/hwtest.h>
 #include <asm/io.h>
+#include <asm/config.h>
 
 u_long atari_mch_cookie;
 EXPORT_SYMBOL(atari_mch_cookie);
diff --git a/arch/m68k/bvme6000/config.c b/arch/m68k/bvme6000/config.c
index 0c6feafbbd11..9b060d466e03 100644
--- a/arch/m68k/bvme6000/config.c
+++ b/arch/m68k/bvme6000/config.c
@@ -36,6 +36,7 @@
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/bvme6000hw.h>
+#include <asm/config.h>
 
 static void bvme6000_get_model(char *model);
 extern void bvme6000_sched_init(void);
diff --git a/arch/m68k/hp300/config.c b/arch/m68k/hp300/config.c
index ce1eb3d3d55d..2c92843397c3 100644
--- a/arch/m68k/hp300/config.c
+++ b/arch/m68k/hp300/config.c
@@ -22,6 +22,7 @@
 #include <asm/blinken.h>
 #include <asm/io.h>                               /* readb() and writeb() */
 #include <asm/hp300hw.h>
+#include <asm/config.h>
 
 #include "time.h"
 
diff --git a/arch/m68k/include/asm/config.h b/arch/m68k/include/asm/config.h
new file mode 100644
index 000000000000..aae61070628b
--- /dev/null
+++ b/arch/m68k/include/asm/config.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * This file contains prototypes provided by each m68k machine
+ * to parse bootinfo data structures and to configure the machine
+ */
+
+#ifndef _M68K_CONFIG_H
+#define _M68K_CONFIG_H
+
+extern int amiga_parse_bootinfo(const struct bi_record *record);
+extern int atari_parse_bootinfo(const struct bi_record *record);
+extern int mac_parse_bootinfo(const struct bi_record *record);
+extern int q40_parse_bootinfo(const struct bi_record *record);
+extern int bvme6000_parse_bootinfo(const struct bi_record *record);
+extern int mvme16x_parse_bootinfo(const struct bi_record *record);
+extern int mvme147_parse_bootinfo(const struct bi_record *record);
+extern int hp300_parse_bootinfo(const struct bi_record *record);
+extern int apollo_parse_bootinfo(const struct bi_record *record);
+
+extern void config_amiga(void);
+extern void config_atari(void);
+extern void config_mac(void);
+extern void config_sun3(void);
+extern void config_apollo(void);
+extern void config_mvme147(void);
+extern void config_mvme16x(void);
+extern void config_bvme6000(void);
+extern void config_hp300(void);
+extern void config_q40(void);
+extern void config_sun3x(void);
+
+#endif /* _M68K_CONFIG_H */
diff --git a/arch/m68k/kernel/setup_mm.c b/arch/m68k/kernel/setup_mm.c
index 49e573b94326..8228275aae3e 100644
--- a/arch/m68k/kernel/setup_mm.c
+++ b/arch/m68k/kernel/setup_mm.c
@@ -47,6 +47,7 @@
 #endif
 #include <asm/macintosh.h>
 #include <asm/natfeat.h>
+#include <asm/config.h>
 
 #if !FPSTATESIZE || !NR_IRQS
 #warning No CPU/platform type selected, your kernel will not work!
@@ -113,28 +114,6 @@ EXPORT_SYMBOL(isa_type);
 EXPORT_SYMBOL(isa_sex);
 #endif
 
-extern int amiga_parse_bootinfo(const struct bi_record *);
-extern int atari_parse_bootinfo(const struct bi_record *);
-extern int mac_parse_bootinfo(const struct bi_record *);
-extern int q40_parse_bootinfo(const struct bi_record *);
-extern int bvme6000_parse_bootinfo(const struct bi_record *);
-extern int mvme16x_parse_bootinfo(const struct bi_record *);
-extern int mvme147_parse_bootinfo(const struct bi_record *);
-extern int hp300_parse_bootinfo(const struct bi_record *);
-extern int apollo_parse_bootinfo(const struct bi_record *);
-
-extern void config_amiga(void);
-extern void config_atari(void);
-extern void config_mac(void);
-extern void config_sun3(void);
-extern void config_apollo(void);
-extern void config_mvme147(void);
-extern void config_mvme16x(void);
-extern void config_bvme6000(void);
-extern void config_hp300(void);
-extern void config_q40(void);
-extern void config_sun3x(void);
-
 #define MASK_256K 0xfffc0000
 
 extern void paging_init(void);
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 5d16f9b47aa9..65d124ec80bb 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -47,6 +47,7 @@
 #include <asm/mac_via.h>
 #include <asm/mac_oss.h>
 #include <asm/mac_psc.h>
+#include <asm/config.h>
 
 /* Mac bootinfo struct */
 struct mac_booter_data mac_bi_data;
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index dfd6202fd403..b96ea7c76a19 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -34,6 +34,7 @@
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/mvme147hw.h>
+#include <asm/config.h>
 
 
 static void mvme147_get_model(char *model);
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index b4422c2dfbbf..88cbdc10925b 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -37,6 +37,7 @@
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/mvme16xhw.h>
+#include <asm/config.h>
 
 extern t_bdid mvme_bdid;
 
diff --git a/arch/m68k/q40/config.c b/arch/m68k/q40/config.c
index 5caf1e5be1c2..9237243077ce 100644
--- a/arch/m68k/q40/config.c
+++ b/arch/m68k/q40/config.c
@@ -34,6 +34,7 @@
 #include <asm/traps.h>
 #include <asm/machdep.h>
 #include <asm/q40_master.h>
+#include <asm/config.h>
 
 extern void q40_init_IRQ(void);
 static void q40_get_model(char *model);
-- 
2.35.1

