Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B515D4B00A3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbiBIWuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:50:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236315AbiBIWuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:50:00 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1698DE01925B;
        Wed,  9 Feb 2022 14:50:02 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id r27so4127086oiw.4;
        Wed, 09 Feb 2022 14:50:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WffXTGUWmaJ7sTpJG2IxQlCthN1RWy2Bou30UXKrVTo=;
        b=cM5NSeP1GXZDa06T5+9CQ5zuef8IJpsD6GVET0KClaJZwYkBKndpM0j/3mhMjtjH2N
         6bCJdqbTXy7VdH3oorfQ6Xv+wWGiHAf8U2wdOcxC5kLLjBbsjdePljEnV8cjd+Lnyd2f
         34jRX7n9Zon63mqdQvLuIP1Ge0uK8sqpsxsL2aDP+35t2box04FYQjg1bEk55Zn76S+o
         RUUrj+gKo6bTewMombgjjYMyIEQKg/keMqQDr1Q3nshcIeeWYxjbfagWh9cMLV4NVVla
         6KWdjxpSZ72Nn6a8fR1K6TR9tLs9s2pIhExGE14ZC5cM43+2QJNEGNkNq8LRDAIbJ5QB
         Lqdw==
X-Gm-Message-State: AOAM532w5w8b74wZbTmnnisIv9p/f6NgscTiyqZUtCvoLFbQCqa92wa3
        OG7g6/GGwi89+bT4AAOI6Q==
X-Google-Smtp-Source: ABdhPJx8mqDeUisKN1aZZaSd6vum38tFuwaTd5L7VHbg0gs7E9FGeM7654sTp6Au28nfs+jCy+Tauw==
X-Received: by 2002:a05:6808:d4a:: with SMTP id w10mr2153365oik.192.1644447001335;
        Wed, 09 Feb 2022 14:50:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id e16sm7174776otr.11.2022.02.09.14.49.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:50:00 -0800 (PST)
Received: (nullmailer pid 1091386 invoked by uid 1000);
        Wed, 09 Feb 2022 22:49:59 -0000
Date:   Wed, 9 Feb 2022 16:49:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     devicetree@vger.kernel.org, Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
        linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 06/10] dt-bindings: display: samsung,exynos-hdmi-ddc:
 convert to dtschema
Message-ID: <YgRFF899BNPaZE5F@robh.at.kernel.org>
References: <20220208171823.226211-1-krzysztof.kozlowski@canonical.com>
 <20220208171823.226211-7-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208171823.226211-7-krzysztof.kozlowski@canonical.com>
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

On Tue, 08 Feb 2022 18:18:19 +0100, Krzysztof Kozlowski wrote:
> Convert the Exynos HDMI DDC bindings to DT schema format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../display/exynos/exynos_hdmiddc.txt         | 15 -------
>  .../samsung/samsung,exynos-hdmi-ddc.yaml      | 42 +++++++++++++++++++
>  2 files changed, 42 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/display/exynos/exynos_hdmiddc.txt
>  create mode 100644 Documentation/devicetree/bindings/display/samsung/samsung,exynos-hdmi-ddc.yaml
> 

Applied, thanks!
