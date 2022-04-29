Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3D351554E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356153AbiD2UT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238431AbiD2UTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:19:55 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E3C996A6;
        Fri, 29 Apr 2022 13:16:36 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-e93bbb54f9so9186983fac.12;
        Fri, 29 Apr 2022 13:16:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tiOACVbwh67uqkrg+v7LDtn9Slnv0D8m91bpuKh0Ev0=;
        b=toBc/y10DPlIcE3tfihrx4fLzBYFEXYl7iMAJi/bzqkxRv3ELU98btW81e1ljNxhsA
         OgaUFXWEF0GpzVOY5lI51KNe2AgT12MuOEy8xtHnDcXmMTdNWWdyDzt41/rbaqjqvLZp
         YbBiJ+qWAbw84nCcmdsecKl5+1l9TuwSjpAys+XAT1DxZmVKMlUapnitJb1quNu3kv82
         tLtrYY42iaDYBUrIW0LOJeFrPV4pZAIHpBbILtdiCrOUH1ubEsTHUyGK0CfoE9UOuwrd
         jubOXdTE8rwOUMa2zE4AfPnNcC3cnQNN1j6FfHMgFbynPVC3t40hODFZV+v7nEB3HgTU
         KjVA==
X-Gm-Message-State: AOAM533Rci8Ln+nIALgIndNfJuwT+mzDJ1cBexpgxTT9FQbuZQkL6TGD
        EacXSvsTW/faDIOMCAIeuw==
X-Google-Smtp-Source: ABdhPJw2gDKOW+0tcM8RQuwAxxtSJfYernX60ZZrMMDRUED6g9kqv7Imhf1an1clOEIvD5i6uHJTWA==
X-Received: by 2002:a05:6870:e245:b0:de:9321:9ea3 with SMTP id d5-20020a056870e24500b000de93219ea3mr480183oac.79.1651263395259;
        Fri, 29 Apr 2022 13:16:35 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i13-20020a54408d000000b00325cda1ffb9sm67047oii.56.2022.04.29.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 13:16:34 -0700 (PDT)
Received: (nullmailer pid 2793009 invoked by uid 1000);
        Fri, 29 Apr 2022 20:16:33 -0000
Date:   Fri, 29 Apr 2022 15:16:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        tzungbi@google.com, linux-mediatek@lists.infradead.org,
        trevor.wu@mediatek.com, matthias.bgg@gmail.com, aaronyu@google.com,
        julianbraha@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [v4 16/18] dt-bindings: mediatek: mt8186: add
 mt8186-mt6366-da7219-max98357 document
Message-ID: <YmxHoXfpmC2XxReg@robh.at.kernel.org>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-17-jiaxin.yu@mediatek.com>
 <YmqlNV31FrcAyuN9@robh.at.kernel.org>
 <5e400f7ccb3b208a033e2ad8f220331851ff9c7e.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e400f7ccb3b208a033e2ad8f220331851ff9c7e.camel@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 05:40:02PM +0800, Jiaxin Yu wrote:
> On Thu, 2022-04-28 at 09:31 -0500, Rob Herring wrote:
> > On Thu, Apr 28, 2022 at 05:33:53PM +0800, Jiaxin Yu wrote:
> > > Add document for mt8186 board with mt6366, da7219 and max98357.
> > > 
> > > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> > > ---
> > >  .../sound/mt8186-mt6366-da7219-max98357.yaml  | 71
> > > +++++++++++++++++++
> > >  1 file changed, 71 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/sound/mt8186-
> > > mt6366-da7219-max98357.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/sound/mt8186-mt6366-
> > > da7219-max98357.yaml
> > > b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-
> > > max98357.yaml
> > > new file mode 100644
> > > index 000000000000..55e8649f2aea
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/sound/mt8186-mt6366-da7219-
> > > max98357.yaml
> > > @@ -0,0 +1,71 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: 
> > > http://devicetree.org/schemas/sound/mt8186-mt6366-da7219-max98357.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Mediatek MT8186 with MT6366, DA7219 and MAX98357 ASoC sound
> > > card driver
> > > +
> > > +maintainers:
> > > +  - Jiaxin Yu <jiaxin.yu@mediatek.com>
> > > +
> > > +description:
> > > +  This binding describes the MT8186 sound card.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt8186_mt6366_da7219_max98357_sound
> > 
> > s/_/-/
> > 
> Got it.
> > > +
> > > +  mediatek,platform:
> > > +    $ref: "/schemas/types.yaml#/definitions/phandle"
> > > +    description: The phandle of MT8186 ASoC platform.
> > > +
> > > +  headset-codec:
> > > +    type: object
> > 
> >        additionalProperties: false
> Ditto.
> > 
> > > +    properties:
> > > +      sound-dai:
> > > +        $ref: /schemas/types.yaml#/definitions/phandle
> > 
> > sound-dai already has a type, so drop and define how many entries.
> > 
> Ditto.

No need to reply in agreement. Just trim the email instead.

> > > +    properties:
> > > +      sound-dai:
> > > +        minItems: 2
> > > +        maxItems: 3
> > 
> > If more than 1 entry, then you need to define what each one is and
> > the 
> > order. Just like reg, interrupts, clocks, etc.
> > 
> Hi Rob,
> 
> Should I correct them as below?
> 
> ---
> properties:
>   sound-dai:
>     minItems: 2
>     maxItems: 3
>     items:
>       - items:
>           - description: xxx
>           - description: yyy
>           - description: zzz

Drop the outer 'items'. As-is, you are saying you have 1 entry with 3 
cells (1 phandle + 2 arg cells).

Rob
