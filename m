Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53D53528A50
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343623AbiEPQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343615AbiEPQ1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:27:51 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED04393EE;
        Mon, 16 May 2022 09:27:50 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-e93bbb54f9so20752757fac.12;
        Mon, 16 May 2022 09:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=osVfxhsQi2p2dlDrhzZDuOBV7X+Ps662PG/MDdJu9W0=;
        b=R8Uy/8TgWLgSj8dnANBcz9ev3bYcDCylCkLNtSkoJKYdoUfUCQFlm2JyK/5CzWtvq5
         Zua7+YAtjyd0BOh733TOLhmy8kww4tK3NMLnn3ssHxBzZ1TpPHIwdS4torhBIfvRDAAi
         M8yYnl05epDcUdtkiFBsi8afwfEA3ZvQ9wt+2QNGYDt3UJcawRVmLakFa++ID8AETReB
         np/lvpNCOp6LJo9RCYOOUwBynwl1R2zQelVr/sw8OaouPTWU6Asi5Lr3SqEpbg4OU+tD
         5tezWO0aAOhl9115zSmqIn10KPdA14MRs1F5wu/7qfrkHVC7weY5auKgYfpu9Wqnm23U
         7CPw==
X-Gm-Message-State: AOAM5309w0IVaIoJJ9/B9/KEYA7Y1RredSMmtU52QhJWBdA/9Tbqn6hx
        MiM4j2H9V/HPhINB3eOX2ww1ROZtYQ==
X-Google-Smtp-Source: ABdhPJxaunhi1VLlqHvgFaK+EgjKjq0gVMM8ayHjAQzaIw/eUPKQEHsbfeLNaMcAuwFJet/LLjQYYg==
X-Received: by 2002:a05:6870:890f:b0:e1:c92d:d84 with SMTP id i15-20020a056870890f00b000e1c92d0d84mr9757652oao.49.1652718469152;
        Mon, 16 May 2022 09:27:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b18-20020a9d6b92000000b00606b1f72fcbsm4071686otq.31.2022.05.16.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:27:48 -0700 (PDT)
Received: (nullmailer pid 2793161 invoked by uid 1000);
        Mon, 16 May 2022 16:27:47 -0000
Date:   Mon, 16 May 2022 11:27:47 -0500
From:   Rob Herring <robh@kernel.org>
To:     cyndis@kapsi.fi
Cc:     krzysztof.kozlowski@canonical.com,
        linux-arm-kernel@lists.infradead.org, robin.murphy@arm.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        joro@8bytes.org, thierry.reding@gmail.com, robh+dt@kernel.org,
        linux-tegra@vger.kernel.org, will@kernel.org, jonathanh@nvidia.com,
        devicetree@vger.kernel.org, iommu@lists.linux-foundation.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: host1x: Add iommu-map property
Message-ID: <20220516162747.GA2793126-robh@kernel.org>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-2-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516085258.1227691-2-cyndis@kapsi.fi>
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

On Mon, 16 May 2022 11:52:50 +0300, cyndis@kapsi.fi wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Add schema information for specifying context stream IDs. This uses
> the standard iommu-map property.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v3:
> * New patch
> v4:
> * Remove memory-contexts subnode.
> ---
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
