Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB85254EC8D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379177AbiFPV2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379114AbiFPV2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:28:18 -0400
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84BC21820;
        Thu, 16 Jun 2022 14:28:16 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id a15so1774160ilq.12;
        Thu, 16 Jun 2022 14:28:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p2fPALb1JPQ4AHcfCxgMf5Jxk8npv4hWtBM7JpKyakw=;
        b=xXBw8olggW/EFG3gxIajH9Cyw3KXzKU2WDukiTr4xdXjOVT3nI1brjXLefTc1cUg3m
         BXiMqQKDlCHk7Q3KvIdd9y27NkLm9Ch8AEGjcN0PBzKvBC06bFiail1SXoZhOft0g+I2
         uALKqYXn3YOnCx4RH7jXA9zLBh6SlowvIOmkqKYhpyasBYUpBPDOCptQpQ6Mi8ospTIm
         AvghNzUSga4Y9gyLc2Hlns6XR8bJsDccPxZ9qS3fpSi2jBt8VlrqP4Pmv/e2N/bNsjfM
         IwOVp1GakJYPBAtqhkF8qfIUd4rtD+Map7cOjLFbegNQHYpCMmUQQ8+4WsoEsoslbIA5
         /KpQ==
X-Gm-Message-State: AJIora8OvREZqWa+VJ51BAvoXn72DOblqvetfILd55EPI5znZeZMAp4j
        RjC4vMIw6vh24TqsMYtuMw==
X-Google-Smtp-Source: AGRyM1vXz8zr1qepnCDtLqZTRG9xKb9gNBJydHo8HDS0dVqWruV80818zrXGU2iTTEoR7y/TLi/J4w==
X-Received: by 2002:a05:6e02:1bc8:b0:2d4:342:9c68 with SMTP id x8-20020a056e021bc800b002d403429c68mr4075981ilv.254.1655414896016;
        Thu, 16 Jun 2022 14:28:16 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id j8-20020a02a688000000b003314f874ac8sm1357939jam.36.2022.06.16.14.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 14:28:15 -0700 (PDT)
Received: (nullmailer pid 4024739 invoked by uid 1000);
        Thu, 16 Jun 2022 21:28:13 -0000
Date:   Thu, 16 Jun 2022 15:28:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de, daniel@ffwll.ch,
        krzysztof.kozlowski+dt@linaro.org, mripard@kernel.org,
        tzimmermann@suse.de, matthias.bgg@gmail.com, deller@gmx.de,
        airlied@linux.ie, msp@baylibre.com, granquet@baylibre.com,
        jitao.shi@mediatek.com, wenst@chromium.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fbdev@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v11 01/10] dt-bindings: mediatek,dp: Add Display Port
 binding
Message-ID: <20220616212813.GA3991754-robh@kernel.org>
References: <20220610105522.13449-1-rex-bc.chen@mediatek.com>
 <20220610105522.13449-2-rex-bc.chen@mediatek.com>
 <20220614202336.GA2400714-robh@kernel.org>
 <aeebb6879d62865f8baf037e541c568eb9310f23.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeebb6879d62865f8baf037e541c568eb9310f23.camel@mediatek.com>
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

On Thu, Jun 16, 2022 at 09:22:16PM +0800, Rex-BC Chen wrote:
> On Tue, 2022-06-14 at 14:23 -0600, Rob Herring wrote:
> > On Fri, Jun 10, 2022 at 06:55:13PM +0800, Bo-Chen Chen wrote:
> > > From: Markus Schneider-Pargmann <msp@baylibre.com>
> > > 
> > > This controller is present on several mediatek hardware. Currently
> > > mt8195 and mt8395 have this controller without a functional
> > > difference,
> > > so only one compatible field is added.
> > > 
> > > The controller can have two forms, as a normal display port and as
> > > an
> > > embedded display port.
> > > 
> > > Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> > > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > > [Bo-Chen: Fix reviewers' comment]
> > > Signed-off-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> > > ---
> > >  .../display/mediatek/mediatek,dp.yaml         | 101
> > > ++++++++++++++++++
> > >  1 file changed, 101 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/mediatek/mediatek,dp.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya
> > > ml
> > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya
> > > ml
> > > new file mode 100644
> > > index 000000000000..10f50a0dcf49
> > > --- /dev/null
> > > +++
> > > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dp.ya
> > > ml
> > > @@ -0,0 +1,101 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: 
> > > https://urldefense.com/v3/__http://devicetree.org/schemas/display/mediatek/mediatek,dp.yaml*__;Iw!!CTRNKA9wMg0ARbw!yqAl1KhfbHqHN7-5aeqhzqeOVhPU_Z5beko5q-y-s5pcfp1WL5oVGvY5UF4EfWm4PWjc5mjBwyBUMsr_RI45ipbhsw$
> > >  
> > > +$schema: 
> > > https://urldefense.com/v3/__http://devicetree.org/meta-schemas/core.yaml*__;Iw!!CTRNKA9wMg0ARbw!yqAl1KhfbHqHN7-5aeqhzqeOVhPU_Z5beko5q-y-s5pcfp1WL5oVGvY5UF4EfWm4PWjc5mjBwyBUMsr_RI5WzYKENQ$
> > >  
> > > +
> > > +title: MediaTek Display Port Controller
> > > +
> > > +maintainers:
> > > +  - Chun-Kuang Hu <chunkuang.hu@kernel.org>
> > > +  - Jitao shi <jitao.shi@mediatek.com>
> > > +
> > > +description: |
> > > +  Device tree bindings for the MediaTek display port and
> > > +  embedded display port controller present on some MediaTek SoCs.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt8195-dp-tx
> > > +      - mediatek,mt8195-edp-tx
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  nvmem-cells:
> > > +    maxItems: 1
> > > +    description: efuse data for display port calibration
> > > +
> > > +  nvmem-cell-names:
> > > +    const: dp_calibration_data
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Input endpoint of the controller, usually
> > > dp_intf
> > > +
> > > +      port@1:
> > > +        $ref: /schemas/graph.yaml#/properties/port
> > > +        description: Output endpoint of the controller
> > > +
> > > +    required:
> > > +      - port@0
> > > +      - port@1
> > > +
> > > +  max-lanes:
> > > +    maxItems: 1
> > > +    description: maximum number of lanes supported by the
> > > hardware.
> > 
> > We already have a 'data-lanes' property defined in 
> > 'video-interfaces.yaml' that can serve this purpose.
> > 
> 
> Hello Rob,
> 
> Thanks for review.
> From the description of video-interfaces.yaml, I think it's not quite
> match what we need. We only need this value be one of "1,2,4".

data-lanes = <0>;
data-lanes = <0 1>;
data-lanes = <0 1 2 3>;

Limiting the number of lanes to something less than the max is exactly 
how this property is used in addition to being able to show the mapping 
of lanes.

Rob
