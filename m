Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D221472B57
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 12:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbhLML2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 06:28:01 -0500
Received: from mail.skyhub.de ([5.9.137.197]:37368 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231465AbhLML2A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 06:28:00 -0500
Received: from zn.tnic (dslb-088-067-202-008.088.067.pools.vodafone-ip.de [88.67.202.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C3A2A1EC0419;
        Mon, 13 Dec 2021 12:27:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1639394878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KK9jkCRzL+Fk4HiZo/UFJba49+xowGLvOcrg6pd+JLk=;
        b=k4Y/M7FJMTs4TMaiQPki4iw8szw9P1mXCwUDUAtz19CcrsOXmmzF748RJap7VsInflRT2S
        K5gPi4b/G+Srh7lynQUmMWbt/FlGfnxJB7+SJuop5UMzG75SZ77rvDmYYw0LSLwOP+be4v
        qrKQLhoz8FnYhdcu8lIga/mIMpCodj0=
From:   Borislav Petkov <bp@alien8.de>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        John Dorminy <jdorminy@redhat.com>, anjaneya.chagam@intel.com,
        dan.j.williams@intel.com, Hugh Dickins <hughd@google.com>,
        "Patrick J. Volkerding" <volkerdi@gmail.com>
Subject: [PATCH 1/3] Revert "x86/boot: Mark prepare_command_line() __init"
Date:   Mon, 13 Dec 2021 12:27:55 +0100
Message-Id: <20211213112757.2612-2-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211213112757.2612-1-bp@alien8.de>
References: <YbcTgQdTpJAHAZw4@zn.tnic>
 <20211213112757.2612-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This reverts commit c0f2077baa4113f38f008b8e912b9fb3ff8d43df.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 6a190c7f4d71..c410be738ae7 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -742,7 +742,7 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
 	return 0;
 }
 
-static char * __init prepare_command_line(void)
+static char *prepare_command_line(void)
 {
 #ifdef CONFIG_CMDLINE_BOOL
 #ifdef CONFIG_CMDLINE_OVERRIDE
-- 
2.29.2

