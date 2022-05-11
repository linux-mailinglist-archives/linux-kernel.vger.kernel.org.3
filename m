Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05457523CBA
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 20:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346433AbiEKSkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 14:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240901AbiEKSkL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:40:11 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0C922DA12;
        Wed, 11 May 2022 11:40:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ef5380669cso31429877b3.9;
        Wed, 11 May 2022 11:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gacAQnuTjXI3dz5TBJm0cWWRDuAqQVNEJfTWj1bBIpg=;
        b=QcTRIebnvYiCLvVVye/uet+vfZJgWbzfp1uLdVVnlMnPKm01s0LuUJUZ91Xq0MB9Vr
         UvJ31JfGq+SEWZ/FnBrJstqzQahaDs4gfi2jYP96zXZMoyWJRCbQjC+8BTGNblnigo4i
         TvhQFLN+5/vohU/bN8z9bLHVLaZLJS3z+dZYTZdnb3KD65mJqrn37NewG3VMLPxk0JdJ
         hSRNeZyyAddkDt1GafBCleGW7l8iaZWLLpop8J/VUfnRHMwixxlz9JXsSWtrgqV4zwJx
         4xhFLuYsbOhpVnyJBYcM/wKPrOu/YABlYqo35H2KKherBlAV90VG0HVQlT3v75juxVZX
         EfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gacAQnuTjXI3dz5TBJm0cWWRDuAqQVNEJfTWj1bBIpg=;
        b=wLjFVD9jh2PGwCuon2WfVO0CdF2NPaDOKsdQ86fp+W/hNdF6AbKS0ITmIlUoQ9ZBfb
         VNOAhf2PiSzx33HMajBtKqG3Djv9Foy6nwoC/+X8XMs+2uiFsaU4D1D3e0yugLmZERdD
         4SBPuhDGVFYYwBY7szBu5tWyl6C+3LEc9txy9jvFGSvSfKqAmfR4uEctxHde8lGJI7Ts
         jgILNd3o1Wup6wbiP/O6612ZNYhWmkfp+yx0U/lMSn5FJ/rBvuCcdmJ9x/EkjJKB2qPq
         JA8UEdh9H9xC+/dK1xeqGKkwEiNb4c9IOBq06HuGgtfOnTtX8OukvqmPwaay9RIrd/Hj
         XhlA==
X-Gm-Message-State: AOAM532r1K/vwomugWu8AwwbpaGdF7ZAPB7rDhWQ3n6Pbt4eRDoMhTUT
        lbVYow2ZFOrpJJ8eQQhLFkiScW7uRz/KcPLaapc=
X-Google-Smtp-Source: ABdhPJyMUehcufRfIX14setohpSGBpeP18SXvT0KMG1vCIhPypdsZ3bdLIhs3tcx/6SKNJM6VYHywe/u8k/I9as5dlI=
X-Received: by 2002:a0d:e645:0:b0:2f4:dbd6:261e with SMTP id
 p66-20020a0de645000000b002f4dbd6261emr26676104ywe.7.1652294408357; Wed, 11
 May 2022 11:40:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com> <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <CAHk-=wg8YgH1h3wrm9CtXff7rSewa+NE0Z5upb1GOE8XiTL9HA@mail.gmail.com>
In-Reply-To: <CAHk-=wg8YgH1h3wrm9CtXff7rSewa+NE0Z5upb1GOE8XiTL9HA@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 11 May 2022 11:39:56 -0700
Message-ID: <CAF6AEGusO9XAqHNatJLgV+wpVoyyLg1vHtUsnSkAxJeV7n3WNg@mail.gmail.com>
Subject: Re: Adding CI results to the kernel tree was Re: [RFC v2] drm/msm:
 Add initial ci/ subdirectory
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dave Airlie <airlied@gmail.com>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Corbet <corbet@lwn.net>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 10:33 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, May 10, 2022 at 10:07 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > > And use it to store expectations about what the drm/msm driver is
> > > supposed to pass in the IGT test suite.
> >
> > I wanted to loop in Linus/Greg to see if there are any issues raised
> > by adding CI results file to the tree in their minds, or if any other
> > subsystem has done this already, and it's all fine.
> >
> > I think this is a good thing after our Mesa experience, but Mesa has a
> > lot tighter integration here, so I want to get some more opinions
> > outside the group.
>
> Honestly, my immediate reaction is that I think it might be ok, but
>
>  (a) are these things going to absolutely balloon over time?
>
>  (b) should these not be separated out?
>
> Those two issues kind of interact.
>
> If it's a small and targeted test-suite, by all means keep it in the
> kernel, but why not make it part of "tools/testing/selftests"
>
> But if people expect this to balloon and we end up having megabytes of
> test output, then I really think it should be a separate git tree.
>
> A diffstat like this:
>
> >  7 files changed, 791 insertions(+)
>
> is not a problem at all. But I get the feeling that this is just the
> tip of the iceberg, and people will want to not just have the result
> files, but start adding actual *input* files that may be largely
> automated stuff and may be tens of megabytes in size.
>
> Because the result files on their own aren't really self-contained,
> and then people will want to keep them in sync with the test-files
> themselves, and start adding those, and now it *really* is likely very
> unwieldy.

It is missing in this revision of the RFC, but the intention is to
have the gitlab-ci.yml point to a specific commit SHA in the
gfx-ci/drm-ci[1] tree, to solve the problem of keeping the results in
sync with the expectations.  Ie. a kernel commit would control moving
to a new version of i-g-t (and eventually deqp and/or piglit), and at
the same time make any necessary updates in the expectations files.

BR,
-R

[1] https://gitlab.freedesktop.org/gfx-ci/drm-ci

> Or if that doesn't happen, and the actual input test files stay in a
> separate CI repo, and then you end up having random coherency issues
> with that CI repo, and it all gets to be either horribly messy, or the
> result files in the kernel end up really stale.
>
> So honestly, I personally don't see a good end result here.  This
> particular small patch? *This* one looks fine to me, except I really
> think tools/testing/selftests/gpu would be a much more logical place
> for it.
>
> But I don't see a way forward that is sane.
>
> Can somebody argue otherwise?
>
>             Linus
