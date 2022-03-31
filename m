Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A9D4EDA2C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:05:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbiCaNHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiCaNGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:06:53 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3209049252
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:06 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id y38so39526239ybi.8
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 06:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FlAYsloNunK4Gbn5Ha6Q08Ocp9zz+BcFgNosISbfqtk=;
        b=G0uZeSd+qqMGgJ2xiJ5K3OzVnaapobjGnFXQ2JtKC3KH8q89GRNMoNrKttClsOy+SC
         peLYHOwLnUvDDnJCMsz/OxkdekTKN0mtQnW1nbwiosDAVD+7NZPZ8b34HxCI8H/pPOPc
         Yy2CjHRvsdhlWcUoW6EezGhhLVOPT6JeofwdBFDPpKNdPKUthfp+OxIVBBP07vdHJSa1
         gooq9xMn/Lo1sGuSLcJX+8MrXMsIN451ZSArGHSpTIdey+Lvo1AhK6ekmC4+pJy/x1yK
         GqlDjHgth9+PHzco8w6dal8xErbo0JYgrz0NUYXVMdewotcgmvqryVGZCi/hYRIzXf2l
         cmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FlAYsloNunK4Gbn5Ha6Q08Ocp9zz+BcFgNosISbfqtk=;
        b=re7+ZH1sqJe+wQzIKo3mSFzyq+sg3V9C5Ku0MP0silhg7tftnE/eYEyQfcz2s/ekHW
         LakqL63EfnIIZVW5tNYqjEoSW168Kc/fK6C3XG0knTl95NqnGjU4YyBEtFEq8seTtOsB
         5yuRwO2P0M1RQshJJH8aNtWQ3Z6xglk9xLjWeM5zC2uRFcv/vUKS+98DnJscniKo+i7G
         NHyrfagvoOBT9RIxPQ6LOO89c/KlWyDnNESITMgAvVDuZ69YqrJJh/WYr9UCgFhbxF6z
         71o/x9/Ej5g7wg5962VxrTA9GFFvIsypoXM+wugGaOJWZZPzC+5aHGfG07dNR2IFz4eR
         kXuQ==
X-Gm-Message-State: AOAM5318AlDJ3U14wCG7HwWl48r6gI2l1HRa3b6HXG8P6i1Dt/A2tBf+
        kcl0c7bm336D8XclbywzhZjgxzO/2lH08wRdLfLvnQ==
X-Google-Smtp-Source: ABdhPJwZXmsaPYtsaDbjfgUdhDDpX5HR0bzBi4bSsJgQ5eP/9NBsWXRIsIuywjwq2d4nVrBrvCK7BwxMWXJAgCPaJZY=
X-Received: by 2002:a25:c5d2:0:b0:636:e78a:866d with SMTP id
 v201-20020a25c5d2000000b00636e78a866dmr4133366ybe.225.1648731904948; Thu, 31
 Mar 2022 06:05:04 -0700 (PDT)
MIME-Version: 1.0
References: <20220327123835.28329-1-aford173@gmail.com>
In-Reply-To: <20220327123835.28329-1-aford173@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 31 Mar 2022 15:04:28 +0200
Message-ID: <CAPDyKFrhiaJHqsB8tVp_SkJwTtfanS5eN8wucntUHLL589Snww@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: mmc: imx-esdhc: Update compatible fallbacks
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-mmc@vger.kernel.org, haibo.chen@nxp.com,
        aford@beaconembedded.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Mar 2022 at 14:39, Adam Ford <aford173@gmail.com> wrote:
>
> The SDHC controller in the imx8mn and imx8mp have the same controller
> as the imx8mm which is slightly different than that of the imx7d.
> Using the fallback of the imx8mm enables the controllers to support
> HS400-ES which is not available on the imx7d. After discussion with NXP,
> it turns out that the imx8qm should fall back to the imx8qxp, because
> those have some additional flags not present in the imx8mm.
>
> Suggested-by: haibo.chen@nxp.com
> Signed-off-by: Adam Ford <aford173@gmail.com>

I didn't quite follow all the discussions on patch3 - and whether that
may affect the binding. Anyway, I assume you will send a new version.
If not, please tell and will pick this up.

Kind regards
Uffe


> ---
> V2:  Added suggested-by note and imx8qxp updates.
> ---
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.yaml   | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> index 7dbbcae9485c..1427e9b5a6ec 100644
> --- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.yaml
> @@ -34,23 +34,25 @@ properties:
>            - fsl,imx6ull-usdhc
>            - fsl,imx7d-usdhc
>            - fsl,imx7ulp-usdhc
> +          - fsl,imx8mm-usdhc
> +          - fsl,imx8qxp-usdhc
>            - fsl,imxrt1050-usdhc
>            - nxp,s32g2-usdhc
>        - items:
>            - enum:
> -              - fsl,imx8mm-usdhc
> -              - fsl,imx8mn-usdhc
> -              - fsl,imx8mp-usdhc
>                - fsl,imx8mq-usdhc
> -              - fsl,imx8qm-usdhc
> -              - fsl,imx8qxp-usdhc
>            - const: fsl,imx7d-usdhc
>        - items:
>            - enum:
> -              - fsl,imx93-usdhc
> +              - fsl,imx8mn-usdhc
> +              - fsl,imx8mp-usdhc
>                - fsl,imx8ulp-usdhc
> +              - fsl,imx93-usdhc
>            - const: fsl,imx8mm-usdhc
> -
> +      - items:
> +          - enum:
> +              - fsl,imx8qm-usdhc
> +          - const: fsl,imx8qxp-usdhc
>    reg:
>      maxItems: 1
>
> --
> 2.34.1
>
