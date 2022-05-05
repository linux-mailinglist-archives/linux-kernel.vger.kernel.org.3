Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01DCB51BC52
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 11:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353965AbiEEJo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 05:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353943AbiEEJoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 05:44:21 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEF64578C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 02:40:40 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2ef5380669cso42055697b3.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 02:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mIXApjkzHf008Qogv/wyqEj1PJzEdOobETAHN9U7xwk=;
        b=a8NoptyXEyno9fbhzXc6CEcSoGjIx2hTiwvjhOsKDAkAUSdgm6+7ct0gg6MC9SC3Rz
         mHjYPPb75DiewFPudKKtAzLIBzPGrZ1YDFSV8YC68BDCmFdakdGk/GIQNTrkHVDpQiQL
         IinJhz6XLeQA6fTCuQwwLdglzx7yOeNNepQIDSUi7YZ8eQnXr6ThAYXXyuvaczW70PRX
         0pa28Bqw0MKwDTvbV72yRbaBAXMZSN3pFcEZMAH+r3VIf1fHsUW9wGSZT5/0Uu2IlpGB
         z2Sp7gAhAxVhTQFFLuaOMYzPXZL+CSgVhgbYbkXc57bofm3l0EsUvdidt2dWigspO0Vx
         1dhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mIXApjkzHf008Qogv/wyqEj1PJzEdOobETAHN9U7xwk=;
        b=4e8W9AHvJ904gQKanvVgBmbzYZUv2ZXfYsEj7acmMPrJgm9fPPxOXZUs0qUy/ecAhl
         ibphE7wv3Cpn5est6oTy9dIYoBmXC3sh2wO5ahjJM1TB8U/lIFHXfQp+m9UwqpqMXaNy
         E8R9TqTaYkytWfdTNYUl4DevEuDiW5G3RqeCAxKJX7R3oQ2gaxwiv/odmAx4JTkGENev
         FmkROMkqu274PrYBCf3VcwDdwYWKO/Z/Z8darI49Txdqp8gNJZ0D6xDnbXBFbCr8GwbU
         gu+a1p7Amv+h4oYfM5n6bkT7ssXrzPUjXosFO/QTai7Yhm7lw6JW5X7DDLtU0coWXQ98
         ga7w==
X-Gm-Message-State: AOAM531nb0mXUfTIZxpyDPuHTd6wxNODyDxM0Vc7evo3IqBery7v+lMy
        PjTrcqgRd97qXErvLGxcF6iMO0nmhqVVTJWuRmH9yw==
X-Google-Smtp-Source: ABdhPJx+QYX6dWCjUFTsqC3gplkBfaJD1W/ZwsxtBNAq6AT/1JZV9LVyHsZwqSZwJtWASOytKBs0XB2BD/Sr1Oim6i8=
X-Received: by 2002:a81:492:0:b0:2f7:ce87:c324 with SMTP id
 140-20020a810492000000b002f7ce87c324mr23716879ywe.359.1651743639508; Thu, 05
 May 2022 02:40:39 -0700 (PDT)
MIME-Version: 1.0
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
 <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
 <20220505074408.ayzmd5kdbw2fagbq@vireshk-i7> <CAKfTPtCuJGsrsBJ2jACr_YeKN3RXNVMkgRgo+cw9t7CAyGwHWQ@mail.gmail.com>
 <20220505082801.oks7ko2sbqazyenn@vireshk-i7>
In-Reply-To: <20220505082801.oks7ko2sbqazyenn@vireshk-i7>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 5 May 2022 11:40:28 +0200
Message-ID: <CAKfTPtCfKBiQkghY6gw+sSYYOXFRWMZNXsr64Vn5G-Oo1HF8ew@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to mismatch
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 May 2022 at 10:28, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 05-05-22, 10:21, Vincent Guittot wrote:
> > Part of your problem is that cpufreq use khz whereas clock uses hz
>
> Not in this case at least as the value mentioned in OPP table DT is in
> Hz.

But dev_pm_opp_init_cpufreq_table make it kHz anyway

>
> > Would it be better to do something like below in cpufreq_generic_get
> >
> > (clk_get_rate(policy->clk) + 500) / 1000
> >
> > so you round to closest instead of always floor rounding
>
> That would be a fine thing to do anyway, though I am not sure if it
> will fix the problem at hand.
>
> If the hardware returns 499,999,499 Hz, we will still have the
> problem.

But in this case, cpufreq table should use 499,999Khz IMO. We already
have OPP/cpufreq table being updated at boot with actual value.

>
> --
> viresh
