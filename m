Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E31C8598780
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245061AbiHRP3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344351AbiHRP3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:29:19 -0400
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D88F2DEC;
        Thu, 18 Aug 2022 08:29:18 -0700 (PDT)
Received: by mail-oo1-f53.google.com with SMTP id x7-20020a4aaf47000000b0044884ebb925so414766oon.2;
        Thu, 18 Aug 2022 08:29:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=bSswJuC75R6XDrPIU1WtI9zMLCP/ryjDK45Y39QAIBs=;
        b=WVLz0ZhteIVm8DwmWZJCFDReaQFtEKLr4YOfY6pPUkOM3wueITItVW8yGEUJ/WBW9A
         7FYiF6lIMhlkVUcXYrIUWzsfmUtiVZbikXj/itp9CWQAt0M2/m43S9brEFKjQB/VN80V
         pmv/4NqyLFWq+vS35tC7geqg1GhFMJfd8vadyGyoiQbJxNFN4QNYMVwIDtfWB/60ZMDI
         TLQBuJKPP1hF8My7yA+apaBW8/dVPfC0pD60lzv5DEqGkXylaFlJQC2j/DcrzF7Vv76T
         QXs70w2yPbt5dbmcSXHZSNYnza4VVsyZW7zzy/fVgUKJ8wtW/D/v2KTXJu8vZ5De3SFn
         ZXPw==
X-Gm-Message-State: ACgBeo01pPEvsvUsnwm8AFe+UckUDFHmd/UeEKtNTKsgAlWngaZF6KAF
        JHrRZFXW1bpdJuaSPV0ay2toxM2ZYA==
X-Google-Smtp-Source: AA6agR7xwZCJnyPO6SbLNaIEgg5t/Izwz4ra7rD9omGf98iEzXjjM8IaFZpVK/cbz/Gbp8B4CH9v3Q==
X-Received: by 2002:a4a:e54e:0:b0:44a:fb57:7022 with SMTP id s14-20020a4ae54e000000b0044afb577022mr617657oot.91.1660836557832;
        Thu, 18 Aug 2022 08:29:17 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:5fe0:b4f5:6e22:4704:df60:73a3])
        by smtp.gmail.com with ESMTPSA id g128-20020a4a5b86000000b004489258c9d2sm371872oob.2.2022.08.18.08.29.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 08:29:16 -0700 (PDT)
Received: (nullmailer pid 1902294 invoked by uid 1000);
        Thu, 18 Aug 2022 15:29:14 -0000
Date:   Thu, 18 Aug 2022 09:29:14 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Chengci.Xu" <chengci.xu@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        yi.kuo@mediatek.com, anthony.huang@mediatek.com,
        wendy-st.lin@mediatek.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: memory: mediatek: Add mt8188 smi
 binding
Message-ID: <20220818152914.GO1829017-robh@kernel.org>
References: <20220817124608.10062-1-chengci.xu@mediatek.com>
 <20220817124608.10062-2-chengci.xu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817124608.10062-2-chengci.xu@mediatek.com>
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

On Wed, Aug 17, 2022 at 08:46:05PM +0800, Chengci.Xu wrote:
> Add mt8188 smi supporting in the bindings.
> 
> In mt8188, there are two smi-common HW, one is for vdo(video output),
> the other is for vpp(video processing pipe). They connect with different
> smi-larbs, then some setting(bus_sel) is different. Differentiate them
> with the compatible string.
> 
> Something like this:
> 
>    IOMMU(VDO)          IOMMU(VPP)
>        |                   |
> SMI_COMMON_VDO       SMI_COMMON_VPP
> ----------------     ----------------
>    |     |   ...       |     |    ...
>  larb0 larb2 ...     larb1 larb3  ...
> 
> Signed-off-by: Chengci.Xu <chengci.xu@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml      | 4 +++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml        | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
