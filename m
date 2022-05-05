Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07A4551C262
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379212AbiEEO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380610AbiEEO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:26:49 -0400
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F28F5A59A;
        Thu,  5 May 2022 07:23:10 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id l16so4473806oil.6;
        Thu, 05 May 2022 07:23:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2Taau8ka7vhSeyIzrAdEH+RWRel/8zyWmnArViOK7Lc=;
        b=5FmOGNWoeYyCQRrzf8Maw74S0PSj5Wh8blgwSUMhBn4YHaNbPAhsprZgBbnl6w6GGu
         nhFeP7tFY87Zp91rDkus0sgKqmvhdpersAoSPL41x5zCR28W7B+0h3Ew5a/sK+pUqK18
         NwWzkG0R3p1TsCidbB5PII5hYQuJxWaKuKlGiuSuH6I8EWrn9axVODFTPT1xdJG/Q9cQ
         u73LzobVKIyvOsULn5wRg4HkyjyhnbkDwcSQkgbVp02QX1wAYvdq8eB6nDPm3UIVINGJ
         XDAiUSgHzDHtrjO62bUtosi7y7ZpVxP/Mx8UBwTKCfWP2A1n9YFBy+LlpdZE/JYT3NqV
         Lj1g==
X-Gm-Message-State: AOAM533oIDJmMAl5dIZgXN2Kwm0U6AR2end+5zL574spvQdRSDv5PNbh
        ZWGTJZA76DFrBDkyiI8FXA==
X-Google-Smtp-Source: ABdhPJxuao5+60YMfK95+X4uxsKmPVX85pl3N5ZYvDex79fllcKvzasLz/UxIh5HUKdzw9eZjo+Elw==
X-Received: by 2002:a54:4119:0:b0:325:a6dc:efae with SMTP id l25-20020a544119000000b00325a6dcefaemr2469602oic.100.1651760589915;
        Thu, 05 May 2022 07:23:09 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z14-20020a056870e30e00b000e7a517df41sm548757oad.13.2022.05.05.07.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 07:23:09 -0700 (PDT)
Received: (nullmailer pid 3827231 invoked by uid 1000);
        Thu, 05 May 2022 14:23:08 -0000
Date:   Thu, 5 May 2022 09:23:08 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Manu Gautam <mgautam@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH 03/13] dt-bindings: usb: qcom,dwc3: add IPQ8074, MSM8994,
 QCS404 and SM6125
Message-ID: <YnPdzLUqIE7FlmbN@robh.at.kernel.org>
References: <20220504131923.214367-1-krzysztof.kozlowski@linaro.org>
 <20220504131923.214367-4-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504131923.214367-4-krzysztof.kozlowski@linaro.org>
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

On Wed, 04 May 2022 15:19:13 +0200, Krzysztof Kozlowski wrote:
> Add compatibles for dedicated USB DWC3 blocks on Qualcomm IPQ8074,
> MSM8994, QCS404 and SM6125.  They differ against other variants in clock
> and/or interrupts.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/usb/qcom,dwc3.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
