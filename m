Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D485313E2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiEWOIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbiEWOIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:08:18 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D638345043;
        Mon, 23 May 2022 07:08:17 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id q8so17872408oif.13;
        Mon, 23 May 2022 07:08:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c/Revpi/NQeBVLl9e7ZCFj2VurS2hZIRuL3sCTpYBPU=;
        b=h4bKEGPDUv+aqQGhlSd9nSPZ0PS+CNGGXG2Ia49s/D+obo+afWH4klPjn/agbUpFkJ
         3viJ2Ig98DMxJ2YQdmvsuqDdtcCopLmSP83shWp5yWok/4FN0omlPHLUjYtB5Il6EziX
         hvncMkNFF9pvQTMdzY2R90YgF0jqytU11FFIe9hhmFfY0APAQ9PnZ2z6bTMooDCKHoZU
         9lGVj5J6z/JY4yj96iRddMa1/HtatIIfVx3vB1jlo6xwd4tsOgNP5H6LtSAmtDpdOprK
         vB2n3WH4xeKWZ7oDVx1O4rr3jjYqE/rQUzrJHmomYSOr+QmKzHMfzJRF+TpHEi0QtAk6
         LdzA==
X-Gm-Message-State: AOAM530yjFnzw2DmfPoFXP7nDcB/HHwz7OVfC4d0N0y5hR/jO4KAZZaz
        rfFv3ctHzBWzlVy/SJuQvQ==
X-Google-Smtp-Source: ABdhPJzQukjWCQT1QEmWzFgP+OVp9orwtCbowykGqCuwEbqMpR+WgnafwDT9QfD0g/ABT99ODaPCxg==
X-Received: by 2002:a05:6808:1314:b0:328:eb31:99b6 with SMTP id y20-20020a056808131400b00328eb3199b6mr11775397oiv.12.1653314897097;
        Mon, 23 May 2022 07:08:17 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g4-20020a9d6484000000b006060322125asm4025063otl.42.2022.05.23.07.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:08:16 -0700 (PDT)
Received: (nullmailer pid 1515070 invoked by uid 1000);
        Mon, 23 May 2022 14:08:15 -0000
Date:   Mon, 23 May 2022 09:08:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sboyd@kernel.org, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, wenst@chromium.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: arm: mtk-clocks: Set #clock-cells as
 required property
Message-ID: <20220523140815.GA1500210-robh@kernel.org>
References: <20220518093631.25491-1-angelogioacchino.delregno@collabora.com>
 <20220518093631.25491-3-angelogioacchino.delregno@collabora.com>
 <20220520221910.GA348732-robh@kernel.org>
 <288690ac-b23b-92f8-64b4-d994f249f21c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <288690ac-b23b-92f8-64b4-d994f249f21c@linaro.org>
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

On Sat, May 21, 2022 at 04:05:01PM +0200, Krzysztof Kozlowski wrote:
> On 21/05/2022 00:19, Rob Herring wrote:
> > On Wed, May 18, 2022 at 11:36:31AM +0200, AngeloGioacchino Del Regno wrote:
> >> This is a clock-controller binding, so it needs #clock-cells, or
> >> it would be of no use: add that to the list of required properties.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> >> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >> ---
> >>  .../devicetree/bindings/arm/mediatek/mediatek,mt8186-clock.yaml  | 1 +
> >>  .../bindings/arm/mediatek/mediatek,mt8186-sys-clock.yaml         | 1 +
> >>  .../devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml  | 1 +
> >>  .../bindings/arm/mediatek/mediatek,mt8192-sys-clock.yaml         | 1 +
> >>  .../devicetree/bindings/arm/mediatek/mediatek,mt8195-clock.yaml  | 1 +
> >>  .../bindings/arm/mediatek/mediatek,mt8195-sys-clock.yaml         | 1 +
> >>  6 files changed, 6 insertions(+)
> > 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > Wasn't there some discussion about moving these to bindings/clocks/? 
> > Maybe that was another one, it's all a blur...
> 
> Yes, there was such idea although I am not sure if this is worth by
> itself - messes up with the git history.

There shouldn't be too much history since converting to schema. For just 
a move git is smart enough to see across moves.

Rob
