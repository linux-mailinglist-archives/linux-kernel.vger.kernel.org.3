Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340FA4E621C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 12:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349655AbiCXLIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 07:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbiCXLIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 07:08:49 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB5E9A9AC;
        Thu, 24 Mar 2022 04:07:17 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id r23so5232245edb.0;
        Thu, 24 Mar 2022 04:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WGF14RUnJyiVRTAJrOTqMWNPjX762pP3YtrFh/OYz+k=;
        b=T/EuArlh575CUTy5a8MOXOKbX9lPwY0WFQkLavZw11EjEWKoGuMPo8e/AOaim6gK8S
         MS1snjCCdGnfw9YhYBxlt1TKxWmUnEWFt0WO9G/552m8dV0789EcwAHuqwT3hAyxq1Q7
         oiM2hHehMZyerpnJH2GU5vHhglrGvkPEl2ENpF/c903wzxwW9qd3TfJd7p5oftkhBIKn
         CKe2o9++F82v260KMUW2LeKh4m9fxFjQ4cFDq7zJXkdEPVZklHFmUEW7/+GU1mktmyTl
         sfSVLSRa7idzJHwe0+HgNwoB92MV3CbvTAAlFYiZunwkKE7vJG/T7pSC1I1XLqHWm2z6
         0Yrg==
X-Gm-Message-State: AOAM532kJoPRctRGZ2CxPAkSWvZZTz9juRXGLeCXFqXUBzv0j3Qi1p10
        MuK5p3tHN5x7EPggynSDlGJREPYHpNG/kA==
X-Google-Smtp-Source: ABdhPJx5n6ChCN/EcL7ayTXSjIi+oK6eFu5g8no4Q38FEkc6GZn8+qIUWLdNCXVCm90iRk2ocKkiaQ==
X-Received: by 2002:a05:6402:506:b0:419:46b2:2433 with SMTP id m6-20020a056402050600b0041946b22433mr5964140edv.21.1648120035851;
        Thu, 24 Mar 2022 04:07:15 -0700 (PDT)
Received: from [192.168.0.156] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.googlemail.com with ESMTPSA id r16-20020a056402019000b00418ed60c332sm1270063edv.65.2022.03.24.04.07.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 04:07:14 -0700 (PDT)
Message-ID: <93fe6a41-3b59-2fbc-6f95-833f337815ee@kernel.org>
Date:   Thu, 24 Mar 2022 12:07:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Content-Language: en-US
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20220324073425.18607-1-a-govindraju@ti.com>
 <20220324073425.18607-2-a-govindraju@ti.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220324073425.18607-2-a-govindraju@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/03/2022 08:34, Aswath Govindraju wrote:
> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
> controller.
> 
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
> 
> Changes since v1:
> - made correction in grammer of clocks property description
>   and added maxItems in the interrupts property based on comments
>   received from Roger
> - corrected the title, fixed the description of
>   ti,syscon-phy-pll-refclk, added pattern properties and child node
>   in the example based on the comments from Krzysztof.
> 
>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++++++++++++++++
>  1 file changed, 117 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> 
> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> new file mode 100644
> index 000000000000..452bfdc6fb09
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> @@ -0,0 +1,117 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
> +
> +maintainers:
> +  - Aswath Govindraju <a-govindraju@ti.com>
> +
> +properties:
> +  compatible:
> +    const: ti,am62-usb
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +  power-domains:
> +    description:
> +      PM domain provider node and an args specifier containing
> +      the USB ISO device id value. See,
> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> +    maxItems: 1
> +
> +  clocks:
> +    description: Clock phandle to usb2_refclk
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref
> +
> +  id-gpio:
> +    description:
> +      GPIO to be used as ID pin
> +    maxItems: 1

I have doubts about this. If you USB controller handles the ID pin, then
probably this should be moved to usb-connector.yaml. I did not see
id-gpio in any other USB controller blocks.


Best regards,
Krzysztof
