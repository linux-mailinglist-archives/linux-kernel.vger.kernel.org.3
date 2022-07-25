Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D45157FF64
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 14:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235348AbiGYM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 08:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235308AbiGYM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 08:56:32 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE86D112
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:56:31 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id o2so722473iof.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ZWMPfRksKaSGd6Z8V59bYl4UC7FJJqcyb7CYW6E6S1M=;
        b=V/pFhU0147Aqhv/1kM12N3SqA1zASpBq0TJ+o7uGIFcFaAmihGZp+wJLDEqYCUuW68
         +rJqi21cT286VEApqcaHJUDjNR1eQx9YGNjdIldojWxYUyyQv1vqy40y051sG2eijjzW
         CfC2zG61JpNMZ27EecAkZxJywy6Y7OV6Ts15w7qr8tJy4tXJQM3ghzvWwsLyAQArRDiq
         nfNfK+wCcTphDLRvutRonxovO3Fw6VTmdNJLWAw0Gv4/+YRb8kqSApiucV+osJH7gLPx
         5TXDS8CtC+1HDPZy27t8JSVFTheujd1wDJI174OU5Rpmb1BBm+hShv6JEQQ+qKgeJSV6
         0LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=ZWMPfRksKaSGd6Z8V59bYl4UC7FJJqcyb7CYW6E6S1M=;
        b=ORSMgg+/FNYD/Mp2bzqAMddTqZU15M2YaNCKw1epaTE/fwzAWL//HpAIRiE5vPZ8f/
         2PrHW5eBPKNPiRZcStUnhi2BYTsN1VCvn9DO3ZQJE19slPRkj2fgd4d65adw6QoNJLTC
         2/sN+jps/KD+2W2kRuD1xfW6nFOvR7E7I2NAGwdhcnNaSwaCccJsLwVyooNclzcnf9nM
         UY4mzA3pTEIrSyrAMpKHpJAvrk+u4Yu4+DpzFVSIup9WavJiFSDWYnwG139fLAgZD3/X
         2wvFO3xAns1N65uA4pKt4m7iOMsXNYz37AAxGenSXvqj86fArA851hiIEogGnxLaKcSc
         LZPg==
X-Gm-Message-State: AJIora/dFPt4DF+6T4UBn2087Bj4FUVy1lTJp8m3/6tc3efdjo0iXRDS
        xsuSfAywKh4iozQbh73rlP3bDy4y0gD8/bu7DnWmUxq8EvM=
X-Google-Smtp-Source: AGRyM1uFzJXUpiLw4T0FdMK4/VllUZwBgwuz2kY/7HSKAQnEK0xPGYrJjWDyLxn9EL7sp5+5h7CcDRxwDqF7fpGp36M=
X-Received: by 2002:a05:6638:14cd:b0:341:46ad:f3da with SMTP id
 l13-20020a05663814cd00b0034146adf3damr5114155jak.36.1658753790630; Mon, 25
 Jul 2022 05:56:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220725083904.56552-1-huangjie.albert@bytedance.com> <20220725083904.56552-3-huangjie.albert@bytedance.com>
In-Reply-To: <20220725083904.56552-3-huangjie.albert@bytedance.com>
From:   =?UTF-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Date:   Mon, 25 Jul 2022 20:56:19 +0800
Message-ID: <CABKxMyOoHzgAq40NYL3RNBJKt9md081cREo3QxX9dKv6EjcBWw@mail.gmail.com>
Subject: Fwd: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
To:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

---------- Forwarded message ---------
=E5=8F=91=E4=BB=B6=E4=BA=BA=EF=BC=9A Albert Huang <huangjie.albert@bytedanc=
e.com>
Date: 2022=E5=B9=B47=E6=9C=8825=E6=97=A5=E5=91=A8=E4=B8=80 16:40
Subject: [PATCH 2/4] kexec: add CONFING_KEXEC_PURGATORY_SKIP_SIG
To:
Cc: huangjie.albert <huangjie.albert@bytedance.com>, Thomas Gleixner
<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
<x86@kernel.org>, H. Peter Anvin <hpa@zytor.com>, Eric Biederman
<ebiederm@xmission.com>, Masahiro Yamada <masahiroy@kernel.org>,
Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers
<ndesaulniers@google.com>, Kirill A. Shutemov
<kirill.shutemov@linux.intel.com>, Brijesh Singh
<brijesh.singh@amd.com>, Michael Roth <michael.roth@amd.com>, Nathan
Chancellor <nathan@kernel.org>, Kuppuswamy Sathyanarayanan
<sathyanarayanan.kuppuswamy@linux.intel.com>, Ard Biesheuvel
<ardb@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Sean
Christopherson <seanjc@google.com>, Joerg Roedel <jroedel@suse.de>,
Mark Rutland <mark.rutland@arm.com>, Kees Cook
<keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
<kexec@lists.infradead.org>, <linux-kbuild@vger.kernel.org>


From: "huangjie.albert" <huangjie.albert@bytedance.com>

the verify_sha256_digest may cost 300+ ms in my test environment:
bzImage: 53M initramfs:28M

We can add a macro to control whether to enable this check. If we
can confirm that the data in this will not change, we can turn off
the check and get a faster startup.

Signed-off-by: huangjie.albert <huangjie.albert@bytedance.com>
---
 arch/x86/Kconfig               | 9 +++++++++
 arch/x86/purgatory/purgatory.c | 7 +++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52a7f91527fe..adbd3a2bd60f 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2052,6 +2052,15 @@ config KEXEC_BZIMAGE_VERIFY_SIG
        help
          Enable bzImage signature verification support.

+config KEXEC_PURGATORY_SKIP_SIG
+       bool "skip kexec purgatory signature verification"
+       depends on ARCH_HAS_KEXEC_PURGATORY
+       help
+         this options makes the kexec purgatory do  not signature verifica=
tion
+         which would get hundreds of milliseconds saved during kexec
boot. If we can
+         confirm that the data of each segment loaded by kexec will
not change we may
+         enable this option
+
 config CRASH_DUMP
        bool "kernel crash dumps"
        depends on X86_64 || (X86_32 && HIGHMEM)
diff --git a/arch/x86/purgatory/purgatory.c b/arch/x86/purgatory/purgatory.=
c
index 7558139920f8..b3f15774d86d 100644
--- a/arch/x86/purgatory/purgatory.c
+++ b/arch/x86/purgatory/purgatory.c
@@ -20,6 +20,12 @@ u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE]
__section(".kexec-purgatory");

 struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX]
__section(".kexec-purgatory");

+#ifdef CONFIG_KEXEC_PURGATORY_SKIP_SIG
+static int verify_sha256_digest(void)
+{
+       return 0;
+}
+#else
 static int verify_sha256_digest(void)
 {
        struct kexec_sha_region *ptr, *end;
@@ -39,6 +45,7 @@ static int verify_sha256_digest(void)

        return 0;
 }
+#endif

 void purgatory(void)
 {
--
2.31.1
