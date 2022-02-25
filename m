Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586A44C4A24
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiBYQIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242673AbiBYQH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:07:57 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DB40931;
        Fri, 25 Feb 2022 08:07:24 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id vz16so11881669ejb.0;
        Fri, 25 Feb 2022 08:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ts+FkTbShV4Wpp+wSNsd+uKmnjaetMFa029W72HjYZs=;
        b=hRJtnxCADcNU3McONXvS4XWl7ATSSCg+T4M+vqVitzVmwhCTl6UxDXVwSfiDMTQbby
         EH3CSYEa8Nklkze+TivabDlc+a6no0MmW8K5IMHF0u0qP3GrNbKpnXwH2G/2/Lbi4W48
         NixueKemw0g/HvdGUfVCPXDA5J2P0cYf4YG1/Rraa8Ai2ltQ/gmLwZd2WWI9WmRmcqmF
         nD6LnRE+MEyoBHgyS9RCkPbRkc5F2V+eKLqspIwdoDa36llbSKDVNtIM7hZMn6J+u4MZ
         gS6kyR5GklbmcnkKEV2ANMOleSJ+7BO5ahwkhcP9zTOwqx9RE2N/f+6jNqntSz66Dpd1
         b95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ts+FkTbShV4Wpp+wSNsd+uKmnjaetMFa029W72HjYZs=;
        b=bfpbtWMmy1CZCm7FtZhbtTzwl0El+ebOw9j8eNGlEP7+zhHd132Dc6L0oOCpyPU0pP
         cWGa7cpK7qV07d+8rrGLsg29G0HRkSrU7VJgM/8YbY3NjcsV/vjgmebCED9dcJfrFRav
         ldZefWKwu7SGIU0GA+il68e5wnxLXTZOolfAn8h/1954KEpYvXdjpAl58pudKGJUB338
         0bwlxLbjwaJWXo0ezfaN6UzRnWwg41au39SJkyjUSvVecMhr97ReBGyOqmZ60PZ4ZVD+
         /xkESFUCiUBauCevk1LMcQra1nshCx7RKETNSDV56z8ag2xFEJsSxhESAl8HovkJnr2b
         RbgA==
X-Gm-Message-State: AOAM531y/hQLaxBUQZ/D4fjnBfNZpnK9YcH1f1LDvwT6WJ9r1zoowrAB
        ReCwnFPhFYtW1aPMAJjSgHo=
X-Google-Smtp-Source: ABdhPJy9Rv6QkaL/cuO5EzUsXPf5Sxhe48gGqhncSPETom7hz7UYhj/+YcJrExMr8MC2rYnKRker8A==
X-Received: by 2002:a17:906:a046:b0:6b9:20c:47c1 with SMTP id bg6-20020a170906a04600b006b9020c47c1mr6459495ejb.615.1645805242584;
        Fri, 25 Feb 2022 08:07:22 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7cc0a000000b0040f826f09fdsm1506921edt.81.2022.02.25.08.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 08:07:22 -0800 (PST)
Message-ID: <5cca79dc-619c-a162-e850-b3efd4dc746d@gmail.com>
Date:   Fri, 25 Feb 2022 17:07:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 2/8] dt-bindings: usb: dwc3: add description for rk3568
Content-Language: en-US
To:     Peter Geis <pgwipeout@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Riesch <michael.riesch@wolfvision.net>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
 <20220225145432.422130-3-pgwipeout@gmail.com>
From:   Johan Jonker <jbx6244@gmail.com>
In-Reply-To: <20220225145432.422130-3-pgwipeout@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Lots of USB series all of a sudden.
Combine possible?

On 2/25/22 15:54, Peter Geis wrote:
> The rk3568 dwc3 controllers are backwards compatible with the rk3399.
> Add the device tree description for it.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> index 04077f2d7faf..e3044e81cc72 100644
> --- a/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/rockchip,dwc3.yaml
> @@ -30,6 +30,7 @@ select:
>          enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3399-dwc3
> +          - rockchip,rk3568-dwc3
>    required:
>      - compatible
>  
> @@ -39,6 +40,7 @@ properties:
>        - enum:
>            - rockchip,rk3328-dwc3
>            - rockchip,rk3399-dwc3
> +          - rockchip,rk3568-dwc3
>        - const: snps,dwc3
>  
>    reg:
> @@ -75,7 +77,10 @@ properties:
>      maxItems: 1
>  
he
>    reset-names:
> -    const: usb3-otg
> +    items:
> +      - enum:
> +          - usb3-otg
> +          - usb3-host

The use of reset-names is "sort of" only related to the rk3399 legacy
node. Still using this sub node DT to not to break older existing boot
loaders.

https://github.com/torvalds/linux/search?q=usb3-otg

It's only mentioned as comment in dwc3-of-simple.c but not used:

 	simple->resets = of_reset_control_array_get(np, false, true,
						    true);
core.c uses something similar.

	dwc->reset = devm_reset_control_array_get_optional_shared(dev);
	if (IS_ERR(dwc->reset))
		return PTR_ERR(dwc->reset);


Up to the maintainers, but I wouldn't add another variant/name for the
same thing as it also optional(= not required) and no longer needed.

Johan

===

Maybe drop PCLK_PIPE as well to reduce notifications.

See example:
https://lore.kernel.org/linux-rockchip/20220225131602.2283499-4-michael.riesch@wolfvision.net/T/#u

>  
>  unevaluatedProperties: false
>  
