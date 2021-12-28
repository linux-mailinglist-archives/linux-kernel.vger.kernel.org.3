Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CC2480CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 20:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbhL1Tjf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 14:39:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233989AbhL1Tjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 14:39:33 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3C7C06173E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 11:39:33 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id q8so16552776ljp.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 11:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f0mf13mpCBlZzVJGnXhAHxuRbWYoDDVS32f5pj7vN0A=;
        b=NOqtUUNb0Ay9ZDi/Z2gbVJ3uAn90VZVg/2nxn+gh0ZjiH+M1XGeYetsVSY/oYgfycG
         gL2V0fwD//H4jrmGFiXaN3FXFpZfh6P5JnRTmHj+tWTRd2hzAgBkPwSggyyvNPybLqHt
         gcgsepuZHwp5sfdqq+PX7/RU4xKJA5zwJBXFS+Vt2dmAoB/gx6qje2/DexrWzT/aVPS9
         hYwZuVGUWoUN3QCre2tBak5QCARbUZN8Hr+YBrNPeljri+gO/w9fRRNGtDyc6Thk5KRG
         zCogpWRtoFQs1uy2CNjnpS+5Slprxgm/7Yrb+jJ3niDDc7/dgXcGKov+09sRTl3tj2Df
         tB+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f0mf13mpCBlZzVJGnXhAHxuRbWYoDDVS32f5pj7vN0A=;
        b=2RP+2PcXdTiQTowghgHxJJpCI6JWg2ZSMVEW9tptlhJRVoCzHUPfQuaSUj2mW/W+HQ
         7rJmvzgt1/Yk+2fWSXzP1MJyZSwn5WIzfPjh7pPE7WlKSxRXFaN9RqMva/XrTp+q/FNV
         7fOlOdGOKCLAsHjvRFgpz0Sdoj4oO7/Gmm1H7AncAetl6jepJKQMx/c/v39dFEdLe/ra
         CPfxnydGYyRLdcFerUM5RTbSuFt2TxWgDJRRRvsKz/toAqjZAOW0PiU/PDSoECGjt0gH
         VN48CTtzG3bjekkSwHLy5Dn7BYkqHXAA/N5FYRK5Sc54D90WbNbGUVV6HC04SJzrXjxb
         OI+g==
X-Gm-Message-State: AOAM530l5ozdC106WNa5uSO9/WsTuVA4iIce4oD+JldkDPynlTM7s+Hr
        2mAZ1rdmIRGgRnBaHrY87CyTscySng+5iaUYHtNVSQ==
X-Google-Smtp-Source: ABdhPJx+VVRO76ys/tIXGD/kV/guqr/qkVIP+OsygHJJ0/H8ZCt+8RRrtrlLGV6LNV8cf0C8GnXFuXG8Ig7IABu13IY=
X-Received: by 2002:a2e:7c0b:: with SMTP id x11mr14607183ljc.198.1640720371126;
 Tue, 28 Dec 2021 11:39:31 -0800 (PST)
MIME-Version: 1.0
References: <20211227131041.4668-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20211227131041.4668-1-lukas.bulwahn@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Dec 2021 11:39:19 -0800
Message-ID: <CAKwvOdk68xzVVCCGgdEDj3fSD9nwgh8=7zi6QGa-hhxweRibYQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] taskstats: remove unneeded dead assignment
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Balbir Singh <bsingharora@gmail.com>, Tom Rix <trix@redhat.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux@googlegroups.com,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 5:10 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> make clang-analyzer on x86_64 defconfig caught my attention with:
>
>   kernel/taskstats.c:120:2: warning: Value stored to 'rc' is never read \
>   [clang-analyzer-deadcode.DeadStores]
>           rc = 0;
>           ^
>
> Commit d94a041519f3 ("taskstats: free skb, avoid returns in
> send_cpu_listeners") made send_cpu_listeners() not return a value and
> hence, the rc variable remained only to be used within the loop where
> it is always assigned before read and it does not need any other
> initialisation.
>
> So, simply remove this unneeded dead initializing assignment.
>
> As compilers will detect this unneeded assignment and optimize this anyway,
> the resulting object code is identical before and after this change.
>
> No functional change. No change to object code.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

I was going to ask "what happens when the list is empty?" but `rc` is
only used in a loop where that's not the case. Thanks for the patch!

It looks like
commit d94a041519f3 ("[PATCH] taskstats: free skb, avoid returns in
send_cpu_listeners")
from v2.6.18-rc4
is what changed send_cpu_listeners not to use rc outside of the loop.

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
> applies cleanly on current master and next-20201105
> Resend: still applies cleanly on next-20211224
>
> Balbir, please pick this minor non-urgent clean-up patch.
>
>  kernel/taskstats.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/kernel/taskstats.c b/kernel/taskstats.c
> index a2802b6ff4bb..bd18a7bf5276 100644
> --- a/kernel/taskstats.c
> +++ b/kernel/taskstats.c
> @@ -117,7 +117,6 @@ static void send_cpu_listeners(struct sk_buff *skb,
>
>         genlmsg_end(skb, reply);
>
> -       rc = 0;
>         down_read(&listeners->sem);
>         list_for_each_entry(s, &listeners->list, list) {
>                 skb_next = NULL;
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
