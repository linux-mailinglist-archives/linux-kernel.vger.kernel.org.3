Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF3C533081
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 20:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240341AbiEXSef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 14:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234421AbiEXSed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 14:34:33 -0400
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C76B7F2;
        Tue, 24 May 2022 11:34:32 -0700 (PDT)
Received: by mail-ot1-f43.google.com with SMTP id n2-20020a9d6f02000000b0060b22af84d4so1646915otq.1;
        Tue, 24 May 2022 11:34:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjd8D9LIeadEp+4o52T4npY8wF40x2FBi1ttoFUutuI=;
        b=g10fsUuIGFqsx8TGMY1IH/8gvsxwE1Fj/UBOHqN7y3UF+quPt1Zf6UDdDHjR4xpl4m
         xy0HyPwxH6Up/uuiTb+qJJTkfirQgLOGE0CSe3S604xEBupMHJ+y+6qq6QGt1gZdXNjv
         qQq8YV8hWToDFL1SfuGUkKYPDKZUIM8owP0aX4hdwF7pL+OhOXMrOevZoubDcwblkIm/
         HTmyzxuDPMASzA2LFV9UDE8r4rpTV0TD340Hhq2lQN3E5JoCf+k+i2Fish+tK+/vIOD5
         0WjpflT7V018iLSl9mG0l8at4A5UP0Fd29FmsJHaoizXhlUEu7BC3J9CvNp8hsH5kMft
         JPLA==
X-Gm-Message-State: AOAM5318bBF6BwXUlOgr6Mq4VvsqjWgqAXyCpeg2HoXxu/olWDazFAcy
        mFrWhGeAsEQiBqvX56bWow==
X-Google-Smtp-Source: ABdhPJzWSIvUkNxANyL6S8yGql2pTikwMosJPy7ZGtOM7pUIJp5EfIaENUu1pLQfOdGLrJYjTedpcA==
X-Received: by 2002:a05:6830:44a7:b0:606:6bcc:f4c7 with SMTP id r39-20020a05683044a700b006066bccf4c7mr10863879otv.198.1653417272232;
        Tue, 24 May 2022 11:34:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r125-20020acada83000000b003289f51c2d7sm5614576oig.34.2022.05.24.11.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 11:34:31 -0700 (PDT)
Received: (nullmailer pid 4136645 invoked by uid 1000);
        Tue, 24 May 2022 18:34:30 -0000
Date:   Tue, 24 May 2022 13:34:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kyle Swenson <kyle.swenson@est.tech>
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: lp50xx: correct reg/unit
 addresses in example
Message-ID: <20220524183430.GA4134907-robh@kernel.org>
References: <20220524070815.42997-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524070815.42997-1-krzysztof.kozlowski@linaro.org>
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

On Tue, May 24, 2022 at 09:08:14AM +0200, Krzysztof Kozlowski wrote:
> The multi-led node defined address/size cells, so it intended to have
> children with unit addresses.
> 
> The second multi-led's reg property defined three LED indexes within one
> reg item, which is not correct - these are three separate items.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. Correct multi-led unit address as well (Rob).
> 
> Cc: Kyle Swenson <kyle.swenson@est.tech>
> ---
>  .../devicetree/bindings/leds/leds-lp50xx.yaml | 24 ++++++++++++-------
>  1 file changed, 15 insertions(+), 9 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
