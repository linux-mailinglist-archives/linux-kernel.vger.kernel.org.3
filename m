Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A481B4F674A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbiDFRaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239245AbiDFRaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:30:13 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAD1136643
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 08:33:41 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q14so3696261ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 08:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=V2MKXaDi/1jNYC/yBJ1BrH+QH08TMzML0ERK28N60DY=;
        b=SLAyyGFjinRL8kaGFHMoza109mTD3uqyOJGHii9BPON0ZPD8zZ2GegVCMABiZIf92u
         mwJXveOBoX3NpkmgodISPHevXOGq7XiOcgfR00OXb/1sTCN5v/eCljZDTh0j/xYyEmCE
         i/dxVYR7ZSv7AHEIffHQTAorD19scopZBLnVbMDqEbcc4lEYFFX3gyiZUd1HQxBEgXPD
         6bF8LStWUJzYpZnZH1X6cdcrEeLnusqLziJVEcNjhFqOv9IrtZVifv82qv5l6e5MqULN
         IEoq0jnK0LUT34ETn1ZAebxZnSpE5SSVxsRx9BnmWm9a9Yf+EH4QHb8CcojpbN71phbo
         tWtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=V2MKXaDi/1jNYC/yBJ1BrH+QH08TMzML0ERK28N60DY=;
        b=kqOk+pwvoKvF7/0XvAk/07Anlq+ydt2YceOenew/VV1iBYEaIuGJLZlXwzoyXk5ycP
         TjY0bP0Hzydty6IrhPWfyU15deCU1sy1u/GlRkNmuPj5bAY+pn9fWRwQjVoZ6X/q1ieB
         hB1Heop2KsM8mo1bfpj7BmH7NvRqkQ219QjnbxK9HhrUgUN2XT+V48I9OBxnBkvjozQb
         q1K/yURvYhRhH34gn7N4EZ2gvBKh83fLcWzET6KptQs4XwAU26krvZpGDFaO+xE6Lj0W
         vbupshfxMeGaSmxpxxmZc2E1qsJD4VsLLHizrCQLIXQF44/w32pgGGkRqnnYD5xuPRXQ
         kxmw==
X-Gm-Message-State: AOAM532WfYdUububHo849AA5+O24JDwcvtAJqwC6SI2nwRqbZS0YRpkY
        +uaw5XIj3FCTQceq3aF5inpLj10dyVkcd+APb7e8iA==
X-Google-Smtp-Source: ABdhPJzreYUYPZpbVpzkaPv5TENoYSI5dAupQC5/q42OXgAWYqF9DUZh8BLgg57J3IYFZOeGcNNC0cXGZ9hbHJddLsc=
X-Received: by 2002:a2e:b8cc:0:b0:249:a2b5:8e16 with SMTP id
 s12-20020a2eb8cc000000b00249a2b58e16mr5867735ljp.381.1649259219699; Wed, 06
 Apr 2022 08:33:39 -0700 (PDT)
MIME-Version: 1.0
References: <1649244204-23471-1-git-send-email-zgpeng@tencent.com>
 <CAKfTPtDh7qFpdjsEBvT34WEgW8uGbdwsZnyXjq4KpAcOse9Pew@mail.gmail.com> <CAE5vP3=ZPGV=PuYb-WJsoQ8tX4yDAjajT_WRU+7gAiW54XgX_g@mail.gmail.com>
In-Reply-To: <CAE5vP3=ZPGV=PuYb-WJsoQ8tX4yDAjajT_WRU+7gAiW54XgX_g@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 6 Apr 2022 17:33:28 +0200
Message-ID: <CAKfTPtA8VjZ-F3vdiKJtpij6PUxu_OR7-54cG6NcS_K7guHF6g@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Return the busiest group only if imbalance is meaningful
To:     =?UTF-8?B?5b2t5b+X5Yia?= <zgpeng.linux@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org,
        Benjamin Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org
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

On Wed, 6 Apr 2022 at 17:07, =E5=BD=AD=E5=BF=97=E5=88=9A <zgpeng.linux@gmai=
l.com> wrote:
>
> YES. The following are specific scenarios where negative values occur:
>
>
>
> The scheduler domain contains four groups, namely groupA, groupB, groupC,=
 and groupD;
>
> The types and avg_load conditions of the four groups are as follows
>
>
>
> GroupA    TYPE=3D group_fully_busy     avg_load=3D10        [local group]
>
>
>
> GroupB    TYPE=3D group_has_spare     avg_load=3D1
>
> GroupC    TYPE=3D group_has_spare     avg_load=3D1
>
> GroupD    TYPE=3D group_overloaded    avg_load=3D20      [busiest group]
>
>
>
> The CPU that calls load_balance is located in groupA, and update_sd_lb_st=
ats will select the busiest group in GroupB, groupC, and
>
> groupD, that is, gorupD. Under this condition, other judgments in the fin=
d_busiest_group function will be bypassed and the
>
> calculate_imbalance function will be called. The judgment in the middle o=
f the calculate_imbalance function cannot stop this
>
> situation, and it will go to the imbalance calculate logic at the end of =
the function.At this time, the domain's avg_load=3D8, but
>
>  the local_groupthe's avg_load=3D10; The negative value is therefore gene=
rated.

I think that this case should be covered by an additional test in
calculate_imbalance because we should not try to pull load in groupA
if it's already above  the average load. Something like below should
cover this

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9469,6 +9469,16 @@ static inline void calculate_imbalance(struct
lb_env *env, struct sd_lb_stats *s

                sds->avg_load =3D (sds->total_load * SCHED_CAPACITY_SCALE) =
/
                                sds->total_capacity;
+
+               /*
+                * Don't pull any tasks if this group is already above the
+                * domain average load.
+                */
+               if (local->avg_load >=3D sds->avg_load) {
+                       env->imbalance =3D 0;
+                       return;
+               }
+
                /*
                 * If the local group is more loaded than the selected
                 * busiest group don't try to pull any tasks.

>
>
> Vincent Guittot <vincent.guittot@linaro.org> =E4=BA=8E2022=E5=B9=B44=E6=
=9C=886=E6=97=A5=E5=91=A8=E4=B8=89 20:59=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, 6 Apr 2022 at 13:23, zgpeng <zgpeng.linux@gmail.com> wrote:
>> >
>> > When calculate_imbalance function calculate the imbalance, it may
>> > actually get a negative number. In this case, it is meaningless to
>>
>> We should not return a negative imbalance but I suppose this can
>> happen when we are using the avg_load metrics to calculate imbalance.
>> Have you faced a use case where imbalance is negative ?
>>
>> > return the so-called busiest group and continue to search for the
>> > busiest cpu later. Therefore, only when the imbalance is greater
>> > than 0 should return the busiest group, otherwise return NULL.
>> >
>> > Signed-off-by: zgpeng <zgpeng@tencent.com>
>> > Reviewed-by: Samuel Liao <samuelliao@tencent.com>
>> > ---
>> >  kernel/sched/fair.c | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > index 601f8bd..9f75303 100644
>> > --- a/kernel/sched/fair.c
>> > +++ b/kernel/sched/fair.c
>> > @@ -9639,7 +9639,7 @@ static struct sched_group *find_busiest_group(st=
ruct lb_env *env)
>> >  force_balance:
>> >         /* Looks like there is an imbalance. Compute it */
>> >         calculate_imbalance(env, &sds);
>> > -       return env->imbalance ? sds.busiest : NULL;
>> > +       return env->imbalance > 0 ? sds.busiest : NULL;
>> >
>> >  out_balanced:
>> >         env->imbalance =3D 0;
>> > --
>> > 2.9.5
>> >
