Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1155128B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 10:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231197AbiFTIVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 04:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238965AbiFTIVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 04:21:11 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C16612090
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:21:10 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id u12so19531391eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=H2+1Br+WPxKlr7rhA9GfS8O/m05TRKE7h+ScGuyJAog=;
        b=JC5OvhqSI3YDLB4ulNcwLiuwrq3174cHPyMi4JeV8uCx84M4SI/6pAzWSwwGIAmo9i
         p6t9Ivqkdqui3xsiy3Ee0xUhCcJ6w6+jOOIte/Ii6tUtK/BAsuBJ911XGEpGvt1aqiYK
         QTB7y+CxG1pWhpmx+BPbgHhnHz3voafRZyRc6YsvqsKPdcyWzXQRLQbkHOigs0ZlkeFH
         UL50DeYMUcOj2rjwGCiX7h9nrnJgw2WRLPQIjCZFjqUqjMVmYlDyNEZWlZCUo4E9gHJJ
         IdoUff+QZ89fSbkrQWHgF2KZiJcF2i2h9l+lVFA3pPJTh+u+icUmTajeydSWfkGyDcCv
         +fHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=H2+1Br+WPxKlr7rhA9GfS8O/m05TRKE7h+ScGuyJAog=;
        b=KlUROL95Nj0ygobHgUkYD3uM5jbiLr+BALZgHhElEB47bS0fs2QhSrnTbhVINJqapt
         802QseIv50aCWB+/LAoy3t2P8VMYuLI7Rn1zBDzaQIPs43aZ9iTwVVh49doH69vfU79S
         OQ/kuOtJCbrU/t3iZG6XWTasyh1ReyI5JAF6dns2QIeoxyfAcfY9LTwtRKvFK5x6LuuR
         roW1qnp/sf7N/97OR1iL22bgMhUAmpczKTq69B/gU6nK2v26TQE2i4GzxroM1pr+naQd
         CBEydDQEeibdZCAd4nqeIa5znkhfXLOkXdzOhgi2njcHrkjPG7oL+087B240b33nz7NK
         7dVQ==
X-Gm-Message-State: AJIora9FaSU1d1ApPABV9etyvkySMRdOtDkXcDVGxT1oDOClPhjVtWmc
        vHbkAsuezLkJ2CwaV/r0vIrD7w==
X-Google-Smtp-Source: AGRyM1vUUFN5yFrpsDyCCDudDRBU4X7vKD37ZJhGh+DJw/CUxCKNVKu2v2/I8EJ7euaQXqIHibedZQ==
X-Received: by 2002:a17:906:72de:b0:711:f8c8:ba00 with SMTP id m30-20020a17090672de00b00711f8c8ba00mr20299153ejl.586.1655713268738;
        Mon, 20 Jun 2022 01:21:08 -0700 (PDT)
Received: from [192.168.0.207] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id h20-20020a1709070b1400b006fe7d269db8sm5469823ejl.104.2022.06.20.01.21.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 01:21:08 -0700 (PDT)
Message-ID: <040f149b-c441-c778-6d4f-f3b2b2afaf4e@linaro.org>
Date:   Mon, 20 Jun 2022 10:21:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 05/18] dt-binding: clk: npcm845: Add binding for
 Nuvoton NPCM8XX Clock
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, wim@linux-watchdog.org, linux@roeck-us.net,
        catalin.marinas@arm.com, will@kernel.org, arnd@arndb.de,
        olof@lixom.net, jirislaby@kernel.org, shawnguo@kernel.org,
        bjorn.andersson@linaro.org, geert+renesas@glider.be,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, nobuhiro1.iwamatsu@toshiba.co.jp,
        robert.hancock@calian.com, j.neuschaefer@gmx.net, lkundrak@v3.sk
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20220619151225.209029-1-tmaimon77@gmail.com>
 <20220619151225.209029-6-tmaimon77@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220619151225.209029-6-tmaimon77@gmail.com>
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

On 19/06/2022 17:12, Tomer Maimon wrote:
> Add binding for the Arbel BMC NPCM8XX Clock controller.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
> ---
>  .../bindings/clock/nuvoton,npcm845-clk.yaml   | 49 +++++++++++++++++++
>  .../dt-bindings/clock/nuvoton,npcm8xx-clock.h | 49 +++++++++++++++++++
>  2 files changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
>  create mode 100644 include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> new file mode 100644
> index 000000000000..3d4fddc090ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nuvoton,npcm845-clk.yaml
> @@ -0,0 +1,49 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/nuvoton,npcm845-clk.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton NPCM8XX Clock Controller Binding
> +
> +maintainers:
> +  - Tomer Maimon <tmaimon77@gmail.com>
> +
> +description: |
> +  Nuvoton Arbel BMC NPCM8XX contains an integrated clock controller, which
> +  generates and supplies clocks to all modules within the BMC.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - nuvoton,npcm845-clk
> +
> +  reg:
> +    maxItems: 1
> +
> +  '#clock-cells':
> +    const: 1
> +    description:
> +      See include/dt-bindings/clock/nuvoton,npcm8xx-clock.h for the full
> +      list of NPCM8XX clock IDs.
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#clock-cells"

Use same quotes through your patchset - either " or '. Do not mix.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    ahb {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +
> +        clock-controller@f0801000 {
> +            compatible = "nuvoton,npcm845-clk";
> +            reg = <0x0 0xf0801000 0x0 0x1000>;
> +            #clock-cells = <1>;
> +        };
> +    };
> +...
> diff --git a/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> new file mode 100644
> index 000000000000..e5cce08b00e1
> --- /dev/null
> +++ b/include/dt-bindings/clock/nuvoton,npcm8xx-clock.h
> @@ -0,0 +1,49 @@
> +/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */

My comment about filename is still waiting to be resolved. I asked for
same filename as bindings in v1.

https://lore.kernel.org/all/CAP6Zq1gXEqqquKzxTHoxYnvh2LCGt-ES+k=aX61FKyHW5WB62w@mail.gmail.com/

I am still going to NAK it if it is not implemented.

Best regards,
Krzysztof
