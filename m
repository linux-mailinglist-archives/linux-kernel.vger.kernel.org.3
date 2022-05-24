Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB2C53209F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 04:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233036AbiEXCE1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 22:04:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233022AbiEXCE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 22:04:26 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D674D95DE2;
        Mon, 23 May 2022 19:04:24 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-edeb6c3642so20674508fac.3;
        Mon, 23 May 2022 19:04:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=N0zLUHV5HQZJRuniC3/7vxtGft5GLwuurd3z/KjkOYA=;
        b=yL1iBXThZateSEyu6mtHzzpmvvuWKGTh5qaV7+OatKGB5RuLj5ns//DeGsA04Pqbk1
         dAKNR8g+InBELdCg0eCBIY/0MXiKdnjIozE/DlbAI/VYsB348oc3vQIKaXTjV9Pt3zOb
         Nxp9yOjMchFOWeunv8b7KGdp08gNMAnFpP3r5CkYAG0ldPMbljQ6AKbvgsfB60wRyAiQ
         NSAGBpsNf0c89F4F0kTpnOHDM10E4yOsjypM/lyeXU3zOBRexFMYZs2meLTAzjSQvZG6
         JAt/czFrc5xH6dciVGAuo4AOHX2VKE3Hut6hKtY1BdBXTf57OwwU1vVshdpcB8qUnAi4
         +XnA==
X-Gm-Message-State: AOAM531T88FhKwBSkIG8rvIz+JnM3BlfYOIDSkmeP8TK8V2yv5Y+YMxp
        B5cCI68uWl1nEXNHB/gzMvM+acs/9g==
X-Google-Smtp-Source: ABdhPJzc83ILmeCGs6GwtXj9L5Lfk0v3QyLPCpftkSfOWyq1Ont2IGnAGrKE58KSeJOJWqVJaiDkdA==
X-Received: by 2002:a05:6870:c390:b0:f1:6a3a:227b with SMTP id g16-20020a056870c39000b000f16a3a227bmr1219146oao.142.1653357864072;
        Mon, 23 May 2022 19:04:24 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h6-20020a9d5546000000b0060b088dcbeesm2770482oti.27.2022.05.23.19.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 19:04:23 -0700 (PDT)
Received: (nullmailer pid 2603318 invoked by uid 1000);
        Tue, 24 May 2022 02:04:22 -0000
Date:   Mon, 23 May 2022 21:04:22 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 08/12] dt-bindings: arm: qcom: add missing SM6125 board
 compatibles
Message-ID: <20220524020422.GA2603253-robh@kernel.org>
References: <20220521164550.91115-1-krzysztof.kozlowski@linaro.org>
 <20220521164550.91115-8-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220521164550.91115-8-krzysztof.kozlowski@linaro.org>
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

On Sat, 21 May 2022 18:45:46 +0200, Krzysztof Kozlowski wrote:
> Document board compatibles already present in Linux kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
