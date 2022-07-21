Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8606D57D3E8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiGUTPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiGUTOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:52 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8ED8E6C9;
        Thu, 21 Jul 2022 12:14:33 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id u19so1290552ilk.7;
        Thu, 21 Jul 2022 12:14:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rnUF6Gy6VpMfHS+Y/JAesQ3fa3pZW6ZVysqfKdY729Q=;
        b=dwReHOx/y+UaUz2I6VMrvPGtfWNA7xHDW1Wx5MROkahBAMIaPgvTn1OYe3j/baoanL
         qVjZEx/OvyWa6wa9skOrwzPXWyXswZWtG2yqjurIuXHRWAP252mQdVLgoErAJCWqBs10
         DZtmsdms3ceMD4hpt2hHPMCiLeR2wwj3vi5N679nbTT7eewOIbkJEbhuIdqQFTdEeBSM
         NxaMugfNwCB3/dv0yd8JWgpsD2T+Uzmb3C1Anf6wvmxoUx2zw8j6G+127qxnblVODjCC
         IKpXi+fY5lbbmg82gqapPpsBzTHkHbRj8Hi59SzRlXpw9zAMZI5oc6XaiH/sKMbpED8h
         AQyQ==
X-Gm-Message-State: AJIora/3f5R6+oXChyF9swFNgQ8bRDGphz16NGER2YloxqeftuB3cdFL
        ZwXDZHkQSFXcT41+ZtCoLg==
X-Google-Smtp-Source: AGRyM1ua0b4erLheTeQOaOZ7pldoGU5sXIQ0afqynpiBInjJrJpsrVH5TjpMSxvjMUl+tJapAuE6tA==
X-Received: by 2002:a05:6e02:148c:b0:2dc:386c:9a1a with SMTP id n12-20020a056e02148c00b002dc386c9a1amr21918645ilk.188.1658430872261;
        Thu, 21 Jul 2022 12:14:32 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id g6-20020a02cd06000000b0033f3394cf9fsm1099667jaq.6.2022.07.21.12.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:31 -0700 (PDT)
Received: (nullmailer pid 1770426 invoked by uid 1000);
        Thu, 21 Jul 2022 19:14:30 -0000
Date:   Thu, 21 Jul 2022 13:14:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     agross@kernel.org, kuba@kernel.org, davem@davemloft.net,
        mturquette@baylibre.com, linux-kernel@vger.kernel.org,
        brgl@bgdev.pl, pabeni@redhat.com, yilun.xu@intel.com,
        khilman@baylibre.com, sboyd@kernel.org, devicetree@vger.kernel.org,
        mdf@kernel.org, narmstrong@baylibre.com, edumazet@google.com,
        robh+dt@kernel.org, linus.walleij@linaro.org, david@lechnology.com,
        bjorn.andersson@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        mathieu.poirier@linaro.org
Subject: Re: [PATCH v2] dt-bindings: Fix typo in comment
Message-ID: <20220721191430.GA1770309-robh@kernel.org>
References: <20220721011746.19663-1-slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721011746.19663-1-slark_xiao@163.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 09:17:46 +0800, Slark Xiao wrote:
> Fix typo in the comment
> 
> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> ---
> v2: Add all changes in one subsystem into 1 patch
> ---
>  Documentation/devicetree/bindings/arm/msm/qcom,saw2.txt       | 2 +-
>  Documentation/devicetree/bindings/clock/ti/davinci/pll.txt    | 2 +-
>  Documentation/devicetree/bindings/fpga/fpga-region.txt        | 2 +-
>  Documentation/devicetree/bindings/gpio/gpio-pisosr.txt        | 2 +-
>  Documentation/devicetree/bindings/net/qcom-emac.txt           | 2 +-
>  .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 2 +-
>  .../devicetree/bindings/pinctrl/aspeed,ast2400-pinctrl.yaml   | 2 +-
>  .../devicetree/bindings/pinctrl/aspeed,ast2500-pinctrl.yaml   | 2 +-
>  .../devicetree/bindings/pinctrl/aspeed,ast2600-pinctrl.yaml   | 2 +-
>  .../devicetree/bindings/power/amlogic,meson-ee-pwrc.yaml      | 2 +-
>  Documentation/devicetree/bindings/powerpc/fsl/cpus.txt        | 2 +-
>  Documentation/devicetree/bindings/powerpc/opal/power-mgt.txt  | 2 +-
>  Documentation/devicetree/bindings/remoteproc/qcom,q6v5.txt    | 2 +-
>  Documentation/devicetree/bindings/sound/tlv320adcx140.yaml    | 4 ++--
>  .../devicetree/bindings/thermal/brcm,avs-ro-thermal.yaml      | 2 +-
>  .../devicetree/bindings/thermal/nvidia,tegra124-soctherm.txt  | 2 +-
>  Documentation/devicetree/bindings/thermal/rcar-thermal.yaml   | 2 +-
>  17 files changed, 18 insertions(+), 18 deletions(-)
> 

Applied, thanks!
