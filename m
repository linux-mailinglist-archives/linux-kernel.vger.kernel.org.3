Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BDC4D3087
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 14:51:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiCINuS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 08:50:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbiCINuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 08:50:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51AD114FFFB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 05:49:16 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id n31-20020a05600c3b9f00b003898fc06f1eso3439890wms.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 05:49:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hEp4/u1ISx6prQ1+5HYrYVrc6JvgAFZ71gig22l5Las=;
        b=oLu5m4G/KWOAsm3K5P6GU7uvlI6qVJgVM/Lq6PB0Y+0LmStBo41/4SsVMuPSs/1kq1
         GaPXXQE5GNtRHcaxunMvSTJfVlrJyvgM/L6kBN1KMPXiTE3ZoMN0p1+VaQvUmkvbZyfd
         1+sIpKDdlmiUt3E8zKJLKX6oJiERHTjNIKiRziLCh8LaGc/ZElKyi0j+Ie5umaFL6wIL
         6RzTPdgvieiJSWJCaAHfjcQnuXfWm6NLcfHty3F82ifA1mYCxlRAtIm6BSPlAjxHBiqK
         WxUv33k4o3v0tYmZtf+Xs+FXozi28WBL+WUA6k4/l0rkQW5ceuqbS53j1fic5reAOa0A
         8+jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hEp4/u1ISx6prQ1+5HYrYVrc6JvgAFZ71gig22l5Las=;
        b=uBtijFLbvY8NY1qqEdOKvf9U6xto3zS6i+Jbw6//pH4L9RysTQNXiRHzQac3fCbt2U
         Pqks9XzIKhn+M7B/ycIAWtKKG/7LqDzTuqPUEOv4ZJpg7mqpiv99WPVwfaj3vcyVYEVF
         VbOCig06y2HXsDTUoyEVjbhRJtE7Txruv0NHVsTEnzecnjOSiKaXcRZHXu+R667ZCA7D
         Vfc3DuJDp8+YhraZ78xNl1jdbdmdtZs9lmOD/pmcule+NA0TxlfZkRzdIj4qT6qQXbZH
         KRVKpviP99Qj0SDLejjyLOsWm6fO3idXPdxnH3SmMpyhZBaNp8MpZgLQnmLqrVDbHKYo
         iozA==
X-Gm-Message-State: AOAM533vMzVAX03t0tbtpRzzJ6VwkiNKawPj6RkwUqTHg/VHg+XMD18q
        MSA9UxI8XOF5myrW5dplqGXndAuS9hSIMGI9OSQDAw==
X-Google-Smtp-Source: ABdhPJxyflo0xL3BS2EgPzN6gokR3hCnb1YBfMDLmPh1P4pSUXAbtGWXjS+Lt+8QbtGTrgoWm3KDa6PiTZHUUCt3fh0=
X-Received: by 2002:a05:600c:1548:b0:389:cde3:35cc with SMTP id
 f8-20020a05600c154800b00389cde335ccmr4249426wmg.133.1646833754937; Wed, 09
 Mar 2022 05:49:14 -0800 (PST)
MIME-Version: 1.0
References: <20220309113117.1126-1-mike.leach@linaro.org> <YiiUePW2DESezPLo@bogus>
In-Reply-To: <YiiUePW2DESezPLo@bogus>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 9 Mar 2022 13:49:04 +0000
Message-ID: <CAJ9a7VgvLF7304DLtKsDsNcq9hJo9n-Ek049KiWG1tMAT9ox3w@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/1] arm64: dts: Juno CTI device tree additions
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     liviu.dudau@arm.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        linux-kernel@vger.kernel.org, lorenzo.pieralisi@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        robh+dt@kernel.org
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

Hi Sudeep,

On Wed, 9 Mar 2022 at 11:50, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> On Wed, Mar 09, 2022 at 11:31:16AM +0000, Mike Leach wrote:
> > This is a resend of a patch from some time ago (04/2020)[1] which seems to
> > have fallen through the cracks - most likely as last time I mistakenly
> > tagged it as dt-bindings: rather than dts:
> >
>
> Quite likely, but I vaguely remember this and I assume the bindings had
> on-going discussions at that time.
>
> > I am planning a release of additional CTI configuration examples, which
> > include some for Juno - so this is now needed upstream to support that work.
> >
> > Patch unchanged, other than a correction to the subject.
> >
>
> That may not work. I haven't tried applying but it would be good to
> post it rebasing on -next at this moment or after v5.18-rc1 is released.
> I have already sent v5.18 material, so I need to queue this for v5.19.
> So preferable post the rebase version at v5.18-rc1 in 2+ weeks time.
> We have had some restructuring including the new scmi version of DTB
> in the mainline or queued in -next at the moment.
>

I did check it on coresight/next (5.17-rc3) and it was fine.

However re-doing for 5.18 is no problem as anything that depends on it
will be on there or later anyway.

Will rebase and  repost when 5.18-rc1 becomes available.

Thanks

Mike

> Sorry for missing this last time.
>
> > [1] https://lore.kernel.org/linux-arm-kernel/20200415201330.15894-1-mike.leach@linaro.org/
> >
> >
> > Mike Leach (1):
> >   arm64: dts: arm:  Juno - add CTI entries to device tree
> >
>
> No need of the cover letter for one patch, just post the patch next time.
>
> --
> Regards,
> Sudeep



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
