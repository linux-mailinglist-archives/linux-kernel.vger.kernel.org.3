Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F207652351C
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244218AbiEKOMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiEKOMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:12:20 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B663469B5F;
        Wed, 11 May 2022 07:12:19 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-edf3b6b0f2so2927153fac.9;
        Wed, 11 May 2022 07:12:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hVwIirk09yaLIn9W0AnvNQlwP2lkso9U6oZmurIZ4jo=;
        b=D4zxoAizxuYj5AersHXEtVadWOwLmz7P6VoTfEUToZJP9N2TaEkeuXRFFeBvWiQ1ci
         M0LkGmkOI0AyQImU4LOfk3RJ5M64Xv8OMDCSe7NOfVsJ7XqY/GajV/oVJIo8OESjWjxu
         V2oCrbtgOuPWIFODYLy24ZImKVbQE4t1Yda5UQ9FftI41pZhe941jMiniY5lGD394UnB
         bUevW0cU5EOcxMuKMkm7wljsAcLn+08q9rJkx/B3UH0XXNEi5nmQXXsxQBW6Yj43eVYZ
         RtF94GOOACPcba2j7c8+A5zA37yEbzu2epRz5ijKXFv9weM0cNyNw+NhUk14cB4YDcpD
         QeLw==
X-Gm-Message-State: AOAM530+DrQ01GaOek+BPzrNwVdDzmPH1q09KIXqsXCsCHbudhCMhjhn
        LU+jVVZZOiwgdvVQr2hRYA==
X-Google-Smtp-Source: ABdhPJxD+7w4jCYBXpntlQ05yu2K8ufID8l4SDZrOUeqpx/5VE6wlYHK5Le77K7bV0jyOCAjWZSOkw==
X-Received: by 2002:a05:6870:8888:b0:e9:a3eb:a52d with SMTP id m8-20020a056870888800b000e9a3eba52dmr2742881oam.181.1652278339038;
        Wed, 11 May 2022 07:12:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bd28-20020a056870d79c00b000e686d1386fsm617236oab.9.2022.05.11.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:12:18 -0700 (PDT)
Received: (nullmailer pid 236095 invoked by uid 1000);
        Wed, 11 May 2022 14:12:17 -0000
Date:   Wed, 11 May 2022 09:12:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     hsinyi@chromium.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v10 1/4] dt-bindings: timer: Add compatible for Mediatek
 MT8186
Message-ID: <20220511141217.GA236062-robh@kernel.org>
References: <20220510075233.5426-1-allen-kh.cheng@mediatek.com>
 <20220510075233.5426-2-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510075233.5426-2-allen-kh.cheng@mediatek.com>
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

On Tue, 10 May 2022 15:52:30 +0800, Allen-KH Cheng wrote:
> From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> 
> This commit adds dt-binding documentation of timer for Mediatek MT8186 SoC
> Platform.
> 
> Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
> ---
>  Documentation/devicetree/bindings/timer/mediatek,mtk-timer.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
