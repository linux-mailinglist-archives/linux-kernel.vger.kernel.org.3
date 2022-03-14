Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22A14D8F96
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 23:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245636AbiCNWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238535AbiCNWb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 18:31:58 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE03E5D3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:30:48 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2e57826a10bso23705947b3.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 15:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=h5JL0iMAknmQ5zErn6+wiD/umMBaFUOjyvtYnP2xprY=;
        b=jQ/m0lOugL+8gJgFqx0d3h9CrFThHj9SSAeaK26F10uhuhpm/IaylQbEWCgs9aEwMg
         xHtSL+1zpiDRTCvz7Cn5aRvjgCITWk3mUrrQ84T450bxekrPtSojJ9NqGFIOniFofeCW
         oigDE3fy/qz233g6GgO9rDuDR/i0uAMFfOZrQ5R1xDxmeTdrthehy3vy8Rniy1PJX66s
         sbvlACcvZ5v4uSyG9yTP4oI5H64SWKa3tAumzPpzAiHIMcKhCCd6Tu/h57yjjsGaes+5
         GEUvw4LRuQrph0IrOwbuL+O9N2aaye8CspgHa/kLVu8XIDkpK3dDCJdTBkEgTUNO5MyA
         5pUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=h5JL0iMAknmQ5zErn6+wiD/umMBaFUOjyvtYnP2xprY=;
        b=6SL8OlunltdZiJN/J8zYoOssNNM7jnhMN8E5SCk5udt5cK0MY0ZLLwOnHq+9kMjcCL
         j5G9NoTuM0TixOFuuv6luMShD/8/4daqwVMz/xTqebM0ix4rXsyMpl/TJdCdIkvnrrlr
         uCLERiLQKxZl0b0Klj4suTCAwXgFwnqAizhO/a/llRmr3aVaZFGbH/jAyc0K2927M+mP
         CxjMI4S5zK8buiYxzg2rxwprJFf5Wjc/vcHcm5cS1K9Xtqj+PezCHO1hThumVSYNZ9uQ
         UdwJjMcwQEMNoXrC+R99I5cppvZGeLJ+wu4FG2KBOLmWV8iG7d3iVbohPSTQbUlpA3Co
         zKTA==
X-Gm-Message-State: AOAM530pJsCIph1aJgRCetnsNV6PoWHLB+e2iqnyQDpLA/NUKfSmpn1c
        2g9DpUJQ6v0+lnzsJvFFk/PDUQr6IX3cg5ym5XR4Aw==
X-Google-Smtp-Source: ABdhPJwzLCJfSZjx5/TBItvwJKrtoDNANlPaUefy9IZu2+RM17VvYmhwaNKSXJWDCzbo9iV3+Var2lcUHXH4XaXX0Pc=
X-Received: by 2002:a81:b49:0:b0:2db:f472:dfca with SMTP id
 70-20020a810b49000000b002dbf472dfcamr20504701ywl.455.1647297046635; Mon, 14
 Mar 2022 15:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220314221703.30910-1-dmueller@suse.de>
In-Reply-To: <20220314221703.30910-1-dmueller@suse.de>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 14 Mar 2022 15:30:10 -0700
Message-ID: <CAGETcx_6BGXFfF1ZHH_=Gq1vp8quFzyLNSCjtfTakJfQE-7Nyw@mail.gmail.com>
Subject: Re: [PATCH] scripts/dev-needs: depend on bash in shebang
To:     =?UTF-8?B?RGlyayBNw7xsbGVy?= <dmueller@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding LKML

On Mon, Mar 14, 2022 at 3:17 PM Dirk M=C3=BCller <dmueller@suse.de> wrote:
>
> This script uses bash specific syntax. make it more specific by
> declaring it to be used via bash rather than /bin/sh which could
> be non-bash.
>
> Signed-off-by: Dirk M=C3=BCller <dmueller@suse.de>

Technically this is targeted towards toybox because that's what I deal
with everyday while I work on Android devices. But toybox seems to
follow bash conventions. Would this shebang be considered valid in
that instance?

Btw, I've been meaning to add (for more than year) the following to
the top of the script:
shopt -s expand_aliases

Geert pointed out that the script doesn't work with some setups
because this flag isn't default enabled. I also remember this being a
deprecated option, but until someone wants to rewrite this script in a
way that it'll work on toybox (this is what Android uses) with zero
setup and also not depend on the aliases, we might as well set the
flag to match with reality.

Wanna pull that shopt into your patch?

-Saravana

> ---
>  scripts/dev-needs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
> index 454cc304fb44..c324f0737f6b 100755
> --- a/scripts/dev-needs.sh
> +++ b/scripts/dev-needs.sh
> @@ -1,4 +1,4 @@
> -#! /bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2020, Google LLC. All rights reserved.
>  # Author: Saravana Kannan <saravanak@google.com>
> --
> 2.35.1
>

On Mon, Mar 14, 2022 at 3:17 PM Dirk M=C3=BCller <dmueller@suse.de> wrote:
>
> This script uses bash specific syntax. make it more specific by
> declaring it to be used via bash rather than /bin/sh which could
> be non-bash.
>
> Signed-off-by: Dirk M=C3=BCller <dmueller@suse.de>
> ---
>  scripts/dev-needs.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/scripts/dev-needs.sh b/scripts/dev-needs.sh
> index 454cc304fb44..c324f0737f6b 100755
> --- a/scripts/dev-needs.sh
> +++ b/scripts/dev-needs.sh
> @@ -1,4 +1,4 @@
> -#! /bin/sh
> +#!/bin/bash
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2020, Google LLC. All rights reserved.
>  # Author: Saravana Kannan <saravanak@google.com>
> --
> 2.35.1
>
