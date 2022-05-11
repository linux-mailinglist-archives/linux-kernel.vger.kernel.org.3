Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5552344C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 15:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243755AbiEKNdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 09:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239272AbiEKNdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 09:33:45 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A100C5D8A;
        Wed, 11 May 2022 06:33:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id i20-20020a05600c355400b0039456976dcaso2542409wmq.1;
        Wed, 11 May 2022 06:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ksy6PHWBR9sVN5QwB4AlZVRAOWKrGBlUQcJanMtrZ1E=;
        b=mTDzNH2v16tSY8KR9n8XYuM9TmRFKMujDftxz6TIj6GtwaEOz1nHkwh9I23i0T3HdH
         FkRLXEX5SaHr/3aMMMm7OL/M/d+MaFHllgpxQm/fpYTPdAYgalEfYfqkuEUtmA93LCsz
         KTJ+dEbvn9aYPq/m/ywGmSofzC6L8X7kJ7GhdUszaeH8/X2mdeXpmjdv+8MkkdGJOkK5
         Gy7x53+7PYcENNJD+lBQtTteeSN2J6383EG33+HODXzESWqPsDZuh/g7svvE1fImNNif
         2mBzCB9nkBhxa2kVXx1d4gGeBI3j+8uRsqTkVokwRaI4RP3uLnVC7AdoYvSvrUEYrboU
         /Gew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ksy6PHWBR9sVN5QwB4AlZVRAOWKrGBlUQcJanMtrZ1E=;
        b=Te3yLYRzB0NysHtcEWCB1gaLaCzJQhVcX2c37IM4nrcptIbn9r3dgV13XCEqIFOJRJ
         oqYGgUiw0Ba0vfr+99c2p/uWgk1hTe6K4l+VpxbHlH7zLDxo0W25vzaLT/judCJ7HR+D
         ZLbHXY09DHnEe/2d5HCB/CAcn50xTDTQhNFlbqkfpJ5AaEqqJV6yKEr7+Gxp4cHA1kj+
         wW9Rj8jnsZU1WAhXwe9m4atuqrO4pxz0BTJ8YPeVCvSoVhMWqrmt5+g8OcZQhA9d2N6q
         /fuQD7Q+SG4dQje7j2RJoGDJiDJwKWLoiC1Aqb0BpaaPkgrTmTS2fhVozV8FZ/RQYI6A
         trcA==
X-Gm-Message-State: AOAM533dibntHCbFS9zUh5lod72P/g6u0HTzGisCZ9cJT7vj7brDmomj
        lxgAk1K3yGM/iLAV9D3CEOAPHeS7mCtr2oZnXC0=
X-Google-Smtp-Source: ABdhPJx0HsNmN6aXZ/qgME3QoitJWXJwbYBVMkQDcpQpvHLbKrddWJTuykdpvOlgA7X5TIZWTNkDfYvdnRN4NLyIp6Q=
X-Received: by 2002:a05:600c:154d:b0:394:8d64:9166 with SMTP id
 f13-20020a05600c154d00b003948d649166mr4952413wmg.102.1652276022494; Wed, 11
 May 2022 06:33:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220510070140.45407-1-tomeu.vizoso@collabora.com>
 <20220510141329.54414-1-tomeu.vizoso@collabora.com> <CAPM=9tzLR-wsLhg2ikGjoK06s-ju5XWa1rtPPiUpN=pwD1vgtA@mail.gmail.com>
 <YntWQIXSqMCd6TYV@kroah.com> <1255a66a-121d-988a-19a7-316f703cb37d@mailbox.org>
 <YnujG0nkF0U6d5kd@kroah.com>
In-Reply-To: <YnujG0nkF0U6d5kd@kroah.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 11 May 2022 06:33:32 -0700
Message-ID: <CAF6AEGsmD-CNGj4bAE952JQpquaWA+Nxo5TGpFiHqaPK9doP-g@mail.gmail.com>
Subject: Re: [Freedreno] Adding CI results to the kernel tree was Re: [RFC v2]
 drm/msm: Add initial ci/ subdirectory
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@mailbox.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Dave Airlie <airlied@gmail.com>, Sean Paul <sean@poorly.run>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 4:50 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, May 11, 2022 at 12:26:05PM +0200, Michel D=C3=A4nzer wrote:
> > On 2022-05-11 08:22, Greg Kroah-Hartman wrote:
> > > On Wed, May 11, 2022 at 03:06:47PM +1000, Dave Airlie wrote:
> > >>> And use it to store expectations about what the drm/msm driver is
> > >>> supposed to pass in the IGT test suite.
> > >>
> > >> I wanted to loop in Linus/Greg to see if there are any issues raised
> > >> by adding CI results file to the tree in their minds, or if any othe=
r
> > >> subsystem has done this already, and it's all fine.
> > >
> > > Why does the results need to be added to the tree?  Shouldn't they be
> > > either "all is good" or "constantly changing and a constant churn"?
> > >
> > >> I think this is a good thing after our Mesa experience, but Mesa has=
 a
> > >> lot tighter integration here, so I want to get some more opinions
> > >> outside the group.
> > >
> > > For systems that have "tight integration" this might make sense as pr=
oof
> > > that all is working for a specific commit, but I can't see how this w=
ill
> > > help the kernel out much.
> > >
> > > What are you going to do with these results being checked in all the
> > > time?
> >
> > Having the expected results in the tree keeps them consistent with the =
driver code itself, and allows putting in place gating CI to prevent mergin=
g driver changes which make any of the tests deviate from the expected resu=
lt.
>
> Shouldn't "expected result" always be "pass"?
>
> If not, then the test should be changed to be "skipped" like we have
> today in the kselftest tests.

No, we want to run tests even if they are expected to fail.  This
prevents the scenario of a test getting fixed without being noticed
(for ex, developer was working on fixing test A and didn't notice that
the fix also fixed test B).  If a fix goes unnoticed, a later
regression would also go unnoticed ;-)

I was skeptical about this approach at first with mesa CI, but having
used mesa CI for a while, I am now a firm believer in the approach.

And ofc we want the expectations to be in the kernel tree because
there could be, for example, differences between -fixes and -next
branches.  (Or even stable kernel branches if/when we get to the point
of running CI on those.)

> And how about tieing this into the kselftest process as well, why would
> this be somehow separate from the rest of the kernel tests?
>
> > Keeping them separate inevitably results in divergence between the driv=
er code and the expected test results, which would result in spurious failu=
res of such CI.
>
> Again, "pass" should be the expected results :)
>
> > I expect the main complication for the kernel will be due to driver cha=
nges merged via different trees, e.g. for cross-subsystem reworks. Since th=
ose will not go through the same CI, they may accidentally introduce incons=
istencies. The ideal solution for this IMO would be centralizing CI such th=
at the same gating tests have to pass regardless of how the code is merged.=
 But there's likely quite a long way to go until we get there. :)
>
> We have in-kernel tests for the rest of the kernel, why can't you put
> your testing stuff into there as well?

We could ofc put a lot more of the gitlab yml and scripts into the
kernel tree.  Probably all of i-g-t is a bit much to put in the kernel
tree.  Not to mention I'd like to see this expand to also run some
deqp and/or piglit tests, which is definitely too much to vendor into
the kernel tree.

The approach of this RFC was to put only what was absolutely required
in the kernel tree (such as expectations), and then link out to an
external drm-ci tree[1] which has all the necessary scripts and yml
for building and running tests, to avoid having to put a whole lot
more in the kernel tree. (We should be specifying exact commit-sha for
that tree, IMO, as it controls the version of i-g-t which gets used,
and we need to be able to update expectations in sync with an i-g-t
uprev, for example when new tests are added or if a test fix caused a
fail->pass transition.)

BR,
-R

[1] https://gitlab.freedesktop.org/gfx-ci/drm-ci

> thanks,
>
> greg k-h
