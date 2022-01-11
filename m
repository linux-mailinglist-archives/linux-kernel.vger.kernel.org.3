Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB048A959
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348908AbiAKI27 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:28:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348903AbiAKI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:28:56 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8EFCC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:28:55 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id d3so27199490lfv.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 00:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w64oRqjy2sBBTYpxJqtZ5u6+GHIXLbttja2ZaIWmILY=;
        b=srx4yPzHYNdYr0CC4i1/pIX9bImRobXWfrTb/WMcU5awT1Q1LqnnVGz4lkCyJNNVtQ
         o6dAg8T+E72GvH23nookiW/N2M0GzMPO+MUG81Plzc3guueA6Gm7wFgGvlMj5a+h1Sx7
         n2UHf8A4khYCg05U7q3/AtL0r9w3pz4Nm0lOtirIpCqJw/hl2gXBF1kyNrz2AXWGb92n
         4LaLRYY7W80xLPWDwfNo5Uibe4QoBVnvkcbYc4c/pmZ3cY827oGieERLJMqCGmbms4VJ
         ToN2/pO5dRFXkfw7C5u/aqvXNxa/vfh1JuGsO7nFuuGFsa6shCpswU9fty244TU4N4gz
         5wMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w64oRqjy2sBBTYpxJqtZ5u6+GHIXLbttja2ZaIWmILY=;
        b=F/JzOgHIJOrHnXTiV34Dg6u0AucA5nkQfvAdzt4FFJHREWvXc+/QXQLVQ80F7EL7ft
         j7WUvt55zVPnEBBThCKGqNJFJoPdjdEnU0+v6xwZ+uVoZfYBm1lFy+mCOAUBaPT7vid+
         fnccDitTi6C6sYBd0fNO2rxP118wzenmhs8R+vPsmVNph+FsUf+cVKUm8D+Je1OoZ+YW
         vWShDMzkV7DFAbqljqNqAymISAA9UifPvExHa8PA8lU4GVb0mb+T1fmWoIRtnuJkqtO2
         St6S07lL606ZX2A2/QyurpBWuhcfOvrStOwhDOw4m9CgIYkNBRz2OZVqyURSu2XFzaL6
         pqJQ==
X-Gm-Message-State: AOAM533BetB93iL5j4R1FrhyamAIwafeQ3cpfYwZIewLpHqgHgO1WgaI
        5FDAeBnGKVBsLUtcHHmP0x/n60TwnjuNJ1h+86qp5g==
X-Google-Smtp-Source: ABdhPJz4Ucs7djDQ4nkdItIbDWDwL6t/cbpWI/q5kJrjUsF3ZjH58NU0nm9GE4KFDs5LFx4VSOMqXjR5Ks0x1lQoMlo=
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr2586999lfr.71.1641889734076;
 Tue, 11 Jan 2022 00:28:54 -0800 (PST)
MIME-Version: 1.0
References: <20211218130014.4037640-1-daniel.lezcano@linaro.org>
 <20211218130014.4037640-3-daniel.lezcano@linaro.org> <CAPDyKFrLTsUxG8JHdK33h2BT8pxeHk6kiU-4uGrvxUhcQKg3Sw@mail.gmail.com>
 <8fcc0ef8-b0c7-da73-434f-31c88896aed5@linaro.org> <CAPDyKFqzxnfh0kow5mzoApFMQpKOAv=e1b7Cy9H-iEh99Wmagw@mail.gmail.com>
 <cbc70ea7-39b4-b5e8-b5c0-45fb436f53eb@linaro.org>
In-Reply-To: <cbc70ea7-39b4-b5e8-b5c0-45fb436f53eb@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 11 Jan 2022 09:28:17 +0100
Message-ID: <CAPDyKFoFpEjakaeb1JvYg47qoagGnzwyh2T1SpHQiwB3sFgkoA@mail.gmail.com>
Subject: Re: [PATCH v5 2/6] powercap/drivers/dtpm: Add hierarchy creation
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     rjw@rjwysocki.net, lukasz.luba@arm.com, robh@kernel.org,
        heiko@sntech.de, arnd@linaro.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jan 2022 at 16:55, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 07/01/2022 16:54, Ulf Hansson wrote:
> > [...]
> >
> >>>> +static int dtpm_for_each_child(const struct dtpm_node *hierarchy,
> >>>> +                              const struct dtpm_node *it, struct dtpm *parent)
> >>>> +{
> >>>> +       struct dtpm *dtpm;
> >>>> +       int i, ret;
> >>>> +
> >>>> +       for (i = 0; hierarchy[i].name; i++) {
> >>>> +
> >>>> +               if (hierarchy[i].parent != it)
> >>>> +                       continue;
> >>>> +
> >>>> +               dtpm = dtpm_node_callback[hierarchy[i].type](&hierarchy[i], parent);
> >>>> +               if (!dtpm || IS_ERR(dtpm))
> >>>> +                       continue;
> >>>> +
> >>>> +               ret = dtpm_for_each_child(hierarchy, &hierarchy[i], dtpm);
> >>>
> >>> Why do you need to recursively call dtpm_for_each_child() here?
> >>>
> >>> Is there a restriction on how the dtpm core code manages adding
> >>> children/parents?
> >>
> >> [ ... ]
> >>
> >> The recursive call is needed given the structure of the tree in an array
> >> in order to connect with the parent.
> >
> > Right, I believe I understand what you are trying to do here, but I am
> > not sure if this is the best approach to do this. Maybe it is.
> >
> > The problem is that we are also allocating memory for a dtpm and we
> > call dtpm_register() on it in this execution path - and this memory
> > doesn't get freed up nor unregistered, if any of the later recursive
> > calls to dtpm_for_each_child() fails.
> >
> > The point is, it looks like it can get rather messy with the recursive
> > calls to cope with the error path. Maybe it's easier to store the
> > allocated dtpms in a list somewhere and use this to also find a
> > reference of a parent?
>
> I think it is better to continue the construction with other nodes even
> some of them failed to create, it should be a non critical issue. As an
> analogy, if one thermal zone fails to create, the other thermal zones
> are not removed.

Well, what if it fails because its "consumer part" is waiting for some
resource to become available?

Maybe the devfreq driver/subsystem isn't available yet and causes
-EPROBE_DEFER, for example. Perhaps this isn't the way the dtpm
registration works currently, but sure it's worth considering when
going forward, no?

In any case, papering over the error seems quite scary to me. I would
much prefer if we instead could propagate the error code correctly to
the caller of dtpm_create_hierarchy(), to allow it to retry if
necessary.

>
> In addition, that should allow multiple nodes description for different
> DT setup for the same platform. That should fix the issue pointed by Bjorn.
>
> > Later on, when we may decide to implement "dtpm_destroy_hierarchy()"
> > (or whatever we would call such interface), you probably need a list
> > of the allocated dtpms anyway, don't you think?
>
> No it is not necessary, the dtpms list is the dtpm tree itself and it
> can be destroyed recursively.

I could quite figure out how that should work though, but I assume
that is what the ->release() callback in the struct dtpm_ops is there
to help with, in some way.

Kind regards
Uffe
