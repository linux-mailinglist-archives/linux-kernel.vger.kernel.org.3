Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F6C5A6865
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 18:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbiH3Q1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 12:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbiH3Q1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 12:27:09 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F22BADAB;
        Tue, 30 Aug 2022 09:27:06 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-11f11d932a8so9549049fac.3;
        Tue, 30 Aug 2022 09:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=wuRk+VYHRYicUuf1j8uq3lODBftZnoqCCHUZOuAjQB0=;
        b=ubr6Oc7/6uEi+jjkodRkt+tXu1UMf2zXttuY9xjTyIEDg3GUS+0s1i9dNp/EcLivmU
         bsngRC38/B2K/wUGfAJ7GJoQxJ6Gj+nlcw1kPA7NTIaj9ll43soHkWo0qCMjbBgFeAdb
         hlKbxEx8Vo8seLlA6ZL9VH+g6SU/f4vTeN9hWNQLPjPLpsVFvaAWMdAwzkmpuhHVHrQj
         c7mo3hlu2tPOtFa131qFKW9v9zRpfIp9mxVdQ7duvzYVLpAaTobrWl2SI909zYqMihZB
         NVCVwbIQaUMOOVXV1fg0sBT/nzxOSwacrdOmk43sJ2qxduYe46OKczE6Q2k/me4MDM3t
         SRqQ==
X-Gm-Message-State: ACgBeo3QXUlMKeRzkE5wCnGhAI3zlCRpW2iN8H5muSICIK7IB0wE1hXP
        2Vu74ULu3APd2PcJZTI8pkxkIgcQig==
X-Google-Smtp-Source: AA6agR6GA6Q0ErAGzOIHxDnClzhpq9ne0VqxD6Z//Rl9F2SULHqE/HhYGYWk0fVndX+8Zi3adywX5w==
X-Received: by 2002:a05:6808:1892:b0:344:d066:5171 with SMTP id bi18-20020a056808189200b00344d0665171mr9457806oib.195.1661876825779;
        Tue, 30 Aug 2022 09:27:05 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w14-20020a0568080d4e00b0033b15465357sm6390194oik.5.2022.08.30.09.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 09:27:05 -0700 (PDT)
Received: (nullmailer pid 1527854 invoked by uid 1000);
        Tue, 30 Aug 2022 16:27:04 -0000
Date:   Tue, 30 Aug 2022 11:27:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org, David Heidelberg <david@ixit.cz>,
        Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Lee Jones <lee@kernel.org>
Subject: Re: [PATCH 14/14] dt-bindings: mfd: qcom,spmi-pmic: fix TM ADC node
 schema on PM8998
Message-ID: <20220830162704.GA1527768-robh@kernel.org>
References: <20220828084341.112146-1-krzysztof.kozlowski@linaro.org>
 <20220828084341.112146-15-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220828084341.112146-15-krzysztof.kozlowski@linaro.org>
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

On Sun, 28 Aug 2022 11:43:41 +0300, Krzysztof Kozlowski wrote:
> There are two bindings for Qualcomm SPMI PMIC Thermal Monitoring ADC:
> one for ADC HC and one for ADC TM5 and TM7.  PM8998 uses the former one,
> so fix matching of child schema:
> 
>   qcom/msm8998-asus-novago-tp370ql.dtb: pmic@0: adc-tm@3400:compatible:0: 'qcom,spmi-adc-tm-hc' is not one of ['qcom,spmi-adc-tm5', 'qcom,spmi-adc-tm5-gen2', 'qcom,adc-tm7']
> 
> Fixes: 3f5117be9584 ("dt-bindings: mfd: convert to yaml Qualcomm SPMI PMIC")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/mfd/qcom,spmi-pmic.yaml           | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
