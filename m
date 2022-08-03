Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 113D95888AC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 10:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237415AbiHCIVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 04:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237315AbiHCIV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 04:21:27 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A369B26D1;
        Wed,  3 Aug 2022 01:21:23 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 06202840A6;
        Wed,  3 Aug 2022 10:21:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1659514881;
        bh=PYESAQiUch5YKqUXs3LmKbcK3itp+947LQclzoggae8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Zwu8wAmSjAUG8H6pkh+mRzLR0yxEBscCZPjBjFv/94n/to/hQTUAauG5U5orjWu5q
         +V2TfAhB7z9ymbaHE/PYCF3m5PaMtbHiwElMDOLJk2pWiQNcMYViCQa82QcPD6sWm3
         XmmcgPs/jd6qIHzFCEUjaCw86/D0PfonLOYHCWZrI8SpHeK2gLjGGnwOL+rCehTM16
         /WSmNGDuK3hti6mBuiAWVQaOBt8UL2Q3YPzEX95sEKq6U82tY5arqJbMIalb0ctV+m
         OX27GC1hGGoq/JZ0AMFfy0wxVC9fWvdTFgNdB7dDX6dPeFGoe6zM+J9PnqafdczpZB
         aU66emVERFQSA==
Message-ID: <7e30f558-d42e-9751-7729-f0422f3926fa@denx.de>
Date:   Wed, 3 Aug 2022 10:21:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v3 2/4] dt-bindings: display: add new bus-format property
 for panel-dpi
Content-Language: en-US
To:     Max Krummenacher <max.oss.09@gmail.com>,
        max.krummenacher@toradex.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20220628181838.2031-1-max.oss.09@gmail.com>
 <20220628181838.2031-3-max.oss.09@gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220628181838.2031-3-max.oss.09@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 20:18, Max Krummenacher wrote:

Hello Max,

[...]

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> index dae0676b5c6e..52f5db03b6a8 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> @@ -26,7 +26,28 @@ properties:
>     height-mm: true
>     label: true
>     panel-timing: true
> -  port: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    description:
> +      Input port node, receives the panel data.
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +
> +        properties:
> +          bus-format:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0x1001
> +            maximum: 0x1fff
> +            description: |
> +              Describes how the display panel is connected to the display interface.
> +              Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
> +              The mapping between the color/significance of the panel lines to the
> +              parallel data lines are defined in:
> +              https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats

I am not sure whether I should re-open this discussion, but I still 
wonder, wouldn't it be better to describe the DPI bus color channel 
ordering (RGB, BGR, ...), width of each color channel in bits, pixel 
format (RGB, YUV, ...) instead of using specific constants for the 
entire format ?
