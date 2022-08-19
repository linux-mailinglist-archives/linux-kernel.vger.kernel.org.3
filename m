Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF26C599584
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbiHSGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235053AbiHSGwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:52:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF255DB7E1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:52:53 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x19so4948001lfq.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Y5uL27unbAtFFDXV9O3CJy9VefjqDxgpHdg47Nmbfy4=;
        b=JgBlkJi/LL6K3LjSxJ5NaoyL5BIk+UWEvHJlvFGRUd5P2Tqm3jfQgYVHdJOg0xryIB
         GJm4B+LbzlK2LJwNZXcVQbN06lXwPH55d8MdV4WmkmCxk7rGBdS13j4k9kTuOuwcRJzw
         /3k/WsNbtvkDOO6weB25lLpfxynHio9ObvCfNkmbAXBgI7Mf51St0nnAAnwxkav6GUR5
         JT6WzB2yMleHZvQyVdhl2jTjv6w1epULwVXWZbtd6QM9mLaIFRaF3Ky3Ycpkxtlb9oDc
         DS3Gob/+/kkYZE/fq2qMm76ysTW4vHhPUol70fSU5yRvJpUgYubmQ7h1SHeFM06cIZJW
         bGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Y5uL27unbAtFFDXV9O3CJy9VefjqDxgpHdg47Nmbfy4=;
        b=3RBCyWf+UXs+KE07OBM6hyNZnRvr04p6ZLGezF2HI1iqtjBNiGWTqed6DnUaGMssmb
         egY7nb26i9F0GjdrVdz3R7Pe7Egm1meopEAHjjVEZPXRxqOalRg2Y7czv/+Ma5uvxhev
         36gbZUDiiIhxC1zlT245MuwRuw0c45NRtJAo4K7vhO7MD163C+tkK23xF+YwXV5olxgg
         Z5wnvaS5Fh7s6MwAumxfNgztsleuxgLCbg/R6W5U5X/soRNS0aMbuWFDwcsPnYNGVF68
         2pNNQo0TFcjlLl4KHWn22tcVjkrQmm1D/cMuIffiCyLYP9q4Ug1+6EGhg2Ma6/whg9qH
         GxmA==
X-Gm-Message-State: ACgBeo2TJzuGJirdvIx6Nv84MTnX1Qo/znng8KzhOh8cV+Xet9d6H9M+
        IAyhDUxxEU7MGbSjXtThquRkranzcvfMJsCb
X-Google-Smtp-Source: AA6agR4mH2mFYS7o54N5XSepotC6RrBaYjnakDvALchOSSqNl8yUhTN1K7TsMONWgIW9k7PxrTx/bQ==
X-Received: by 2002:a05:6512:4009:b0:491:bdd9:eab1 with SMTP id br9-20020a056512400900b00491bdd9eab1mr2177454lfb.372.1660891972252;
        Thu, 18 Aug 2022 23:52:52 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id a19-20020ac25e73000000b0048aa64cfef6sm172941lfr.152.2022.08.18.23.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 23:52:51 -0700 (PDT)
Message-ID: <550e652e-4541-c1e6-33a7-d5555f0cb266@linaro.org>
Date:   Fri, 19 Aug 2022 09:52:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/2] dt-bindings: lan966x-otpc: document Lan966X OTPC
Content-Language: en-US
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     srinivas.kandagatla@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
References: <20220818164405.1953698-1-horatiu.vultur@microchip.com>
 <20220818164405.1953698-2-horatiu.vultur@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220818164405.1953698-2-horatiu.vultur@microchip.com>
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

On 18/08/2022 19:44, Horatiu Vultur wrote:
> Document Lan966x OTP controller.
> 
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---
>  .../nvmem/microchip,lan966x-otpc.yaml         | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/nvmem/microchip,lan966x-otpc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/nvmem/microchip,lan966x-otpc.yaml b/Documentation/devicetree/bindings/nvmem/microchip,lan966x-otpc.yaml
> new file mode 100644
> index 000000000000..b19465971930
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/nvmem/microchip,lan966x-otpc.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/nvmem/microchip,lan966x-otpc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Microchip LAN966X OTP Controller (OTPC)
> +
> +maintainers:
> +  - Horatiu Vultur <horatiu.vultur@microchip.com>
> +
> +description: |
> +  OTP controller drives a NVMEM memory where system specific data
> +  (e.g. hardware configuration settings, chip identifiers) or
> +  user specific data could be stored.
> +
> +allOf:
> +  - $ref: "nvmem.yaml#"

No need for quotes.

> +
> +properties:
> +  compatible:
> +    items:
> +      - const: microchip,lan966x-otpc

No wildcards in compatible (which will also affect the file name as it
should match the compatible).

> +      - const: syscon

Is OTP controller also system controller register region? This is a bit
odd and looks like hack not to use nvmem subsystem.

> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    otpc: otp@e0021000 {
> +        compatible = "microchip,lan966x-otpc", "syscon";
> +        reg = <0xe0021000 0x300>;
> +    };
> +
> +...


Best regards,
Krzysztof
