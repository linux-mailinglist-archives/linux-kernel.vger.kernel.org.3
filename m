Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D64A58C9E0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243289AbiHHN4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243273AbiHHN43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:56:29 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 690E7DFC6;
        Mon,  8 Aug 2022 06:56:21 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id w7-20020a056830060700b00636a29e1d37so6499041oti.11;
        Mon, 08 Aug 2022 06:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=7MpufPiEwqIWSMkyna1zV0ThiQO6ldBPgCVBYks6zEc=;
        b=Kwsu0tPQArpLJrXVfS1QRtCrZJghUgXixY2AdivNGt7clwGtzYlVlB3hPgG5o9SGK4
         uBOwOy4/04BYIPJvNvbDHSz0DUS5X6krnwAxKZH5/ZtbxoFtU8uSRqNC9j8jJ7qXXH8b
         5Ih0z94z+YBT6bYImHhyk7AYOy1Z8wQ8qcJJAD73INmJbcxAnZ6lTRw3dyaIFm52F7/g
         3LaoZOmbSWP9+OpaS4+3kag5nWbrARjlnmH3+0d21PWzQuF3dhbqFXqxGJon3wgZztrX
         O+2vRAylTVQCzFB9auTekz5/qLXWsLbSVLiQpzqjfUbWrffw/980sZPHKsFKV2V87Sq7
         0lxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=7MpufPiEwqIWSMkyna1zV0ThiQO6ldBPgCVBYks6zEc=;
        b=CeB5TAJ/Kdy6y36nkgwmXHTdD4tIaxaTDI9hokj69YZqoZn33YwmvPNEumUEQOFM30
         HPAl9GTtk8a8pt8d8LEE6HKsdTJ94k5wUnBqMH+SR5uOEzsc0XnTWtJmpUkQRo7wxyeB
         T+63e5WR/wjfzr1nZk9YVKQ4RfFKv+FvqjiC1d7lm2ygT2HtTHlhx6Ea23oe2a0N9kUn
         NV3vatRgbKEjYl5rPzdtBTh7AOmdAKATXT199GgDrjArCAtytmB6W3VmNSiiWIHinEU1
         5EUWXkgRcDAuOkAi5Vd5LkvKnKVGxb7gDs+4MRMuwVW5WW8M4M9DBTBykCRLK7qrK9oH
         7a2g==
X-Gm-Message-State: ACgBeo2gNM/kib0EgrCvulE8D5FzxFqnAbHyWTlbjMoopVyqFR4lX3Nw
        JFctg0JY15w2N/BY1zMBv/+nb34BiOQ7oZ6LMwFSZ9qw+mk=
X-Google-Smtp-Source: AA6agR4Fz/+Jh+PKEF1AyJjJ+m0XqiL7J7daj/1+TOsuYNLadSf7OpcTSkeX7vYvbMDQdZ19HVHllJYZocy4LLWVhR0=
X-Received: by 2002:a9d:6443:0:b0:61c:7f6b:fef8 with SMTP id
 m3-20020a9d6443000000b0061c7f6bfef8mr6888698otl.319.1659966980579; Mon, 08
 Aug 2022 06:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20220628181838.2031-1-max.oss.09@gmail.com> <20220628181838.2031-3-max.oss.09@gmail.com>
 <7e30f558-d42e-9751-7729-f0422f3926fa@denx.de>
In-Reply-To: <7e30f558-d42e-9751-7729-f0422f3926fa@denx.de>
From:   Max Krummenacher <max.oss.09@gmail.com>
Date:   Mon, 8 Aug 2022 15:56:09 +0200
Message-ID: <CAEHkU3WJ75W0RAtSKECNHmr-KLmZyziPz_t80wFNubxvGvD21g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: display: add new bus-format property
 for panel-dpi
To:     Marek Vasut <marex@denx.de>
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
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek

On Wed, Aug 3, 2022 at 10:21 AM Marek Vasut <marex@denx.de> wrote:
>
> On 6/28/22 20:18, Max Krummenacher wrote:
>
> Hello Max,
>
> [...]
>
> > diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> > index dae0676b5c6e..52f5db03b6a8 100644
> > --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> > +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> > @@ -26,7 +26,28 @@ properties:
> >     height-mm: true
> >     label: true
> >     panel-timing: true
> > -  port: true
> > +
> > +  port:
> > +    $ref: /schemas/graph.yaml#/$defs/port-base
> > +    description:
> > +      Input port node, receives the panel data.
> > +
> > +    properties:
> > +      endpoint:
> > +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> > +
> > +        properties:
> > +          bus-format:
> > +            $ref: /schemas/types.yaml#/definitions/uint32
> > +            minimum: 0x1001
> > +            maximum: 0x1fff
> > +            description: |
> > +              Describes how the display panel is connected to the display interface.
> > +              Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
> > +              The mapping between the color/significance of the panel lines to the
> > +              parallel data lines are defined in:
> > +              https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats
>
> I am not sure whether I should re-open this discussion, but I still
> wonder, wouldn't it be better to describe the DPI bus color channel
> ordering (RGB, BGR, ...), width of each color channel in bits, pixel
> format (RGB, YUV, ...) instead of using specific constants for the
> entire format ?

From a system view it would be hard to define that structure which
will catch any and all future requirements. Assume that there will be
3D panels and they will need an additional depth field. Or in
in addition to RGB data there will be a fourth color component. Or
whatever the panel manufacturers might come up with...
Or consider the Tegra 30 example I brought up in this thread. Tegras can
output RGB666 for 18bit panels, and then use the next 8 bits to extend
to 24bit (Maybe RGB666RGB222 ?).
https://lore.kernel.org/all/71ef1b35301330d0bbb64844247b6c4c2237ad1c.camel@gmail.com/
If such requirements pop up the enumeration can be extended with a new
value without changing the binding in any way, with a structured
approach this will require changed bindings, maybe even with issues
in backward compatibility.

From an implementation perspective for Linux the busformat in code is
currently an enumeration. So one would have to take the device tree
structured busformat and run it through a potentially complicated
function to get to the Linux busformat enumeration value. The final
consumer has no advantage over what is there today.

IMHO a change away from one enumeration value to a structured approach
creates some drawbacks without any obvious advantages.

Comments, other views on that?

Regards
Max
