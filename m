Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E590A580486
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 21:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiGYThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiGYThL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 15:37:11 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DA205C3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:37:10 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id y11so19453666lfs.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Zisrg+my4924xsZCS3yBVYkINpOxJI4SuAiL7f/OBT4=;
        b=UVU+B8Q4PmWuitOO6TvzYHyIb31NEYhP8UgbcCI0d2EqoxgCfV2IRZvMx/z264gI3W
         0vuTww2XeyEAuKf8Xt66OYeZVtpWWjs/vlDg4YocXVvTlnE/UdNsAgqfr/YZ9gBg8VNG
         WQ2LuOwnzcG7zll4eI01L1/4mQbKctV3aTSYRRqlJ0adEMto4rtz6P4BTNPMDMsDaUCZ
         Ixjagsf1JA9sK4LU15vC1TOAuI/TchEGQ+6t7F/wjU/vsJOtcj7EOG13C99VBwlbgW8o
         Jz2vQX1zgo2DyZ7eBUn7G+ghBPmbCq83J0VmNa+YzwghFhW4LmYdpcJp6rGku8TCRa5S
         VfTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Zisrg+my4924xsZCS3yBVYkINpOxJI4SuAiL7f/OBT4=;
        b=hOYG8zegRhJlUAoG1v8oD0oql3ZN34SVTHwbSgGLoRzPzbioDjBgqUlZznAxO0aI0p
         onIqhUc4iWvM7tfyPJ0HHLhlamBUTM3NlXIkQNJ+2mEuVhFUHuay16tm9xteV/uZw3/Q
         WKL9gounM1vf+e9s+i5hveniKgZ49jfjn4okr2oa5ZiIz9EX31z+6HkZCEmAp0o8HnOO
         b/MBDVAPjvunSqfjGqpstosyL5COaippNbgxkOmGAXz/f15BY5u3s1/wtQ/feXQJ4oVY
         jiTyoe4UJMkHWZWEnew6Flwq7BYrCE/ZFQXo6zjGorXW3jPg1vu/76z/cXr3EuYU+PDj
         9vXg==
X-Gm-Message-State: AJIora9c6vY1hMrLG2HY2FyCja6DmLy7J3/j59xe4geFNPdPj9JHdOTb
        Ejci9puecaC5K7cSU92z1KfMxw==
X-Google-Smtp-Source: AGRyM1tSyuOF/ktWhT5phRnEeq9jwZcJbhK+eyafyKSoZs0pNsmXivvCVGASi4KMWU5ocdrIeS7vaQ==
X-Received: by 2002:a19:4352:0:b0:48a:7b6b:4eec with SMTP id m18-20020a194352000000b0048a7b6b4eecmr4814739lfj.301.1658777828357;
        Mon, 25 Jul 2022 12:37:08 -0700 (PDT)
Received: from [192.168.3.197] (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id w14-20020a197b0e000000b00489545df9f3sm1167084lfc.148.2022.07.25.12.37.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Jul 2022 12:37:07 -0700 (PDT)
Message-ID: <a7d0f6c7-1943-8bef-71ff-736455609cde@linaro.org>
Date:   Mon, 25 Jul 2022 21:37:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [net-next v2 3/3] dt-bindings: net: adin1110: Add docs
Content-Language: en-US
To:     alexandru.tachici@analog.com, netdev@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        gerhard@engleder-embedded.com, geert+renesas@glider.be,
        joel@jms.id.au, stefan.wahren@i2se.com, wellslutw@gmail.com,
        geert@linux-m68k.org, robh+dt@kernel.org,
        d.michailidis@fungible.com, stephen@networkplumber.org,
        l.stelmach@samsung.com, linux-kernel@vger.kernel.org
References: <20220725165312.59471-1-alexandru.tachici@analog.com>
 <20220725165312.59471-4-alexandru.tachici@analog.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220725165312.59471-4-alexandru.tachici@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2022 18:53, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add bindings for the ADIN1110/2111 MAC-PHY/SWITCH.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---

Thank you for your patch. There is something to discuss/improve.

>  .../devicetree/bindings/net/adi,adin1110.yaml | 81 +++++++++++++++++++
>  1 file changed, 81 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/adi,adin1110.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> new file mode 100644
> index 000000000000..cc83f08c0a55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
> @@ -0,0 +1,81 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/adi,adin1110.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ADI ADIN1110 MAC-PHY
> +
> +maintainers:
> +  - Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +description: |
> +  The ADIN1110 is a low power single port 10BASE-T1L MAC-
> +  PHY designed for industrial Ethernet applications. It integrates
> +  an Ethernet PHY core with a MAC and all the associated analog
> +  circuitry, input and output clock buffering.
> +
> +  The ADIN2111 is a low power, low complexity, two-Ethernet ports
> +  switch with integrated 10BASE-T1L PHYs and one serial peripheral
> +  interface (SPI) port. The device is designed for industrial Ethernet
> +  applications using low power constrained nodes and is compliant
> +  with the IEEE 802.3cg-2019 Ethernet standard for long reach
> +  10 Mbps single pair Ethernet (SPE).
> +
> +  The device has a 4-wire SPI interface for communication
> +  between the MAC and host processor.
> +
> +allOf:
> +  - $ref: ethernet-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,adin1110
> +      - adi,adin2111
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
> +
> +  adi,spi-crc:
> +    description: |
> +      Enable CRC8 checks on SPI read/writes.
> +    type: boolean
> +
> +  interrupts:
> +    maxItems: 1
> +

You had phy nodes here, but they were not replaced with the phy-handle.
No ethernet-ports or mdios with phy?


Best regards,
Krzysztof
