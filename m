Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 556525348BE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbiEZCQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346095AbiEZCQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:16:31 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A236BFD3;
        Wed, 25 May 2022 19:16:30 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e656032735so770151fac.0;
        Wed, 25 May 2022 19:16:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=134oiLvxGnZg4992RkdYIVwC/5Bje3TWeWd2oKYxL0Q=;
        b=blX7+wqJXdCxqZ634YU8m844VBLTJQTwUSMrHYSRnDLTK2uTFcgcLdWUfNVxCV0Aok
         CbMwGw17vvY+S0X5Fql5PGHO2M/irGTvu1N8WRRIZteEfSrqRQYojlJ/gFP4f25Loznj
         IfFnjBZh/nWUmbMC+S6ENW3NB4HWMuljcuDhgGBKaZIxV0pWSPaUgy32SEWwDHndDzIf
         t/mjS0goejavcJvAofIDuEZ0mR1px/VRnVu8z0GkQ+Q0rIEgbbT9o0n9Bgo5XC2oC2Gf
         Jhg+cItnwN84hdwf6BG02qOE1Q5XTZm0DJzZw9+f9PsMpJBVqBNKCcSeTIP3cgapW+f+
         I47g==
X-Gm-Message-State: AOAM533HQO/cyEE5EM/dC+xPNuz9aWAYn7Hz0T0xUULruBavo47iLnAq
        EtoqNttQwqZ3/it+T8n+0KA8jUiRbQ==
X-Google-Smtp-Source: ABdhPJwrerWesM5d+JRU5y0Af59Y7nk0eL0Xh4d/Oo2QMyu3Tlu9Kh0wWVWQOFZXtIgKGqxMmpxHPA==
X-Received: by 2002:a05:6870:45a5:b0:ee:1742:1be3 with SMTP id y37-20020a05687045a500b000ee17421be3mr55409oao.170.1653531389872;
        Wed, 25 May 2022 19:16:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id hl8-20020a0568701b0800b000f2c4ebb832sm188868oab.10.2022.05.25.19.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:16:29 -0700 (PDT)
Received: (nullmailer pid 2927383 invoked by uid 1000);
        Thu, 26 May 2022 02:16:28 -0000
Date:   Wed, 25 May 2022 21:16:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Rob Herring <robh+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH 9/9] dt-bindings: arm: qcom: add missing SM8350 board
 compatibles
Message-ID: <20220526021628.GA2927331-robh@kernel.org>
References: <20220520123252.365762-1-krzysztof.kozlowski@linaro.org>
 <20220520123252.365762-9-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520123252.365762-9-krzysztof.kozlowski@linaro.org>
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

On Fri, 20 May 2022 14:32:52 +0200, Krzysztof Kozlowski wrote:
> Document several board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
