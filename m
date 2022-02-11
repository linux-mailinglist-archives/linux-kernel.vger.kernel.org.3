Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893F34B283E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241482AbiBKOsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:48:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235874AbiBKOsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:48:31 -0500
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0513FFE;
        Fri, 11 Feb 2022 06:48:31 -0800 (PST)
Received: by mail-oo1-f54.google.com with SMTP id q145-20020a4a3397000000b002e85c7234b1so10586744ooq.8;
        Fri, 11 Feb 2022 06:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O7OnEPb9fuxvqN5g26fYv9LVZN/hhTSP1Ptizy/y4t4=;
        b=4HYyEzVFEVplAPl4HkWUpZ7ErWnb3ju7MmUVmm1ecFTms/MnN0pQG815aSJjavyr4o
         lYsq+f4gOy2z/GcPOlRulr2hA4N9MqydLzWVP0g/DPoWGndMhmfw18rval51TC1P2h2g
         UHVSQ6bDfxxHvUARWiWQdtUvANQnDElFmtK2tl8HO0PNEyAxC+Kss+hCEiFoGwFgV33W
         ODvDi79NZf5R3J0qLHf8XAHYw2dIljkk5jgRI8Gwo0HRvNVp5dk7g/LyERnYdFqMMDQL
         WqUcbkap+WpPNbVmjY9YvS3FNMt/o/IDqdmc2peIUF9GSHQ7OysKI0jarpgnUbVQYYq8
         LFyA==
X-Gm-Message-State: AOAM531YrXm+HX6zEBMHOAJ+W96jgs4Q+McJ0zVg7JSSJWJzGClRnjJy
        T3a5RCRsF57QjYwBxALHK/JhYngeiw==
X-Google-Smtp-Source: ABdhPJwSho7dl9kUe2vpyZezvoFcWfxPQXu+OgRj2U5Ws1eHSTaaDMolpTOT7Wg0n/fvvuq5FPudzw==
X-Received: by 2002:a05:6870:4:: with SMTP id a4mr242110oaa.228.1644590910339;
        Fri, 11 Feb 2022 06:48:30 -0800 (PST)
Received: from robh.at.kernel.org ([2607:fb90:20d7:a802:e6b0:6d9c:32f7:4bd9])
        by smtp.gmail.com with ESMTPSA id g17sm9065240ots.73.2022.02.11.06.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 06:48:29 -0800 (PST)
Received: (nullmailer pid 342457 invoked by uid 1000);
        Fri, 11 Feb 2022 14:48:27 -0000
Date:   Fri, 11 Feb 2022 08:48:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>
Cc:     ldewangan@nvidia.com, linux-spi@vger.kernel.org,
        thierry.reding@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, skomatineni@nvidia.com,
        broonie@kernel.org, p.zabel@pengutronix.de,
        linux-tegra@vger.kernel.org, robh+dt@kernel.org,
        jonathanh@nvidia.com
Subject: Re: [PATCH 2/6] dt-bindings: spi: Tegra234 QUAD SPI compatible
Message-ID: <YgZ3O7cMeLIqD8aE@robh.at.kernel.org>
References: <1643970576-31503-1-git-send-email-kyarlagadda@nvidia.com>
 <1643970576-31503-3-git-send-email-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643970576-31503-3-git-send-email-kyarlagadda@nvidia.com>
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

On Fri, 04 Feb 2022 15:59:32 +0530, Krishna Yarlagadda wrote:
> Add compatible string for Tegra234 for Tegra QUAD SPI
> 
> Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
> ---
>  Documentation/devicetree/bindings/spi/nvidia,tegra210-quad.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
