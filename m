Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4802E57E5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235824AbiGVRrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235096AbiGVRrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:47:00 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA09893697
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:46:55 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id u14so6301639lju.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=4pDf7ez85QHUoBuUMoHgMnyuDNXTg+iV62WcG6bVoxE=;
        b=k5jT7LN8Fx7VEkTi0XgPQxBYvaHMVqDhNuzeipXMEE2dmex+dbNJnlmZiPyNCJMZ2P
         Tc+7Z/KTvjKKzxfIihpYVp7o4uYWv8G5KY6JLb6/rgmcyvOEx53QIhkMr1TcCtHZtfjU
         kR2I+YWQCWY/iBDDjTQS8dhgAfJ/0K0bl8gJSMEbFijjb/Kz5ONZ/AnK82jGsRcYFGlo
         ww8uAvOc28X7SUpKNAUpNfi0Zd5z6ZTs0jfeIYhKjfVlo595c17U3QvI/4ImkcJcK0D4
         1kk3nFzKiBm/S5GpZW+EwKlIH5ZfbHo/D94C8C9+GvpeC9PIm2ry3y0jI4UQANy9q4r/
         XeNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=4pDf7ez85QHUoBuUMoHgMnyuDNXTg+iV62WcG6bVoxE=;
        b=sX5XeuyOlceVOdqPP/Lwme4+53/gLljtFOPSw9ScfKVrO7JjOB+h4u4GUQI3dslkAX
         D8zdvKPrWkMesN7ONjBCS2rN6sy5n+KeF77jirlJtdJMZt+IVNBWNb93mbEdAVp4af55
         CzcbzEbhIXz6MSOPvpd+O3Uf1RRy4j4B1xDoOGZdoqQYe7AKMgWi0QdPx5WOBGzAmLNn
         wyjdOshUkP8zDreOtED4f/J1IxeuQm47SqV1enfZKpQYPF1tGz1JdC/6OO+Z1krKEaEp
         MVyRItc7Lk1/ucx3fD+3adMBsn5WS4TwtJylDvxbplJcslbnMydH/9VokzHdOi6W7mU3
         cZ+A==
X-Gm-Message-State: AJIora9ycqwLL6ezhdNq8rDd/OizX1MT3MQvEwmO7dkUVNiNnlyCgMuG
        RI14+5T3q9h+SmW9LvP/aOt47g==
X-Google-Smtp-Source: AGRyM1sqFiGr1+mDJ9qbeVsgJ4L1DLzZ2N4yyzMkKPO7XUslPN8IvI+lN6tL17Kpq2z/VwHxUKK3hA==
X-Received: by 2002:a2e:a5cb:0:b0:25d:7a70:2891 with SMTP id n11-20020a2ea5cb000000b0025d7a702891mr386558ljp.295.1658512013920;
        Fri, 22 Jul 2022 10:46:53 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id o1-20020a05651205c100b00489c7fb668dsm1163070lfo.182.2022.07.22.10.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:46:53 -0700 (PDT)
Message-ID: <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
Date:   Fri, 22 Jul 2022 19:46:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Content-Language: en-US
To:     =?UTF-8?B?5ZGo55Cw5p2wIChaaG91IFlhbmppZSk=?= 
        <zhouyanjie@wanyeetech.com>, tudor.ambarus@microchip.com,
        p.yadav@ti.com, michael@walle.cc, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com,
        reimu@sudomaker.com
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 18:48, 周琰杰 (Zhou Yanjie) wrote:
> Add the SFC bindings for the X1000 SoC, the X1600 SoC, the X1830 SoC,
> and the X2000 SoC from Ingenic.
> 
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
>  .../devicetree/bindings/spi/ingenic,sfc.yaml       | 64 ++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
> new file mode 100644
> index 00000000..b7c4cf4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/ingenic,sfc.yaml
> @@ -0,0 +1,64 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/ingenic,sfc.yaml#

File name should be rather based on first compatible, so
ingenic,x1000-sfc.yaml

> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for SFC in Ingenic SoCs
> +
> +maintainers:
> +  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> +
> +description:
> +  The SPI Flash Controller in Ingenic SoCs.
> +

You miss here allOf referencing spi-controller.

> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - ingenic,x1000-sfc
> +          - ingenic,x1600-sfc
> +          - ingenic,x2000-sfc
> +      - items:
> +          - enum:
> +              - ingenic,x1830-sfc
> +          - const: ingenic,x1000-sfc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    const: sfc

Remove the clock-names entirely, no benefits.

> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/ingenic,x1000-cgu.h>
> +
> +	sfc: spi@13440000 {
> +		compatible = "ingenic,x1000-sfc";


Use 4 spaces for example indentation.

> +		reg = <0x13440000 0x1000>;
> +
> +		interrupt-parent = <&intc>;
> +		interrupts = <7>;
> +
> +		clocks = <&cgu X1000_CLK_SFC>;
> +		clock-names = "sfc";
> +
> +		status = "disabled";

No status in example.

> +	};
> +...


Best regards,
Krzysztof
