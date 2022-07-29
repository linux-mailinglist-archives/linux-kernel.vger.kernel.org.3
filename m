Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5C658552A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 20:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiG2Swa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 14:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiG2Sw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 14:52:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B41D3342F;
        Fri, 29 Jul 2022 11:52:27 -0700 (PDT)
Date:   Fri, 29 Jul 2022 18:52:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659120745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AMlIlR/IA7h43fs/jnqbfHPC05a5PqX994y/JiTgek=;
        b=4SFuhuJv//l63IiuTbDait1NmdVZaxRPOwkXZPDgxsF/6BP8kuJCIvW9T1H7nlIaUU1HFR
        EIocm8DAPHpfnOxnG3ftP1rodIKJo45GTr8E4NiGSy5mLRvLR60q42AENM807WPOFUxXRF
        KNY+Zlou90QHSzOqCyOiUgQ2wKPbZlR8IWyeP6G8+hTVXMUju0CWW365gorjzf3uslUiLx
        BRL+JVxBg4z24W09vd/70nuOxhqVvBCAzDYYwear4neF3NzASAABx0rJG/n8/3DZVIbK9o
        udBo1ltdyYwoxl73xyjtl+JxbBj6O5DXWKzp9nwsjMwGrSXs3oRmbm3HyfQY3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659120745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6AMlIlR/IA7h43fs/jnqbfHPC05a5PqX994y/JiTgek=;
        b=iYquR8hfoqiu5AHFKYwZlYnj/2NeRodWvdK+eFsshVyV55LGNypdJejZVTUG6sgTs3Ypa0
        EdQxeLd2LLq3rmAA==
From:   "tip-bot2 for Eiichi Tsukata" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] docs/kernel-parameters: Update descriptions for
 "mitigations=" param with retbleed
Cc:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>,
        Borislav Petkov <bp@suse.de>, corbet@lwn.net, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220728043907.165688-1-eiichi.tsukata@nutanix.com>
References: <20220728043907.165688-1-eiichi.tsukata@nutanix.com>
MIME-Version: 1.0
Message-ID: <165912074412.15455.16713302879881825177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     ea304a8b89fd0d6cf94ee30cb139dc23d9f1a62f
Gitweb:        https://git.kernel.org/tip/ea304a8b89fd0d6cf94ee30cb139dc23d9f1a62f
Author:        Eiichi Tsukata <eiichi.tsukata@nutanix.com>
AuthorDate:    Thu, 28 Jul 2022 04:39:07 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 29 Jul 2022 20:47:07 +02:00

docs/kernel-parameters: Update descriptions for "mitigations=" param with retbleed

Updates descriptions for "mitigations=off" and "mitigations=auto,nosmt"
with the respective retbleed= settings.

Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: corbet@lwn.net
Link: https://lore.kernel.org/r/20220728043907.165688-1-eiichi.tsukata@nutanix.com
---
 Documentation/admin-guide/kernel-parameters.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c0fdb04..cc3ea8f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3176,6 +3176,7 @@
 					       no_entry_flush [PPC]
 					       no_uaccess_flush [PPC]
 					       mmio_stale_data=off [X86]
+					       retbleed=off [X86]
 
 				Exceptions:
 					       This does not have any effect on
@@ -3198,6 +3199,7 @@
 					       mds=full,nosmt [X86]
 					       tsx_async_abort=full,nosmt [X86]
 					       mmio_stale_data=full,nosmt [X86]
+					       retbleed=auto,nosmt [X86]
 
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
