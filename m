Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C825F53ADF6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 22:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiFAUq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiFAUoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 16:44:09 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA551EA075;
        Wed,  1 Jun 2022 13:29:08 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-f16a3e0529so4265529fac.2;
        Wed, 01 Jun 2022 13:29:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hM5KF5wCwVdKsYo5M+AgMiM3NVZvgB0creSQpi4bIVM=;
        b=Jz8HlBWgG2oFQHPkRECQYy91Tn26RZe5Kfl4G8j9ZUCSxjflSozgOvRdA3Lnj+b5eT
         K5FzuaA+gFEcM2R+/Of+B1xdaoz4r5K91abdfgtpGgINQzaL/kCHVu8QqhU85Z/D8NV/
         hV7RWUBFrP0E8NdR08bKglKhOUc6BHWLtEyoeaDR9WAws5P7FrO05BoEu1JwuANLV9Nv
         Erxdth6ZkdNm6N8TpmH33r7M7PWi5GNh2TYHwCAHeFNKOJUI4G4R3fmEM74czQOHHfmN
         SlPRmcg9WcpO7pnqGo/I5em3CtAN2UN6DGF7DEOji3tGiyOSXWIHBih8WwJlX6ZeJBTE
         OuFg==
X-Gm-Message-State: AOAM530wJv0OPeCvbwj2p6tNTLG5bJqgkUifPal5TOyMTHvZ7Cr9XJEV
        FXa4yXG3e6G4XhTLUlO0zeJQI14q9Q==
X-Google-Smtp-Source: ABdhPJz/ahrvEIyLaTJn2tdg3qpfcBBKaT+gGiEjPOUSa+SOVMJSI109IsfvmyTNBHZT51qJxtq0fQ==
X-Received: by 2002:a05:6808:15a3:b0:32b:9c85:3434 with SMTP id t35-20020a05680815a300b0032b9c853434mr16880204oiw.118.1654113704350;
        Wed, 01 Jun 2022 13:01:44 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r21-20020a056830081500b0060603221245sm1270062ots.21.2022.06.01.13.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 13:01:44 -0700 (PDT)
Received: (nullmailer pid 338460 invoked by uid 1000);
        Wed, 01 Jun 2022 20:01:43 -0000
Date:   Wed, 1 Jun 2022 15:01:43 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>, yong.wu@mediatek.com,
        joro@8bytes.org, will@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        iommu@lists.linux-foundation.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 1/7] dt-bindings: iommu: mediatek: Add phandles for
 mediatek infra/pericfg
Message-ID: <20220601200143.GA334351-robh@kernel.org>
References: <20220518100503.37279-1-angelogioacchino.delregno@collabora.com>
 <20220518100503.37279-2-angelogioacchino.delregno@collabora.com>
 <4cfbc8dd-83d3-80df-630d-6f8fb2efb9fd@gmail.com>
 <2550039f-1cfc-eb5d-bbc9-bf82666e9abd@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2550039f-1cfc-eb5d-bbc9-bf82666e9abd@collabora.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:42:20PM +0200, AngeloGioacchino Del Regno wrote:
> Il 18/05/22 13:29, Matthias Brugger ha scritto:
> > 
> > 
> > On 18/05/2022 12:04, AngeloGioacchino Del Regno wrote:
> > > Add properties "mediatek,infracfg" and "mediatek,pericfg" to let the
> > > mtk_iommu driver retrieve phandles to the infracfg and pericfg syscon(s)
> > > instead of performing a per-soc compatible lookup.
> > > 
> > > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > > ---
> > >   .../devicetree/bindings/iommu/mediatek,iommu.yaml         | 8 ++++++++
> > >   1 file changed, 8 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > index 2ae3bbad7f1a..c4af41947593 100644
> > > --- a/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > +++ b/Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> > > @@ -101,6 +101,10 @@ properties:
> > >       items:
> > >         - const: bclk
> > > +  mediatek,infracfg:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: The phandle to the mediatek infracfg syscon
> > > +
> > >     mediatek,larbs:
> > >       $ref: /schemas/types.yaml#/definitions/phandle-array
> > >       minItems: 1
> > > @@ -112,6 +116,10 @@ properties:
> > >         Refer to bindings/memory-controllers/mediatek,smi-larb.yaml. It must sort
> > >         according to the local arbiter index, like larb0, larb1, larb2...
> > > +  mediatek,pericfg:
> > > +    $ref: /schemas/types.yaml#/definitions/phandle
> > > +    description: The phandle to the mediatek pericfg syscon
> > > +
> > 
> > I didn't explain myself. What I was suguesting was to squash the patch
> > that add requiered mediatek,infracfg with the patch that adds
> > mediatk,infracfg to the binding description. And then squash the both
> > patches adding pericfg as well.
> 
> Sorry Matthias, I'm not sure ... I think I'm misunderstanding you again...
> ...but if I'm not, I don't think that squashing actual code and bindings together
> is something acceptable?
> 
> I've made that kind of mistake in the past and I was told multiple times that
> dt-bindings changes shall be sent separately from the actual driver changes.

Combine patches 1 and 6 is the suggestion, not driver changes.

Rob
