Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B482048BAB8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 23:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346309AbiAKWYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 17:24:14 -0500
Received: from mx1.uni-rostock.de ([139.30.22.71]:55465 "EHLO
        mx1.uni-rostock.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230480AbiAKWYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 17:24:12 -0500
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1641939850; bh=IAh7VU2Gkazp79uYG+fTcN5f34huyPCK3e0lnHU6aJo=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=ed25519-sha256; b=
 gXMd2WOCC7nLWEI7G/5WvnbXThp7Ut0DaDPRNTb/L5VtszMtuWP10W84nNZ33+j2DslA5frZm4mMmvUpgwY2Ag==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1641939850; bh=IAh7VU2Gkazp79uYG+fTcN5f34huyPCK3e0lnHU6aJo=; h=
 "Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id"; 
 a=rsa-sha256; b=
 hS11vuXSGo0+GMhNHR5k0mCklRNul+Mk9QUwTX2TcRkwCKFTw4i8Z0ofE6Q1+koLFxL/O/qSUFYQvS7c0/3wQ5xoEvAqCc6ifFNll0bxPFW9GkkxlSuWRIUEk9/j8vHFts7wiz0Neh8CHojExIJ9ALl0zjbjo5SvL70Etr+8Ow8=
Received: from 139.30.22.83 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Tue, 11 Jan 2022 22:24:09 GMT
Received: from meshdev.amd.e-technik.uni-rostock.de (139.30.202.104) by
 email3.uni-rostock.de (139.30.22.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Tue, 11 Jan 2022 23:24:09 +0100
From:   Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
CC:     Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: add generated capflags.c to gitignore
Date:   Tue, 11 Jan 2022 22:23:53 +0000
Message-ID: <20220111222353.1501350-1-benjamin.beichler@uni-rostock.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [139.30.202.104]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 email3.uni-rostock.de (139.30.22.83)
X-TM-SNTS-SMTP: 662BD3255006C5AFA92FAB0F0DA8B68E75A66599E4E034722F26D9699A81144B2002:8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
---
 arch/um/.gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/.gitignore b/arch/um/.gitignore
index 6323e5571887..8168b3bc08b8 100644
--- a/arch/um/.gitignore
+++ b/arch/um/.gitignore
@@ -2,3 +2,4 @@
 kernel/config.c
 kernel/config.tmp
 kernel/vmlinux.lds
+capflags.c
\ No newline at end of file
-- 
2.25.1
