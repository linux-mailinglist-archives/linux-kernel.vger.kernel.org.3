Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6901A54773C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 20:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiFKS5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 14:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFKS5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 14:57:07 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1664B56FB1;
        Sat, 11 Jun 2022 11:57:05 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 25BIuipR007517;
        Sun, 12 Jun 2022 03:56:45 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 25BIuipR007517
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654973805;
        bh=AoopS6AH6/JYPKTM3ymepP+zzBS9+J7pNi+ot06aLfU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=1hxHdjea+yXpMjpsTMSPebRmtgQDusnHAGA0js0Znn3iWgpqUiSNenmTl6Xumu0Ba
         6qd05Tac04EI0EvhxbVJLNmwsjC9O0SV7FSZs6COtCFKjQ9JmARDoKy6VfSDLjJbks
         zSdZ0spJgl3n7aY5gwSO1/UQyuzBcFI++nRlDCx+66Qx0UyTnP8G/yj/Qz/oeIFDYn
         Jiaf2pvBeeu8M4uLnS0P2kXPSGZfmO5Fk+wAcUmFcjgWYpYNju2crY3y+woMD2uqdb
         GH5r7oGZj+uI52aIInWTlTqiFP+MUlPKie9ywS+19h0IQ9t6Cn2dk3q0rwBkH9SHZY
         meiqS68rxPC3w==
X-Nifty-SrcIP: [209.85.221.49]
Received: by mail-wr1-f49.google.com with SMTP id c21so2451983wrb.1;
        Sat, 11 Jun 2022 11:56:44 -0700 (PDT)
X-Gm-Message-State: AOAM5306m/gx1ieViX0dQVK91CgVAfASkl+lZDcsn409kZh0m8rKb4Le
        ptwFny51ynAJUVGtEkkuL3vRCQ8QqlAlplX+jp0=
X-Google-Smtp-Source: ABdhPJxB1C4InfiSv00V6Ot8xswrI/1/InpXbFlsD/nXyEPcwu4M+CGhlUqKoYF564m9vLYDkPaZQTAztf1lF9q4UAU=
X-Received: by 2002:a5d:584f:0:b0:219:e106:3e02 with SMTP id
 i15-20020a5d584f000000b00219e1063e02mr11725196wrf.461.1654973803245; Sat, 11
 Jun 2022 11:56:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220610183236.1272216-1-masahiroy@kernel.org>
 <20220610183236.1272216-6-masahiroy@kernel.org> <c86b53f8d8c60a16a4cb3b34ac9ab2ab8b992595.camel@perches.com>
In-Reply-To: <c86b53f8d8c60a16a4cb3b34ac9ab2ab8b992595.camel@perches.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 12 Jun 2022 03:56:06 +0900
X-Gmail-Original-Message-ID: <CAK7LNATVUh2nOKGA0OUC4r37xYeae2ZEPE=FHFvRn5-3o5H11g@mail.gmail.com>
Message-ID: <CAK7LNATVUh2nOKGA0OUC4r37xYeae2ZEPE=FHFvRn5-3o5H11g@mail.gmail.com>
Subject: Re: [PATCH 5/7] checkpatch: warn if <asm/export.h> is included
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules <linux-modules@vger.kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 10:33 AM Joe Perches <joe@perches.com> wrote:
>
> On Sat, 2022-06-11 at 03:32 +0900, Masahiro Yamada wrote:
> > With the previous refactoring,
> >
> >  - <asm/export.h> is a wrapper of <asm-generic/export.h>
> >  - <asm-generic/export.h> is a wrapper of <linux/export.h>
> >
> > My hope is to replace
> >
> >    #include <asm/export.h>  -->  #include <linux/export.h>
> >
> > for all *.S files.
> >
> > For now, adding a warning in the checkpatch.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/checkpatch.pl | 7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> []
> > @@ -3753,6 +3753,13 @@ sub process {
> >                            "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
> >               }
> >
> > +# warn if <asm/export.h> is included.
> > +# <asm/export.h> is a wrapper of <linux/export.h>. Please include <linux/export.h> directly.
> > +             if ($tree && $rawline =~ m{^.\s*\#\s*include\s*\<asm\/export\.h\>}) {
> > +                     WARN("INCLUDE_LINUX_EXPORT",
> > +                         "Please include <linux/export.h> instead of <asm/export.h>\n" . $herecurr);
> > +             }
>
> This warns on patch context lines.
> That's not something checkpatch generally does.
>
> Likely this should use /^\+ rather than /^.
>
> And it's nice to have --fix capability
>
>                         if (WARN("etc...") &&
>                             $fix) {
>                                 $fixed[$fixlinenr] =~ s/\s*#\s*include\s*\<asm\/export\.h\>/#include <linux/export.h>/;
>                         }
>
> cheers, Joe



I retract this patch series because I realized it was breaking ia64.
Please ignore this patch.

Anyway, your expert feedback about checkpatch.pl
was very appreciated. Thank you.


-- 
Best Regards
Masahiro Yamada
