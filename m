Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DDD45B0BE4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 19:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiIGR6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 13:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbiIGR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 13:58:02 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C222AA4DA;
        Wed,  7 Sep 2022 10:58:01 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-11e9a7135easo37949859fac.6;
        Wed, 07 Sep 2022 10:58:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=UdQDfJDRdgGrPGjr0rQoSFWlcm9yHV7FNhW1rklMkE0=;
        b=zs+rUhahmEXicw/Ubu+iuq+okCF//247nzn5p+pSTJql9nx7pDcUL88ZCJeovy8z0F
         HtoKp6vObUuRpP1TezsaZyo0ddAi0Yt8pm5wLBKrMMGIDEGmt0NLHZn8BndW2CgSFSnl
         S6KxVgd6PEB4i6H28D0T65FxzruJIti+tmRyAmV32+GnsEzzXESiceZvjSJpZCOai8xE
         OQYCZUaNJaLrRvEbXn+XeAAd6++n2pMnc7eNlwWBBzXBfZ/B1Es+mravJ0IWIV0xRpLb
         WpyBYa6/hFQm10teO7pxR4Fr4VK41/+qXi03WwtjpJojUFTmu1gtU9VWudo6Wyt+Hp6X
         gyfw==
X-Gm-Message-State: ACgBeo1eR1eligW33qMttYoQZwa9DK2JehVEPmNKsrQwgvXP2McwD8xz
        fR1FrQQ9MOUS1RyUtvKzxw==
X-Google-Smtp-Source: AA6agR6xKrGz+BcPw2Zi9fBkKG87AYCGD492SkFstQc2YuZbmPjB1jUx7jBedulSPqAHkVLIY16gbQ==
X-Received: by 2002:a05:6808:e90:b0:345:49f2:a112 with SMTP id k16-20020a0568080e9000b0034549f2a112mr12928078oil.7.1662573480405;
        Wed, 07 Sep 2022 10:58:00 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l3-20020a056870f14300b0012752d3212fsm4943445oac.53.2022.09.07.10.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 10:58:00 -0700 (PDT)
Received: (nullmailer pid 3798414 invoked by uid 1000);
        Wed, 07 Sep 2022 17:57:59 -0000
Date:   Wed, 7 Sep 2022 12:57:59 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: [PATCH v2 09/14] ASoC: dt-bindings:: qcom,q6asm: convert to
 dtschema
Message-ID: <20220907175759.GA3791463-robh@kernel.org>
References: <20220907101556.37394-1-krzysztof.kozlowski@linaro.org>
 <20220907101556.37394-10-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907101556.37394-10-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 12:15:51PM +0200, Krzysztof Kozlowski wrote:
> Convert Qualcomm Audio Stream Manager (Q6ASM) bindings to DT schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Expected warning because the qcom,apr.yaml is being fixed in next commit:
> 
>   Documentation/devicetree/bindings/sound/qcom,q6asm.example.dtb: apr: service@7: 'dais' does not match any of the regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'
>     From schema: /home/krzk/dev/linux/linux/Documentation/devicetree/bindings/soc/qcom/qcom,apr.yaml
> 
> Changes since v1:
> 1. New patch.
> ---
>  .../devicetree/bindings/sound/qcom,q6asm.txt  |  70 -----------
>  .../devicetree/bindings/sound/qcom,q6asm.yaml | 112 ++++++++++++++++++
>  2 files changed, 112 insertions(+), 70 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,q6asm.yaml

Should be qcom,q6asm-dais.yaml or you need to add qcom,q6asm compatible?

> 
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt b/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> deleted file mode 100644
> index 0d0075125243..000000000000
> --- a/Documentation/devicetree/bindings/sound/qcom,q6asm.txt
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -Qualcomm Audio Stream Manager (Q6ASM) binding
> -
> -Q6ASM is one of the APR audio service on Q6DSP.
> -Please refer to qcom,apr.txt for details of the common apr service bindings
> -used by the apr service device.
> -
> -- but must contain the following property:
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,q6asm-v<MAJOR-NUMBER>.<MINOR-NUMBER>".
> -		    Or "qcom,q6asm" where the version number can be queried
> -		    from DSP.
> -		    example "qcom,q6asm-v2.0"

Where is this compatible handled now? 

> -
> -= ASM DAIs (Digital Audio Interface)
> -"dais" subnode of the ASM node represents dai specific configuration
> -
> -- compatible:
> -	Usage: required
> -	Value type: <stringlist>
> -	Definition: must be "qcom,q6asm-dais".
> -
> -- #sound-dai-cells
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be 1
> -
> -== ASM DAI is subnode of "dais" and represent a dai, it includes board specific
> -configuration of each dai. Must contain the following properties.
> -
> -- reg
> -	Usage: required
> -	Value type: <u32>
> -	Definition: Must be dai id
> -
> -- direction:
> -	Usage: Required for Compress offload dais
> -	Value type: <u32>
> -	Definition: Specifies the direction of the dai stream
> -			Q6ASM_DAI_TX_RX (0) for both tx and rx
> -			Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
> -			Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
> -
> -- is-compress-dai:
> -	Usage: Required for Compress offload dais
> -	Value type: <boolean>
> -	Definition: present for Compress offload dais
> -
> -
> -= EXAMPLE
> -#include <dt-bindings/sound/qcom,q6asm.h>
> -
> -apr-service@7 {
> -	compatible = "qcom,q6asm";
> -	reg = <APR_SVC_ASM>;
> -	q6asmdai: dais {
> -		compatible = "qcom,q6asm-dais";
> -		#address-cells = <1>;
> -		#size-cells = <0>;
> -		#sound-dai-cells = <1>;
> -
> -		dai@0 {
> -			reg = <0>;
> -			direction = <Q6ASM_DAI_RX>;
> -			is-compress-dai;
> -		};
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml b/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
> new file mode 100644
> index 000000000000..505bd64a0717
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,q6asm.yaml
> @@ -0,0 +1,112 @@
> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,q6asm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Audio Stream Manager (Q6ASM)
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description:
> +  Q6ASM is one of the APR audio services on Q6DSP. Each of its subnodes
> +  represent a dai with board specific configuration.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,q6asm-dais
> +
> +  iommus:
> +    maxItems: 1
> +
> +  '#sound-dai-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 1
> +
> +  '#size-cells':
> +    const: 0
> +
> +patternProperties:
> +  '^dai@[0-9]+$':
> +    type: object
> +    description:
> +      Q6ASM Digital Audio Interface
> +
> +    properties:
> +      reg:
> +        maxItems: 1
> +
> +      direction:
> +        $ref: /schemas/types.yaml#/definitions/uint32
> +        enum: [0, 1, 2]
> +        description: |
> +          The direction of the dai stream::
> +           - Q6ASM_DAI_TX_RX (0) for both tx and rx
> +           - Q6ASM_DAI_TX (1) for only tx (Capture/Encode)
> +           - Q6ASM_DAI_RX (2) for only rx (Playback/Decode)
> +
> +      is-compress-dai:
> +        type: boolean
> +        description:
> +          Compress offload dai.
> +
> +    dependencies:
> +      is-compress-dai: ['direction']
> +
> +    required:
> +      - reg
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - "#sound-dai-cells"
> +  - "#address-cells"
> +  - "#size-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/soc/qcom,apr.h>
> +    #include <dt-bindings/sound/qcom,q6asm.h>
> +
> +    apr {
> +        compatible = "qcom,apr-v2";
> +        qcom,domain = <APR_DOMAIN_ADSP>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        service@7 {
> +            compatible = "qcom,q6asm";
> +            reg = <APR_SVC_ASM>;
> +            qcom,protection-domain = "avs/audio", "msm/adsp/audio_pd";
> +
> +            dais {
> +                compatible = "qcom,q6asm-dais";
> +                iommus = <&apps_smmu 0x1821 0x0>;
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +                #sound-dai-cells = <1>;
> +
> +                dai@0 {
> +                    reg = <0>;
> +                };
> +
> +                dai@1 {
> +                    reg = <1>;
> +                };
> +
> +                dai@2 {
> +                    reg = <2>;
> +                    is-compress-dai;
> +                    direction = <1>;
> +                };
> +            };
> +        };
> +    };
> -- 
> 2.34.1
> 
> 
