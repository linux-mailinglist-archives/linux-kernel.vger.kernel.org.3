Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5161C4D6925
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351152AbiCKTk3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:40:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiCKTk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:40:28 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D2A172249;
        Fri, 11 Mar 2022 11:39:23 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2dc28791ecbso104805227b3.4;
        Fri, 11 Mar 2022 11:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mh7tQAL0n2bfKeDOiESqkHoSAFen1q88Q72P8o10M7A=;
        b=W8yPWXikTd3d8CG7OAaTfCsJUv8lX0jtJk/K204unOsnjmJqY5TXkjQbvznknMk/i2
         zslAJLXCzeIvSP5eYHxnbg0im1/T7xstqlhL5icnhxyXLFNT0yIZdR7te+P47YysSnZL
         17GMjtE3UqI1QjHCld1TOzg1VWO5vZ8DLz8fWSp6iTrvCoA9H/Piy6qBaS0T0SB3cMFO
         avasPngLRedqGgiXrJM1Y27Z2Kh63qZkbdRIF2jmWs0vlIugsGNZF+38iuv39CFwQNtb
         7GWb7gXFPcr/pAHsuCFN/LAkeRSNH1ugN1K2YHkpFc9Ka8VbAwKLI1T0Lo+001BZktah
         qMig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mh7tQAL0n2bfKeDOiESqkHoSAFen1q88Q72P8o10M7A=;
        b=3uOoigvNKpNS2Tn2Exih6JIWV2zxj7MqxB1wdhMyLBInF9yB9Xg4o+l6EI5idawyvg
         SzWkSmsm5IAUjMWMqL8lzX+W37O2LJc1D/Gskdrvv7rV4hvlaI1TUfM2Bl+Lt9bVZ8Z+
         QffadWymENacELnugNtEePehEIISlZaz7+WL9MaB5R/sNsqdUp8e4BrrKYDki6+YKw79
         SaFI0GlCGyyCaq0BTTQQJsd7CYsqyfamo2a7mOgMsIgGN+z7WFraIGYeYmy1lHilwi2V
         GlTB8x7xpN1vtqV9EyjKF0aNt4EPYoDUtkonujmRSTKp50hqNnOYyZeboLTinuES2YrB
         mPxg==
X-Gm-Message-State: AOAM533PlrlxxwJJX2zauO7AE11+vVtxBFnmFr6nV4ojeuy9xOUvOd+g
        r2JVmFR7nOHnf8N3TfhUp18OdEI/TUiAke/h8Zs+JgS+jbU=
X-Google-Smtp-Source: ABdhPJwdPCDYT3XTqvaxrFf38dMJcyUvh98/yM+YN1EMw/AaIwHtCxJvZ6LmxyfTNN3Xmd84OjgIZJ8+FQUkanYZdVY=
X-Received: by 2002:a0d:c645:0:b0:2db:9ed9:e6e5 with SMTP id
 i66-20020a0dc645000000b002db9ed9e6e5mr9835172ywd.292.1647027562199; Fri, 11
 Mar 2022 11:39:22 -0800 (PST)
MIME-Version: 1.0
References: <20211224161334.31123-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20211224161334.31123-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <c5ea7235-8642-6a89-f4ce-bd0861b6e4aa@linaro.org> <CA+V-a8tkhERx+8zDae5aWkNQ9Oxd1AamRL=i4TDC2X8RGgAo0w@mail.gmail.com>
 <5e13c1ba-0bf5-e360-c350-e7a1a1402350@linaro.org> <CAL_Jsq+CWKvkHMNhAa3o_rSLy_+AoHi6wkB3MRM8O3jJ5sG_Wg@mail.gmail.com>
 <c3e75761-e554-d8b1-f41d-f7bed5a0cce7@linaro.org>
In-Reply-To: <c3e75761-e554-d8b1-f41d-f7bed5a0cce7@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Fri, 11 Mar 2022 19:38:56 +0000
Message-ID: <CA+V-a8vVMu2JteQ9AwvsP=QG6dme+FuFVX5tWgvuEzBffhd1oA@mail.gmail.com>
Subject: Re: [PATCH] slimbus: qcom-ngd-ctrl: Use platform_get_irq() to get the interrupt
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        alsa-devel <alsa-devel@alsa-project.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 2:59 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 10/03/2022 14:14, Rob Herring wrote:
> > On Thu, Mar 10, 2022 at 4:42 AM Srinivas Kandagatla
> > <srinivas.kandagatla@linaro.org> wrote:
> >>
> >>
> >>
> >> On 10/03/2022 10:23, Lad, Prabhakar wrote:
> >>> On Thu, Mar 10, 2022 at 10:16 AM Srinivas Kandagatla
> >>> <srinivas.kandagatla@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 24/12/2021 16:13, Lad Prabhakar wrote:
> >>>>> platform_get_resource(pdev, IORESOURCE_IRQ, ..) relies on static
> >>>>> allocation of IRQ resources in DT core code, this causes an issue
> >>>>
> >>>> Are you saying that we should not be using platform_get_resource(pdev,
> >>>> IORESOURCE_IRQ, ...) on drivers that support DT?
> >
> > We should be using platform_get_irq(). (period, on all platform drivers)
> >
>
> Thanks, I see why is it preferred.
>
> Code as of now will not prevent drivers from calling
> platform_get_resource(..IORESOURCE_IRQ).
>
> Are we planning to enforce this in any way?
>
> >>>>> when using hierarchical interrupt domains using "interrupts" property
> >>>>> in the node as this bypasses the hierarchical setup and messes up the
> >>>>> irq chaining.
> >>>>
> >>>> Should this not be fixed in the DT core itself?
> >>>>
> >>> Yes the plan is to fix in the DT core itself (refer [0]).
> >>>
> >>> [0] https://patchwork.kernel.org/project/linux-renesas-soc/patch/20211209001056.29774-1-prabhakar.mahadev-lad.rj@bp.renesas.com/
> >>>
> >>>>>
> >>>>> In preparation for removal of static setup of IRQ resource from DT core
> >>>>> code use platform_get_irq().
> >>>>
> >>>> I would prefer this patch to be part of the series that removes IRQ
> >>>> resource handling from DT core.
> >>>>
> >>> Since there are too many users (which are in different subsystems)
> >>> getting this all in single series would be a pain. As a result it is
> >>> split up into individual subsystems.
> >> Am happy for this to be included in that series,
> >> TBH, this patch make more sense along with that series than by itself.
> >
> > No it doesn't. This is no different than converting to devm_* variants
> > or other cleanups to match current preferred styles.
> >
> > Treewide cross subsystem clean-ups are a huge pain to merge. Why would
> > you ask for that when it is clearly not necessary?
>
> Only reason for this ask was to understand how platform_get_resource()
> will change moving forward, if this is something that you are planning
> to include in your fix patches.
>
> I can go ahead and apply the patch, if that helps.
>
Yes please, that would be helpful.

Cheers,
Prabhakar
