Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C5C4CE36A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 08:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiCEHUQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 02:20:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiCEHUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 02:20:13 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8708D240DF7;
        Fri,  4 Mar 2022 23:19:24 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id x14so8108323ill.12;
        Fri, 04 Mar 2022 23:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=Q2swG4/Q4VYLXmiZzbAmmWAx2ko3A/RK0gh0OlX3gGA=;
        b=YClrx//ZVwvKRW7lRukKlAo8dKnA+cN66kcPaZ1nbwvbD4+RzPoHAsNSdJ7TbD7W4P
         moXXQjiujZTQPt3aSVv3awUViK7cYdgSticgAVoECiKUgadA/08/fJ0KVi/DVegKhBBg
         YUprtpCkZgvls/7w880umyJN6MwV7r+h/IgiW+ItXTw1Lgo66G0Rd99h6l+W1uBTHKr7
         SM8iDC+bMki5XfuHC4SD9DEPAwbAl8TBWqErqaP4AxqPhr0kxfeFnXJigJpn/um3Z1Uw
         Axwsam2ht16kgCYs4TLFtxfCvc24ZQy59YlD6emtRH9o8XzlkZoQJqZ8SR7MQB2J6rJ3
         kbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=Q2swG4/Q4VYLXmiZzbAmmWAx2ko3A/RK0gh0OlX3gGA=;
        b=v+mmTAIO7es1zWlki53Xb7HBGqg4E/qr7Ohj6EMD8HGC4HC64iuZund76kebihsZxm
         Qcl65QdVLJy3LbPtglMk9IgjsXXgJzyK+i1KXJjLrQYuOqLJ3e7Tu7oXFsAPVAzwhdCV
         A0dCm5Y45vnZVFbEGGkYwVynV0JqyDTK+ZaLFdA09NWQm1X7uVI9aYiemNrSviCUrgMG
         asGj3+1ZugtNU81+rIOr4MkDb3CoiwPfrSJQ3GJhYocMm9fjA8htXPkMcgfhP22yom5A
         boo7YlofQI0HB8kvY+DeQkJjtxFxk1LaEtVCCiCN2ki1ckAjKUzQVUxwvTKPgvSQXKOH
         h5nA==
X-Gm-Message-State: AOAM5311ISN71o6+LigCkCxtXsnPTcOgTB2waHDrOPaTVzKTqchzc18O
        qMBs25TIsu2EwWoVvvF3VWuRpiSwLJGnhQ+YpFZhupFlhBMeZQ==
X-Google-Smtp-Source: ABdhPJw0SXzTwY3Z/qZWZ0oIMDR5umUhkMBTmvmCDoCrsukS3xMlV5mU7mHNQBBlUhTLjEldiA0Ms94GDyjjWWd+6mY=
X-Received: by 2002:a05:6e02:164f:b0:2c6:1b85:b985 with SMTP id
 v15-20020a056e02164f00b002c61b85b985mr2358933ilu.4.1646464763682; Fri, 04 Mar
 2022 23:19:23 -0800 (PST)
MIME-Version: 1.0
References: <20220226123755.85213-1-masahiroy@kernel.org> <CA+icZUUm1zpbSyOW3xKUsqo9bBjAehw6KvVBjGxpYy4XBjO4yw@mail.gmail.com>
 <CAK7LNARx40BnsL-8sTV+62URe2cr1K1G7MeKN-MMZ0nPw3NFVQ@mail.gmail.com> <CA+icZUXkd=dtbBX3UKLRzGiVSKC=TeW7ATiRKD9dnYtmm6RZqg@mail.gmail.com>
In-Reply-To: <CA+icZUXkd=dtbBX3UKLRzGiVSKC=TeW7ATiRKD9dnYtmm6RZqg@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 5 Mar 2022 08:18:47 +0100
Message-ID: <CA+icZUWBO3S4DVqDR=fQ8O07JM+w-3ThgnaBqMPo9YhivtoULA@mail.gmail.com>
Subject: Re: [PATCH] kconfig: change .config format to use =n instead of "is
 not set"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 8:54 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sun, Feb 27, 2022 at 5:24 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > On Sun, Feb 27, 2022 at 6:38 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> > >
> > > On Sat, Feb 26, 2022 at 2:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > > >
> > > > The .config file uses "# CONFIG_FOO is not set" form to represent
> > > > disabled options. In the old days, it was useful because the .config
> > > > was directly included from Makefiles. For example, you can use
> > > > "ifdef CONFIG_FOO" in Makefiles to check if the option is enabled.
> > > >
> > > > Commit c955ccafc38e ("kconfig: fix .config dependencies") introduced
> > > > include/config/auto.conf, which mirrors the .config, but trims down
> > > > all disabled options.
> > > >
> > > > Since then, include/config/auto.conf defines CONFIG options during the
> > > > build. The .config is used just for storing the user's configuration.
> > > > I do not see a strong reason to use a particular pattern of comment
> > > > for disabled options.
> > > >
> > > > With this commit, Kconfig will output disable options in a more natural
> > > > form, "CONFIG_FOO=n".
> > > >
> > > > Kconfig accepts both "# CONFIG_FOO is not set" and "CONFIG_FOO=n" as a
> > > > valid input. You do not need to update arch/*/configs/*_defconfig files
> > > > for now. "git bisect" should be able to cross the commit in both ways
> > > > without any issue.
> > > >
> > >
> > > Good.
> > >
> > > Lot of people use/used the notation CONFIG_FOO=n, so did I.
> > >
> > > Thanks for keeping the "compatibility" with old usage "# CONFIG_FOO is not set".
> > >
> > > Normally, I use git diff (or scripts/diffconfig in Git tree) to
> > > compare two kernel-configs, so seeing
> > >
> > > -CONFIG_FOO=y
> > > +CONFIG_FOO=n
> > >
> > > ...might be at first view unfamiliar/unusual.
> > > With the old notation it was easier to see that Kconfig is unset.
> >
> > I agree on this point.
> >
> > "is not set" stands out much better than "=n",
> > and our eyes are accustomed to this notation for 20 years.
> >
> > However, real comments do not stand out since
> > we already (ab)use comments for disabled options.
> >
> > This is related thread
> > https://patchwork.kernel.org/project/linux-kbuild/patch/20211213100043.45645-3-arielmarcovitch@gmail.com/
> >
>
> Thanks for the link.
>
> > >
> > > Is this patch on top of kbuild-next Git?
> > >
> >
> > Yes.
>
> Let me see if I will try kbuild-next with this patch on top of
> upcoming Linux v5.17-rc6.
>

I was not able to apply your patch on top of latest kbuild-next.git:

$ git log --oneline v5.17-rc6..
3a8276b1ae7e (HEAD -> for-5.17/kbuild-next-2022022) Merge branch
'for-next' of https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild
into for-5.17/kbuild-next-2022022
d4c858643263 kallsyms: ignore all local labels prefixed by '.L'
a7d4f58e99dd kconfig: fix missing '# end of' for empty menu
868653f421cd kconfig: add fflush() before ferror() check
5c8166419acf kbuild: replace $(if A,A,B) with $(or A,B)
f67695c9962e kbuild: Add environment variables for userprogs flags
a5575df58004 kbuild: unify cmd_copy and cmd_shipped

$ LC_ALL=C git apply --check --verbose
../20220226_masahiroy_kconfig_change_config_format_to_use_n_instead_of_is_not_set.mbx
Checking patch scripts/kconfig/confdata.c...
error: while searching for:
       return out;
}

enum output_n { OUTPUT_N, OUTPUT_N_AS_UNSET, OUTPUT_N_NONE };

static void __print_symbol(FILE *fp, struct symbol *sym, enum output_n output_n,
                          bool escape_string)
{
       const char *val;

error: patch failed: scripts/kconfig/confdata.c:658
error: scripts/kconfig/confdata.c: patch does not apply
Checking patch scripts/kconfig/merge_config.sh...
Checking patch scripts/kconfig/streamline_config.pl...
Checking patch scripts/kconfig/tests/choice/alldef_expected_config...
Checking patch scripts/kconfig/tests/choice/allmod_expected_config...
Checking patch scripts/kconfig/tests/choice/allno_expected_config...
Checking patch scripts/kconfig/tests/choice/allyes_expected_config...
Checking patch scripts/kconfig/tests/choice/oldask1_config...
Checking patch scripts/kconfig/tests/inter_choice/expected_config...
Checking patch scripts/kconfig/tests/new_choice_with_dep/config...
Checking patch scripts/kconfig/tests/no_write_if_dep_unmet/__init__.py...
Checking patch scripts/kconfig/tests/no_write_if_dep_unmet/expected_config...

$ git log --oneline v5.17-rc6.. scripts/kconfig/confdata.c
a7d4f58e99dd kconfig: fix missing '# end of' for empty menu
868653f421cd kconfig: add fflush() before ferror() check

- Sedat -
