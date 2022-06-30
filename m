Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABB5D562611
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiF3W1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbiF3W1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:27:04 -0400
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2122E9E5;
        Thu, 30 Jun 2022 15:27:03 -0700 (PDT)
Received: by mail-il1-f178.google.com with SMTP id 9so309603ill.5;
        Thu, 30 Jun 2022 15:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBKxCNRhOkrZGwnGEwmDsjzCy7lDzvvnANoEY4ngbjw=;
        b=J4cg7YsD8yLTIVgTc/0y7UO2tB//znqjMDFNsso6s76djyAHUTGTl/1uBKkP3GKoN9
         IXhQMmdwUkyHxwOTycwRX8WxclfA4RZV2FVMDRCKmZgD+xcG4H60XkcnQxSYzkJ2z6IK
         AAkuU5LRPyotOHKmH5mZWuimXmDgocZfSM8RKqFT2b8Geyx6UMrD6/a5+xZP/nQlZ/lp
         1oAcTjLKkP101HWn2Vr4jT5+FHFXxpr+/oSoV/lV64DiezPR/YMTypK4aOV5W/Z90Z1e
         UcJ20cVliI9XP9tjAfxQ9J1lo0iLVyULbUMKgUjzG2Qxaiy6IPTEkw+xA2EwEQz551i4
         ooTA==
X-Gm-Message-State: AJIora+lWgDwmolIlDCSyWKMWAH0mf2bTbj6VsF/DNJ9c0040Xea+W9Y
        H9d6MzKXv6U5sExNgz9mdA==
X-Google-Smtp-Source: AGRyM1tBT8xPwMFgikFk/n1MdNeRn/YegQVkOXJfjbomIWyQZar0n3sTGmbaGMOOmooIE3uXfvLD1Q==
X-Received: by 2002:a92:6c05:0:b0:2da:b9e8:24df with SMTP id h5-20020a926c05000000b002dab9e824dfmr6589346ilc.99.1656628022856;
        Thu, 30 Jun 2022 15:27:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b002d79f619517sm8470627ilq.26.2022.06.30.15.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 15:27:02 -0700 (PDT)
Received: (nullmailer pid 3436472 invoked by uid 1000);
        Thu, 30 Jun 2022 22:27:00 -0000
Date:   Thu, 30 Jun 2022 16:27:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiaEn Wu <peterwu.pub@gmail.com>, Pavel Machek <pavel@ucw.cz>,
        Dan Murphy <dmurphy@ti.com>
Subject: Re: [PATCH] dt-bindings: leds: class-multicolor: reference class
 directly in multi-led node
Message-ID: <20220630222700.GA3436416-robh@kernel.org>
References: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
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

On Fri, 24 Jun 2022 13:21:06 +0200, Krzysztof Kozlowski wrote:
> The leds/common.yaml is referenced directly in each LED node, which
> leads to people doing the same with leds/leds-class-multicolor.yaml.
> This is not correct because leds-class-multicolor.yaml defined multi-led
> property and its children.  Some schemas implemented this incorrect.
> 
> Rework this to match same behavior common.yaml, so expect the multi-led
> node to reference the leds-class-multicolor.yaml.  Fixing allows to add
> unevaluatedProperties:false.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> This will conflict with any new users of leds-class-multicolor, e.g.:
> https://lore.kernel.org/all/20220623115631.22209-4-peterwu.pub@gmail.com/
> 
> The new users should be updated to match the usage introduced here.
> ---
>  .../leds/cznic,turris-omnia-leds.yaml         |  2 ++
>  .../bindings/leds/leds-class-multicolor.yaml  | 32 +++++++++----------
>  .../devicetree/bindings/leds/leds-lp50xx.yaml |  2 ++
>  .../bindings/leds/leds-pwm-multicolor.yaml    |  5 ++-
>  .../bindings/leds/leds-qcom-lpg.yaml          |  2 ++
>  5 files changed, 24 insertions(+), 19 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
