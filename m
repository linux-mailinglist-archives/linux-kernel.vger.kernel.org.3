Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D81134BA4CB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbiBQPqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:46:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiBQPqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:46:38 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21FB2B2FCC
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:46:22 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id b9so16034lfv.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6eOVkV0FfYDX4jKgH8lSa5gK8o29oEdERE0Byp3iJzE=;
        b=MgWQ3005tz6UruAbexiTAQmjyE4/vGJjJ40YgZkKt5wgINq/cJdQZVusIwFmFpcPq+
         O9LqsfoMX6zjowwT75eyH08ab9QC33ZquLLmyPmCDIYJ+gpq1u+FdgzSNuxhqOOl1vD5
         0e1PqeAEKPZWjfpxvg1shY8rTmUAzC383tFnOWjZYTAzzhte8qWfgMECgj+3siboyhYx
         Y4LLCOzaZ7CfeN+2LxKGcxaJ5natn80ZMTOeS0IOsMvOI7QFiYjP32bw9gpgBkch8jYj
         1kpFGnzduqrkbBO8z5W+/g8S19Kt08yp2z+ERAhsZnqxReCcb01N+EYfhKwwk0AxANrT
         FFPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6eOVkV0FfYDX4jKgH8lSa5gK8o29oEdERE0Byp3iJzE=;
        b=mbKvkUZhy6oalVu7mO+ACxvJrkQDkTbQUKIwGmt2zHFVXZWSmRG/E/M+IpFGx0i1uJ
         NbAI2fLGeeZSWzNo4tcDfT8KqAKhjFc/jmTyQWGkkPAkATPHZW6QVYAqDQ7lNu2Ee2wI
         /+GX9u+R5aCvtHTsENJq2ZTBGJ3LlJcZDzmZcuVKkSpKwqbWDcGUEx4SXK8QuH8AdV+v
         W5OND6fQVvS9YgpLXeqKk6e/ics2IRtorP9XlOWOhcVJ5ZavR9L8qqu5IjSqmNrQ3nVh
         uMJRPGpAPoFSndM/oO7edXTOjcbar4QzqAw88SlPZmul491l4BYQzk7zgpl/QP4W4PIs
         IK4w==
X-Gm-Message-State: AOAM531n3hVVFu/GAfmLs7XZlwDlaLexPMDyCWOlQZuReSBqOMYQOysg
        NBe3Za5U3X24Sf8oNostNYDMKqu4cp2SPHTiFLyrDg==
X-Google-Smtp-Source: ABdhPJyrAwM7dg/qVHJUCprw1s1xE0huQn0o9suPK834G4SXUVGmelYLIWAXSWs2GYH/bT5EyszGK9bTD+Sf0I1eSA0=
X-Received: by 2002:a05:6512:2241:b0:441:ce2b:18ef with SMTP id
 i1-20020a056512224100b00441ce2b18efmr2443065lfu.167.1645112779464; Thu, 17
 Feb 2022 07:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20220130210210.549877-1-daniel.lezcano@linaro.org>
 <20220130210210.549877-3-daniel.lezcano@linaro.org> <CAPDyKFqV++g63Asax8TNSEgujxJ=uM9XG2_Advu34JidYBCGtg@mail.gmail.com>
 <e44b9c4b-2ac4-4ea4-c771-bde13943af5f@linaro.org> <CAPDyKFr8Ycr2cbiD5MM9FSPc1qea+Yp9=cottcGAo7HmFR9Eaw@mail.gmail.com>
 <cfbaefa5-fc7b-bd0f-e4ed-8f046de2a7cf@linaro.org>
In-Reply-To: <cfbaefa5-fc7b-bd0f-e4ed-8f046de2a7cf@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 17 Feb 2022 16:45:43 +0100
Message-ID: <CAPDyKFoWq+i09Ts_+SAz9ctC2a7-cqC71buDmvb-LZFTVSH+DQ@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] powercap/dtpm: Fixup kfree for virtual node
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, heiko@sntech.de, lukasz.luba@arm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
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

On Thu, 17 Feb 2022 at 14:54, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 17/02/2022 14:17, Ulf Hansson wrote:
> > On Wed, 16 Feb 2022 at 19:10, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 16/02/2022 17:22, Ulf Hansson wrote:
> >>> On Sun, 30 Jan 2022 at 22:02, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> When the node is virtual there is no release function associated which
> >>>> can free the memory.
> >>>>
> >>>> Free the memory when no 'ops' exists.
> >>>>
> >>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>>> ---
> >>>>    drivers/powercap/dtpm.c | 4 ++--
> >>>>    1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>
> >>>> diff --git a/drivers/powercap/dtpm.c b/drivers/powercap/dtpm.c
> >>>> index 0b0121c37a1b..7bddd25a6767 100644
> >>>> --- a/drivers/powercap/dtpm.c
> >>>> +++ b/drivers/powercap/dtpm.c
> >>>> @@ -181,12 +181,12 @@ int dtpm_release_zone(struct powercap_zone *pcz)
> >>>>
> >>>>           if (dtpm->ops)
> >>>>                   dtpm->ops->release(dtpm);
> >>>> +       else
> >>>> +               kfree(dtpm);
> >>>>
> >>>
> >>> This doesn't look correct. Below you check dtpm against "root", which
> >>> may be after its memory has been freed.
> >>>
> >>> If the ->release() function should be responsible for freeing the
> >>> dtpm, it needs to be called after the check below.
> >>
> >> It is harmless, 'root' is not dereferenced but used as an ID
> >>
> >> Moreover, in the patch 5/7 it is moved out this function.
> >
> > Right. It just looks a bit odd here.
> >
> >>
> >>
> >>>>           if (root == dtpm)
> >>>>                   root = NULL;
> >>>>
> >>>> -       kfree(dtpm);
> >
> > So then why doesn't this kfree do the job already?
> >
> > kfree(NULL) works fine, if dtpm->ops->release(dtpm) already freed the data.
>
> The description is confusing.
>
> Actually, there is a double kfree. When there is a ops->release, the
> kfree is done there and again a few lines after.
>
> The issue was introduced with the change where dtpm had a private data
> field to store the backend specific structure and was converted to a
> backend specific structure containing a dtpm node [1].
>
> So this function was calling release from the dtpm backend which was
> freeing the specific data in the dtpm->private and then here was freeing
> the dtpm. Now, the backend frees the structure which contains the dtpm
> structure, so when returning from ops->release(), dtpm is already free.
>
> I should change the description and add a Fixes tag to the change
> described above.

Does ops->release() also resets the "dtpm" pointer to NULL? If not,
it's good practice that it should, right?

In that case, we would be calling "kfree(NULL);" the second time,
which is perfectly fine.

>
> [1]
> https://lore.kernel.org/r/20210312130411.29833-4-daniel.lezcano@linaro.org
>

Kind regards
Uffe
