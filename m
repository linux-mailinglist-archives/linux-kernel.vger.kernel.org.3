Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A91C4BCBAE
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 03:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbiBTCZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 21:25:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiBTCZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 21:25:12 -0500
Received: from conssluserg-02.nifty.com (conssluserg-02.nifty.com [210.131.2.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7E53982C;
        Sat, 19 Feb 2022 18:24:51 -0800 (PST)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171]) (authenticated)
        by conssluserg-02.nifty.com with ESMTP id 21K2OYoS018707;
        Sun, 20 Feb 2022 11:24:35 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com 21K2OYoS018707
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645323875;
        bh=O34aX6v+SKBXjsgb5h1Ozq31/g4h4Tgi9RBNyvaw98E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RXxga2KOzm3r4xhrcXPo6WQHVRnq7i4PT7bm4MiWn4/nz17E9JHi5bfzce/yA9PRv
         GWJcfiwEHloEt6kPMDjR4InJe/PFv00y0JFtxcPPL2GmlJ23hQd6kPojp0ehht/U/J
         LYqgSyU+vrZx3OzuSvk1OWvdxQr9zK4Bw8yoOHXkrGu46YwEec2A5GWwLgc97pXiPt
         niIk1YkpJwtFCFkD8P6RGzDg+rjWS/g2Yi/HXA18Gv/ytGG1pjbsvb8DxsO3x3igB8
         6orv4Wt8aw4ONSsZ/YEe2mR9WQ+F1IMOK7q3EKXC5uVPKMKDnlc5BugeZNfbAkyixA
         Mjr45NxSnE3yQ==
X-Nifty-SrcIP: [209.85.214.171]
Received: by mail-pl1-f171.google.com with SMTP id w20so10131433plq.12;
        Sat, 19 Feb 2022 18:24:35 -0800 (PST)
X-Gm-Message-State: AOAM532JXjgfAKWOV1j6TIj/aNsBfHaVVu3QfmvZvAvHPfUgsMivDyiY
        I61TkJm3BLF/nxd4/7bdPNKkjfxRZKYFkM764bg=
X-Google-Smtp-Source: ABdhPJw0wfu9KLEhzJIJyk0BbMkomyu4Z2OGapPuWgbFerBCzpcR7tJFuPaSxqyY4ATdUPXhuNyqTLVEHLWK6wDsdlw=
X-Received: by 2002:a17:902:d2d1:b0:149:732e:d335 with SMTP id
 n17-20020a170902d2d100b00149732ed335mr13611492plc.136.1645323874224; Sat, 19
 Feb 2022 18:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20211213100043.45645-1-arielmarcovitch@gmail.com>
 <20211213100043.45645-2-arielmarcovitch@gmail.com> <CAK7LNAS+Df_V-B9Qy_39hgUZF1b6UeiHQ5m-25JekiVYSQ67dQ@mail.gmail.com>
 <26d74eaa-5c6a-4103-cf77-1356173a3978@gmail.com>
In-Reply-To: <26d74eaa-5c6a-4103-cf77-1356173a3978@gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 20 Feb 2022 11:23:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNARd8S9V07Z1kE5GtjoV=s2W8Of9=nX-tsAGe9BaxAf2FA@mail.gmail.com>
Message-ID: <CAK7LNARd8S9V07Z1kE5GtjoV=s2W8Of9=nX-tsAGe9BaxAf2FA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kconfig: Show menuconfigs as menus in the .config file
To:     Ariel Marcovitch <arielmarcovitch@gmail.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 19, 2022 at 3:39 AM Ariel Marcovitch
<arielmarcovitch@gmail.com> wrote:
>
> Hello!
>
> On 18/01/2022 20:20, Masahiro Yamada wrote:
> > On Mon, Dec 13, 2021 at 7:01 PM Ariel Marcovitch
> > <arielmarcovitch@gmail.com> wrote:
> >> Until now, menuconfigs were considered configs because they had non-zero
> >> sym attribute. This meant that instead of having the nice menu comment
> >> block in the .config output file, they were merely shown as single
> >> configs.
> >>
> >> For example:
> >> ```Kconfig
> >> menu "Foo"
> >> endmenu
> >>
> >> menuconfig BAR
> >>          bool "Bar"
> >>
> >> config OTHER
> >>          bool "Other"
> >>          depends on BAR
> >> ```
> >>
> >> Will be shown as:
> >> ```.config
> >>   #
> >>   # Foo
> >>   #
> >>   # end of Foo
> >
> > I am OK with this patch.
> >
> > Just a nit.
> >
> > As far as I tested your sample code (without applying this patch),
> > I did not see the line "# end of Foo".
> >
> > The line "# end of ..." is printed when the last child gets back to
> > its parent, but the "Foo" menu has no child menu here.
> >
> > This is out of scope of this patch, but can you update the
> > commit log so it matches the current behavior?
>
> I saw you added a patch to change that, so now the code sample here is
> less of a lie :)
>
> I learned my message of never adding code samples to commit messages
> without testing these as well :)
>
> So is it ready now to be applied on top of your change?


Yes, v2 please.










> > (or add one config into the "Foo" menu)
> >
> >
> >
> >
> >
> >
> >
> >>   CONFIG_BAR=y
> >>   CONFIG_OTHER=y
> >> ```
> >>
> >> Instead of using the sym attribute to decide whether or not to print the
> >> menu block comment, check menu->prompt->type explicitly (after checking
> >> that menu_is_visible(menu) which means menu->prompt is not none). The
> >> only prompt types we actually show as menus are P_MENU and P_COMMENT. At
> >> the end of the menu we need to show the end of block only for P_MENU
> >> (although P_COMMENT prompts will not get to this flow because they don't
> >> have children).
> >>
> >> Signed-off-by: Ariel Marcovitch <arielmarcovitch@gmail.com>
> >> ---
> >>   scripts/kconfig/confdata.c | 28 +++++++++++++++++-----------
> >>   1 file changed, 17 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/scripts/kconfig/confdata.c b/scripts/kconfig/confdata.c
> >> index 42bc56ee238c..9f2c22f46ee0 100644
> >> --- a/scripts/kconfig/confdata.c
> >> +++ b/scripts/kconfig/confdata.c
> >> @@ -874,16 +874,21 @@ int conf_write(const char *name)
> >>          menu = rootmenu.list;
> >>          while (menu) {
> >>                  sym = menu->sym;
> >> -               if (!sym) {
> >> -                       if (!menu_is_visible(menu))
> >> -                               goto next;
> >> -                       str = menu_get_prompt(menu);
> >> -                       fprintf(out, "\n"
> >> -                                    "#\n"
> >> -                                    "# %s\n"
> >> -                                    "#\n", str);
> >> -                       need_newline = false;
> >> -               } else if (!(sym->flags & SYMBOL_CHOICE) &&
> >> +
> >> +               if (menu_is_visible(menu)) {
> >> +                       enum prop_type type = menu->prompt->type;
> >> +
> >> +                       if (type == P_MENU || type == P_COMMENT) {
> >> +                               str = menu_get_prompt(menu);
> >> +                               fprintf(out, "\n"
> >> +                                       "#\n"
> >> +                                       "# %s\n"
> >> +                                       "#\n", str);
> >> +                               need_newline = false;
> >> +                       }
> >> +               }
> >> +
> >> +               if (sym && !(sym->flags & SYMBOL_CHOICE) &&
> >>                             !(sym->flags & SYMBOL_WRITTEN)) {
> >>                          sym_calc_value(sym);
> >>                          if (!(sym->flags & SYMBOL_WRITE))
> >> @@ -904,7 +909,8 @@ int conf_write(const char *name)
> >>                  if (menu->next)
> >>                          menu = menu->next;
> >>                  else while ((menu = menu->parent)) {
> >> -                       if (!menu->sym && menu_is_visible(menu) &&
> >> +                       if (menu_is_visible(menu) &&
> >> +                           menu->prompt->type == P_MENU &&
> >>                              menu != &rootmenu) {
> >>                                  str = menu_get_prompt(menu);
> >>                                  fprintf(out, "# end of %s\n", str);
> >> --
> >> 2.25.1
> >>



-- 
Best Regards
Masahiro Yamada
