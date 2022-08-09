Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF4C58D1B6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235784AbiHIBZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHIBZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:25:19 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3328CB3B;
        Mon,  8 Aug 2022 18:25:15 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 94CB1845A5;
        Tue,  9 Aug 2022 03:25:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1660008311;
        bh=goK8Xyy9CXnnnf5aAlKG6fKJPnCIUrulzRORKlgOilg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=OJyY+JZVJF8GVtbbz92GXnTeWynqEa2Gfb6K0/BOUVjuV/WpEnqWXxNIrw4CcX1bZ
         3LypYW6m/ynPf82BIJfOSZr4TP+oAbw4yCc2i40BUx34a5LJhKswMymFLhwdfg1LW+
         QFwR549mlYbg5BcDir8gmDt6x1ycjgchvmxFUIo2ygDFOdhj8bH2a3fUOqFmG2Np4e
         8XY5utnnYKQkltJjJYNFFQiTf+/tHsT239xyKvp26bRwgSZXCK//R5qmu4RyszmrTJ
         3J2oIVr+hhVkJnf64RfBAdhy7rEHXdNjtrSBFp0mLarDL6570BzGik6nefc6udnZed
         yjOaHTC4lvbwg==
Message-ID: <aa288917-9841-aab8-0a6a-764b775d8c02@denx.de>
Date:   Tue, 9 Aug 2022 03:25:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v3 2/4] dt-bindings: display: add new bus-format property
 for panel-dpi
Content-Language: en-US
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     max.krummenacher@toradex.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
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
 <7e30f558-d42e-9751-7729-f0422f3926fa@denx.de>
 <CAEHkU3WJ75W0RAtSKECNHmr-KLmZyziPz_t80wFNubxvGvD21g@mail.gmail.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <CAEHkU3WJ75W0RAtSKECNHmr-KLmZyziPz_t80wFNubxvGvD21g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.6 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/22 15:56, Max Krummenacher wrote:
> Hi Marek

Hello Max,

[...]

>>> +        properties:
>>> +          bus-format:
>>> +            $ref: /schemas/types.yaml#/definitions/uint32
>>> +            minimum: 0x1001
>>> +            maximum: 0x1fff
>>> +            description: |
>>> +              Describes how the display panel is connected to the display interface.
>>> +              Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
>>> +              The mapping between the color/significance of the panel lines to the
>>> +              parallel data lines are defined in:
>>> +              https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats
>>
>> I am not sure whether I should re-open this discussion, but I still
>> wonder, wouldn't it be better to describe the DPI bus color channel
>> ordering (RGB, BGR, ...), width of each color channel in bits, pixel
>> format (RGB, YUV, ...) instead of using specific constants for the
>> entire format ?
> 
>>From a system view it would be hard to define that structure which
> will catch any and all future requirements. Assume that there will be
> 3D panels and they will need an additional depth field.

You can very much say you have panels which require Y/U/V color channels 
instead of R/G/B , and then just add more color channels as needed. But 
that -- color channel, their order, offset, bit width, can be described 
rather easily, something like:

color-channel-names = "R", "G", "B";
color-channel-width = <8 8 8>;
color-channel-shift = <16 8 0>;

> Or in
> in addition to RGB data there will be a fourth color component. Or
> whatever the panel manufacturers might come up with...
> Or consider the Tegra 30 example I brought up in this thread. Tegras can
> output RGB666 for 18bit panels, and then use the next 8 bits to extend
> to 24bit (Maybe RGB666RGB222 ?).

I think there are two options here:

1) Look at 'data-lanes' property on DSI ? Both the DSI host and DSI
    device define the 'data-lanes' property per endpoint and they might
    not be the same.

But with DPI, the better option might be:

2) Implement something like LVDS codec, some sort of transparent DPI
    bridge driver which can be defined in DT and represent the "glue"
    wiring adapter between the mismatched DPI source and sink formats.

> https://lore.kernel.org/all/71ef1b35301330d0bbb64844247b6c4c2237ad1c.camel@gmail.com/
> If such requirements pop up the enumeration can be extended with a new
> value without changing the binding in any way, with a structured
> approach this will require changed bindings, maybe even with issues
> in backward compatibility.

If we have 2) which would describe how the DPI wires were connected, 
like "channel R got shifted by two bits, bottom two bits got replicated, 
etc.", then maybe we can avoid introducing new non-standard formats 
altogether ?

>>From an implementation perspective for Linux the busformat in code is
> currently an enumeration. So one would have to take the device tree
> structured busformat and run it through a potentially complicated
> function to get to the Linux busformat enumeration value. The final
> consumer has no advantage over what is there today.
> 
> IMHO a change away from one enumeration value to a structured approach
> creates some drawbacks without any obvious advantages.
> 
> Comments, other views on that?

See above.
