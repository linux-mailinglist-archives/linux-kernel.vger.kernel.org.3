Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8939153D43B
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 03:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349853AbiFDBMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 21:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbiFDBMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 21:12:31 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A41E0FB
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 18:12:30 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id p130so2921942iod.0
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 18:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7HmAcc2+RoDxk7f9Rs3Ffi6CA3TIxfq1pKNEK2z9OK0=;
        b=mtr2P2+EYULhNxrqRuSgrTdWXC8avZSXIDKJS5U/NUBA+46r//VQkbLzDURVBtc2SY
         GU1DxLhVJN6/SBoZoeSiBQwek6QmHylcN1a674e0EawBKtASE5QzgsjLY1IgsEY5nIKe
         lQi7uT2zkasnDfog8B2hpkm3nnQ+Ocb4hTxCg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7HmAcc2+RoDxk7f9Rs3Ffi6CA3TIxfq1pKNEK2z9OK0=;
        b=D9cyYsWMZdM+idNArKfrEA3u+9ilVxoG0P1W7SaQSsMrlKUXaxwalsr2Zezf0Y+Iee
         IoHXXB3esLcfWfq/cpnP4fQtvOcS/eJ6hvE1IFHZjqYxAi5yb35flYcpXWzn56M5cmXx
         ANs9yE6dtwJZq+BtjlCQORX4FestdgHz3HM5eFRXV5qlieVtIgVt3GV+kPImoitbJzk2
         MI+GTJVnIkUjB4W4uunUF3EjpGEjTkqI5S8PPRer6HrhYv3ihQbDnWoA1N0guM2hobN4
         YDi85R1yAm6B5TgCw+K7UYqc2yvxxtUSnH34ejg7iQJVWAfkG2Ar4NFXoK7E6mjoaZH/
         tAZQ==
X-Gm-Message-State: AOAM533OSfNuBo2ChbSZ5CpK5guBpjCysyB5V7utpGAbNVoetWciDZwZ
        1edsEcaRqeGkuC8Wi5JABMLkgoXDivAkKu6OBvdb0A==
X-Google-Smtp-Source: ABdhPJz78nI+FW/CTAVVqaxYOkz7qz3GR5ULi/3muQQSNvfryRhsl0pm7omddjpYTnsFAzY8ssAubxbDMwYzEhZLjFU=
X-Received: by 2002:a05:6638:411f:b0:32e:a114:54e with SMTP id
 ay31-20020a056638411f00b0032ea114054emr7095723jab.82.1654305149395; Fri, 03
 Jun 2022 18:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220603151600.19cfa617@canb.auug.org.au> <CAF6AEGtYS1LYowjf-OiN-C1+4JFTWwOOpP__4iDLo-dFy0t0Tg@mail.gmail.com>
 <20220604103757.29d0b048@canb.auug.org.au>
In-Reply-To: <20220604103757.29d0b048@canb.auug.org.au>
From:   Rob Clark <robdclark@chromium.org>
Date:   Fri, 3 Jun 2022 18:12:33 -0700
Message-ID: <CAJs_Fx6KMeKZhyFjfJgwDiJv5xHm-xxQ6YSMWNsaRZz=CQLrBQ@mail.gmail.com>
Subject: Re: linux-next: Fixes tag needs some work in the drm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Clark <robdclark@gmail.com>, Dave Airlie <airlied@linux.ie>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Haowen Bai <baihaowen@meizu.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 3, 2022 at 5:38 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Rob,
>
> On Fri, 3 Jun 2022 07:58:14 -0700 Rob Clark <robdclark@gmail.com> wrote:
> >
> > will the truncated subject confuse the scripts that look for patches
> > to backport to stable, ie. do we *really* have to rewrite history to
> > fix this?
>
> I don't know what scripts are being used and what they expect, but our
> documentation says (Documentation/process/submitting-patches.rst):
>
>   If your patch fixes a bug in a specific commit, e.g. you found an issue using
>   ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>   the SHA-1 ID, and the one line summary.  Do not split the tag across multiple
>   lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
>   parsing scripts.
>
> But, that being said, doing the rewrite is up to the maintainer.  You
> could just look at this as a learning experience and do better in the
> future.

Ok, I'll leave it up to airlied

If you don't mind sharing, what is the script you use?  We could
perhaps add it to our WIP CI..  a script is much less likely to miss a
check than a human, so I'm a fan of automating these sorts of checks
whenever possible ;-)

BR,
-R

> BTW, my script reacted to the missing closing quotes and parentheses,
> which is more like to confuse any scripts that the actual truncation.
> --
> Cheers,
> Stephen Rothwell
