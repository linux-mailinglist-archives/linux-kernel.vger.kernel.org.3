Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742E058B185
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 23:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbiHEVyz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 17:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiHEVye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 17:54:34 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B8211811;
        Fri,  5 Aug 2022 14:54:30 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id l9so1989571ilq.1;
        Fri, 05 Aug 2022 14:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=J3hK7bUI023BnYR4sokXeCwLdQ8v4VG+y38uaGcbPRI=;
        b=o0oj1BOG1mKLXImOxNOgfmj9cP/l6Qyu/jfY/wwshKoUYop1cQrBtyQN0j4z2InP2d
         qwYHy1eRLM2dXWxLxj0bvAOGCy7vsApXbPpiKcoNZb5vwbgKQMZGblwSDJrpUuOxBSql
         6jdJfflHBPBB3yDfsU2MiNl+5M8QlCkCXp/jNapCkAe5h9X3A9taawcLI5+KBDU4Pgbw
         drO8zahX0S+OjowxQ/G3vX9mWjlqx4gRmRvdHwA5lw7p2/LaXX54fybIHXLrSs5Tv81F
         9R/DMjmA/gvF9mPSyQwZMrvOMpbu4503UBQUPPD+hnyFF+6VX0T7kUtw/tMFrXaUp1qh
         i0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=J3hK7bUI023BnYR4sokXeCwLdQ8v4VG+y38uaGcbPRI=;
        b=RlPNzzGDfftCojZ187vk8kdUcRDty4d2RlUeorl9s+WWn2TFjXyOlzn+q5me3SC2hR
         z5QsrkIQX2+EwvurdpDCkE6hVIV2cinqii0qMESoUxLkz7ZxZrqPzyhrI1cHeDw15CB3
         KzVKg3YyrE5oAzP6o/spy14K0en105OsUZg9siYrUSO403a8icV5vqYgGLrh8FfNwnvF
         RRwH7zH9Dh5GRoKJaUUowv/9klcGDz5SP+qmKRT9RuxVsYzL/pqbYSua3mXOnyfhyyIX
         qpBe88zjrfZhIdhK5WxDyla0O/ogFedxOYRtB4vDPTBsi7R7h3dPsc6Ee7ZuSyouQSZi
         Yxsg==
X-Gm-Message-State: ACgBeo3/dPynI37hyJQCPSUEZTmMct5zZ3c5IGTrsGXc9dcLDBNnHnzP
        CPQdbILXX97aglyoGa8JYSFNAsGJj2OENw==
X-Google-Smtp-Source: AA6agR6acEQ86Et7SlsRUNj2iJh1u88ZjLV2wi4n1jq1iPs7PuY06rR1utA1tbyb101yYRiXj1WsXQ==
X-Received: by 2002:a05:6e02:1b84:b0:2de:c27c:600 with SMTP id h4-20020a056e021b8400b002dec27c0600mr3990559ili.292.1659736469508;
        Fri, 05 Aug 2022 14:54:29 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id e12-20020a056602044c00b0067c09fd0b53sm1765532iov.21.2022.08.05.14.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Aug 2022 14:54:29 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     linux-kernel@vger.kernel.org, jbaron@akamai.com,
        gregkh@linuxfoundation.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     daniel.vetter@ffwll.ch, seanpaul@chromium.org, robdclark@gmail.com,
        Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 08/33] dyndbg: add test_dynamic_debug module
Date:   Fri,  5 Aug 2022 15:53:30 -0600
Message-Id: <20220805215355.3509287-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220805215355.3509287-1-jim.cromie@gmail.com>
References: <20220805215355.3509287-1-jim.cromie@gmail.com>
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

Provide a simple module to allow testing DYNAMIC_DEBUG behavior.  It
calls do_prints() from module-init, and with a sysfs-node.

  dmesg -C
  dmesg -w &
  modprobe test_dynamic_debug dyndbg=+p
  echo 1 > /sys/module/dynamic_debug/parameters/verbose

  cat /sys/module/test_dynamic_debug/parameters/do_prints
  echo module test_dynamic_debug +mftl > /proc/dynamic_debug/control
  echo junk > /sys/module/test_dynamic_debug/parameters/do_prints

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
Acked-by: Jason Baron <jbaron@akamai.com>
---
 MAINTAINERS              |  2 ++
 lib/Kconfig.debug        | 10 ++++++
 lib/Makefile             |  1 +
 lib/test_dynamic_debug.c | 70 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 83 insertions(+)
 create mode 100644 lib/test_dynamic_debug.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 64379c699903..a14fc4b6a10b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7093,6 +7093,8 @@ M:	Jason Baron <jbaron@akamai.com>
 S:	Maintained
 F:	include/linux/dynamic_debug.h
 F:	lib/dynamic_debug.c
+M:	Jim Cromie <jim.cromie@gmail.com>
+F:	lib/test_dynamic_debug.c
 
 DYNAMIC INTERRUPT MODERATION
 M:	Tal Gilboa <talgi@nvidia.com>
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 2e24db4bff19..ca5978e1d18a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2529,6 +2529,16 @@ config TEST_STATIC_KEYS
 
 	  If unsure, say N.
 
+config TEST_DYNAMIC_DEBUG
+	tristate "Test DYNAMIC_DEBUG"
+	depends on DYNAMIC_DEBUG
+	help
+	  This module registers a tracer callback to count enabled
+	  pr_debugs in a 'do_debugging' function, then alters their
+	  enablements, calls the function, and compares counts.
+
+	  If unsure, say N.
+
 config TEST_KMOD
 	tristate "kmod stress tester"
 	depends on m
diff --git a/lib/Makefile b/lib/Makefile
index f99bf61f8bbc..9c316df868de 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -82,6 +82,7 @@ obj-$(CONFIG_TEST_SORT) += test_sort.o
 obj-$(CONFIG_TEST_USER_COPY) += test_user_copy.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_keys.o
 obj-$(CONFIG_TEST_STATIC_KEYS) += test_static_key_base.o
+obj-$(CONFIG_TEST_DYNAMIC_DEBUG) += test_dynamic_debug.o
 obj-$(CONFIG_TEST_PRINTF) += test_printf.o
 obj-$(CONFIG_TEST_SCANF) += test_scanf.o
 obj-$(CONFIG_TEST_BITMAP) += test_bitmap.o
diff --git a/lib/test_dynamic_debug.c b/lib/test_dynamic_debug.c
new file mode 100644
index 000000000000..ba3882ca3e48
--- /dev/null
+++ b/lib/test_dynamic_debug.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Kernel module for testing dynamic_debug
+ *
+ * Authors:
+ *      Jim Cromie	<jim.cromie@gmail.com>
+ */
+
+#define pr_fmt(fmt) "test_dd: " fmt
+
+#include <linux/module.h>
+
+static void do_prints(void); /* device under test */
+
+/* run tests by reading or writing sysfs node */
+
+static int param_set_do_prints(const char *instr, const struct kernel_param *kp)
+{
+	do_prints();
+	return 0;
+}
+
+static int param_get_do_prints(char *buffer, const struct kernel_param *kp)
+{
+	do_prints();
+	return scnprintf(buffer, PAGE_SIZE, "did do_prints\n");
+}
+
+static const struct kernel_param_ops param_ops_do_prints = {
+	.set = param_set_do_prints,
+	.get = param_get_do_prints,
+};
+
+module_param_cb(do_prints, &param_ops_do_prints, NULL, 0600);
+
+static void do_alpha(void)
+{
+	pr_debug("do alpha\n");
+}
+static void do_beta(void)
+{
+	pr_debug("do beta\n");
+}
+
+static void do_prints(void)
+{
+	do_alpha();
+	do_beta();
+}
+
+static int __init test_dynamic_debug_init(void)
+{
+	pr_debug("init start\n");
+
+	do_prints();
+
+	pr_debug("init done\n");
+	return 0;
+}
+
+static void __exit test_dynamic_debug_exit(void)
+{
+	pr_debug("exiting\n");
+}
+
+module_init(test_dynamic_debug_init);
+module_exit(test_dynamic_debug_exit);
+
+MODULE_AUTHOR("Jim Cromie <jim.cromie@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.37.1

