Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77745715E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232561AbiGLJjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 05:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiGLJiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 05:38:54 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13EC2644
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:38:52 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id p6so6408184ljc.8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=DPmmhi+2J1rxKC4UbiQ/cFtEMBdLVlyhY+s/IdsukL0=;
        b=Gh3DmoyEfQ/kog6KzHV6sC/jLz88DNk+G8JpIZFTDJfrqZu2ZFpy8kJhfvW5pZDwNp
         6pgPlBNjjCn/Tk+L35mpODgdbYUXDBm4W2UpqNRhfMuVXdEfHOQap2hyqnvgnPl9Rv59
         xrcieOWOfa+DPq76bL5fE5+gX6dREG7jjJY/fwgl3yHr+G+/peSzHtXN7MJgAKaY1qv7
         pXuHWua24lARqSOa6xuzXuPxPfeltvG6ji7abBeocfrdnkntNAa5Wdec1Bg08HFnm25K
         3qfXsBfmQ+k/VJTcnbEtLrZRk8YGeZEqTDY3EY9UXLFnCdv82/gc2xxRS5IHLz/kN+Wu
         DBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=DPmmhi+2J1rxKC4UbiQ/cFtEMBdLVlyhY+s/IdsukL0=;
        b=OTTEzoIJe/Q/nrjbaO4yIa5Ud1FzH/eZRkbflku7AD9ML4HuFOr3yUAhOT907EvJTQ
         MCQ67mUNlGMN27UwJBNhg8pqEZvxGhOuAAP/SsCrBMUduvJO2bR+C3m8x6kKYc5e1973
         7aZ9zzgMxMMHoF0CqgEb08jaz1JRQIP/EANKEVOIkxf4AuY+f8fbXynZy9ve5KKgzFXH
         OP2fTz7NhiiKNwU6g9sgJotZbD4ku/pWipyLx2JB6HrOYxAy9AdIz4Pz3zjWi3Rj78JQ
         yDfTsgR3pUL9863ZHX+KF9C8pgt4x2oDpMim8ZezR0jIA24dXVfdeQDGtlP/0rSoY352
         J46g==
X-Gm-Message-State: AJIora/O3mkmdfAgaT2nV9W50o9kLcRmEwdAS26/ZN6LvudSpt8EskcE
        moVl9Sh+y4JBV2rzNSdPsA7q1w==
X-Google-Smtp-Source: AGRyM1tchxD7VKZTXRAYOEvY2VFhTArisZH6aNEblZI+hYGxn8HJ7tYZDZ9eGchgeZadyJEiJhI9HA==
X-Received: by 2002:a2e:131a:0:b0:25d:68eb:cf6 with SMTP id 26-20020a2e131a000000b0025d68eb0cf6mr6071967ljt.267.1657618731025;
        Tue, 12 Jul 2022 02:38:51 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id q18-20020a056512211200b00489db87cb7csm1362314lfr.280.2022.07.12.02.38.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 02:38:50 -0700 (PDT)
Message-ID: <a281de26-0900-94b1-c139-f7af27a57d42@linaro.org>
Date:   Tue, 12 Jul 2022 11:38:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v16 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712090534.2783494-1-xji@analogixsemi.com>
 <20220712090534.2783494-2-xji@analogixsemi.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220712090534.2783494-2-xji@analogixsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/2022 11:05, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> v13 -> v14 :
>     1. Fix Robot compile error. Fix node name not correct.

Node name is still not correct.

>     2. Change HEX to lowercase.
>     3. Use "ports" property.
> v12 -> v13 :
>     1. Drop the quotes for "$id" and "$schema"
>     2. Remove "allOf" label
>     3. Change node name from "i2c1" to "i2c"
>     4. Change node name from "typec" to "usb-typec"
> 
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/usb/analogix,anx7411.yaml        | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> new file mode 100644
> index 000000000000..bbd071ba338f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/analogix,anx7411.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analogix ANX7411 Type-C controller bindings
> +
> +maintainers:
> +  - Xin Ji <xji@analogixsemi.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - analogix,anx7411
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  connector:
> +    type: object
> +    $ref: ../connector/usb-connector.yaml
> +    description:
> +      Properties for usb c connector.
> +
> +    properties:
> +      compatible:
> +        const: usb-c-connector
> +
> +      power-role: true
> +
> +      data-role: true
> +
> +      try-power-role: true
> +
> +    required:
> +      - compatible
> +
> +required:
> +  - compatible
> +  - reg
> +  - connector
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        anx7411@2c {

Use generic node name:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +            compatible = "analogix,anx7411";
> +            reg = <0x2c>;
> +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio0>;
> +
> +            typec_con: connector {
> +                compatible = "usb-c-connector";
> +                power-role = "dual";
> +                data-role = "dual";
> +                try-power-role = "source";
> +
> +                ports {
> +                    #address-cells = <1>;
> +                    #size-cells = <0>;
> +                    port@0 {
> +                        reg = <0>;
> +                        typec_con_ep: endpoint {
> +                            remote-endpoint = <&usbotg_hs_ep>;
> +                        };
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...


Best regards,
Krzysztof
