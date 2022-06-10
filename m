Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07999546BA8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349722AbiFJR2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346784AbiFJR2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:28:08 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A43812A7882;
        Fri, 10 Jun 2022 10:28:07 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id r71so25437446pgr.0;
        Fri, 10 Jun 2022 10:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGqbehE+ZveInuu1+3qwVkNRRvQWvCG4DxrZ+H9HjeM=;
        b=Peuo1gMnEIX9fpDqjCX+Bu1Bhcpes+fjpnwEFgBejwqmc1JnCjtABamm3y3ULvgyLL
         HkqiToUK4OlbBTTkmzNhfM+YKbEHfiAyXiO+dpxqyU4VOwJoQPZNC3iezLsRGlw5wnLa
         Das340RRUWzo8SGhiGPHxjUqHvzjm+n4HP657lHc/nrAJkwfCaWMwZwtVgEJXSMF8Uk3
         y+AV3EqK6JRwmXehAHk6ypiOMdReUE/34wn9IH3SoX6DFkiyrTZtvovS5IEKX7vv3ZHG
         1eZwvrlj/T6f5J8e4Qn7JFPIoqOCrzFwYRyJnvdjFZtzytlIto67m7CyRoOSpPpm6dn4
         pfyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JGqbehE+ZveInuu1+3qwVkNRRvQWvCG4DxrZ+H9HjeM=;
        b=XKELGV2kTqAcl5Ma+Ib7IL5mum5JWDyxe/AaKBPMgb8R3PIRz0fUkZl+bwk3YNSCZc
         U6AkjCnlhtr0jtYhW9AiCy6nEcBZP+67RQv39yOpSrfGfL/tBnUIktfP8JJctIQ/1sPA
         /h8VGFXPMrlK9gFY7ACIHq+uFHZWl+KBhUZH36UoOr1jARB0RzqOVLpShW4pFa8kHGiU
         CPWbKsrJq08bsm6YbWJSoE/Suil4N5RaTIiUvQf7nfSq0gKMtfeebjOg3MsvkOlgShgc
         o/7zQz0KVQEt3WVJwJV8gWuugPwnkqnuvauIjGSS9v2Bvf/9duFw6G8bkTTQqKn1aL4G
         eS8A==
X-Gm-Message-State: AOAM532jU308DowntirDkkmtN0UeK5mwXeZRpZMpRIvQXmPoFG5tywLI
        Oso2cRHw+KASPcNw0uKpnos=
X-Google-Smtp-Source: ABdhPJz+Qr3QgcbMAG9/jGKndXDWYWzi78jgegL3uDMSyjR4IW7voDshOdHPvzlc5M4HrwWifp30vw==
X-Received: by 2002:a65:6e9b:0:b0:3c5:f761:2d94 with SMTP id bm27-20020a656e9b000000b003c5f7612d94mr40256869pgb.79.1654882087047;
        Fri, 10 Jun 2022 10:28:07 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:a25:b2b9:c7f3:678d:3dce:b25d])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902650f00b0016194c1df58sm17222665plk.105.2022.06.10.10.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 10:28:06 -0700 (PDT)
From:   Risheng1128 <hi4u29ck02@gmail.com>
To:     srinivas.pandruvada@linux.intel.com
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Risheng1128 <hi4u29ck02@gmail.com>
Subject: [PATCH] tools/power/x86/intel-speed-select: Remove duplicate macro
Date:   Sat, 11 Jun 2022 01:27:14 +0800
Message-Id: <20220610172714.27772-1-hi4u29ck02@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some macros such as `GENMASK` and `GENMASK_ULL` are redefined in
`include/linux/bits.h`. Simultaneously, the `GENMASK` in
`include/linux/bits.h` is more secure and prevents the following situation.
1. [net: stmmac: Fix misuses of GENMASK macro](https://reurl.cc/loMWvl)
2. [clocksource/drivers/npcm: Fix misuse of GENMASK macro](
https://reurl.cc/b2yr96)

Therefore, I think these macro could be removed.

Signed-off-by: Risheng1128 <hi4u29ck02@gmail.com>
---
 tools/power/x86/intel-speed-select/Makefile | 1 +
 tools/power/x86/intel-speed-select/isst.h   | 7 +------
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/tools/power/x86/intel-speed-select/Makefile b/tools/power/x86/intel-speed-select/Makefile
index 7221f2f55e8b..760d49d61955 100644
--- a/tools/power/x86/intel-speed-select/Makefile
+++ b/tools/power/x86/intel-speed-select/Makefile
@@ -14,6 +14,7 @@ endif
 # (this improves performance and avoids hard-to-debug behaviour);
 MAKEFLAGS += -r
 override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include -I/usr/include/libnl3
+override CFLAGS += -I../../../include
 override LDFLAGS += -lnl-genl-3 -lnl-3
 
 ALL_TARGETS := intel-speed-select
diff --git a/tools/power/x86/intel-speed-select/isst.h b/tools/power/x86/intel-speed-select/isst.h
index 0796d8c6a882..44de990d182e 100644
--- a/tools/power/x86/intel-speed-select/isst.h
+++ b/tools/power/x86/intel-speed-select/isst.h
@@ -27,12 +27,7 @@
 
 #include <stdarg.h>
 #include <sys/ioctl.h>
-
-#define BIT(x) (1 << (x))
-#define BIT_ULL(nr) (1ULL << (nr))
-#define GENMASK(h, l) (((~0UL) << (l)) & (~0UL >> (sizeof(long) * 8 - 1 - (h))))
-#define GENMASK_ULL(h, l)                                                      \
-	(((~0ULL) << (l)) & (~0ULL >> (sizeof(long long) * 8 - 1 - (h))))
+#include <linux/bits.h>
 
 #define CONFIG_TDP				0x7f
 #define CONFIG_TDP_GET_LEVELS_INFO		0x00
-- 
2.25.1

