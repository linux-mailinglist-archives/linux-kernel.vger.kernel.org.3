Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011BF4F1DC8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383065AbiDDVlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380264AbiDDTYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 15:24:54 -0400
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC7CF3B037;
        Mon,  4 Apr 2022 12:22:57 -0700 (PDT)
Received: by mail-oi1-f179.google.com with SMTP id w127so11078382oig.10;
        Mon, 04 Apr 2022 12:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WKBlTF79XqHlzgtuNtv6275CX0xRJ50HbuzrT91tU8g=;
        b=1XzltYTbOqIKgR0+3guu+vdsDTDJKkIRHPN+I1GYsx/C3zOyU/spkYDlprDm+90IH8
         7OA7oYKA4mv1OIJk5HlAsMU6CgD8PvmosneN8qrq6FI/+8oWAMadrkJxhlR9jA0jaDJH
         aolcQu6YNPTVnyCeio3h8yiWvhXsApQ5mezpjHZyim0bLdy19Zx/PJbp15Qdqd1CEByb
         dnnR4izsN+l/Wuk4FRz8d543ToKfCjsac7A0ibs/2/dR/rfmK14aRF+s8sSHaPuZsnFb
         BZ0pPfOLFyoSfh+QPQjFzHAZ5PHf9AO9AaB0nNbcKzOZkUzoG6t2KxA5Y0546Lh2KclS
         KHtQ==
X-Gm-Message-State: AOAM5315zJbgKj3c8PnZJai2B35DqPGDXAq7HG2IWdYOnZk1utI+Gm/c
        nJkxNPShIt8JqQQRj5qwXg==
X-Google-Smtp-Source: ABdhPJyYU5ZN20QO1onZaEwEsB+CVkebLQ3zOpRklJ6Pq/HgZ2AgQsr/pu9Qk30S2Wn7qSTJgjGIRw==
X-Received: by 2002:a05:6808:de0:b0:2ec:c2ab:50b9 with SMTP id g32-20020a0568080de000b002ecc2ab50b9mr298493oic.254.1649100177005;
        Mon, 04 Apr 2022 12:22:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d12-20020a056871040c00b000d9eed0f8fdsm4545924oag.14.2022.04.04.12.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 12:22:56 -0700 (PDT)
Received: (nullmailer pid 1802031 invoked by uid 1000);
        Mon, 04 Apr 2022 19:22:55 -0000
Date:   Mon, 4 Apr 2022 14:22:55 -0500
From:   Rob Herring <robh@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     devicetree@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        ryder.lee@kernel.org, linux-mmc@vger.kernel.org,
        wenst@chromium.org, chunfeng.yun@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, Wenbin Mei <wenbin.mei@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>
Subject: Re: [PATCH v13 1/2] dt-bindings: mmc: mtk-sd: increase reg items
Message-ID: <YktFjwb6ZqfOyqUe@robh.at.kernel.org>
References: <20220330094532.21721-1-tinghan.shen@mediatek.com>
 <20220330094532.21721-2-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220330094532.21721-2-tinghan.shen@mediatek.com>
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

On Wed, 30 Mar 2022 17:45:31 +0800, Tinghan Shen wrote:
> MediaTek has a new version of mmc IP since mt8183. Some IO registers
> are moved to top to improve hardware design and named as "host top
> registers".
> 
> Add host top register in the reg binding description for mt8183 and
> successors.
> 
> Signed-off-by: Wenbin Mei <wenbin.mei@mediatek.com>
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> ---
>  Documentation/devicetree/bindings/mmc/mtk-sd.yaml | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
