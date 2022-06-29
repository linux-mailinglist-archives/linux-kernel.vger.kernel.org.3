Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A9955FCE7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 12:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232628AbiF2KMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 06:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiF2KMj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 06:12:39 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43AF23BE6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:12:37 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id pk21so31609977ejb.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 03:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=UQVs/vk3TXmyqHO0m20AymMZtMAnKjYQ1g4TBF6/kA4=;
        b=tnbsHSwQFfXRfiqLQMLSrwpXtVEZKHjoZImczR4HSgCINnV15+SS3BgKi+MZ9GTu91
         PwIy2TldEysT/aS+k6lpU5zR2HABIBWqHgagH8Dua908aU7MLwwpdtw8dlg9wHFlF8I7
         E0OyC++4PcPlsKCYhvi92uu3JJEzJEeNyAaO54vjoOP/ERc+XrTTDrhxhi9rBIj4qYKg
         jQqIiPMSGudU0xbc/8xyxGtCrCfNqZjLa7Jf2iVuxGs27tsnfFcH9RZq00A4Kkpm85P+
         nqn1rQnACnMurA89newiVOdC6RJH2z7xdzXMhtaYI1TIC9IB4bPAJ7iZxFhOXAOySxXV
         D2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=UQVs/vk3TXmyqHO0m20AymMZtMAnKjYQ1g4TBF6/kA4=;
        b=7PxaKv2GAKu2Xvd8PKDi14xu26AT/XGwj3N3Felo/n+vHTtJ1SdrpA3KRboGs9bpgr
         dcoVXKHiXQWcnrz3eQCRv7XjG6aT2KdfGQ5M0qijPNQmxKE6zA/2DpiXqDn/jY0I8i8A
         YTeAezmKPSzIRa/9KBM0YQpTmNXS3WbYCDD90ZBANQmH2i0C4XWPu37GQggD8aikqHQ5
         2NRkyau7qCg5nhsNJuI7PU3IQg1QoeV/Jp04XHhbV68xA3JWod+vYWPdn/BC6esABSCa
         k8tKAa2RBwzgf+Pc5FfwBGfk9qoMHeKRMzjsALHGtwU3D9EJctwBm+f1+qHaWdj8xvaO
         /Nbg==
X-Gm-Message-State: AJIora8Jj0ToK3+cmr6wfrAudgqqiguxldw6udw13/jMKxfVivEx49zR
        3ban5GSeyvNnZoq10qxItKAbo200A3oOVw==
X-Google-Smtp-Source: AGRyM1sjvx1wOPMp+bijYxCAGUlWcQdG9iZUFcyc5CG2oi0K7eSi07C87KiYcu9D21TT+wr8/GSRfA==
X-Received: by 2002:a17:906:5305:b0:712:388c:2bf5 with SMTP id h5-20020a170906530500b00712388c2bf5mr2513089ejo.559.1656497556306;
        Wed, 29 Jun 2022 03:12:36 -0700 (PDT)
Received: from [192.168.0.183] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090613c500b00722fb3c99bcsm7531482ejc.203.2022.06.29.03.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 03:12:35 -0700 (PDT)
Message-ID: <f2b16788-32bd-a487-4087-66d876247fdb@linaro.org>
Date:   Wed, 29 Jun 2022 12:12:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v12 2/3] dt-bindings: usb: Add analogix anx7411 PD binding
Content-Language: en-US
To:     Xin Ji <xji@analogixsemi.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     bliang@analogixsemi.com, qwen@analogixsemi.com,
        jli@analogixsemi.com, Rob Herring <robh@kernel.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220628044843.2257885-1-xji@analogixsemi.com>
 <20220628044843.2257885-2-xji@analogixsemi.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220628044843.2257885-2-xji@analogixsemi.com>
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

On 28/06/2022 06:48, Xin Ji wrote:
> Add analogix PD chip anx7411 device binding
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Xin Ji <xji@analogixsemi.com>
> ---
>  .../bindings/usb/analogix,anx7411.yaml        | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> new file mode 100644
> index 000000000000..c5c6d5a9dc17
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/analogix,anx7411.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/analogix,anx7411.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop the quotes from both places.

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
> +
> +    allOf:
> +      - $ref: ../connector/usb-connector.yaml

additionalProperties: false
(on the level of allOf)

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
> +    i2c1 {

"i2c"

> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        typec: anx7411@2C {

generic node name, so maybe usb-typec?

If fixed, keep Rob's Rb comment.

> +            compatible = "analogix,anx7411";
> +            reg = <0x2C>;
> +            interrupts = <8 IRQ_TYPE_EDGE_FALLING>;
> +            interrupt-parent = <&gpio0>;
> +
> +            typec_con: connector {
> +                compatible = "usb-c-connector";
> +                power-role = "dual";
> +                data-role = "dual";
> +                try-power-role = "source";
> +
> +                port {

I think usb-c-connector requires "ports" node, doesn't it?

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
