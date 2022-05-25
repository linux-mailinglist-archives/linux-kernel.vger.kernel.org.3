Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2284B533742
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiEYHTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 03:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242567AbiEYHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 03:19:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F310D9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:19:38 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id t25so34573427lfg.7
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 00:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHwxHU6ohZboKQ4tTTi2xgOgbmCm0LjSeLzBUr3hoGA=;
        b=L7lVCeMe3p/g4n/hgblXnnbwOXFfu+y8u4bUyIUTInEsZx17coE20KOJa0S0TKNlvo
         1Btf8L6Y3RUgzle3tVnGu4wvapinFyttJxn7YZDkHc9hkS7RPOPA/Sl7WEpSrclfAbx5
         5kxGVhLWq32kqryLvBq656p7Q1NJdFMZSosQYFsDzQBH9rjLWvrJdI3ovs7LV9SXAgrN
         dv16hFG3mJmrwBlLHEyixAIvqSGfP0YhhmNq24NEQPz//YLc8MhJfAPII1+Mb+vZaW1B
         SbUhp+KdWi/BNYT/KgOZFoqouNTRKw1Ci6YhQ/sb/M2w3srPECHZY3Ao7n3giMuoRIcz
         6ydw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHwxHU6ohZboKQ4tTTi2xgOgbmCm0LjSeLzBUr3hoGA=;
        b=bli4LlaI1mg/WHm66I78TR6ck/e2sDpWynE3g83WtKeIcL8wJc6pIrs755bulPIvdT
         SzY3rafMFSwkxZh+NzgvbAuhjd2HUCqI3W9/EQPbuVsTgdXJMgreJ0JoeCXw3r5Ue2UP
         b66QSi+xGXGCIoTWuzbB4TrqQhis4sj/iYa1efGZmzjiJ8yo+pWBAaF9p+K5Ls+MqANt
         4aGsnbs79kGyzsJM7zgzdOWOFix9OaJUJ4aP0kd+8G/SHZ/vzqU8Nc6pJm9241zwELg5
         BLeQP0m0epMIU0XMwCia5BNxhrbdhoWYNDdGxOos9yyYv5/pgfbiACmzTX2BBRcRQ0oR
         nsCg==
X-Gm-Message-State: AOAM532JYv98FF9L5sM18Di6x+Vb2pFPYdTv6WmKERy8Tn9gYygOre6K
        QmkWhqfHxaHCws0dXuLeySSLzspKzT3AXQsSQxnb2w==
X-Google-Smtp-Source: ABdhPJxISQ8H5RJ9yLfk/SlIOV+DAgzABJEoDwUn1ekltq5e5YuWu9xVvURmPcchSsZpCeaFLlOxmSBkZnsSoQetUdA=
X-Received: by 2002:a05:6512:70b:b0:477:a832:7d07 with SMTP id
 b11-20020a056512070b00b00477a8327d07mr21941717lfs.71.1653463177262; Wed, 25
 May 2022 00:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220523121836.27442-1-ulf.hansson@linaro.org> <CAHk-=wiYh33UCe_sKvLWYY-ptPL6=T4m60b8vCX_t=qvmmOWWg@mail.gmail.com>
In-Reply-To: <CAHk-=wiYh33UCe_sKvLWYY-ptPL6=T4m60b8vCX_t=qvmmOWWg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 25 May 2022 09:18:59 +0200
Message-ID: <CAPDyKFreHmOuJ8MLmumTjs-52JxBydtQ3q3SMPCUtMKx89x8wQ@mail.gmail.com>
Subject: Re: [GIT PULL] MMC updates for v5.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 at 00:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, May 23, 2022 at 5:18 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/ulfh/mmc.git tags/mmc-v5.19
>
> Please stop doing the horrible undocumented merges.
>
> You have three merge commits that have *no* documentation. They say
> "Merge branch 'fixes' into next", and that's it.

My bad, I have simply forgotten about them lately. Earlier I was more
often doing a re-base of my next branch against some later rc, which
makes the merges to disappear from the history.

>
> If you can't be bothered to explain why and what a merge does, then
> just don't do it.
>
> It really is that simple.
>
> I've pulled this, but I really want to stop seeing bad merges.

Thanks, I will make sure this doesn't happen again, sorry for the inconvenience.

>
>                     Linus

Kind regards
Uffe
