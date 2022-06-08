Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62911543A56
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiFHR1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 13:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbiFHR1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 13:27:03 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F7044B1FE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 10:24:57 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y16so17050800ili.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 10:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PxDHLMbJGF1owInS1P62PcKBFVUxfaTCqLJGBkURXio=;
        b=NWQvZlCaFl4ev3AHkiIjWn7DpPpA/YGVIyZ3INP/rq0bB0FmZ/lF0tlT5w3PVjnD9j
         HFtr+bfbBjsMpHiR0FCPUfH2i3CP9tmcWLnaXbaOvPi9yiPfad+ea2XUXcdY4q+oFH+D
         DK8YOLOF5LqyySYK0IyaeXiyo5YYBYaVL4rFEtcvtaA8dVHfVGeF57AWN7xXPAGy4l/7
         F6kb7bVnURpfI5omVoXyGMPYRByn0kz8qfiscjTYRkUdAmdmRBPt6+ti3zT/hpNAGcJt
         7FifBVcLhjWa3hSnCGyE7bdoK91ef3ZubT+YbtqLOoaeZZm4+khVtvEupPpNMzSwewau
         93Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PxDHLMbJGF1owInS1P62PcKBFVUxfaTCqLJGBkURXio=;
        b=LDv1IdiUEDdUInHI0HbdLbMd1hJlIjQ5bcpKuCmjCkRKYT9gMvL+lNKCHsVbANo0h1
         OmpvlQn7MqolMoLqHnxgqVbCjurJCOg+P+y0lNLSkjRM2Be0k0FwhfHStRcpbXHLMqqI
         i82v5FV/dk8HLNNlv+QgD3NzzZUQrnGLRo2H11ekW7ruxF6+5c10R36X9HwK4s+UOZz9
         jgYT2h9IStQMLDV2Z2XO9xVmn3s3kmYI3V0gitNZYTcI99HSnHWO7K3qxJNQP6neNPZp
         rXGNcaK/5fMCnOAZM2wKhEqN0hUZJ0pe370LOpQQW3/42LmTyB2HCEL4/KJQrzvWfUbM
         lfgg==
X-Gm-Message-State: AOAM5307XL/3yVCBO63dqDdOYh7YTaV86FV8vRResWxe53XWVf/3qsG5
        RQUqksVCm+jA9DzEX02x89ULftDLaJ4e9eRx230=
X-Google-Smtp-Source: ABdhPJxkLaD1dwYdQRmEIZrk58IzhaQn5SrfYBQSPh/SdHNBCe4LFP/mPXVNu9ckhLxMfhCHQK8FrQ37Cl0ojC39+j0=
X-Received: by 2002:a05:6e02:1c88:b0:2d1:87ea:18c with SMTP id
 w8-20020a056e021c8800b002d187ea018cmr19763313ill.321.1654709096662; Wed, 08
 Jun 2022 10:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220608150008.57629-1-1030steven@gmail.com> <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
In-Reply-To: <3193fcc9-c672-19d9-a2e2-ad67809dd20b@infradead.org>
From:   =?UTF-8?B?6b6N5biG6LuS?= <1030steven@gmail.com>
Date:   Thu, 9 Jun 2022 01:24:45 +0800
Message-ID: <CAEZ6PjwamdjavX_AvsFmRasE7W1cnc10dpPqSzxhvzEKm4i5Aw@mail.gmail.com>
Subject: Re: [PATCH] sched/pelt: Fix bracket typo
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_STARTS_WITH_NUMS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 8, 2022 at 11:33 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 6/8/22 08:00, Steven Lung wrote:
> > The second bracket describing the range is inverted, this patch
> > will fix it.
> >
> > Signed-off-by: Steven Lung <1030steven@gmail.com>
> > ---
> >  kernel/sched/pelt.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/sched/pelt.c b/kernel/sched/pelt.c
> > index 0f3107682..ed82cfba9 100644
> > --- a/kernel/sched/pelt.c
> > +++ b/kernel/sched/pelt.c
> > @@ -233,7 +233,7 @@ ___update_load_sum(u64 now, struct sched_avg *sa,
> >   * When syncing *_avg with *_sum, we must take into account the current
> >   * position in the PELT segment otherwise the remaining part of the segment
> >   * will be considered as idle time whereas it's not yet elapsed and this will
> > - * generate unwanted oscillation in the range [1002..1024[.
>
> Is the above the same as                   range [1002..1024).
> ?  I.e. 1002-1023 inclusive (or 1024 excluded)?
>
> > + * generate unwanted oscillation in the range [1002..1024].
> >   *
> >   * The max value of *_sum varies with the position in the time segment and is
> >   * equals to :
>
> --
> ~Randy

In the patch that the author submitted[1] for this comment, he
mentioned that the value 1024 can be obtained.
So I think we should use brackets instead of parenthesis.

[1]: https://lore.kernel.org/all/20200506155301.14288-1-vincent.guittot@linaro.org/T/#u

--
Steven
