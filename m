Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7474EA599
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiC2DAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 23:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiC2C77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:59:59 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720FD26CD;
        Mon, 28 Mar 2022 19:58:14 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id 10so14193691qtz.11;
        Mon, 28 Mar 2022 19:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2doMNH7ifB03QblJV2sV07sq+r0A6Mdk0Jlzv/ArvaY=;
        b=AUeM4C6NBE4EMZ2lTC/kkzSz9gJLIrJRpFA4SgUEtFR6sht/NzF1n4U3bovPj4bOQD
         dIC7H2cgVqJj17X6kuoInrEyZvmkCrKYw7F7H79NWkwh1dfYG3/ZjGexG2viAFTCXaST
         z3pdNxSnlPBdVtNod0v+QYyAYzJZK4VAJKp0Iweyi1RP2AbkQgOO40/C1kJW+D63lIJE
         0kTvsA8iW7gKdpP/lj9l12Gy9jQ8wiCbtEsr55TEluNv6xP6mLJ0q+TRm8/JAf1PeSQX
         Vg0Fg626qCPmg8jE/SgETQiJ/VDwoJkgijLpIyzEVucRBPu0tqlELTDX76M3NZsoMhfl
         j/bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2doMNH7ifB03QblJV2sV07sq+r0A6Mdk0Jlzv/ArvaY=;
        b=fLms70K7DXI5vNDticyXa6JHxXfeQ+ocalMqSNy8tb5aE83Z33xhVMq1MzN1CoBGHR
         KIpYOQREzL2K1HXrMx1QK09PwseXztBSdtuJPgjwFrCV2+sMxl/r9weihfkGb4IJXrYJ
         KekioPKd6uUnS/qoohimlMCBA+JT4dfaYzIFaojrMwAlx1xjWNU4tl+JlkYmGeueIM3Y
         3Jscb95w+vnjgrEg2x4y4kmOwHySJUyBjsytA0I1ITKq/Rh2J9u4IhqhBTe+SWYndHqd
         7NZc3WQaMP/7q1xnGum0XDwjRScvpQizaDvz3cLIXGfWGy36/G/qtnnx64Wn4EIfj02j
         ekmw==
X-Gm-Message-State: AOAM5336m4JSbJRwHDxgYx+xeOcJgV+mpg3jWeir3xt4eMi81ZzN6en3
        +JEc8T6B0f+sAuU/RBn+Oc0=
X-Google-Smtp-Source: ABdhPJxUiSUsDbfSAFh0QJP/PMH9L27Pm2GNMWaSdSsolWBtkOUCqw9Ms+uD2jae4rk7kuLZuKiZ0Q==
X-Received: by 2002:ac8:7f81:0:b0:2e1:fd50:24f2 with SMTP id z1-20020ac87f81000000b002e1fd5024f2mr25162533qtj.353.1648522693637;
        Mon, 28 Mar 2022 19:58:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id p13-20020a05622a048d00b002e1ce0c627csm14763118qtx.58.2022.03.28.19.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 19:58:13 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     rth@twiddle.net, ink@jurassic.park.msu.ru, mattst88@gmail.com,
        firoz.khan@linaro.org, ematsumiya@suse.de
Cc:     rostedt@goodmis.org, mingo@redhat.com, yang.yang29@zte.com.cn,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] alpha: replace NR_SYSCALLS by NR_syscalls
Date:   Tue, 29 Mar 2022 02:57:38 +0000
Message-Id: <20220329025737.2375176-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
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

From: Yang Yang <yang.yang29@zte.com.cn>

Reference to other arch likes x86_64 or arm64 to do this replacement.
To solve compile error when using NR_syscalls in kernel[1].

[1] https://lore.kernel.org/all/202203270449.WBYQF9X3-lkp@intel.com/

Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
---
 arch/alpha/include/asm/unistd.h | 2 +-
 arch/alpha/kernel/entry.S       | 4 ++--
 kernel/trace/trace.h            | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/alpha/include/asm/unistd.h b/arch/alpha/include/asm/unistd.h
index 986f5da9b7d8..caabd92ea709 100644
--- a/arch/alpha/include/asm/unistd.h
+++ b/arch/alpha/include/asm/unistd.h
@@ -4,7 +4,7 @@
 
 #include <uapi/asm/unistd.h>
 
-#define NR_SYSCALLS	__NR_syscalls
+#define NR_syscalls	__NR_syscalls
 
 #define __ARCH_WANT_NEW_STAT
 #define __ARCH_WANT_OLD_READDIR
diff --git a/arch/alpha/kernel/entry.S b/arch/alpha/kernel/entry.S
index e227f3a29a43..966400b925a5 100644
--- a/arch/alpha/kernel/entry.S
+++ b/arch/alpha/kernel/entry.S
@@ -454,7 +454,7 @@ entSys:
 	SAVE_ALL
 	lda	$8, 0x3fff
 	bic	$sp, $8, $8
-	lda	$4, NR_SYSCALLS($31)
+	lda	$4, NR_syscalls($31)
 	stq	$16, SP_OFF+24($sp)
 	lda	$5, sys_call_table
 	lda	$27, sys_ni_syscall
@@ -585,7 +585,7 @@ strace:
 	ldq	$21, 88($sp)
 
 	/* get the system call pointer.. */
-	lda	$1, NR_SYSCALLS($31)
+	lda	$1, NR_syscalls($31)
 	lda	$2, sys_call_table
 	lda	$27, sys_ni_syscall
 	cmpult	$0, $1, $1
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 07d990270e2a..7ad8324db192 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -25,7 +25,7 @@
 #include "pid_list.h"
 
 #ifdef CONFIG_FTRACE_SYSCALLS
-#include <asm/unistd.h>		/* For NR_SYSCALLS	     */
+#include <asm/unistd.h>		/* For NR_syscalls	     */
 #include <asm/syscall.h>	/* some archs define it here */
 #endif
 
-- 
2.25.1

