Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC96E468E92
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhLFBaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:30:08 -0500
Received: from conssluserg-04.nifty.com ([210.131.2.83]:31625 "EHLO
        conssluserg-04.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbhLFBaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:30:05 -0500
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169]) (authenticated)
        by conssluserg-04.nifty.com with ESMTP id 1B61QJSB014961;
        Mon, 6 Dec 2021 10:26:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-04.nifty.com 1B61QJSB014961
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1638753980;
        bh=bTLJ/FhfjJFuHBBQBmsFdBVETare2IBx5K2SgNpA/3U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eScM6k3EqZmv85kztqfJNj6eQPpK0z/fQv2h8unfpDXoYAVUiHGEP+MmK75l1TzBo
         yjTsgXru6P/BEJTCZaU5cZAEqhBJzMsSG/9p7s5dL2dy6Jx9GnNu66m4dBH5zdrJAp
         iHPTAf4d61wR0Ess2MIQaOEJeWvw4PPMcCPYyWJJT+RddXTqLUJh/cj/zrPlgpBfgD
         m7Wj8aLcLbzU/dj9xQ7qkLortGcPj/ziY4sG6c1nB1GX5iE6NODh3rJG+ODdFGqS5m
         QXEiggIOgpIOCl0nlSN+9RT6K744+KVhTrw+oqHWgSsgv42oJFw9KSShI7gs4ZlMCy
         VrXfz6VPwVOeA==
X-Nifty-SrcIP: [209.85.215.169]
Received: by mail-pg1-f169.google.com with SMTP id l190so8930657pge.7;
        Sun, 05 Dec 2021 17:26:20 -0800 (PST)
X-Gm-Message-State: AOAM53043wm/19KKraqmOqoblN5z7DYRyNyLb+35wcGkCe1dmPLk35O/
        x0+j9pKaZx9rlMXjz8Ea7Lr62gfmr0dQErT2AIE=
X-Google-Smtp-Source: ABdhPJwmfa5PGfTsywA5yHzN+wuZBOkVcnUgZcDaj3keg45Gtfw/CFNE4EgL9M5PP2ztW1p1j1HMBljROs0XKWoKL0g=
X-Received: by 2002:a62:a21b:0:b0:4ad:57c9:c7d1 with SMTP id
 m27-20020a62a21b000000b004ad57c9c7d1mr6576445pff.68.1638753979510; Sun, 05
 Dec 2021 17:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20211206010533.439981-1-masahiroy@kernel.org> <046c27a3937b27c26ece93f835e692c75c7bd1a0.camel@perches.com>
In-Reply-To: <046c27a3937b27c26ece93f835e692c75c7bd1a0.camel@perches.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Mon, 6 Dec 2021 10:25:43 +0900
X-Gmail-Original-Message-ID: <CAK7LNARYvpFB-8gurgokFGMLiV6iQWwqdu=MtvGjhTdEv9StvA@mail.gmail.com>
Message-ID: <CAK7LNARYvpFB-8gurgokFGMLiV6iQWwqdu=MtvGjhTdEv9StvA@mail.gmail.com>
Subject: Re: [PATCH 1/2] kbuild: move headers_check.pl to usr/include/
To:     Joe Perches <joe@perches.com>
Cc:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 10:16 AM Joe Perches <joe@perches.com> wrote:
>
> On Mon, 2021-12-06 at 10:05 +0900, Masahiro Yamada wrote:
> > This script is only used by usr/include/Makefile. Make it local to
> > the directory.
> >
> > Update the comment in include/uapi/linux/soundcard.h because
> > 'make headers_check' is no longer functional.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  include/uapi/linux/soundcard.h            | 2 +-
> >  usr/include/Makefile                      | 2 +-
> >  {scripts => usr/include}/headers_check.pl | 0
> >  3 files changed, 2 insertions(+), 2 deletions(-)
> >  rename {scripts => usr/include}/headers_check.pl (100%)
> >
> > diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
> []
> > @@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
> >   *   the GPL version of OSS-4.x and build against that version
> >   *   of the header.
> >   *
> > - *   We redefine the extern keyword so that make headers_check
> > + *   We redefine the extern keyword so that scripts/headers_check.pl
>
> Didn't you just move/rename this file?

My bad - it is the old file path.

Thanks, I will fix it.





> > diff --git a/scripts/headers_check.pl b/usr/include/headers_check.pl
> > similarity index 100%
> > rename from scripts/headers_check.pl
> > rename to usr/include/headers_check.pl
>
>


-- 
Best Regards
Masahiro Yamada
