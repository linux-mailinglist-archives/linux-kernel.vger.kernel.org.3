Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B927B52E9C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348070AbiETKRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245591AbiETKRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:17:32 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C190AEAB82
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 03:17:31 -0700 (PDT)
Received: from zn.tnic (p200300ea974657be329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:57be:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 487391EC0432;
        Fri, 20 May 2022 12:17:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1653041850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:in-reply-to:
         references; bh=C7itVOw0JRgGqgYGdx6qGoHlKVftuL1bUN3gncw9r3g=;
        b=WqetNwJul4LbabBJZfOkCwn2THA15tl1fBL4oUhKHt2ccE2iDOujyj8X3kGr4FoSe9qfYE
        yweEILh4LeSqqWrLq21CiN9HPQThQ58PDHDy82RLAAecTZXsIQZdCtlEONnbFMrcZ+KEzQ
        HAvUlG2KAGbGSFxfrsBsWyE31GupV6k=
From:   Borislav Petkov <bp@alien8.de>
To:     X86 ML <x86@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86: Remove empty files
Date:   Fri, 20 May 2022 12:17:23 +0200
Message-Id: <20220520101723.12006-1-bp@alien8.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Remove empty files which were supposed to get removed with the
respective commits removing the functionality in them:

$ find arch/x86/ -empty
arch/x86/lib/mmx_32.c
arch/x86/include/asm/fpu/internal.h
arch/x86/include/asm/mmx.h

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/include/asm/fpu/internal.h | 0
 arch/x86/include/asm/mmx.h          | 0
 arch/x86/lib/mmx_32.c               | 0
 3 files changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 arch/x86/include/asm/fpu/internal.h
 delete mode 100644 arch/x86/include/asm/mmx.h
 delete mode 100644 arch/x86/lib/mmx_32.c

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/arch/x86/include/asm/mmx.h b/arch/x86/include/asm/mmx.h
deleted file mode 100644
index e69de29bb2d1..000000000000
diff --git a/arch/x86/lib/mmx_32.c b/arch/x86/lib/mmx_32.c
deleted file mode 100644
index e69de29bb2d1..000000000000
-- 
2.35.1

