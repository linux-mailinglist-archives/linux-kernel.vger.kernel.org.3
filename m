Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0355A255A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 12:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343893AbiHZKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343658AbiHZKB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 06:01:26 -0400
Received: from smtpout30.security-mail.net (smtpout30.security-mail.net [85.31.212.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C11FCC7415
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 03:01:23 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id DBB1A310046
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 12:01:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1661508082;
        bh=uuLq46R+6k0TRm61YpWMjIX77MiXMaRGoSxbdhaEMLs=;
        h=From:To:Cc:Subject:Date;
        b=D66WPYiEpfQJDQShzi4IwNb7fIYo3AsgvXBRPqii+Ea/nXjlQbHxgqytcZ+LYoI8H
         gBTxFqPSuMCFndWgic1q2eNrWGV2aKzqYAwCK/NmYjwsrO6JAfxA5XZnYR2fLrmi9h
         OD8X6LRe4K08iBNjvkVR82ekAhjYSZwq8zWn9LXk=
Received: from fx305 (localhost [127.0.0.1])
        by fx305.security-mail.net (Postfix) with ESMTP id 2A708310036;
        Fri, 26 Aug 2022 12:01:21 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <356e.630899ef.5923e.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx305.security-mail.net (Postfix) with ESMTPS id D001F30FECB;
        Fri, 26 Aug 2022 12:01:19 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id D1C5A27E02FA;
        Fri, 26 Aug 2022 12:01:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id BB28227E0392;
        Fri, 26 Aug 2022 12:01:18 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu BB28227E0392
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1661508078;
        bh=6GbwSXyiNfD5wRZyPJr5zes9W2hMouyvXD4buMCrhyk=;
        h=From:To:Date:Message-Id;
        b=gxb2BpGJYhAxoikaF13S8kzxP3lAa+YMSvdLbnsnLOiZH2BCwcTw26Yyvy2vgiWFW
         jzNRTNQxo0n5E3Zr+0z8HVspCki2jmHe2hVIz1Obnsg9/lcUYWM+dqxG4QHlsf83wr
         Ffjzs/2kPGf13TkY4SjUPzvtHjQD3oAotBr797xQ=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id XhIo-A3vK7fY; Fri, 26 Aug 2022 12:01:18 +0200 (CEST)
Received: from tellis.lin.mbt.kalray.eu (unknown [192.168.36.206])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id AA58427E02FA;
        Fri, 26 Aug 2022 12:01:18 +0200 (CEST)
From:   Jules Maselbas <jmaselbas@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [PATCH] sparc: Fix repeated word in comments
Date:   Fri, 26 Aug 2022 12:00:42 +0200
Message-Id: <20220826100052.22945-14-jmaselbas@kalray.eu>
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

CC: "David S. Miller" <davem@davemloft.net>
CC: sparclinux@vger.kernel.org
Signed-off-by: Jules Maselbas <jmaselbas@kalray.eu>
---
 arch/sparc/kernel/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index cb1ef25116e9..07897cb09bbd 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -310,7 +310,7 @@ static struct pci_dev *of_create_pci_dev(struct pci_pbm_info *pbm,
 	/* We can't actually use the firmware value, we have
 	 * to read what is in the register right now.  One
 	 * reason is that in the case of IDE interfaces the
-	 * firmware can sample the value before the the IDE
+	 * firmware can sample the value before the IDE
 	 * interface is programmed into native mode.
 	 */
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class);
-- 
2.17.1

