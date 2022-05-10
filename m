Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA3D522249
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 19:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347933AbiEJRZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 13:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347919AbiEJRZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 13:25:06 -0400
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED123A1BB;
        Tue, 10 May 2022 10:21:02 -0700 (PDT)
Received: by mail-oi1-f172.google.com with SMTP id m25so19250828oih.2;
        Tue, 10 May 2022 10:21:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oMzOMHbyZL+xpBkMzkSynF3FtiNncyHat+FTsJFqJKY=;
        b=nUGKxNtgHCDrU71KcwAm30zju4pEzV5nStIzllUQkojE+80dALxFEmXsA+VLOZhvNK
         UjV7QleQsyoZAyiHtzGRl8JzUqyIGu/3cffKSsm7B44yU+N8YAJaV3MqkeVl6Tkup1yg
         bo2Et7zSbJcI5Tgx0b0QYusJBTpOE7Lr5YkyO+cnHkRQxhsH8tH1A3qz9oqOlOIaBkJm
         C072Ukn9Tld1m7aN2X+YxeZJuIQaFXQykBTYUg+lheV++IXS48z+PFH8/QH7KW6Cxihu
         bGjmb3iHzonnkhw1lJcJh068X/e6PGQsge7mLvkMQllCL3Xk9g1LfQ+tjggPMm8RCdSm
         MBXg==
X-Gm-Message-State: AOAM531uWK1G9HK5dK+zn+i2yosbLquqwzZTdwMbnL5QK5AaR3+jiFaq
        gjhIz9HYXTjW5mNkosXPUQ==
X-Google-Smtp-Source: ABdhPJznU/OK4X6N6Bam1z+KQxPFq1bK52J+cIR4GOgkdzKpqKmgFPS7YZjpDW22cMbMfK7vuKe6Lw==
X-Received: by 2002:aca:502:0:b0:2cd:c24:278f with SMTP id 2-20020aca0502000000b002cd0c24278fmr539112oif.150.1652203262272;
        Tue, 10 May 2022 10:21:02 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i9-20020a4aab09000000b0035eb4e5a6ccsm6343573oon.34.2022.05.10.10.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 10:21:01 -0700 (PDT)
Received: (nullmailer pid 2231680 invoked by uid 1000);
        Tue, 10 May 2022 17:21:01 -0000
Date:   Tue, 10 May 2022 12:21:01 -0500
From:   Rob Herring <robh@kernel.org>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     linux-kernel@vger.kernel.org, hsinyi@chromium.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mediatek@lists.infradead.org,
        Ryder Lee <ryder.lee@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v10 2/4] dt-bindings: arm: mediatek: Add mt8186 pericfg
 compatible
Message-ID: <Ynqe/d2+UT1V8Y+3@robh.at.kernel.org>
References: <20220510075233.5426-1-allen-kh.cheng@mediatek.com>
 <20220510075233.5426-3-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510075233.5426-3-allen-kh.cheng@mediatek.com>
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

On Tue, 10 May 2022 15:52:31 +0800, Allen-KH Cheng wrote:
> Add mt8186 pericfg compatible to binding document.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> ---
>  .../devicetree/bindings/arm/mediatek/mediatek,pericfg.yaml       | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
