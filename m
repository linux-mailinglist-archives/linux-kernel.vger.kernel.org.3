Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F396493E9A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356229AbiASQxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243524AbiASQxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:53:18 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2330C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:53:17 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id o3so2995607pjs.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RdjTOUEbyGxqpzNJfmpiBGT/Qva80FiHw/y1GbjwPA=;
        b=VC++GBBKZxSlQK1MeJ8/adrnCrR+HqC5AjgaJ87sV6yQwv6UNd9+EfBLAbQq25/IpZ
         COIQfU/sNNt8DiuWzMfZMSDjcqZIkReC+MU/rlTDP4usJAxA6JhDmeUbzXDzdSfXj9H/
         KKuifvveVFlYsPghSlU5vIeChPL16OsbnDGCGwgCDlRLwCleGK+Dfagzr+hT7zi9svy0
         8sPkUpPh9Y5+CNHRCZ9QtJTaomL2De/w+r2UTO6dqSE+BObGH/sw/N3ZTlA4t1FuIlt3
         3SFQt0mNQ+QsDQkfXobnZfNBRxHmh+D5wtA6Tgu+UJRasDpCVv/j1N4kGx3W0AQwAnFD
         +bDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RdjTOUEbyGxqpzNJfmpiBGT/Qva80FiHw/y1GbjwPA=;
        b=xmxpksy3zl2jHtuNDAxNe4bVvQLPgUWM5d+/LyTHZSxBucn5Js475udP/K6prlNxao
         h9PFoiEF9PvQWhFuc4Ej7oE9f5GilfBvZJNcAK8udcjnLBwbXtJW9tARC+IGsObD0veS
         ss/ws3x0lCDHuQZ7RSzSxFyaqVphrRbV3Tf5gsryZs2rWTRmfhmSY7XizcnY8VY0Ekt5
         98QuV3uJgL1NFKb8Yl3BcT9mwCenG491ieIZvSi3G+s2MRKYN3JvMeik8yAWT1IY8eCj
         npTBeJR5i6YnrbsnpjWSQ5szOg0aedi55WRevF0G52v1quIDcYp2laWHR2CznFq+UzW9
         4MWg==
X-Gm-Message-State: AOAM532osQXASqWXmL1ouQ0SatcKGyRJ8LJt6pXAjA7Hw5LaE4UtdVfT
        h5vyV57fHiadupncu9VZwahCGRlTMIO6NP8qMl4Qohq707bhLg==
X-Google-Smtp-Source: ABdhPJx+TbATIF4nHmGFZOPmddAbhmsVuTuIxbk1yLpFJzNPz12fXYYOKY+MiX3okodET0I2JmpVeX0B+YvZ5tgCzzU=
X-Received: by 2002:a17:902:ce8e:b0:14a:6938:c925 with SMTP id
 f14-20020a170902ce8e00b0014a6938c925mr34346856plg.46.1642611197416; Wed, 19
 Jan 2022 08:53:17 -0800 (PST)
MIME-Version: 1.0
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
 <CAPLW+4n-1H5Yu3wQaus-UJ_VW_TjHrNUHaPCGCMURXg8EqxjyA@mail.gmail.com> <CAK8P3a1ou-ZdrXN0MHQoJ+gGbvhXT-e2qt96_f9M8VwrdX0pAg@mail.gmail.com>
In-Reply-To: <CAK8P3a1ou-ZdrXN0MHQoJ+gGbvhXT-e2qt96_f9M8VwrdX0pAg@mail.gmail.com>
From:   Olof Johansson <olof@lixom.net>
Date:   Wed, 19 Jan 2022 08:53:05 -0800
Message-ID: <CAOesGMgF3S5_XsWjEqq=-zfYXwOWFpFNA6afL81wceRUA_0FeQ@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Sam Protsenko <semen.protsenko@linaro.org>,
        arm-soc <arm@kernel.org>, SoC Team <soc@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 8:07 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Wed, Jan 19, 2022 at 4:11 PM Sam Protsenko
> <semen.protsenko@linaro.org> wrote:
> > On Mon, 27 Dec 2021 at 13:30, Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com> wrote:
> >
> > Hi Olof, Arnd,
> >
> > Just want to check if it's possible for those patches to be applied in
> > v5.17? Sorry for the noise, but that's important to me.
>
> I can see that Olof merged merged this into the "arm/late" branch in
> the soc tree,
> so I assume he still plans to send it in the next few days.

Yep, will be sent up today most likely.

> With the timing over Christmas, I sent out the large bulk of the
> contents (anything
> I merged before Dec 23) last year, and Linus already merged it, the rest ended
> up in the "late" branch.
>
> As usual, there is no guarantee that late changes make it in, but I have seen
> no indication of any problems so far.

Correct. Been sitting on it for a while in case there were fixes
coming in for the first pieces that got merged, but in traditional
fashion I'm guessing those will start to show up a few days after the
late branch gets merged. :)


-Olof
