Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51D5A4C59F2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 08:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiB0H4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 02:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbiB0H4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 02:56:07 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9CC6E8EC;
        Sat, 26 Feb 2022 23:55:31 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id i1so1105785ilu.6;
        Sat, 26 Feb 2022 23:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=6UspNjPSA95Czi+4k0cCsQv10TlcLxSQJMlCuYbTSPg=;
        b=jq+c3bNtgj/me5iZFESSxt7NJ6ke9RTuk+wlNtqjzxygLVw9+cVUg1t2hpIYXbktPq
         ao5rJ7YC1cZbHvIuy6XU3Z39MpjSaQCl9KBUb3yPEPj4ojGnyKN4hJeffLNTTBCzN6i6
         G/qUUh7AR6fhqVuX3QAMcXg1Hjjt3d9fw15R34Ek8o5ZQdSKeOGOpcXp+wWRpy8QwxuO
         xgb/SLWvScHqluDNeeSMYX4oV2c/xsQLTadoLr/LmHA36rm2h7KuCqHAv3q69qyKoe23
         2gYVPZNqyXzqrV76HzXLzDPDqJZIQ/T+Z/JDxw9NNdAtpBaiVFMva+mjVkhh8Z1dtUTl
         5stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=6UspNjPSA95Czi+4k0cCsQv10TlcLxSQJMlCuYbTSPg=;
        b=GrFwFURe4TPcYM/XpXErGGIaa696MfsUKxMGSZm5EYy+aZo5qxwijwCK5/GNA4+eeY
         jXIA7mvLgqs1sFz+U/iamQZMt6nAQn6lRaIpLpri8vR63i/CejiW/u+0pTTrqlRbjdeR
         t1r68G1wJdPeqIY9MidgxB3Nqj41rr9qR6rwnyJZ3gm97O4RpWeXlsCU+zijyjeQ7Ckt
         pxS1SciEHdzp5SidxE875abcWPQSmOcSpZVw9a6vjdHkRGv7JQN7BhDZBlrctvd+DryM
         ddc0woOs6bvzpNgnQcND7A0zqDjDMPsNcEIBKg+x6df2Ez3n6uHSJo9iDa0yx14hJTQe
         wRqA==
X-Gm-Message-State: AOAM530cLdLPwo7yqE9vj3OyzfGM74/dDSGZDhcNmWysvSPQEHV/PzHd
        kS+yO6gSaVDL6mlbzxgY5veDBzOR4gnFfWRH9hxXBA79sms=
X-Google-Smtp-Source: ABdhPJyjFgacCLFEcdkTikysykHNhAg9LbgX7uZegiVzEM53tbEn/eipkzpbBcbvyPIEQxMYgsViksKx8isOGd41Uog=
X-Received: by 2002:a92:c14b:0:b0:2c2:8879:44be with SMTP id
 b11-20020a92c14b000000b002c2887944bemr13839805ilh.100.1645948530525; Sat, 26
 Feb 2022 23:55:30 -0800 (PST)
MIME-Version: 1.0
References: <20220226123755.85213-1-masahiroy@kernel.org> <CA+icZUUm1zpbSyOW3xKUsqo9bBjAehw6KvVBjGxpYy4XBjO4yw@mail.gmail.com>
 <CAK7LNARx40BnsL-8sTV+62URe2cr1K1G7MeKN-MMZ0nPw3NFVQ@mail.gmail.com>
In-Reply-To: <CAK7LNARx40BnsL-8sTV+62URe2cr1K1G7MeKN-MMZ0nPw3NFVQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sun, 27 Feb 2022 08:54:54 +0100
Message-ID: <CA+icZUXkd=dtbBX3UKLRzGiVSKC=TeW7ATiRKD9dnYtmm6RZqg@mail.gmail.com>
Subject: Re: [PATCH] kconfig: change .config format to use =n instead of "is
 not set"
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 5:24 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Sun, Feb 27, 2022 at 6:38 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > On Sat, Feb 26, 2022 at 2:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> > >
> > > The .config file uses "# CONFIG_FOO is not set" form to represent
> > > disabled options. In the old days, it was useful because the .config
> > > was directly included from Makefiles. For example, you can use
> > > "ifdef CONFIG_FOO" in Makefiles to check if the option is enabled.
> > >
> > > Commit c955ccafc38e ("kconfig: fix .config dependencies") introduced
> > > include/config/auto.conf, which mirrors the .config, but trims down
> > > all disabled options.
> > >
> > > Since then, include/config/auto.conf defines CONFIG options during the
> > > build. The .config is used just for storing the user's configuration.
> > > I do not see a strong reason to use a particular pattern of comment
> > > for disabled options.
> > >
> > > With this commit, Kconfig will output disable options in a more natural
> > > form, "CONFIG_FOO=n".
> > >
> > > Kconfig accepts both "# CONFIG_FOO is not set" and "CONFIG_FOO=n" as a
> > > valid input. You do not need to update arch/*/configs/*_defconfig files
> > > for now. "git bisect" should be able to cross the commit in both ways
> > > without any issue.
> > >
> >
> > Good.
> >
> > Lot of people use/used the notation CONFIG_FOO=n, so did I.
> >
> > Thanks for keeping the "compatibility" with old usage "# CONFIG_FOO is not set".
> >
> > Normally, I use git diff (or scripts/diffconfig in Git tree) to
> > compare two kernel-configs, so seeing
> >
> > -CONFIG_FOO=y
> > +CONFIG_FOO=n
> >
> > ...might be at first view unfamiliar/unusual.
> > With the old notation it was easier to see that Kconfig is unset.
>
> I agree on this point.
>
> "is not set" stands out much better than "=n",
> and our eyes are accustomed to this notation for 20 years.
>
> However, real comments do not stand out since
> we already (ab)use comments for disabled options.
>
> This is related thread
> https://patchwork.kernel.org/project/linux-kbuild/patch/20211213100043.45645-3-arielmarcovitch@gmail.com/
>

Thanks for the link.

> >
> > Is this patch on top of kbuild-next Git?
> >
>
> Yes.

Let me see if I will try kbuild-next with this patch on top of
upcoming Linux v5.17-rc6.

- Sedat -
