Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E34D46B006
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbhLGBwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbhLGBwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:52:16 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81461C0613FE
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 17:48:47 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so4918187ood.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 17:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AFz5tb1s5E2o6IruMPa/3kRd+Fiv5iY0Fzye5oLOFqE=;
        b=UBvo3aqLBUEJrPryLbjhYFOvdDYupBjLMjp6i2aymVQphxY3WXk4NvVFcKfKV+YgJ9
         EzgzBeDDKpk9L1y7ZpPHWhTNfVxOIZlpi2m3Oqz5/FJAIost4evonA/cFftreHqXKT1G
         4tkU1YqV5gOwaqbA12So24Qc5tAg8ENbB6adRVAGW9ZW88MmCvFRlr6LyKDUWerpAtlD
         d1OmYPSOOXSDg1+ua/pRA01pSAC4Phvjy6W73WGogFcMu9OnQhGC9TQCVk6RZxepUPhh
         j//83QH9DXTrf5mAclC8bnzFbH4VwngBAfiDhEaCN6FHSJtUg3rVYAHIAkj5eU2quKlv
         Rzug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AFz5tb1s5E2o6IruMPa/3kRd+Fiv5iY0Fzye5oLOFqE=;
        b=DQkBoMZsSvnBjcRP2XT7l5lk44A+wDrlhtTbNVziInMt0qRz709oB0Y60EiH/eo0Wa
         BXJSXhc74zpiixwql7Wrrn6wNS2Blt21QBM7S3va8wLbF46Kzs3xd0AFnzRoTw327uLo
         3MjBpTw6V/fPUaZYBm/VA4BK4jx0Ra5FyC3RkDpjCE5ycEU6Awrai8ioWzsucsC3lYhL
         /SfrmwVcRiUezqVFFOpJRjRYqHlDp44hChRinik7fzG4psXbJv5ywBQ+RMmNGPSACbMA
         16uIqll1BLQrVDc6e7/1YbyeKR7niz0z44FqpfbBTQzXifaxFshUtCuCSRxGw3w2OCXM
         5qpQ==
X-Gm-Message-State: AOAM530/leldgKc6htmedwCDt5iaelaz+59C60liahvbVpua14q/YNB8
        O/J9q5/PO9rqUzcULUdMJ6AcqNG2nCRIpgRypIDsyA==
X-Google-Smtp-Source: ABdhPJx3H3C1ePdMTdRJPqjHs5w5ltUUprwA6vQYg3EGk7a5/lyPTgGkRhm/2WQ8BNLTM4aHT+6Rqn6InkenUQG9j2I=
X-Received: by 2002:a4a:8515:: with SMTP id k21mr24612108ooh.71.1638841726738;
 Mon, 06 Dec 2021 17:48:46 -0800 (PST)
MIME-Version: 1.0
References: <20211206174201.2297265-1-robh@kernel.org>
In-Reply-To: <20211206174201.2297265-1-robh@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Dec 2021 02:48:35 +0100
Message-ID: <CACRpkdYXdUmYHt=1uCtoZTWfy5ZV6VV3obfSa0Aw9SwvoSB-CA@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: mmc: Add missing properties used in examples
To:     Rob Herring <robh@kernel.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 6:42 PM Rob Herring <robh@kernel.org> wrote:

> When 'unevaluatedProperties' support is enabled, the following warnings
> are generated in the mmc bindings:
>
> Documentation/devicetree/bindings/mmc/mtk-sd.example.dt.yaml: mmc@11230000: Unevaluated properties are not allowed ('reg', 'interrupts' were unexpected)
> Documentation/devicetree/bindings/mmc/sdhci-am654.example.dt.yaml: mmc@4f80000: Unevaluated properties are not allowed ('sdhci-caps-mask' was unexpected)
> Documentation/devicetree/bindings/mmc/socionext,uniphier-sd.example.dt.yaml: mmc@5a400000: Unevaluated properties are not allowed ('dma-names', 'dmas' were unexpected)
> Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@80126000: Unevaluated properties are not allowed ('dmas', 'dma-names' were unexpected)
> Documentation/devicetree/bindings/mmc/arasan,sdhci.example.dt.yaml: mmc@80420000: Unevaluated properties are not allowed ('resets' was unexpected)
> Documentation/devicetree/bindings/mmc/arm,pl18x.example.dt.yaml: mmc@52007000: Unevaluated properties are not allowed ('interrupt-names' was unexpected)
> Documentation/devicetree/bindings/clock/imx8qxp-lpcg.example.dt.yaml: mmc@5b010000: Unevaluated properties are not allowed ('power-domains' was unexpected)
>
> Add the missing properties as necessary. For pl18x, drop interrupt-names
> as there isn't any use of it when there are 2 interrupts.
>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: NXP Linux Team <linux-imx@nxp.com>
> Cc: Chaotian Jing <chaotian.jing@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wenbin Mei <wenbin.mei@mediatek.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-mediatek@lists.infradead.org
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
