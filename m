Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30BF8529603
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239643AbiEQA2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235922AbiEQA2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:28:13 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A702E6AF;
        Mon, 16 May 2022 17:28:12 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id w130so20697536oig.0;
        Mon, 16 May 2022 17:28:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I/PRWeG1YnE/JwHQMwD1ihP3Nmk0QEXI09vnmmG1I/c=;
        b=Guq3jDhYFHr95e6ceON9DkOiTynAUJYiI97RivVaE0O6tGDjq4KMiUTNE/1qHaMHeI
         86D+dkkMVZe4q9pz1ODYMRMMAhWXcbK7T2EVebHvQZPdMmJ/Uwbv3XyjEpQn2rZwbphO
         aEk21DyEXf95Uq6gmES8JLfg62VZA36udsgcpNZPb8dx/Zxl+jyo/YT7Hgn1ffzJdP+n
         aH2SjwzbWrEw2Xj2VHqi2+ZZ53/EG31DP6kDKIHmnij0zmzYLyWl8CD1qNLy8wvGcWgX
         lGe7t4hUXZmo41P9dKsjhddj3tphnk2DnONH4SPYyvh3ddmOS362py0BhLbdmo7KWHrU
         Mgsg==
X-Gm-Message-State: AOAM531fdi3SsgaYsFtU7eRFlMsbBNO0dptTbBglcZa6G3462h75dy14
        kp6yM46Eg2r4oG4743icNw==
X-Google-Smtp-Source: ABdhPJwvzVvygq2R77xdkS3Qd2tI9QqB+QUPnXu1a1IvA0UAspMLsaoDdmtMdWPZ4suAnNykk0La4Q==
X-Received: by 2002:a05:6808:d49:b0:328:ed5c:f8da with SMTP id w9-20020a0568080d4900b00328ed5cf8damr5388314oik.64.1652747291482;
        Mon, 16 May 2022 17:28:11 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id eg1-20020a056870988100b000edf5a12baasm5990009oab.46.2022.05.16.17.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:28:10 -0700 (PDT)
Received: (nullmailer pid 3650380 invoked by uid 1000);
        Tue, 17 May 2022 00:28:09 -0000
Date:   Mon, 16 May 2022 19:28:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        David Heidelberg <david@ixit.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: [PATCH 01/11] dt-bindings: pinctrl: qcom,pmic-gpio: document
 PM8150L and PMM8155AU
Message-ID: <20220517002809.GA3650315-robh@kernel.org>
References: <20220507194913.261121-1-krzysztof.kozlowski@linaro.org>
 <20220507194913.261121-2-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220507194913.261121-2-krzysztof.kozlowski@linaro.org>
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

On Sat, 07 May 2022 21:49:03 +0200, Krzysztof Kozlowski wrote:
> Add missing compatibles for devices: PM8150L and PMM8155AU.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,pmic-gpio.yaml | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
