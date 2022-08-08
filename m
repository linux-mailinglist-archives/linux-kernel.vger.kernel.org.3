Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065C858CCC1
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 19:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243486AbiHHRhj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 13:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235852AbiHHRhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 13:37:36 -0400
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592FE13E91;
        Mon,  8 Aug 2022 10:37:35 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 278HbJRH004735;
        Tue, 9 Aug 2022 02:37:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 278HbJRH004735
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659980240;
        bh=BuY1TMSXWdED7zukVvB5l/59DaxxbcqQ2IOZciXPWIY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P7aSEtMvrm0rPN77TPEfS9Fwxu6H4SqYPBOM+Yqn9iXKeuLQpG9dbACaBGz/W04jX
         17vcTbboznbJeo8gfBomBvUtXO8dO0hZQ6rSz8+PFYnpuR3LZgXc0Qtw4OgCsYYC80
         n76wofFLTf89hE7+t0ixRY2UehFA29CtNWdhHvd2AAyYxloFIpYY2WtqtyBEX/GInf
         IR2eo6FRZ7Ww0mu9Cs1D3Gu7dJK/klwaPyZmgKX1Sbl4N0AcnCISvmZPZbjCDQlsgQ
         A91G7WzyIyo7vVkBxQNwvXBl65B8jbVQ8NkTT2zBiXoY450RrNOk2+5YY7eOOv5NEG
         fDEaL/i65BtDA==
X-Nifty-SrcIP: [209.85.221.45]
Received: by mail-wr1-f45.google.com with SMTP id l4so11641169wrm.13;
        Mon, 08 Aug 2022 10:37:20 -0700 (PDT)
X-Gm-Message-State: ACgBeo3Mh86Q7RDjk1RcsF4t1XMDbnUZay6vpFqqdRI8Qsj/7kmkuWvm
        35WjqSCdTKRxT2x5KILcj06OjyOAaQmhOCwWgLg=
X-Google-Smtp-Source: AA6agR5TLez3BClNRdpePrpc8q6eKNE0zlD502ux+r07wV1rDelRX/GyGxXX4tLJF8qojzyjNwVqNb0ZK6QfgKdcSTM=
X-Received: by 2002:a05:6000:1f83:b0:223:60ee:6c08 with SMTP id
 bw3-20020a0560001f8300b0022360ee6c08mr1572173wrb.682.1659980238492; Mon, 08
 Aug 2022 10:37:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220513113930.10488-1-masahiroy@kernel.org> <CAK7LNAQvneCi11myLpkikuXh=i5PLtTaLe0nGpDZXgv_Q1L0Ow@mail.gmail.com>
 <2c496d24174e63b27ec047f383df6700@matoro.tk> <CAK7LNASWKhj0tZK6jA1PsYje+idTjzdbYa9avyGeakVScj843A@mail.gmail.com>
 <38a9853e59db8946999316ce3a6b4621@matoro.tk>
In-Reply-To: <38a9853e59db8946999316ce3a6b4621@matoro.tk>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 9 Aug 2022 02:36:41 +0900
X-Gmail-Original-Message-ID: <CAK7LNATa1fdwQsuC3LOkzhr1SaR6ipJqe1b0fAC1pk3LX9wDhA@mail.gmail.com>
Message-ID: <CAK7LNATa1fdwQsuC3LOkzhr1SaR6ipJqe1b0fAC1pk3LX9wDhA@mail.gmail.com>
Subject: Re: [PATCH v6 00/10] kbuild: yet another series of cleanups (modpost,
 LTO, MODULE_REL_CRCS, export.h)
To:     matoro <matoro_mailinglist_kernel@matoro.tk>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 8, 2022 at 10:27 PM matoro
<matoro_mailinglist_kernel@matoro.tk> wrote:
>
> I have real hardware for all these arches in my collection.  I use it
> for testing the latest kernel and toolchains on as many of the
> less-popular arches as possible, exactly to find issues like this one :)
>
> Specifically we support all of these in Gentoo.  To double-check this
> wasn't a config issue, I asked another user who also runs sparc to try
> building 5.19 with his config (not copying mine), and he observed the
> same problem.  You can reach us in #gentoo-sparc on Libera.
>
> As for testing, I make all this hardware available on an as-needed
> basis.  So if you can't or don't want to fiddle with qemu, just let me
> know (email or IRC, same username on Libera), and I will get you direct
> access to my hardware.  Thanks!!


I found the root cause.

When I build the sparc kernel, I see a warning

WARNING: modpost: EXPORT symbol "_mcount" [vmlinux] version generation
failed, symbol will not be versioned.


Then, modpost missed to write out the entry.

With the following patch, you will be able to load the module.

I will send a patch with a proper commit log tomorrow. I need some sleep now.



diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 29474cee10b1..337bd36a890a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -2206,13 +2206,11 @@ static void add_exported_symbols(struct buffer
*buf, struct module *mod)
        /* record CRCs for exported symbols */
        buf_printf(buf, "\n");
        list_for_each_entry(sym, &mod->exported_symbols, list) {
-               if (!sym->crc_valid) {
+               if (!sym->crc_valid)
                        warn("EXPORT symbol \"%s\" [%s%s] version
generation failed, symbol will not be versioned.\n"
                             "Is \"%s\" prototyped in
<asm/asm-prototypes.h>?\n",
                             sym->name, mod->name, mod->is_vmlinux ? "" : ".ko",
                             sym->name);
-                       continue;
-               }

                buf_printf(buf, "SYMBOL_CRC(%s, 0x%08x, \"%s\");\n",
                           sym->name, sym->crc, sym->is_gpl_only ? "_gpl" : "");















-- 
Best Regards
Masahiro Yamada
