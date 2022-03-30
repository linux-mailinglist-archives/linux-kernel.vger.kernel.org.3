Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809094EB83E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 04:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241708AbiC3CRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 22:17:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiC3CRq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 22:17:46 -0400
Received: from conssluserg-04.nifty.com (conssluserg-04.nifty.com [210.131.2.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFFE1F1634;
        Tue, 29 Mar 2022 19:16:00 -0700 (PDT)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 22U2Fb4U003913;
        Wed, 30 Mar 2022 11:15:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 22U2Fb4U003913
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648606538;
        bh=wA/dPX3LwDIECPfacxqAjooeC1LeQc17W0fddzTnLGU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2vn4M+AONv2I9UyXrBZeib9Sgl+/piCVX2+yLV9d5sh97wrnlCyuz3uEvkvgZL5sA
         egFeth+9RwBkMyMRxlCvccB6dnUX9F/aGDA8YG9MZeScdPruo4OXCCC10YO8grs/eN
         FIavGXm3qbDVOq1OZmTHuDdWNKlPM2gNGQV/ehUvJ2sNaXc34sAWTtYiXveTIGqA2z
         raN8h7BxXuVthZrZhBfizwNN++cdxXWpU0BjjjK4Rjve8FDma5ZdhsDZVV+sdc0p/1
         KwxUkOYEXmK9PdOxXOBHowI/uzo+c0b9qKXOWX4fDsZzkyyFBtZ7H1t1T9ps6+bYDt
         +ObFL3fQa95zQ==
X-Nifty-SrcIP: [209.85.210.176]
Received: by mail-pf1-f176.google.com with SMTP id f3so16283893pfe.2;
        Tue, 29 Mar 2022 19:15:38 -0700 (PDT)
X-Gm-Message-State: AOAM532FTIuW18PeHIQfMPnOIGrBnfsFv3qXk8KEB6yhWDVRTmX1GlpP
        qGjGy49qsuDh8v5aibSBWCD09W8E9HTD8Za1dWQ=
X-Google-Smtp-Source: ABdhPJxZ75sP+BLfObkBnYxrplEiiOpmMN9c2KAqkwJgkPqQecf1q2auDRI5qPl0VYzaSGdE0c36F9OuUVyqaNQeD8Y=
X-Received: by 2002:a05:6a00:a1d:b0:4f6:d122:cd08 with SMTP id
 p29-20020a056a000a1d00b004f6d122cd08mr31317129pfh.68.1648606537281; Tue, 29
 Mar 2022 19:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNATL4v40ZHJ+Ym3k_fVe4ddmMA3wFQXb5RaTz9hmPebeuQ@mail.gmail.com>
 <CAHk-=wgxcu9DFkXAOAFdDtLWwuv6qb5iV1E69yWE-JEVsd-NFg@mail.gmail.com>
In-Reply-To: <CAHk-=wgxcu9DFkXAOAFdDtLWwuv6qb5iV1E69yWE-JEVsd-NFg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 30 Mar 2022 11:14:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQEUydHD1TxgsK1vV5VR-tr98Ej7L=5GphPnAydfWCJ7Q@mail.gmail.com>
Message-ID: <CAK7LNAQEUydHD1TxgsK1vV5VR-tr98Ej7L=5GphPnAydfWCJ7Q@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 5:10 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I pulled this, and then immediately unpulled.
>
> On Mon, Mar 28, 2022 at 5:09 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
> >
> >  - Change the .config format to use CONFIG_FOO=n instead of
> >    "# CONFIG_FOO is not set"
>
> This is unacceptable.
>
> The change was apparently made to make automation easier, at the
> expense of making it harder for people to parse.

Making automation was not the main motivation.

We use comment lines in two ways.

[1] disabled option
     # CONFIG_FOO is not set

[2] real comments

    #
    # IRQ subsystem
    #
    CONFIG_GENERIC_IRQ_PROBE=y
       [ snip]
    # CONFIG_GENERIC_IRQ_DEBUGFS is not set
    # end of IRQ subsystem



In the current .config format,
 it is easy to tell the difference between
"this is enabled" and "this is not enabled",
but it is hard to tell the difference between
"this is not enabled" and "this is a comment".


I constantly receive some patches (e.g. [1] )
for better commenting, but the weirdness
is that Kconfig uses comments to store actual
information.

[1] https://patchwork.kernel.org/project/linux-kbuild/patch/20211213100043.45645-3-arielmarcovitch@gmail.com/


Having said that, you really dislike this change.
Let me send v2.


>
> That is not a valid tradeoff.
>
> I _look_ at my config files. Constantly. I don't want some mess where
> it's really damn hard to visually tell the difference between "this is
> enabled" and "this is not enabled".
>
> So no, I'm not pulling this kind of horrible "make it simpler for
> automation, and harder for humans" to read.
>
>                 Linus



-- 
Best Regards
Masahiro Yamada
