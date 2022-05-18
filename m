Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDD152AF39
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 02:36:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbiERAgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 20:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbiERAge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 20:36:34 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9837D220CC;
        Tue, 17 May 2022 17:36:33 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id r1so902295oie.4;
        Tue, 17 May 2022 17:36:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=g3fk2r+VdltCJs0tLhP3Og3NkDOH8LnSswk63V92fI0=;
        b=jGnqSwHGjwgh7uBH78vGPskzlXCNr7BYzD3gyYl7wUb/bx1oT0W93HToq3RAfaY5Yx
         2PIOV+75qVGOQqxW7QCUkh/GJESdlUILN2eB+/k+TEk7BWERnHHOuja8M63eYRicXXwT
         POemr26MCJxYrad3Bje5LfHf/2azNZsEYD9nU/QOe0t7HXMS8rrW3Fe7UNdZEb5IMEiG
         6mqOIyhFd0Exig/QrFtDAw6IfDqzzr95iXF/t3qf1cK1UYWi/oBKX1ou2zRPCLMdBfb0
         ZeAr8qf7Nxs3o9keSxLIPc68FbU6pmfNvgWytz67XQjhfLfrH1YJdWw+PTbgHTtkHu9K
         lpSw==
X-Gm-Message-State: AOAM530jct4LXYvPUFcsZD5vQVzLAvinATVCFGeWQcudwN/KR1Vwq8iw
        ptH1aYM2jLZMUG85ZdLTj0WqS0HQRQ==
X-Google-Smtp-Source: ABdhPJzn9MyNf0yAEImhtz5Vy7C/Luds182CEZZVvFMqqdR4rHl5Uc2AY+2a3qIN5fLX5xwtyFrOOA==
X-Received: by 2002:a05:6808:1244:b0:322:6925:3f4f with SMTP id o4-20020a056808124400b0032269253f4fmr17196680oiv.39.1652834192947;
        Tue, 17 May 2022 17:36:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z3-20020a056870d68300b000e686d13897sm439885oap.49.2022.05.17.17.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 17:36:32 -0700 (PDT)
Received: (nullmailer pid 1950589 invoked by uid 1000);
        Wed, 18 May 2022 00:36:31 -0000
Date:   Tue, 17 May 2022 19:36:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, phone-devel@vger.kernel.org,
        kernel@collabora.com, matthias.bgg@gmail.com,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-mediatek@lists.infradead.org, marijn.suijten@somainline.org,
        yong.wu@mediatek.com, paul.bouchara@somainline.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v2 1/2] dt-bindings: memory: mtk-smi: Add MT6795 Helio
 X10 bindings
Message-ID: <20220518003631.GA1950529-robh@kernel.org>
References: <20220513150633.387200-1-angelogioacchino.delregno@collabora.com>
 <20220513150633.387200-2-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513150633.387200-2-angelogioacchino.delregno@collabora.com>
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

On Fri, 13 May 2022 17:06:32 +0200, AngeloGioacchino Del Regno wrote:
> Add SMI bindings for the MediaTek Helio X10 (MT6795) SoC
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml         | 1 +
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml           | 1 +
>  2 files changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
