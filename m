Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BD9519D11
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348181AbiEDKl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbiEDKlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:41:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5828289BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:37:47 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id y19so1121548ljd.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:37:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vb0NSe8ARzC5SmuUEMfvtdIbDeahcHfl+QMHR8M0UQk=;
        b=GZhSotbCyj7bjcQg3PRN5d5i3LNDLOHkeiEebj/4ACqHtK1YLDFsRK/0IrTHnfceOy
         UluKNPmhbjw9UWDe43i9hxj2A4wVNksLYrr0zgBRav0mWNt+O2TKGxOn39dduRc7hww+
         5IU4ZhRYef0ywjjxFhBviwDj1IhQ/Nlc9V0YgCTRVNC2ObNe9YAxdNsieXO9KNQ3Xn8b
         VrPx1e1Zk7/x4vnxDXFSvWv9wjxu51vfy8OhkXN4uzac4E34FHOJKbE4GhWrNkMTmO/t
         mGyVZzFppdwPpbLeK03k3r0Eai14LTxLKjON1JLWRun+EEVT4Uc4/FB7XksuWfvM/MEH
         5vKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vb0NSe8ARzC5SmuUEMfvtdIbDeahcHfl+QMHR8M0UQk=;
        b=m8NekzG7cQRgxml9EICavy805DymvRAIjFK5rTxqWBORoLrSrRm0aptv9MaCTH6Tjn
         5lKB38V/r2Owb3kLh4WirvJic6EeW2X5NpsvTOwb2DcdtmJU2JM/SfyG+atHxIZmkp9o
         JFjacKKvHNhz82MrqOlwfpKDBoibZWIc+7m/OQf+GhRwKoFsQWtQ/HUlqTock+434hYE
         vxclYa1Bapls6jnG8ajYrqIyYFm6QCPbn1fBWOzFcIS+kphtGHKAyZFrFlH6MQMK1Ix+
         Yad5HphSVSPQ7YkL9lAtRj0XGrOrDVKRsB7S+dl1SO8roDOMF4jgovlwzy9xyoMzChQs
         5B7g==
X-Gm-Message-State: AOAM532MHNO8xLSLj6/pHAG4YidkdK1EljB2M3nPdT2BA9W4idtCmh0v
        WbacMjCZeG9wQXWSo+vz4vcsPO0yE3DLknpsKUnlYg==
X-Google-Smtp-Source: ABdhPJy3RP8ApTLWFeuOxSaDmP+bk9p4uPaAGqlNoJA31itRj3U0AHz4xNk4wOpq4ed3AV5juy2VAtEjHIHTWQOiNls=
X-Received: by 2002:a05:651c:1783:b0:249:43a8:b6f9 with SMTP id
 bn3-20020a05651c178300b0024943a8b6f9mr11878078ljb.273.1651660666042; Wed, 04
 May 2022 03:37:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220422170920.401914-1-sebastian.reichel@collabora.com> <20220422170920.401914-8-sebastian.reichel@collabora.com>
In-Reply-To: <20220422170920.401914-8-sebastian.reichel@collabora.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:09 +0200
Message-ID: <CAPDyKFpCa6xqQfpBj9e8E92_WyK_tEESgSMuRm9_CNRuMgFbQw@mail.gmail.com>
Subject: Re: [PATCHv1 07/19] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rk3588
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 at 19:09, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Add compatible value for the Rockchip rk3588 dwcmshc controller.
>
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Applied for next, thanks!

Note that, I am expecting a new version of the other mmc patches that
is a part of the series.

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> index f300ced4cdf3..71f8e726d641 100644
> --- a/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> +++ b/Documentation/devicetree/bindings/mmc/snps,dwcmshc-sdhci.yaml
> @@ -17,6 +17,7 @@ properties:
>    compatible:
>      enum:
>        - rockchip,rk3568-dwcmshc
> +      - rockchip,rk3588-dwcmshc
>        - snps,dwcmshc-sdhci
>
>    reg:
> --
> 2.35.1
>
