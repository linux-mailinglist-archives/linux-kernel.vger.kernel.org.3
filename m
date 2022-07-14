Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6D0574B8C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbiGNLIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238260AbiGNLIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:08:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A80E89;
        Thu, 14 Jul 2022 04:08:34 -0700 (PDT)
Date:   Thu, 14 Jul 2022 11:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657796913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHbjtE2rRok+PDLTLfeXHRG66lZG1VHrYTg2Mc7KRmA=;
        b=l0o0mGVEo3aG1nm/azETnbcv912beRkDj6Mi28Wba/b0XkSKl6c3JKNyWYzfHBNDLDo7OD
        ejtrRdDUswOYy+cwkKN1F9bi1vMHnhk8OJ+AwC1OXjv9+P8P0Q/ygTv2TZwYDMXH5kdxS2
        y0Mn6dvB9vvh/Uf1TBfNZFakLezpNSX9PRbzqIs89M7wY4eBLlD8HjM1EDkTHYkF2CuW5Y
        d9/qQmOKHZFL1ChgSiPIDD74CzkyfvdHGqURn0pwxAPN5zDXWIQQZwBQgmWVkUQJTEkqx/
        arv1yr3eext0H0MEnh8tebFhbo7N2Q9aW4IF5iBMDwFKxfnsYzKZkrEiwru/GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657796913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pHbjtE2rRok+PDLTLfeXHRG66lZG1VHrYTg2Mc7KRmA=;
        b=K//a577Lepf+k3NWFVCTMIsf0SGNcjTH5FeqbLqF0R3VvETI8ZU5WhaMD+1diBwrUTYWVs
        GokR69ylrdBetNAw==
From:   "tip-bot2 for Jiapeng Chong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/bugs: Mark retbleed_strings static
Cc:     Abaci Robot <abaci@linux.alibaba.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220714072939.71162-1-jiapeng.chong@linux.alibaba.com>
References: <20220714072939.71162-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <165779691246.15455.16253032169822799893.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     33a8573bdfeec5b746aedeea880733a4c7993158
Gitweb:        https://git.kernel.org/tip/33a8573bdfeec5b746aedeea880733a4c7993158
Author:        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
AuthorDate:    Thu, 14 Jul 2022 15:29:39 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 14 Jul 2022 09:41:30 +02:00

x86/bugs: Mark retbleed_strings static

This symbol is not used outside of bugs.c, so mark it static.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220714072939.71162-1-jiapeng.chong@linux.alibaba.com
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0dd0471..3a0787a 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -793,7 +793,7 @@ enum retbleed_mitigation_cmd {
 	RETBLEED_CMD_IBPB,
 };
 
-const char * const retbleed_strings[] = {
+static const char * const retbleed_strings[] = {
 	[RETBLEED_MITIGATION_NONE]	= "Vulnerable",
 	[RETBLEED_MITIGATION_UNRET]	= "Mitigation: untrained return thunk",
 	[RETBLEED_MITIGATION_IBPB]	= "Mitigation: IBPB",
