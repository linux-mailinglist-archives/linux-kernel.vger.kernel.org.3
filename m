Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7655A01C0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 21:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235300AbiHXTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236884AbiHXTEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 15:04:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD7BBD9;
        Wed, 24 Aug 2022 12:04:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76C5C617A1;
        Wed, 24 Aug 2022 19:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB7ACC4347C;
        Wed, 24 Aug 2022 19:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661367884;
        bh=nLY1dWX+NvnobV3U/O2MJdRhHPtd9rugDGykeghL9C0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=rY03dinX+fIfbIRN9zrOTLpoSqa8ObzafZuN0mIg5x+l1aZ/xDyacffHq+vvc5O2l
         9Wy5AYkL5OmarB9JMbmwoTqOYWd8ZzZsuxOznyHIanFzEDsMxWr46mePz2VfJqYDQV
         /CfQJx2ktwIkvbDqngyACp680p2LmhmZ4WtdJ6N1s9IM+1IOY5MqEX0e4sjb2W5cJT
         Wv7NommO7hTGxSYZcHj2x7na9zmJQBs8ZxrQaFD4UqUwCnNtF4IrI7ZkFm7Ys0lpEl
         +G0amuOmhkSc27x+I4rxltFM2gTQIxVphg6stEYXcDfc8sFh7OXLUGswWpGk8g7/MQ
         WSF7/qGPKNXxQ==
Received: by mail-ua1-f52.google.com with SMTP id d15so7077518uak.11;
        Wed, 24 Aug 2022 12:04:44 -0700 (PDT)
X-Gm-Message-State: ACgBeo2fOfAn7qg4pGwD5U5ThKAq+5N5jF0q1dM6Umiel9YL5eZZJhKR
        UX+ySay8yy92KXGZAv1FUhnZt8FOgM+ZHoT+YQ==
X-Google-Smtp-Source: AA6agR7+X17CRMoPpoVupslgTTLLUBypMe9v+axiCCGH7mCEo+eSbyZ4gKfbeV10FTOa57uB9+WTdkZhPE0G97wRKq8=
X-Received: by 2002:ab0:1053:0:b0:391:9c29:7ca8 with SMTP id
 g19-20020ab01053000000b003919c297ca8mr155684uab.86.1661367883513; Wed, 24 Aug
 2022 12:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220721212718.1980905-1-robh@kernel.org>
In-Reply-To: <20220721212718.1980905-1-robh@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 24 Aug 2022 14:04:31 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJCGPSxYb5CqiEM9YAmJjQE4wp_0HCWgBSqPDBBAJRMBA@mail.gmail.com>
Message-ID: <CAL_JsqJCGPSxYb5CqiEM9YAmJjQE4wp_0HCWgBSqPDBBAJRMBA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: coresight: Add 'power-domains' property
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Coresight ML <coresight@lists.linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/STM32 ARCHITECTURE" 
        <linux-stm32@st-md-mailman.stormreply.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 4:27 PM Rob Herring <robh@kernel.org> wrote:
>
> Coresight components may be in a power domain which is the case for the Arm
> Juno board. Allow a single 'power-domains' entry for Coresight components.

Ping.

>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml  | 3 +++
>  Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml   | 3 +++
>  .../devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml  | 3 +++
>  .../bindings/arm/arm,coresight-dynamic-replicator.yaml         | 3 +++
>  Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml | 3 +++
>  Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml   | 3 +++
>  .../devicetree/bindings/arm/arm,coresight-static-funnel.yaml   | 3 +++
>  .../bindings/arm/arm,coresight-static-replicator.yaml          | 3 +++
>  Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml   | 3 +++
>  Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml   | 3 +++
>  Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml  | 3 +++
>  .../devicetree/bindings/arm/arm,embedded-trace-extension.yaml  | 3 +++
>  12 files changed, 36 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> index d783d9276124..2bae06eed693 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> @@ -61,6 +61,9 @@ properties:
>      maxItems: 1
>      description: Address translation error interrupt
>
> +  power-domains:
> +    maxItems: 1
> +
>    in-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> index 72ffe4d1e948..0c5b875cb654 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-cti.yaml
> @@ -98,6 +98,9 @@ properties:
>        base cti node if compatible string arm,coresight-cti-v8-arch is used,
>        or may appear in a trig-conns child node when appropriate.
>
> +  power-domains:
> +    maxItems: 1
> +
>    arm,cti-ctm-id:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> index 1eeedc22857c..44a1041cb0fc 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> @@ -54,6 +54,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    in-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
> index a26ed9214e00..03792e9bd97a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-dynamic-replicator.yaml
> @@ -54,6 +54,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    qcom,replicator-loses-context:
>      type: boolean
>      description:
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> index fd06ede26ceb..90679788e0bf 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> @@ -54,6 +54,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    in-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> index e0377ce48537..01200f67504a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> @@ -73,6 +73,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    arm,coresight-loses-context-with-cpu:
>      type: boolean
>      description:
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
> index b9da30ab9ccd..06a1d346982c 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-funnel.yaml
> @@ -27,6 +27,9 @@ properties:
>    compatible:
>      const: arm,coresight-static-funnel
>
> +  power-domains:
> +    maxItems: 1
> +
>    in-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> index 66ee97370fb2..5178e7fdff0b 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> @@ -27,6 +27,9 @@ properties:
>    compatible:
>      const: arm,coresight-static-replicator
>
> +  power-domains:
> +    maxItems: 1
> +
>    in-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> index 905008faa012..378380c3f5aa 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> @@ -61,6 +61,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    out-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> index 3463b6e53aef..e0b88a71356a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> @@ -55,6 +55,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    arm,buffer-size:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      deprecated: true
> diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> index e80d48200c37..61a0cdc27745 100644
> --- a/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> @@ -54,6 +54,9 @@ properties:
>        - const: apb_pclk
>        - const: atclk
>
> +  power-domains:
> +    maxItems: 1
> +
>    in-ports:
>      $ref: /schemas/graph.yaml#/properties/ports
>      additionalProperties: false
> diff --git a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> index 5f07fb166c56..108460627d9a 100644
> --- a/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> +++ b/Documentation/devicetree/bindings/arm/arm,embedded-trace-extension.yaml
> @@ -33,6 +33,9 @@ properties:
>        Handle to the cpu this ETE is bound to.
>      $ref: /schemas/types.yaml#/definitions/phandle
>
> +  power-domains:
> +    maxItems: 1
> +
>    out-ports:
>      description: |
>        Output connections from the ETE to legacy CoreSight trace bus.
> --
> 2.34.1
>
