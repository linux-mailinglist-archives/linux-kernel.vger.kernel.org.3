Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29CC5AC162
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 22:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiICUf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 16:35:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiICUfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 16:35:55 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E584DB6F;
        Sat,  3 Sep 2022 13:35:53 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id p16so9997792ejb.9;
        Sat, 03 Sep 2022 13:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=o1W5HEvQkI52jMHmGzSP14GXStCG+OfGJsNyrQi6xOc=;
        b=WBPGSjO8Zj5EvG7pLAD9AhZpr9dfUJ0G1d/8S03eVMS09iqDVm3rSmUOoCKQ8MUACc
         nmujmsYhaPhM9J6JvlEKq8e3PX2bvvKUDPGJRlD3ZBprfOaLmx6uodsonsImMUe36Rlk
         xZFzjhiHoN+JLc7StZSDnee/csD+88PyICsR9Oye7RiNB0t8Kyb9H7M3WmXqABYnBNDO
         L67AlWzUIhmzzOnn2iygQBOCHQaQ5n0K/OlSC33un612HyPKF71cb1Yva0FGegFw9Of4
         nK5s0HOni/nbXnuCzCydj0KuBEvR206zmp20Ce7Mosq0CACyF81XtR5u2jvqGg+cQVLt
         s2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=o1W5HEvQkI52jMHmGzSP14GXStCG+OfGJsNyrQi6xOc=;
        b=KRy4apV2/1JnKUFD1Q0qlyY6j1MNQ/5A3L/qeDQKGMno/6K2QFvL4YTwrGkJeImrdj
         Fv7UEhkX2RtW0yCjraAb/XKvAg4OXXfLR6MlpMNeGZphyTCJLBSjp0pyNJddBr628J0G
         fcA5tbkrBW/8d7KMekZ+dVnZQWpw+abiCavqyClZb1iv01uJa2ODcPssX6bEAVy88TaE
         uLKlKqHeWEXWGsBTqrhWxHsG/Oc/48qsdYRImDejBa0vGiLQGhkTJ6j/LrWK/DS8SQOn
         ReMmWG1ORum5neH27Qyyi66ZHNxiNOe8n8uWT+lz3hISNfU8AbL4cbH+LlIRpauZIIzC
         c7/g==
X-Gm-Message-State: ACgBeo06QNUFo49IDA+g6pzbITOMTafl+yhfMbHpm8nnXtTIsxZ4oif7
        XgzlJ2B/SUBWCy14XyIikixQKqvut60oXN5iPLc=
X-Google-Smtp-Source: AA6agR6QLG961Ixs7ILW/ahcGV52DV/sQJ5j9+k2F9rB2hX9ZzdzH4sV2Kz1xirkrti+66lWa0n+Ynz4nbh05HgbLoA=
X-Received: by 2002:a17:906:7307:b0:73c:c9ee:8b5c with SMTP id
 di7-20020a170906730700b0073cc9ee8b5cmr30499934ejc.310.1662237352286; Sat, 03
 Sep 2022 13:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1589528491.git.viresh.kumar@linaro.org> <CAJiuCceftArjKPyiEW8AnT5TtuCJFsRGGA-_8y2zG5GDTxHO4Q@mail.gmail.com>
 <CAJiuCcejjaM=+XWsmOe93idbC8TyyxLj30+Lf+5C=yv=hxT80g@mail.gmail.com>
In-Reply-To: <CAJiuCcejjaM=+XWsmOe93idbC8TyyxLj30+Lf+5C=yv=hxT80g@mail.gmail.com>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Sat, 3 Sep 2022 22:35:40 +0200
Message-ID: <CAJiuCccmVtyHbd7ZvEwmw67aesyPe=eVzSE5z_KjCC5__7brjQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] opp: core: add regulators enable and disable
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     k.konieczny@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        "open list:ALLWINNER CPUFREQ DRIVER" <linux-pm@vger.kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On Thu, 21 May 2020 at 14:23, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com=
> wrote:
>
> Hi,
>
> On Fri, 15 May 2020 at 14:00, Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.c=
om> wrote:
> >
> > Hi Viresh,
> >
> > On Fri, 15 May 2020 at 09:57, Viresh Kumar <viresh.kumar@linaro.org> wr=
ote:
> > >
> > > Hi,
> > >
> > > This series reintroduces the usage of regulator_enable/disable() to t=
he
> > > OPP core after the previous attempt was reverted [1] shortly after ge=
tting
> > > applied. This time the regulator is enabled only after it is configur=
ed
> > > by the OPP core.
> > >
> > > Marek, Kamil and Cl=C3=A9ment: Can you guys please test this out and =
report
> > > if this doesn't work as expected ?
> >
> > I have reviewed the patch and it seems fine for my use case.
> > Unfortunately I can't test it until next week.
>
> Ok, before the patch the regulator was released by regulator_late_cleanup=
() :
> [   33.756849] vdd-gpu: disabling
>
> Now it works fine and the vdd-gpu is no more disabled.

Today, I compiled my kernel without any program requiring GPU
computing at boot. This makes the dev_pm_opp_set_rate() to never be
called and so the regulator is not enabled before the regulator
framework switches off all the regulators that haven't been enabled.

Unfortunately switching off the GPU regulator makes my board hang..

I'm not sure what is the best approach to fix this.

Is it required that the dev_pm_opp_set_rate() must be called one time
at the GPU driver init?

Panfost already calls devfreq_recommended_opp() and dev_pm_opp_put()
but that doesn't trigger dev_pm_opp_set_rate().

Thanks for your help,
BR,
Clement


>
> Tested-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
>
> Regards,
> Clement
>
> >
> > Acked-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> >
> > Regards,
> > Clement
> >
> >
> > >
> > > --
> > > viresh
> > >
> > > [1] https://lore.kernel.org/lkml/20191017102758.8104-1-m.szyprowski@s=
amsung.com/
> > >
> > > Kamil Konieczny (1):
> > >   opp: core: add regulators enable and disable
> > >
> > > Viresh Kumar (1):
> > >   opp: Reorder the code for !target_freq case
> > >
> > >  drivers/opp/core.c | 39 ++++++++++++++++++++++++++++++++++-----
> > >  drivers/opp/opp.h  |  2 ++
> > >  2 files changed, 36 insertions(+), 5 deletions(-)
> > >
> > > --
> > > 2.25.0.rc1.19.g042ed3e048af
> > >
