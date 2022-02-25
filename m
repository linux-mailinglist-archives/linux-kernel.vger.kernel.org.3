Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD1534C4E7A
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 20:16:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234485AbiBYTQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 14:16:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbiBYTQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 14:16:55 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC7621CD25;
        Fri, 25 Feb 2022 11:16:23 -0800 (PST)
Received: by mail-ot1-f49.google.com with SMTP id g6-20020a9d6486000000b005acf9a0b644so4276084otl.12;
        Fri, 25 Feb 2022 11:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MjMHysom9kW2ufziIfpzHU8NZ8UHajftf+w14wsmNUE=;
        b=o+N24FFy9WhUxDvSr8hhFyvBWvc2/W7eVT4O0WgBsMUgmTiIlSzIgZpYE2rq2MFczr
         vUjNpdMYC45USwWjUgb9CxToqmZoXsSCBHDqEXtvp6OCCxgX5gftCSo22+BiyAAiCPvn
         d+BtqQP4Jq5QTOxIgKoo9IP1WtibTODO3Gm1sG0X7YCUA0YT/9JW4ePKmhV5ppk1LkOH
         IuIHaGfoIjPYpiE1N/YF2y/cbrc9gMCok0fd4LGVCKCJr4dca6LvU23H75QcVc0Z5Ycn
         o9Zu83y6cOPMIsmOrgIMjmlMt6Fv3vWmQSrCusEx1Fvskv8m+vNDLz8SPoqplZYxDi+Q
         pVgQ==
X-Gm-Message-State: AOAM530yBmoaMbKl78dSujamdgJodp/DXhloBza6hiwx2O6JdUNcsDpW
        c1SRYUVPk7KmV34sk/rn8Q==
X-Google-Smtp-Source: ABdhPJzH92pAlv3IwnBQb2MbcNAImo/5jXQUnmCcDK1tSYu6KTmKZ8JzgUrj0xYit4bGDtM1Rh59Dg==
X-Received: by 2002:a05:6830:1f51:b0:5ad:1f9b:dc43 with SMTP id u17-20020a0568301f5100b005ad1f9bdc43mr3522990oth.369.1645816582896;
        Fri, 25 Feb 2022 11:16:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id g7-20020a056870d20700b000d1614be328sm1559694oac.27.2022.02.25.11.16.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 11:16:22 -0800 (PST)
Received: (nullmailer pid 1274167 invoked by uid 1000);
        Fri, 25 Feb 2022 19:16:21 -0000
Date:   Fri, 25 Feb 2022 13:16:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Dong Aisheng <aisheng.dong@nxp.com>, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: fsl: scu: add imx8dxl scu clock support
Message-ID: <YhkrBZzIDJ4Rgj9x@robh.at.kernel.org>
References: <20220222082140.2073629-1-abel.vesa@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220222082140.2073629-1-abel.vesa@nxp.com>
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

On Tue, Feb 22, 2022 at 10:21:40AM +0200, Abel Vesa wrote:
> Add imx8dxl scu clock support.
> 
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>

But please convert this to schema.

Rob
