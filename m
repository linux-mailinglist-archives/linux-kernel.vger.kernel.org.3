Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C096E537087
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 12:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiE2KNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 06:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2KNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 06:13:08 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467361CB01
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:13:06 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jx22so15876101ejb.12
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 03:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=bUy1BLSfINnv6ERfgwnR9eRuDhaZE3UpSRaIiNc0rCk=;
        b=fOCVaeWekIDBF1ZTj+ZMJy83A6Ex7xJs/MN5E3AF/v8o5zvs2ENqHEpThyFQUumh+d
         VTifvXiSxPk5W/+dDVbHcSm5nTN5ozMBfO9Xr2FdVvVMuF7/tscs3txTgA6KQDGAvteR
         R8vvvIKMs07CwMPbo+dU74xrLJqj+jG2KEWkS5XBl5zzOi46h2eqERFGuaD0JLzwjFZq
         9pqqEmsGVdEumazbZKkSsonZV/jyU4DZRO5FA7hpOZlKR6ET6NlcMfI/cN3WlBxTIcWW
         m2dopHfGh1WUkzNIKBbPOgtZwYrEdO/nOHnZUVwUP1vi18jBhR2wgfhCwGWyMO9HSjhj
         ktSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=bUy1BLSfINnv6ERfgwnR9eRuDhaZE3UpSRaIiNc0rCk=;
        b=2yHISUpL8+Si0tE2TlSYwdsZDMiYQ0gE+/AKQMbbgKhwKxOuCJk3HpJDTHNfVmc4AC
         IebvWYPBSlgidy0ET8ZMutdRwoNRZwFoHXM5bsq+mwrvWIB1qP472Az9B73GgQA7Ugbx
         RaTePtbgw175dkk4Lx5m8kUQpoAuaqWUXAyVItKgO69fQmgUOHub02Lk1oX3iplbYP18
         N84jq660VMnk1GY7Fe9eKISH4Nuy0vVZUspBpWCfa6ZgzGSC0pc6b7NHW+hQpPCKdYud
         6oukpNjHUC8SiPb9saGpV86CJT40QguTbnvxG23UzmMyP5G1sA1+9NRUny5OxkMusBLX
         6ZzQ==
X-Gm-Message-State: AOAM532Ub1YJtTehBMj9jRUACLOlFUlX/w5lucSuaMM0flyzmqtIpi7e
        IfXV+/U5wLEU+By5eHw+N/Vwzw==
X-Google-Smtp-Source: ABdhPJwRnn73I0h92HQD0I7VsbBaBGvIs+5l+glq3XnZt5443BhXX1yMDrfdu0PUF5ljjdSKKrk0/w==
X-Received: by 2002:a17:907:7f0f:b0:6fe:b18c:72cf with SMTP id qf15-20020a1709077f0f00b006feb18c72cfmr38239293ejc.203.1653819184771;
        Sun, 29 May 2022 03:13:04 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 12-20020a50874c000000b0042bc5a536edsm4760532edv.28.2022.05.29.03.13.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 03:13:04 -0700 (PDT)
Message-ID: <09803412-640a-6c9a-fe5a-b0af8cd10f0f@linaro.org>
Date:   Sun, 29 May 2022 12:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v4] ARM: dts: aspeed: Adding Jabil Rubypass BMC
Content-Language: en-US
To:     David Wang <David_Wang6097@jabil.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     edward_chen@jabil.com, ben_pai@jabil.com
References: <20220527042708.805444-1-David_Wang6097@jabil.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220527042708.805444-1-David_Wang6097@jabil.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/05/2022 06:27, David Wang wrote:
> The initial introduction of the jabil server with AST2600 BMC SoC.
> 
> ---
> 
> v4
> - Add document the new compatible.
> - Delete redundant blank lines.
> - Add a new line at end of file.

Thanks for the changes but several fixes are still needed. If some of my
comments are a bit unspecific, you can always ask for clarification.

> 
> v3
> - Adjustment entries are ordered by name.
> - Remove the bootargs property and modify the stdout-path property.
> - Group multiple LED devices into a group.
> - Modify the "gpio3_71" node name format.
> - Delete unneeded blank line at the end.
> 
> v2
> - Disable empty i2c bus.
> - Remove gfx node because aspeed-g6.dtsi isn't supported.
> - Modify the led format and add some properties.
> - Fix wrong indentation.
> - Add stdout property in chosen node.
> - Rename temp to temperature-sensor in i2c bus 0.
> 
> ---
> 
> Signed-off-by: David Wang <David_Wang6097@jabil.com>
> ---
>  .../bindings/arm/jabil/jabil-boards.yaml      |  24 +
>  .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>  arch/arm/boot/dts/Makefile                    |   1 +
>  .../boot/dts/aspeed-bmc-jabil-rubypass.dts    | 442 ++++++++++++++++++
>  4 files changed, 469 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/jabil/jabil-boards.yaml
>  create mode 100644 arch/arm/boot/dts/aspeed-bmc-jabil-rubypass.dts
> 
> diff --git a/Documentation/devicetree/bindings/arm/jabil/jabil-boards.yaml b/Documentation/devicetree/bindings/arm/jabil/jabil-boards.yaml
> new file mode 100644
> index 000000000000..dde7791aa8bc
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/jabil/jabil-boards.yaml
> @@ -0,0 +1,24 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/jabil/jabil-boards.yaml#

This should be aspeed. Let me send a send a base patch for all Aspeed
boards.


> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Jabil Bmc and Aspeed SoC based boards
> +
> +maintainers:
> +  - David Wang <David_wang6097@jabil.com>
> +
> +properties:
> +  $nodename:
> +    const: '/'
> +  compatible:
> +    oneOf:
> +      - description: Aspeed ast2600 bmc boards
> +        items:
> +          - const: jabil,rbp                    # eaglestream platform
> +
> +required:
> +  - compatible
> +
> +additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 01430973ecec..69738483c059 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -624,6 +624,8 @@ patternProperties:
>      description: Jiandangjing Technology Co., Ltd.
>    "^joz,.*":
>      description: JOZ BV
> +  "^jabil,.*":
> +    description: Jabil Design Service Branch (Sanchong)

The list is ordered alphabetically, so jabil goes before. This should be
also separate patch.

>    "^kam,.*":
>      description: Kamstrup A/S
>    "^karo,.*":
Best regards,
Krzysztof
