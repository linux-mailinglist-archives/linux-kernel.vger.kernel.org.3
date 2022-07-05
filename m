Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3DE35670D9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230161AbiGEOWH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231382AbiGEOVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:21:50 -0400
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E9C2F9;
        Tue,  5 Jul 2022 07:20:46 -0700 (PDT)
Received: by mail-yb1-f174.google.com with SMTP id l144so9583968ybl.5;
        Tue, 05 Jul 2022 07:20:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=moN/mB85gS3lzdF/iudqcHdJYr12PlhTawzxEcZPH9M=;
        b=QcI9TNjTjwN4/HXlM7tVfKPFBZPhYT7MlIidUxvVSNUu4MfKk/D0MroKP7tOowqShg
         //44Oppz/I5ABD3iVTNDZwelNcLlYi4ZI4nQuDEufjuAuvByy3gpmRc3fYnBFwF+nvqR
         iNRI4J3c+lbai/+MdSDmO3oEOkMGFG6IvwS68EAGGNqBBlVGOETmfrbubSH3nIF+Ovvm
         HEs0ocVq2hTJKaQPGbxHc8KscZfJUMMwhU42NjRULgoZmMtxtAZAPj93N4K1aotwvi7R
         cuawDsQmlszk5Wn7+PF0JOD5ZJlnOLaKof/c1pW1PsZ2XfsNhGxIxBC3qUmu7nnpG4Ci
         FwAA==
X-Gm-Message-State: AJIora8S/ZRvXdeAH+HtscA9wYvj97sCKDM7uqViI47OdkUZ8Me0KgEc
        Z6XSvoTWeH/iI3DHxXqYemDAxAQwyEvxZG+RmUQ=
X-Google-Smtp-Source: AGRyM1vZCKRP7wH7I3kUoT40URHjBTjDmEqnttfgPyVxDKcKBGau+xSfP+rRXXTJ5OVg8kIMJLGBIdfmEau3BeKKEe8=
X-Received: by 2002:a25:fb02:0:b0:66e:3db9:5d49 with SMTP id
 j2-20020a25fb02000000b0066e3db95d49mr14212439ybe.137.1657030845422; Tue, 05
 Jul 2022 07:20:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220703183059.4133659-1-daniel.lezcano@linexp.org>
 <20220703183059.4133659-6-daniel.lezcano@linexp.org> <ad8dd950-9260-16b3-2134-72984e2ba261@arm.com>
 <e2d81210-a969-fe9d-a4fb-1826c991fbce@linexp.org> <f1cd08de-e8cb-18c2-9f92-01436810bc20@arm.com>
In-Reply-To: <f1cd08de-e8cb-18c2-9f92-01436810bc20@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Jul 2022 16:20:32 +0200
Message-ID: <CAJZ5v0iKcLM--L4ecoPDWpQ=8zgfeMxCku4zJt7hzVxSszgSNQ@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] thermal/core: Remove unneeded EXPORT_SYMBOLS
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Alexandre Bailon <abailon@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Todd Kjos <tkjos@google.com>,
        Wei Wang <wvw@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linexp.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 9:30 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
>
>
> On 7/4/22 22:14, Daniel Lezcano wrote:
> > On 04/07/2022 09:35, Lukasz Luba wrote:
> >> Hi Daniel,
> >>
> >> (+Todd and Wei on CC)
> >>
> >>
> >> On 7/3/22 19:30, Daniel Lezcano wrote:
> >
> > [ ... ]
> >
> >>>   }
> >>> -EXPORT_SYMBOL(get_tz_trend);
> >
> > [ ... ]
> >
> >>>   }
> >>> -EXPORT_SYMBOL(thermal_cdev_update);
> >>
> >> I wouldn't remove that export. I can see in my Pixel6 modules dir, that
> >> it's called in 7 places.
> >>
> >> I assume that in Android world this is common use.
> >
> > It is not possible to do changes taking into consideration out of tree
> > code. Moreover there is logically no good reason to use the
> > thermal_cdev_update() function from outside of the thermal core code.
> >
>
> I see your point which is 'upstream'. On the other hand the mostly
> deployed kernel is in Android devices and that brings a lot to the
> community.
>
> This symbol might also be used by other distros which might have
> modules for some accelerators, which also support tricky cooling.
>
> I would keep it as is...

I think that the long-term goal is to reduce differences between the
mainline kernel and Android.  From this angle, it would be good if
Android was aware that the mainline did stuff especially for them and
making them carry an extra patch would go a long way towards that
purpose.
