Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47BCF553889
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 19:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352089AbiFURIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351521AbiFURIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 13:08:04 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E25BB1F6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:08:03 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id x75so10579419qkb.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 10:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3HDmrs3DFE35G4XFfrgco/xuTbSz6ISXl7GhqnFYe1M=;
        b=tcq2wCeQKzis8PrQ6UfY2M/YKkGpfWBUqCQxcEOs1sC63sjj+sQGJTI/1BO4rat+a1
         3PuAH/4woUkmhPG2hf6BSEPQhGRIGscgfdN34rN3bdWmtTzdng5nvfg7OXQy/hKMGZB2
         V8tFtRBjKFNSon3m4mAZbzkGflp8WpvJMb/zDhnnwfL3/u1d94t+gUvj6tspkJNzarZf
         Hg7ljnxJQja6ytKczVfV4bgKB16JKOpbVY4stSpZtM6mQ5+EQ9A80CQScS6xzv8tIABk
         b06u0xCD+nGWlOUVHDaIufm+dqYSwCDbJLazUXrL0FI63gPwTJ23Hr7GicGMFCaRJy1L
         jAag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3HDmrs3DFE35G4XFfrgco/xuTbSz6ISXl7GhqnFYe1M=;
        b=IRLj6ITCFpEcj62uZfszqmLaWTyGtUCXyWxKR0PUHYKA735kDUnpGKSvnDRKs4tqp1
         7HEIGDgBmyvNCeq0f/AFoatzR3W9lkgUbbFQThp9QRiuKqjJ1DLz7KS2WIcioYlKX6p5
         gwFyRLUJlao2/qRnpoesaO0YJME6pyOJD/KyGsgRkU+ylUajxeRFhnhuhZ4fEWBAMopI
         o+H+kbT7j5lwIKgWv1yexRDl+uGJ1u6zKE6ob3mPj2ZmLBdQ7EpqiYMqZu3zSosnPCQY
         YQ/VHlZT/NbfUkMxPhteoyJIVKex+ZEDVTH4mL8tdrZFBdjKRBefi/8ZDZscayn+QRxT
         2iEA==
X-Gm-Message-State: AJIora/E0RC+nAHxDDzKxIksaKtPdA/LLmpukZJwLUercib+eVEOCGwK
        5KcH2XFj26kf9wCEeOqs3qeZns7bTQj66nIEsmvq8UZE7Pz3la/Y
X-Google-Smtp-Source: AGRyM1uQ/jKdPSTIjotlzhMvoeYQo1L8t6uwWKou2MSwoDlV2zQT7hNIzr//0CS3qto+LtkUZLaL3v8Na0/X0vzgfTY=
X-Received: by 2002:a05:620a:31a0:b0:6a7:549f:a788 with SMTP id
 bi32-20020a05620a31a000b006a7549fa788mr20758075qkb.203.1655831282044; Tue, 21
 Jun 2022 10:08:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220621160621.24415-1-y.oudjana@protonmail.com> <20220621160621.24415-6-y.oudjana@protonmail.com>
In-Reply-To: <20220621160621.24415-6-y.oudjana@protonmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 21 Jun 2022 20:07:50 +0300
Message-ID: <CAA8EJprQTiU+=ajKSWbFfbHuVxjEiybTPNez66Ob+4YZ+fXW_A@mail.gmail.com>
Subject: Re: [PATCH 5/6] dt-bindings: clock: qcom,msm8996-apcc: Fix clocks
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, 21 Jun 2022 at 19:07, Yassine Oudjana <yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> The clocks currently listed in clocks and clock-names are the ones
> supplied by this clock controller, not the ones it consumes. Replace
> them with the only clock it consumes - the on-board oscillator (XO),
> and make the properties required.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  .../bindings/clock/qcom,msm8996-apcc.yaml         | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> index a20cb10636dd..c4971234fef8 100644
> --- a/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> +++ b/Documentation/devicetree/bindings/clock/qcom,msm8996-apcc.yaml
> @@ -26,22 +26,18 @@ properties:
>
>    clocks:
>      items:
> -      - description: Primary PLL clock for power cluster (little)
> -      - description: Primary PLL clock for perf cluster (big)
> -      - description: Alternate PLL clock for power cluster (little)
> -      - description: Alternate PLL clock for perf cluster (big)
> +      - description: XO source
>
>    clock-names:
>      items:
> -      - const: pwrcl_pll
> -      - const: perfcl_pll
> -      - const: pwrcl_alt_pll
> -      - const: perfcl_alt_pll
> +      - const: xo
>
>  required:
>    - compatible
>    - reg
>    - '#clock-cells'
> +  - clocks
> +  - clock-names

I think we can not list them as required, as then older DT files won't
pass schema validation. But I'll leave this into the hands of Rob and
Krzyshtof.

>
>  additionalProperties: false
>
> @@ -51,4 +47,7 @@ examples:
>          compatible = "qcom,msm8996-apcc";
>          reg = <0x6400000 0x90000>;
>          #clock-cells = <1>;
> +
> +        clocks = <&xo_board>;
> +        clock-names = "xo";
>      };
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
