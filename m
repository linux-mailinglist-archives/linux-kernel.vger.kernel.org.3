Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFA44CE14A
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 00:59:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiCDX7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 18:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiCDX7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 18:59:48 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53531F1AF2;
        Fri,  4 Mar 2022 15:58:59 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id y7so9454363oih.5;
        Fri, 04 Mar 2022 15:58:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3vaokBMj/J8kbDel9BxGln/8gBsCxja7J1uSkU+kzXA=;
        b=uJ8rG7gNSh8IHL8cFUGqs1fTQkTje+iH3EKQ7c3x22LnoMPHB3SnH+FQsOwSPI/VOG
         cnc/4W8WdijbfF6MtWGPuNBcmygK4odWKxj7ktPY7+kxG+1otNcTcvh0aRksnKVl3O1A
         l2neTdxZhZ84CSv7EvpQUbGyrVVUsihgzGnQ0qSLx5GA/FSg/v3gcdS2W1qMnykAXiYB
         wJA2T9vq2eBWgPV5ymljFcyGrNubpV4PIXXApqh1+6lZHw6ynivn80u10PE/bQWd/qf/
         Vu7xZ2T3LZ+RZUhYx4uP0hpXjAmh7CiEdzOMSZATG3FMsdSAxvsMfRLfOobkasyk+/Pf
         QBDA==
X-Gm-Message-State: AOAM532nZ+MTxDXj5aj3owM06mJbWLv4rbQqN4DNhnlPVZ4t3E2JoU8V
        8/5m9bT4ApQEbQgiNiQGVA==
X-Google-Smtp-Source: ABdhPJwgFu6dD1NTwa+Ou26TV2rAcT5cOmUnEJv+rdOqUmRd59DkF1MPbe8UFQT7YLwYY/JvNusJDQ==
X-Received: by 2002:a05:6808:3008:b0:2d9:a0c7:dd3c with SMTP id ay8-20020a056808300800b002d9a0c7dd3cmr534141oib.181.1646438338651;
        Fri, 04 Mar 2022 15:58:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id ex5-20020a056870ed4500b000a8853e8651sm2922799oab.23.2022.03.04.15.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:58:58 -0800 (PST)
Received: (nullmailer pid 721760 invoked by uid 1000);
        Fri, 04 Mar 2022 23:58:57 -0000
Date:   Fri, 4 Mar 2022 17:58:57 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, shawn.guo@linaro.org, vkoul@kernel.org,
        linux-phy@lists.infradead.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Subject: Re: [PATCH v2 7/8] dt-bindings: phy: qcom,qmp: Describe phy@ subnode
 properly
Message-ID: <YiKnwTZXev/ciErl@robh.at.kernel.org>
References: <20220228123019.382037-1-bhupesh.sharma@linaro.org>
 <20220228123019.382037-8-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220228123019.382037-8-bhupesh.sharma@linaro.org>
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

On Mon, Feb 28, 2022 at 06:00:18PM +0530, Bhupesh Sharma wrote:
> Currently the qcom,qmp-phy dt-binding doesn't describe
> the 'reg' and '#phy-cells' properties for the phy@ subnode.
> 
> Fix the same.
> 
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> index 70e7cd75e173..f8a43acd229a 100644
> --- a/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> +++ b/Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml
> @@ -115,6 +115,13 @@ patternProperties:
>        Each device node of QMP phy is required to have as many child nodes as
>        the number of lanes the PHY has.
>      properties:
> +      reg:
> +        minItems: 1
> +        maxItems: 6

You need to define what each entry is.

> +
> +      "#phy-cells":
> +        const: 0
> +
>        "#clock-cells":
>          enum: [ 0, 1, 2 ]
>  
> -- 
> 2.35.1
> 
> 
