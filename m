Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30134FE0A3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351338AbiDLMpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349500AbiDLMpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:45:21 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0879376E19
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:10:01 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o2so10177731lfu.13
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 05:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nPnzcyNV3A/4UYBzWHKTKf4kIp6tVvkH+WsDEXjDC24=;
        b=lDM2BhUHoH9Y+RgQ9Bejy2VOEq3wZBs2rmgzsGi+vSzCT9TnP/8p3Wpupm7r3FXUdb
         8tJJOEslIMEHSsBsANKpcplIDLfo2t7FROT/4UUxv3JT5Lfof+D9K6xXjn9GZ0IX18I5
         i5wr6Qmz7ObO0Z+1rOwSjltkoXo5eguNJmHBQ0fa0oyubBBMv3A9dg2++8Ec6PZJ0G6g
         y8bArUarnYMM3yVpAzhImHBpfpz9qai/H6kAyrM6mEe2xFj9adjKuacadXwFgwMhFpvV
         SAPoPZa4ThafUqA6nzvJQrfLxbQOIbgW/dCztPJCl6GvdP3vuHEWyLDxZm7vzyMxUnUO
         qV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nPnzcyNV3A/4UYBzWHKTKf4kIp6tVvkH+WsDEXjDC24=;
        b=ejsy6+0JjTnaTrYdAg3vYIB22onQw8zNNfTvVC+EnkCrxmZvtxZSNZUJpOak+5foB+
         xygicJCEwoaPjDxlb8Nk2NYbxl2DVPABX/JSoF+xpHtBANg91YVqqsrhc0PRCC5YaPt9
         E1Obk8YotBdSNN5KLGZP84v+z4cbu7lGMNLg2Wlu+e0cA5f+P9X/SONwFYOMUtaaABBq
         kPh1KpMtgjDdhszs57GuJYMd8GU0D3kGJ0/55QHejO+QyUJcxhaGLFQtTxmbGbuqjl+k
         zYDM15s9pSPUvXfBjdfk6wcjyXay4vYlBYXgyl0quDNlSaR6q6GQWubponTs7nOmi4hH
         LayQ==
X-Gm-Message-State: AOAM533nK9+aKo3VGZP/pJjI5JboaKLqLZoWGquqf1M7htc64LA7gQS9
        SyEAiGC8FNgSvuiDohMcB6l6w0FP7/6sShwGbiJORQ==
X-Google-Smtp-Source: ABdhPJw+QK0ioHa/IORYPR20pHaGiyG//MIdGQmMFH88fHxyhrzPKtKt7GOnvFjngT2GteOSQr2B4Jw9WZ+8GibsNMQ=
X-Received: by 2002:ac2:4bcf:0:b0:46b:ae4d:2855 with SMTP id
 o15-20020ac24bcf000000b0046bae4d2855mr4980780lfq.184.1649765396161; Tue, 12
 Apr 2022 05:09:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220410193544.1745684-1-aford173@gmail.com>
In-Reply-To: <20220410193544.1745684-1-aford173@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 12 Apr 2022 14:09:20 +0200
Message-ID: <CAPDyKFpWMmteaJ3Afz2TD4ba2iE-0vf4VJ_V-kkEE332OzywpQ@mail.gmail.com>
Subject: Re: [PATCH V4 1/3] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc@vger.kernel.org, aford@beaconembedded.com,
        haibo.chen@nxp.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <Kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
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

On Sun, 10 Apr 2022 at 21:35, Adam Ford <aford173@gmail.com> wrote:
>
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
>
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d. After discussion with NXP,
> it turns out that the imx8qm should fall back to the imx8qxp, because
> those have some additional flags not present in the imx8mm.
>
> Mark the current state of the fallbacks as deprecated, and add the
> proper fallbacks so in the future, the deprecated combination can be
> removed and prevent any future devices from using the wrong fallback.
>
> Suggested-by: haibo.chen@nxp.com
> Signed-off-by: Adam Ford <aford173@gmail.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> V4:  Mark deprecated items with "deprecated: true" instead of a comment
> V3:  Add support for the interim fallback on imx8mn and imx8mp where
>      they both fallback to imx8mm, but keep the imx7d to prevent any
>      breakage.
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7dbbcae9485c..58447095f000 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,22 +34,46 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imx8mm-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mq-usdhc
> +          - const: fsl,imx7d-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
> +              - fsl,imx93-usdhc
> +              - fsl,imx8ulp-usdhc
> +          - const: fsl,imx8mm-usdhc
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
>        - items:
>            - enum:
>                - fsl,imx8mm-usdhc
>                - fsl,imx8mn-usdhc
>                - fsl,imx8mp-usdhc
> -              - fsl,imx8mq-usdhc
>                - fsl,imx8qm-usdhc
>                - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
> +        deprecated: true
>        - items:
>            - enum:
> -              - fsl,imx93-usdhc
> -              - fsl,imx8ulp-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
>            - const: fsl,imx8mm-usdhc
> +          - const: fsl,imx7d-usdhc
> +        deprecated: true
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
> +          - const: fsl,imx7d-usdhc
> +        deprecated: true
>
>    reg:
>      maxItems: 1
> --
> 2.34.1
>
