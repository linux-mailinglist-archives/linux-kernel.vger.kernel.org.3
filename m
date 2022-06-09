Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 937A554556B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 22:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244007AbiFIUO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 16:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243951AbiFIUOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 16:14:55 -0400
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99269F552C;
        Thu,  9 Jun 2022 13:14:54 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id y12so23309750ior.7;
        Thu, 09 Jun 2022 13:14:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=piUBE++JRG9yWwuNvmCBzi3ehQlmnHS+QH9pFUr1+pk=;
        b=GJ2oa5wIVpLjzyVwnIy3c64HHmROlC4CEt9fIkwlbXtFy3wnLtJpLf1lGADJZ1rW3/
         LLzsekwTDy33WIHdb2DxbRf9RzMdW10X8UsEnJt3qiqk01yla9ql8Fv01R1yJHW9FyC1
         fwzqg/elgMVme10riV71rvQ0qFuQuxUJqXhdgjstSpgAPH/y72Uu/+eu+O6yoJGNH+kl
         fSeol0HwMiMfxji656TNZxKLVf/XtB1S/4mREg7vmhgFcCyPf+s8O/5kwDPisIf66Qje
         hPHNS1rk3aJvShba9ot+MDhjk97jGe9wWv7rAGeYzzKFxpqHkka67E4edcJMWTSLRxBw
         c4QQ==
X-Gm-Message-State: AOAM532NvSM++Cc/wQXGeWPx/eyLGruXEtx2PzFe+PoFHR090TblTWsT
        V4QpCaSngX7Q7D+t3nBGbudmhAGE3w==
X-Google-Smtp-Source: ABdhPJxXbwg7PCmF5Ut2aJoaikQsVVn8SNBKqY6YT/SGxz3mzeIpYGcuR/LFx2pMAx72R20MDOV/QQ==
X-Received: by 2002:a05:6638:3e94:b0:331:c614:ecb7 with SMTP id ch20-20020a0566383e9400b00331c614ecb7mr9583924jab.220.1654805693852;
        Thu, 09 Jun 2022 13:14:53 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id b8-20020a92a048000000b002d3a3a089b3sm10663316ilm.1.2022.06.09.13.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jun 2022 13:14:53 -0700 (PDT)
Received: (nullmailer pid 29307 invoked by uid 1000);
        Thu, 09 Jun 2022 20:14:52 -0000
Date:   Thu, 9 Jun 2022 14:14:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: mfd: qcom,tcsr: Add qcom,tcsr-mdm9615
Message-ID: <20220609201452.GA29231-robh@kernel.org>
References: <20220607133443.182468-1-krzysztof.kozlowski@linaro.org>
 <20220607133443.182468-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607133443.182468-2-krzysztof.kozlowski@linaro.org>
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

On Tue, 07 Jun 2022 15:34:43 +0200, Krzysztof Kozlowski wrote:
> Document the (already used) TCSR on MDM9615.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
