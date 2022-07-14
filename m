Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC25F574DAD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 14:34:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbiGNMeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 08:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239313AbiGNMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 08:33:58 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9EF101D3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:33:56 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id z25so2587830lfr.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 05:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=znBmTmWbrra/OYjTkxnIPxribEEA4AB0oOiGcRO1fM4=;
        b=am2BWu1YVCHhUdeG+SgRP5hOGK4IVx1sW+EN3dHRC5r9mK69YjS+uxvRAc+hmP2jR8
         GjraOZ6I4dIffe61z32cemcVORC0jEs9EiDERpA8gMhNNhV+byMO8sX9Fdii2iRcesbM
         ZtZc53neKhKK/UkXPL3Wz0lSee0uL33e9a4O2bCZPNQCOQPzviu9ces26f1418c9p0H6
         N9xuboR+q1nQf52SFwdxBpaFe8oxDYnd9qF0IRaBCLjeo3SW83aFgVUPJ0VLi6Rz+6ds
         QCChPKu2a+OZWdfSNxz0buNSSrmvX54Cdk/6UapcwXbdDTAdAgIHc1xK+w4JSl3Fh8PL
         KRGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=znBmTmWbrra/OYjTkxnIPxribEEA4AB0oOiGcRO1fM4=;
        b=W3TGXSfxAGRO4PzUnTOvrMhDwT9aY0BazHNZ//KnKn/bjeZ0dGKLNo1L2SWmzTOYka
         DFNSvkQ5Ax18y+ok4Icds+D7AAzbHF1l2YTr7vajwkewK3KfZLqNaSDGWZ3+fUOfz/lQ
         w8tqIp60O5eNq/2BxdM3jy5/ZZm3QEJZyILgwMsXqbHPVd+xxkLrJ5WKB++7lyours/c
         iaI1vv4+oMEC6dZuSkFycW3MXBO5TWCEqGx0exR+7G7XHfhD375GVyGrq0bU/SLkdeoE
         gp29PUMz6FJqERMPAQxT93I+6XKOvTYXgZ+AswT807aa5bI0nbaxmoODYIJT3pIiyII+
         wOjA==
X-Gm-Message-State: AJIora/hsm70BY/jsWVYulDnVibVyJeN0NVtG8Bcrzcixdv9cgZIhT9b
        NWOdgwp4WIC9SVagjJYaML/llg==
X-Google-Smtp-Source: AGRyM1v3jmzJ7ayv07Ch9djYz/ySqe3koVDpxqaTr3phOrx5yXav0xsji5TaHJDbSL8JsyIGcdO0dw==
X-Received: by 2002:ac2:5509:0:b0:489:e7f9:75b9 with SMTP id j9-20020ac25509000000b00489e7f975b9mr4855400lfk.507.1657802034487;
        Thu, 14 Jul 2022 05:33:54 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id q27-20020a05651232bb00b00489de5012d4sm335536lfe.301.2022.07.14.05.33.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:33:53 -0700 (PDT)
Message-ID: <c237958c-c274-73b4-f844-b2e29d905447@linaro.org>
Date:   Thu, 14 Jul 2022 14:33:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] dt-bindings: mailbox : marvell,mbox: Add bindings
Content-Language: en-US
To:     Wojciech Bartczak <wbartczak@marvell.com>,
        linux-kernel@vger.kernel.org
Cc:     wbartczak@gmail.com, Piyush Malgujar <pmalgujar@marvell.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
References: <20220714121215.22931-1-wbartczak@marvell.com>
 <20220714121215.22931-2-wbartczak@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714121215.22931-2-wbartczak@marvell.com>
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

On 14/07/2022 14:12, Wojciech Bartczak wrote:
> This patch adds device tree binding for Marvell Message Handling Unit
> (MHU) controller.
> 
> Signed-off-by: Wojciech Bartczak <wbartczak@marvell.com>
> ---
>  .../mailbox/marvell,mbox-mailbox.yaml         | 112 ++++++++++++++++++
>  1 file changed, 112 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..d9a6e14dcb12da6c3a9db2dfafc075ccefa8711c
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mailbox/marvell,mbox-mailbox.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mailbox/marvell,mbox-mailbox.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Marvell Message Handling Unit
> +
> +maintainers:
> +  - Wojciech Bartczak <wbartczak@marvell.com>
> +  - Piyush Malgujar <pmalgujar@marvell.com>
> +
> +description:
> +  The Marvell's Message Handling Unit is a mailbox controller
> +  with a single channel used to communicate with System Control Processor.
> +  Driver supports series of cn9x and cn10x SoC.


Driver is not related to bindings, remove implementation details.

> +  Sole purpose of the link is to exchange SCMI related data with SCP.
> +  The link has hardwired configuration, it uses simple notification scheme
> +  over shared memory block to push data back and forth.
> +  Interrupts used by mailbox may be configured in two ways,
> +  as SPI interrupts, then driver uses platform device forntend.
> +  Other way is to use PCI bus frontend with LPI interrupts.
> +
> +properties:
> +  compatible:
> +    items:

No "items", you have just one here, but see comment below.

> +      - const: marvell,mbox

Need SoC or model specific compatible. Generic fallbacks are accepted if
always prepended with specific compatible.

Are you sure that all, absolutely all, including ones made in 20 years,
of Marvell mboxes will be 100% compatible with "marvell,mbox"?

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    items:
> +      - description: interrupt type
> +        const: 0
> +      - description: interrupt number
> +      - description: interrupt trigger type
> +        const: 1

This looks wrong. You just specified here three interrupts, which are
fixed... It does not make really sense.


> +
> +  '#mbox-cells':
> +    description: Index of the channel

Skip description, obvious.

> +    const: 1
> +
> +  shmem:
> +    description:
> +      List of phandle pointing to the shared memory area between SCP and AP.
> +      The area is used to exchange additional information not covered by SCMI.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - '#mbox-cells'
> +  - shmem
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    soc@0 {
> +      reg = <0 0>;
> +       #address-cells = <2>;

Messed up indentation. While fixing it, convert to 4 space for DTS
example, as recommended.

> +       #size-cells = <2>;
> +
> +      sram@36,0 {
> +        compatible = "cpc-shmem";
> +        reg = <0x86d0 0xdd400 0 0x200>;
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        ranges = <0 0x0 0x86d0 0xdd400 0x200>;
> +
> +        scp_to_cpu0: scp-shmame@0 {
> +          compatible = "cpc-shmem";
> +          reg = <0x0 0x0 0x200>;
> +        };
> +      };

Isn't smem a generic property and generic use case? If so, then drop
this part, unless it brings anything specific to your mailbox example.

> +
> +      mailbox0: mailbox@28,0 {
> +        #mbox-cells = <1>;

First compatible, then reg then the rest of properties.

> +        compatible = "marvell,mbox";
> +        reg = <0xe000 0 0 0>;
> +        shmem = <&scp_to_cpu0>;
> +      };
> +    };
> +  - |
> +    soc@1 {
> +      reg = <1 0>;
> +       #address-cells = <2>;
> +       #size-cells = <2>;
> +
> +      sram@36,0 {
> +        compatible = "cpc-shmem";
> +        reg = <0x86d0 0xdd400 0 0x200>;
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        ranges = <0 0x0 0x86d0 0xdd400 0x200>;
> +
> +        scp_to_cpu1: scp-shmame@1 {
> +          compatible = "cpc-shmem";
> +          reg = <0x0 0x0 0x200>;
> +        };
> +      };
> +
> +      mailbox1: mailbox@82c000000000 {
> +        #mbox-cells = <1>;
> +        compatible = "marvell,mbox";
> +        reg = <0x82c0 0x00000000 0x0 0x100000>;
> +        interrupt-parent = <&gic0>;
> +        interrupts = <0 59 1>;

These look like GIC and interrupt flags, so definitely not three
interrupts. Use proper defines.


> +        shmem = <&scp_to_cpu1>;

This is the same example as before, drop it or merge with previous.

> +      };
> +    };


Best regards,
Krzysztof
