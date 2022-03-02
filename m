Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B22E4CB2D1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 00:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiCBXqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 18:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiCBXqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 18:46:06 -0500
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966D24EF54;
        Wed,  2 Mar 2022 15:43:57 -0800 (PST)
Received: by mail-oi1-x22b.google.com with SMTP id p15so3299065oip.3;
        Wed, 02 Mar 2022 15:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lp3igCTBUuzlbWnkmK/gfxOOr4818cn0YOZlkpHeS+Y=;
        b=Vyo3B7vRjlNFrwo7KK5xiCzmwAwgIeI+e6v3ufQAUXsoASn7b969YNcvCcuHiPea2I
         YzFEwcOXeQBM+zdx0YKGj/JH8ti7+Vs+Kjid3MQcyAMeGZb5Lfoh1oXcOoJMwqfJx4rK
         dnag0LkQhg7Hr/3NsJJagy9JkpZw1E7UDlPUr78P5YpeubzK/lv4uT27mgpJXCVpV6NW
         sWU0oj8795lkxGzRCXDeA6vbp/+413Smrlt5Edf7ciI6ut74AhfP5dua3VMezb7mfOMU
         kS00SwNL1Vnp5v3Hro5skR7n0xjoPMUoBjKWTwz0j9Kd/sSZJkxfiROEw4lZOtwnJo/W
         pgVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lp3igCTBUuzlbWnkmK/gfxOOr4818cn0YOZlkpHeS+Y=;
        b=7FyZXGum2T/cJa5pGGQJ9LPEQenmmSMAQzaPBrYxo5t7Nr5si8Dm2Zx/Ejp/P4zrcK
         lZ3xI7Ejr9uB/pS78Nwd2oAqQ++cTgh0Ozmrtk9HDhl/WV9bmyA2T8xWJABM/Ja9iWox
         5QihIdXKvsbbEbQrgSy8kGiJlez4lXK6GcL+Zmjh9b5eeH1LIAwZ7knRnURMquyDP2Y+
         sjC+OhunIRXK415R1VsDLh1v+M1V+ujyOrVGnQK4n1sS8Z5bCqVMTz2+7nQf5HlfjpFA
         muhAbJWrUrWjgnFCJuu0GSXdkvrS8hPT2Pdw48DRLE6y7y6eZHfuoNPahFN4dCSO9LHp
         pqIw==
X-Gm-Message-State: AOAM531DTBOdAwwCxPK++hRopJWTYVnJgS9yVZtVrn9EAw3nHlM7PMlS
        yPtorFNTDdNqWe389tVKeLOP+UvD4+0eBcc3Roo=
X-Google-Smtp-Source: ABdhPJzbX9RgtlE7iKrIsuSOmMNrhk6U1PLpHkbJ75YlDSAlitrKKmBHBsXT/m5122I+aCzffWcKZKxZUXkdSGaNGo4=
X-Received: by 2002:a05:6808:3091:b0:2d4:c180:d586 with SMTP id
 bl17-20020a056808309100b002d4c180d586mr2139157oib.120.1646264632489; Wed, 02
 Mar 2022 15:43:52 -0800 (PST)
MIME-Version: 1.0
References: <20220303075733.481987a8@canb.auug.org.au> <4804f1e7-8a25-ad8c-dd63-589ed34260c6@amd.com>
In-Reply-To: <4804f1e7-8a25-ad8c-dd63-589ed34260c6@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 2 Mar 2022 18:43:41 -0500
Message-ID: <CADnq5_PEobgWeJu8jipJx0gxSiiDiKLp372+5GLvTqncdG6zHA@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the amdgpu tree
To:     Luben Tuikov <luben.tuikov@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 2, 2022 at 5:11 PM Luben Tuikov <luben.tuikov@amd.com> wrote:
>
> In our local branch it is:
>
>     60862e45da3b5a drm/amd/display: Don't fill up the logs
>     ...
>     Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")
>
> Which exists:
>
>     5898243ba7acdb drm/amd/display: Add dsc pre-validation in atomic check
>
> So maybe something happened in merging, etc.

That's the commit in our development branch, but that doesn't directly
correspond to the -next branch.  I've fixed it up and pushed a new
-next branch.

Alex

>
> Regards,
> Luben
>
> On 2022-03-02 15:57, Stephen Rothwell wrote:
> > Hi all,
> >
> > In commit
> >
> >   d15628d483a5 ("drm/amd/display: Don't fill up the logs")
> >
> > Fixes tag
> >
> >   Fixes: 5898243ba7acdb ("drm/amd/display: Add dsc pre-validation in atomic check")
> >
> > has these problem(s):
> >
> >   - Target SHA1 does not exist
> >
> > Maybe you meant
> >
> > Fixes: 17ce8a6907f7 ("drm/amd/display: Add dsc pre-validation in atomic check")
> >
>
> Regards,
> --
> Luben
