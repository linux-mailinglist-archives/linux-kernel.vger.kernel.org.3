Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E885109EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 22:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354816AbiDZUPe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 16:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354789AbiDZUPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 16:15:22 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211B186BDA;
        Tue, 26 Apr 2022 13:11:48 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.99.192]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXXdn-1nN8Dl1QXX-00YyYT; Tue, 26 Apr 2022 22:10:58 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 198DB3C088; Tue, 26 Apr 2022 22:10:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1651003856; bh=R/Kw4Op8hyZ4jcPee67qTZrfx8Tg8yOC+/sEkC2esoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wTIUDYxZf0jXcmnl84CmDsd6y8ocCqm85HkaULylafFos1Pl0b5ahPaM38DvcHUz6
         GSPPMpBnzjTvKDvf3cYpNeWYO3xoE4aH/j8EupWjse256FH1iNl8UWAdWL6EDZbLEE
         QSf320O5dKUBT3w7cQsX6UcWZUInR9zDeu0rKbfY=
Date:   Tue, 26 Apr 2022 22:10:55 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        llvm@lists.linux.dev
Subject: Re: [PATCH 00/27] kbuild: yet another series of cleanups (modpost
 and LTO)
Message-ID: <YmhRz1SEjpEU8Nty@fjasle.eu>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
X-Provags-ID: V03:K1:122aPGvBqY6tIA/oCXwlRl7Mpi1hoD+1bqMgfw6wBwc7/XwIpVA
 tF7voRfpYSiI1mICJ7rrQul2yM5xn5+uwMsYJ+4EXwMR9/LRUzyncr6jn2/NiMydmusiw1w
 0yLZefHPWffuC7tugEcFuBTX18JjhPH5og9os/6pIZzepIKZgmXYgmRDMwGmEmMRcQXAAfL
 IhBTu4JaVBHoSOMZ4Xppw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MfXNq7HSm7Y=:8MI0vvK4hksh7bM8YAeCcI
 7YqNb4DgX+6BEA+wzM0SfU9HV1BPk0i3J2OMZm3uQ4MHKFsUVDraVvcYdk+c7Ltyp2Dx5n9xG
 v4fPhyK2d60XIWjCOgAu/krFpmPOw6c7mpRP16JNM4Hyt62Rx0aJyDRtFlA4x9C9mvqNitEmo
 mrv3qzQXva5a/BJcK9m9sG/YwUANRCCSIPjLOmgDzWumnb0o0/Ia2Mhfy2fqruHKqJbVVskzv
 gA46poB7oMtBOSdPUwUWl4AVjdl6qFJmEQDuOFX/dmjuZCeKdugz2CgJfNPJG9arEv1x282T/
 UI5q4j3p3Z+PP1pIPhTHSvHT1ggeenXZbcCz+GgA3eBb2XNFTG/0DiHaO5rvxAja1/FdsyYVz
 f8u68KnoSFVBAtRGMhdGPeNS34OuMv/GlvPGlGLFvtcGTXAZigvddHgTq//S7pZBE2tCUmLkc
 FXWJR1wZb1icdKedDjHETRIPUnS/w77peONwXAEtLhPJf5DzWPLQXhu5yf6+f7HroTOm9QFG5
 Sq5Bx5yrbziU8uKglfwHU3UvGtabaLlIs3ek+IelQ1/h6HNOiaRwq2mSh3WP2I3mcOpbw+J/F
 UFJX/trsX+0USBvdc0E0QgjAKbuzYckHiciVMRXAu2jdwZS/G50xNjJsJb7K7vn2tnPfQEjsd
 0xsBBM7GZo/d25FzkxxHjpg/TCajSoxoUV2MllaBg/8GZP5FaBSQtr+qwMMnbpgbTXM0=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 04:07:44AM +0900 Masahiro Yamada wrote:
> This is the third batch of cleanups in this development cycle.
> 
> This weekend, I wrote up the code I have been planning.
> 
> After a bunch of modpost refactoring, I got rid of the ugly code
> in Makefiles.
> 
> With this, Kbuild will get back much simpler and cleaner.
> 

Hi Masahiro,

I tried applying the patch set onto your kbuild and
kbuild-fixes-v5.18, but it didn't apply.  Can you give me
a hint on your commit base?

Kind regards,
Nicolas

> 
> Masahiro Yamada (27):
>   modpost: use snprintf() instead of sprintf() for safety
>   modpost: do not write out any file when error occurred
>   modpost: remove stale comment about sym_add_exported()
>   modpost: add a separate error for exported symbols without definition
>   modpost: retrieve the module dependency and CRCs in check_exports()
>   modpost: use bool type where appropriate
>   modpost: import include/linux/list.h
>   modpost: traverse modules in order
>   modpost: add sym_add_unresolved() helper
>   modpost: traverse unresolved symbols in order
>   modpost: use doubly linked list for dump_lists
>   modpost: move struct namespace_list to modpost.c
>   modpost: traverse the namespace_list in order
>   modpost: dump Module.symvers in the same order of modules.order
>   modpost: move static EXPORT_SYMBOL check to check_exports()
>   modpost: make multiple export error
>   modpost: make sym_add_exported() always allocate a new symbol
>   modpost: make sym_add_exported() a void function
>   modpost: use hlist for hash table implementation
>   modpost: mitigate false-negatives for static EXPORT_SYMBOL checks
>   kbuild: record symbol versions in *.cmd files
>   kbuild: generate a list of objects in vmlinux
>   modpost: retrieve symbol versions by parsing *.cmd files
>   modpost: generate linker script to collect symbol versions
>   kbuild: embed symbol versions at final link of vmlinux or modules
>   kbuild: stop generating *.symversions
>   kbuild: do not create *.prelink.o for Clang LTO or IBT
> 
>  .gitignore                |   1 +
>  Makefile                  |   1 +
>  scripts/Kbuild.include    |   4 +
>  scripts/Makefile.build    | 107 ++------
>  scripts/Makefile.lib      |   7 -
>  scripts/Makefile.modfinal |   6 +-
>  scripts/Makefile.modpost  |   9 +-
>  scripts/link-vmlinux.sh   |  38 ++-
>  scripts/mod/file2alias.c  |   2 -
>  scripts/mod/list.h        | 336 ++++++++++++++++++++++++
>  scripts/mod/modpost.c     | 529 +++++++++++++++++++++++---------------
>  scripts/mod/modpost.h     |  27 +-
>  12 files changed, 731 insertions(+), 336 deletions(-)
>  create mode 100644 scripts/mod/list.h
> 
> -- 
> 2.32.0

-- 
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
↳ gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --
