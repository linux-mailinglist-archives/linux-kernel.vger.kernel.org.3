Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA32547019
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 01:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349325AbiFJXfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 19:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349246AbiFJXfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 19:35:20 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E38289A39
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:19 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id s22-20020a252d56000000b0065d1ef35f9dso571034ybe.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 16:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f3tp75L0usvR7/HEBHFbI6zWEipD9O6WfG/DwXt9RxU=;
        b=CpMvF4+7DFsMpHOaBEWCwgkIhWmhi/au92bxFtbtvPGRHAWy6+tq7ZwZu3TPPp6veI
         1/W4RvU4He66Cv/fRAUzOJbwPqP5t/6+n5lMIDjhd1533RUb8ih5FjbIPmGUMeaW8jIf
         xU7gRrLWGIVRD9KJKZ03AfCUIOIwFJXlqCXEEOrkTVeNd+8a/E4LGyBX3oKhbXxWT5B3
         csHoZBf1G2k0NQEQX8j1k2TI/Q9kBr2M2OXzy7ksKoBCKvBOmItjQBca8AAX48N2bG++
         S5ZYPEoMCY3S9ogw7q+CbyHd6CRL9UyVEsIUbUiKKnt2MraU/Shg+/CeAMN1ytZR8AGm
         UbFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f3tp75L0usvR7/HEBHFbI6zWEipD9O6WfG/DwXt9RxU=;
        b=ex01oohO88ES9qV0lX8VVKKx4ccpwwGYSyk9RLhO79z4tAeGxvMD6C0Fc7cN8hE07+
         xSt6z+dkl00/ypXslfPiSB/g9s76lfYc4vOoP3Kar4in90p+y1oHN9n57UG/ai2YG1rr
         zrMRH9Ap6dh9cE8x0QVsQ1rKHEzuXFxyac5Xpf34+fC8LGFEwaMVlqkFvOhD/L2kx97i
         FgtjMUAo1gGX0SFV1QBu8nQD9yzlchfJudZLAcWIkO6abeUt6kQpH6t539TWLEDA+1su
         IJfZBuqYOeoUz7MpaWtE7Eeem/7CvVHgAa4H5aiwctIvaNS0qNO3aWWx7VQ4b53lcbvD
         7iqg==
X-Gm-Message-State: AOAM530mACVxsjhQoeJH7IZ5aS5/js96VeFRIAaQpptkju+gdh/RAkBI
        Ke97JcEh30Xy4OVAv0b+Yp/c9xr9Gr9qAgaZwCScwUwKGGZv11gDEJadSS6wJJ5cwzJJQ9TG8o9
        yrIubLhkdjuvmrxiwejWR+vDs/mnhZP7YKO3Np+XtyjCQbfTANzC2Sz6ULGM8N79xp1W9fV+PKp
        Rku4fUlq5fjg==
X-Google-Smtp-Source: ABdhPJzufpaPghJca0m6g3l+aiVQwc4NlfpobT2IZhUHkW8s9pNjPsoYzNApitsOwyVnlrXfnO1/LO0AYH7qF3bsPIU=
X-Received: from samitolvanen1.mtv.corp.google.com ([2620:15c:201:2:f464:6db6:3d47:ed14])
 (user=samitolvanen job=sendgmr) by 2002:a0d:d9d7:0:b0:30c:2ba5:a151 with SMTP
 id b206-20020a0dd9d7000000b0030c2ba5a151mr51469497ywe.481.1654904118209; Fri,
 10 Jun 2022 16:35:18 -0700 (PDT)
Date:   Fri, 10 Jun 2022 16:34:54 -0700
In-Reply-To: <20220610233513.1798771-1-samitolvanen@google.com>
Message-Id: <20220610233513.1798771-2-samitolvanen@google.com>
Mime-Version: 1.0
References: <20220610233513.1798771-1-samitolvanen@google.com>
X-Developer-Key: i=samitolvanen@google.com; a=openpgp; fpr=35CCFB63B283D6D3AEB783944CB5F6848BBC56EE
X-Developer-Signature: v=1; a=openpgp-sha256; l=2980; h=from:subject;
 bh=D9CF0FusOcHoK9N60QLxjpk1E2xsqSvmemFeS75j5/8=; b=owEB7QES/pANAwAKAUy19oSLvFbuAcsmYgBio9UsuUCdAj7U2+8Hnh3U+7yazPmqBk99zh6vJyhb
 4/+cmdSJAbMEAAEKAB0WIQQ1zPtjsoPW0663g5RMtfaEi7xW7gUCYqPVLAAKCRBMtfaEi7xW7nGxC/
 oCtMcUeK4KGJm7EoJ262u7jGOh4PjE0kWyNah1Np47MSwS2EpgThwsYg/oyPlMAKsuEiEb3Gv5G2zR
 spW3AtGXGZ0sI3SfFcZQj6N6iI4JfLIFsFq5+v0uN+ORUESg8JiD9jqja4KXEn8ZRFw37BLsnDIgUz
 Y40ii2rqHPjLuAijuImAO/uj/jTxUjtOmV0K9nD7YjXMGHCJsdAAAziA2VaAcLxsRuOtBDpD2LUd/X
 IkSmg3Zyl1mjt7AYMiZMoGZ3opA2HjBB+YTLefQHBJEPPm4Lcadtg6gNYhJfG32QWywx9g6qeJu5yT
 APfULpxls5FYQmIDIJK+sD/Mnieq4ClX2KzvtsaVStZA5iA5nV9rN3uSbh5eChZot5evyMMb/np5z2
 np3oNKfQBlUMXkL7e1W3wyDjgIZ+Y+OSJdYSxXn50RhUc2x4vygGQNzJekBUrEL9rBri4RteAWfFZA
 3Avw3bBx1N8qZbR0uS8ging4PqmrIqG68CqQowCZTc6Lw=
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
Subject: [RFC PATCH v3 01/20] treewide: Filter out CC_FLAGS_CFI
From:   Sami Tolvanen <samitolvanen@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     Kees Cook <keescook@chromium.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-hardening@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for removing CC_FLAGS_CFI from CC_FLAGS_LTO, explicitly
filter out CC_FLAGS_CFI in all the makefiles where we currently filter
out CC_FLAGS_LTO.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/arm64/kernel/vdso/Makefile       | 3 ++-
 arch/x86/entry/vdso/Makefile          | 3 ++-
 drivers/firmware/efi/libstub/Makefile | 2 ++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index f6e25d7c346a..c7c123ed29cc 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -34,7 +34,8 @@ ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 # kernel with CONFIG_WERROR enabled.
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) \
 				$(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
+				$(CC_FLAGS_LTO) $(CC_FLAGS_CFI) \
+				-Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index c2a8b76ae0bc..0148df4f0425 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -91,7 +91,7 @@ ifneq ($(RETPOLINE_VDSO_CFLAGS),)
 endif
 endif
 
-$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
+$(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(CC_FLAGS_CFI) $(RANDSTRUCT_CFLAGS) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
@@ -152,6 +152,7 @@ KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(GCC_PLUGINS_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_LTO),$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out $(CC_FLAGS_CFI),$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 += -m32 -msoft-float -mregparm=0 -fpic
 KBUILD_CFLAGS_32 += -fno-stack-protector
 KBUILD_CFLAGS_32 += $(call cc-option, -foptimize-sibling-calls)
diff --git a/drivers/firmware/efi/libstub/Makefile b/drivers/firmware/efi/libstub/Makefile
index d0537573501e..234fb2910622 100644
--- a/drivers/firmware/efi/libstub/Makefile
+++ b/drivers/firmware/efi/libstub/Makefile
@@ -39,6 +39,8 @@ KBUILD_CFLAGS			:= $(cflags-y) -Os -DDISABLE_BRANCH_PROFILING \
 
 # remove SCS flags from all objects in this directory
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_SCS), $(KBUILD_CFLAGS))
+# disable CFI
+KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_CFI), $(KBUILD_CFLAGS))
 # disable LTO
 KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO), $(KBUILD_CFLAGS))
 
-- 
2.36.1.476.g0c4daa206d-goog

