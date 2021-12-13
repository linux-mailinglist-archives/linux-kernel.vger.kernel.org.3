Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE53B472CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 14:01:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237094AbhLMNBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 08:01:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhLMNBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 08:01:50 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1B0C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:01:49 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id u22so23533372lju.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 05:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mmZqoM0VKk19CgkjkqT2/mS1Wzq4NBD9qkKtBMLqLss=;
        b=CXhNuATQd8iDGZZytbWfLcg2yXtENnNCTKsNdZ1fZIz+RkCQDT2d8Yg5go8/P1d/c4
         wCDwchO9A63guwAOxxpmkrCXlkj8l94hZURQbhdTiA8ubNeK8kFVH+E5wZscpY7ZOO+3
         Op8xfaKGNiwSis5xYtXFSX7NW22UB+nyUknCHmGgniM4zQ4EZmoNaZA07WU9or+gVpg+
         1CYTnGCgEeZatVJ4KiscXfHqfpl/3vlyru7JgkzhHOb3nMwrumn337EVox8W0BdZ1v/G
         P7B7jwwpGbXjuqd/XoGfWZeHIMevRS4txQr6jxI+f+44dlx8w/Y33+6v97q64LsSO6WO
         UfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mmZqoM0VKk19CgkjkqT2/mS1Wzq4NBD9qkKtBMLqLss=;
        b=Z7ouGFDxZlhoYSML046xbxCuHs1WWzaKIWwjnAqO1IvM61RWJINcpD7H/2wmhPG/m+
         v6LJajF9iZmXM2erV/oxN1xT6nkQW+ker0FK1Zoc7G21jOtKnwOiQ69iuo0yDMPf/5PI
         TvFrwZzamjtmB2NvyjAJiPvGF1TeTMwWAhO6RhTJPSNzADz2u24JyubeoE4MIzAkhXed
         Esag67+Lx71PhJx7cjB7AbFlvZlrT5NYGH8nftTyOQE5yyv9OyXZdwPsbmoxMRXs7Sfk
         8BIhjFYqiQuPq0RnCo6HRORqkQYFAIhLONy6tSCfEHAKGCMf4S7W+sJRFzvkT0lWZSvU
         XKqg==
X-Gm-Message-State: AOAM532hmikam4B2lwrtJ90NKeSHg4hIG9ZCRRRuH0BIiLb0jCoqDBhD
        YQaXhWfJj3rbxjup+DH0So+I8ujFdOXQCOoSft69hQ==
X-Google-Smtp-Source: ABdhPJwDPCbxiPnhThYyhmTadFojAvuJfukt/vgX9gGHkV9OErrpCAyUIo/lXKbMSSPm5smSXRJojyNJL0Ju04uDV1I=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr29570182ljc.229.1639400506261;
 Mon, 13 Dec 2021 05:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
In-Reply-To: <20211212145956.1423755-1-martin.blumenstingl@googlemail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 13 Dec 2021 14:01:09 +0100
Message-ID: <CAPDyKFoqGFJQ=i301+xXvP1he-tzL8pzZO3q6P+tERYFUNZskA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] mmc: meson-mx-sdhc: two fixes
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Dec 2021 at 16:00, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> The first patch in this series fixes Broadcom SDIO wifi cards (using
> the brcmfmac driver) on Meson8 SoCs. Meson8b with Realtek (RTL8723BS)
> SDIO wifi is unaffected by this (it worked fine before). Testing was
> done (on the S82 board) in private by a user who wants to remain
> anonymous.
>
> The second patch in this series is a minor cleanup which I found when
> working on the first patch.
>
>
> Martin Blumenstingl (2):
>   mmc: meson-mx-sdhc: Set MANUAL_STOP for multi-block SDIO commands
>   mmc: meson-mx-sdhc: Drop unused MESON_SDHC_NUM_BUILTIN_CLKS macro
>
>  drivers/mmc/host/meson-mx-sdhc-clkc.c | 2 --
>  drivers/mmc/host/meson-mx-sdhc-mmc.c  | 9 +++++++++
>  2 files changed, 9 insertions(+), 2 deletions(-)
>

Hi Martin,

I noticed that you didn't cc the Maintainers from Baylibre, perhaps
the amlogic list is good enough?

Kind regards
Uffe
