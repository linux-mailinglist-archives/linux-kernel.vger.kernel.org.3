Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A980D4FE580
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 18:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355739AbiDLQEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 12:04:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiDLQEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 12:04:05 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317804E3AE;
        Tue, 12 Apr 2022 09:01:47 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-2ec42eae76bso56686857b3.10;
        Tue, 12 Apr 2022 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zr2Ssv/gnXtfzKHsN3K3U/E/+u6SWo2WOlNj3rXzKdU=;
        b=N73opXIemhwd9lsPMxyl2TF8cnBblRMKjxjWwy5eKuK25lFRXEHA150z5ixB6QUcDM
         DxkR53wMaDQpN77c4IM435HXM6GdD+5zlmAJKTrJL/WpCfUjk8mDIl9OFvwkZP2EO8/H
         C+Knu4qGeIyOwOUeGibGS/6ufRCsljqEsStIxWstzZQn4WTh4vmsQ+YNiGlf6flUUQPa
         2ZpWZWtvpzJpm7J3fB2ew9fE6qPmooW33rGBT5zDzyteraa61pFZaa40r9WCAR4nU8So
         zP4vZ231HbbcI5EJVZQpWiMDMW5VPRSp57BBUv8HYiYvZwXTB+C4ME+mV+qLiwnIBJjy
         F6IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zr2Ssv/gnXtfzKHsN3K3U/E/+u6SWo2WOlNj3rXzKdU=;
        b=c7AFgOglzkumSEWSAG9pV50jDs5PxEHuAp2IBHaDS8D4YldB7DHcTbX4BU7nkllA7e
         SADfuIFruXA2ZsGSbXfQQMkMrdL7Lhz/MYb/1Z4Yv4ryhMRM4aCUDVfGInKCo/K63XdC
         et6N0djr/F8QtRUvHR/s62Nx4WFUJDKFe+XeBCSstOtSbKHzj+PQzjO5k0XC+BM/34Oq
         svnQumb/vkgjFEUf2hbpYn2+iI7k5aPYspPvZEtXhMSgmIPpzibFSjG+jI5Ihn4nKjAF
         fKohDkRK0+Ohs9fPVulDOLvthh+nQMVmvYAQMixXFCrhK8I/Peu/1G1Jnvi13i9nTvE5
         aMEA==
X-Gm-Message-State: AOAM530ky++b0Zp6duUMcvRxIBAf5a2RblTcGDKA/ArDKsfAFQ8gDQSi
        JYmATo9cy4oP1rMXkMF9JqXR1nSXyih+3TUI+Qc=
X-Google-Smtp-Source: ABdhPJwtMJHcAcD9ZKTfy3iWVDIB38jk6WrG07hOHdYV0zDDiunOqR7nLxXoW99s3mTWXa7cQjHIcqeKd/+t1ei92aI=
X-Received: by 2002:a81:52c8:0:b0:2ec:8fa:ebfd with SMTP id
 g191-20020a8152c8000000b002ec08faebfdmr10328943ywb.502.1649779306121; Tue, 12
 Apr 2022 09:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220406014842.2771799-1-briannorris@chromium.org>
 <CGME20220406094558epcas1p4fa0c77a5acd6b73c192f6b19136cd5f9@epcas1p4.samsung.com>
 <20220405184816.RFC.1.Ib865f199d15221eab4ff77f70bd7e9e2eb04d32f@changeid>
 <c8664eae-4a10-bd1a-8898-01b96c05331e@samsung.com> <CA+ASDXNx+nwVKuisMAsHEKLfd=hqBzZmhFxphcYUF=bamqN2kA@mail.gmail.com>
In-Reply-To: <CA+ASDXNx+nwVKuisMAsHEKLfd=hqBzZmhFxphcYUF=bamqN2kA@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Tue, 12 Apr 2022 12:01:34 -0400
Message-ID: <CAMdYzYrZAWKq51vueAhjF4pBjfxmjAHXUsp5SRF_i2wh6ma5_A@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] soc: rockchip: power-domain: Manage resource
 conflicts with firmware
To:     Brian Norris <briannorris@chromium.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        linux-pm <linux-pm@vger.kernel.org>,
        Doug Anderson <dianders@chromium.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
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

On Fri, Apr 8, 2022 at 11:36 PM Brian Norris <briannorris@chromium.org> wrote:
>
> Hi Chanwoo,
>
> On Wed, Apr 6, 2022 at 9:38 PM Chanwoo Choi <cw00.choi@samsung.com> wrote:
> > Instead of adding the specific function for only rockchip,
> > how about adding new function pointer (like block/unblock or start/stop and others)
> > into 'struct generic_pm_domain'? And add new pm_genpd_* function
> > to control the power domain.

Good Morning,

As requested, I tested this on the rockpro64.
It solves the issue of the hang on initial frequency adjustment down to 400mhz.
It seems there are still issues with the ddr4 calculation in mainline
atf, as when we jump back up to 800mhz it hangs.

Thank you, this is greatly appreciated!
Tested-by: Peter Geis <pgwipeout@gmail.com>
on rk3399-rockpro64

Very Respectfully,
Peter Geis

>
> I suppose that is technically possible, but I'm not sure it makes a
> ton of sense.
>
> First, genpd doesn't seem to typically expose operations directly to
> client device drivers. It's mostly about abstract handling of the
> dependencies of "how do I power on this device?" behind the scenes of
> things like pm_runtime_*(). I guess maybe something like
> dev_pm_genpd_set_performance_state() is an approximately similar API
> though (i.e., a genpd operation exposed to client drivers)? I could
> try to go that route, if the genpd maintainers think this makes sense.
>
> But secondly, this isn't exactly an operation on one power domain.
> It's an operation on the entire power controller. I suppose I could
> make a new domain here for the memory controller, and teach that
> domain to implicitly manipulate all the other domains provided by the
> PMU, but that feels like a fake abstraction to me.
>
> Lastly, and perhaps least importantly: this likely would require a
> device tree binding change. So far, the memory controller hasn't had
> its own power domain. I guess one could argue that it has some
> similarities to a power domain, albeit one that is managed in firmware
> -- so maybe this is a reasonable "bug" to fix, if it really comes down
> to it.
>
> > Because it is better to use subsystem interface.
>
> I don't agree this is universally true. It makes sense when there are
> truly abstract concepts represented, which are likely to appear across
> multiple implementations. Or maybe if the object model is complex. But
> this operation seems very SoC-specific to me, and it's pretty simple
> to implement this way. Or, do you think this is really something that
> others will need -- pausing (and powering) a power controller so
> another entity can manage it?
>
> I guess I'd also like some thoughts from the genpd maintainers (CC'd),
> of whether this seems like a good fit for a new genpd callback and
> API.
>
> Brian
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
