Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBD7589002
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 18:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237903AbiHCQGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 12:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiHCQGe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 12:06:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068891A83F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 09:06:34 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w3so6409243edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Aug 2022 09:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5szB0Yt8wfbiTaP8/uH11/lZ59NOlpGeFsdpgoLNvJ8=;
        b=ic+vNPABuREX+PIjwaM+VOGEJw6oF2ebKuLtvGvb4/Hb7YaZRdZFas4fPAdzbAg7jx
         aesjy+76DTWh4E6VOx93inA8iC/941RMQo8fsSmtWm07+lOlWWxdSUMOghm1jrWvVoR4
         U/LivSCQiuMwcebAF9+j1uTdx7DTBfUBhs5nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5szB0Yt8wfbiTaP8/uH11/lZ59NOlpGeFsdpgoLNvJ8=;
        b=pexTTRVzRaMO7v8lZ7aq1/o/OsZKFkH0JUSzfvaPch+KJcY5rXXMZDCnlCXOq30j8F
         I2PFpNtytYAgG3FCb0Ym2nCoPUhDuKzqUmaPBUZP4/5UwAWobhtCLMeyPOqMnYAr5ux4
         tm2+T3E7DY45gjljdjkguVYdYI89RweFAl6VsScffvpWKxNpSDBjNIXQTwqwehRMj1BI
         FC8A/DS+ATn2SS9t9L5bQ2NXGQHc013+2A5B7Dk545zazAXzwS0SYXEa9D/q3XXx0XmT
         v9C5Mt/D0HNblgPGleaNMavh3Esif0u4qDsGfrh6ayk1MMipmXld+FgJiUSvWetjO7oU
         WOGw==
X-Gm-Message-State: AJIora/7sgaaLm9MsfKA7EmxhNOwZpqn1PLPVAgBSfvV4q034mYl+8oi
        uiBLdxTegocI8KmRsoQ7suDjb5DKknms+BlR2wcfRQ==
X-Google-Smtp-Source: AGRyM1tY9355tF5SR98IYTJw6jtydsojrQZtfOZY+tbbLicCH00rJyvlJeK55pfPj3vsy9eOthOXBZnjsNPgYb7wPm8=
X-Received: by 2002:aa7:d813:0:b0:43c:dedd:b4e8 with SMTP id
 v19-20020aa7d813000000b0043cdeddb4e8mr26254900edq.231.1659542792573; Wed, 03
 Aug 2022 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-EccPH46FGKQj8gYEg5HGpmmRiqzrZouTZauwpvX-+2j4GNA@mail.gmail.com>
 <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
In-Reply-To: <CAHk-=wim4B671BOPfxoXDSz0xfOruqoKCMQrjAX0R95PH5Wy4g@mail.gmail.com>
From:   Micah Morton <mortonm@chromium.org>
Date:   Wed, 3 Aug 2022 09:08:22 -0700
Message-ID: <CAJ-EccOP4Yq4RSBSkA_71kagqvA=a+tUV63UbHWZVM2uqJMDFQ@mail.gmail.com>
Subject: Re: [GIT PULL] SafeSetID changes for v6.0
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 2, 2022 at 3:20 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Aug 1, 2022 at 7:40 PM Micah Morton <mortonm@chromium.org> wrote:
> >
> > This pull request contains one commit that touches common kernel code,
> >
> > one that adds functionality internal to the SafeSetID LSM code, and a
> >
> > few other commits that only modify the SafeSetID LSM selftest.
> [...]
>
> What odd MUA do you use that causes this double-spaced text email?
>
> I can read it, but it really is a bit strange. It was all plain text,
> and marked as utf-8, and otherwise looked normal except for that
> double spacing.
>
> I get flashbacks to my "writing papers at university" days.

I know, it was ugly. I just switched laptops to a Mac and thought for
sure the mail message preview I was seeing in gmail after copy+paste
from a terminal window was just some weird scaling issue on my
external monitor or something. Sure enough the message was sent off
looking like a double spaced book report from 8th grade :)

I'll have to find what's going wrong with the copy+paste to gmail on
this particular device.

>
>              Linus
