Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626E55A1002
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 14:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiHYMKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 08:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240916AbiHYMKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 08:10:34 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC3697501
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:10:32 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id d9so3152439ljl.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 05:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=n9pMH2H5Xekwc4hhOKpfLB4HqSCAO2/+9Ps6poR2Wbo=;
        b=xWvGHAcbKndQ46QgWUjkmXeKciR8JRbi1w3t7S650F5f5PY+QPbwfvaaL9fdob0/xm
         AEjiq0m1OdZpshX5x+QHGJ2cM6ra+5a9IDyswHcejTa5iGiSrzOXuRxlu6l27EIjlo74
         xwF+IUWPAbd1nUv+YqQUsga7OHs1znP+GNDMDKawbFMGJ2HXKtoMo+FgeEeTnnN881aP
         a9FO9g5Syw9pNfaQPKBhmxuk+PmRViCldPNzECiEQ3/BkHzLT1zopc9cltNc3oxyr6/g
         RRR1wYOIk56R2RK+Z+tpyevChyma4kPCDXPAj+ZRptTJF4YxDBocGrjAwp8px5hUFpqR
         F8JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=n9pMH2H5Xekwc4hhOKpfLB4HqSCAO2/+9Ps6poR2Wbo=;
        b=FlDDj9RlsU0fmZOGq/bv03L5H1cvhksHSNQxt0ZOHUjQGdHzqzWWdCcTUl+LkYysQ6
         fcqeV9W3ATnTc76N6v4elxvDy99xSIBEjnMNwaiNU+6KxOH2baPk03PrRXGlROGuyXX2
         drHeboIztK7KBrR9O/Suxc3Qv5fTRwNM2C0ThXPNhOynPKPZYdbWCr6uDtZRcTNFFN/o
         65Uzwdc2RMxrgZrHFXRnJuGSXjwWyeVBrVBr4IO5e31ZTRATNhJoD7ncIiPenV4mxwBN
         nEifl+0aXfu+1un9mOViCByH3mEW7oGtzo2FUTKbypOj0st2w4EajtSoRD+FrSB4TY11
         6xNQ==
X-Gm-Message-State: ACgBeo1oBAMu7V3uLFs9IHFZSZvxkx5fM/RVKpBb9JycapWvEA+X96R9
        ldD7nU5QoGABJjYmsuepR//w9yoOKM8/XMy0O7M=
X-Google-Smtp-Source: AA6agR4do4MtgbwG+5E36jRCy//yvPStmF90VOaXwMtYlWscV8f7H0M9Pw8v4W4Dq9e1nE1pwlw3Pw==
X-Received: by 2002:a2e:3512:0:b0:261:c683:18a0 with SMTP id z18-20020a2e3512000000b00261c68318a0mr1014604ljz.7.1661429431027;
        Thu, 25 Aug 2022 05:10:31 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id v10-20020a056512096a00b00492eea55c58sm460099lft.198.2022.08.25.05.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 05:10:30 -0700 (PDT)
Message-ID: <0ecf1664-03a2-71ac-b967-6905b96c7ce0@linaro.org>
Date:   Thu, 25 Aug 2022 15:10:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: gpio: mpfs-gpio: allow parsing of hog child
 nodes.
Content-Language: en-US
To:     Conor Dooley <mail@conchuod.ie>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220820204130.1380270-1-mail@conchuod.ie>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220820204130.1380270-1-mail@conchuod.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/08/2022 23:41, Conor Dooley wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> The SD card and eMMC on PolarFire SoC based dev boards are sometimes
> statically muxed using a GPIO. To facilitate this, enable gpio-hog
> child node properties.
> 
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  .../bindings/gpio/microchip,mpfs-gpio.yaml     | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> index 110651eafa70..6704a7a52cd0 100644
> --- a/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> +++ b/Documentation/devicetree/bindings/gpio/microchip,mpfs-gpio.yaml
> @@ -44,6 +44,24 @@ properties:
>  
>    gpio-controller: true
>  
> +patternProperties:
> +  "^.+-hog(?:-[0-9]+)?$":

What is this pattern about: "(?:" ?

> +    type: object
> +
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
> +
> +    required:
> +      - gpio-hog
> +      - gpios
> +
> +    additionalProperties: false

Put it after type:object. Easier to read/find.

Best regards,
Krzysztof
