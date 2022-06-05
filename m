Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7676753DE5C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 23:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347674AbiFEVYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 17:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347602AbiFEVYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 17:24:10 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA012AC43;
        Sun,  5 Jun 2022 14:24:09 -0700 (PDT)
Received: by mail-qk1-f177.google.com with SMTP id br33so8011538qkb.0;
        Sun, 05 Jun 2022 14:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ba3lRMDd+3WFaPX0DEx2In5z5tlRJ5r1CBO5vDDJqPU=;
        b=resLYfLc5klTD0OE0yyERtkAPIsIIa3PmceYjgKUhtA4ssGH9Pxv7PRczdKXI7h6zX
         FunFTVULAV+ctI0eYT8147/S5h+N2uCZUFfwnBQh8jd1YwqSbmGAGgl8Oh6Mk5zuHYTr
         veQnBqrrkD8Ndvlk/o0b8DK0NBaE+XxJZIxzpg92sjSMbcqnFhuL4+lt/wn+M/Y7a/6U
         q8H0h69br+f5FucNfIIpms4scHqxOHHuCrLDn8oCzHoT2YN5eiabiu9SKqDX3LYp9j5o
         bEp+J6zpRukc6RxJP3/S7NzLuCoq68IHxL6fsCsYhno63mx2KU3R2iB80ek9GTPY1iLE
         zEMA==
X-Gm-Message-State: AOAM531Gpetm/pa3giNJpo81lQju8JX1lifDgIKN16jTqPmrDW7Q/Muj
        nxtAuz6y0DM/1/+8x1Uh2w==
X-Google-Smtp-Source: ABdhPJwHbigpNJ9BBh5xlV+1WffvJHwsucDLYpw50sQP6yiATxNp3EPoyBlRK/22F5prFaST/c/qmw==
X-Received: by 2002:ae9:e8c4:0:b0:6a6:ab86:47ac with SMTP id a187-20020ae9e8c4000000b006a6ab8647acmr6261971qkg.48.1654464248936;
        Sun, 05 Jun 2022 14:24:08 -0700 (PDT)
Received: from robh.at.kernel.org ([2607:fb90:ac97:ac63:b5fd:aa9:8d74:9989])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a291000b006a6bb044740sm1381308qkp.66.2022.06.05.14.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 14:24:08 -0700 (PDT)
Received: (nullmailer pid 3542674 invoked by uid 1000);
        Sun, 05 Jun 2022 21:24:05 -0000
Date:   Sun, 5 Jun 2022 16:24:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>, devicetree@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Thierry Reding <treding@nvidia.com>,
        linux-sunxi@lists.linux.dev, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH 3/3] dt-bindings: arm: Remove obsolete CPU enable methods
Message-ID: <20220605212405.GA3542627-robh@kernel.org>
References: <20220531045038.42230-1-samuel@sholland.org>
 <20220531045038.42230-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531045038.42230-4-samuel@sholland.org>
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

On Mon, 30 May 2022 23:50:38 -0500, Samuel Holland wrote:
> U-Boot has provided PSCI on Allwinner A31 and A23/A33 since May 2015,
> commit 014414f53695 ("ARM: sunxi: Enable PSCI for sun8i"). Since we can
> assume PSCI is available on these platforms, they no longer need custom
> CPU enable methods.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  Documentation/devicetree/bindings/arm/cpus.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
