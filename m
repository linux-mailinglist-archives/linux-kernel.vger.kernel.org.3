Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C814B006E
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:38:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbiBIWhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:37:54 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbiBIWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:37:52 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCAC1DF65E;
        Wed,  9 Feb 2022 14:37:54 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so4237050oot.4;
        Wed, 09 Feb 2022 14:37:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GQ1EzJlmJd0ZHanWZ4n0qIae0fuVJzefydO25vR7qkU=;
        b=7rh4h9TMpms74kMSJU9XxoXl+POH198A3PDN9lPDK8IBkh4qGC2TknRVl1u6tYXAUf
         x3VMJ0yDM5IY0rqNpLO54GS1BzvmfTvTp9OYfpPs1RESCbE1iMBjYijmVXQxCCQMAYE3
         XlMLNUprvK5xjuilhwvl78HyX/I2bZZK03lS5GRhSSdpSogPpncHnLDD3+TcyytPPTUk
         mlNhMKwo7ail6x13OIMNUM23Wfy4pKs2l2flvwtm1XxywkV82Km82YccsnS5nF2fruQi
         mQE3DI2aIblObIyw+zMBTX6CsUVWVcEhJSoZeJWknyfRqZ0+NucUuSHtR4MY5dlJACCz
         SNMw==
X-Gm-Message-State: AOAM530xy0hJUcMx7aZRcBHC2ux3ln7IE6N2vjXTrpkOchMJ8G0g+RkI
        z0tNWpQmo39ZcNn87pByyg==
X-Google-Smtp-Source: ABdhPJxT+1Zv0qJNE+ACROtN1X/wUItX4PE/QGNxPvgeCA2Yr/Tcep23vnamSkV/AfSRHRw1HzGSgg==
X-Received: by 2002:a05:6870:b146:: with SMTP id a6mr1663767oal.149.1644446274132;
        Wed, 09 Feb 2022 14:37:54 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ep17sm7669756oab.21.2022.02.09.14.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:37:53 -0800 (PST)
Received: (nullmailer pid 1070995 invoked by uid 1000);
        Wed, 09 Feb 2022 22:37:52 -0000
Date:   Wed, 9 Feb 2022 16:37:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Joonyoung Shim <jy0922.shim@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-samsung-soc@vger.kernel.org, linux-phy@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Inki Dae <inki.dae@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 03/10] dt-bindings: phy: samsung,exynos-hdmi-phy: convert
 to dtschema
Message-ID: <YgRCQKqYEEzGc4+N@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-4-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-4-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:16 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos HDMI PHY bindings to DT schema format and put them
> next to other PHYs.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../display/exynos/exynos_hdmiphy.txt         | 15 -------
>  .../bindings/phy/samsung,exynos-hdmi-phy.yaml | 44 +++++++++++++++++++
>  2 files changed, 44 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiphy.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-hdmi-phy.yaml
> 

Applied, thanks!
