Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972394F86E1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234519AbiDGSIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 14:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiDGSI1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 14:08:27 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FC01E461B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 11:06:25 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id x33so4581684lfu.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwNPEn1Qq7uv4RdgWNLzHFqsu4OAjr3KWr5NW8LXZlw=;
        b=FzpY0kFBGfyZZCQEyvL5s8hlHiWUO7GtmY3oyySyBa7MFe0FZFxvXn05WHMYorc2zb
         v4aPp5CV0jEedWRUfQYzSCGK2a64BHmsiBIsPJN6vCGNMFJHqJkE7YgpLUh3BoWdi5b7
         9i2nb43MUYG0cI8r4gwHnsz0cb/4Ijpr6mafQ5IYDo+jw8IiVraq7KAwM4/WlMG1dUam
         xSWO/F/WkBDzucun507eTRzAFB36gXSVKrJJwewAhUHKEN8c7l05aHyLPV2uMrfd8n5A
         mXVV3bzxJ1JqeF9HXfW4iS1QC6nGQ6oaCLpY9r5uQl4xFpxueHhv6bGymiV1i3ObxNfl
         IKyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwNPEn1Qq7uv4RdgWNLzHFqsu4OAjr3KWr5NW8LXZlw=;
        b=5OZFBLevIDyhJ4vTVYjOXmjur4nNV/vxBxjmZwc01XeKRT2zJGbj1wBPrJzyW+C1kQ
         74EeD33lrEZAydHqk3RrjFgM8P43hNySs0srRy+92Vxl4tSLoRMvFYGcu8baE/G0Sw0R
         fGox2+XHW2OQCxDcPoi3CUz1WwcLOigmg/XAGM8SuQ8FFNdl7mj5vqVR/VKTFyCUywDK
         uqvLxHZNP9zsmJBUN8vK+/kiZUvsU9VzWn0pm5ixVsHItK9cN+aPRz4tdZzNmNP2DCue
         LeyefQQtilB8voKwZaxWFi71m2telyXPakTPwZAcXom960+ZvwA6YP0PqRTYEVfmG8Ps
         u/YQ==
X-Gm-Message-State: AOAM531cFk5gqOZlBP1Ps2NW0/F3+B4bov/VRwSsZHBvxWxtOiYNn3IY
        tR5Ocv1dj8g/LzE+7pl23OCQb2wK6Rb1/k0a6gkqSuOf2ZxK6Q==
X-Google-Smtp-Source: ABdhPJyW51VcXmBTIer//X3eyaZpHr3gODmyvuIZNbPifUFQmk8WOkbQf5q1UK6kw1CeuB8/o10K/VAD1kV1uMt2ZyE=
X-Received: by 2002:a05:6512:3092:b0:44a:e7bb:e961 with SMTP id
 z18-20020a056512309200b0044ae7bbe961mr10226923lfd.190.1649354783232; Thu, 07
 Apr 2022 11:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220407175715.3378998-1-trix@redhat.com> <Yk8nV1kBngon+o6N@dev-arch.thelio-3990X>
In-Reply-To: <Yk8nV1kBngon+o6N@dev-arch.thelio-3990X>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 7 Apr 2022 11:06:11 -0700
Message-ID: <CAKwvOd=3nP8_SHXLByX1qUWU424g6y-89LR953396+RQME37Ag@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add self as clang reviewer
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 7, 2022 at 11:03 AM Nathan Chancellor <nathan@kernel.org> wrote:
>
> On Thu, Apr 07, 2022 at 01:57:15PM -0400, Tom Rix wrote:
> > I have been helping with build breaks and
> > other clang things and would like to help
> > with the reviews.
> >
> > Signed-off-by: Tom Rix <trix@redhat.com>
>
> Thanks a lot Tom!
>
> Acked-by: Nathan Chancellor <nathan@kernel.org>
>
> I think we might need to CC Andrew Morton for this, as we do not
> currently pick up patches ourselves.

Yep, Andrew, would you be so kind?
https://lore.kernel.org/llvm/20220407175715.3378998-1-trix@redhat.com/

Welcome aboard, Tom!

Acked-by: Nick Desaulniers <ndesaulniers@google.com>

>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 9ebfc93d8f0d..8da670067a34 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4797,6 +4797,7 @@ F:      .clang-format
> >  CLANG/LLVM BUILD SUPPORT
> >  M:   Nathan Chancellor <nathan@kernel.org>
> >  M:   Nick Desaulniers <ndesaulniers@google.com>
> > +R:   Tom Rix <trix@redhat.com>
> >  L:   llvm@lists.linux.dev
> >  S:   Supported
> >  W:   https://clangbuiltlinux.github.io/
> > --
> > 2.27.0
> >
> >



-- 
Thanks,
~Nick Desaulniers
