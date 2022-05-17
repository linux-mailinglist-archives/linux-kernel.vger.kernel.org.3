Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0E8D529609
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239358AbiEQA3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiEQA3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:29:52 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B0E034B91;
        Mon, 16 May 2022 17:29:51 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e656032735so22445953fac.0;
        Mon, 16 May 2022 17:29:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=32BN2l95v5LBFwP+AcZKEqGfbkDadjTJoyyDGNFPxQM=;
        b=VbZ10BrM8AE3DHAI51XqI5ok6QXju2sMlcb1x6gTlPen0uTkZ5lqKzKTbVmYPYEeJy
         jxjzjuhShynciCV7/VVY1mo1OSzCEUPq97VdmSm3Vzf5yvtK2vkU4Az/36wfgBF4t5Sz
         ih+89pQDHXgjx/lafNfcHaJ7vWkCp/vjR6QfbZtq+asIxaG95UgMrFn5Y+hdwaflV7ql
         ZSahgDmMGXcwcUxD+nestMrjl8/bk6k9eWAhtdNartqsKytbR5lvsByR9RiMvsxobzNF
         ViLRmblqu402DGXAHwMA/XVz6jZ4nvafOz1qL5OhIuJ3c0iToJ4EOnWof8Jl/JmGNeuk
         9Rug==
X-Gm-Message-State: AOAM53268wgdm6xCSY9PYMA3Hi2JeMq7UlO5wRFjEyI3OBwURcO1etN3
        ez/6+ZnJKJ5rXOmjZoYkpg==
X-Google-Smtp-Source: ABdhPJwJNP780hacDuD1Sy2w8SJ30U2bMvAzR04NornuZH0/B0/KmEJNmyUu//HZqaVStkAhjQtvcQ==
X-Received: by 2002:a05:6870:e2d5:b0:f1:99d1:1cb1 with SMTP id w21-20020a056870e2d500b000f199d11cb1mr4531744oad.153.1652747390935;
        Mon, 16 May 2022 17:29:50 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id o14-20020a056870910e00b000f193e656c5sm3001168oae.15.2022.05.16.17.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:29:50 -0700 (PDT)
Received: (nullmailer pid 3653400 invoked by uid 1000);
        Tue, 17 May 2022 00:29:49 -0000
Date:   Mon, 16 May 2022 19:29:49 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Heidelberg <david@ixit.cz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Stephen Boyd <sboyd@codeaurora.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: pinctrl: qcom,pmic-gpio: fix matching
 pin config
Message-ID: <20220517002949.GA3653337-robh@kernel.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
 <20220507194913.261121-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507194913.261121-3-krzysztof.kozlowski@linaro.org>
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

On Sat, 07 May 2022 21:49:04 +0200, Krzysztof Kozlowski wrote:
> Matching PMIC GPIOs config nodes within a '-state' node by '.*' pattern
> does not work as expected because of linux,phandle in the DTB:
> 
>   arch/arm64/boot/dts/qcom/msm8994-msft-lumia-octagon-cityman.dtb: gpios@c000: divclk4-state: 'oneOf' conditional failed, one must be fixed:
>     'pins' is a required property
>     'function' is a required property
>     'pinconf' does not match any of the regexes: 'pinctrl-[0-9]+'
>     [[2]] is not of type 'object'
> 
> Make the schema stricter and expect such nodes to be either named
> 'pinconfig' or followed with '-pins' prefix.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml          | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
