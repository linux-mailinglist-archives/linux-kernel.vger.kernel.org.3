Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FE9568B99
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbiGFOp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:45:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233470AbiGFOpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:45:52 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E125583;
        Wed,  6 Jul 2022 07:45:52 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id h85so14210609iof.4;
        Wed, 06 Jul 2022 07:45:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F76AWoKe++Zx0dD2zE8V7c1BPtYAI5oZL0brUD35ZU4=;
        b=nk81Y+XTxsC/EAj0V/MCsVqOcIKcWuGcelJZg39LX1NEJHu+mwHM2zBW4Ton0q32U8
         ppTozwUDqcSEaNaQ+f891Kjps4M9AN1k6q5SpwGlLCOPpI3xnvG9xm1GBeTG+mi3CUi8
         n8p6yPnO4AiPfoSy0eaMvMDFaZFRjTc+jRyyif18ouMQ+2jfP1caQymv7MaIqofk5WkS
         yUcGes9SKSDobWUP1G6ABGUcOaiZZ2KI894lrE/exn+CB1itZdVrJSuwrvL/zrZHO3Iy
         2ysIxpNK1JiMoSh684a3fLNlH3WS8ovl92mOLAyFqah2zxj7IdBw5Q1KJb3P76M3ocqs
         y0Dg==
X-Gm-Message-State: AJIora/SONXTxYc5udTbhJ2SAaNhP3XIkH8/UHd4cmB/+weHpfta+Nb+
        y5C2ead+6EyA4CyjAx3deA==
X-Google-Smtp-Source: AGRyM1vKo7aMrFmy88OiMPEw21lorx1jy+GJycUjUFI4kV845M26Rh/j6xZk5qDb9m21R56dJw3dpQ==
X-Received: by 2002:a5e:a506:0:b0:66a:2cdc:e6f7 with SMTP id 6-20020a5ea506000000b0066a2cdce6f7mr22203877iog.113.1657118751286;
        Wed, 06 Jul 2022 07:45:51 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id k30-20020a02335e000000b00339e6f88235sm15999225jak.61.2022.07.06.07.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 07:45:50 -0700 (PDT)
Received: (nullmailer pid 18250 invoked by uid 1000);
        Wed, 06 Jul 2022 14:45:49 -0000
Date:   Wed, 6 Jul 2022 08:45:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 1/3] dt-bindings: arm: qcom: document qcom,msm-id and
 qcom,board-id
Message-ID: <20220706144549.GA18217-robh@kernel.org>
References: <20220705130300.100882-1-krzysztof.kozlowski@linaro.org>
 <20220705130300.100882-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705130300.100882-2-krzysztof.kozlowski@linaro.org>
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

On Tue, 05 Jul 2022 15:02:58 +0200, Krzysztof Kozlowski wrote:
> The top level qcom,msm-id and qcom,board-id properties are utilized by
> bootloaders on Qualcomm MSM platforms to determine which device tree
> should be used and passed to the kernel.
> 
> The commit b32e592d3c28 ("devicetree: bindings: Document qcom board
> compatible format") from 2015 was a consensus during discussion about
> upstreaming qcom,msm-id and qcom,board-id fields.  There are however still
> problems with that consensus:
> 1. It was reached 7 years ago but it turned out its implementation did
>    not reach all possible products.
> 
> 2. Initially additional tool (dtbTool) was needed for parsing these
>    fields to create a QCDT image consisting of multiple DTBs, later the
>    bootloaders were improved and they use these qcom,msm-id and
>    qcom,board-id properties directly.
> 
> 3. Extracting relevant information from the board compatible requires
>    this additional tool (dtbTool), which makes the build process more
>    complicated and not easily reproducible (DTBs are modified after the
>    kernel build).
> 
> 4. Some versions of Qualcomm bootloaders expect these properties even
>    when booting with a single DTB.  The community is stuck with these
>    bootloaders thus they require properties in the DTBs.
> 
> Since several upstreamed Qualcomm SoC-based boards require these
> properties to properly boot and the properties are reportedly used by
> bootloaders, document them along with the bindings header with constants
> used by: bootloader, some DTS and socinfo driver.
> 
> Link: https://lore.kernel.org/r/a3c932d1-a102-ce18-deea-18cbbd05ecab@linaro.org/
> Co-developed-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Kumar Gala <galak@codeaurora.org>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  .../devicetree/bindings/arm/qcom.yaml         | 120 ++++++++++++++
>  include/dt-bindings/arm/qcom,ids.h            | 152 ++++++++++++++++++
>  2 files changed, 272 insertions(+)
>  create mode 100644 include/dt-bindings/arm/qcom,ids.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
