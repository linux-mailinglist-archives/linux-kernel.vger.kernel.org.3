Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B374678AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381202AbhLCNrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:47:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346278AbhLCNrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:47:08 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEFDC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:43:44 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id r25so11641581edq.7
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=caqYbeB05zXLjGSVGUuCqdI7HQ2llCrRlhq6cVUWiV0=;
        b=Ygqjtiv4kbuWrWiNOsYjnB0ekFqH7NOzoufn67zHKL7N9FW69D0gKais/bI+zxeFF9
         4ahlcOaV35sfw4iwxmvyY5FLR5MMEPmms2RWsMPDd8TMtYLkAIP1wDpMsoF2VylH1eQg
         ZrqJBTF8yfExwx9kJaT8P9KyuHqRku+Smpuns=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=caqYbeB05zXLjGSVGUuCqdI7HQ2llCrRlhq6cVUWiV0=;
        b=hcP+wVW281NF8TVM7bhQk0YpRraRFdG3pWzKmDJCHwllLlIYvl8s2NU92xNxR6YeWq
         zZ1ObX2PcsiRWZLG28URtgnQm1Prg7QB7qZxlOu3rrd0//6XqYZSx3fggEnYn25AgzKa
         lK4RHygzTfAZVB7i+8vPpiUpZ4eF0en7GL4jfUlyEoW/TD2c1FsMPYN8k1G9ZJUYnAlP
         P9lL2cTn7vsiX8Jwikwdj8UR6N5+CQadszPgy8Ls0Wej7I5qJdmlZYz6+XRHH/tS6B98
         g4/miWoQrKg8Kj6eZQnfCRFJeCdtjnojKzH/sTuR2SZsmUNmhg5Qjr382/Zixv2bxBSm
         2w7Q==
X-Gm-Message-State: AOAM532/+iisHxP4tdqgGjojjArGlwPFueIRNCeTlfKt22Upsl18yGAv
        CMjjZ6S2325Hs42JsDjp3sYjuw==
X-Google-Smtp-Source: ABdhPJyCdv61zjdeT962tknIyH1upj+6b4k5awfM5eC95e/jSTjCO3VCvZ+1wiRUefnxexjNqJ3mAg==
X-Received: by 2002:a05:6402:350e:: with SMTP id b14mr27416602edd.313.1638539023238;
        Fri, 03 Dec 2021 05:43:43 -0800 (PST)
Received: from gmail.com ([100.104.168.197])
        by smtp.gmail.com with ESMTPSA id e26sm2041942edr.82.2021.12.03.05.43.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 05:43:43 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:43:25 +0100
From:   Ricardo Ribalda <ribalda@chromium.org>
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com,
        irui.wang@mediatek.com
Subject: Re: [PATCH V6, 1/5] dt-bindings: mediatek: Add mediatek,
 mt8195-jpgenc compatible
Message-ID: <Yaoe/Tk1wMyFoB1s@gmail.com>
References: <1638501230-13417-1-git-send-email-kyrie.wu@mediatek.com>
 <1638501230-13417-2-git-send-email-kyrie.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638501230-13417-2-git-send-email-kyrie.wu@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kyrie.wu wrote:

> Add mediatek, mt8195-jpgenc compatible to binding document
> 
> Signed-off-by: kyrie.wu <kyrie.wu@mediatek.com>
> ---
> V6: no change

Hi Kyrie

Your patch does not seem to apply on top of linus or linus/next.

In linus/next they still have the .txt file:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt?id=7afeac307a9561e3a93682c1e7eb22f918aa1187

What are you using?

Thanks


> ---
>  Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> index fcd9b82..e93ccf5 100644
> --- a/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.yaml
> @@ -18,6 +18,9 @@ properties:
>        - enum:
>            - mediatek,mt2701-jpgenc
>            - mediatek,mt8183-jpgenc
> +          - mediatek,mt8195-jpgenc
> +          - mediatek,mt8195-jpgenc0
> +          - mediatek,mt8195-jpgenc1
>        - const: mediatek,mtk-jpgenc
>    reg:
>      maxItems: 1
> -- 
> 2.6.4
> 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
> 
