Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 476E052A9BA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 19:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351669AbiEQR5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 13:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350016AbiEQR46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 13:56:58 -0400
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D72F5007F;
        Tue, 17 May 2022 10:56:48 -0700 (PDT)
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-f17f1acffeso12597619fac.4;
        Tue, 17 May 2022 10:56:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L1sqOLzWzpsiBSGnA++a9tfQA6CMCv9r3qkf2l/yADM=;
        b=NSsarO4rPqozavbYz3Fks/6gdIW6b0Rr9+yoB3Wb7nGrUvzteQ6Zd5y9npeZuRuQz0
         mv9EBiWh7b+p3wnft+hHT6wDlCTDuBhNEGYuy3mejpwrfHkGAPMBOD8Yr+LlpB1UxNqf
         he2zCzIXnh+XJQ/+MTcfnWGM74/DgAyewG+PQCZ9MVJeoifO34Y87DmXLCXGwl2lHRfA
         JBwfQR/Q33Q3y/SYe+Hic2qSgbHRWwH7BnQnGmCydNX1FA19uPyLM0jHSsvqiEAoxcME
         sIqyNDAGABWvghlgogVGSHOy3Tgn2AyH7Z55vrvXcbulAwcZqvkUtLK3jNLn0IwLFN/X
         4zUg==
X-Gm-Message-State: AOAM5314ULv3k4oOw8r5oS6F5VNttsvAhijhf0OHe4UjbiMqT/74VzAb
        0Pf0U+e433TK7KIEOko4IQ==
X-Google-Smtp-Source: ABdhPJyQ0yRfa/115zZ1LMiFdRblJkKEdDow7ouxhH/iPe14psEKoBNOiL/yZkDVQ9plvrPtJvmilg==
X-Received: by 2002:a05:6870:8315:b0:e9:c1a:a1e0 with SMTP id p21-20020a056870831500b000e90c1aa1e0mr13051512oae.153.1652810207862;
        Tue, 17 May 2022 10:56:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w62-20020acaad41000000b00328a1be5c3asm78864oie.25.2022.05.17.10.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 10:56:47 -0700 (PDT)
Received: (nullmailer pid 1321569 invoked by uid 1000);
        Tue, 17 May 2022 17:56:46 -0000
Date:   Tue, 17 May 2022 12:56:46 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, jsequeira@nvidia.com,
        linux-tegra@vger.kernel.org, bbasu@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, kbuild-all@lists.01.org,
        thierry.reding@gmail.com, vsethi@nvidia.com, jonathanh@nvidia.com
Subject: Re: [Patch v6 6/9] dt-bindings: arm: tegra: Add NVIDIA Tegra234
 CBB2.0 binding
Message-ID: <20220517175646.GA1321507-robh@kernel.org>
References: <20220511201651.30695-1-sumitg@nvidia.com>
 <20220511201651.30695-8-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511201651.30695-8-sumitg@nvidia.com>
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

On Thu, 12 May 2022 01:46:48 +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent
> the Control Backbone (CBB) version 2.0 used in T234 SoC.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra234-cbb.yaml        | 74 +++++++++++++++++++
>  1 file changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
