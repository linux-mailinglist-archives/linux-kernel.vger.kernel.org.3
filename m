Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324CA5ABA14
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 23:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiIBVbZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 17:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiIBVbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 17:31:22 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA355EEF28;
        Fri,  2 Sep 2022 14:31:19 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id u5-20020a4a5705000000b0044b34c2c89cso573622ooa.9;
        Fri, 02 Sep 2022 14:31:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=RPXcg8S4KyYuvQ2h0ZxAMrKdXRJfPvOglHtgG5zFDQ0=;
        b=wYPz78u/glMLM84PpMcBS+Yy/kVn4EvMrg77YNwin28t/lMBNR0S7eodemsdrTL7bZ
         celfXD4hkib2nkNqwEku7FH1ClsI1k4YBUmkTLAcv3wGVxfNaWlp0b5W/X5M10+9pDZn
         8e7FRoWosaUyIl8hT0kfL7yHg+wIQziaTDK4T1DxzwneTvmAb2pL9rtl9moZKiqP5zFV
         c9a5BXeaegUBx7g5hj8mYNaBd5JNEbSjzHFa44d5rC8+YiQeWgX30jnb8WNGTI1R/CnB
         Qtc+jNFaUzIXecTBYcne4fxpuTQvYnicXm1Q6zC2g7gO+SBnvf/fB+wVfVPH2dVSnvbW
         COmA==
X-Gm-Message-State: ACgBeo1nic8NIKaQrU1WEH4WoGDh6ZiGeXle7L6f4yQz1JVaIteaVCVG
        9DFaP3AgSw5P5DcXORe6izoaE/Oguw==
X-Google-Smtp-Source: AA6agR7gAHbiDGuf/4d73jGZkGGqXN72S41JDyjKovaLhBAQW2zNQZvmduOt+nfE80rWeCcDmIPUUQ==
X-Received: by 2002:a4a:2c92:0:b0:448:a89b:af18 with SMTP id o140-20020a4a2c92000000b00448a89baf18mr13173764ooo.42.1662154279003;
        Fri, 02 Sep 2022 14:31:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n6-20020a4ad626000000b00435785e7b49sm1058116oon.19.2022.09.02.14.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 14:31:18 -0700 (PDT)
Received: (nullmailer pid 449613 invoked by uid 1000);
        Fri, 02 Sep 2022 21:31:17 -0000
Date:   Fri, 2 Sep 2022 16:31:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH RFT v2 1/4] dt-bindings: soc: qcom: smd-rpm: add PMIC
 regulators nodes
Message-ID: <20220902213117.GA449547-robh@kernel.org>
References: <20220901093243.134288-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901093243.134288-1-krzysztof.kozlowski@linaro.org>
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

On Thu, 01 Sep 2022 12:32:40 +0300, Krzysztof Kozlowski wrote:
> The Qualcomm RPM over SMD contains devices for one or two PMIC
> regulators - already used in several DTS files.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Changes since v1:
> 1. None
> ---
>  Documentation/devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
