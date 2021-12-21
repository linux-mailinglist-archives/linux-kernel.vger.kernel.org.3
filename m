Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C8647C05A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 14:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238067AbhLUNDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 08:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238064AbhLUNDe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 08:03:34 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C12C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bt1so29094248lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 05:03:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqXlLV8SePaGC+y3/vdaOf1H0E4thOEsiFPNapXQwSc=;
        b=YyYPK9tu3NmScrecLS1MccIJvkhdJy4nQ05x9Z3bt/8vALw1x+ChKGPtvKCnZY5xvi
         s4WV5IxCq8WSDBv2lm3jUZPwAN3lYjxzCTki+vYHcztUd3Z893htrpRORBgTB/r8ARsS
         K0OKXOBmn41TVqOgRYMdG4ebbv3TOsci2xjntYGbZvUW94hh9kZqEZ53DDRR3Gh6dQrc
         +IZx6HEWuvQGmStWddnzGBtvp2zCJ0nnFIoOvxb2lfRMifH5uwNLatShXB1/xGgqBhdU
         HsfgFm7/neLDbVqqD03e2p+Y3lkxRPxzBzfjifTjzsiWHArWZJeaA4J26WB4c/6kWMOx
         RgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqXlLV8SePaGC+y3/vdaOf1H0E4thOEsiFPNapXQwSc=;
        b=OC2QtjtlLPmlEM8WzSkA8uGaZPzv7t8ftq6KAgYAKqZ/TshLTqbdY3c02A0VOL9rvI
         rHe4mVcQnckxknE3ajXeu7dHRYgtKPAzdFoONW5p6QFnE5Vn6um1hXaV/7NpMbk+TqfU
         s2LoFROnX/F2D1luyf0ufQoohe06C7YmUkXGz+HRr4XERTMxnvooXlcYl+L3L4SZrodM
         kvf8WMQxQ/HKtaD5/2heIsJnHf1mJbSDZ60d9O45+CE0Fx5qPlSBwe7PBHxEwPJHZ0Bp
         0vgw5eyYGWBkOIrMD7KGN4Y+8GRMFO62Ge9zXfJL+6KDXlnLfJisv9xEcL0yaysc2epS
         uqTA==
X-Gm-Message-State: AOAM530V8uOzcGhO31DHpLK8MhtQ0FfgLkBsQ2JgX76MMBjzvAPFomYd
        dJM0o15Lf591batKJOhXLJ/X5FEm+HNIqjPXWAe2ww==
X-Google-Smtp-Source: ABdhPJz29OYTxN/YI/nfoGqSbzGzFH8lQFfuOhtkX+emAf6tcx5jyjh7QQeKtEVugrVqanaBliR1j4kwByF6Bzl9MiU=
X-Received: by 2002:a05:6512:3bb:: with SMTP id v27mr3010113lfp.71.1640091812018;
 Tue, 21 Dec 2021 05:03:32 -0800 (PST)
MIME-Version: 1.0
References: <20211215141727.4901-1-yann.gautier@foss.st.com>
In-Reply-To: <20211215141727.4901-1-yann.gautier@foss.st.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 21 Dec 2021 14:02:55 +0100
Message-ID: <CAPDyKFpxionwX-OZwPGbwCmRmqTkWbcf7XQsZyHMh7Ht=smPbQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] mmc: mmci: updates for STM32MP13
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Vladimir Zapolskiy <vz@mleia.com>,
        u.kleine-koenig@pengutronix.de, Marek Vasut <marex@denx.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Ludovic Barre <ludovic.barre@foss.st.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021 at 15:18, Yann Gautier <yann.gautier@foss.st.com> wrote:
>
> The new STmicroelectronics STM32MP13 SoC embeds a new version
> of the SDMMC peripheral (v2.2).
> It supports SDR104 and HS200 modes.
>
> Yann Gautier (4):
>   mmc: mmci: Add support for sdmmc variant revision v2.2
>   mmc: mmci: increase stm32 sdmmcv2 clock max freq
>   mmc: mmci: stm32: clear DLYB_CR after sending tuning command
>   mmc: mmci: add hs200 support for stm32 sdmmc
>
>  drivers/mmc/host/mmci.c             | 7 ++++++-
>  drivers/mmc/host/mmci_stm32_sdmmc.c | 7 +++++--
>  2 files changed, 11 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>

Patch 1, 2 and 4, applied for next, thanks!

Kind regards
Uffe
