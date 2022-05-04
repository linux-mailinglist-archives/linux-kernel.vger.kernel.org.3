Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9119D519D32
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348402AbiEDKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:42:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348286AbiEDKl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:41:56 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573D82A250
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:38:16 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so1604144lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aIei54pOigWQK9+b+OkuEAgJl1aHkkUTvctdnQzlHt4=;
        b=p0VO7qbsL7uF9M9/7ebYfqcO6JdNdD5a/QA5s064dT12fcvviR6wea5z8IkxOrVoyM
         VUNhiDj4X8/+FW6HvzkKp4vdNUYxLuIbQdOD8ifURVedOD9eeCpxzCw/Ar2dVQxkU9BD
         ilq0Y3MuGyvqnp/h8JvbkpxRXB5KpQormgYBo5GKUuM65GuRm/weR/HyQIZbBEbFMKND
         98UrUCEeB4DlubfqxACY+6m4Q5W7ZQ1l/AFlX8nN7d3p1bg7N+qZpHEXeqS5ya924NVT
         ofuwIaGzxEm48qe1Au0jlA7p/idKArtFirJ3dVGK5IX4rxR3S8AKzznF6y9Vu4kpbTKQ
         GxjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aIei54pOigWQK9+b+OkuEAgJl1aHkkUTvctdnQzlHt4=;
        b=kLRSPST6fWXiH+Djda9Lu25F6yBqaoLNnmcQXrCg1gVyKUqL0d7wwj95Fp3q44wmgf
         pIR8FLIUEVtD+jnfH1fT5UAA/LJcY0XxLX1qGXbXaU93ehMPTbSnsDHgFKPHD12ljYEm
         ED0/KlFJINmbDAZzxdxdr7ZxuJp61q7HFunQ5S5vgWCf7rWlQ8K3dRE7hXatYmQUshBk
         pyMOgcWOXuYs8QQ4r0zBxpkBSl6HhBZnVNHtEnuVAel339ewF9cPo76YqHn335rEBrsg
         ktAXvquZavOu3eDxYAdl3sUN9GYqr7LXW8rWb0TRA9r72SW2tLItOauTgAcE68e8kFRY
         OVuA==
X-Gm-Message-State: AOAM533g8Zk2/SGiJK00LkoOBOUhqeA3+xIhXP80N72fYGAZ9aoQDNtP
        aA6NU5LktQJU8WmQ1AXQ30tdxgpkYRwKaH44lhURhw==
X-Google-Smtp-Source: ABdhPJwqEGO9KRl5DaF0jB3TjhJs4ZD0v8c25IWGC8C18y+TB8EClCVVs9A9uZbWsFRWbQbkHeM1oxy1vrwUxo+HD+s=
X-Received: by 2002:a05:6512:301:b0:471:ecd0:ea24 with SMTP id
 t1-20020a056512030100b00471ecd0ea24mr13515941lfp.71.1651660695871; Wed, 04
 May 2022 03:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220428081817.35382-1-krzysztof.kozlowski@linaro.org> <20220428081817.35382-2-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220428081817.35382-2-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:39 +0200
Message-ID: <CAPDyKFok+boJ5hHLduJbQ3AZjNWfWXB93=bem_s97yf=j3XRRw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: mmc: brcm,sdhci-brcmstb: cleanup example
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2022 at 10:18, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Cleanup indentation and order of entries in example DTS.  The most
> important when reading the DTS are compatible and reg.  By convention
> they are usually to first entries.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  .../bindings/mmc/brcm,sdhci-brcmstb.yaml       | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> index 54a0edab5f8c..b672202fff4e 100644
> --- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> +++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.yaml
> @@ -65,15 +65,15 @@ unevaluatedProperties: false
>  examples:
>    - |
>      mmc@84b0000 {
> -      sd-uhs-sdr50;
> -      sd-uhs-ddr50;
> -      sd-uhs-sdr104;
> -      sdhci,auto-cmd12;
>        compatible = "brcm,bcm7216-sdhci",
>                     "brcm,bcm7445-sdhci",
>                     "brcm,sdhci-brcmstb";
>        reg = <0x84b0000 0x260>, <0x84b0300 0x200>;
>        reg-names = "host", "cfg";
> +      sd-uhs-sdr50;
> +      sd-uhs-ddr50;
> +      sd-uhs-sdr104;
> +      sdhci,auto-cmd12;
>        interrupts = <0x0 0x26 0x4>;
>        interrupt-names = "sdio0_0";
>        clocks = <&scmi_clk 245>;
> @@ -81,6 +81,11 @@ examples:
>      };
>
>      mmc@84b1000 {
> +      compatible = "brcm,bcm7216-sdhci",
> +                   "brcm,bcm7445-sdhci",
> +                   "brcm,sdhci-brcmstb";
> +      reg = <0x84b1000 0x260>, <0x84b1300 0x200>;
> +      reg-names = "host", "cfg";
>        mmc-ddr-1_8v;
>        mmc-hs200-1_8v;
>        mmc-hs400-1_8v;
> @@ -88,11 +93,6 @@ examples:
>        supports-cqe;
>        non-removable;
>        bus-width = <0x8>;
> -      compatible = "brcm,bcm7216-sdhci",
> -           "brcm,bcm7445-sdhci",
> -            "brcm,sdhci-brcmstb";
> -      reg = <0x84b1000 0x260>, <0x84b1300 0x200>;
> -      reg-names = "host", "cfg";
>        interrupts = <0x0 0x27 0x4>;
>        interrupt-names = "sdio1_0";
>        clocks = <&scmi_clk 245>;
> --
> 2.32.0
>
