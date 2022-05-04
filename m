Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB4A519D25
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348294AbiEDKmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348249AbiEDKlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:41:55 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB23029CB6
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:38:14 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 17so1132504lji.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lD3vvXHAHJs3IRnQAHfphn1E2NtyGe633IfNU2pH9ck=;
        b=QaNg+hrH0pWi1gegQLwIunoR96zQeWK405W/Y0DimAXEprgC6u6tNQyTc1XTqFVU4h
         poyJ1hvGMfkGW4M4zzVcfyyiBE5x7enLur2bhx1BCk1vMfmmunpoJJvu62TgUJYs7EUN
         rNETTUTSN7ekB6AXtT3O4rljzo4wb9v3QUMtEUUaODNLuI7ECb3F49YEvM+74VF7zM3W
         m2cSjEjDZLt6B8o16XYHmC/R5xDBzmcf6Zi47MWoXmAq1hHZUYbz8bh+bRzkTgtz+jjX
         CRGalEFuDBlXelp8sBL1sgXTzlbdfuBK0920R5Qh6l0w7CVfq4DSsVE7n1+PvvcN6ziO
         PGQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lD3vvXHAHJs3IRnQAHfphn1E2NtyGe633IfNU2pH9ck=;
        b=pwcK7wETKTfwHGa/IIMGzvMvr8+ANvqdQyLKJq1SlbWphLymDuQgA8w4m0eeo8Ys3s
         dQa4xUXeQ8hKI5uEfE+X41Oxypa68A/R5TSA50sibBso6v1IXlmnWnP29Nl0KF5hnct1
         pdiXSgHt9OrentdJblHjtJtq3/QHZEyLOcc3vSGffMtdkXHcrZTF5YCdhoQq0WtpkcXG
         5rsgH68P7rBZWibmw3YFhKocm+Q0Iz6fDBSBKJCp2LUDAeLS1XSwZx/414qTC9hzfXid
         nzlTk2v1iZ9/iuI3nmeTPAnnBHeDxQXiYfAz4/SYwOz6JaaHuyPJRr+jiRTsaIraOYK+
         kWew==
X-Gm-Message-State: AOAM530xdVYhcaR22YiDogEpCH+992Vddec766i9ms2NO1CBaiTtbJdq
        40ihmSSmkQklNTcyhhWwFGJQAzd7jOe9qkYYSgYTlQ==
X-Google-Smtp-Source: ABdhPJy+kS6AXMWUkmQ6E/kbOxo9lyfYr8OK70af4kdLrlbjvuToWT0sZZJrsSDzfyNmt7IFspcd+yMVuBQcDDWWKHI=
X-Received: by 2002:a05:651c:483:b0:24f:2ae0:61f3 with SMTP id
 s3-20020a05651c048300b0024f2ae061f3mr12397148ljc.229.1651660693223; Wed, 04
 May 2022 03:38:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:36 +0200
Message-ID: <CAPDyKFrkkif0ABhe0_pZFBpWjMVoXETKZ7GpJUORR94LmbbaGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: mmc: brcm,sdhci-brcmstb: correct number
 of reg entries
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Al Cooper <alcooperx@gmail.com>, linux-mmc@vger.kernel.org,
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

On Thu, 28 Apr 2022 at 10:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The binding should not allow infinite number of 'reg' entries, so add
> strict limit.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index dccd5ad96981..54a0edab5f8c 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -31,7 +31,7 @@ properties:
>            - const: brcm,sdhci-brcmstb
>
>    reg:
> -    minItems: 2
> +    maxItems: 2
>
>    reg-names:
>      items:
> --
> 2.32.0
>
