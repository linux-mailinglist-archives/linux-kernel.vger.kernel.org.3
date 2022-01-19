Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C38493C9F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:07:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355369AbiASPHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:07:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241946AbiASPHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:07:46 -0500
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F47AC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:07:46 -0800 (PST)
Received: by mail-ua1-x92a.google.com with SMTP id p1so4975831uap.9
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0kJDAEcAMfCnqPG5TmMKRv1bGPtoRviMKgZZAgVAEv8=;
        b=DKldvcypNWCarjDm9KNhkUnNfw8mjepUghJ7DwEvZFTGgF1qDcX2qZzcbwzkqMlsWL
         vlmWhT/4CitznHG0NKlba6J7u7X2JDrXX2nzaSHzRKHeFunkZwwV665y3WEhMBp4BKuf
         ZSGs4xY/cYVIaomnYkhBdP1h/5uGZr4r2Aqks5Oq6K+VfI/yzpCb7++m1Az7qBjsWKZ6
         AcYXRlIkO0Tg9VinefGG0fPTllXLp0+zLC46VIAuTvR+aBIpWkhshrgBlgOfB/p6rVsj
         hKJqqL3WpwO6/AZH4ivAuVR9Po/WeHMJ8YoW7ITll2en9AItM2KBiLvqnLpIudhkZjEi
         O3yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0kJDAEcAMfCnqPG5TmMKRv1bGPtoRviMKgZZAgVAEv8=;
        b=Z/9TqoDtWyUPDfHdmYEuyaXd4pzBGjnq5CDf17ML9aG1YsohAbCokfiKvhj0+4AGXi
         UtHBiKHKxOTnh4mVAKUzRhpwZcgFcSFnkYDoo0dP58we1qOSDi6BHl22pGQMkMj/F0sa
         jvfaR21kObmrGalTwUSdSirlVF+IvelRQNIbV/Sb4YRSNs4qmhqoJuqOOAwWWjQiGgr/
         vAF6/sL1iAIuh+A1Xpf/rG07QVWtbMYIMvZkv7AOX7YknaKBGbK5ttb01T5Fokz8ri6G
         /uKLNZHxDktcUITdKBOfFymfyE3jN+DOTVKDl8woGgTsQPtZcaRDyz4Trw7QNarWXmEP
         ZY9g==
X-Gm-Message-State: AOAM532bojRDzcowl4P7aLJAIYBtkvZeVCvb4jWNf1bqUBBA77rmciNj
        G+lI5ylEbmQ3JC8avGh8ZtQFbs4vpxDynaJ81I/+5A==
X-Google-Smtp-Source: ABdhPJziPZemMP8fXOLYqxRtVC//dQRMv7XXL4DytCFTrCYXYSoOKbpWqwH4B7Ir4m26Id9l9+DeFPvIIbxDiuFw/Fo=
X-Received: by 2002:ab0:13ee:: with SMTP id n43mr11994297uae.9.1642604864292;
 Wed, 19 Jan 2022 07:07:44 -0800 (PST)
MIME-Version: 1.0
References: <20211227112959.7325-1-krzysztof.kozlowski@canonical.com>
 <CAPLW+4=vEYm6dGSCXtmiXUVe7FT6p=6Uk=MCvEsEgcdTz-R0NA@mail.gmail.com> <495d7eee-ab87-d330-119c-eaafa6c1dee7@canonical.com>
In-Reply-To: <495d7eee-ab87-d330-119c-eaafa6c1dee7@canonical.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 19 Jan 2022 17:07:32 +0200
Message-ID: <CAPLW+4nM_8nbf4inP2pGMVbkE+OYwbkPrfjKtPAYPBfUXvF32A@mail.gmail.com>
Subject: Re: [GIT PULL] arm64: dts: samsung: Second pull for v5.17
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 16:49, Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> On 19/01/2022 15:35, Sam Protsenko wrote:
> > On Mon, 27 Dec 2021 at 13:30, Krzysztof Kozlowski
> > <krzysztof.kozlowski@canonical.com> wrote:
> >>
> >> Hi,
> >>
> >> Second pull with DTS for ARM64, on top of previous pull.
> >>
> >> Best regards,
> >> Krzysztof
> >>
> >>
> >> The following changes since commit 51b1a5729469cef57a3c97aa014aa6e1d2b8d864:
> >>
> >>   dt-bindings: pinctrl: samsung: Add pin drive definitions for Exynos850 (2021-12-20 10:35:32 +0100)
> >>
> >> are available in the Git repository at:
> >>
> >>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-5.17-2
> >>
> >> for you to fetch changes up to a1828d772e0738c30a383a7d335aded2f2baf908:
> >>
> >>   arm64: dts: exynos: Add initial E850-96 board support (2021-12-22 12:31:13 +0100)
> >>
> >> ----------------------------------------------------------------
> >> Samsung DTS ARM64 changes for v5.17, part two
> >>
> >> Add initial Exynos850 support and WinLink E850-96 board using it.
> >>
> >> ----------------------------------------------------------------
> >> Sam Protsenko (2):
> >>       arm64: dts: exynos: Add initial Exynos850 SoC support
> >>       arm64: dts: exynos: Add initial E850-96 board support
> >>
> >
> > Hi Krzysztof,
> >
> > Do you know if this series is going to land in v5.17?
>
> I don't know, did not check.
>
> > The prediction
> > (by phb-crystal-ball) is that MW closes on 23 Jan. I can see those
> > patches in soc/for-next [1], but want to be sure those are scheduled
> > for v5.17.
>
> I don't get how can you be sure that they will be in v5.17. If they are
> not going to be pulled - what can you do?
>

I can't. Just haven't seen corresponding pull request to mainline tree
on ML yet, thought you may know something. Basically I just don't want
those patches to be lost accidentally. And of course it'd nice to see
those in v5.17. Anyway, that question should've been probably directed
to Olof and Arnd, sorry for disturbing.

>
> Best regards,
> Krzysztof
