Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B6F4CD80E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239520AbiCDPiL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:38:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiCDPiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:38:09 -0500
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E98C1C60F4;
        Fri,  4 Mar 2022 07:37:22 -0800 (PST)
Received: by mail-oi1-f172.google.com with SMTP id 12so8135620oix.12;
        Fri, 04 Mar 2022 07:37:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PACe0xmx6r81EAuaFyvZQyZNTfONIujSTfg4d0qd68c=;
        b=vpukUqwii8CHpeNsgD5/uQWrqDEyOCWdzc6fAFEfyJt6X/jct52/6QihjbY55vEIic
         aRsklFMl0Xjup4jcyzx93Qi7EOV02xNJlNo4SUx/AcmURR6/usrmX/eyAvCGCJAg7VJj
         otjc7IEwAFLZ4RJXiAPLrIbyen6iDGG2jFiyx+7Z52w/jqJ+y4w1+OayenbxxkC1j902
         ru4+hHUX/WBl6rRHXBq4OlvKeXzI82293ToiQiz12vmN2kFkSLqdz8agNH44L+b9MmbE
         fyuCtL3h4clNruoOiOep27uen8Clr2Pzf09r2UstGxnpUwEHH1ohI266pUZclPbmLXeT
         mZ3A==
X-Gm-Message-State: AOAM533s8Uh7uv7cXUEjJ9lHiFrfrI5oGatfMab67tCF6sr/4iatTqTx
        H8jMJLEEU2ahSD0T1vovfQ==
X-Google-Smtp-Source: ABdhPJyof2S988VwMuNZcB9U5XecU80emaNMSFoZxgT+mxIr6cGyJM+vro5tIuRKk2C7lcM5e49grw==
X-Received: by 2002:a05:6808:1301:b0:2d5:4226:87e4 with SMTP id y1-20020a056808130100b002d5422687e4mr9716207oiv.136.1646408241690;
        Fri, 04 Mar 2022 07:37:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id m26-20020a05680806da00b002d797266870sm2690848oih.9.2022.03.04.07.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:37:21 -0800 (PST)
Received: (nullmailer pid 3983773 invoked by uid 1000);
        Fri, 04 Mar 2022 15:37:19 -0000
Date:   Fri, 4 Mar 2022 09:37:19 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        chunkuang.hu@kernel.org, jitao.shi@mediatek.com,
        matthias.bgg@gmail.com, mcoquelin.stm32@gmail.com,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski@canonical.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alexandre.torgue@foss.st.com,
        ck.hu@mediatek.com, linux-stm32@st-md-mailman.stormreply.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        devicetree@vger.kernel.org, jason-jh.lin@mediatek.com
Subject: Re: [PATCH 1/3] dt-bindings: display: mediatek,mutex: Fix
 mediatek,gce-events type
Message-ID: <YiIyL+Vd1zWiDKbm@robh.at.kernel.org>
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
 <20220304095458.12409-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304095458.12409-2-angelogioacchino.delregno@collabora.com>
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

On Fri, 04 Mar 2022 10:54:56 +0100, AngeloGioacchino Del Regno wrote:
> The mediatek,gce-events property needs as value an array of uint32
> corresponding to the CMDQ events to listen to, and not any phandle.
> 
> Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,mutex.yaml    | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
