Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3D6957A9B7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237268AbiGSWTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236334AbiGSWTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:19:32 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8353F54645
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:19:29 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id j3so8753395oif.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CRBhHPNd8lkmJ/xyyV0gCO7YkNC1yX8SCs8PR5uQJIQ=;
        b=tSY7/OtHYLqnxjYX7qF+CiOMHcE4AiqiraYqXnuB2wZu9Z3IsdH5Tj5WYfS8R55Kcm
         PqPeMzZ6NTAiID6lp6MPyhnWvXNpNxpFGUrp5EeqcGGyYpGSCsD1Yr3gTZKDV9xX99PM
         uy5I8KF9watPaMYZLrXxeQkoCvHPHnTy5sCkepBJz9NqaykwG+bbm3brIH/Vygl1ozxx
         f6tZVmSXRvQnzU8FrlGW1koqtjR8gIQ/rxvjH0BDRs5nKNjXo47FfEbYsXklcI2doN2H
         Nmj6sI/A9RXphA0LZjRJREM3/XL/nUnA07qCeV4EBDU145le06PG2+zQgsjh12P4LZLp
         VkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CRBhHPNd8lkmJ/xyyV0gCO7YkNC1yX8SCs8PR5uQJIQ=;
        b=gTPr/CNjImDjHSfq3rWNvR/ivNYWR19ncrD3W42DU6ZGQMvibXkXWsbpTDh7ZfFvRG
         ggHuJhmITqb0HGlZf9s2/+ADftXb2IjmhwrIRIL1LCEQOXLOn1poOLUt6sxdTnRvYzXo
         FDK4Tac4btu06V+GTdg896oi/RQG91etrZ1+snQQ+sTPnJ+GB0JH3kmX+pntwrzdmiZV
         IXy5gxHqf73c/NXl08ELmeecPRrm4LJHBlfUXZ5j81Hckx9QrRUe8k9qgUnUKx9acqHm
         HFjzorisD+wB/7E/yGgC4ZTjEwY6V8AY+cqSLjuOUBv79Bn4HsyCEjZpFEBFd0vSKP70
         euBg==
X-Gm-Message-State: AJIora/si2r/vkll9qYulr5TzPPGkvvSpVVYvrhl0Yq4vnLRpjrjTpC5
        hKtTtyO9O7yWUoNQs/JdofSu2g==
X-Google-Smtp-Source: AGRyM1tHME1bRoBD15TC5jZn2/JyI3PJMNYV0SSySQZH9tYLXGVz2G4SriJU0tXmlpR34OVN8Juu1Q==
X-Received: by 2002:a05:6808:1885:b0:33a:74ac:8b79 with SMTP id bi5-20020a056808188500b0033a74ac8b79mr868009oib.237.1658269168799;
        Tue, 19 Jul 2022 15:19:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id z34-20020a056870d6a200b0010c5005d427sm8194177oap.33.2022.07.19.15.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 15:19:27 -0700 (PDT)
Date:   Tue, 19 Jul 2022 17:19:25 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux-leds@vger.kernel.org, pavel@ucw.cz,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: Fix 'dtbs_check' errors for
 pm8350c & sc8280xp pwm nodes
Message-ID: <Ytct7QzHOlvXH7s3@builder.lan>
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 19 Jul 15:50 CDT 2022, Bhupesh Sharma wrote:

> make dtbs_check currently reports the following errors
> with pm8350c & sc8280xp pwm nodes:
> 
> arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
>  pwm@e800: 'reg' does not match any of the regexes:
>  '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
> 
> Fix the same.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/pm8350c.dtsi        | 1 -
>  arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> index e0bbb67717fe..33f939132571 100644
> --- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> +++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> @@ -32,7 +32,6 @@ pm8350c_gpios: gpio@8800 {
>  
>  		pm8350c_pwm: pwm@e800 {

You need to also drop the unit address.

That said, looking at the dts it's quite nice to have the address of
these nodes. So perhaps we should fix up the binding and populate reg
instead?

Regards,
Bjorn

>  			compatible = "qcom,pm8350c-pwm";
> -			reg = <0xe800>;
>  			#pwm-cells = <2>;
>  			status = "disabled";
>  		};
> diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> index ae90b97aecb8..69f5bc8127b2 100644
> --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> @@ -62,7 +62,6 @@ pmc8280c_gpios: gpio@8800 {
>  
>  		pmc8280c_lpg: lpg@e800 {
>  			compatible = "qcom,pm8350c-pwm";
> -			reg = <0xe800>;
>  
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 2.35.3
> 
