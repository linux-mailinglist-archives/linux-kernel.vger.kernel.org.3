Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB91F5A2556
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343783AbiHZKCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230112AbiHZKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:21 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5F8BB02B
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:19 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id A4055310040
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508077;
        bh=USZZUSYzIyqzRyvWLPCu/6oIKQdgLE+JqwQsu/sMvjs=;
        h=From:To:Cc:Subject:Date;
        b=raDHnAPYJQydo2EltOyAKuPKfUN69qTLCYvso66NvjSlVLh71D2go47+/13N8Lfof
         Ug0MkorLK7Oq5xOL0DxY0giaQAv0Vsf/lc3JFw+6ucOpQpmUNrhrll56/Je5yPIMyZ
         QtY908LkJk6Ob9MOsBx8nfE5W0U/aUQnkPmtUpwU=
Received: from fx305 (localhost [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id 29C3B310036
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:17 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <2f82.630899ec.8e1fa.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx305.security-mail.net (Postfix) with ESMTPS id 8F4E8310030
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:16 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 7529D27E0396;
        Fri, 26 Aug 2022 12:01:16 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 5FC8427E0392;
        Fri, 26 Aug 2022 12:01:16 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 5FC8427E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508076;
        bh=AzBIuGBzTJu5r1iEjAhUWrWO0W9ziyd1az8DV0Q9ITk=;
        h=From:To:Date:Message-Id;
        b=DDtq/f1Yab3Q8n8aftcacUDfuPQCbGobYY6iAmwTER9+/9XoPtFENxymFssx2P6yk
         lyTcWwZgHJIlq6nAOlxKwj1PMtAORJK0EQIXKVsrDwBsHhD49fhyZUcVe2uTCqSzrV
         QWHCOL5NgBRLmfYk+TU27t6VzCn4WXMN6IeEkrbw=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IiGHug2e2vyZ; Fri, 26 Aug 2022 12:01:16 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 4860327E02FA;
        Fri, 26 Aug 2022 12:01:16 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>
Subject: [PATCH] x86: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:41 +0200
Message-Id: <20220826100052.22945-13-jmaselbas@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove redundant word `the`.

Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 arch/x86/tools/relocs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..3f8ab8efb674 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -764,7 +764,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
  *	to the start of the per_cpu area that does not change).
  *
  *	Relocations that apply to the per_cpu area need to have their
- *	offset adjusted by by the value of __per_cpu_load to make them
+ *	offset adjusted by the value of __per_cpu_load to make them
  *	point to the correct place in the loaded image (because the
  *	virtual address of .data..percpu is 0).
  *
-- 
2.17.1

