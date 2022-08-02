Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A2C587E62
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237226AbiHBOuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 10:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233655AbiHBOuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 10:50:12 -0400
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE61D215;
        Tue,  2 Aug 2022 07:50:10 -0700 (PDT)
Received: by mail-il1-f176.google.com with SMTP id b12so6408032ils.9;
        Tue, 02 Aug 2022 07:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=e4JWei8BMxaRFQiwirEOpStmVsY2WsRWjYgax2kVdRc=;
        b=Ig12JKcTkMPo97mT/OLDm/Xq7L+5vtey3m3os8ZKljR0zn+ihDmP4e5wzViKVkx3EV
         KcHFXGeDAUb4jUMMbxE3QN2d5Ufyxl06wGnEPPKyqmSqjNpgdIpuZ7XmIghoUs6anr1S
         OV3blU0qmcHR4r5YU0Ob4RFFJFA4HVKWCLBXw7KPn0CsIc34Xs5cStFU20u/1piNtbNj
         3JEaIMiZe+OuPNwCe1+6r2gI8GPdX6e82ApDCBKlS65uobr90zGLvg6+HWOLdkNSFbnb
         xwfVJVcpVElE9MnAr0BcMEg2vVXtjhM3wuJIrgt/DWhBKb3KWUoyStf3ZJC2DIZHxC5u
         UneA==
X-Gm-Message-State: ACgBeo3F29n756widdu1DU8yt50UhLGCHIlwnSCL2e8CSdQeIKnMWq1Q
        LsGwUtxavstBd+q37uAeZQ==
X-Google-Smtp-Source: AA6agR47+EjReEzIB4sp12jVe0PEjtgf7L/ATJqstogXhzbClxWHyciERfQXiINmgx7Mxoh8x+JmqQ==
X-Received: by 2002:a05:6e02:1a6f:b0:2de:b54a:1ce4 with SMTP id w15-20020a056e021a6f00b002deb54a1ce4mr3250938ilv.284.1659451810001;
        Tue, 02 Aug 2022 07:50:10 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id q11-20020a02cf0b000000b0033f3dd2e7e7sm6481253jar.44.2022.08.02.07.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 07:50:09 -0700 (PDT)
Received: (nullmailer pid 85864 invoked by uid 1000);
        Tue, 02 Aug 2022 14:50:08 -0000
Date:   Tue, 2 Aug 2022 08:50:08 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sameer Pujar <spujar@nvidia.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, perex@perex.cz, tiwai@suse.com,
        kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: dt-bindings: Add sample format conversion
Message-ID: <20220802145008.GB30116-robh@kernel.org>
References: <1659370052-18966-1-git-send-email-spujar@nvidia.com>
 <1659370052-18966-3-git-send-email-spujar@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1659370052-18966-3-git-send-email-spujar@nvidia.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 09:37:31PM +0530, Sameer Pujar wrote:
> Presently "convert-channels" and "convert-rate" DT bindings are available
> for channel and rate fixups respectively.
> 
> Similarly add "convert-sample-format" binding to fixup DAI sample format
> as well. This is added to simple-card and audio-graph based sound cards.

Do you have users for both cases?

> 
> Signed-off-by: Sameer Pujar <spujar@nvidia.com>
> Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  Documentation/devicetree/bindings/sound/audio-graph-port.yaml |  4 ++++
>  Documentation/devicetree/bindings/sound/audio-graph.yaml      |  2 ++
>  Documentation/devicetree/bindings/sound/dai-params.yaml       | 10 ++++++++++
>  Documentation/devicetree/bindings/sound/simple-card.yaml      |  4 ++++
>  4 files changed, 20 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> index 30a644d9..8e64192 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph-port.yaml
> @@ -22,6 +22,8 @@ properties:
>      $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
>    convert-channels:
>      $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
> +  convert-sample-format:
> +    $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
>  
>  patternProperties:
>    "^endpoint(@[0-9a-f]+)?":
> @@ -67,6 +69,8 @@ patternProperties:
>          $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
>        convert-channels:
>          $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
> +      convert-sample-format:
> +        $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
>  
>        dai-tdm-slot-width-map:
>          description: Mapping of sample widths to slot widths. For hardware
> diff --git a/Documentation/devicetree/bindings/sound/audio-graph.yaml b/Documentation/devicetree/bindings/sound/audio-graph.yaml
> index a9cd52e..93ddd55 100644
> --- a/Documentation/devicetree/bindings/sound/audio-graph.yaml
> +++ b/Documentation/devicetree/bindings/sound/audio-graph.yaml
> @@ -30,6 +30,8 @@ properties:
>      $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
>    convert-channels:
>      $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
> +  convert-sample-format:
> +    $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"

Can someone explain why we need these properties defined in 3 different 
locations? That's not a great pattern to continue.

>  
>    pa-gpios:
>      maxItems: 1
> diff --git a/Documentation/devicetree/bindings/sound/dai-params.yaml b/Documentation/devicetree/bindings/sound/dai-params.yaml
> index aae60cb..933957d 100644
> --- a/Documentation/devicetree/bindings/sound/dai-params.yaml
> +++ b/Documentation/devicetree/bindings/sound/dai-params.yaml
> @@ -19,6 +19,16 @@ properties:
>      minimum: 1
>      maximum: 32
>  
> +  dai-sample-format:
> +    description: Audio sample format used by DAI
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum:
> +      - s8
> +      - s16_le
> +      - s24_le
> +      - s24_3le
> +      - s32_le
> +
>    dai-sample-rate:
>      description: Audio sample rate used by DAI
>      $ref: /schemas/types.yaml#/definitions/uint32
> diff --git a/Documentation/devicetree/bindings/sound/simple-card.yaml b/Documentation/devicetree/bindings/sound/simple-card.yaml
> index ab03a2b..ec21190 100644
> --- a/Documentation/devicetree/bindings/sound/simple-card.yaml
> +++ b/Documentation/devicetree/bindings/sound/simple-card.yaml
> @@ -183,6 +183,8 @@ properties:
>      $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
>    simple-audio-card,convert-channels:
>      $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
> +  simple-audio-card,convert-sample-format:

Don't add more properties with 'simple-audio-card,' prefix. That's not a 
pattern we want to be consistent with...

> +    $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
>    simple-audio-card,prefix:
>      $ref: "#/definitions/prefix"
>    simple-audio-card,pin-switches:
> @@ -226,6 +228,8 @@ patternProperties:
>          $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-rate"
>        convert-channels:
>          $ref: "/schemas/sound/dai-params.yaml#/properties/dai-channels"
> +      convert-sample-format:
> +        $ref: "/schemas/sound/dai-params.yaml#/properties/dai-sample-format"
>        prefix:
>          $ref: "#/definitions/prefix"
>        pin-switches:
> -- 
> 2.7.4
> 
> 
