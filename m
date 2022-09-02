Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A97C5AB81C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 20:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbiIBST5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 14:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiIBSTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 14:19:53 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB3B558B64;
        Fri,  2 Sep 2022 11:19:51 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-11eb44f520dso6658121fac.10;
        Fri, 02 Sep 2022 11:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DFYj3SzmCSDPlkEMmdzkWyN5W3U24WerlpydHPBUtDY=;
        b=bNU3fVUaRreSii84DwM62FmQok25C8MdFA1cxTAzsmEjyFXMzK6DBhFahDx1ijMhja
         0tnSoN7gMKnCkhXxcz42fNZNReHjfRBP7WHzcVoFS6DAJ8E17iREXRGvT6tGO3KcopPS
         9SdxJAGS35kaM7wXCQCTL7Rv8KNo4EqeLso8TfFwum7Khn9za9pVJTLN9nl7i9O/9992
         jF+q3ikXF8upjJ0YMRnODbPHdf6E/WoO4BZ+Hr1mu+ULN+w0vD6DYhUuHjU6qP9Zmu9P
         4Bib8hf2Kru0D3xh32KhhZafRla9NaLklundn0kofP9iOfQMql5tK3Tlg5pauOAPE19m
         ZBcQ==
X-Gm-Message-State: ACgBeo0/TMRM1bCixrb9ysTERfrAcNBXcjgDcWnUWwZ9JE8sGwtyWELq
        0UHiBWgnyZoPaexCl+1guw==
X-Google-Smtp-Source: AA6agR7NieM49Immp0yg7zhLlvCYsYHzsJ8oBKkIeFWd8pV9cIX90lhfljoXMzPYm2bpuDTyyvOK3A==
X-Received: by 2002:a05:6870:8090:b0:122:7289:bd59 with SMTP id q16-20020a056870809000b001227289bd59mr2954932oab.284.1662142790802;
        Fri, 02 Sep 2022 11:19:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 22-20020aca0916000000b00344adbc3492sm1238492oij.24.2022.09.02.11.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 11:19:50 -0700 (PDT)
Received: (nullmailer pid 173081 invoked by uid 1000);
        Fri, 02 Sep 2022 18:19:49 -0000
Date:   Fri, 2 Sep 2022 13:19:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, maoguang.meng@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        nicolas.dufresne@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        kyrie wu <kyrie.wu@mediatek.com>,
        angelogioacchino.delregno@collabora.com,
        Tomasz Figa <tfiga@chromium.org>, linux-kernel@vger.kernel.org,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>, wenst@chromium.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, xia.jiang@mediatek.com
Subject: Re: [V13,1/7] dt-bindings: mediatek: Add mediatek, mt8195-jpgenc
 compatible
Message-ID: <20220902181949.GA173040-robh@kernel.org>
References: <20220826092956.10340-1-irui.wang@mediatek.com>
 <20220826092956.10340-2-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826092956.10340-2-irui.wang@mediatek.com>
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

On Fri, 26 Aug 2022 17:29:50 +0800, Irui Wang wrote:
> From: kyrie wu <kyrie.wu@mediatek.com>
> 
> Add mediatek,mt8195-jpgenc compatible to binding document.
> 
> Signed-off-by: kyrie wu <kyrie.wu@mediatek.com>
> Signed-off-by: irui wang <irui.wang@mediatek.com>
> ---
>  .../media/mediatek,mt8195-jpegenc.yaml        | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/media/mediatek,mt8195-jpegenc.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
