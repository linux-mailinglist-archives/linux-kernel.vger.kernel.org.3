Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A70751D16C
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351158AbiEFGhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347115AbiEFGhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:08 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB2C765D12
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id q23so8694934wra.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=zu4AtSrWuUrFqluTuLes2G4jySEfMkXFj4MSuotNcP8=;
        b=nBLJX9BOhZS2KhBzKZP8WIb0G2WoFXEKmhC48dL9m/dOKK+vOqbzQuLHa74JQw5FXQ
         5cw0O+kIAcHwxPJOsRhPuvrmwQrSv5gfHbrIzpkHJDlyrm1rbh1o5uRVPTJgHIqOPiWu
         OjKG5T3PIo1IZQwlUv3KiIq7I6PNOPFOMA73itk+QaX5Z9cHk703uCCzUEsCQyxTli/1
         UA7kFUggEgmXDUZE1jUzufD6KHAhos4FKwYtFAZ/Q9R4fiwyZgJ4yWmU0FUDsLFKoyzJ
         +Bu2L2omXHztui7UZ5W0MnePBtNhq+utII5P3hX4pZOa7ACPV7BOdOn7LfbT4Je0oYJn
         b5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zu4AtSrWuUrFqluTuLes2G4jySEfMkXFj4MSuotNcP8=;
        b=BoNMRvcUKao6tOrr4A9G1xMlQ+QR7PBt5QpLfiPkSkTQzhkVdWmcC0UTYSS8Dd+WZ9
         ULx9JT8g/VG/v3ZzcttTYR3p7Ec5BhlUcSiEL5I9beWW1o3eYQyjDq7qmrVRFqtFw+/C
         IjaIMiULyEfN73Uf0i3SFjNjD1WnHxgmWBGQb4oQBy5NEzgfMWRBvCwbJHoHrCQaApiz
         SYKj2yKdlMntjOilLC8HIbOsSjMV3eiLgHAJuKE2KCBYQuT/EWAgT66+j/YapwbOc84M
         ar8Vk6tWTJvvivQStCQCaEEHP/oYvjUl+8qTlBBTO6d4AMstOwJzBr1Cx5NKKnq4nvGa
         2Zkw==
X-Gm-Message-State: AOAM533I+3hn8qgP+O6Zzf6a5FQvUsARCr1T7WwUikmH+qzeuhwYOn3t
        J5c4Lo7g+daZBG+EpSU3sZ7rlA==
X-Google-Smtp-Source: ABdhPJxOYXIfHDAIKwKfUyg/bCTw83nEmd/G5PaRvat9R7xeclaq15T5zuKNKgSLHONxdU6ZfMaRrA==
X-Received: by 2002:adf:e541:0:b0:207:adb8:aab2 with SMTP id z1-20020adfe541000000b00207adb8aab2mr1354021wrm.67.1651818805218;
        Thu, 05 May 2022 23:33:25 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id bu17-20020a056000079100b0020c5253d8e9sm2691075wrb.53.2022.05.05.23.33.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 23:33:24 -0700 (PDT)
Message-ID: <836ed37a-d672-1841-844e-f6e66d79dbc9@linaro.org>
Date:   Fri, 6 May 2022 08:33:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v14 4/9] dt-bindings: clock: Add bindings for SP7021 clock
 driver
Content-Language: en-US
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        tglx@linutronix.de, maz@kernel.org, p.zabel@pengutronix.de,
        linux@armlinux.org.uk, arnd@arndb.de,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <cover.1651805790.git.qinjian@cqplus1.com>
 <96fb8d38c891ee0716375a9194b4870c43946122.1651805790.git.qinjian@cqplus1.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96fb8d38c891ee0716375a9194b4870c43946122.1651805790.git.qinjian@cqplus1.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 05:23, Qin Jian wrote:
> Add documentation to describe Sunplus SP7021 clock driver bindings.
> 
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
> fix the comments from Krzysztof & Rob.
> ---
>  .../bindings/clock/sunplus,sp7021-clkc.yaml   | 51 +++++++++++
>  MAINTAINERS                                   |  2 +
>  include/dt-bindings/clock/sp-sp7021.h         | 88 +++++++++++++++++++
>  3 files changed, 141 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/sp-sp7021.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> new file mode 100644
> index 000000000..859b2cca5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/sunplus,sp7021-clkc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SP7021 SoC Clock Controller Binding
> +
> +maintainers:
> +  - Qin Jian <qinjian@cqplus1.com>
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-clkc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  "#clock-cells":
> +    const: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - "#clock-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +

No need for blank line.

> +    extclk: osc0 {
> +      compatible = "fixed-clock";
> +      #clock-cells = <0>;
> +      clock-frequency = <27000000>;
> +      clock-output-names = "extclk";
> +    };
> +
> +    clkc: clock-controller@9c000000 {
> +      compatible = "sunplus,sp7021-clkc";
> +      reg = <0x9c000000 0x280>;
> +      clocks = <&extclk>;
> +      #clock-cells = <1>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 26066f199..5d8b420d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2744,8 +2744,10 @@ L:	linux-arm-kernel@lists.infradead.org (moderated for mon-subscribers)
>  S:	Maintained
>  W:	https://sunplus-tibbo.atlassian.net/wiki/spaces/doc/overview
>  F:	Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
> +F:	Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  F:	Documentation/devicetree/bindings/reset/sunplus,reset.yaml
>  F:	drivers/reset/reset-sunplus.c
> +F:	include/dt-bindings/clock/sp-sp7021.h
>  F:	include/dt-bindings/reset/sp-sp7021.h
>  
>  ARM/Synaptics SoC support
> diff --git a/include/dt-bindings/clock/sp-sp7021.h b/include/dt-bindings/clock/sp-sp7021.h

Please match the filename to the bindings, so vendor,device
("sunplus,sp7021-clkc.h")


Best regards,
Krzysztof
