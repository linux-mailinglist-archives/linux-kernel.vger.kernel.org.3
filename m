Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8338952AA00
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 20:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350035AbiEQSI0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 14:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232354AbiEQSIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 14:08:22 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEDC5FB8;
        Tue, 17 May 2022 11:08:22 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f1d2ea701dso1171891fac.10;
        Tue, 17 May 2022 11:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yA1WC/CMw1QTEhMlwWP3KRXXpyfEqJZV8ewG6GE6Q2w=;
        b=hjcWEvL+027cG6Xmg2jgzk+7PSntd0yBct1UDbeHuunkujfZxk+y5P3aKyWVsXGFf3
         g78ryvXLd4GXU6n+5yH/A+7nEQQbyNR+j5c7UJO9PrOvJOFyesZvUPCUMzSSgDoKGIz6
         4vkdwHi1S9OQv/fjOzg8NgwVBPP5LSVsA11Kb9KQEvUuNMD3J1IS8ufOkBWmx7oL6j28
         Sz3vFqwwwDRW5VUuBhwT7FYUy92K6GicfIKD8ZZ4Af+CEW5Xv1OfTfBJsTCkeTpi4mCK
         J9xJtL9Z2QK13KHRErUjDaAFD+A72XRJ2fPKm2Ju8a+zS8xvCCfn+o55RAjMAlD9gFao
         6Kzg==
X-Gm-Message-State: AOAM530ojR5OfqgWCRyCByDFxTqMNCH5maLtQf9+LXZihldlcrrjSbKS
        23fdd60vB+SXT4UF3tZYJoX3J4DuUw==
X-Google-Smtp-Source: ABdhPJyHxM+gcy+aOGsVHVFJUXDmZbeAjCxX3XCZt6jlOXXTkRGryo+YYnDX3wQV6bhyF7oqpe2Ofg==
X-Received: by 2002:a05:6870:a40a:b0:f1:9240:2776 with SMTP id m10-20020a056870a40a00b000f192402776mr7214742oal.140.1652810901432;
        Tue, 17 May 2022 11:08:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d5-20020a056870e24500b000e90544b79fsm40017oac.41.2022.05.17.11.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 11:08:20 -0700 (PDT)
Received: (nullmailer pid 1342262 invoked by uid 1000);
        Tue, 17 May 2022 18:08:19 -0000
Date:   Tue, 17 May 2022 13:08:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>
Subject: Re: [PATCH next v5 2/4] dt-bindings: nvmem: mediatek: efuse: add
 support mt8183
Message-ID: <20220517180819.GA1342202-robh@kernel.org>
References: <20220512062622.31484-1-chunfeng.yun@mediatek.com>
 <20220512062622.31484-2-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512062622.31484-2-chunfeng.yun@mediatek.com>
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

On Thu, 12 May 2022 14:26:20 +0800, Chunfeng Yun wrote:
> Add "mediatek,mt8183-efuse" to fix dtbs check warning.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v5: new patch
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
