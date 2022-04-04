Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468664F1E77
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 00:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380435AbiDDVsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379391AbiDDRES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 13:04:18 -0400
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2687140A22;
        Mon,  4 Apr 2022 10:02:22 -0700 (PDT)
Received: by mail-oi1-f176.google.com with SMTP id q129so10701409oif.4;
        Mon, 04 Apr 2022 10:02:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KnM/3DeRUkghGL3B228lv8tjJAJo66tZo/nzV6jVUL8=;
        b=woe382QyJMhl9DaVmJVTx67a5NzPogC7+6pfXXLFKQcIQwagapfi0LCRzNCsJ8hVVn
         rp8m5FJ7/vohg747dNQ0s8hxMe0f4APnpVxpZm73WxCrkrv5rZBhmx4jJKF+36b1h9bP
         +m663ZgDm09R3bt0QW212tlvzQRFx7IaPaRBUM6c4+qTnw+/Cj8AkLTJi5b+0v4tNvZR
         dyXGiX4KmQcWUJrbFeXr4JSD99f6LvU/s9zbfc7Rb54iyWvDCoh7DLylB6SG+UpSsDDo
         aJJkP+im1EoyySgsxVHYln/G2vLUMfk9ESKJ/a8P+6xshBN5n3j8a408TfoAE8q7g1sm
         yIvA==
X-Gm-Message-State: AOAM533mlrFkfObwvFKtL7oG0x1y9RrBF/+E0llbgMl9/IKK+EV8wxzf
        uuhKkr8u2qqvd7Tm9OzM0tac9U28xg==
X-Google-Smtp-Source: ABdhPJwjAxbJ3KU0l9+VXRjxGhhRZm4agoSKxhMj4f9qcCrMs2dDJ+nBsX6ziJpkXNEm3ZrMKCAzUA==
X-Received: by 2002:a05:6808:2008:b0:2da:5b12:83ff with SMTP id q8-20020a056808200800b002da5b1283ffmr47508oiw.216.1649091740535;
        Mon, 04 Apr 2022 10:02:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t3-20020a05680800c300b002f935a7daa9sm4403437oic.19.2022.04.04.10.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 10:02:19 -0700 (PDT)
Received: (nullmailer pid 1527750 invoked by uid 1000);
        Mon, 04 Apr 2022 17:02:19 -0000
Date:   Mon, 4 Apr 2022 12:02:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-pm@vger.kernel.org,
        linux-gpio@vger.kernel.org, - <patches@opensource.cirrus.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        alsa-devel@alsa-project.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-media@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH] dt-bindings: Fix 'enum' lists with duplicate entries
Message-ID: <Ykskm27aWyHMGk5v@robh.at.kernel.org>
References: <20220401141247.2993925-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401141247.2993925-1-robh@kernel.org>
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

On Fri, 01 Apr 2022 09:12:47 -0500, Rob Herring wrote:
> There's no reason to list the same value twice in an 'enum'. Fix all the
> occurrences in the tree. A meta-schema change will catch future ones.
> 
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Thierry Reding <thierry.reding@gmail.com>
> Cc: Jonathan Hunter <jonathanh@nvidia.com>
> Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: Charles Keepax <ckeepax@opensource.cirrus.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Sebastian Reichel <sre@kernel.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Yunfei Dong <yunfei.dong@mediatek.com>
> Cc: - <patches@opensource.cirrus.com>
> Cc: linux-media@vger.kernel.org
> Cc: alsa-devel@alsa-project.org
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> There's also one other occurrence in snps,dwmac.yaml I didn't fix as
> there's a patch[1] for it which prompted this patch.
> 
> Rob
> 
> [1] https://lore.kernel.org/r/20220401030847epcms1p8cf7a8e1d8cd7d325dacf30f78da36328@epcms1p8
> 
>  .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml        |  1 -
>  Documentation/devicetree/bindings/bus/ti-sysc.yaml    |  1 -
>  .../bindings/media/mediatek,vcodec-encoder.yaml       |  1 -
>  .../devicetree/bindings/pinctrl/cirrus,madera.yaml    | 11 +++++------
>  .../devicetree/bindings/power/supply/bq2415x.yaml     |  1 -
>  5 files changed, 5 insertions(+), 10 deletions(-)
> 

Applied, thanks!
