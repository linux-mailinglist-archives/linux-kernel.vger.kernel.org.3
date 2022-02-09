Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3750D4B002B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 23:29:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235781AbiBIW3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 17:29:08 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235736AbiBIW2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 17:28:46 -0500
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B51E01526E;
        Wed,  9 Feb 2022 14:28:47 -0800 (PST)
Received: by mail-oi1-f182.google.com with SMTP id v67so4040543oie.9;
        Wed, 09 Feb 2022 14:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EwsIVdLEfVGoPBqdrgLhnimUnbXgmktMKOR1sSjl/NA=;
        b=I2Ws3i5FkGbj7x2lNfhzdoC2A3HpIA7UtrArxYFUqTSxL+zJfP19enci/L4RdtnmGp
         XxYLkVmQ5Rwis889TNTkXw7pWY+qqtxsSLzFVoZ0qTXtwBxKfB1Xyl4S/ATdc/k7QQVO
         3Xnrv8xTue0Nv7ntdGmsLc3rTDiRJ4MvEyg9agZkl8paFUD8l+j0HAW77++G6XazoY7F
         zzYsW1JCWXYjo6UlRMLnoi9GwTwGjy4fvLKcpYaR7aximlPYPpMo8Avqinq/rNwnGxFO
         c5kAckWV7hrsycMjogzumGQkn1o+oCgX3cuNPYYZhugE8jRHUZqHdfzrObn06e1/IG1b
         +6TQ==
X-Gm-Message-State: AOAM531c9AqQ2hayXwLXAuNY3wSdmduzg49l1aHaqYy5c+LgE2gVDNNJ
        sdu85UEVl7NqdePvFf1o7Usz5d/glEJ9
X-Google-Smtp-Source: ABdhPJwXeEEP8ZHw42f+Arl2+dsKF/Kx5gEjZkyRcS4vl+YGewrTUiYb/gG6eyh0erPXu4cr1yLEiw==
X-Received: by 2002:a05:6808:1598:: with SMTP id t24mr2269183oiw.50.1644445727247;
        Wed, 09 Feb 2022 14:28:47 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id y3sm7473612oix.41.2022.02.09.14.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:28:46 -0800 (PST)
Received: (nullmailer pid 1054786 invoked by uid 1000);
        Wed, 09 Feb 2022 22:28:45 -0000
Date:   Wed, 9 Feb 2022 16:28:45 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: Re: [PATCH 3/8] dt-bindings: phy: samsung,mipi-video-phy: convert to
 dtschema
Message-ID: <YgRAHeOA5m+rd9qu@robh.at.kernel.org>
References: <20220129193646.372481-1-krzysztof.kozlowski@canonical.com>
 <20220129193646.372481-3-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220129193646.372481-3-krzysztof.kozlowski@canonical.com>
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

On Sat, 29 Jan 2022 20:36:41 +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung SoC MIPI CSIS/DSIM DPHY bindings to DT schema
> format.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/phy/samsung,mipi-video-phy.yaml  | 113 ++++++++++++++++++
>  .../devicetree/bindings/phy/samsung-phy.txt   |  29 -----
>  2 files changed, 113 insertions(+), 29 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/phy/samsung,mipi-video-phy.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
