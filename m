Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C773C50D4D6
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239028AbiDXTe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236178AbiDXTez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:34:55 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C12F35861
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:31:54 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id w187so14208665ybe.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+AQVps84z7hk0jyB/oKl3EgtneKdfCelacizMXV5xXg=;
        b=QDuyjScIqpWTuaiMOeGMTqvTySTl6NHSn7syPNoiu4mchT+LrP77liQsW+DBa428co
         1IeI5rJAH+ADhnGxs3SFlIiHuzqy+7yRyuzrAJPOVF/afL1AAT7B7vXt9+xnSgzUtfwW
         npUhJKpNlBZ1VIHs5U5TLgBPbaLp7pGBeToSrQALAourp2knBVNbZoGJsSuhQvJal0tU
         noUkyCMgGtoyd5qcdEG/7vACVL4+qOr5UjA/v8JUh4CRO0vK75qvHTlTO6PiDf08dPGL
         ykMYGfSesgg4H2nodkVTMOB1jnX0rD65rOMkvd61QQSg/3AtQhIDDij9qMSd4auCrcVu
         tizA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+AQVps84z7hk0jyB/oKl3EgtneKdfCelacizMXV5xXg=;
        b=y7VaNw0Twhmgl19iOhwMuC7JpV40J4E46uSlT365pS1SMzGz+JNC1zsGoIhfUolUSx
         4bprLRKksRSJ5We3mnkQZqIU948BOYbRGQXVNPcSWUZyjYUD77bWWBmWABVrHLFGle54
         6EUPa0NYWRGaHjLUkgyDZJfIq65aCoMZmK+4jz7CmWZwZAYY+ytRObfvaf2sGIdxlu8G
         0lHcdSbudGM+NGuF+MuxXdIFYCoX0mY9geAfugC0tx8dqv4m1h29mYxBEAumEe8x6x4R
         HvPqgP+AEuJFG4+QoH9WqHpDw1sOvYv9K97TiYXW8wiqRwmHmE3Ml+H4eD7wp/jEblSX
         fvzQ==
X-Gm-Message-State: AOAM532l4GhGhkoyc6Pcu0dJQbK6dZJW3KIWILmwrEJlCsb1OfZrJLLa
        FuN7C1EeZ3X+23qF0ifV3D0UbIp3LvkFTv4GnNopLw==
X-Google-Smtp-Source: ABdhPJwMjI1+pMfAsXoJkmTQTRfEuItdFICvt6YfAyCblp9cWI9AXZ5qYqRaD2ij6rPHfWJQjB4o1dRB8sGqOoyNmPo=
X-Received: by 2002:a25:5cc:0:b0:648:5905:15e6 with SMTP id
 195-20020a2505cc000000b00648590515e6mr2304895ybf.241.1650828713682; Sun, 24
 Apr 2022 12:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <YmUekOVjdFIi3FBw@zn.tnic> <CAHk-=wjccVKAcK7JmpPpOrqR3fXrfza6dCbCLr9BmTyTasJ2GA@mail.gmail.com>
In-Reply-To: <CAHk-=wjccVKAcK7JmpPpOrqR3fXrfza6dCbCLr9BmTyTasJ2GA@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 24 Apr 2022 21:31:42 +0200
Message-ID: <CAKfTPtD2QEyZ6ADd5WrwETMOX0XOwJGnVddt7VHgfURdqgOS-Q@mail.gmail.com>
Subject: Re: [GIT PULL] sched/urgent for 5.18-rc4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>, kuyo chang <kuyo.chang@mediatek.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Apr 2022 at 21:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Apr 24, 2022 at 2:55 AM Borislav Petkov <bp@suse.de> wrote:
> >
> > - Fix a corner case when calculating sched runqueue variables
>
> This worries me.
>
> It now does:
>
> +       if (se_weight(se) < se->avg.load_sum)
> +               se->avg.load_sum = div_u64(se->avg.load_sum, se_weight(se));
>
> and at no point does it check if se_weight(se) is zero.
>
> It *used* to check for that divide-by-zero issue, so from what I can
> tell, a zero se_weight() is actually possible.
>
> Now, it's entirely possible that no, se_weight() can never go down to
> zero. But it's not obvious,. and the commit message doesn't mention
> this change at all.
>
> So I pulled, but then after looking at it I unpulled again in the
> hopes that somebody will clarify the issue for me.
>
> And scale_load_down() (in se_weight()) does try to make the result be
> at least 2 on 64-bit, but only if the original wasn't zero. Very
> confusing.
>
> So can somebody please tell me why se_weight() cannot be 0, and why we
> _used_ to check for zero? Because that commit sure as heck doesn't
> explain it.

For task, weight can't be null
For task group, weight is initialized to nice 0 in init_tg_cfs_entry()
and then it's clamp in calc_group_shares in order to not be null
Then since 26cf52229efc ("sched: Avoid scale real weight down to
zero"), scale_load_down can't return null value.

In fact, the condition if (se_weight(se)) was not needed any more and
should have been removed with commit 26cf52229efc

>
> And - as usual with the -tip tree - the "Link:" thing is almost
> entirely pointless. It doesn't actually point to any discussion of the
> problems, it only points to the patch submission.
>
> I realize that is convenient for automation, but it's really not
> generally a very useful link. It would be much more useful to link to
> whatever problem report that actually *causes* the submission, not to
> the submission itself. We already see the end result in the commit,
> it's the "how did we get here" that is the most interesting part.
>
> And no, I don't see any explanation for "why se_weight() cannot be
> zero" in that submission thread either.
>
> Somebody please hit me over the head with a clue bat.
>
>                  Linus
