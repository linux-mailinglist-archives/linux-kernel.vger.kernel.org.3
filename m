Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 294B855F029
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbiF1VHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:07:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiF1VHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:07:22 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5C463A195;
        Tue, 28 Jun 2022 14:07:20 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id l24so14093253ion.13;
        Tue, 28 Jun 2022 14:07:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EdmVCCaapks5mqyJeNP/LvsCykQThbQW4f2v+GKWiVI=;
        b=luJ0bqm1xTrfmE8BoMNLrxR9JqYYfDFfTLHwVm3QTmMoW5XZ/NJj240R3l8KnBUgwy
         c32CjerCRsJ0z2eKmRRVH/mQVW3YdeCC0ca9M61HDQO2meRBphhdgYmdZqDuQfscQ4hs
         uMffIZZlX3QTEsS4/FKy6/31fZN1Vrq7ly1xeZVVobc6w5qHGmHwjyi35pjRp3Yt9vCc
         du5BTtdbR6kAP3pW4CyLLvJ9NxURzDL+t3A6s0ltBNVLMVVolFASdQEvPg6mBFWsshME
         Eal7Zte+Le3NMK1J6B+ySXeOGOVhmVzc02T68U8ZhvGgobu6pJ1+qNnXhanJC/mEo/4R
         rNrg==
X-Gm-Message-State: AJIora8YHHJc+QcRGxMgt2ScXzCtC97OCHYmEWgjNZLEDy94h24pxOpr
        PPzHZKKdkIGUiqSFSXKYkg==
X-Google-Smtp-Source: AGRyM1uc+XPBhifMAguV92DxPvJZX6j7ZucXINm5C5uMzjXPcIlUdRqzojxywk4dF8WrqVqjSlCHzA==
X-Received: by 2002:a05:6638:2589:b0:333:e976:d0c7 with SMTP id s9-20020a056638258900b00333e976d0c7mr50106jat.16.1656450440054;
        Tue, 28 Jun 2022 14:07:20 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id b28-20020a026f5c000000b0032e70c4e12fsm6614611jae.28.2022.06.28.14.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 14:07:19 -0700 (PDT)
Received: (nullmailer pid 977856 invoked by uid 1000);
        Tue, 28 Jun 2022 21:07:16 -0000
Date:   Tue, 28 Jun 2022 15:07:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Irui Wang <irui.wang@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        angelogioacchino.delregno@collabora.com,
        nicolas.dufresne@collabora.com, wenst@chromium.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
Subject: Re: [RESEND V9,1/7] dt-bindings: mediatek: Add mediatek,
 mt8195-jpgenc compatible
Message-ID: <20220628210716.GA963202-robh@kernel.org>
References: <20220614121024.31667-1-irui.wang@mediatek.com>
 <20220614121024.31667-2-irui.wang@mediatek.com>
 <20220617231139.GA2610098-robh@kernel.org>
 <329eb655ddb503e4327cbe3cffef625bb44630b1.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <329eb655ddb503e4327cbe3cffef625bb44630b1.camel@mediatek.com>
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

On Mon, Jun 20, 2022 at 02:04:38PM +0800, kyrie.wu wrote:
> On Fri, 2022-06-17 at 17:11 -0600, Rob Herring wrote:
> > On Tue, Jun 14, 2022 at 08:10:18PM +0800, Irui Wang wrote:
> > > From: kyrie wu <kyrie.wu@mediatek.com>
> > > 
> > > Add mediatek,mt8195-jpgenc compatible to binding document.
> > > 
> > > Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> > > ---
> > >  .../media/mediatek,mt8195-jpegenc.yaml        | 153
> > > ++++++++++++++++++
> > >  1 file changed, 153 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/media/mediatek,mt8195-
> > > jpegenc.yaml
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/media/mediatek,mt8195-
> > > jpegenc.yaml
> > > b/Documentation/devicetree/bindings/media/mediatek,mt8195-
> > > jpegenc.yaml
> > > new file mode 100644
> > > index 000000000000..a7f9f723d5db
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/mediatek,mt8195-
> > > jpegenc.yaml
> > > @@ -0,0 +1,153 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: 
> > > http://devicetree.org/schemas/media/mediatek,mt8195-jpegenc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: MediaTek JPEG Encoder Device Tree Bindings
> > > +
> > > +maintainers:
> > > +  - kyrie wu <kyrie.wu@mediatek.corp-partner.google.com>
> > > +
> > > +description: |-
> > > +  MediaTek JPEG Encoder is the JPEG encode hardware present in
> > > MediaTek SoCs
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: mediatek,mt8195-jpgenc
> > > +
> > > +  mediatek,jpegenc-multi-core:
> > > +    type: boolean
> > > +    description: |
> > > +      Indicates whether the jpeg encoder has multiple cores or
> > > not.
> > > +
> > > +  power-domains:
> > > +    maxItems: 1
> > > +
> > > +  iommus:
> > > +    maxItems: 4
> > > +    description: |
> > > +      Points to the respective IOMMU block with master port as
> > > argument, see
> > > +      Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > for details.
> > > +      Ports are according to the HW.
> > > +
> > > +  "#address-cells":
> > > +    const: 2
> > > +
> > > +  "#size-cells":
> > > +    const: 2
> > > +
> > > +  ranges: true
> > > +
> > > +# Required child node:
> > > +patternProperties:
> > > +  "^jpgenc@[0-9a-f]+$":
> > > +    type: object
> > > +    description: |
> > > +      The jpeg encoder hardware device node which should be added
> > > as subnodes to
> > > +      the main jpeg node.
> > > +
> > > +    properties:
> > > +      compatible:
> > > +        const: mediatek,mt8195-jpgenc-hw
> > > +
> > > +      reg:
> > > +        maxItems: 1
> > > +
> > > +      hw_id:
> > > +        description: |
> > > +          Current jpegenc hw id.
> > 
> > Same question here. Surely, I asked sometime in the last 8 versions,
> > but 
> > no explanation here and I'm not going to go look for it.
> Dear Rob,
> I'm sorry for not giving an accurate explanation in time.
> The MT8195 has own two encoding hardwares, we use hw_id to 
> represent them.
> hw_id = 0, for hardware 0, and hw_id = 1, repesents another one.
> I will improve the description in the next version.

Why do you care which one is which? 

We generally don't do instance indices in DT, so figure out how not to 
need this.

Rob
