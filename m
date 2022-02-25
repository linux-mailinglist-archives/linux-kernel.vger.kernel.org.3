Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36D24C473C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241717AbiBYOQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiBYOQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:16:46 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C125210473;
        Fri, 25 Feb 2022 06:16:14 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 12so7510463oix.12;
        Fri, 25 Feb 2022 06:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=u34k0AC5/CDX3ztycNN10YHu6FGX1mXLVB5DOobgxjQ=;
        b=3mnk1oF+UiVL/vyBmvaRpyjANF41RKqyqDD0IGKhgkAgWF24RGaImqUndKubkH5r9S
         wtLllIwBFfEjBka3glEcIRqTERAMP57PvFHzH4Tl2rumTzThe1sE8ECKoBnoMgybJkcb
         3qrKycpVzobw2JGXW4ukveHqRtmHjKFdYm63asGXSNJb4VJf0LEN3Lyv2pSv0r5inc8h
         t6TgCaLAhf2ndxT3pYSqgCwiKXe2mM2A0z0pg26fcI9T2dCJ1qoCyWW3XuyDaw9HH340
         3yZVeuSz2G/YxTb/7lrF10lYvW16gt5iZKBhFmSBrgKZsiedrijxUTjQUN6o2FjOgK7A
         uFFg==
X-Gm-Message-State: AOAM532p+mKbBsdHT1dvf8/fgl9kBHZZ0c9ri74fb1dipgf7Vl4PT+JC
        97cU5EuiQRMDbBQBnatzx0GVlLw4qA==
X-Google-Smtp-Source: ABdhPJzzMZgmxUhR8u/KeuADsvTo8SJ96KMpPuaxyVoSa5xh1WmCWCIHDMCoHioPv/3JyFd0UWO5OQ==
X-Received: by 2002:a05:6808:3027:b0:2cf:d108:b59 with SMTP id ay39-20020a056808302700b002cfd1080b59mr1592705oib.309.1645798573542;
        Fri, 25 Feb 2022 06:16:13 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id eq37-20020a056870a92500b000c6699dad62sm1357189oab.41.2022.02.25.06.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:16:12 -0800 (PST)
Received: (nullmailer pid 857895 invoked by uid 1000);
        Fri, 25 Feb 2022 14:16:07 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
In-Reply-To: <20220225053257.2479279-1-bjorn.andersson@linaro.org>
References: <20220225053257.2479279-1-bjorn.andersson@linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: qcom: Add sc8280xp TLMM binding
Date:   Fri, 25 Feb 2022 08:16:07 -0600
Message-Id: <1645798567.343483.857894.nullmailer@robh.at.kernel.org>
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

On Thu, 24 Feb 2022 21:32:56 -0800, Bjorn Andersson wrote:
> The Qualcomm SC8280XP platform contains a single block of registers
> for the TLMM block. This provides pinconf and pinmux for 228 GPIOs, 2
> UFS_RESET pins and one SDC interface.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
>  .../pinctrl/qcom,sc8280xp-pinctrl.yaml        | 153 ++++++++++++++++++
>  1 file changed, 153 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pinctrl/qcom,sc8280xp-pinctrl.example.dt.yaml:0:0: /example-0/pinctrl@3100000: failed to match any schema with compatible: ['qcom,sc8280x-tlmm']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1597478

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

