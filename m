Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB81F4ADC28
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 16:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379685AbiBHPNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 10:13:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379694AbiBHPNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:13:09 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57376C0612C0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:13:04 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id z19so33832812lfq.13
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 07:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ul6586FcR2XNKw03Estem+L/2VYFh9q5OPSt2ipD/I=;
        b=lTtINBBOCY8o3GicRiibtef9ezSJryqKiDbXTVXhiO2U9dopVM6SL0E++3vEtiIRSj
         rS1GnQalBTA1I7lJodLcbsoS0D8ywNS8LVmOpinkajALmglHEsjWQLeK6m1aG+WnV66h
         jhXKV/qfDnWh0WQxPwSWLP+zzio3U73dP/HwllvT2QN2sInSJcvivIHrqiEEya9A9gdU
         yCuX+3BtSAbSAJIOSmXpFb+fGVM3+yZ8OWP7LwnT1gGlzChXv8v1qOxgMDNXjFIGgAiP
         HcUGwLco3iOmOwLrpa3SiOXc8rgDhaGZT6W10uP8KdICZoVXsFR4RecOTYA1dO1Tec2D
         0+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ul6586FcR2XNKw03Estem+L/2VYFh9q5OPSt2ipD/I=;
        b=rKZi+h4xCyvaFiloSD+9Wox9voFElmpmMCTlg48hy1DhdnqzG6HQvoB/lvDO2YXGR2
         G6Wd3ncMsVmFtbQiKDG/rIH2r/X4t3S487j89UsXKV6DAS6Dr9J6xVAm3arRhEMIcs91
         HmYIks3ywKSLO/aEZbylkmXrY4e3jtWNmbJ93NjtyfodzHrbnuD1vD9xJRuVnjoaQ89X
         VdmhV8884uOFbal4mxyUZ39wPkCXylvE6QjfPZ/5GbUYyjyR7jfkyK+qYSjFMCwVT0H9
         8KnOVnk7akPRAyuHPwDeYa8SSExokD3DW1Pesr+cO4/XHi42JhMfZvGlauYAlIR/FRSW
         PQ9A==
X-Gm-Message-State: AOAM532am4KH+JJv8jZrCx5VsoTE/FKoVNmYawL24vyzzc5vy++olK7z
        5oPrpkojD6yF99h8mm0i24Ao06PmtaFT8sY3gBUPKg==
X-Google-Smtp-Source: ABdhPJwi6FPXFMyazeJ7i45pYAQSCW8A1BCRnS82xEFe9NN4cuh8Q4joFFexYDXE7e2Y5nmlF/FcS/EQkzm2rd08e2A=
X-Received: by 2002:a05:6512:3b9a:: with SMTP id g26mr3266780lfv.71.1644333182732;
 Tue, 08 Feb 2022 07:13:02 -0800 (PST)
MIME-Version: 1.0
References: <20220203015112.12008-1-samuel@sholland.org>
In-Reply-To: <20220203015112.12008-1-samuel@sholland.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Feb 2022 16:12:25 +0100
Message-ID: <CAPDyKFoQzcD0gV0fXU=FyzTqQfLoTuDWhMrUaRPGYqsD7Spq8Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: sunxi: Add D1 MMC and eMMC compatibles
To:     Samuel Holland <samuel@sholland.org>
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
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

On Thu, 3 Feb 2022 at 02:51, Samuel Holland <samuel@sholland.org> wrote:
>
> D1 contains variants of the usual sunxi MMC controller. The eMMC
> controller has the same parameters as the A100 eMMC controller. The
> other controllers have a DMA address shift like on A100, but they have
> a smaller 13-bit size field, making them a new incompatible variant.
>
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>
>  .../devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml      | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> index 4f62ad6ce50c..94e2c6c4e4b7 100644
> --- a/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/allwinner,sun4i-a10-mmc.yaml
> @@ -24,6 +24,7 @@ properties:
>        - const: allwinner,sun7i-a20-mmc
>        - const: allwinner,sun8i-a83t-emmc
>        - const: allwinner,sun9i-a80-mmc
> +      - const: allwinner,sun20i-d1-mmc
>        - const: allwinner,sun50i-a64-emmc
>        - const: allwinner,sun50i-a64-mmc
>        - const: allwinner,sun50i-a100-emmc
> @@ -49,6 +50,9 @@ properties:
>        - items:
>            - const: allwinner,sun50i-h6-mmc
>            - const: allwinner,sun50i-a64-mmc
> +      - items:
> +          - const: allwinner,sun20i-d1-emmc
> +          - const: allwinner,sun50i-a100-emmc
>        - items:
>            - const: allwinner,sun50i-h616-emmc
>            - const: allwinner,sun50i-a100-emmc
> --
> 2.33.1
>
