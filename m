Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC17533A75
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 12:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbiEYKKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 06:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237502AbiEYKKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 06:10:24 -0400
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6FE9158B
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 03:10:22 -0700 (PDT)
Received: from localhost.localdomain (unknown [80.240.223.29])
        by mail.ispras.ru (Postfix) with ESMTPSA id 620F340755EC;
        Wed, 25 May 2022 10:10:20 +0000 (UTC)
From:   Evgeniy Baskov <baskov@ispras.ru>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Evgeniy Baskov <baskov@ispras.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 5/5] x86/boot: Remove no longer needed includes
Date:   Wed, 25 May 2022 13:10:13 +0300
Message-Id: <9b92fe8edc970ae9d438273fa7eafde49827a14d.1653471377.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <cover.1653471377.git.baskov@ispras.ru>
References: <cover.1653471377.git.baskov@ispras.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86/incldue/asm/shared/setup-cmdline.h header already provides
COMMAND_LINE_SIZE definition.

Signed-off-by: Evgeniy Baskov <baskov@ispras.ru>

diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index 44c350d627c7..7dc0300529fa 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -33,10 +33,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Used by PAGE_KERN* macros: */
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 4a3f223973f4..39e455c105a7 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -31,10 +31,6 @@
 #include <linux/ctype.h>
 #include <generated/utsrelease.h>
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
 extern unsigned long get_cmd_line_ptr(void);
 
 /* Simplified build-specific string for starting entropy. */
-- 
2.36.1

