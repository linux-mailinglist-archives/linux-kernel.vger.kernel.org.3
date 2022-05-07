Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0FF651E82E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352258AbiEGPg6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 11:36:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343852AbiEGPgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 11:36:49 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A49C41334
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 08:33:01 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id kq17so19413653ejb.4
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WoF/0Ii49PYDNsk6u6jquUVes8vOOgnxL82lmVkopNk=;
        b=hbZaxNI6qN5ydwitjGS0ycJ9PrQVMErIN1myj1i3Ic5I/wOTsddYnje4UHU/Y6tcoW
         C+A6D9U2emUq4347u90brLDS/vPg0mM61AacXYqH3g61vorylNW6UU6zdKpJgdhkEUtC
         O0VmPrVZdrI/E3ZFMtAjDiAqW0EqC4qAMDohmKOe8PAIwBdnAMU7+0/pxpzVW8IqJ7xB
         WZyLMEZav+nHSkEmyGSlul3lmo9gmE/zC38A6lAcwrmJx6uRgOL63hJ1OAjjUSEwY1eq
         h+bO8Bs1sWouHF9uJ0HdHe9T/w4sKn09X5OGBZyYtKv7j9ErXsFgsU9kefByqJ7dMLxS
         FEDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WoF/0Ii49PYDNsk6u6jquUVes8vOOgnxL82lmVkopNk=;
        b=iAZmVPQ686oqJAz3BVHUWvR6rzczCEd8lO6j0ty+H4l/NBVJhKWy1gDxlWeF9wkMmN
         F37qq0uIE9Z+u7lGktACIVWuFDLnVghi1zf6xl8A4stmH3Gp5S6uNDI2ZZPmDA/s5dSs
         T4r6fqHFiQynu3CQLTKrUPLaa5UPu0S6oScSOlr9Q3i7Vddd4BQUy/pHxsKvBVqKU1Yh
         eKMoHER9LZcBWvSRmy1GGU313O1rkmqLSxumGLph8ItEldq7cxz4U1aC7dDIcR3Fxc+Q
         Kl3lD0FwbTfy4oUqbcRZ5PWqKDFhRChGbQ/LV3gaKOJPlgcs2S+idHoP+PWsrvLbvMdg
         snyw==
X-Gm-Message-State: AOAM531oDE3YXgtjG4rPI2NSRSWpU+rJ4rzXW+vO1KfpnAeLEP7Tn5rw
        FnVNBH9YGE3jyVeIWaIpydc4nA==
X-Google-Smtp-Source: ABdhPJyuLCjiprducycd4P1q1AptPYjmn5ilrCEHgqAYEPSF8/JtPmr16zxUdgC2vuN4SVeDmW0IWQ==
X-Received: by 2002:a17:907:98eb:b0:6f3:ce56:c1a2 with SMTP id ke11-20020a17090798eb00b006f3ce56c1a2mr8034161ejc.173.1651937579992;
        Sat, 07 May 2022 08:32:59 -0700 (PDT)
Received: from [192.168.0.232] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id v4-20020a056402348400b0042617ba63b8sm3758505edc.66.2022.05.07.08.32.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 08:32:59 -0700 (PDT)
Message-ID: <2ab35af2-b067-4243-35ed-a592a7046374@linaro.org>
Date:   Sat, 7 May 2022 17:32:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/3] dt-bindings: display: Add bindings for EBBG FT8719
Content-Language: en-US
To:     Joel Selvaraj <jo@jsfamily.in>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Corentin Labbe <clabbe@baylibre.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <cover.1651835715.git.jo@jsfamily.in>
 <BY5PR02MB70099A894450D05DC7359CEAD9C59@BY5PR02MB7009.namprd02.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <BY5PR02MB70099A894450D05DC7359CEAD9C59@BY5PR02MB7009.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 14:17, Joel Selvaraj wrote:
> Add bindings for the EBBG FT8719 6.18" 2246x1080 DSI video mode panel,
> which can be found on some Xiaomi Poco F1 phones. The backlight is
> managed through the QCOM WLED driver.
> 
> Signed-off-by: Joel Selvaraj <jo@jsfamily.in>
> ---
>  .../bindings/display/panel/ebbg,ft8719.yaml   | 78 +++++++++++++++++++
>  1 file changed, 78 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml b/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
> new file mode 100644
> index 000000000000..fac6c9692c55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/ebbg,ft8719.yaml
> @@ -0,0 +1,78 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/panel/ebbg,ft8719.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: EBBG FT8719 MIPI-DSI LCD panel
> +
> +maintainers:
> +  - Joel Selvaraj <jo@jsfamily.in>
> +
> +description: |
> +  The FT8719 panel from EBBG is a FHD+ LCD display panel with a resolution
> +  of 1080x2246. It is a video mode DSI panel. The backlight is managed
> +  through the QCOM WLED driver.
> +
> +allOf:
> +  - $ref: panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: ebbg,ft8719
> +
> +  reg:
> +    description: DSI virtual channel of the peripheral

maxItems

> +
> +  reset-gpios:
> +    description: phandle of gpio for reset line

Skip description - it's obvious.

> +
> +  vddio-supply:
> +    description: phandle of the Power IC supply regulator

s/phandle of//

> +
> +  vddpos-supply:
> +    description: phandle of the positive boost supply regulator
> +
> +  vddneg-supply:
> +    description: phandle of the negative boost supply regulator
> +
> +  backlight: true
> +  port: true

Both should not be needed - they come from panel-common.yaml. They might
stay in list

> +
> +required:
> +  - compatible
> +  - reg
> +  - vddio-supply
> +  - vddpos-supply
> +  - vddneg-supply
> +  - reset-gpios
> +  - port
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |+

No need for +

> +    #include <dt-bindings/gpio/gpio.h>
> +    dsi0 {

Just dsi



Best regards,
Krzysztof
