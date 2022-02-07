Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD134ACBB4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:57:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243286AbiBGV5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239942AbiBGV5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:57:43 -0500
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83015C061355;
        Mon,  7 Feb 2022 13:57:42 -0800 (PST)
Received: by mail-oi1-f179.google.com with SMTP id v67so18550090oie.9;
        Mon, 07 Feb 2022 13:57:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CIT/zYqj4KmVgAn5vqAR/pRlBWKndIBHim2BVa6q7Ls=;
        b=KSGmF6KvTFIGClFbVC3UbOKuK6wZ2DbdRiAOtOkGAFEry/ORZRT99drWOO+cADiv0x
         pnNM3IQCej43FDiEGISd3ceHfQ7ggyYlq3b/CsNOKSt+ypOst7nKxEqa880w9vxvHA21
         GOqaKCsGWJtL+5c0hZmec7p/PYO5/ABP+r/p4lxsz5S9yxnynHZ9idReRU66POybc0vB
         WN69yaRvxymPw+3Xs4xSNtDmXg+WANHVM3h6ro6UQAOaiFrHb6VWK13220WE+7FshSW3
         qWH22e+439MpoHaSVvYLDq+dbnOYc+HDhTtx2LMgQQRChxAvSDVp99MgAaWfU0a2EWZR
         mTEA==
X-Gm-Message-State: AOAM530km0pAE625xOUzASKOIpKgsfG/azU2NV+KPPk1YT3AmGYSqJ1S
        uxLmwM6o823c8yt3B6/UFw==
X-Google-Smtp-Source: ABdhPJwTY5WUNnR2oOLu+PEJubSNdTF2LEaIPZoKmZNu5fb1bdtr6OBaXStUltyISA4pM2kJzMAO9w==
X-Received: by 2002:a05:6808:ec4:: with SMTP id q4mr485990oiv.326.1644271061869;
        Mon, 07 Feb 2022 13:57:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y19sm4589626oti.49.2022.02.07.13.57.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:57:40 -0800 (PST)
Received: (nullmailer pid 996196 invoked by uid 1000);
        Mon, 07 Feb 2022 21:57:38 -0000
Date:   Mon, 7 Feb 2022 15:57:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 0/8] dt-bindings: memory: convert to dtschema
Message-ID: <YgGV0jz9qlbQUk8/@robh.at.kernel.org>
References: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220206135807.211767-1-krzysztof.kozlowski@canonical.com>
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

On Sun, Feb 06, 2022 at 02:57:59PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes since v2:
> 1. Re-order patches so timings get converted earlier. This fixes dt-checker
> robot report.
> 2. Add Dmitry's review tag.
> 3. Three new patches:
>    #6: dt-bindings: memory: lpddr3: deprecate passing timings frequency as unit address
>    #7: memory: of: parse max-freq property
>    #8: ARM: dts: exynos: remove deprecated unit address for LPDDR3 timings on Odroid
> 
> Changes since v1:
> 1. Drop patch 1 (ARM dts) - applied.
> 2. Correct description in lpddr2-timings (Dmitry).
> 
> Best regards,
> Krzysztof
> 
> Krzysztof Kozlowski (8):
>   dt-bindings: memory: lpddr2-timings: convert to dtschema
>   dt-bindings: memory: lpddr3-timings: convert to dtschema
>   dt-bindings: memory: lpddr3: convert to dtschema
>   dt-bindings: memory: lpddr3: adjust IO width to spec
>   dt-bindings: memory: lpddr3: deprecate manufacturer ID
>   dt-bindings: memory: lpddr3: deprecate passing timings frequency as
>     unit address
>   memory: of: parse max-freq property
>   ARM: dts: exynos: remove deprecated unit address for LPDDR3 timings on
>     Odroid

Reviewed-by: Rob Herring <robh@kernel.org>
