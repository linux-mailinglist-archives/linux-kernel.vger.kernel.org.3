Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E201848F915
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 20:33:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiAOTdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 14:33:22 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:40881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbiAOTdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 14:33:16 -0500
Received: from quad ([82.142.13.186]) by mrelayeu.kundenserver.de (mreue011
 [212.227.15.167]) with ESMTPSA (Nemesis) id 1MCKWI-1mzR7j0k5q-009O8w; Sat, 15
 Jan 2022 20:32:49 +0100
From:   Laurent Vivier <laurent@vivier.eu>
To:     linux-kernel@vger.kernel.org
Cc:     John Stultz <john.stultz@linaro.org>, linux-rtc@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-m68k@lists.linux-m68k.org,
        Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH v8 1/4] m68k: add asm/config.h
Date:   Sat, 15 Jan 2022 20:32:42 +0100
Message-Id: <20220115193245.3777833-2-laurent@vivier.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220115193245.3777833-1-laurent@vivier.eu>
References: <20220115193245.3777833-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:G81D57gMbbTu2AaRQ48i03hLNWEqBkkcWg5jvfE6/ud5dmTOSDx
 4ur+w/q0ggHD6acKxEEabaADeKmai8jxSGTgd0tILQfk2IXWazAKE8ka0LUeIzowoAm1Sia
 ZejMkgJ/Z33rfkyXWs78ITjSKr0yOn8EonOgbD2jGScuRwRbDjpGJ9/B/mRtdDyR3ZoYGd3
 uPfkaxZ3LjVDRqEPj7Htg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:CjblmJBKjJY=:U26XyehvrmoI20Hd5F2vQZ
 Sr2r1t0Ii84WctuIBtSLy7KBVn7MLl+SqlFazlv0RqzV7tu8eBngZ652Q9mzFQog+w9WwDzo5
 OoA6Ey/1JxTuYLi2NAacEsmPkSom/G1lNl4zDD79MtitBe9Ax3JVuv7s8SSl/N9PfKk2jsJCf
 n9nJ9CcpTFWrw1zFJm1AfLRpOm7uXN108zeDN+pOc+IzTQZH95hcpQbbLu1we/3El++f27d8l
 /94IwPGGE6JIyV/qXYpbqQ9wTDGrQgNc5WshJUw5wUBn14k3lFrMrxcpUqsaieRXpsfIwcFYQ
 1ZW+BiPXZUScJrPbDGWCy3l4W1pWSEJfVoBjRER85Igh5uIApBmbssFpe3P12jdyqZ1IIYoWU
 uQkYHsePSAAcXclBIVjyYiXPLRAh73k9K6L9ENKRf0Z62agZeVRS4KeZsbGWL4VsjYZx6bLMt
 +S9vvuPwzvngEzwq63TAmwuJPJP/7xWC134jsneIO2c06m7lLJH6FjEfALeQgEfhUVyhCS+ak
 04R6Xz2PdyOeHS3Kv2eqAW+sTb0uKbd0O4vGABUTOElPH2x7FPGJ1GOVAcC+itDBQUSbFdCvZ
 1tD+pk5Ngc76ugn8SpMMhjn6/3UrILQBEHhSrhSutA3ntCg7mnzp9CFtQK3qJOjWfQnES/H+O
 49/t51fSnx765xvt4dWeBsPCdopP638ndeuOtkvSjzVRkyjVr0Ktk6nTcrzmQYGi7wTI=
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
index 4b51bfd38e5f..226dc3750397 100644
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
2.34.1

