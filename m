Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03075488C50
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 21:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiAIUiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 15:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiAIUix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 15:38:53 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF23DC06173F;
        Sun,  9 Jan 2022 12:38:52 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id w22so4439053iov.3;
        Sun, 09 Jan 2022 12:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aUgjMWnA1IN7R+ANpNtaHO4QvxMEdQHiPYa1/JTQhjM=;
        b=IwV3q9ht1h2hBcaQmOAGKqpqBhTcCCXyIV9yGk7wcXIyMKiPUDzbFTsloct6a608iR
         JwEhWGPWQyYIvz3dcbJO7AIE114EUL61a23I058gP2Tm5lO3NWTtHx6biP+puIUIStpi
         6Zy5qMHlhbr3FipO4iGWS4diSOY71GJI5BzISFYPjulmk25JXaiaLRUyr0e6nR4Wp0Th
         wzztMQpVLgn9Tcmpp4r5hjg09IxGH/z43e1h7+236Gb5T+n2a3bNftxge/SvUXeqe0ui
         BcoeLCqdn1hGI4Xv1YFBW3R8GG5y/v/abRkRj2wCTAVz0aKW2bJFkbseWwEQPaRTkiYA
         6X7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aUgjMWnA1IN7R+ANpNtaHO4QvxMEdQHiPYa1/JTQhjM=;
        b=uQXuz58OvV6r7tCm4E4FH4nNv7XFd38vhhLphQclP3ik8ndVdXxxG3lmCGxlJCb7Qh
         MjvpGIe8ksqQV0LFiLjtP9pkmFaJlLbuug00rcLMrjpJD8jSGuElaiF2D4QFj/32uVXO
         sVDaA2xIK8kc+Kho7UkFijSVktuLwEKY4p3B+3UhE1EPjBYSTYX4hMatKcIfEVEAPPba
         fzeYKlvpWE9omzy7VpmAdLxxXLtlXjMWqgUo/ZG3OgVLXtZEO7XyW6JhzU3PC0EOhW2T
         CaBW3Jp6HQR5PEft7hBgYtKeejrezHLgV/wQ5r7P5jfs4dG2VYJMC7Ow+eyZYC8K/+F5
         m2QQ==
X-Gm-Message-State: AOAM53085FFVEKUHdCP1uNnqnm2iHwH+ucQC5XhAABeC9xuJAQlWc3TW
        o3jSu14cmUz2PrYgp6qXTQi8qgVYFoEw7bK2QuQ=
X-Google-Smtp-Source: ABdhPJwXGNlIUiI8Ot7yHO5wT2K+zq/wsRQ/6JpZQUWK1OY7zqxDusKkMDHQL6lbCyw5EPAOXo18XwDRxpq+43oh7dc=
X-Received: by 2002:a5d:9ec2:: with SMTP id a2mr35621393ioe.44.1641760732400;
 Sun, 09 Jan 2022 12:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20220106123357.16220-1-sj@kernel.org>
In-Reply-To: <20220106123357.16220-1-sj@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Jan 2022 21:38:40 +0100
Message-ID: <CANiq72muzMPVUNJQU7Vcx0uCSEZc7Y_67LuX7PB=xNkCJ+NX7A@mail.gmail.com>
Subject: Re: [PATCH] init/Kconfig: Specify the interpreter for rust-version.sh
To:     SeongJae Park <sj@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 1:34 PM SeongJae Park <sj@kernel.org> wrote:
>
> Some common tools like 'diff' don't support permissions of the files.
> Due to that, 'rust-version.sh' in some trees including '-mm' result in
> having no execution permission, and therefore build fails like below:

Do you mean the Quilt workflow? From a quick look:

https://lists.nongnu.org/archive/html/quilt-dev/2008-01/msg00000.html
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=749069

Is that the issue? I am surprised it loses that information...

> It's not a big deal, but not so fun.  This commit fixes the issue by
> specifying the interpreter for 'rust-version.sh' in the Kconfig file.

Other script calls do not do that, so I would prefer to avoid it. But
I can take it temporarily to help you (until we are in mainline, if I
understand correctly the issue), but I would prefer to have a comment
nearby it justifying the workaround and explaining when we can remove
it.

Cheers,
Miguel
