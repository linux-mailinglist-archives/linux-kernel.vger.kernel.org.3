Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D864FFBCF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 18:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiDMQ4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 12:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiDMQ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 12:56:12 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8728869CD1;
        Wed, 13 Apr 2022 09:53:49 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KdpX609T6z67nHV;
        Thu, 14 Apr 2022 00:51:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 13 Apr 2022 18:53:46 +0200
Received: from localhost (10.81.205.148) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 17:53:44 +0100
Date:   Wed, 13 Apr 2022 17:53:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Rob Herring <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Agathe Porte" <agathe.porte@nokia.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "Jean Delvare" <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        "Geert Uytterhoeven" <geert+renesas@glider.be>,
        <linux-hwmon@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <linux-iio@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix array constraints on scalar properties
Message-ID: <20220413175341.000030d9@Huawei.com>
In-Reply-To: <20220413140121.3132837-1-robh@kernel.org>
References: <20220413140121.3132837-1-robh@kernel.org>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.148]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Apr 2022 09:01:21 -0500
Rob Herring <robh@kernel.org> wrote:

> Scalar properties shouldn't have array constraints (minItems, maxItems,
> items). These constraints can simply be dropped with any constraints under
> 'items' moved up a level.
> 
> Cc: Agathe Porte <agathe.porte@nokia.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Olivier Moysan <olivier.moysan@foss.st.com>
> Cc: Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: linux-hwmon@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-iio@vger.kernel.org
> Cc: linux-media@vger.kernel.org
> Cc: linux-remoteproc@vger.kernel.org
> Cc: linux-spi@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml       | 5 ++---
>  .../devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml      | 4 +---

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

>  Documentation/devicetree/bindings/media/coda.yaml            | 1 -
>  .../devicetree/bindings/media/mediatek,vcodec-decoder.yaml   | 2 --
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml   | 2 --
>  .../bindings/media/mediatek,vcodec-subdev-decoder.yaml       | 1 -
>  .../devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml | 4 +---
>  Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml  | 2 --
>  8 files changed, 4 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> index 801ca9ba7d34..e7493e25a7d2 100644
> --- a/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> +++ b/Documentation/devicetree/bindings/hwmon/ti,tmp464.yaml
> @@ -58,9 +58,8 @@ patternProperties:
>            The value (two's complement) to be programmed in the channel specific N correction register.
>            For remote channels only.
>          $ref: /schemas/types.yaml#/definitions/int32
> -        items:
> -          minimum: -128
> -          maximum: 127
> +        minimum: -128
> +        maximum: 127
>  
>      required:
>        - reg
> diff --git a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> index 7c260f209687..952bc900d0fa 100644
> --- a/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> +++ b/Documentation/devicetree/bindings/iio/adc/st,stm32-dfsdm-adc.yaml
> @@ -108,9 +108,7 @@ patternProperties:
>            - [1-5]: order 1 to 5.
>            For audio purpose it is recommended to use order 3 to 5.
>          $ref: /schemas/types.yaml#/definitions/uint32
> -        items:
> -          minimum: 0
> -          maximum: 5
> +        maximum: 5
>  
>        "#io-channel-cells":
>          const: 1
> diff --git a/Documentation/devicetree/bindings/media/coda.yaml b/Documentation/devicetree/bindings/media/coda.yaml
> index 36781ee4617f..c9d5adbc8c4a 100644
> --- a/Documentation/devicetree/bindings/media/coda.yaml
> +++ b/Documentation/devicetree/bindings/media/coda.yaml
> @@ -65,7 +65,6 @@ properties:
>    iram:
>      $ref: /schemas/types.yaml#/definitions/phandle
>      description: phandle pointing to the SRAM device node
> -    maxItems: 1
>  
>  required:
>    - compatible
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> index 9b179bb44dfb..aa55ca65d6ed 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-decoder.yaml
> @@ -63,13 +63,11 @@ properties:
>  
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to vpu.
>  
>    mediatek,scp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to scp.
>  
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index e7b65a91c92c..2746dea3ce79 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -55,13 +55,11 @@ properties:
>  
>    mediatek,vpu:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to vpu.
>  
>    mediatek,scp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description:
>        Describes point to scp.
>  
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> index 7687be0f50aa..c73bf2352aca 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-subdev-decoder.yaml
> @@ -61,7 +61,6 @@ properties:
>  
>    mediatek,scp:
>      $ref: /schemas/types.yaml#/definitions/phandle
> -    maxItems: 1
>      description: |
>        The node of system control processor (SCP), using
>        the remoteproc & rpmsg framework.
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> index 2424de733ee4..d99a729d2710 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sc7280-wpss-pil.yaml
> @@ -104,8 +104,7 @@ properties:
>    qcom,smem-state-names:
>      $ref: /schemas/types.yaml#/definitions/string
>      description: The names of the state bits used for SMP2P output
> -    items:
> -      - const: stop
> +    const: stop
>  
>    glink-edge:
>      type: object
> @@ -130,7 +129,6 @@ properties:
>        qcom,remote-pid:
>          $ref: /schemas/types.yaml#/definitions/uint32
>          description: ID of the shared memory used by GLINK for communication with WPSS
> -        maxItems: 1
>  
>      required:
>        - interrupts
> diff --git a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> index b104899205f6..5de710adfa63 100644
> --- a/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> +++ b/Documentation/devicetree/bindings/spi/renesas,sh-msiof.yaml
> @@ -124,7 +124,6 @@ properties:
>      description: |
>        Override the default TX fifo size.  Unit is words.  Ignored if 0.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    maxItems: 1
>      default: 64
>  
>    renesas,rx-fifo-size:
> @@ -132,7 +131,6 @@ properties:
>      description: |
>        Override the default RX fifo size.  Unit is words.  Ignored if 0.
>      $ref: /schemas/types.yaml#/definitions/uint32
> -    maxItems: 1
>      default: 64
>  
>  required:

