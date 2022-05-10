Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69F575221C7
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 18:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347691AbiEJQ4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 12:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347700AbiEJQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 12:56:31 -0400
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C619227E3E3;
        Tue, 10 May 2022 09:52:33 -0700 (PDT)
Received: by mail-oo1-f45.google.com with SMTP id v33-20020a4a9764000000b0035f814bb06eso1177159ooi.11;
        Tue, 10 May 2022 09:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u22jnC0OoTDsN67xAaW7G39CrAN0b5e5jQ0qlFl5cGs=;
        b=5W+44L3uwR0Qb4tk74E/PBcHRTGYA6ny8pDxgR17EX2UhawRl2JS25NxtXF1U/sDim
         WEVczPOHbIK13QPbCu94U6jUHNyU9CEHre1bNAn6FB76cQgy5kr4hx1HJXbTOo3mZb6I
         7f5/jS8R1PR5TGHKfTkZi12dT9tw9QSPsLCEmJvC8+C1L5ZmeFd3ax3XTcyOQVNKT7yQ
         Suw1y966Wm+2T6w9CUNVNFXWaGph+cd50majvnO3RNz5AmeUALKb7I6uDGu27UE6CDKG
         ezqmDIcDoI3NE4tTkmiVsAEV4BvUoIeRTwK7T8VULrfBaXDWzMqh1owUW8s9JHhsclE1
         aQwg==
X-Gm-Message-State: AOAM531bEP1T6JRmkcFoVJfaGMnXJfh/YPDj2dEtjHUEUTxE1pqp5Xrs
        Rp1/oDZFBDV5leYXjZbERQ==
X-Google-Smtp-Source: ABdhPJxzgztr0qV3I9rOB+9f8tevAzG2uUcStC/v+7u3jSTSGu17L2SrTt3mnutsFpkzL0yFJqeHBQ==
X-Received: by 2002:a05:6830:280e:b0:606:ae45:6110 with SMTP id w14-20020a056830280e00b00606ae456110mr1455142otu.14.1652201553048;
        Tue, 10 May 2022 09:52:33 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z39-20020a056870d6a700b000eb639a5652sm4548667oap.37.2022.05.10.09.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 09:52:32 -0700 (PDT)
Received: (nullmailer pid 2183977 invoked by uid 1000);
        Tue, 10 May 2022 16:52:31 -0000
Date:   Tue, 10 May 2022 11:52:31 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        David Heidelberg <david@ixit.cz>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: pinctrl: qcom,pmic-gpio: add
 'gpio-reserved-ranges'
Message-ID: <YnqYTxjP1I3Lthke@robh.at.kernel.org>
References: <20220508135932.132378-1-krzysztof.kozlowski@linaro.org>
 <20220508135932.132378-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508135932.132378-2-krzysztof.kozlowski@linaro.org>
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

On Sun, 08 May 2022 15:59:29 +0200, Krzysztof Kozlowski wrote:
> 'gpio-reserved-ranges' property is already used and supported by common pinctrl
> bindings, so add it also here to fix warnings like:
> 
>   qrb5165-rb5.dtb: gpio@c000: 'gpio-reserved-ranges' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/pinctrl/qcom,pmic-gpio.yaml      | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
