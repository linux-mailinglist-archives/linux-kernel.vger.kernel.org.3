Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC97748AB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 11:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237594AbiAKKTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 05:19:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiAKKTC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 05:19:02 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBFAC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:19:01 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id g14so17270500ybs.8
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 02:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4MctOA2Fm45weLHb7UnqfJRB+R0oIlHoPeifU3MCFnI=;
        b=Pfdwu4JNaOv7nrBOLQvJYYfIMvvyd/DWU6LUc19RoNi9kJwWcc63V5nW+tBqBErtkz
         nv4arxyRIrcA97AuJ36Um9Zww+GgLQsPoedHz9vaCS1PMRBbpbF69iKbTa9fHS34tf9o
         jA4IZ6kAYBBUlh5vZU78ovuEus4JDU2f3RGbR64wEXvtWL4Tt5yjyjtG+31BB5fS2xw2
         2yN1aUsFPMD1w4X1xVbYtjzu9tIZmmpJu/yQ37ryjRxv3vex4M/0nqBPApjsNSuojAfJ
         oBawXLSXrbwLkvX4wZPe9nvDpYBlY5ADsUK3A+LnRhh+8nB2tCdOE3xyUIfgZowvBn4J
         DXhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4MctOA2Fm45weLHb7UnqfJRB+R0oIlHoPeifU3MCFnI=;
        b=aBE3ZND1d7+gaztAkXZs3UfowhYWoM26zNnyZcUQXmZzTBV5awHQUdKyG6/zalnknE
         zFYaUsR3hTXmM3kI/GaHVlFw2AMK2RLD2sLCS/mystiVKUlx1gRzVUbXymn0VNl7JxRz
         OZzzaFbOuVhSAZolpgd2Ni9SZL46oyrfZQPB5dYIEiZ5AJceH66zAbejuO8JDpDhSh/T
         dT1Fa8tua8Qr+tNZzWWMPX8uYdw1wf5HY2B7MTRUXNpncFjE2Vo1m+fNBRfAUqIw0wou
         Sxi9SK/ewbMuzH1neNz/z92m8pwakrTIUNSyKiuDRkHbm0DvHPdn9s5+YE69RLU5urla
         VOmA==
X-Gm-Message-State: AOAM532RtU1p2ktpwwaQjQ0CY70XNBzpd5kQXob6pZ50tXNY3/5q9rZI
        KgvZkifHGXwToxcHV9a0ALhEeHAdzhHoR39ncWc=
X-Google-Smtp-Source: ABdhPJyOVB+nHHrug4G82WGlXrxd1R5lvByq/Hhvba44/fu0EE8KUkCke9Kh5AKUQ/xdHHPp+YTGhyHV4Xe79eiNEwE=
X-Received: by 2002:a25:fc4:: with SMTP id 187mr5049535ybp.608.1641896340029;
 Tue, 11 Jan 2022 02:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20220110200529.18601-1-dafna.hirschfeld@collabora.com>
In-Reply-To: <20220110200529.18601-1-dafna.hirschfeld@collabora.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Tue, 11 Jan 2022 11:18:55 +0100
Message-ID: <CAKXUXMyepnLO=jLPciG5mWvTxbQGR+1PaeYs1_c+-t3hFAEhNg@mail.gmail.com>
Subject: Re: [PATCH] checkpatch: warn for p0 patch only if prefix is not b
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dafna,

On Mon, Jan 10, 2022 at 9:06 PM Dafna Hirschfeld
<dafna.hirschfeld@collabora.com> wrote:
>
> It might be that file 'b' happens to exit. In that
> case, if the prefix is also 'b' (which is the
> common case) we get the falsely warning:
>
> patch prefix 'b' exists, appears to be a -p0 patch
>
> So warn only if prefix is not 'b'
>

The checkpatch script that is maintained here is really only intended
for its use in the kernel development. You may use checkpatch anywhere
else, but any changes that increase complexity for those other use
cases is really difficult to argue for inclusion in the kernel
repository. The checkpatch script currently is already large and
complex enough and all rules need to be understood as rough
heuristics, not as strict rules.

So, can you point to a kernel repository where there is actually a
file 'b' included? On a quick scan, I could not find a file 'b' in the
current trees of the repositories on my machine.

I am just letting you know about what I have observed; I do not decide
on the inclusion of this patch, though.

Lukas

> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 1784921c645d..72263b142e39 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2821,7 +2821,7 @@ sub process {
>                         $in_commit_log = 0;
>
>                         $p1_prefix = $1;
> -                       if (!$file && $tree && $p1_prefix ne '' &&
> +                       if (!$file && $tree && $p1_prefix ne '' && $p1_prefix ne 'b' &&
>                             -e "$root/$p1_prefix") {
>                                 WARN("PATCH_PREFIX",
>                                      "patch prefix '$p1_prefix' exists, appears to be a -p0 patch\n");

> --
> 2.17.1
>
