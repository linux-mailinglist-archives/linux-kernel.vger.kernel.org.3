Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72C1540360
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344774AbiFGQIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 12:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344712AbiFGQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 12:08:10 -0400
Received: from mail-il1-f177.google.com (mail-il1-f177.google.com [209.85.166.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED5E443C9;
        Tue,  7 Jun 2022 09:08:10 -0700 (PDT)
Received: by mail-il1-f177.google.com with SMTP id a15so14520200ilq.12;
        Tue, 07 Jun 2022 09:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IcVu4WajHv6XPQv1yYvHjVGQzqBrXJ6uvkB7WM1ORUk=;
        b=06jDuZtUm01MYz6g1LpOV9IopS+hS3nFlha4QBir6X2SLNHdkZQqJujlorDcv/idcz
         h/yGfmS1/QP3LWTzOMuHrTrw4b2WntBUrsvg99jQfC6hKhisHR54XMqoaymxmZ/tJVF2
         CP+Pi6w6N0tGzBL2fCmh6n/ilPp7BPwil4DwHFmjnXV4q4Unnw3GBp1h9Lhg5mozixxE
         MIEghyTbZsApr9Bb4dbkY9wcgqFpNNY7lRwkRruwxxXqegXZjgoid/v8v0TBwaGd0iqU
         NLC8TUh+geIlb8bn6RIcLxHPoBLcchyaXOlLb5ZpQIzVYagYDAXNWN1gj3zNoXKsC09N
         G0+g==
X-Gm-Message-State: AOAM530bkhrNmgOAqICCVACUft0skGGROzAc8nY71p0IHyL5pAmUWkTj
        4hMXSXKB+eHOuoba3viBrQ==
X-Google-Smtp-Source: ABdhPJwkB6tWssEJWTfCQGirJEa1uIPrrUEYFGpmaCAPiwN8q4TlO6GszS0vcXmTn6BhoiBisqAo5w==
X-Received: by 2002:a05:6e02:1949:b0:2d3:c0fb:322 with SMTP id x9-20020a056e02194900b002d3c0fb0322mr17090293ilu.242.1654618089339;
        Tue, 07 Jun 2022 09:08:09 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id i11-20020a02b68b000000b0033167715cf9sm5989686jam.27.2022.06.07.09.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 09:08:08 -0700 (PDT)
Received: (nullmailer pid 3350333 invoked by uid 1000);
        Tue, 07 Jun 2022 16:08:07 -0000
Date:   Tue, 7 Jun 2022 10:08:07 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-sunxi@lists.linux.dev, linux-watchdog@vger.kernel.org,
        Maxime Ripard <mripard@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Hu Ziji <huziji@marvell.com>,
        linux-arm-kernel@lists.infradead.org, Chen-Yu Tsai <wens@csie.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-tegra@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-mmc@vger.kernel.org, Jonathan Hunter <jonathanh@nvidia.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] dt-bindings: Drop more redundant 'maxItems/minItems' in
 if/then schemas
Message-ID: <20220607160807.GA3350189-robh@kernel.org>
References: <20220606225137.1536010-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606225137.1536010-1-robh@kernel.org>
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

On Mon, 06 Jun 2022 17:51:36 -0500, Rob Herring wrote:
> Another round from new cases in 5.19-rc of removing redundant
> minItems/maxItems when 'items' list is specified. This time it is in
> if/then schemas as the meta-schema was failing to check this case.
> 
> If a property has an 'items' list, then a 'minItems' or 'maxItems' with the
> same size as the list is redundant and can be dropped. Note that is DT
> schema specific behavior and not standard json-schema behavior. The tooling
> will fixup the final schema adding any unspecified minItems/maxItems.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/memory-controllers/nvidia,tegra186-mc.yaml        | 3 ---
>  Documentation/devicetree/bindings/mmc/marvell,xenon-sdhci.yaml | 1 -
>  .../devicetree/bindings/watchdog/allwinner,sun4i-a10-wdt.yaml  | 1 -
>  3 files changed, 5 deletions(-)
> 

Applied, thanks!
