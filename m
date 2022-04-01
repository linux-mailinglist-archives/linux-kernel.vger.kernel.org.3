Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E024EE5DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243913AbiDACCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiDACCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:02:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514751A6E68
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:00:44 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id r23so1375846edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hNRvmRxRt7nKkMkW5WxVDCU1Iy6gNw03vGAy8sCh0g0=;
        b=q6NNPzOLkXZoGfXiZdO6mALYkbFbSKmWy7A/tlX6Ss2tLm8FmRZ8T71Q/8D3NeX97/
         hPUgZhJhXFhu0gQd8NtmHv15QqJFEdkFHn/jlBcOXNQE9qpi7voVdSP7yGofeQEt1b54
         ztud9MOJqhvE0WBgfJ2Nx5WfghihikU4K7OZaS7TJfHaYggeDA91Ntzas5EODulNCD7K
         nwMwrH/3On7bY8q6UQCsEEEOvRkUAd7YU429FvG/v+6C8CTNjygjx/Kr8+PZGJLJiXxv
         D0V2g144e1V6ldVXWxgCQHCB4J/ivuKw9yqwG0M2kg2fHpzkGy6iuP0hFa+Iqdy9eTay
         7nZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hNRvmRxRt7nKkMkW5WxVDCU1Iy6gNw03vGAy8sCh0g0=;
        b=vVggSF2CYQUnIV1unJRyuxs6FtRP7y6bTzCoE2cdBV18zCShBGVm7UaiOWChkpNyO9
         1pkYOWQhbNoc2J4qfOPE71rSCInSz37ECcJgNhPZ5JmOvxeiC9ftxq1eYk0s2Pfn2+J2
         jTKZWnzWwh88wNPxt6O3JjNtTnDKnQMpG3ovR2BDKJUT2RXNTURxAZvmI3t+H7zxRZk5
         ct3nso8uS58Wivc1stPTH3vezfs6PJWA6oinAv5hO96+1LLVsOW4F6P/GO6Xi5P1nguw
         VULl5SRTwaWrDXElJYBaWHU7q55oHZ+OFBJRlV20T1rqEDLVL1X5jOQvd5jCJKcACKP+
         4oYQ==
X-Gm-Message-State: AOAM532ZpFwE7YfCcZ5HjeC0L+6AR35qqAPWlkfKlSTzWBbv40RK3897
        nbyMaLhTZgafwcEZevNjDs9XPBWwv+tAzcVVzSM=
X-Google-Smtp-Source: ABdhPJz6SbZ2JP++j7i1h9VR9R6xNzNBB/VbD5rE7Bch3cokupLLnU+lmRSu3tF7qoUdQXORvWkmU99jmdhFflmeEkY=
X-Received: by 2002:a05:6402:2788:b0:41b:c871:715b with SMTP id
 b8-20020a056402278800b0041bc871715bmr3590672ede.53.1648778442797; Thu, 31 Mar
 2022 19:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220316135047.188122-1-dzm91@hust.edu.cn> <CAHUa44FiumE97drc11vBdr46Zh2uWysk--bn2AZnaw==5bTphA@mail.gmail.com>
 <CAD-N9QU=_M2_=GsQii8R85o46PnsxcLqJGFKA0UANbRWAFnjHQ@mail.gmail.com>
In-Reply-To: <CAD-N9QU=_M2_=GsQii8R85o46PnsxcLqJGFKA0UANbRWAFnjHQ@mail.gmail.com>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Fri, 1 Apr 2022 10:00:16 +0800
Message-ID: <CAD-N9QWB9HGY=DU1gazbt3e8p4GdG-=CJtD26M59AgAhbagusA@mail.gmail.com>
Subject: Re: [PATCH] tee: optee: add missing mutext_destroy in optee_ffa_probe
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     Dongliang Mu <dzm91@hust.edu.cn>,
        Sumit Garg <sumit.garg@linaro.org>,
        op-tee@lists.trustedfirmware.org,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Mar 24, 2022 at 5:33 PM Dongliang Mu <mudongliangabcd@gmail.com> wrote:
>
> On Thu, Mar 24, 2022 at 4:29 PM Jens Wiklander
> <jens.wiklander@linaro.org> wrote:
> >
> > On Wed, Mar 16, 2022 at 2:51 PM Dongliang Mu <dzm91@hust.edu.cn> wrote:
> > >
> > > From: Dongliang Mu <mudongliangabcd@gmail.com>
> > >
> > > The error handling code of optee_ffa_probe misses the mutex_destroy of
> > > ffa.mutex when mutext_init succeeds.
> > >
> > > Fix this by adding mutex_destory of ffa.mutex at the error handling part
> > >
> > > Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
> >
> > I believe this should be
> > Fixes: 4615e5a34b95 ("optee: add FF-A support")
> > don't you agree?
>
> Hi Jen,
>
> This commit 4615e5a34b95 is more suitable since mutex_init is introduced here.
>
> Why did I label the commit aceeafefff73?
>
> Because this commit tried to fix the issue, but only added one
> mutex_destroy for &optee->call_queue.mutex, misses &optee->ffa.mutex.
>

ping?

> >
> > Thanks,
> > Jens
> >
> > > Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
> > > ---
> > >  drivers/tee/optee/ffa_abi.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> > > index f744ab15bf2c..30a6119a2b16 100644
> > > --- a/drivers/tee/optee/ffa_abi.c
> > > +++ b/drivers/tee/optee/ffa_abi.c
> > > @@ -894,6 +894,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
> > >         rhashtable_free_and_destroy(&optee->ffa.global_ids, rh_free_fn, NULL);
> > >         optee_supp_uninit(&optee->supp);
> > >         mutex_destroy(&optee->call_queue.mutex);
> > > +       mutex_destroy(&optee->ffa.mutex);
> > >  err_unreg_supp_teedev:
> > >         tee_device_unregister(optee->supp_teedev);
> > >  err_unreg_teedev:
> > > --
> > > 2.25.1
> > >
