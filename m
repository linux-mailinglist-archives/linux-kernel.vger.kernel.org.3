Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58F156BA0F
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237927AbiGHMuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237579AbiGHMuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 08:50:21 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDDA1EAEA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 05:50:19 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g4so37639056ybg.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 05:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=btXZxPXZDy315xwImAwRFliP5iVS0KaTZenaWIIp5KM=;
        b=w9FVgtdd+YUrMdoZq+R6P9mnK4mFjuQq7/1HjcxGehzpWhq8UFDTDBpEXRgFFOY37T
         g+TxC1WrIgtpZ2tclIrmnH/iAiarH9EBA8HkmJp1jlO/FedeLa0m86l3jbxNMfYECHIp
         np9bsaXRERDlfAJFB53NEApF5IsyPISyMc4pwM8Md25Bg/LvYVYsqYi3b3ykdDV7G0tx
         QoGPbIwG24gak/TmJTcoODaFeDZuIcycRkmygsLuLxiEELCbIpfe1qIBQiGoGagH2ESi
         ATDBfE7N8SGcXHk2u97e/QkWO9F9M+ITZCb2n2W+Ig3kJTpfWAPn4aueP4kApzGL9311
         yrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=btXZxPXZDy315xwImAwRFliP5iVS0KaTZenaWIIp5KM=;
        b=2ceMj9pCyc2O7sxKgAYziOpC+2hoD/tl3PSP2Wd6I4p6Xg/wieWjXT6vG4XMKIB3iZ
         +C4LpaOeFGJ18f6yVswx+qd5p9zqmXaALiyvxsXu6Z4oIeaG/9Kt2+rxJ5TFJlZQ/ZgI
         wDc24yZxOOL2Ru+ItPopay/V6eLYqV8xQoydWOwIk6RswBgjKyhAw3rkYq9i67Do/jcN
         LILQibtTCqGYyXoQ79LqE1WokmDoWQiDp9cSAqphe1HJmNqv6ulhTr//mhwETtY2qjYA
         tBRZiU7kPbzpdttIUQ/F9fzOJ3ojHvh+3bkg7lGCxhuIXagjVxZzOgrn8ZnmHcZcfjIY
         driw==
X-Gm-Message-State: AJIora8e8xFQN4DQqD4Fnl8xO6t/MCZaSESdMzpmhM9eflVlcIlS0hZ8
        wn+igLw9V3UkWb6++IMJx7fmyHBuWpASpWYdfw7g3A==
X-Google-Smtp-Source: AGRyM1sBdW4KV0b5hSPeO+FMkkutwXjtdcTQ5Sv85l72gxTgJS5fMf0dBxj2q8TPmCH7TzDs7tNGq0CEKXUGOzFdJI8=
X-Received: by 2002:a25:9382:0:b0:66d:ae8e:19e8 with SMTP id
 a2-20020a259382000000b0066dae8e19e8mr3407649ybm.236.1657284619157; Fri, 08
 Jul 2022 05:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220707034143.37991-1-jiahao.os@bytedance.com>
 <CAKfTPtAb==WjCpmqOaVdwna6c+yxxskkRKwBKB7_EuJC9SrmJA@mail.gmail.com> <1a9656a2-024e-497f-a0e6-3ec65910ab54@bytedance.com>
In-Reply-To: <1a9656a2-024e-497f-a0e6-3ec65910ab54@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Jul 2022 14:50:07 +0200
Message-ID: <CAKfTPtCe-_BGYpK4t_pLKkk0agzgUVwvweE46-VA9W=vB_GQfw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH] sched/fair: Remove unused parameter idle
 of _nohz_idle_balance()
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2022 at 12:32, Hao Jia <jiahao.os@bytedance.com> wrote:
>
>
>
> On 2022/7/7 Vincent Guittot wrote:
> > On Thu, 7 Jul 2022 at 05:42, Hao Jia <jiahao.os@bytedance.com> wrote:
> >>
> >> Since commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu
> >> loop of ILB") was merged. The parameter idle of _nohz_idle_balance()
> >
> > The description of the commit should be in a single line.
> >
> > commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
> >
>
> Thank you for your suggestion.
>
> how about this=EF=BC=9F

looks good to me

>
> Commit 7a82e5f52a35 ("sched/fair: Merge for each idle cpu loop of ILB")
> has been merged. The parameter idle of _nohz_idle_balance()
> is not used anymore so we can remove it.
>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
>
> >> is not used anymore so we can remove it.
> >>
> >> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> >
> > Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
> >
> >> ---
> >>   kernel/sched/fair.c | 7 +++----
> >>   1 file changed, 3 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 77b2048a9326..8d4be2a95e37 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -10682,8 +10682,7 @@ static bool update_nohz_stats(struct rq *rq)
> >>    * can be a simple update of blocked load or a complete load balance=
 with
> >>    * tasks movement depending of flags.
> >>    */
> >> -static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags=
,
> >> -                              enum cpu_idle_type idle)
> >> +static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags=
)
> >>   {
> >>          /* Earliest time when we have to do rebalance again */
> >>          unsigned long now =3D jiffies;
> >> @@ -10798,7 +10797,7 @@ static bool nohz_idle_balance(struct rq *this_=
rq, enum cpu_idle_type idle)
> >>          if (idle !=3D CPU_IDLE)
> >>                  return false;
> >>
> >> -       _nohz_idle_balance(this_rq, flags, idle);
> >> +       _nohz_idle_balance(this_rq, flags);
> >>
> >>          return true;
> >>   }
> >> @@ -10818,7 +10817,7 @@ void nohz_run_idle_balance(int cpu)
> >>           * (ie NOHZ_STATS_KICK set) and will do the same.
> >>           */
> >>          if ((flags =3D=3D NOHZ_NEWILB_KICK) && !need_resched())
> >> -               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK, CPU_I=
DLE);
> >> +               _nohz_idle_balance(cpu_rq(cpu), NOHZ_STATS_KICK);
> >>   }
> >>
> >>   static void nohz_newidle_balance(struct rq *this_rq)
> >> --
> >> 2.32.0
> >>
