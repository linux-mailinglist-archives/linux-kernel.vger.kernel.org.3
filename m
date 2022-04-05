Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99784F23E6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbiDEHEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiDEHEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:04:35 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62DF11C12
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 00:02:37 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k14so10352749pga.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 00:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8VhMjpVUBYebqxLy6TEA2cjKY1vC5urgh/5emBRUq/I=;
        b=MtJSlVzlZz6r6m7J5b/Veav5FPkaS7thzHc24KO8NiZM8O76BxaYUPJZ/urIie3rhV
         /jZEg9PkFCcgo/8RdzQVUu6q+6OrtuehmsIOxt6f9LxBcB4mm/SOlrNWaj1gaKQzfK+V
         lbgCFFgNcLh85uRnC9bBUnbhRbwO6QeuFFgdo/jVqS1LIJtC2qjSU4ocAJE39PIcJkXz
         JZ09ns+XAumqI4NSxJJjf6GqYoFrqBTOEqChrO0b+gdhyulqXSSVD46q1RpfFxXQZu10
         EQgYhngD2GaNZ80dATlh8VdUV7R0eUSg6C2PyNC32rTPVUe8BWZHsDUh2BTlpdF085cV
         zABQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8VhMjpVUBYebqxLy6TEA2cjKY1vC5urgh/5emBRUq/I=;
        b=iu3bgcFDNwkKK7I+qes3YDGlReAGZa1aJtneRPbILnYCAeuij506PheFLmeZ7cPd9A
         VMNxDb2GW9Cj8aqPYaRng44NmC06mx1ccPdbqxiiu7wh1aHSShFjn/LU2u0yyUU4JWqO
         1wnJLMddlSZtKJJ8CA45BCsvALF3yt2atzmuGyMOsQNyIclhcpK+k6VESR1Wg5znolMo
         56odzUU8F+FEKwDsCaFpLIuL1RZWB5nfUZxzvOZL0CmmfYNgMrjhyUtJ3bYasxeW2mDz
         eu5dMGOQcO5jPncXjKEwbl1+snlY84eyyV0LfBsIS8TJXjqahO8DANO65LOAWVNUzikh
         QJbg==
X-Gm-Message-State: AOAM532izLhiiMSAnW7t+NMKInUuVWH4o09KU/Jm8uQ5VePS0CBpqFUl
        pCIsfUpO/tgGJAP4d9CPqJ3d7JdR83+67WJuXc9OhA==
X-Google-Smtp-Source: ABdhPJy9on+cF7e/53OZP0n/2+KbeNKqBwK2+/2sT0br9zmBQO702zJBrvFsswapjsWl2BKh1iSUzATaDk3po+/aHts=
X-Received: by 2002:a63:541f:0:b0:399:3007:e7a2 with SMTP id
 i31-20020a63541f000000b003993007e7a2mr1710334pgb.568.1649142157075; Tue, 05
 Apr 2022 00:02:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220316135047.188122-1-dzm91@hust.edu.cn> <CAHUa44FiumE97drc11vBdr46Zh2uWysk--bn2AZnaw==5bTphA@mail.gmail.com>
 <CAD-N9QU=_M2_=GsQii8R85o46PnsxcLqJGFKA0UANbRWAFnjHQ@mail.gmail.com> <CAD-N9QWB9HGY=DU1gazbt3e8p4GdG-=CJtD26M59AgAhbagusA@mail.gmail.com>
In-Reply-To: <CAD-N9QWB9HGY=DU1gazbt3e8p4GdG-=CJtD26M59AgAhbagusA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Tue, 5 Apr 2022 09:02:26 +0200
Message-ID: <CAHUa44F3ic_Fu-pLsZ2sZeC69TSLwKZjegdkCB-xpm=Zm6J4PA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
To:     Dongliang Mu <mudongliangabcd@gmail.com>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Fri, Apr 1, 2022 at 4:00 AM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Thu, Mar 24, 2022 at 5:33 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
> >
> > On Thu, Mar 24, 2022 at 4:29 PM Jens Wiklander
> > <jens.wiklander@linaro.org> wrote:
> > >
> > > On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> > > >
> > > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > > >
> > > > The error handling code of optee_ffa_probe misses the mutex_destroy of
> > > > ffa.mutex when mutext_init succeeds.
> > > >
> > > > Fix this by adding mutex_destory of ffa.mutex at the error handling part
> > > >
> > > > Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
> > >
> > > I believe this should be
> > > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > > don't you agree?
> >
> > Hi Jen,
> >
> > This commit 4615e5a34b95 is more suitable since mutex_init is introduced here.
> >
> > Why did I label the commit aceeafefff73?
> >
> > Because this commit tried to fix the issue, but only added one
> > mutex_destroy for &optee->call_queue.mutex, misses &optee->ffa.mutex.
> >
>
> ping?

I'm picking up this.

Thanks,
Jens
