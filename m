Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD47D4D5529
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 00:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344606AbiCJXO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 18:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236297AbiCJXO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 18:14:58 -0500
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0D319ABD9;
        Thu, 10 Mar 2022 15:13:56 -0800 (PST)
Received: by mail-oo1-f45.google.com with SMTP id n5-20020a4a9545000000b0031d45a442feso8674960ooi.3;
        Thu, 10 Mar 2022 15:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=m2xvQTGJE3ysRwd1CcmXhVPZy5zdjD5mPFrEfObDZcA=;
        b=KYABQ9i/9Tsa9ctmPuDoWyW4Gcdq5s2LhSDStwaO53DLBRGNUAPZdhbzzaknhSDrC5
         vSzGEbDX2NstQR9SJhUCZCMaSkGkOuvGbDe/+uXBnSsFrhAmu41e14KmGO/LMB6L/WAU
         uK+H3RfHruVHRJHC0t7nKIihTPaqzzbOIdVUgtgvF3vRIc44ligaPz0XQ9ToxEdrLipM
         tehit+f/YMo3BcoQPwOWvTjBkjlcwOcfSp1dbDn4wDZhvxs+RibH3RDKFv6NomlHimu9
         52DOKza8mgvRjdbFws5e6RNaGPL04um9a4Ii+Jxvv5j6SSBBr2Yl/PUOoXR3Py3H1wbT
         syng==
X-Gm-Message-State: AOAM5322zvDGreiw7ALa+12pIYzIGBdpiisSV6oOpyMfHPnQj6E2ZSae
        HHv7xva/tt6oMVK4m7CbwR3n2FwNQw==
X-Google-Smtp-Source: ABdhPJwSzxiWisq04pxicnT3+uL8xgXrN1u6Usk11hAVHbvCyHrPWp2PufxdTyNaLFlJ2icXHhWnoA==
X-Received: by 2002:a05:6870:c0cb:b0:da:2bcc:aa09 with SMTP id e11-20020a056870c0cb00b000da2bccaa09mr4163750oad.63.1646954035737;
        Thu, 10 Mar 2022 15:13:55 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r23-20020a056830237700b005b2610517c8sm2902188oth.56.2022.03.10.15.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 15:13:55 -0800 (PST)
Received: (nullmailer pid 2273654 invoked by uid 1000);
        Thu, 10 Mar 2022 23:13:54 -0000
Date:   Thu, 10 Mar 2022 17:13:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     viresh.kumar@linaro.org, rafael@kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org,
        Hector Yuan <hector.yuan@mediatek.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        krzk+dt@kernel.org, angelogioacchino.delregno@somainline.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: dvfs: Use MediaTek CPUFREQ HW as an
 example
Message-ID: <YiqGMkvC6UyDy4H9@robh.at.kernel.org>
References: <20220309151541.139511-1-manivannan.sadhasivam@linaro.org>
 <20220309151541.139511-2-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309151541.139511-2-manivannan.sadhasivam@linaro.org>
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

On Wed, 09 Mar 2022 20:45:40 +0530, Manivannan Sadhasivam wrote:
> Qcom CPUFREQ HW don't have the support for generic performance domains yet.
> So use MediaTek CPUFREQ HW that has the support available in mainline.
> 
> This also silences the below dtschema warnings for "cpufreq-qcom-hw.yaml":
> 
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: reg: [[305397760, 4096]] is too short
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clocks' is a required property
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: 'clock-names' is a required property
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#freq-domain-cells' is a required property
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> Documentation/devicetree/bindings/dvfs/performance-domain.example.dt.yaml: performance-controller@12340000: '#performance-domain-cells' does not match any of the regexes: 'pinctrl-[0-9]+'
>         From schema: Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.yaml
> 
> Cc: Hector Yuan <hector.yuan@mediatek.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../bindings/dvfs/performance-domain.yaml          | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
