Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8045A5348CB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345954AbiEZCSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 22:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbiEZCSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 22:18:36 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A44FEBCE89;
        Wed, 25 May 2022 19:18:32 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-f2c8c0d5bdso728070fac.4;
        Wed, 25 May 2022 19:18:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=foKtAo1Y6c8pBShbBRC/eT2mMXJwcmjK24BpM2A5+YY=;
        b=I7g23EBWM/fjsNcrI4QKQQ8qjq9cwUpl0rKeq3C2guR5G4cuZOZ2HQJ1pDTLxin81j
         sEvb3x1wGalgxwfA3fq48OC+1rhp887HmhwRrW4oLqSUzqJPr3fuE4RXE91b4kFen5Fa
         6ijBFMlJHYCH9d0FAbsdmVrvU8sA1v5NFeOTcJyjviRM0Lg5vEMc/4c13G8wACjg2pz5
         ApxIo1PlUYHnGnqwfuHsYja7XFtFbT9H3lyKDHLjsIbMDJvVA6UnrPfF1BcKbPyPGZCu
         rSYf3qUabISFtpb1XvapzIWlTVc0A8qx4teEvKFxQmIHgTGObsZ5L46CKAmjVSW00lFj
         s12w==
X-Gm-Message-State: AOAM533DGJ6jJx7mg1mSNqJ7jyEBfsniKp7y5mxO8zsYytTPmRKIdu3j
        4AqIk/Md6srzFddcb4DOUA==
X-Google-Smtp-Source: ABdhPJyN1PIFUspamJD5BtNCQiHBXsHVhF75LCWNEgsitJZS4atmc2UVRuF+K4zZWAs5cXycsWMKIQ==
X-Received: by 2002:a05:6870:ec86:b0:f1:ae8d:357b with SMTP id eo6-20020a056870ec8600b000f1ae8d357bmr61223oab.138.1653531511976;
        Wed, 25 May 2022 19:18:31 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d14-20020a05680808ee00b00325643bce40sm241101oic.0.2022.05.25.19.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 19:18:31 -0700 (PDT)
Received: (nullmailer pid 2930650 invoked by uid 1000);
        Thu, 26 May 2022 02:18:30 -0000
Date:   Wed, 25 May 2022 21:18:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm QCS404 SCM
Message-ID: <20220526021830.GA2930597-robh@kernel.org>
References: <20220521164623.91322-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164623.91322-1-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:46:23 +0200, Krzysztof Kozlowski wrote:
> Document the compatible for Qualcomm QCS404 SCM.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
