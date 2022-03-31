Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D66A84ED411
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbiCaGpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbiCaGpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:45:49 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0021E7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:44:01 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id qa43so45959973ejc.12
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VB+MQmFGOi8PIqurWSQQXXP2T/3+5lFG8686ICDPeeQ=;
        b=V+PtUPDmwkeSKgKILCl8uPBH2oMxeNb9HbqE2EKJFMtTZGGrkCQha62Ok0iLz8HVvv
         x9D7BPETNKCOIwgiakABu0kXDMnFFxVjeAQNCEiwHHwcgezFoMqtsoe6VKIp+b26e7fq
         g2/1W/kZp4uvGMvs0XFhONWp29bEEi1nNw7vJNDTVAriXy+/g7pMlrqecZdGojfLs2As
         jvPOhfhcedWWm6X0jIEpwjfqAXVWDN6tOyzTZcFEPjpCPI2xXCvGJb7tMt1HOi5NzLcl
         X4L870ooHn38Nj70hzlG2q8+GCBzaOTJhTWUc1uyrHY1f1WE8K5P5qf6tPO74J1WAlZF
         W5tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VB+MQmFGOi8PIqurWSQQXXP2T/3+5lFG8686ICDPeeQ=;
        b=yYO/XZ8qx0aew+MI5zYPFUfz+MdD8QvVWZ76qiaeWNpwHApU/oLrPhr6YMCcS43OZQ
         4tQBp52AOYP0nQldIGovI+rviMhcm1Jk7Ve5L2SHEyQaqLGzkmaTeX837RjrmqOdvG+I
         gi+xe4oMJc8DRLrHPuNEhLChu84gj/C4DYRmPv69YygBal6mgpE2BkTulSyT9v2g8oyd
         w+r6fWlgykBSCr/5CNMSQ82XKyJeOZYACwi6pd2w1EssLqxCsamO5HI53phFjoCUBc+d
         2t1s23opqib1YypwXG8At3/VGL28PCzBw/3WhXfx7LMP3mg5PdXPGtji5mOMxMqWyxu/
         ZZjQ==
X-Gm-Message-State: AOAM532tHqj/lDYopxaSVQpdAjx554Is7OwH4Bj8O+lIDdF7F5eDUXNB
        6X7KaN9R1q209kqDdoWTxCyY1g==
X-Google-Smtp-Source: ABdhPJyQOrnnISPCfZvbJJ1F4zHA6mlVGmMT5D9+CwjsEF5kqtNCIvJ28WOpYto8VVX3JF58iuWdLw==
X-Received: by 2002:a17:907:3e99:b0:6df:7ad3:f66b with SMTP id hs25-20020a1709073e9900b006df7ad3f66bmr3707452ejc.230.1648709040431;
        Wed, 30 Mar 2022 23:44:00 -0700 (PDT)
Received: from [192.168.0.165] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090606c200b006a728f4a9bcsm9145467ejb.148.2022.03.30.23.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 23:43:59 -0700 (PDT)
Message-ID: <9e3ba11c-d179-c229-fb7c-bf5611a15b1b@linaro.org>
Date:   Thu, 31 Mar 2022 08:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [RFC PATCH 1/5] dt-bindings: sound: Add Apple Macs sound system
Content-Language: en-US
To:     =?UTF-8?Q?Martin_Povi=c5=a1er?= <povik+lin@cutebit.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
 <20220331000449.41062-2-povik+lin@cutebit.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220331000449.41062-2-povik+lin@cutebit.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2022 02:04, Martin Povišer wrote:
> Add binding for Apple Silicon Macs' machine-level sound system.
> 
> Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
> ---
>  .../bindings/sound/apple,macaudio.yaml        | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/apple,macaudio.yaml
> 

Commit title does not match subsystem.

> diff --git a/Documentation/devicetree/bindings/sound/apple,macaudio.yaml b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
> new file mode 100644
> index 000000000000..a6380e4bdd1a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/apple,macaudio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Apple Silicon Macs integrated sound system
> +
> +maintainers:
> +  - Martin Povišer <povik+lin@cutebit.org>
> +

Add description.

> +definitions:

This does not make code more readable.

> +  dai:
> +    type: object
> +    properties:
> +      sound-dai: true
> +    required:
> +      - sound-dai
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - apple,j274-macaudio
> +          - apple,j293-macaudio
> +          - apple,j314-macaudio
> +      - const: apple,macaudio

Open example-schema.yaml and look at formatting plus general coding
style. You miss line breaks making it unreadable.

> +  "#address-cells":
> +    const: 1
> +  "#size-cells":
> +    const: 0
> +  model:
> +    description: |
> +      Model name to use when the sound system is presented to users as a sound card.
> +    $ref: /schemas/types.yaml#/definitions/string
> +
> +patternProperties:
> +  "^dai-link(@[0-9a-f]+)?$":
> +    description: |
> +      A DAI link comprising of CPU and CODEC DAI specifiers and supplemental properties.
> +    type: object
> +    properties:
> +      reg:
> +        maxItems: 1
> +      mclk-fs:
> +        description: |
> +          Forced MCLK/samplerate factor (optional).

Optional is obvious from !required.

Description is different than existing field in simple card. Is this the
same field or not?

> +        $ref: /schemas/types.yaml#/definitions/uint32
> +      link-name:
> +        description: Name for the DAI link to present to users.
> +        $ref: /schemas/types.yaml#/definitions/string
> +      cpu:
> +        $ref: "#/definitions/dai"
> +      codec:
> +        $ref: "#/definitions/dai"

missing maxItems for DAI phandles.

> +    required:
> +      - reg
> +      - cpu
> +      - codec
> +    additionalProperties: false

This entire block is unreadable.

> +
> +required:
> +  - compatible
> +  - model
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +      compatible = "apple,j293-macaudio", "apple,macaudio";
> +      model = "MacBook Pro J293 integrated audio";
> +
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +
> +      dai-link@0 {
> +        reg = <0>;
> +        link-name = "Speakers";
> +        mclk-fs = <64>;
> +
> +        cpu {
> +          sound-dai = <&mca 0>, <&mca 1>;
> +        };
> +        codec {
> +          sound-dai = <&speaker_left_front>, <&speaker_right_front>,
> +            <&speaker_left_rear>, <&speaker_right_rear>;

Align the line.

> +        };
> +      };
> +
> +      dai-link@1 {
> +        reg = <1>;
> +        link-name = "Headphones Jack";
> +        mclk-fs = <64>;
> +
> +        cpu {
> +          sound-dai = <&mca 2>;
> +        };
> +        codec {
> +          sound-dai = <&jack_codec>;
> +        };
> +      };
> +    };


Best regards,
Krzysztof
