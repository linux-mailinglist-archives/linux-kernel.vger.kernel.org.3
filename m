Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C9F14B00B3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:52:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236480AbiBIWwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:52:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:57714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiBIWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:52:08 -0500
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E93E01A21B;
        Wed,  9 Feb 2022 14:52:06 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id y23so4084453oia.13;
        Wed, 09 Feb 2022 14:52:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=81LsmVmsIyFRiRR0GZyYCY+f6XNSwVWGjlc1C5pOq40=;
        b=S/fkDgTJ1dxFYgUiOcVrZYgCBj6AxucjVZFVScTGsIrJMr7Beb/f+SFBBvnbiGaqzE
         s4gG2GNLxsr/F5plgJNq0dzNjHXnb3O3XG2xsMxxndtXmPCnbK0sdcH4yI3KldK3FGW3
         yYkIL+wvq3y0IRRbZnNNh/zO5/mMTM9bnF687Muh/dAdbTwFJhRWO0Qz41JvAhL50HIn
         sOEEfnqXp9PS2xNLspgnmWkeSixK/ZYmJ3in3PtOxSMFZGTRCjF9keLlsuAh9Y8k8mp7
         d3kP+fvkcMmu6t7h92XnBHvstbgEFzUzRtp5QPpHaGadT0q3YdncXX+lFqVsmyxF4Up6
         dd0g==
X-Gm-Message-State: AOAM532NEsyqmXj1pNI6vqjWfcrWHG0x8laxBH687dawLlOiO4QPbFBI
        fJWKpHUqyFm4O+ff9Mbjjw==
X-Google-Smtp-Source: ABdhPJxhDG37kNewELAxYMxYsCIOApDp892YsjkBS8cWBqFp2a6lGLrKakiPXdho3A+kprdu+INhvA==
X-Received: by 2002:a05:6808:1154:: with SMTP id u20mr2513366oiu.169.1644447125325;
        Wed, 09 Feb 2022 14:52:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 100sm7174314oth.75.2022.02.09.14.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:52:04 -0800 (PST)
Received: (nullmailer pid 1095802 invoked by uid 1000);
        Wed, 09 Feb 2022 22:52:03 -0000
Date:   Wed, 9 Feb 2022 16:52:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Inki Dae <inki.dae@samsung.com>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 07/10] dt-bindings: display: samsung,exynos-mixer:
 convert to dtschema
Message-ID: <YgRFk12N+lLo0WL/@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-8-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-8-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:20 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos Mixer bindings to DT schema format.
> 
> The conversion includes also updates to the bindings, matching the
> current DTS and Linux driver:
> 1. Add clocks required on Exynos4210 and Exynos4212 types of Mixer.
> 2. Add second memory range on Exynos4210 and Exynos4212.
> 3. Add interconnects, iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/display/exynos/exynos_mixer.txt  |  26 ----
>  .../display/samsung/samsung,exynos-mixer.yaml | 143 ++++++++++++++++++
>  2 files changed, 143 insertions(+), 26 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_mixer.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-mixer.yaml
> 

Applied, thanks!
