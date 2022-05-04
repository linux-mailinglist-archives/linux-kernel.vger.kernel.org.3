Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A87BE51AF77
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 22:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378273AbiEDUm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 16:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiEDUmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 16:42:54 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AF8E5044E;
        Wed,  4 May 2022 13:39:17 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bv19so5092197ejb.6;
        Wed, 04 May 2022 13:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:references:from
         :in-reply-to:content-transfer-encoding;
        bh=Z2dVs5miBxmXIySFSNiW8pDoiQoVKCwO3mjzMYv3Zec=;
        b=Z3rTg8R+bJUJWRg/IqgFAIFPaCR7ziAiygfcpmxywJGxkFelZ6ryfoerwCQFWwBGuh
         BuoMD1Ye30enuoDCP5jTZ8WN8YiA0Ycp8uR+6PTS9wmOfcw3aTg0BgHGe5qL+KKtwWeL
         ONuIUbWjegJbQT2F1WLK8wmWWn2DG5HrkbArMLk8OE8AwVOV3tuRbATvzcfVfVO+dqt3
         6yiXjYYMhew0GLY/3t9n62r8VbRlMZIEPROXPtkZqubcZ86T6ih6pnpdRwON2VwKDLw7
         xobGgdk4Q7SjknBYnViPJ8XgdX+EJB+iagSiDtrtYl826TDbKWpC0od7jAOgfxE5ETcR
         4LiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:references:from:in-reply-to:content-transfer-encoding;
        bh=Z2dVs5miBxmXIySFSNiW8pDoiQoVKCwO3mjzMYv3Zec=;
        b=284Kce0OEEZELR1BksEPrUdkG/Zo/Z0tdOaNRwtLiChSwhgw8GZ7rHrHuxOeWGcNWj
         piPKnIIwfEnxA8p+249ZSYTP+sJj2wgVq05yHjdu5EpKoky3UQkkqMefZVyOmFj4niUP
         TWDqQ+fAZo4ta3jLc8EV8vTwu/tIrSfrnIo/pmxl+p1KN5TwmtcGW/SK5g2zIdL3e9WZ
         NsfVeVIj+b2FHplgmJgMxov6fZcG9xNYxHHnejFcFebrhfSUhsHWLUfDzO1gXWMECQYw
         JXsYPrfoWAu9cCXz1iREcfuFR6LmDNhoKzLNI7fqgrx7b1RgdseA1LVFtwCvKjePNhh0
         zf2Q==
X-Gm-Message-State: AOAM532/a/udTKrK3HocjAHZh1OTAbqebhqeZh34Zju85U4TA4lodWv2
        XW/8pLjAEfO75GxDxgeinmY=
X-Google-Smtp-Source: ABdhPJz/STYDRpY8rzebL057RwSwOIeG+CcAiMnBZMkP5z3+WXgOu4hNxD/b2WeJThieF8B9LgOK8A==
X-Received: by 2002:a17:906:9c82:b0:6df:c5f0:d456 with SMTP id fj2-20020a1709069c8200b006dfc5f0d456mr22153238ejc.287.1651696755643;
        Wed, 04 May 2022 13:39:15 -0700 (PDT)
Received: from [192.168.26.149] (ip-194-187-74-233.konfederacka.maverick.com.pl. [194.187.74.233])
        by smtp.googlemail.com with ESMTPSA id bf16-20020a0564021a5000b0042617ba63aesm9675481edb.56.2022.05.04.13.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 13:39:15 -0700 (PDT)
Message-ID: <b2d90156-f29d-88a0-58b8-7fb32c08c837@gmail.com>
Date:   Wed, 4 May 2022 22:39:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:96.0) Gecko/20100101
 Thunderbird/96.0
Subject: Re: [RESEND PATCH v3 1/2] dt-bindings: mtd: partitions: Document new
 partition-dynamic nodes
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429124825.21477-1-ansuelsmth@gmail.com>
 <20220429124825.21477-2-ansuelsmth@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
In-Reply-To: <20220429124825.21477-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.04.2022 14:48, Ansuel Smith wrote:
> Document new partition-dynamic nodes used to provide an OF node for
> partition registred at runtime by parsers. This is required for nvmem
> system to declare and detect nvmem-cells.
> 
> With these special partitions, the reg / offset is not required.
> The node name must be in the form of "partition name"-dynamic.
> If the partition can't be displayed using the node name, it's possible
> to use the label binding that will be used instead of the node name.
> The node name or the label binding is used to match the partition
> allocated by the parser at runtime and the parser will provide reg
> and offset of the mtd.
> 
> NVMEM will use the data from the parser and provide the NVMEM cells
> declared in the DTS, "connecting" the dynamic partition with a
> static declaration of cells in them.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   .../mtd/partitions/partition-dynamic.yaml     | 56 +++++++++++++++++++
>   .../mtd/partitions/qcom,smem-part.yaml        |  4 ++
>   2 files changed, 60 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> new file mode 100644
> index 000000000000..e0efa58e4fac
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mtd/partitions/partition-dynamic.yaml
> @@ -0,0 +1,56 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mtd/partitions/partition-dynamic.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Dynamic Partition

I'm not native but that "Dynamic Partition" sounds pretty natural and
I'm wondering if you shouldn't make that binding dynamic-partition.yaml

Any natives to comment on this? :)


> +description: |
> +  This binding describes a single flash partition that is dynamically allocated
> +  by a dedicated parser that is not a fixed-partition parser.
> +
> +  A dynamic partition require the node ending with the "-dynamic" tag and if the
> +  dynamic partition name can't be displayed using the node name, the label
> +  properties can be used. The node name or the label have to match the dynamic
> +  partition allocated by the parser.
> +
> +  These special partition definition can be used to give a dynamic partition
> +  an OF node to declare NVMEM cells. An example is declaring the partition
> +  label and all the NVMEM cells in it. The parser will detect the correct reg
> +  and offset and the NVMEM will register the cells in it based on the data
> +  extracted by the parser.
> +
> +maintainers:
> +  - Ansuel Smith <ansuelsmth@gmail.com>
> +
> +properties:
> +  label:
> +    description: The label / name for the partition assigned by the parser at
> +      runtime. This is needed for sybsystem like NVMEM to define cells and
> +      register with this OF node.
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    flash {
> +      partitions {
> +        compatible = "qcom,smem-part";
> +
> +        art-dynamic {
> +          compatible = "nvmem-cells";
> +          #address-cells = <1>;
> +          #size-cells = <1>;
> +          label = "0:art";
> +
> +          macaddr_art_0: macaddr@0 {
> +            reg = <0x0 0x6>;
> +          };
> +
> +          macaddr_art_6: macaddr@6 {
> +            reg = <0x6 0x6>;
> +          };
> +        };
> +      };
> +    };

I see that we need a property (like "label") for storing partition name
as it may contain characters not allowed in $nodename.

Is there a reason to play with all that foo-dynamic $nodename then? With
fallback from "label" to extracting foo from *-dynamic pattern?

Could we just be lazy, keep things simple and require "label" property?

Then we could e.g. require $nodename to be pattern ^partition-[0-9a-f]+$
It's what leds-gpio.yaml does for reference.

Example:

partitions {
	compatible = "foo";

	partition-1 {
		label = "bootloader";
	};

	partition-2 {
		label = "0:art";
	};
};
