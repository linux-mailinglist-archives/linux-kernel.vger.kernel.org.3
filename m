Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97E24C5941
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 05:25:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbiB0EZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 23:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiB0EZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 23:25:26 -0500
Received: from conssluserg-05.nifty.com (conssluserg-05.nifty.com [210.131.2.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D3A286A61;
        Sat, 26 Feb 2022 20:24:50 -0800 (PST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 21R4OJQH003168;
        Sun, 27 Feb 2022 13:24:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 21R4OJQH003168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1645935859;
        bh=QMpLpFvK50geS0pNLEKH725VNQkb2vBonv3zKogEUhU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Qaz7a4wqvAPO6nmHRGNyWFAqhm83Y+SV2XsaZ2qfgZovUZn8oiMwdRN/wQg961jpM
         gshCm23qvbd77r+xArOKVW7T4eHDeS1X/hoM6lXz0AIw7asf+swCGYA1fRKfu5QBJG
         hQhoo8KQt/arplcRBrCrUxBnBsXCcOXOxVIZ0agnGNr1q1HszgNB5W4bGVrUwboe/P
         5zthUlHlMQWDfZY6GKz+S5qN+1xA2DeIqilW5pO812sVjz5MZ6c5KvRx1iSokK3bZt
         5LNufzq7DI62N31P0o9rCG7YzbRA43ROahW/Sa3OUcGmK0vbIPv5t6I5atALh9Ix41
         fW/uBFhucYShQ==
X-Nifty-SrcIP: [209.85.214.170]
Received: by mail-pl1-f170.google.com with SMTP id b22so8035110pls.7;
        Sat, 26 Feb 2022 20:24:19 -0800 (PST)
X-Gm-Message-State: AOAM5333dPfkNNumKcrEC9VnBGUGHXyrYuNFhxqhQXUFdVavGBR8ugUP
        OeIQYk3kG0MSiKQ6daeFTPvWb7xDmJ9UUnp+YxU=
X-Google-Smtp-Source: ABdhPJx82Fht5/y6E94Ik8jhTKs8bwEQszU5prGNOMpqi8fxSns9dt8Gv357NxdOgnc1Ymg2WhhzTnihOP75sTIIYT4=
X-Received: by 2002:a17:90a:ab17:b0:1b9:b61a:aadb with SMTP id
 m23-20020a17090aab1700b001b9b61aaadbmr10547760pjq.77.1645935858727; Sat, 26
 Feb 2022 20:24:18 -0800 (PST)
MIME-Version: 1.0
References: <20220226123755.85213-1-masahiroy@kernel.org> <CA+icZUUm1zpbSyOW3xKUsqo9bBjAehw6KvVBjGxpYy4XBjO4yw@mail.gmail.com>
In-Reply-To: <CA+icZUUm1zpbSyOW3xKUsqo9bBjAehw6KvVBjGxpYy4XBjO4yw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 27 Feb 2022 13:23:36 +0900
X-Gmail-Original-Message-ID: <CAK7LNARx40BnsL-8sTV+62URe2cr1K1G7MeKN-MMZ0nPw3NFVQ@mail.gmail.com>
Message-ID: <CAK7LNARx40BnsL-8sTV+62URe2cr1K1G7MeKN-MMZ0nPw3NFVQ@mail.gmail.com>
Subject: Re: [PATCH] kconfig: change .config format to use =n instead of "is
 not set"
To:     Sedat Dilek <sedat.dilek@gmail.com>
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

On Sun, Feb 27, 2022 at 6:38 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Sat, Feb 26, 2022 at 2:34 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> > The .config file uses "# CONFIG_FOO is not set" form to represent
> > disabled options. In the old days, it was useful because the .config
> > was directly included from Makefiles. For example, you can use
> > "ifdef CONFIG_FOO" in Makefiles to check if the option is enabled.
> >
> > Commit c955ccafc38e ("kconfig: fix .config dependencies") introduced
> > include/config/auto.conf, which mirrors the .config, but trims down
> > all disabled options.
> >
> > Since then, include/config/auto.conf defines CONFIG options during the
> > build. The .config is used just for storing the user's configuration.
> > I do not see a strong reason to use a particular pattern of comment
> > for disabled options.
> >
> > With this commit, Kconfig will output disable options in a more natural
> > form, "CONFIG_FOO=n".
> >
> > Kconfig accepts both "# CONFIG_FOO is not set" and "CONFIG_FOO=n" as a
> > valid input. You do not need to update arch/*/configs/*_defconfig files
> > for now. "git bisect" should be able to cross the commit in both ways
> > without any issue.
> >
>
> Good.
>
> Lot of people use/used the notation CONFIG_FOO=n, so did I.
>
> Thanks for keeping the "compatibility" with old usage "# CONFIG_FOO is not set".
>
> Normally, I use git diff (or scripts/diffconfig in Git tree) to
> compare two kernel-configs, so seeing
>
> -CONFIG_FOO=y
> +CONFIG_FOO=n
>
> ...might be at first view unfamiliar/unusual.
> With the old notation it was easier to see that Kconfig is unset.

I agree on this point.

"is not set" stands out much better than "=n",
and our eyes are accustomed to this notation for 20 years.

However, real comments do not stand out since
we already (ab)use comments for disabled options.

This is related thread
https://patchwork.kernel.org/project/linux-kbuild/patch/20211213100043.45645-3-arielmarcovitch@gmail.com/



>
> Is this patch on top of kbuild-next Git?
>

Yes.
