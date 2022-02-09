Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986224B00B8
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236539AbiBIWyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:54:20 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiBIWyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:54:19 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6147BC0219EC;
        Wed,  9 Feb 2022 14:54:21 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id u3so4085026oiv.12;
        Wed, 09 Feb 2022 14:54:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6GbViqjX2s1KVg61FHQ0TVRuw5O1ks6inA3ssFWIfJ8=;
        b=VoHNza52R5PIdfeWJCoa4m3/M62C/gz/2J+sIyYKfDFuQ3st/40vj1TM/T/CmSdprP
         mjstMmvLoSWb5H2UbC5i3ntKrezNebBGKmgcewnK2d9ggA49xdRS/FksfVBDRhuv5FeH
         /Ge2GEBenq21cO/3wmDtsG2MQ/c2HpPaihIjMhNHr4CDGZSHdfLwpM1wxNsY5kAIoYQW
         BDx/HiyG2S9QNVhv0+kbjbiD5tzBn781MiwMDz5KdLtVTHJDUiRfa1lgrCXHsNQCaAtb
         Et6IU1lcLHfgQs5yEdGd8mE0w2jm4l8lyoNtLRE9JByUP5K2kKRAi8o5jtu93E1qmCYP
         3Zhw==
X-Gm-Message-State: AOAM530hB4op1fXnDcpFE/EQfzGUSNXhN9WYEy9rDcQo3cchTJhZBFsU
        +3S9RN74gkeskpOrAXDLng==
X-Google-Smtp-Source: ABdhPJxTGXgRssJw2GYnmEEUbCzvymNHxtSMoA4l0QobCAsPiTRJLeonWFEGnxjf3OjpdEJjkbBNHw==
X-Received: by 2002:a05:6808:1302:: with SMTP id y2mr2365158oiv.308.1644447260712;
        Wed, 09 Feb 2022 14:54:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p11sm7699220oiv.17.2022.02.09.14.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:54:20 -0800 (PST)
Received: (nullmailer pid 1099593 invoked by uid 1000);
        Wed, 09 Feb 2022 22:54:19 -0000
Date:   Wed, 9 Feb 2022 16:54:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        dri-devel@lists.freedesktop.org, Inki Dae <inki.dae@samsung.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-kernel@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        devicetree@vger.kernel.org, David Airlie <airlied@linux.ie>
Subject: Re: [PATCH 08/10] dt-bindings: display: samsung,exynos-hdmi: convert
 to dtschema
Message-ID: <YgRGGh6MZaTM3S9B@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-9-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-9-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:21 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos HDMI bindings to DT schema format.
> 
> The conversion includes also updates to the bindings, matching the
> current DTS and Linux driver:
> 1. Add required properties: VDD supplies, power-domains.
> 2. Add optional properties: HDMI-EN supply, ports.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/display/exynos/exynos_hdmi.txt   |  64 -----
>  .../display/samsung/samsung,exynos-hdmi.yaml  | 227 ++++++++++++++++++
>  2 files changed, 227 insertions(+), 64 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmi.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi.yaml
> 

Applied, thanks!
