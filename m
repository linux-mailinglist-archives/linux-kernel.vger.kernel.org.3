Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF6257E5C8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 19:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235740AbiGVRoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 13:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiGVRoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 13:44:04 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7FE82114
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:44:03 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id a23so6378630lfm.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 10:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=77xuwLvbLWnCuxWXuFNg97x/Q/UoNBE8YKOa7koKCQc=;
        b=Rh6kq8XK5OkVXzo21OvcDTRrF04BNHykHigDPuBygYCTLIgdux2kVy94r293wxck8s
         4qs4BUupnK1RleRnhoOOwtXEc5b3X6tbm2JNodnr9aw8Q7GRvXwkOBHmiBnJ4Nrc5WBx
         Pt3YTbMVNR8Z/W/bIzL7KqqcB396MEw/JG8bB6SSqqx1YlH/iLHoyFR466V+lYWc4dL7
         mKDDmDmSnKmsZh6ODpJ0dJZwO3aB/hcWPI4RmAMAC0ke212JxsfXUJWRAac4K4oWBEr8
         jKs+6nxq5dJvGrHXjrG1bYLIxnQG8KYQVdRGDdopuJVLU1o8lcmCoMAmKYh9DqEJWOFf
         6rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=77xuwLvbLWnCuxWXuFNg97x/Q/UoNBE8YKOa7koKCQc=;
        b=5p+1PG67b50TZfREfbC34KgtN3LWHIBymVhgKD2jxpM/noflj8GTGeZt7PakjvQbE7
         l+zFd4ME4JQEi5J/JvhrgPixSG3j900mdXTsWgh/YW45SFw1aG5xXfntrM1NOrN4rn9P
         ddy+GsV788pJerGqeSfDEsTaMs9kXr5/N2sV9+Hi3stlTaJeBSmcxhBHqjxUGnB+K3K0
         r7w+/rhg233csxoaz7/s/ftp0fqkeIfvVRv67mHYR7Ri117kmRkmoH8WKbxe86Xh8vo5
         txQzfTZZ4AgZEgxiTXOKEZ889D8/ckvKqExGgEYcx9Hz6QRBlyod67AG1+yDRJqJrXuc
         wzpA==
X-Gm-Message-State: AJIora+LRbGv9Z/EOtoGTZXHmS7AZmQyXoGCYpMqCT6RPtyxg/dPYWim
        Q0+2TEBpKcaIxDCbkK32PhMxjA==
X-Google-Smtp-Source: AGRyM1u8Z9ofcrLGXlXYmrrX+HN6KSpLHpX2BjExY1LCBBGohOyx5gD2LPLjkWkDgVGABm1aD/B7iw==
X-Received: by 2002:a05:6512:1381:b0:489:cd0b:3a03 with SMTP id p1-20020a056512138100b00489cd0b3a03mr389336lfa.583.1658511841445;
        Fri, 22 Jul 2022 10:44:01 -0700 (PDT)
Received: from [192.168.10.173] (93.81-167-86.customer.lyse.net. [81.167.86.93])
        by smtp.gmail.com with ESMTPSA id bd21-20020a05651c169500b0025d6930d014sm1253726ljb.87.2022.07.22.10.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 10:44:00 -0700 (PDT)
Message-ID: <cd830f5c-1760-69e0-d239-3ce1f30daa43@linaro.org>
Date:   Fri, 22 Jul 2022 19:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/5] spi: dt-bindings: add documentation for
 hpe,gxp-spifi
Content-Language: en-US
To:     nick.hawkins@hpe.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, verdun@hpe.com,
        linux@armlinux.org.uk, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de, joel@jms.id.au
References: <20220722172335.33404-1-nick.hawkins@hpe.com>
 <20220722172335.33404-3-nick.hawkins@hpe.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220722172335.33404-3-nick.hawkins@hpe.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/07/2022 19:23, nick.hawkins@hpe.com wrote:
> From: Nick Hawkins <nick.hawkins@hpe.com>
> 
> Create documentation for the hpe,gxp-spifi binding to support access to
> the SPI parts
> 
> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> 
> ---
> 
> v2:
>  *Removed extra space around < > for reg
>  *Changed interrupt-parrent to interrupt-parent
> ---
>  .../bindings/spi/hpe,gxp-spifi.yaml           | 56 +++++++++++++++++++
>  1 file changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> new file mode 100644
> index 000000000000..346b494ef59b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/hpe,gxp-spifi.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/hpe,gxp-spifi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HPE GXP spi controller flash interface
> +
> +maintainers:
> +  - Nick Hawkins <nick.hawkins@hpe.com>
> +  - Jean-Marie Verdun <verdun@hpe.com>
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

Drop the quotes - not needed.

> +
> +properties:
> +  compatible:
> +    const: hpe,gxp-spifi
> +
> +  reg:
> +    items:
> +      - description: cfg registers
> +      - description: data registers
> +      - description: mapped memory
> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +
> +    spi@200 {
> +        compatible = "hpe,gxp-spifi";
> +        reg = <0x200 0x80>, <0xc000 0x100>, <0x38000000 0x800000>;
> +        interrupts = <20>;
> +        interrupt-parent = <&vic0>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        flash@0 {
> +                reg = <0>;

This has still wrong indentation.



Best regards,
Krzysztof
