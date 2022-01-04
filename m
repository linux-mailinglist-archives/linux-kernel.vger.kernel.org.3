Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF7484B55
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 00:48:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236592AbiADXsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 18:48:31 -0500
Received: from conssluserg-06.nifty.com ([210.131.2.91]:29277 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiADXs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 18:48:27 -0500
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181]) (authenticated)
        by conssluserg-06.nifty.com with ESMTP id 204Nm73a030215;
        Wed, 5 Jan 2022 08:48:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com 204Nm73a030215
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1641340088;
        bh=8PTuTuT6OHWkSguPcbS1CWLZWKSNeB9m5jJ8lAn4Tks=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gMb0Hx86HIc71+IW7g/Ij6E3IRnCBZiJu5lJXxkmU6L/vBkbecCZsOPLO74kUZRUg
         TyX+j+lmqHDQcrHp6kKRgnKIchX43dk+r+binTpNRoky5xy2/och5BDnPQi0cfzmYI
         SYEeLNcbDlaTWyn0OEG3mdu4lHiMjWdFJsdSrWIv0V5kCwcypinF57CEHnEuPS2DiX
         hACgS+etRq0SlHZfLrLj2VRSIE6fbeUaoUFuLuQj4DgrFxnXnIkR0+u1nGxMmc9B8q
         vKLSkbSIN559PcQ1Ebo4ik0D8xfamJkSN3jxh266qRpc29hcr8m5+g9dS1F/6+SaPp
         rgVtPmctAgZUA==
X-Nifty-SrcIP: [209.85.215.181]
Received: by mail-pg1-f181.google.com with SMTP id r5so34002350pgi.6;
        Tue, 04 Jan 2022 15:48:07 -0800 (PST)
X-Gm-Message-State: AOAM530lzA3LoXRhMKAecP8Y6o2/0wlx4HTE27Jn93yXgbYB1fJA6wdb
        3o1WLXzhqe617RUc6UCVc2a49Gbv+Qtf6V1DYPU=
X-Google-Smtp-Source: ABdhPJxQHFOui/0rK3m3HNOSxZybfqHQer8w6j7qQNVlGHQP9dpAdZtmCp07q32wk9ZG0MsfUfK9AjV9Z1oC09pPes4=
X-Received: by 2002:a62:83c3:0:b0:4ba:bb14:4bf7 with SMTP id
 h186-20020a6283c3000000b004babb144bf7mr52691483pfe.32.1641340086970; Tue, 04
 Jan 2022 15:48:06 -0800 (PST)
MIME-Version: 1.0
References: <20211206023507.447574-1-masahiroy@kernel.org>
In-Reply-To: <20211206023507.447574-1-masahiroy@kernel.org>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 5 Jan 2022 08:47:30 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR1_EfR8xAw=LieqrQm_ZQT6bqfE1g1COFaOf=m+tqnmg@mail.gmail.com>
Message-ID: <CAK7LNAR1_EfR8xAw=LieqrQm_ZQT6bqfE1g1COFaOf=m+tqnmg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] kbuild: move headers_check.pl to usr/include/
To:     Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 11:36 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> This script is only used by usr/include/Makefile. Make it local to
> the directory.
>
> Update the comment in include/uapi/linux/soundcard.h because
> 'make headers_check' is no longer functional.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---


Applied to linux-kbuild.


> Changes in v2:
>  - Fix the comment in soundcard.sh to point to the new file path
>
>  include/uapi/linux/soundcard.h            | 2 +-
>  usr/include/Makefile                      | 2 +-
>  {scripts => usr/include}/headers_check.pl | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename {scripts => usr/include}/headers_check.pl (100%)
>
> diff --git a/include/uapi/linux/soundcard.h b/include/uapi/linux/soundcard.h
> index f3b21f989872..ac1318793a86 100644
> --- a/include/uapi/linux/soundcard.h
> +++ b/include/uapi/linux/soundcard.h
> @@ -1051,7 +1051,7 @@ typedef struct mixer_vol_table {
>   *     the GPL version of OSS-4.x and build against that version
>   *     of the header.
>   *
> - *     We redefine the extern keyword so that make headers_check
> + *     We redefine the extern keyword so that usr/include/headers_check.pl
>   *     does not complain about SEQ_USE_EXTBUF.
>   */
>  #define SEQ_DECLAREBUF()               SEQ_USE_EXTBUF()
> diff --git a/usr/include/Makefile b/usr/include/Makefile
> index 1c2ae1368079..0e9c3e72f43a 100644
> --- a/usr/include/Makefile
> +++ b/usr/include/Makefile
> @@ -99,7 +99,7 @@ quiet_cmd_hdrtest = HDRTEST $<
>        cmd_hdrtest = \
>                 $(CC) $(c_flags) -S -o /dev/null -x c /dev/null \
>                         $(if $(filter-out $(no-header-test), $*.h), -include $< -include $<); \
> -               $(PERL) $(srctree)/scripts/headers_check.pl $(obj) $(SRCARCH) $<; \
> +               $(PERL) $(srctree)/$(src)/headers_check.pl $(obj) $(SRCARCH) $<; \
>                 touch $@
>
>  $(obj)/%.hdrtest: $(obj)/%.h FORCE
> diff --git a/scripts/headers_check.pl b/usr/include/headers_check.pl
> similarity index 100%
> rename from scripts/headers_check.pl
> rename to usr/include/headers_check.pl
> --
> 2.32.0
>


-- 
Best Regards
Masahiro Yamada
