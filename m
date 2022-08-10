Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDAD58EAB4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 12:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiHJKv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 06:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230374AbiHJKv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 06:51:26 -0400
Received: from mail-vk1-xa30.google.com (mail-vk1-xa30.google.com [IPv6:2607:f8b0:4864:20::a30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA4762C7
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:51:25 -0700 (PDT)
Received: by mail-vk1-xa30.google.com with SMTP id q191so7192667vkb.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 03:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=h1cqY+wWEiIsslD3StW+1HJvfVXqRrzzKS1Ri5MnoCU=;
        b=EuIdsbqGykuZzc9Wj/SKWpfBMIrpmvedFHt53KNMMHQvNzamf5X4XDTbY9Y2IPRfKb
         c2wUJWGu/VPrIDGakisGdRm9P7uqnArtCYfi6XHnu3eiYAQBzLfWzRTTX1dSHFV3Dlu1
         pjm75vgtVuk0FcfG41wRgllcCaNzRVg/zTD4vTYHY+/t5eWMYJoyNUCL/pdmL/zCr2xv
         VKIdqwHCD649Dqxs6r6yLN4AKR7CNtpW7dyQGouLfx+ai3SrZAfjUxljzG6HNg7vp3u0
         OOsdADKCvEFHRTA/Way2u9g2KI1YN2nzE4abHJV/8O7Wjg1qHIae3nqrfbc86YZ1PxCV
         AoHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=h1cqY+wWEiIsslD3StW+1HJvfVXqRrzzKS1Ri5MnoCU=;
        b=Pc80raXoE1q3CuvHhAh+1KloQWAe/Fz3QuZrhayajBWtSlpd27Us54n86r/N4IS2d0
         Z6Q0sVNwcuFDr+87dw4EvSaHZtUnI3C204H22BUQAfqRHro34wJfMFcXJB+5j787KX4R
         fLOje77ev/iy91vmGtN66Cx6zssT+vi8Gs6R87b27oBs+v89WmaHl0EIPOZXkI20kUYO
         bYtXqF+UsxSlmBhRf31+2aI0uN+eEOrnAv486uvtPjlEv/btDAROT5KrmhDNBrgklwbF
         dL5xyZXWLkV9vXHjwGOH4k+QmAuXr5OvW2pqzM78XTRWgiRODG0TehrNjlch49SJAckt
         wGIg==
X-Gm-Message-State: ACgBeo17XrwHgvYv3/l5fQETPFN0A+8sWWBT4eqUrMQnqHx4JWMelp0v
        UeVnkwOmwQUUnKKHCBoF9+rMzW1DXDk+O5giV+wHn20U71kdcflz
X-Google-Smtp-Source: AA6agR4xAs6qJxEZZWvnnf5CQiqZbmOigwpXI1CtawOXhoShX7/oYIRsCueOGLATwp4RwnbE4PODAQcN1yC2/RltbZg=
X-Received: by 2002:a05:6122:817:b0:377:59fa:3193 with SMTP id
 23-20020a056122081700b0037759fa3193mr11596380vkj.4.1660128684392; Wed, 10 Aug
 2022 03:51:24 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1660068429.git.sander@svanheule.net> <30d8882efedea697da20c27563050008d1569b9e.1660068429.git.sander@svanheule.net>
 <CABVgOSmcKHH2zcCbT-jzekFP8RFov4V0AFBsGjU9kXSy9pJ9HQ@mail.gmail.com> <4f334657f927865266fee19a7920f7248a111ef8.camel@svanheule.net>
In-Reply-To: <4f334657f927865266fee19a7920f7248a111ef8.camel@svanheule.net>
From:   David Gow <davidgow@google.com>
Date:   Wed, 10 Aug 2022 18:51:13 +0800
Message-ID: <CABVgOS=Zc0JYXDuCkd+1-OREKRdDNOt01Ug4+adeMgk1Hp6Mcw@mail.gmail.com>
Subject: Re: [PATCH v1 1/5] lib/test_cpumask: drop cpu_possible_mask full test
To:     Sander Vanheule <sander@svanheule.net>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 4:45 PM Sander Vanheule <sander@svanheule.net> wrot=
e:
>
> Hi David,
>
> On Wed, 2022-08-10 at 12:06 +0800, David Gow wrote:
> > On Wed, Aug 10, 2022 at 2:09 AM Sander Vanheule <sander@svanheule.net> =
wrote:
> > >
> > > cpu_possible_mask is not necessarily completely filled.  That means
> > > running a check on cpumask_full() doesn't make sense, so drop the tes=
t.
> > >
> > > Fixes: c41e8866c28c ("lib/test: introduce cpumask KUnit test suite")
> > > Link: https://lore.kernel.org/lkml/346cb279-8e75-24b0-7d12-9803f2b41c=
73@riseup.net/
> > > Reported-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > Cc: David Gow <davidgow@google.com>
> > > ---
> >
> > Looks good to me. It'd maybe be worth noting _why_  cpu_possible_mask
> > is not always filled (i.e., that the number of available CPUs might
> > not match the maximum number of CPUs the kernel is built to support),
> > but it's probably not worth doing a new version of the patch series
> > just for that.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
>
> Thanks for the reviews!
>
> Perhaps the commit message could be replaced by:
>
> "When the number of CPUs that can possibly be brought online is known at =
boot time, e.g. when
> HOTPLUG is disabled, nr_cpu_ids may be smaller than NR_CPUS. In that case=
, cpu_possible_mask would
> not be completely filled, and cpumask_full(cpu_possible_mask) may return =
false for valid system
> configurations."
>

Sounds good to me! Thanks!

-- David
