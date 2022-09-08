Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810EA5B1BED
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiIHLxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIHLxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:53:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBE38127572
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:53:42 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id m15so7619096lfl.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=iRuj9MmFc1SCJLCaHL8wU+6QRDALzTMmNIxwRLm5wlo=;
        b=E1ebbQoHrW+/VfxPqYc0KjatYpsu58UrKW5S2ZZc8M4onNSkHDJ/19V6NhbIEWN/ZC
         EW+bdOU0fygsFZa9BgSirhgqcjkhddyYn5cF2JeaGU9o31x/zMlvFjl1CgITkBjeIsiI
         1YZB2rllshoEspWfpAnpe9GlwDYVawBxurs964wKLXuLGywagcM1vpngXdZkUo8kx2kt
         GHi3NblhHSn3T781q9eYtTjEBMAZUhDftqT0xesHbPMzEMKdDX14l+9PNb5Zj7nK6eiP
         jrYGTf1xvhdxJ51+ROO4/LYtMWk1pVdtp0Ks3+bp0+eaiJ35ht+AO0EJn6RUlO7bm5cm
         WfnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=iRuj9MmFc1SCJLCaHL8wU+6QRDALzTMmNIxwRLm5wlo=;
        b=gnXmAYBAgoS5+MKXgenlJPYpLbBsxrMZojqFDxGQTVG/GIPY35KB532U7xT+ZqDQ59
         6WpzQ5b25cuvfdxT4zmFt/9P6aKsk8cMB/vuGOyXDH6FJMvIh2eq1i4cKaQYR+c9zsfw
         SVgHU1+DZ49DzJrS6u0G5WXuLp/gHCDDA/3lkaPhG9ZJr4v9GPkTA7TN9QWJ+LsGs+N5
         ZkKTewlVVv/dEvKzSILODo5w5mHJn3DFJ/ZS/OF4RlS6yL3qkLJmA531ZI8rVQncNZ7d
         MP9FllFXiDqE1RYFRK5FG8it1Sbdwq6+ccAcxHnzb7NFYRMg4J+g1omjFmgKFE6/IN/I
         E96w==
X-Gm-Message-State: ACgBeo2ebYiEjwQM2ZyeDZCmeUDoWFKAlm5OmKpmEbgapCHWJP79Efmb
        yjKMKeWIGiabS8YjGT3SpVoA8Q==
X-Google-Smtp-Source: AA6agR4iAQdU6oLoT8Tvfczu2zMwGG5Qj5yA7hI8XaLTD00qADWEc75SRlKViM+IV/RWze1lIH5TOQ==
X-Received: by 2002:a05:6512:259f:b0:494:65bd:7188 with SMTP id bf31-20020a056512259f00b0049465bd7188mr2489781lfb.501.1662638021279;
        Thu, 08 Sep 2022 04:53:41 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id t11-20020a05651c204b00b00261e50a2534sm3128127ljo.33.2022.09.08.04.53.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Sep 2022 04:53:40 -0700 (PDT)
Message-ID: <d447edf0-1726-d742-d932-d24707657691@linaro.org>
Date:   Thu, 8 Sep 2022 13:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/8] ASoC: rockchip: rk3308: add internal audio codec
 bindings
Content-Language: en-US
To:     luca.ceresoli@bootlin.com, alsa-devel@alsa-project.org,
        linux-rockchip@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
 <20220907142124.2532620-2-luca.ceresoli@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220907142124.2532620-2-luca.ceresoli@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2022 16:21, luca.ceresoli@bootlin.com wrote:
> From: Luca Ceresoli <luca.ceresoli@bootlin.com>
> 
> Add device tree bindings document for the internal audio codec of the
> Rockchip RK3308 SoC.
> 
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Use subject prefixes matching the subsystem (git log --oneline -- ...).

> ---
>  .../bindings/sound/rockchip,rk3308-codec.yaml | 102 ++++++++++++++++++
>  MAINTAINERS                                   |   6 ++
>  .../dt-bindings/sound/rockchip,rk3308-codec.h |  15 +++
>  3 files changed, 123 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
>  create mode 100644 include/dt-bindings/sound/rockchip,rk3308-codec.h
> 
> diff --git a/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml b/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
> new file mode 100644
> index 000000000000..f3458f86ef06
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
> @@ -0,0 +1,102 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/rockchip,rk3308-codec.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Rockchip RK3308 Internal Codec
> +
> +description: |
> +  This is the audio codec embedded in the Rockchip RK3308
> +  SoC. It has 8 24-bit ADCs and 2 24-bit DACs. The maximum supported
> +  sampling rate is 192 kHz.
> +
> +  It is connected internally to one out of a selection of the internal I2S
> +  controllers.
> +
> +  The RK3308 audio codec has 8 independent capture channels, but some
> +  features work on stereo pairs called groups:
> +    * grp 0 -- MIC1 / MIC2
> +    * grp 1 -- MIC3 / MIC4
> +    * grp 2 -- MIC5 / MIC6
> +    * grp 3 -- MIC7 / MIC8
> +
> +maintainers:
> +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> +
> +properties:
> +  compatible:
> +    const: rockchip,rk3308-codec
> +
> +  reg:
> +    maxItems: 1
> +
> +  rockchip,grf:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      Phandle to the General Register Files (GRF)
> +
> +  clocks:
> +    items:
> +      - description: clock for TX
> +      - description: clock for RX
> +      - description: AHB clock driving the interface
> +
> +  clock-names:
> +    items:
> +      - const: mclk_tx
> +      - const: mclk_rx
> +      - const: hclk
> +
> +  resets: true

maxItems: 1

> +
> +  reset-names:
> +    items:
> +      - const: "acodec"

No quotes.

> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +  rockchip,micbias-avdd-multiplier:
> +    description: |
> +      Voltage setting for the MICBIAS pins expressed as a multiplier of
> +      AVDD.
> +
> +      E.g. if rockchip,micbias-avdd-multiplier = 7 (x0.85) and AVDD = 3v3,
> +      then MIC BIAS voltage will be 3.3 V * 0.85 = 2.805 V.
> +
> +      Value 0: multiplier = 0.50
> +      Value N: multiplier = 0.50 + 0.05 * N
> +      Value 7: multiplier = 0.85

Use logical values/units. The units is 0.05, so "-percent" in node name.
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
Then drop ref and use enum.

> +
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 7
> +
> +required:
> +  - compatible
> +  - reg
> +  - rockchip,grf
> +  - clocks
> +  - resets
> +  - "#sound-dai-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/rk3308-cru.h>
> +
> +    acodec: acodec@ff560000 {

codec

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "rockchip,rk3308-codec";
> +        reg = <0xff560000 0x10000>;
> +        rockchip,grf = <&grf>;
> +        clock-names = "mclk_tx", "mclk_rx", "hclk";
> +        clocks = <&cru SCLK_I2S2_8CH_TX_OUT>,
> +                 <&cru SCLK_I2S2_8CH_RX_OUT>,
> +                 <&cru PCLK_ACODEC>;
> +        reset-names = "acodec";
> +        resets = <&cru SRST_ACODEC_P>;
> +        #sound-dai-cells = <0>;
> +    };
> +
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 895e8ace80dd..d53a8e74cb1e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17588,6 +17588,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/media/rockchip-rga.yaml
>  F:	drivers/media/platform/rockchip/rga/
>  
> +ROCKCHIP RK3308 INTERNAL AUDIO CODEC
> +M:	Luca Ceresoli <luca.ceresoli@bootlin.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/sound/rockchip,rk3308-codec.yaml
> +F:	include/dt-bindings/sound/rockchip,rk3308-codec.h
> +
>  ROCKCHIP VIDEO DECODER DRIVER
>  M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
>  L:	linux-media@vger.kernel.org
> diff --git a/include/dt-bindings/sound/rockchip,rk3308-codec.h b/include/dt-bindings/sound/rockchip,rk3308-codec.h
> new file mode 100644
> index 000000000000..9f1b210a048e
> --- /dev/null
> +++ b/include/dt-bindings/sound/rockchip,rk3308-codec.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license.

> +#ifndef __DT_BINDINGS_ROCKCHIP_RK3308_CODEC_H__
> +#define __DT_BINDINGS_ROCKCHIP_RK3308_CODEC_H__
> +
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_50	0
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_55	1
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_60	2
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_65	3
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_70	4
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_75	5
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_80	6
> +#define RK3308_CODEC_MICBIAS_AVDD_x_0_85	7

You store register values in the bindings. Nope. Bindings are not for this.

Best regards,
Krzysztof
