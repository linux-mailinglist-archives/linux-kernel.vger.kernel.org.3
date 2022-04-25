Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2942950E494
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 17:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242944AbiDYPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240526AbiDYPmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 11:42:07 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8287C23168;
        Mon, 25 Apr 2022 08:39:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r13so30408869ejd.5;
        Mon, 25 Apr 2022 08:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pYmQqIYD75N8SfHaj0AHYF+l6GG1We6pvmxz4RUic0U=;
        b=HcSKLFcQ39VMWJjtBZOifOr7HgnGBAnQ/2K6mqcHILLQHQEUof1EcH0ST5RP2UyCJW
         sPlugYviZSHSzfhUOdEgns1D2XbP9ik5vVLAa8eQyh+ujOu3Lu7vfKwOvBGFzAgZvNbU
         IVSox7dVLyL/HoeY3CNQ+eVnLotEv6w2ejPCurmWyENlL9f+Jtx40Z/cAX0ihd6LUeJH
         4LTCpaJ6ib1GjFQ1g7nKC9zvclPmJkQy1D4af2UW1r3iG3PFl9M5GO8Qtswn7ipHZde0
         YxEIzYVmsQWrtVf2akEMf6LfzlFWMJknvrruua5q5qcfAX/sW+18ZYvIuUX6M5J1ojo/
         O5aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pYmQqIYD75N8SfHaj0AHYF+l6GG1We6pvmxz4RUic0U=;
        b=pr1u17HYRbqbbqqpvhhP4IUD7sUa3dNhkz2DwHVs94G06h/hJZ97VIDtOw76Dl6FXI
         XBCvZ9GrcImxDl68oz0qOMUf7faJUv/7QEd4RiflWYi4jN05rMAs5WdZpzL8XTZp4kW8
         93GKfG9vrI+Glzyyy0RyvKN3sgbpt0ITvLB6FXYeNtHwKKJ8hX/xQq5b67/evhaP8GY0
         FNny50IkL7tR0ilTbucPJAcKN7rAnwq12Iqjw0WdYcLSzohSTES40tRthEnWTrLt7V0X
         RR5MNucsU62z+R+MNQNTJsud2v894c6qN6iSiypKGMSWrCB8QGfOXqYruIsNPFYDC2Ye
         +i2Q==
X-Gm-Message-State: AOAM530PQST24InvL1lRiMtHVafP06hCV9FW9CcnCADKZZjJRtycY20U
        K1D3/IQF97t/Jys/AbrO73Q=
X-Google-Smtp-Source: ABdhPJwwSkqiGf16KxdNekflI3QJP2lMS26OvuOMJjFrLD26JHb5D0s3BuIki9ZRVb340m/EuLrD8Q==
X-Received: by 2002:a17:907:2daa:b0:6da:924e:955 with SMTP id gt42-20020a1709072daa00b006da924e0955mr16948119ejc.1.1650901139986;
        Mon, 25 Apr 2022 08:38:59 -0700 (PDT)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id s1-20020a056402036100b004240a3fc6b4sm4838063edw.82.2022.04.25.08.38.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 08:38:59 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Dang Huynh <danct12@riseup.net>, Dang Huynh <danct12@riseup.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: sunxi: nanopi: Remove input-name property
Date:   Mon, 25 Apr 2022 17:38:58 +0200
Message-ID: <3427349.iIbC2pHGDl@kista>
In-Reply-To: <20220425064231.243482-1-danct12@riseup.net>
References: <20220425064231.243482-1-danct12@riseup.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 25. april 2022 ob 08:42:32 CEST je Dang Huynh napisal(a):
> This property doesn't seem to exist in the documentation nor
> in source code, but for some reason it is defined in a bunch
> of device trees.
> 
> Signed-off-by: Dang Huynh <danct12@riseup.net>

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> ---
> This patch is a split of this treewide patch [1] to ease the 
> maintainers. 
> 
> [1]: https://patchwork.kernel.org/patch/12633497/
> 
>  arch/arm/boot/dts/sun8i-h3-nanopi.dtsi | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi b/arch/arm/boot/dts/
sun8i-h3-nanopi.dtsi
> index fc45d5aaa67f..a9f749f49beb 100644
> --- a/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3-nanopi.dtsi
> @@ -75,7 +75,6 @@ led-1 {
>  
>  	r_gpio_keys {
>  		compatible = "gpio-keys";
> -		input-name = "k1";
>  
>  		k1 {
>  			label = "k1";
> -- 
> 2.36.0
> 
> 


