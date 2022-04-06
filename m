Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47B214F6693
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 19:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238679AbiDFRS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 13:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238766AbiDFRSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 13:18:47 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AF64700AB;
        Wed,  6 Apr 2022 08:15:18 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-dacc470e03so3228641fac.5;
        Wed, 06 Apr 2022 08:15:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=RpvtWoojBQC/zAbnCARk8Keu9NdnUbRhNT220URCdbA=;
        b=EOEGO8NauGAvtdE0OdMNWl8TNonpuS+Ggu+eIx+Hb1QQbulRf6UkDx+YJejl1ExZt9
         tCZfgZUjM1alB/8j8UYAIxNxUyacFyRXIeNhs8k3ljPmg5kwAsuCIYzWNpwwommXImSX
         dYKuqmaLZRKmMGJNw7iGhkqRv37AK+2xJTn0PcaS/Zz9fgLYpLYfzvzzPojyBtQukbIt
         YyUlI5vTdfdxQYxeZC1zsgks92o4p8s0antDKZOmntUdnBuf3IIg3PIAQe3DzNCtmh6c
         U63/QNLrXm5vwb7n1srt/xfWPeO3MUbbbpONRd5EONrB0QeKZS9+7ZBqBMAwHB9M0ZSu
         K/kA==
X-Gm-Message-State: AOAM530Xe98SPpVCt8XUXF0/MfLCAFhYFFHQvGFx7ieYk8QjvizlRBKs
        pScfH3Ixx+9oiCPff4B9Mg==
X-Google-Smtp-Source: ABdhPJxPRAU35Z8YAsHokOrrhdeTBPlBAcUIPkn2lyOwPKuqU/qsErcv+UFsS47fLlo/nlTZi7C8HQ==
X-Received: by 2002:a05:6870:1807:b0:d7:2a4c:14b8 with SMTP id t7-20020a056870180700b000d72a4c14b8mr4123400oaf.97.1649258117511;
        Wed, 06 Apr 2022 08:15:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q11-20020a4a330b000000b003289cbe97c6sm6422082ooq.13.2022.04.06.08.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 08:15:16 -0700 (PDT)
Received: (nullmailer pid 2263085 invoked by uid 1000);
        Wed, 06 Apr 2022 15:15:15 -0000
Date:   Wed, 6 Apr 2022 10:15:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>
Cc:     xinlei.lee@mediatek.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        jitao.shi@mediatek.com
Subject: Re: [PATCH v2,1/2] dt-bindings: display: mediatek: dpi: Add
 compatible for MediaTek MT8186
Message-ID: <Yk2ugxQukjPmYbFL@robh.at.kernel.org>
References: <1648727917-3099-1-git-send-email-xinlei.lee@mediatek.com>
 <1648727917-3099-2-git-send-email-xinlei.lee@mediatek.com>
 <e0d5a344c8ec1f92357bd9d5b8782dded862c549.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0d5a344c8ec1f92357bd9d5b8782dded862c549.camel@mediatek.com>
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

On Fri, Apr 01, 2022 at 09:38:20AM +0800, Rex-BC Chen wrote:
> On Thu, 2022-03-31 at 19:58 +0800, xinlei.lee@mediatek.com wrote:
> > From: Xinlei Lee <xinlei.lee@mediatek.com>
> > 
> > Add dt-binding documentation of dpi for MediaTek MT8186 SoC.
> > 
> > Signed-off-by: Xinlei Lee <xinlei.lee@mediatek.com>
> > ---
> >  .../devicetree/bindings/display/mediatek/mediatek,dpi.yaml       | 1
> > +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> > l
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> > l
> > index dd2896a40ff0..a73044c50b5f 100644
> > ---
> > a/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> > l
> > +++
> > b/Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.yam
> > l
> > @@ -22,6 +22,7 @@ properties:
> >        - mediatek,mt7623-dpi
> >        - mediatek,mt8173-dpi
> >        - mediatek,mt8183-dpi
> > +      - mediatek,mt8186-dpi
> >        - mediatek,mt8192-dpi
> >  
> >    reg:
> 
> Hello Xinlei,
> 
> From the dts we use, the dpi node needs other properties for MT8186.
> Please send another patch and add these properties to binding.
> 
> assigned-clocks = <&topckgen CLK_TOP_DPI>;
> assigned-clock-parents = <&topckgen CLK_TOP_TVDPLL_D2>;

Those are always allowed on any node with 'clocks', so no need to add 
them here.

Rob
