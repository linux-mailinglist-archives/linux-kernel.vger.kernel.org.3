Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91564B1A50
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 01:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245234AbiBKAUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 19:20:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346054AbiBKAUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 19:20:12 -0500
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826E45594
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:20:12 -0800 (PST)
Received: by mail-oo1-xc31.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so8447471ooi.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MwxbqAdEkZ6Sl6Mr4U5PKeV2CJ4YFO38+JRFL6HkmUs=;
        b=ivkTs9VLGEN6yiftiZ7xyV0BR+b9W4At1QeWBx6knNXPvShsUdSHTSDTKn0W79v8ZO
         xpGs6zqmYZhAF2KLGbZH3Ia/3qZjk61YEGp7jpngI5zXMdgcwftZpEJcbUU3Kkz3wc4E
         W1p/kdaHWp+KJylRcdP0KBXjKrEk2ktg2M2JgXkDXzAuMZLpQhspsUNPnTJc2FAxZ/qA
         NzX9HWMEemt+y/J3NMT0wbwxL42lP21qyM61O2bjL1QxaXhbIbR9SjfeXZbeJ+oMLlNF
         XLpmTopxrQRqTV5YuQ3zCsLWFeLJC1m044NRMNcfWquupwarOvivkac3huprdl6/fFFY
         opWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MwxbqAdEkZ6Sl6Mr4U5PKeV2CJ4YFO38+JRFL6HkmUs=;
        b=kMC5dFpSc9DKI714+CsGz59SrWkmlE+rQRKLp5yBPRIqAg0AtGhlyr/ckYdX0sJx+9
         rqa1Xt655k99fLJKNEr4kcI+jSiZrSkiPMHg7fzBZqDzCkewKW8FcO0EH4bOY94zjcn7
         hzJOtu7YYlpichGDS3+WSNxDQlz9PAHNXSGRgguEQURgtdKjETyWZ7SQKm64GYlaGw5z
         Ux/aPxLGZT7liR5yV8VF0JsQtc3dwOXXb2+jt56P+57dHzg+tAmvY33ClwUMBMDfv6O9
         go7rwjwyWRrgmTxZFeMupR/NEYLZJmIRlyYyRnLpuMDOd1m51iFL1uATnucm9rbqf8Iu
         AimA==
X-Gm-Message-State: AOAM533613TWl/RMDuiC4SnlZXamcV7E1AN89cLzY+GWj/yDidakPYnl
        AKssz2ETPSGDQs/kWVJf7BqEPQ==
X-Google-Smtp-Source: ABdhPJwmuglMyj8JWI40ASfUcyZh8vsscGz4rztyMuEyYtVpPtEXRixA6bBNoGJbI0DN0bk+1tZPSw==
X-Received: by 2002:a05:6870:3a0e:: with SMTP id du14mr1567723oab.25.1644538811862;
        Thu, 10 Feb 2022 16:20:11 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id n66sm8694763oif.35.2022.02.10.16.20.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 16:20:11 -0800 (PST)
Date:   Thu, 10 Feb 2022 18:20:09 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v3 0/7] dt-bindings: Convert multiple Qualcomm OPP
 and CPUFreq bindings to DT schema
Message-ID: <YgWrufkNy3OfmV4o@builder.lan>
References: <20220203072226.51482-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203072226.51482-1-y.oudjana@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 03 Feb 01:24 CST 2022, Yassine Oudjana wrote:

> This series is a compilation of DT schema conversions of multiple Qualcomm
> OPP and CPUFreq bindings:
> - qcom-cpufreq-nvmem (operating-points-v2-kryo-cpu)
> - qcom-opp (operating-points-v2-qcom-level)
> - qcom,cpr
> 

Really nice to see these updates!

I'm going to pick up the patches that goes through the Qualcomm tree,
but patch 3,4 and 7 would be better to take through Viresh's tree, so
I've looped him in on this reply.

Thanks,
Bjorn

> Converting each one to DT schema introduces new dt_binding_check and
> dtbs_check errors to the others, so it was better to combine them into
> a series. Some errors were also caused by a couple of device trees having
> OPP tables with names that do not follow opp-v2-base, so these got fixed
> in this series as well. Finally, the lack of MSM8996 compatibles in
> arm/qcom.yaml caused an error in the opp-v2-kryo-cpu example, so they were
> added to the schema as well as to the msm8996-mtp device tree, which only
> had qcom,msm8996-mtp as its compatible.
> 
> PATCH 4/7 is a new version of a patch[1] that was sent as part of
> a different series before, and PATCH 7/7 is a new version of a patch[2]
> that was sent alone.
> 
> Changes in v3:
>  - Resend with unified version for all patches
> 
> Changes since v1 (PATCH v2 4/7):
>  - Split the schema into an OPP schema and a CPUFreq schema. 
> 
> Changes since v1 (PATCH v2 7/7):
>  - Remove allOf from compatible.
> 
> Yassine Oudjana (7):
>   dt-bindings: arm: qcom: Add msm8996 and apq8096 compatibles
>   arm64: dts: qcom: msm8996-mtp: Add msm8996 compatible
>   dt-bindings: opp: qcom-opp: Convert to DT schema
>   dt-bindings: opp: Convert qcom-nvmem-cpufreq to DT schema
>   arm64: dts: qcom: msm8996: Rename cluster OPP tables
>   arm64: dts: qcom: qcs404: Rename CPU and CPR OPP tables
>   dt-bindings: power: avs: qcom,cpr: Convert to DT schema
> 
>  .../devicetree/bindings/arm/qcom.yaml         |  16 +-
>  .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml  | 166 ++++
>  .../bindings/opp/opp-v2-kryo-cpu.yaml         | 257 ++++++
>  .../bindings/opp/opp-v2-qcom-level.yaml       |  60 ++
>  .../bindings/opp/qcom-nvmem-cpufreq.txt       | 796 ------------------
>  .../devicetree/bindings/opp/qcom-opp.txt      |  19 -
>  .../bindings/power/avs/qcom,cpr.txt           | 130 ---
>  .../bindings/power/avs/qcom,cpr.yaml          | 160 ++++
>  MAINTAINERS                                   |   5 +-
>  arch/arm64/boot/dts/qcom/msm8996-mtp.dts      |   2 +-
>  arch/arm64/boot/dts/qcom/msm8996.dtsi         |   4 +-
>  arch/arm64/boot/dts/qcom/qcs404.dtsi          |   4 +-
>  12 files changed, 666 insertions(+), 953 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/cpufreq/qcom-cpufreq-nvmem.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-kryo-cpu.yaml
>  create mode 100644 Documentation/devicetree/bindings/opp/opp-v2-qcom-level.yaml
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-nvmem-cpufreq.txt
>  delete mode 100644 Documentation/devicetree/bindings/opp/qcom-opp.txt
>  delete mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.txt
>  create mode 100644 Documentation/devicetree/bindings/power/avs/qcom,cpr.yaml
> 
> [1] https://lore.kernel.org/linux-arm-msm/20211014083016.137441-6-y.oudjana@protonmail.com/
> [2] https://lore.kernel.org/linux-arm-msm/20211221133937.173618-1-y.oudjana@protonmail.com/
> -- 
> 2.34.1
> 
> 
