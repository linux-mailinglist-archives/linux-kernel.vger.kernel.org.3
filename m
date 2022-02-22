Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 569704C02FB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235463AbiBVU1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbiBVU1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:27:41 -0500
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2949D051;
        Tue, 22 Feb 2022 12:27:15 -0800 (PST)
Received: by mail-ot1-f42.google.com with SMTP id j3-20020a9d7683000000b005aeed94f4e9so7087423otl.6;
        Tue, 22 Feb 2022 12:27:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uPnUbQrAlFPwBsKQK/FHM3ApbVo/5s8mNMNmKnxO5co=;
        b=pDTbECdoXBX2cqC8oVNUUqqjOGWAVH4pLzUAvipZ8k9W83WRIMED3yT9gtG3ht36NF
         Ij3noHsARUbGZsyJrTjtfwiGnVogBse8aMrmyo1jdjgDjbKytslPxkn2D+QsravFzSzW
         Q6aoZoCAEGsKmieO1JH4qkHCgmqHTaLtHiIS8HnuC6b5svbh9LjeC18DrL76j5CmCp/7
         ShdDjSYXXi/go/eEG7DRl6mKF4o7by4d3VBfuuAnCYG0IaAL4xopX4TFFGReZpmDQmro
         1WNwinmz33OOGRLZKNVwh1XG9Q3PdccrIxn4hbn9TVXFSFVY2KUlthccOdv1ho2Ed97o
         XqNg==
X-Gm-Message-State: AOAM532jSGXm5mc1hgsUgdI02zL8gfKKbzhQBJnG/qk3mBYg84VwgQCm
        xCy47cePMP069yA8lPjc62Okc694SQ==
X-Google-Smtp-Source: ABdhPJzu1Y7MfdsZBnFKD4tdGj0xn3CXifVlJN/265Lw6Z6FbCDdeAP5RHP7woKaVlQzblKUciWqww==
X-Received: by 2002:a9d:5e92:0:b0:59e:28db:41cf with SMTP id f18-20020a9d5e92000000b0059e28db41cfmr9175612otl.366.1645561634834;
        Tue, 22 Feb 2022 12:27:14 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j2sm4716448ooi.39.2022.02.22.12.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:27:14 -0800 (PST)
Received: (nullmailer pid 3527901 invoked by uid 1000);
        Tue, 22 Feb 2022 20:27:13 -0000
Date:   Tue, 22 Feb 2022 14:27:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     broonie@kernel.org, thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        skomatineni@nvidia.com, ldewangan@nvidia.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        p.zabel@pengutronix.de
Subject: Re: [PATCH v2 2/5] dt-bindings: spi: Tegra234 QUAD SPI compatible
Message-ID: <YhVHIVJlCwhbVAH7@robh.at.kernel.org>
References: <20220222175611.58051-1-kyarlagadda@nvidia.com>
 <20220222175611.58051-3-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222175611.58051-3-kyarlagadda@nvidia.com>
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

On Tue, Feb 22, 2022 at 11:26:08PM +0530, Krishna Yarlagadda wrote:
> Add compatible string for Tegra234 for Tegra QUAD SPI
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
>  1 file changed, 1 insertion(+)

Please add Acked-by/Reviewed-by tags when posting new versions. However,
there's no need to repost patches *only* to add the tags. The upstream
maintainer will do that for acks received on the version they apply.

If a tag was not added on purpose, please state why and what changed.
