Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F614E656E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351101AbiCXOkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351025AbiCXOkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:40:19 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A43586B
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:38:47 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KPSX62HjWz9sTc;
        Thu, 24 Mar 2022 15:38:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lOd6mjyXr49c; Thu, 24 Mar 2022 15:38:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KPSX558LRz9sTd;
        Thu, 24 Mar 2022 15:38:45 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 99F338B780;
        Thu, 24 Mar 2022 15:38:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id R1rS3cN8Kx5q; Thu, 24 Mar 2022 15:38:45 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.77])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6177B8B763;
        Thu, 24 Mar 2022 15:38:45 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 22OEcaV21812193
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 24 Mar 2022 15:38:36 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 22OEcZLo1812192;
        Thu, 24 Mar 2022 15:38:35 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] MAINTAINERS: Add arch/powerpc/kernel/trace to TRACING
Date:   Thu, 24 Mar 2022 15:38:28 +0100
Message-Id: <8e2f707e2efa1fc1d1ffd2f9f6758e8c4a82c83e.1648132613.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1648132705; l=702; s=20211009; h=from:subject:message-id; bh=VEiHejukkD6EZJAo8+kChtTLQI9cl6qtorMrMMgbRi0=; b=q6/wjhgxZixX3J8tO3a8TY6mz7jgRoalpOIdoOKiSnDOoAKScLU7RrrNca8BY4YVhvs3YugCV9s+ DVDflFk5CgCoqJSvyC87h115ECB/jS5eO0JrL4CKq4V7EOAiTAqO
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most architectures have ftrace related stuff in arch/*/kernel/ftrace.c
but powerpc has spread in multiple files located in
arch/powerpc/kernel/trace/

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index e127c2fb08a7..3b5943f34568 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19592,6 +19592,7 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
 F:	Documentation/trace/ftrace.rst
 F:	arch/*/*/*/ftrace.h
 F:	arch/*/kernel/ftrace.c
+F:	arch/powerpc/kernel/trace/
 F:	fs/tracefs/
 F:	include/*/ftrace.h
 F:	include/linux/trace*.h
-- 
2.35.1

