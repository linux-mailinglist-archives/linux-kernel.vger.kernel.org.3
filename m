Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD00F5665C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiGEJD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230123AbiGEJDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:03:10 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AFEEB9;
        Tue,  5 Jul 2022 02:03:09 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31caffa4a45so30551557b3.3;
        Tue, 05 Jul 2022 02:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W8Wm30eRqjZo2DvnTiNrnXX7il5/XiX6XVUun1Gx7QM=;
        b=JWKcgYFNvzSnmT5hJZ53dIu3SLHoGOnTs2pSxOBhvcg73/bdybJ+exxxs/G5YeTNXK
         XxSuSK6MTE4C839oVxctGcLCddtTpqdLJrN5Bmx/VFX8xvsgvtLoDR3ctPPEPKs7//li
         nJQ0SyyITr+PlaUqPXy1c+8oGs1uQtb2QongaSGfxDMnl5qqWCncSGwtbro5YaaceLI1
         qtEHf4/NJSDlHw33R/zGvvPrP0I/t50HqjM8uq/8ruTWHPKxd/xyKiS7a3ZpuEo1/i5K
         6DFTDS6XjwXmRybKb4kDwNClXZhtyNCFMSvPsoZFL8SA6RgWGdK7avVznlbzq2GSLX93
         CG2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W8Wm30eRqjZo2DvnTiNrnXX7il5/XiX6XVUun1Gx7QM=;
        b=R3pP0ns4Pe/q7HIob1OHpjDQ0RIeg75y3yiTUK2kjIXvr7f0TAlFIIo7zVitlJkvaP
         JpyJJJH0fJf1cLdzjr0/Z0rdHulss821Ja9FF8M2hwt6xVi6hsN8bWoD1n0SoozZT2xD
         Baio57Cjzlhk7kbKfrFBVmZ988gjkQa5ZWa0B3zaV1N85hCJlWRBMhdEYWgB2yirPYkU
         8JxUUy6AEDfCK9COtuHIHw1nGFKJjk3Q/RDiuVuhlG+v0UBCqlBPtrqyNhzl63+sX+nQ
         gAKYRA89XXD7UWhzRwCzryOKm1cXk80pLygML/79GMh22CfCT82B0a0aiyzPI83tiOqB
         8gQw==
X-Gm-Message-State: AJIora9l/ZPF/6bMN6jLW/ZXKex2m5MUmtfCxjOpOMyv7GeeunRO7oxx
        zJVMc25RpIlfXgl1wTnFpj02xbON1wfPcC4WjFc=
X-Google-Smtp-Source: AGRyM1v2CRG+DKXHIE5wryGPKVWEqDbJO+C7vYv5XEX7bEg0r5zo5hw9c4p4l7Taip7CR4eGcodROUoYssgTudunweE=
X-Received: by 2002:a81:8397:0:b0:31c:8a02:3f6d with SMTP id
 t145-20020a818397000000b0031c8a023f6dmr13860042ywf.486.1657011788255; Tue, 05
 Jul 2022 02:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <YsGVa8KFmdvGY92e@debian.me> <20220704034041.15448-1-bagasdotme@gmail.com>
 <CAHp75Vdg=NG9fnd0EQWg5D4WoW9hGJM+MMBRLSacgQUptuGe9Q@mail.gmail.com> <5418fb0b-47e2-d251-a6c7-a9bacbaf3dc1@gmail.com>
In-Reply-To: <5418fb0b-47e2-d251-a6c7-a9bacbaf3dc1@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 5 Jul 2022 11:02:32 +0200
Message-ID: <CAHp75VfEzNJSAJrjcY_cUj7=k4fNL+TcpEWc9k=wSWB5qb8wJg@mail.gmail.com>
Subject: Re: [PATCH v2] Documentation: bno055: separate SPDX identifier and
 page title
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Linux Documentation List <linux-doc@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrea Merello <andrea.merello@iit.it>,
        Jonathan Cameron <jic23@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        jmondi <jacopo@jmondi.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jul 5, 2022 at 3:13 AM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> On 7/5/22 02:49, Andy Shevchenko wrote:

...

> >> Cc: Jonathan Corbet <corbet@lwn.net>
> >> Cc: Andrea Merello <andrea.merello@iit.it>
> >> Cc: Jonathan Cameron <jic23@kernel.org>
> >> Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> >> Cc: Lars-Peter Clausen <lars@metafoo.de>
> >> Cc: Rob Herring <robh+dt@kernel.org>
> >> Cc: Matt Ranostay <matt.ranostay@konsulko.com>
> >> Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
> >> Cc: jacopo@jmondi.org
> >> Cc: linux-iio@vger.kernel.org
> >> Cc: devicetree@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org (open list)
> >
> > It's a very noisy Cc list which will go in the git history. Instead,
> > use --to and --cc parameters of `git format-patch`. Maintainers
> > usually use `b4` tool that adds a Link tag to the patch itself on the
> > Lore archive which will keep track on the Cc list anyway.

> Thanks for reminding me.
>
> I think something like `b4 am -l`, right?
>
> Anyway, should I resend (reroll)?

Depends on the maintainer's wishes. Maybe they can drop them when
applying, I dunno.

-- 
With Best Regards,
Andy Shevchenko
