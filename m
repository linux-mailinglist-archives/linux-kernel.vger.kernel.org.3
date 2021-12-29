Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E69B4811EE
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 12:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbhL2LQK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 06:16:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbhL2LQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 06:16:09 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7415EC061574;
        Wed, 29 Dec 2021 03:16:09 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id w20so34762061wra.9;
        Wed, 29 Dec 2021 03:16:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=fj9v03WIOgSR08ou05EzjrvJ+7CLv0+5hTLIsCE5StI=;
        b=BWHF+T5kmYxsosqMuWNfAIcqWn5q5R/8K2Jwjrc/Yp3t4UHzF6a3w+U2Dt1MLI3GCU
         m6rp1e0Kut/zSBrCIB70+lEyq7eF8k4L6d91kwMepDzM0xm1j+WJXkBBSCttbx/DBct5
         0EAtYbPT2BD/oNuIvhYy6CoGQKhQAeKEdWJRGiuBvYuva0WA2qXTrTXW7JqSyeC2bXnZ
         4tV/nemrM0FVzu8+2lQOBOkUWBuEZHcBbOkwVxjSVAX8MUEk3Jjh7/1fHuv84stwd5bn
         8YjH4QREhUEp2Y7+PKAhi40N5QT72jYooaRd1tPNsJSHJhVlS36KpTGKku8rKbYJoGOH
         v7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fj9v03WIOgSR08ou05EzjrvJ+7CLv0+5hTLIsCE5StI=;
        b=ezhazQKejoJvy21ZONSrGKtIFJVxP2/0xkAgTDmLLgID9fHyO2f0GUlk5vTMC1StdJ
         M/R99PNyxFCgdFfo2GHsMcQxvUcCo4NllVZDpo5m5/Uf06NoNT8V/OxhWqX+Zy8AlNxi
         hOF7mry2b5d8H47QUDqFW5o8Fb7qScpO9CDSrbs7f9LOcSZ+QVERCfeL+YwlcVzLtVjW
         7uFs20OfQcgDQXAaQZH3p5om8mp1T0IdFr0V/XvT0O6P4wfE2lIoKrDEspVQ/MWFybCe
         Gh7Fd75f8HzCcWpS91G0rja2OxDarJtYb+vJ0OmrmeOe+pSXP4VR2az/ywDiXepmA+Fa
         28DQ==
X-Gm-Message-State: AOAM533hxmBs3suvNDVQ2OEJKGbf7xafqBjcbk2ry+XLsjrtQs4CK5xH
        cNU3GnDNkvD32Mni8ud90CA=
X-Google-Smtp-Source: ABdhPJzAKIfJly8RaCeqPTASh3XEypHJ5AJyp12ftriPta+Aqy7n7C0kbLgcaN0/0wFjj49PsYOuZw==
X-Received: by 2002:a05:6000:148:: with SMTP id r8mr20373200wrx.333.1640776567534;
        Wed, 29 Dec 2021 03:16:07 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2626:5600:5f5:a4cc:1dcf:a62])
        by smtp.gmail.com with ESMTPSA id ay29sm23039644wmb.13.2021.12.29.03.16.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 03:16:06 -0800 (PST)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] x86/build: use the proper name CONFIG_FW_LOADER
Date:   Wed, 29 Dec 2021 12:15:53 +0100
Message-Id: <20211229111553.5846-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c8dcf655ec81 ("x86/build: Tuck away built-in firmware under
FW_LOADER") intends to add the expression regex only when FW_LOADER is
built-in, not a module or disabled.

The config is called CONFIG_FW_LOADER when it is built-in; and
CONFIG_FW_LOADER_MODULE when it is a module.

So, adjust the condition to the actual name of the config.

Fixes: c8dcf655ec81 ("x86/build: Tuck away built-in firmware under FW_LOADER")
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---

I am wondering if this regular expression needs to be made differently
depending on the build configuration at all.

Could this not just be added unconditionally anyway or is not needed at all?
It seems that is was broken since its initial inclusion and nobody ever noticed.


 arch/x86/tools/relocs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index c736cf2ac76b..e2c5b296120d 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -68,7 +68,7 @@ static const char * const sym_regex_kernel[S_NSYMTYPES] = {
 	"(__parainstructions|__alt_instructions)(_end)?|"
 	"(__iommu_table|__apicdrivers|__smp_locks)(_end)?|"
 	"__(start|end)_pci_.*|"
-#if CONFIG_FW_LOADER_BUILTIN
+#if CONFIG_FW_LOADER
 	"__(start|end)_builtin_fw|"
 #endif
 	"__(start|stop)___ksymtab(_gpl)?|"
-- 
2.17.1

