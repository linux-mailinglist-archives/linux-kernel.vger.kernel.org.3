Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77BA5518D29
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 21:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241901AbiECTbc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 15:31:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbiECTb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 15:31:29 -0400
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 439192AE37;
        Tue,  3 May 2022 12:27:56 -0700 (PDT)
Received: by mail-ot1-f47.google.com with SMTP id s18-20020a056830149200b006063fef3e17so773187otq.12;
        Tue, 03 May 2022 12:27:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=t1DI1S/v8x5uneeqAGDnC3X0//kX6nybz2VF5VcS0xQ=;
        b=kvCkQXqku1yLbumeSuy/n5/C1HsZMm4inMMPkrCePG+HYSse0k14VlzpJCLYKtcSkv
         J3CgmCkOD68PYwaVhiUNk3s7iCccsXns/z3o/EFXHNPZkUEoEtybl6u6SO3mIRiOnBVf
         LFJK5QfK7jJrRp7JdCdfZzbbdMPvpTqNHQRssOnOA+iYboCNUrXfrLR5qH2hEEx5uHGf
         wzDgHUMV7yGmQpHRUx6S2LUG+bfTpnGoF1FINo+10Hx0Xt/e0a67PANz42xy63l6f/9g
         a7jXZeWvWp+HOh5HIn6RdXyjLz1O/FHiJKC3ZcViSdiXc/6zaDyBP6Mz7c2Gu5DPS0x9
         rD6A==
X-Gm-Message-State: AOAM5319GrXZi7C5eeW0ol/h8R7Adpqh8hHMnG0LR+MQIb+fu0zkSEye
        Pt1ZKHFwMmqydeJ2G9zdHiyJZL8XAw==
X-Google-Smtp-Source: ABdhPJwkw8I3jDkzvOLRxpoNBfoWnNUdw9YKkm55Bo6yfaZ9Jb8d/fRbqPQodVHJoHwlFT2tWSaaxg==
X-Received: by 2002:a05:6830:4027:b0:606:2d9:c0d3 with SMTP id i7-20020a056830402700b0060602d9c0d3mr6441347ots.260.1651606075551;
        Tue, 03 May 2022 12:27:55 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 7-20020a4a0607000000b0035ed382fb5asm4189066ooj.15.2022.05.03.12.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 12:27:55 -0700 (PDT)
Received: (nullmailer pid 4086471 invoked by uid 1000);
        Tue, 03 May 2022 19:27:54 -0000
Date:   Tue, 3 May 2022 14:27:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, lee.jones@linaro.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, sboyd@kernel.org,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, orsonzhai@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V4 1/4] dt-bindings: clk: sprd: Add bindings for ums512
 clock controller
Message-ID: <YnGCOm86jtxBJ6Jo@robh.at.kernel.org>
References: <20220427100848.3525710-1-gengcixi@gmail.com>
 <20220427100848.3525710-2-gengcixi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427100848.3525710-2-gengcixi@gmail.com>
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

On Wed, 27 Apr 2022 18:08:45 +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Add a new bindings to describe ums512 clock compatible string.
> 
> Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/clock/sprd,ums512-clk.yaml       | 71 +++++++++++++++++++
>  1 file changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
