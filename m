Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8B25825E4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 13:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbiG0LuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 07:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiG0Lt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 07:49:59 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069C04AD7B
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 04:49:57 -0700 (PDT)
Received: from zn.tnic (p200300ea970f4fe3329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:4fe3:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A1D601EC04DF;
        Wed, 27 Jul 2022 13:49:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1658922596;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=RHTabbw7z5/jxwKXRJ6imPs4FVoM0oO8L+t93x0tj+Y=;
        b=XZV+vLVds3hCMWtOPJ9a2WXGAtke+PXoz+U+y/VOFll+blQ26GyB+q1eqq2SN54rQzu0rW
        RpydtFfyPp13ZONVxUeER8sUPn5zFwO/2TGGKk87YtTlFFFtDLVggPnf6iEhQW8U9z4tU1
        f9ZasV/PcZ972n9Lftc2FMKF0a1oFdo=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] misc: Mark MICROCODE_MINOR unused
Date:   Wed, 27 Jul 2022 13:49:48 +0200
Message-Id: <20220727114948.30123-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This one is unused since

  181b6f40e9ea ("x86/microcode: Rip out the OLD_INTERFACE")

so comment it out.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220525161232.14924-1-bp@alien8.de
---
 include/linux/miscdevice.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/miscdevice.h b/include/linux/miscdevice.h
index 0676f18093f9..99291eff32dc 100644
--- a/include/linux/miscdevice.h
+++ b/include/linux/miscdevice.h
@@ -44,7 +44,7 @@
 #define AGPGART_MINOR		175
 #define TOSH_MINOR_DEV		181
 #define HWRNG_MINOR		183
-#define MICROCODE_MINOR		184
+/*#define MICROCODE_MINOR		184 unused */
 #define KEYPAD_MINOR		185
 #define IRNET_MINOR		187
 #define D7S_MINOR		193
-- 
2.35.1

