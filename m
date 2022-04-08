Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F74F8FB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 09:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiDHHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 03:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiDHHlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 03:41:39 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF11A9C84
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 00:39:37 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g9so13646719ybj.9
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 00:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=gyVHJgcaGws8+cVL82BQrcMAUaEUFmtsrDoHZpP9Ojk=;
        b=dhqIlFXZce/V/NaNITP2d+qKkbo2bzcVsQfMKCMYYpq6X0Ss6UNioUmKIs4EWlXsdF
         /y8O2WvCnG0M7Lv3HejtYw4QE0Nt46xqTeGHQ+VrjQzz/mkhWsIMmBCzkp3VRy7eJbuE
         0tKvdhjW6ZHfUZbEo92RH/hwdD6H84zpeYfiekNpoDIeVZoF+1HFqjUA0r4J287liiBY
         pK3Is4XMhTsXGYvdF7pcfZa4tHu7H0ed1uytjEVhO8teN9u2vLo35BkmoKiIJSFcfQPy
         BSb6BlyIiS/1XPN+rVtryBX8FyFVswHCXR2M3CmJJN50MZidBWgimCCM8gX5NOHpStlH
         6bOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=gyVHJgcaGws8+cVL82BQrcMAUaEUFmtsrDoHZpP9Ojk=;
        b=L3luDchvn/SnrlFK3mOoLAXDMklGFcwi0h1KABqeldnrPklf5JXKlCQNa4dpMWYqK4
         SG2dwiYV+jePBE2q0xxqKX9N9WDVurh0Z87M8E7Vd0M0jedvGc0ak5C63djfkjKwxxeJ
         onB1qzPXhNJTWjDa7edEAYbmV2L/UwQYq/4opCIGRBEZP+fLx1ev15EqAn16VDzFW0kF
         zirMZ4dzu+ygiJE1dSe0+eoCB68ex9ZSnOLlRwByxHJ8IFwQpjSyy3Cr8yJPHGQ2RbjU
         ff+1o47ZjFEibH+g9DOGP9fPQDF6TIJw/P4jbBIV0Kj1kxZglkqRpItaMleTrDrHHvlU
         9GPw==
X-Gm-Message-State: AOAM530mqzvrFuuIAOsvmrYzKDrh0Tlpqcp4olNOxJc1RSMdFB9xdYaR
        vJfmljBoz5rFG9xfMiSxLchuT+kuP3CPzqDRqoG5lg==
X-Google-Smtp-Source: ABdhPJwiDzCVHx85XT1dNJRZ6oSnOeolEIUTk5m0Q116PyxgqkgXoE1ag/C+E6W03ZD5bSa8avFXN7JlrehGZ6IUFlg=
X-Received: by 2002:a25:c5d2:0:b0:636:e78a:866d with SMTP id
 v201-20020a25c5d2000000b00636e78a866dmr13760235ybe.225.1649403576296; Fri, 08
 Apr 2022 00:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <1649245580-27256-1-git-send-email-zgpeng@tencent.com>
 <CAKfTPtDCXP8pt=F563sovxXJr-ALFuxNtE+1gWL-s7A-h4waew@mail.gmail.com> <CAE5vP3nYKKxfFWLG_idezXRiDALmGvN8EY0sL8vLK+5rnwMUaA@mail.gmail.com>
In-Reply-To: <CAE5vP3nYKKxfFWLG_idezXRiDALmGvN8EY0sL8vLK+5rnwMUaA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 8 Apr 2022 09:39:25 +0200
Message-ID: <CAKfTPtAOvOa1MYqcnGgVo=C+cE5AAsDVyAiX1EgKhW5YGVSdBg@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Simplify the scene where both local and
 busiest are group_fully_busy
To:     =?UTF-8?B?5b2t5b+X5Yia?= <zgpeng.linux@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        rostedt@goodmis.org, Benjamin Segall <bsegall@google.com>,
        mgorman@suse.de, bristot@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 at 04:38, =E5=BD=AD=E5=BF=97=E5=88=9A <zgpeng.linux@gmai=
l.com> wrote:
>
> When the type of the local group is group_has_spare, it does not affect i=
t, and it also has the opportunity
>
> to pull the process to the local cpu.
>

My point is :

local group is group_fully_busy
busiest group is group_fully_busy

but

local cpu is idle or newly idle otherwise we would have already returned

Currently, calculate_imbalance returns imbalance=3D0 because it is based
on avg_load which is not set for busiest group. Instead of skipping
calculate_imbalance, we might compute an imbalance similarly to what
is done for spare_capacity because local cpu being idle is an
opportunity to run something else

>
>
> This patch deals with scenarios where both the local group and the busies=
t group type are group_fully_busy.
>
> In this scenario, because the avg_load of the group of type group_fully_b=
usy is not calculated, this value is 0.
>
> Therefore, the condition of local->avg_load >=3D busiest->avg_load in cal=
culate_imbalance is satisfied, so the
>
> imbalance will be set to 0; Therefore, in this scenario, the original log=
ic has no chance to pull the process to
>
> the local cpu for execution.  I think it can be judged at the upper level=
, and there is no need to go into
>
> calculate_imbalance to do some useless work.
>
>
> Vincent Guittot <vincent.guittot@linaro.org> =E4=BA=8E2022=E5=B9=B44=E6=
=9C=886=E6=97=A5=E5=91=A8=E4=B8=89 23:41=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, 6 Apr 2022 at 13:46, zgpeng <zgpeng.linux@gmail.com> wrote:
>> >
>> > When both local and busiest group are group_fully_busy type, because
>> > the avg_load of the group of type group_fully_busy is not calculated, =
the
>> > avg_load value is equal to 0. In this case, load balancing will not ac=
tually
>> > done, because after a series of calculations in the calculate_imbalanc=
e, it
>> > will be considered that load balance is not required. Therefore,it is =
not
>> > necessary to enter calculate_imbalance to do some useless work.
>> >
>> > Signed-off-by: zgpeng <zgpeng@tencent.com>
>> > Reviewed-by: Samuel Liao <samuelliao@tencent.com>
>> > ---
>> >  kernel/sched/fair.c | 12 ++++++++++++
>> >  1 file changed, 12 insertions(+)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 9f75303..cc1d6c4 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -9634,6 +9634,18 @@ static struct sched_group *find_busiest_group(s=
truct lb_env *env)
>> >                          * busiest doesn't have any tasks waiting to r=
un
>> >                          */
>> >                         goto out_balanced;
>> > +
>>
>> We are there because both local and busiest are not overloaded, local
>> is idle or newly_idle and there might be an opportunity to pull a
>> waiting task on local to use this local cpu. I wonder if we should not
>> cover this opportunity in calculate_imbalance instead of skipping it
>>
>> > +               if (local->group_type =3D=3D group_fully_busy)
>> > +                       /*
>> > +                        * If local group is group_fully_busy, the cod=
e goes here,
>> > +                        * the type of busiest group must also be grou=
p_fully_busy.
>> > +                        * Because the avg_load of the group_fully_bus=
y type is not
>> > +                        * calculated at present, it is actually equal=
 to 0. In this
>> > +                        * scenario, load balance is not performed. th=
erefore, it can
>> > +                        * be returned directly here, and there is no =
need to do some
>> > +                        * useless work in calculate_imbalance.
>> > +                        */
>> > +                       goto out_balanced;
>> >         }
>> >
>> >  force_balance:
>> > --
>> > 2.9.5
>> >
