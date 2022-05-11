Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1675752361A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 16:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbiEKOrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 10:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245059AbiEKOrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 10:47:36 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4CF2DD71;
        Wed, 11 May 2022 07:47:33 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-e93bbb54f9so3036744fac.12;
        Wed, 11 May 2022 07:47:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBUKOyei7jhZAd+rG0AZF55Jr3UmZvagA9TyiYBMsWU=;
        b=vJIUiw+lUzQy+XM3boG+AiasfNlEn2u53UGyAEd+Epm0h29tx+uyvdX4wunrOgewaD
         SPMLrE+UO45UpwMPElY82xTq2yM3VBBGFLhOug0PMws+pBIFe/qzTe8P783PX0WWkHpN
         /A5y0blxzawCJncw6i3vHm6yKYLe0sReM98k5qx7J/6ZZwYjQhXfrHrjMGHixVvfviYF
         7dFisOBkXU0HxUC88ZrfLoEq7eSGtrPdYLag86mimkOhKrSoHfChMCa/h3bAY8iD0SD4
         TPjm6twF7U95GZ7P96iDj1jMzZoEEYLNUuAmxGPHfcE/WNbkQ9Z+iHqPh4njBEYB5MqV
         mdXQ==
X-Gm-Message-State: AOAM532Poy/mMEOU+y99NuKCtB0BDWUGc3Mh4LcCSuduO1qi8qASWGQO
        uniABiJ1hlGUyf+FBHANYA==
X-Google-Smtp-Source: ABdhPJz98n8ntxGILk81aL6US1/KphHKB3FmHQzCO8v2Qn3CLhjkTHsFGtb472uba5vtZ3ndGND17Q==
X-Received: by 2002:a05:6870:b39c:b0:d1:4a9f:35f9 with SMTP id w28-20020a056870b39c00b000d14a9f35f9mr2769263oap.119.1652280452730;
        Wed, 11 May 2022 07:47:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y21-20020a4a6515000000b0035eb4e5a6c2sm1006637ooc.24.2022.05.11.07.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 07:47:32 -0700 (PDT)
Received: (nullmailer pid 286708 invoked by uid 1000);
        Wed, 11 May 2022 14:47:31 -0000
Date:   Wed, 11 May 2022 09:47:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     devicetree@vger.kernel.org, kbuild-all@lists.01.org,
        linux-tegra@vger.kernel.org, Thierry Reding <treding@nvidia.com>,
        jsequeira@nvidia.com, bbasu@nvidia.com,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, vsethi@nvidia.com, jonathanh@nvidia.com
Subject: Re: [Patch v5 3/9] dt-bindings: arm: tegra: Add NVIDIA Tegra194
 axi2apb binding
Message-ID: <20220511144731.GA286675-robh@kernel.org>
References: <20220506111217.8833-1-sumitg@nvidia.com>
 <20220506111217.8833-4-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506111217.8833-4-sumitg@nvidia.com>
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

On Fri, 06 May 2022 16:42:11 +0530, Sumit Gupta wrote:
> Add device-tree binding documentation to represent the axi2apb bridges
> used by Control Backbone (CBB) 1.0 in Tegra194 SOC. All errors for APB
> slaves are reported as slave error because APB bas single bit to report
> error. So, CBB driver needs to further check error status registers of
> all the axi2apb bridges to find error type.
> 
> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../arm/tegra/nvidia,tegra194-axi2apb.yaml    | 40 +++++++++++++++++++
>  1 file changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
