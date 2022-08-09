Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7650058E1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 23:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229517AbiHIVTm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 17:19:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiHIVTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:19:31 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CBF65801;
        Tue,  9 Aug 2022 14:19:30 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id x2so1121845ilp.10;
        Tue, 09 Aug 2022 14:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=6M/FU7adSM+py46tX1SaYYVRLASGwO2gMfEt0TKFxyg=;
        b=bjkNCBtKZelSUFY0C3TKG9U+T34nccQzbGUvLx8f7/D3nOtFGgyjXOurmForIRnIgb
         gCqxNASGiKAiy1cL+qSi/Bu8caPfU6F8RDzlRLZlHvsaHOUfaqCotGBHLXkOsX3X4WyV
         JX6AxCWUQ5mNJqqX0YTJbifK4QolLbj+JxrXqjK1D1yU0cHpJcc0tQWfkWQUJuHiv+oc
         k4c1ZBWQOOpAd49LjwZ7/6ljt1eDOiTFy2tLCdOt7MlWQzo3mooeR8Ir5WHFS0fSxJr9
         QUdGjRv30VkGwzX7uhGvULK8PvqwTtkCe0JtUEepCcancX2FgpEoqWnghvmMZFvQHkuO
         roGQ==
X-Gm-Message-State: ACgBeo0IjJVhS5qcGFmlQZejP7ZrX1ckgDhb39KVobZFTwAM90T7+l++
        bhi+q37EXDNsQuNNzh5l9w==
X-Google-Smtp-Source: AA6agR5bFw3+/PqucyVOoY3afOh/9y5TDMia+P843qb/iw0Un2IGsb1EqNiKHGZvoLHYUnrJ+VGFlw==
X-Received: by 2002:a92:6e11:0:b0:2df:3082:a28d with SMTP id j17-20020a926e11000000b002df3082a28dmr11284313ilc.199.1660079969888;
        Tue, 09 Aug 2022 14:19:29 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id bs27-20020a056638451b00b0033f51f165e3sm6670989jab.140.2022.08.09.14.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 14:19:29 -0700 (PDT)
Received: (nullmailer pid 2420839 invoked by uid 1000);
        Tue, 09 Aug 2022 21:19:27 -0000
Date:   Tue, 9 Aug 2022 15:19:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     agross@kernel.org, devicetree@vger.kernel.org,
        ulf.hansson@linaro.org, linux-arm-msm@vger.kernel.org,
        bhupesh.linux@gmail.com, bjorn.andersson@linaro.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mmc: sdhci-msm: Fix 'operating-points-v2
 was unexpected' issue
Message-ID: <20220809211927.GA2419725-robh@kernel.org>
References: <20220725202709.2861789-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220725202709.2861789-1-bhupesh.sharma@linaro.org>
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

On Tue, 26 Jul 2022 01:57:09 +0530, Bhupesh Sharma wrote:
> As Rob reported in [1], there is one more issue present
> in the 'sdhci-msm' dt-binding which shows up when a fix for
> 'unevaluatedProperties' handling is applied:
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.example.dtb:
>   mmc@8804000: Unevaluated properties are not allowed
>    ('operating-points-v2' was unexpected)
> 
> Fix the same.
> 
> [1]. https://lore.kernel.org/lkml/20220514220116.1008254-1-bhupesh.sharma@linaro.org/
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  - Rebased on linux-next/master.
> 
>  Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

I picked this one up so it can be fixed for rc1.

Rob
