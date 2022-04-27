Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBD38512154
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229437AbiD0SpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 14:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbiD0SpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 14:45:06 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DEF3D891B;
        Wed, 27 Apr 2022 11:25:29 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id r1so2716729oie.4;
        Wed, 27 Apr 2022 11:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FsKq1stserEZzVCN2awh2jKdYumDzZmZFSRvm+soDl8=;
        b=5BfELmWNRYqbHsGCjprnN+C9Vgt/fPqXY+ksbufbQBuEdvG/YvfVQ37uY0jbrG6M/B
         AWuglRqKEaq2OjIDutjrdgFK5qDWmNKGb8+r2dPvz+xKNzPppyH9wuInpNF+cm3CdXTz
         BduZKL5I1gvAyItC8Xv7VvIN7ZW5xhL2yd1n4Lsk1uonQIwYR5539fjsenmurry/uMlh
         gkhWe87RhEqDrjPeHsWIUM6+8d/rmjh2VZumF/CPcCyRHt7K+7TL3Pf64IDGnIl1bcRT
         xpnkSYHqA29tApxJyuNO2ScOAw1vV0VsoKvMTi49laeCPl81U3DKTEaUeK/kRKEg9EzC
         HxRA==
X-Gm-Message-State: AOAM533o1O/1Qc3sD0iyHr7GcObmFZ3qlbYKn+m4V07nvlxAdf9Yr0JB
        n1z7D4qPIAuFUjtxow/Mbw==
X-Google-Smtp-Source: ABdhPJzQ2SbK7Xv9TeZI7HkgxHJNbFyUL2AOTzGbWNmH45NkPY+PWSkKrLbW/xrsnzpPd3c01+s3GA==
X-Received: by 2002:a05:6808:11cf:b0:2f9:b01b:1800 with SMTP id p15-20020a05680811cf00b002f9b01b1800mr17641981oiv.258.1651083928347;
        Wed, 27 Apr 2022 11:25:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p15-20020a4adfcf000000b0033a48bce3afsm6885319ood.18.2022.04.27.11.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:25:27 -0700 (PDT)
Received: (nullmailer pid 408056 invoked by uid 1000);
        Wed, 27 Apr 2022 18:25:27 -0000
Date:   Wed, 27 Apr 2022 13:25:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>, Ray Jui <rjui@broadcom.com>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Michal Simek <michal.simek@xilinx.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Scott Branden <sbranden@broadcom.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Liviu Dudau <liviu.dudau@arm.com>
Subject: Re: [PATCH 06/10] dt-bindings: mfd: samsung,exynos5433-lpass: fix
 'dma-channels/requests' properties
Message-ID: <YmmKl78AmUQ8JKJF@robh.at.kernel.org>
References: <20220427155840.596535-1-krzysztof.kozlowski@linaro.org>
 <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427155840.596535-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 17:58:36 +0200, Krzysztof Kozlowski wrote:
> pl330 DMA controller bindings documented 'dma-channels' and
> 'dma-requests' properties (without leading hash sign), so fix the DTS to
> match the bindings.
> 
> Reported-by: Rob Herring <robh@kernel.org>
> Fixes: e18183cefc8b ("mfd: Add DT bindings documentation for Samsung Exynos LPASS")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/mfd/samsung,exynos5433-lpass.yaml     | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
