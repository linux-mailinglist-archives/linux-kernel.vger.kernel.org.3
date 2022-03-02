Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1224CAC7A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:51:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244265AbiCBRwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236917AbiCBRwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:52:09 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E86E2D1E2;
        Wed,  2 Mar 2022 09:51:26 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id i5so2437915oih.1;
        Wed, 02 Mar 2022 09:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GFF/t9fk//sx7LHwN7dlkkdLpRIX0g7zkDB/NfrGhNs=;
        b=28/9Ledkegy2oYhjb7MU9fHpn9cY86840I0J+eft0GAdKOIUWMuBYtldgMkYwQByOd
         SNq41ndNFsGdVX5Hfdp7MW23eueVqm7CxxA4I5zgozELfoW2zX55aHK366rAAQACHjFV
         7ts6Ji6cWmCMRA3DYtxN77fbCtAeHYYW9KQSlzmiyk5zlnl+WMhyL205qe8Vegaft7BL
         wSi2Jd4+G7f1o7EZXzGdafmYBNfXJ8b/ePtcdGYl1dh8uVSavkj7vhX7MHnlgki+diul
         e43PJOwaJPR0xhuSIsXJwI3+QVhu1EIOjcRuYhhZDEchB/8oooGjwa1IFlIWBGqqnzQo
         icIA==
X-Gm-Message-State: AOAM5335kP7QW4WbbSbvTCKedWwjIYzZ7UuqzMpKNgzs3Hu+Sja0dWbL
        bHzyWzRVCr8ihIsmxPkY0A==
X-Google-Smtp-Source: ABdhPJzp4n9WySV+E8mkfq2VuWX+XkhyWRTeGtDGbTY2pp+hLqJV3uRkCT9mqniVOdzkKTRtxFjkLw==
X-Received: by 2002:a05:6808:4c:b0:2d7:8451:feb2 with SMTP id v12-20020a056808004c00b002d78451feb2mr937798oic.100.1646243485492;
        Wed, 02 Mar 2022 09:51:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id b15-20020a05687061cf00b000d17a5f0ee6sm7397001oah.11.2022.03.02.09.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:51:24 -0800 (PST)
Received: (nullmailer pid 3955040 invoked by uid 1000);
        Wed, 02 Mar 2022 17:51:23 -0000
Date:   Wed, 2 Mar 2022 11:51:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Ashish Mhetre <amhetre@nvidia.com>
Cc:     krzysztof.kozlowski@canonical.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, vdumpa@nvidia.com, Snikam@nvidia.com
Subject: Re: [Patch v4 2/4] dt-bindings: memory: Update reg maxitems for
 tegra186
Message-ID: <Yh+um1TSNWK8P6GY@robh.at.kernel.org>
References: <1646210609-21943-1-git-send-email-amhetre@nvidia.com>
 <1646210609-21943-3-git-send-email-amhetre@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646210609-21943-3-git-send-email-amhetre@nvidia.com>
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

On Wed, Mar 02, 2022 at 02:13:27PM +0530, Ashish Mhetre wrote:
> >From tegra186 onwards, memory controller support multiple channels.
> Reg items are updated with address and size of these channels.
> Tegra186 has overall 5 memory controller channels. Tegra194 and tegra234
> have overall 17 memory controller channels each.
> There is 1 reg item for memory controller stream-id registers.
> So update the reg maxItems to 18 in tegra186 devicetree documentation.

Some of this needs to be in 'description' for 'reg'.

> 
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>  .../devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml      | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> index 13c4c82..eb7ed00 100644
> --- a/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> +++ b/Documentation/devicetree/bindings/memory-controllers/nvidia,tegra186-mc.yaml
> @@ -35,7 +35,7 @@ properties:
>  
>    reg:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 18
>  
>    interrupts:
>      items:
> -- 
> 2.7.4
> 
