Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47F7E528972
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245573AbiEPQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245534AbiEPQDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:03:31 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7658338B3;
        Mon, 16 May 2022 09:03:30 -0700 (PDT)
Received: by mail-ot1-f41.google.com with SMTP id m6-20020a05683023a600b0060612720715so10347789ots.10;
        Mon, 16 May 2022 09:03:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SzDio8XAI8nlBFG5iUOWW20ONgOCFkCak39qfWjf874=;
        b=HnBghAviZipKJRBivLAPOpv2WG3nl6+x0vh4uA4gY8krHZ8gMhgYGxHmghD3xYc2+k
         PloKDpgjBR812LiQ+92bWTyCKj2xBCQlTT1v7RTIQhBVCbGuF6HfsqZaHlGFS4PERthc
         5rPcOtMQrn0fW/eEd+JOh9v/36Q0sGCHFOZ6StYYOMsJjsKXDPnuwkN7i2pkgfey8tY5
         qQZRcsWCKl7Gyz4x7kNDYJXVG8lWwMvzV7K15hy1LPHRJjIsk2FnsHJumVjCUvx0d7WW
         atzLfNei7L6tUaw9D7fGdUC4gLo7foXA7x7VbPwVgb0eDp36RapOK5mb4Nlh9CfiK1PG
         JuTw==
X-Gm-Message-State: AOAM532MjJKqJ2TX80mxWegZXJVZsCnq+8kh31XL/cGtTdqgSbXbKc1V
        cTKCObVWhLmkZ5ed2qQwTg==
X-Google-Smtp-Source: ABdhPJxCVtmAolhbJ0fmzBUmzA+qG5NqVCHP9ys53Ul5bQx6uPg33wJGiivCjzr/GhgOwo+VDT9gdg==
X-Received: by 2002:a9d:da5:0:b0:605:e8e2:1706 with SMTP id 34-20020a9d0da5000000b00605e8e21706mr6102309ots.317.1652717010094;
        Mon, 16 May 2022 09:03:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id e24-20020a9d5618000000b006060322125fsm4121077oti.47.2022.05.16.09.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:03:29 -0700 (PDT)
Received: (nullmailer pid 2733520 invoked by uid 1000);
        Mon, 16 May 2022 16:03:28 -0000
Date:   Mon, 16 May 2022 11:03:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     marijn.suijten@somainline.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, konrad.dybcio@somainline.org,
        phone-devel@vger.kernel.org, kernel@collabora.com,
        bgolaszewski@baylibre.com, p.zabel@pengutronix.de,
        robh+dt@kernel.org, weiyi.lu@mediatek.com, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, paul.bouchara@somainline.org,
        fparent@baylibre.com, ikjn@chromium.org, jason-jh.lin@mediatek.com,
        krzysztof.kozlowski+dt@linaro.org, rex-bc.chen@mediatek.com,
        ~postmarketos/upstreaming@lists.sr.ht, wenst@chromium.org,
        tinghan.shen@mediatek.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, sam.shih@mediatek.com,
        martin.botka@somainline.org, y.oudjana@protonmail.com,
        miles.chen@mediatek.com, matthias.bgg@gmail.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, ck.hu@mediatek.com
Subject: Re: [PATCH 1/5] dt-bindings: mediatek: Document MT6795 system
 controllers bindings
Message-ID: <20220516160328.GA2733482-robh@kernel.org>
References: <20220513165050.500831-1-angelogioacchino.delregno@collabora.com>
 <20220513165050.500831-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513165050.500831-2-angelogioacchino.delregno@collabora.com>
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

On Fri, 13 May 2022 18:50:46 +0200, AngeloGioacchino Del Regno wrote:
> Document the MediaTek Helio X10 (MT6795) bindings for the apmixedsys,
> infracfg, topckgen, pericfg and mmsys system controllers.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml     | 2 ++
>  .../devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml        | 1 +
>  .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml      | 1 +
>  .../devicetree/bindings/clock/mediatek,apmixedsys.yaml          | 1 +
>  Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml  | 1 +
>  5 files changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
