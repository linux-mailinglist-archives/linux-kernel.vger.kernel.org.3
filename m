Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBE951E8A9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 18:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386387AbiEGQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240158AbiEGQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 12:56:19 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104311E3E6
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 09:52:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id gh6so19670706ejb.0
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 09:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=sCvvHWmzhx8NWrjAiZK9ud0UYbDFJ128HXmTkYuDUIg=;
        b=N0Qpw2sN+/9j7kShmen4Bm5RUlF/vaSuJSXnGywcw6t2glN/vdaUHHRLsdW9wP5iD9
         AzoEt0NEC0Y82+DDjqmjaPXB8KqWuuW5jSjzIEkeH134dkPUWLcs36o5FjoR7ZyOlgbj
         +W/ef4D4JJ4YgOboUeuJnYRcaIdNfHQ+z/sNQD4vxYfVr8+L/uI664AS60qSBtWVNWV5
         W5K49zjQPI8jkcASRCzjZR4/fOcjEFbC6mxrtF5MiqVXFz3S78XKN9OKN+mXQlbk52l7
         n+DFZiPyBfnNz1Ed+fGZ4/+IZFg7dQfzmENbP3vP4f/PuWwksTuORbXa+gFhjbM2UPmn
         2l4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=sCvvHWmzhx8NWrjAiZK9ud0UYbDFJ128HXmTkYuDUIg=;
        b=cNfuIbCiAmBAhTyDdxVgXjAs74w9UgcUdrJOHeiSoXdX58pqHBg+RPW1D761yyjUNa
         l25UDIH2IO2ug/mw3yU/Z1VD/c8nUi/0mq96IZFOLC7EL1Zcxhz6XRkGc2FguZtpimq2
         YTkE69oRrzUbz4CCdfUSvJ0zyoPplohdq1hDc30H/oKO/kEstg29j4FNQ3g3kftnFq1S
         ekZL+kaav+BzlM6V5WpYJLQNWv945vLBFscHlykypHJNrf/BViZdEAjBUMrcj4N1XQL+
         hGtrPZS7+01h1P9WwF8KFsdtptyjU1UY9siHc9Tj0AU29Dny6PHjw/1imWYeKaQ9ZLOE
         2nkw==
X-Gm-Message-State: AOAM533hT2eUPkQ7/SmSWGkQJUEIbC7oBJtyk40pM4BLrIh/WTOJPwkR
        0I83tu5mPrf/3Y/N1zOA/CabEg==
X-Google-Smtp-Source: ABdhPJyLwVc4p6GHtiVwpYvhf72EIYHssdfaGwdyJ8wU7mo4ZxDarLy7Od3kdT7TnhEnxoEZhwaWcg==
X-Received: by 2002:a17:907:94ca:b0:6da:e637:fa42 with SMTP id dn10-20020a17090794ca00b006dae637fa42mr7981828ejc.347.1651942349579;
        Sat, 07 May 2022 09:52:29 -0700 (PDT)
Received: from [192.168.0.233] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id i3-20020a1709061cc300b006f3ef214dfcsm3215191ejh.98.2022.05.07.09.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 09:52:29 -0700 (PDT)
Message-ID: <64376af4-a4b0-9411-33c6-54c3f57e1fa2@linaro.org>
Date:   Sat, 7 May 2022 18:52:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 1/2] dt-bindings: usb: Add documentation for sc27xx typec
 controller
Content-Language: en-US
To:     Cixi Geng <gengcixi@gmail.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        orsonzhai@gmail.com, baolin.wang7@gmail.com, zhang.lyra@gmail.com,
        heikki.krogerus@linux.intel.com
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220507092953.2273879-1-gengcixi@gmail.com>
 <20220507092953.2273879-2-gengcixi@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220507092953.2273879-2-gengcixi@gmail.com>
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

On 07/05/2022 11:29, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> The Spreadtrum PMIC SC27xx integrated typec port controller.
> add the bindings to describe sc27xx typec controller.
> 
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/usb/sprd,sc27xx-typec.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml b/Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml
> new file mode 100644
> index 000000000000..6e49198c88da
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/sprd,sc27xx-typec.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright 2022 Unisoc Inc.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/sprd,sc27xx-typec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SC27XX Type-C port controller
> +
> +description:
> +  The UNISOC, also know as Spreadtrum, SC27XX is a USB Type-C port controller which
> +  supports role and plug orientation detection using the CC pins. It is
> +  compatible with the USB Type-C Cable and Connector Specification v1.2.
> +
> +maintainers:
> +  - Cixi Geng <gengcixi@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sprd,sc2730-typec
> +      - sprd,sc2721-typec

Order alphabetically, please.

> +      - sprd,ump96xx-typec
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  sprd,mode:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The Type-C port mode type

This does not look appropriate. You need to use usb-connector.yaml and
its power-role property. Check existing examples.

Even without usb-connector.yaml schema, you should not hard-code some
magical 32-bit unknown numbers without any documented meaning (bindings)...

> +
> +  nvmem-cells:
> +    maxItems: 2
> +    description:
> +      Reference to an nvmem node for the calibration data.
> +
> +  nvmem-cell-names:
> +    items:
> +      - const: typec_cc1_cal
> +      - const: typec_cc2_cal
> +
> +required:
> +  - compatible
> +  - reg
> +  - sprd,mode
> +  - nvmem-cells
> +  - nvmem-cell-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pmic {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        pmic_typec: typec@380 {
> +                compatible = "sprd,sc2730-typec";
> +                interrupt-parent = <&sc2730_pmic>;
> +                interrupts = <8>;
> +                reg = <0x380>;

Put reg just after compatible.

> +                sprd,mode = <2>;
> +                nvmem-cells = <&typec_cc1_cal>, <&typec_cc2_cal>;
> +                nvmem-cell-names = "typec_cc1_cal", "typec_cc2_cal";
> +                status = "okay";

Examples do not have status. No point.

> +        };
> +    };
> +...


Best regards,
Krzysztof
