Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD893473A38
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 02:32:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244651AbhLNBcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 20:32:19 -0500
Received: from conssluserg-05.nifty.com ([210.131.2.90]:63809 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238136AbhLNBcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 20:32:18 -0500
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id 1BE1W5QR006203;
        Tue, 14 Dec 2021 10:32:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com 1BE1W5QR006203
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1639445526;
        bh=YecfyrVuHcIj3JIfIPxpAE7z9z7J8Agwmei6SxsRfcc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gglte5PICyRgxRnjQPRZYg05NI0HLeQIQ6xYTOYocMjUX63AEf0iiVFCUFUzXD+LP
         cMHOTuGpQE3YwPDnTo/AfEUjKOwdZM6aLUWuZdCaY1UTXC2zgbhf9lb5PZuq6TLikj
         im3kMhZTEhC/SBM7HmNp3Wi9b9t62fdS7Ndc8N8Jz/fQ/RW9q15b68betND7oozize
         lafA0S6nvIxVJhlVQcDmw504Eq1TNubweUL8Tewmx8mZWmThDynvGaWdqGgdhg92P9
         B+u91RK9pjlFlyS7W964y7IUNGrkwH5to5pYYUFXEsl0Sr6qbM5mbuO1k4f8BEGKgd
         U7//uW2p59oWA==
X-Nifty-SrcIP: [209.85.214.174]
Received: by mail-pl1-f174.google.com with SMTP id z6so12460097plk.6;
        Mon, 13 Dec 2021 17:32:06 -0800 (PST)
X-Gm-Message-State: AOAM532KAlBugtuo9EwUq4TwuRQY9HNEhNZw0Uo0jYYlPDynbgN8TeRy
        lNeQ1VC75S8gkaRNyT7OC9CuCQ/XQtLVYltIzOo=
X-Google-Smtp-Source: ABdhPJyWu3SMDBUYUoXFNZPEQBudlfvrZxRUn6rw5S9zluOZN5NAVz3k+6YSdlOfL1WNyN5vkeUWiWFVs0mHRV4Am5Q=
X-Received: by 2002:a17:90a:fb43:: with SMTP id iq3mr2079208pjb.144.1639445525497;
 Mon, 13 Dec 2021 17:32:05 -0800 (PST)
MIME-Version: 1.0
References: <1639389477-17586-1-git-send-email-yangtiezhu@loongson.cn> <1639389477-17586-3-git-send-email-yangtiezhu@loongson.cn>
In-Reply-To: <1639389477-17586-3-git-send-email-yangtiezhu@loongson.cn>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 14 Dec 2021 10:31:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASgJ4TOrPx87yi+VtXMBHC=g2hFSS9HuEE7Qo8HUfJfCg@mail.gmail.com>
Message-ID: <CAK7LNASgJ4TOrPx87yi+VtXMBHC=g2hFSS9HuEE7Qo8HUfJfCg@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] MIPS: Makefile: Remove "ifdef need-compiler" for Kbuild.platforms
To:     Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Jason Self <jason@bluehome.net>,
        Ryutaroh Matsumoto <ryutaroh@ict.e.titech.ac.jp>,
        Nathan Chancellor <nathan@kernel.org>,
        Xuefeng Li <lixuefeng@loongson.cn>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 6:58 PM Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>
> After commit 13ceb48bc19c ("MIPS: Loongson2ef: Remove unnecessary
> {as,cc}-option calls"), no need to use "ifdef need-compiler" for
> Kbuild.platforms, because the cause of the build issue mentioned
> in commit 0706f74f719e ("MIPS: fix *-pkg builds for loongson2ef
> platform") has been disappeared, so just remove it.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---


Reviewed-by: Masahiro Yamada <masahiroy@kernel.org>


>  arch/mips/Makefile | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index ace7f03..e036fc0 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -253,9 +253,7 @@ endif
>  #
>  # Board-dependent options and extra files
>  #
> -ifdef need-compiler
>  include $(srctree)/arch/mips/Kbuild.platforms
> -endif
>
>  ifdef CONFIG_PHYSICAL_START
>  load-y                                 = $(CONFIG_PHYSICAL_START)
> --
> 2.1.0
>


-- 
Best Regards
Masahiro Yamada
