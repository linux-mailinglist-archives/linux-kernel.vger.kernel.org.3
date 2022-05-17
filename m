Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1A04529611
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiEQAag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiEQAab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:30:31 -0400
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D747940A1D;
        Mon, 16 May 2022 17:30:30 -0700 (PDT)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-d39f741ba0so22333345fac.13;
        Mon, 16 May 2022 17:30:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YQVN+0aN39IpaYMuebo1q6u+VmYpyIQaFAaYjEhhLfA=;
        b=U52Brx61F33swa/Llufb3G492DaDl4JD8pcdptn6PEGvevAM9LZoXFYZBPkgI+85tq
         LvZrfkV1kGT3VZqL22naunkhjaPXLkEU49z7Y6SOblXhwEcG6N/7gnUKAKtadFHn0ltm
         xfML5WtYZg8+GNQwEwYfKRk1HcnynyOyLA0VsiMa7/d7TOzdcA1YLhwTYHGYPlZqGma1
         KwFI8fwAFLD0WBc6gVMdeOgbvHi/NydMn2a7kep/XPPFJ4RVisah0HQvvrDPVbczwSmD
         SPTBMQ03n3NC/N7aTsBJ/DwZXjcitTmHOSaX7UtHaZYrKa72dauq5cHdl/OgBmhUf3z/
         B1Wg==
X-Gm-Message-State: AOAM531LP0tt3YhUkpBddLm3gJv425Ij3fBxcgheLQ1imEchGiTnuGXP
        /boNd4P3cWTKhCqt9k3GTA==
X-Google-Smtp-Source: ABdhPJzvuavi64CC+eyeNQXFNzzyGsrniCBrhGnBD6tQrOzFZuRr1TGa7uqPJjXXzOcujYRrHxvvEw==
X-Received: by 2002:a05:6870:e888:b0:f1:a0c6:a5be with SMTP id q8-20020a056870e88800b000f1a0c6a5bemr3947697oan.35.1652747430147;
        Mon, 16 May 2022 17:30:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r196-20020acaa8cd000000b00325cda1ffa5sm4319340oie.36.2022.05.16.17.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:30:29 -0700 (PDT)
Received: (nullmailer pid 3654685 invoked by uid 1000);
        Tue, 17 May 2022 00:30:28 -0000
Date:   Mon, 16 May 2022 19:30:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Heidelberg <david@ixit.cz>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>
Subject: Re: [PATCH 04/11] dt-bindings: pinctrl: qcom,pmic-gpio: add
 'input-disable'
Message-ID: <20220517003028.GA3654626-robh@kernel.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
 <20220507194913.261121-5-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507194913.261121-5-krzysztof.kozlowski@linaro.org>
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

On Sat, 07 May 2022 21:49:06 +0200, Krzysztof Kozlowski wrote:
> 'input-disable' is already used and supported by common pinctrl
> bindings, so add it also here to fix warnings like:
> 
>   arch/arm64/boot/dts/qcom/qrb5165-rb5.dtb: gpio@c000: lt9611-rst-state: 'oneOf' conditional failed, one must be fixed:
>     'input-disable' does not match any of the regexes: 'pinctrl-[0-9]+'
>     'function', 'input-disable', 'output-high', 'pins', 'power-source' do not match any of the regexes: '(pinconf|-pins)$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
