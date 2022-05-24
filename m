Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494AE532092
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:02:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232960AbiEXCCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiEXCCa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:02:30 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF30C762B3;
        Mon, 23 May 2022 19:02:29 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-e656032735so20734340fac.0;
        Mon, 23 May 2022 19:02:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BAGfHIAnZQsvxcqG9cwquf6XuYIEIVwkGs+71RVlXFA=;
        b=pUKaF9oJRyqNHayD0u/fUuT/S+rpQgaxwSz+m3R7fjElh9291oqeZPOSRc13FAlKp2
         bWPOgA4lD7Y8ac/CXSk0jHczjVk47vQ1P3xflTMtPOISC9tSJZ6/p0NGQl9Gq+7CKBdd
         93Ll3aqU0PQswE3XkNSgJCnGL4E4hWWAudkejODesVI3pn1QotN8UoZfqvQWmYXWauUZ
         xeOQE9w5Ur+353iRz2Ys+PHS0uJwYUrAxIasOLXHniZNSwEsiCB1KWS3YMVHST+5s5sg
         EI1BQxI9ufbQ+2dw/Z9w3/EmMvc1QOV1eb07e348Faxtl5HZobrYreGicM/VOWSOv/tV
         oe4Q==
X-Gm-Message-State: AOAM530oFbeiWIlu3FtdfCPlw5PW0zcrM7ICKcGRlTfd2/D6Jm/FAqbU
        WiI954PD76X6sfvay1RrFQ==
X-Google-Smtp-Source: ABdhPJwVnNjhXYTDE1spFwSoMaAMjAQJK1q/qQSk0NfNkHczMMsDMC3hKPBrx7fXI1djuycMQwjhHw==
X-Received: by 2002:a05:6870:a549:b0:f1:bb16:4e56 with SMTP id p9-20020a056870a54900b000f1bb164e56mr1163887oal.166.1653357749286;
        Mon, 23 May 2022 19:02:29 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l6-20020a056871068600b000e686d1389esm4592895oao.56.2022.05.23.19.02.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:02:28 -0700 (PDT)
Received: (nullmailer pid 2599659 invoked by uid 1000);
        Tue, 24 May 2022 02:02:27 -0000
Date:   Mon, 23 May 2022 21:02:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 05/12] dt-bindings: arm: qcom: add missing SDM630 board
 compatibles
Message-ID: <20220524020227.GA2599626-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-5-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:43 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
