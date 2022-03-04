Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B014CE0BA
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiCDXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCDXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:12:41 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B54C27C53E;
        Fri,  4 Mar 2022 15:11:45 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so11167464ooi.2;
        Fri, 04 Mar 2022 15:11:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VcvmzI8lPWcfjXO4cdTkfNwbnHj0syLj1nxodzWufVQ=;
        b=gGa2GwcL/biPXPaGpA6pp2RsXYWspBGUc/Lj4UUWYuSQUj9J/FZpBsdHiw8LZ2oS2R
         pOVi7IQwUEWVAYnpr6QaFnLB/+VjPHK0j8eJyxFBGtAtyySVkZ7tq/U+s9NNWkSYjVqQ
         dFDRpj0IO70T5nguiP9FmZ4ovKbKXd0gN+EQWmCIBvXgAPliP1et1f/9z+PkzhG7ADO1
         XEnb4rVXkx4bxIXjuV78GvXQZdtjjXAxJyZZT7vceSi8PU2iMWpbBXPvNioFy7xRHZTD
         XgpGzvDttaJzmnttNd6ev5awoDk19edkXzeeCkTrYRaNK7Hp9ZCSWWcOUGzE53tAc82t
         FXpA==
X-Gm-Message-State: AOAM532irfAX2GEb3bQwtiPX9SoJxXEq53OCsfkVH8d1m2CfDUxAq6yy
        Z64OiYWWr3clcGU7edvaNR11j9gkPw==
X-Google-Smtp-Source: ABdhPJxLKrurxY8nEivu7pB1E6b8CGAWAAjBgVkRTK4WXlxKtPNkUcmhr8ot2uYN10lImi/+22N42g==
X-Received: by 2002:a4a:4112:0:b0:319:3eb2:11b with SMTP id x18-20020a4a4112000000b003193eb2011bmr306154ooa.40.1646435504347;
        Fri, 04 Mar 2022 15:11:44 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k14-20020a4aa5ce000000b003203602ca63sm2818539oom.47.2022.03.04.15.11.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:11:43 -0800 (PST)
Received: (nullmailer pid 636835 invoked by uid 1000);
        Fri, 04 Mar 2022 23:11:42 -0000
Date:   Fri, 4 Mar 2022 17:11:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        phone-devel@vger.kernel.org, Stephen Boyd <sboyd@codeaurora.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom: Document asus,sparrow device
Message-ID: <YiKcrra910ZmdaGP@robh.at.kernel.org>
References: <20220226101939.1011551-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226101939.1011551-1-luca@z3ntu.xyz>
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

On Sat, 26 Feb 2022 11:19:38 +0100, Luca Weiss wrote:
> Document the ASUS ZenWatch 2 ("sparrow") which is a smartwatch based on
> Snapdragon 400 SoC.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
