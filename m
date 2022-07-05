Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4AC95670FF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 16:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232172AbiGEO1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 10:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiGEO1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:27:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285F0E2D
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:27:33 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id c15so14796540ljr.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=cq+rwG5GlUu183kF9O9RM161Z2xkyctrzWRCkzqLHRA=;
        b=ETPZ2xI6tl+nu08jgqeul7MugHkuS70DC1p+sN8Nmnf0r8zuH//FUYkyGQUHTCy2uV
         lT4uOu9IXXw4wm4vjo1+QfgNmXShQythbfbJEDAfeFDfu0LA/hpZu2VysB0/P3WFbhPp
         Py0Iw0V3wRAxiaj7oyzDDGt+NnN011pt3eLODl89C66EGV4u5qRfNT0+777BkepB8h6t
         sCIiTxtZD6RzAgk/+wni+ccIWlbOxgcM4/FDdllMhiUf3w9LD7kMlxz1fS5M36i00pmd
         6apDoQCdciU/ZPUd218M20IWCO5xoQkH7pKzgZziDiN0EKyeFqG1JQ4n+HRBUx2Upubl
         cRPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=cq+rwG5GlUu183kF9O9RM161Z2xkyctrzWRCkzqLHRA=;
        b=1A3g/E7RJC+wKWPWcD+zshqO60XZ/9teb6z2GPTWumMqQGEx8B5bt4SH0O3dQaZgAt
         ncSz2LVOFqFYidhL0GtHsuoC3FKTxI3JYMT4Z1Oew1OdpP8rNKWtxRXi+8mGLI16lEgT
         9lCpb0srZESwsz/gRGYFnQt9/EE4xIc12ViwuOAdaIKo0lxKey6VfAeV1ay8sCXNyV60
         21oQQahlaGol3V1xTy2lXbnWSS8Qcabs9eIkiDHL8uv75WEuBHllDgTiKjP+JE1bwHLg
         u2N6hX6GFhz45i0ORyygONPlGRh82DpZsBmI/KwWGU221nj0IZMvpJcgCm2OwubYVzuk
         WEiA==
X-Gm-Message-State: AJIora+DLmarY2albov8rht8Xnz58Fctkja5ObGT0pvTTLtgDXvQkJmr
        LtArVwtih/nn5nxE4XdZwr1Fag==
X-Google-Smtp-Source: AGRyM1tjXaQxw2mEkj/bUlJ/hl3fhMF5vUOSsIl5m3rHYUUrzbIO0Cvzt7BPdZh5Xh4tSW+wmYPvGQ==
X-Received: by 2002:a2e:b94e:0:b0:25b:b99f:4f58 with SMTP id 14-20020a2eb94e000000b0025bb99f4f58mr19250754ljs.263.1657031250676;
        Tue, 05 Jul 2022 07:27:30 -0700 (PDT)
Received: from [192.168.1.52] ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id j11-20020a056512344b00b00484e9e254c4sm74818lfr.100.2022.07.05.07.27.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 07:27:30 -0700 (PDT)
Message-ID: <3e2c2b6b-713b-e613-9712-0b9c6d8ba8cc@linaro.org>
Date:   Tue, 5 Jul 2022 16:27:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v13 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705053657.2340274-1-xji@analogixsemi.com>
 <20220705053657.2340274-2-xji@analogixsemi.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220705053657.2340274-2-xji@analogixsemi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07/2022 07:36, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> 
> ---
> v12 -> v13 :
>     1. Drop the quotes for "$id" and "$schema"
>     2. Remove "allOf" label
>     3. Change node name from "i2c1" to "i2c"
>     4. Change node name from "typec" to "usb-typec"
> ---
>  .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> new file mode 100644
> index 000000000000..57429864d499
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> @@ -0,0 +1,76 @@
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
> +        usb-typec: anx7411@2C {

1. node name is still not correct.
2. lowercase hex, so @2c.

> +            compatible = "analogix,anx7411";
> +            reg = <0x2C>;

lowercase hex

> +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio0>;
> +
> +            typec_con: connector {
> +                compatible = "usb-c-connector";
> +                power-role = "dual";
> +                data-role = "dual";
> +                try-power-role = "source";

The DT schema requires ports property and just "port" is not accepted.

> +
> +                port {
> +                    typec_con_ep: endpoint {
> +                        remote-endpoint = <&usbotg_hs_ep>;
> +                    };
> +                };
> +            };
> +        };
> +    };
> +...


Best regards,
Krzysztof
