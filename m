Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03DEB4CD810
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 16:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240451AbiCDPia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 10:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240458AbiCDPi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 10:38:26 -0500
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1ED62E6;
        Fri,  4 Mar 2022 07:37:36 -0800 (PST)
Received: by mail-ot1-f53.google.com with SMTP id p12-20020a05683019cc00b005af1442c9e9so7712751otp.13;
        Fri, 04 Mar 2022 07:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r+7LdT2y9uXyeXQDCwlxps28MTYEq5fDPijsqcJwyto=;
        b=FE7JCxVUXpUZGI2xsiKBFkyUXyMiyE/EmCcOhFEBItYSKcPW2W9HoXVhld2PejJQ0i
         Id03mnbzFGOpcq14261opqMf+97M4JenpUpRw2iMdSZ0w9qN/fdlWQ4C2nnT72xWuxRs
         zu5BuxMC8BMY102yG1dSoo3HUsV2nbejtwz6XkGM/qeTEW30AFEFOp4CDDId7Ftj0okP
         3b/tIDbHg24xzBWbzCI6ToW7XaBOV7sy3Mojf4nIF0ccGhaIzqbIxYP/DUYDyr+cZ5MG
         Ka7e3FLcIP2NZ+20C/q1eqJIb0tZ9a/c8hXIZLIKpTmL8SD6S3snZp2ti9Z4LdCU/gdr
         ln8w==
X-Gm-Message-State: AOAM531SI/3TXmjMRvZEHF0ZjRTfMXkd/yVziEHCaOakNt2cJZptyYtj
        6xhmmErHTwHUcJ2+t6V+AQ==
X-Google-Smtp-Source: ABdhPJyS8IcggXZIQLqNgBK43mnyO4KB0rLd++CNegRmXhAPHh2bGQ7UVv06ZazIdvDbkatuCV33kw==
X-Received: by 2002:a05:6830:33cf:b0:5af:4018:fc2a with SMTP id q15-20020a05683033cf00b005af4018fc2amr22847666ott.161.1646408255646;
        Fri, 04 Mar 2022 07:37:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l13-20020a056830054d00b005a3cce351a1sm2577422otb.28.2022.03.04.07.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 07:37:34 -0800 (PST)
Received: (nullmailer pid 3984240 invoked by uid 1000);
        Fri, 04 Mar 2022 15:37:33 -0000
Date:   Fri, 4 Mar 2022 09:37:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, matthias.bgg@gmail.com,
        alexandre.torgue@foss.st.com, airlied@linux.ie,
        dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
        ck.hu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        jitao.shi@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com, p.zabel@pengutronix.de,
        jason-jh.lin@mediatek.com, linux-kernel@vger.kernel.org,
        chunkuang.hu@kernel.org, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH 2/3] dt-bindings: display: mediatek,ovl: Fix 'iommu'
 required property typo
Message-ID: <YiIyPUGsH5bxapMS@robh.at.kernel.org>
References: <20220304095458.12409-1-angelogioacchino.delregno@collabora.com>
 <20220304095458.12409-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220304095458.12409-3-angelogioacchino.delregno@collabora.com>
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

On Fri, 04 Mar 2022 10:54:57 +0100, AngeloGioacchino Del Regno wrote:
> The property is called 'iommus' and not 'iommu'. Fix this typo.
> 
> Fixes: 4ed545e7d100 ("dt-bindings: display: mediatek: disp: split each block to individual yaml")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,ovl.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
