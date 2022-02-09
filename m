Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129FF4B0033
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235568AbiBIW2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:28:33 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:59318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235512AbiBIW2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:28:25 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB12E01A22B;
        Wed,  9 Feb 2022 14:27:38 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id c7-20020a4ad207000000b002e7ab4185d2so4171999oos.6;
        Wed, 09 Feb 2022 14:27:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=n6Zt6SK7/DgvEPgyY5EWkTCnk1/VAko+dmm1b1fAfZQ=;
        b=4UZAZTnDGt9Wx5GMRdO5Y0m0tpO/ouPoPAbNLSYZ3TTkb2lX4mhriGuS1DBLtSet9o
         lKRFYYGrtVU1l85kvlapjpbp3AD2oYYpgIWTf1Qx63iJ3rfsyBHkPc3E68B0dRG19EZV
         pAGDwWnqz1d6iYTA4Dxm5KEaw2t/Dix4bJYJPWMPSmtn3xWxktI9vSFpz0Ft+HAeLISw
         V70fXd5QMThKACbnYebxLJyJYrWJqY6kvsfT+GMLzFXQDo6KQSbv5ptQ5ObiDYCGw6v+
         WCJhpB+kPC6vznUwgFc0J+y1xPwGDuFttNCqothxjykc8titS5DgIdBNgIWs3eS7blPb
         7/kw==
X-Gm-Message-State: AOAM533OrQbiCHBaD0ONiyb1O85nhSwy80H3B2OC/cNzM41hAIaa2xRC
        LWsQUr4jdY1eFZgkfVMUQQ==
X-Google-Smtp-Source: ABdhPJy7dGqenDB3i9wIAZwLtdKrAH1MJUGI4lcZUua+U7n9oq6gYXN9+EkElDvo+3JJyOoYQ6EmBQ==
X-Received: by 2002:a05:6870:1944:: with SMTP id m4mr1755572oak.341.1644445657652;
        Wed, 09 Feb 2022 14:27:37 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s64sm7227147oos.0.2022.02.09.14.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:27:37 -0800 (PST)
Received: (nullmailer pid 1052607 invoked by uid 1000);
        Wed, 09 Feb 2022 22:27:36 -0000
Date:   Wed, 9 Feb 2022 16:27:36 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH 2/8] dt-bindings: phy: samsung: drop old Eynos5440 PCIe
 phy
Message-ID: <YgQ/2C7tR/ceRsib@robh.at.kernel.org>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-2-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-2-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 20:36:40 +0100, Krzysztof Kozlowski wrote:
> The Exynos5440 PCIe phy support was removed in commit 496db029142f
> ("phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
> PCIe PHY") (with its own bindings), so drop the old bindings.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../devicetree/bindings/phy/samsung-phy.txt     | 17 -----------------
>  1 file changed, 17 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
