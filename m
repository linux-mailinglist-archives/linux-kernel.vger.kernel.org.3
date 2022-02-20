Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869004BCC23
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 05:18:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240754AbiBTETF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 23:19:05 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBTETC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 23:19:02 -0500
Received: from conssluserg-06.nifty.com (conssluserg-06.nifty.com [210.131.2.91])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97453443D4;
        Sat, 19 Feb 2022 20:18:40 -0800 (PST)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 21K4IRDj025223;
        Sun, 20 Feb 2022 13:18:27 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 21K4IRDj025223
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645330707;
        bh=wG0O3SlyDxFXA1cB3yTIbsokoTOWhWvZ7Qm9Ehucurc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a5MEDLU707F40ZiQ1VxjZ6hfWzGhsY5i31KtvvZekVA4qlP/Wkz35ZuD2urj56JaH
         LjdQwQ5+25MZzni82ixTfzhmwGmVdb48R7uYXk5+JrkrfH3eU//4E0clZckR3zSy0L
         zNYCcFvQ9J528jZSCAjRirl7FcNgPObuKGa9ngLiFmxq9DlDvLukQL2gjVS5/nU7a9
         QRKALUprTtDKkUkrpKg2GGMCc5QYCCzjLcIkE/2RXhtk7xMUkLksi/yJ9Fu6Av1iP0
         2hyvstpznpfdqqVqwpF4mwRSvvJ/D53hUNKT4aWvHpp6z9KpgS46zT3msOcEnKxyWV
         CoceVlF3Mkc3Q==
X-Nifty-SrcIP: [209.85.214.172]
Received: by mail-pl1-f172.google.com with SMTP id 4so1651635pll.6;
        Sat, 19 Feb 2022 20:18:27 -0800 (PST)
X-Gm-Message-State: AOAM532E17NgsJW3PBj0v65jBomFavyDn1chWckaUOSCdml2Rpf5BfKa
        7vZFXAl3zdYbPEuMYhWW9OFRSUf7rkIJssiKvi8=
X-Google-Smtp-Source: ABdhPJwfmvP4hkfyE4UoQgIqRjlWMHvhTop4ht9wvPWNIjpJ86GWgr3ApEP3tRI/TT57kEWgxtEUc9KpzvBTy85Tsj4=
X-Received: by 2002:a17:902:d2d1:b0:149:732e:d335 with SMTP id
 n17-20020a170902d2d100b00149732ed335mr13871010plc.136.1645330706567; Sat, 19
 Feb 2022 20:18:26 -0800 (PST)
MIME-Version: 1.0
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
 <20211213100043.45645-3-arielmarcovitch@gmail.com> <CAK7LNAQb8ivsQX-0YDNx6B_ZTBUq9v7SSG+m8=e1GsGL-DuBsg@mail.gmail.com>
 <8043765d-2aa5-16ad-cc03-127398451e93@gmail.com>
In-Reply-To: <8043765d-2aa5-16ad-cc03-127398451e93@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Feb 2022 13:17:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNATFiTyRP3xe_U=kHeDN6ZUNQzXhHTJQysa4szschvS-PA@mail.gmail.com>
Message-ID: <CAK7LNATFiTyRP3xe_U=kHeDN6ZUNQzXhHTJQysa4szschvS-PA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kconfig: Make comments look different than menus in .config
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
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

On Sat, Feb 19, 2022 at 3:55 AM Ariel Marcovitch
<arielmarcovitch@gmail.com> wrote:
>
> On 18/01/2022 20:25, Masahiro Yamada wrote:
> > On Mon, Dec 13, 2021 at 7:01 PM Ariel Marcovitch
> > <arielmarcovitch@gmail.com> wrote:
> >> Currently, the same code that handles menus in the write to .config
> >> handles comments as well. That's why comments look exactly like menus in
> >> the .config except for the 'end of menu' comments that appear only for
> >> menus. This makes sense because sometimes comments are used as sort of
> >> submenus. However for the other cases, it looks kinda weird because one
> >> might attempt to look for the 'end of menu' for comments as well and be
> >> very confused.
> >>
> >> Make comments look different than menus. For the following:
> >> ```kconfig
> >> menu "Stuff"
> >>
> >> config FOO
> >>          def_bool y
> >>
> >> comment "Some comment"
> >>
> >> config BAR
> >>          def_bool n
> >>
> >> endmenu
> >> ```
> >>
> >> The .config will look like this:
> >> ```
> >>   #
> >>   # Stuff
> >>   #
> >>   CONFIG_FOO=y
> >>
> >>   ### Some comment
> >>   # CONFIG_BAR is not defined
> >>   # end of Stuff
> >>
> >> ```
> >>
> >> Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
> >> ---
> >>   scripts/kconfig/confdata.c | 14 ++++++++++----
> >>   1 file changed, 10 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> >> index 9f2c22f46ee0..d3ec1ad67d92 100644
> >> --- a/scripts/kconfig/confdata.c
> >> +++ b/scripts/kconfig/confdata.c
> >> @@ -880,10 +880,16 @@ int conf_write(const char *name)
> >>
> >>                          if (type == P_MENU || type == P_COMMENT) {
> >>                                  str = menu_get_prompt(menu);
> >> -                               fprintf(out, "\n"
> >> -                                       "#\n"
> >> -                                       "# %s\n"
> >> -                                       "#\n", str);
> >> +
> >> +                               if (type == P_MENU)
> >> +                                       fprintf(out, "\n"
> >> +                                               "#\n"
> >> +                                               "# %s\n"
> >> +                                               "#\n", str);
> >> +                               else
> >> +                                       fprintf(out, "\n"
> >> +                                               "### %s\n", str);
> >> +
> >>                                  need_newline = false;
> >>                          }
> >>                  }
> >> --
> >> 2.25.1
> >>
> >
> > Since "# CONFIG... is not set" looks like a comment,
> > I am not sure if this improves the visibility.
>
> I agree that adding another '#' signs to the real comments doesn't solve
> the real
> problem here, being that kconfig uses comments to save actual information
>
> I guess this is for being able to check for a config in shell script
> with [[ -n $CONFIG_FOO ]]?

Maybe.
Also   "ifdef CONFIG_FOO" in Makefile.

In the old days, the .config was directly included.

These days, the .config is used for the purpose of
saving the configuration, and include/config/auto.conf



>
> Although if that's the case, leaving the config empty has the same
> effect, no? And then
> we can add a comment to the end of the definition stating that the
> config is unset.
> Something like this:
>
> CONFIG_FOO=y
> CONFIG_BAR= # is not set

The most natural expression is:

    CONFIG_BAR=n







-- 
Best Regards
Masahiro Yamada
