Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4CE53227B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:36:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbiEXFfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiEXFfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:35:32 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874337CDF6
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:35:29 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L6jb313yQz9tBD;
        Tue, 24 May 2022 07:35:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AFyYAyKao1qj; Tue, 24 May 2022 07:35:27 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L6jb30BV4z9sYL;
        Tue, 24 May 2022 07:35:27 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EC59D8B76E;
        Tue, 24 May 2022 07:35:26 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id pNb_P2ucGYlv; Tue, 24 May 2022 07:35:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.153])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B756F8B764;
        Tue, 24 May 2022 07:35:26 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24O5ZEWK3809125
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 07:35:14 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24O5ZBwd3809124;
        Tue, 24 May 2022 07:35:11 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/xics: Include missing header
Date:   Tue, 24 May 2022 07:35:10 +0200
Message-Id: <f20a14be1a29fa0a9ebcfc5ebf05eb69c5120d10.1653370502.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653370509; l=732; s=20211009; h=from:subject:message-id; bh=PiCYc/EPDipcJJO82zaQ1XjfV93hoiIq4mUD9UVmA8I=; b=vmsbxDJmyRe3Qqog+mVApy2EbDDyJEKNRSrzzcrh2ySwZJWb4mEKvcWp3wv+qOlA+D+8R3rnyydl oqDQq226CiAFi/dH1PlYoQ/V70vp29jJP4qs+J/T5d2bOYynxLRS
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

Include of_adresses.h to get of_iomap() prototype.

Fixes: 86c38fec69a4 ("powerpc: Remove asm/prom.h from all files that don't need it")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/sysdev/xics/ics-native.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xics/ics-native.c b/arch/powerpc/sysdev/xics/ics-native.c
index e33b77da861e..112c8a1e8159 100644
--- a/arch/powerpc/sysdev/xics/ics-native.c
+++ b/arch/powerpc/sysdev/xics/ics-native.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/spinlock.h>
 #include <linux/msi.h>
 #include <linux/list.h>
-- 
2.35.3

