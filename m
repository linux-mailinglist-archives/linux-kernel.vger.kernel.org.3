Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3062A53FBA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241345AbiFGKny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241309AbiFGKnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:43:45 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DA01EAFD
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:43:44 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id d19so6234949lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AGodPBye9UXlI+EMJig0MHyiqcWK8Mh2BBBh7WPiDtk=;
        b=H6oTP+RJHqWcIElLUG+U95H8gWQGDnndMKIicjO1pRvcQ8oaW4sND8oheC1ayfuwXA
         rZ3wbYcjTSliDxsvO45ClnylkbEauh5NPGeQIhHXLSkS71InNOxTvFSnTaQDqK2WdHBn
         3cvlCUXs8CQejZ8fjwYIAJoFq4AFlJf1OuIslQu1pqmJ+cNT/YQ1cLTBWDDERwSKy5xR
         htd7gv/Xh+XHYAmuxFijvJe8IgXZz6CKuMXgyTC8KxtWPYoJqE+q77ScirzQQlQubnMF
         Sd9XaL2pPVyQoUnB9NmCAGmTkIYNM1M6YjT0QIyGnKwfApjBIboFc4FRuGdSDkPQFJ/2
         Ejhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AGodPBye9UXlI+EMJig0MHyiqcWK8Mh2BBBh7WPiDtk=;
        b=cKAXpjrgJelmYchyOcvlRGVEU8wO3ty1xGgtPFM2moP3XjuZCgc/HEN0STMwSq52sY
         PP6SPFWDFgkrmafSa4KLQ/lz8zveabLjdj6l9jd+gf9PznsMNFci7bXfMVjVV/Yo66Km
         qhXjrzAveNHAW2CrtDYxhX60GNSkcSVNZWfpcUPgUY6OO0GpB38iup98M4sNBnpj9IXk
         LwYhec/pHUbfTcwzAUwILGN/DER1V0DKp5F/vh388+6R8xkycRhL7jlmSMFIaZBLjwvp
         owDOV3DgFKL0NL36OFeTx6G7luqFmcay7+17I9HJDihhm8xCLD5QkD+LI7CplI1To4nB
         NFsg==
X-Gm-Message-State: AOAM5327XjZpnj5hAhKQ51pnj3im2Wlhx3iqCEXRz8PGf9Kmlbre2gbV
        aNlyBUawW7iU2HKKkJNPvPeNG3JwLBKDBDV/edwFZQ==
X-Google-Smtp-Source: ABdhPJxchGY4Nt4vrOH/YTDzMSq4XSFMMYN/oBy1P6pcguyqh6vTohfv9M/2OI724RdulYxRsmcMro4+ctsRdKwqR4Q=
X-Received: by 2002:a05:651c:a04:b0:253:f0b4:a406 with SMTP id
 k4-20020a05651c0a0400b00253f0b4a406mr41537049ljq.4.1654598622293; Tue, 07 Jun
 2022 03:43:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220605163710.144210-1-krzysztof.kozlowski@linaro.org> <20220605163710.144210-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220605163710.144210-5-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jun 2022 12:43:06 +0200
Message-ID: <CAPDyKFp7VtMS22vEW==X_GsoPmKZLTK-G4HqG-Mt1ZD2ht7bgg@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] dt-bindings: mmc: samsung,exynos-dw-mshc: document
 Exynos5420 SMU
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, 5 Jun 2022 at 18:37, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Document the compatible for Samsung Exynos5420 SoC Synopsys Designware
> MSHC with SMU, already used in DTS and driver.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml          | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> index 80c557e938a2..fdaa18481aa0 100644
> --- a/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> +++ b/Documentation/devicetree/bindings/mmc/samsung,exynos-dw-mshc.yaml
> @@ -19,6 +19,7 @@ properties:
>        - samsung,exynos4412-dw-mshc
>        - samsung,exynos5250-dw-mshc
>        - samsung,exynos5420-dw-mshc
> +      - samsung,exynos5420-dw-mshc-smu
>        - samsung,exynos7-dw-mshc
>        - samsung,exynos7-dw-mshc-smu
>        - axis,artpec8-dw-mshc
> --
> 2.34.1
>
