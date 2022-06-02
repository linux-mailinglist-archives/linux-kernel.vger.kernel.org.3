Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E8A53BA33
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 15:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235621AbiFBN4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 09:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiFBN4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 09:56:07 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E65176D46;
        Thu,  2 Jun 2022 06:56:06 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f16a3e0529so6842616fac.2;
        Thu, 02 Jun 2022 06:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ItU4+oZlqrhVsTFDZffq1bHsfD8LPaRiGahfhp8yC6g=;
        b=N2ctTcfyN5uG8FdwmwhEY0l1YnhGlGLA+yYeChQIhiJoRHmngGgJR7e2ROsusehLMP
         S5DeeQf9RiNWMy0T67hlcnQVRvPrSJ40DtwCYKK8057sPlBgLI6/VFAaeRU5zWhKC9AL
         KlmNdKE/s9d/j9koTDbNOMjriM9+hTtThZM0YM44Fx88QMM2V4oZsRagQl97eBpDde1d
         WnwEkZTkQ00xoMvmfz3BOmHN5h3wAYiHj0nmkFjy4jwYDhwwI+c2cfrIrd00UNgPAkUV
         OYnL3V/YaCnE0sQ12C3WbBc+JhNUmWM58E47bYmPvtDE1gGPe1AaKr0yRkObKbVQlANa
         fuFg==
X-Gm-Message-State: AOAM533J+eN9SUXPrvsfrw6pZWAmRyJnveOStlVuRShpUfa1gbPOWByx
        FfIDMKb3e7NUWCG6ZTqkAg==
X-Google-Smtp-Source: ABdhPJxg9znekohzZ8yCO9gbFG1TwRG0wCp2dzp7Q9YlFVk8Z/w1M4q2XVJue+i1UtPEKiJWdkNyqA==
X-Received: by 2002:a05:6870:4799:b0:f1:46f8:6ea4 with SMTP id c25-20020a056870479900b000f146f86ea4mr2783044oaq.223.1654178165323;
        Thu, 02 Jun 2022 06:56:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id f3-20020a05680807c300b00325cda1ffa8sm2212823oij.39.2022.06.02.06.56.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 06:56:04 -0700 (PDT)
Received: (nullmailer pid 2197386 invoked by uid 1000);
        Thu, 02 Jun 2022 13:56:04 -0000
Date:   Thu, 2 Jun 2022 08:56:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     ChiYuan Huang <u0084500@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        jingoohan1@gmail.com, Pavel Machek <pavel@ucw.cz>, deller@gmx.de,
        cy_huang <cy_huang@richtek.com>, lucas_tsai@richtek.com,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: backlight: rt4831: Add the new property
 for ocp level selection
Message-ID: <20220602135604.GA2194286-robh@kernel.org>
References: <1653534995-30794-1-git-send-email-u0084500@gmail.com>
 <1653534995-30794-2-git-send-email-u0084500@gmail.com>
 <1c7ab94c-a736-c629-bd8c-8a974803e2b9@linaro.org>
 <CADiBU39jZ6TdYZoH80m4R-X2_fUXZOvDA4yUd_TQdPzBJLE+JA@mail.gmail.com>
 <076d53d3-6062-686f-8e45-14c5f936bbf6@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <076d53d3-6062-686f-8e45-14c5f936bbf6@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 12:32:12PM +0200, Krzysztof Kozlowski wrote:
> On 26/05/2022 10:13, ChiYuan Huang wrote:
> > Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 於 2022年5月26日 週四 下午4:06寫道：
> >>
> >> On 26/05/2022 05:16, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Add the new property for ocp level selection.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>>  .../bindings/leds/backlight/richtek,rt4831-backlight.yaml         | 8 ++++++++
> >>>  include/dt-bindings/leds/rt4831-backlight.h                       | 5 +++++
> >>>  2 files changed, 13 insertions(+)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> >>> index e0ac686..c1c59de 100644
> >>> --- a/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> >>> +++ b/Documentation/devicetree/bindings/leds/backlight/richtek,rt4831-backlight.yaml
> >>> @@ -47,6 +47,14 @@ properties:
> >>>      minimum: 0
> >>>      maximum: 3
> >>>
> >>> +  richtek,bled-ocp-sel:
> >>
> >> Skip "sel" as it is a shortcut of selection. Name instead:
> >> "richtek,backlight-ocp"
> >>
> > OK, if so, do I need to rename all properties from 'bled' to 'backlight' ?
> > If  only this property is naming as 'backlight'. it may conflict with
> > the others like as "richtek,bled-ovp-sel".
> 
> Ah, no, no need.
> 
> >>
> >>> +    description: |
> >>> +      Backlight OCP level selection, currently support 0.9A/1.2A/1.5A/1.8A
> >>
> >> Could you explain here what is OCP (unfold the acronym)?
> > Yes. And the full name is 'over current protection'.
> 
> Thanks and this leads to second thing - you encode register value
> instead of logical value. This must be a logical value in mA, so
> "richtek,bled-ocp-microamp".

We already have common properties for setting current of LEDs. We should 
use that here I think.

Rob
