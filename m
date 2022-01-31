Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 507E54A520D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 23:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbiAaWGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 17:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231248AbiAaWGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 17:06:47 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED856C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:06:46 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id y23so29465445oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 14:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W9hEBXurjCl7qSO381JI7fgMTyHfEqjYiRw7QVwUoiQ=;
        b=f83Oy42QBUfyAnO9mve85cB7lvEpbgY0o691h1XkMCXtnW+ODYVqKGNpp53UiVmbrl
         1LapiEW86Y8LpNLC57YIN4MJXtXRsAUASy/va5wXAVR9UsZJydU9Z6ScvgYH3Rto1ZtR
         ATpM+JnVu6yUXaT++xmS910rY+UtTeVAJJ+1i1Ca8VUFPdxpkRYLLl3WFGoeM3QW+v+a
         UJyNh4UCzHKLT4f4eL1OfYTWVH6YZJGYIXwmVk90Y+qy7if69L8IjUhOCEy3QGIDQSfF
         nDnJhFBgh5+AWipXSUTTZ9+V7sctCUUqRpGELV9SZihVlU5DiMdDgTt1IZyt7DWrK1Pz
         3m7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W9hEBXurjCl7qSO381JI7fgMTyHfEqjYiRw7QVwUoiQ=;
        b=ekWGzf+nfbRxaA/x6ZIQM1DutgnXLwu+UDzqF7xx9TK0L8MNmcAwEFKpJHtV5R6lhG
         +jweLpncRgJmTlLIR2zm4/szajZDtksgynvPp/+i9T3VP4ReRwMmyv5w28vy6J+cvx1p
         LQV55WHvQnFLjKmzaLO3ugoqtMUx/p0hYGc5JS1BWv/6albieXBopwlfsy/Fh6xCj078
         euX7VUajkEmoj7ustn00jTrmtVC3Q7QC4yBA6CUOfaAuV4MOU+gA7bBfqTxkOkvsfzmD
         BtxrW9gkMv7JKnHdJcSJkKZSn6IAxRnBAG9OojXcFOBoMTPwVwa3wvB0wOF4TLnTyAUf
         l+Kg==
X-Gm-Message-State: AOAM531MKYw2Fnr+c6Ks0kfGVTZRmTdeAvMkkb1fLFRen2exTYPYNRjd
        vYfGBZvmhI5A/UFUMmVPdN+9bg==
X-Google-Smtp-Source: ABdhPJwHPXbk+76P0Fx/D780/C1NJjDyzqlecixXCiyHyxzMZac7l6IJP/2pS0jKeDB9FmtMamolhg==
X-Received: by 2002:a05:6808:1822:: with SMTP id bh34mr14801119oib.209.1643666806299;
        Mon, 31 Jan 2022 14:06:46 -0800 (PST)
Received: from builder.lan ([2600:1700:a0:3dc8:3697:f6ff:fe85:aac9])
        by smtp.gmail.com with ESMTPSA id q11sm7085491oti.3.2022.01.31.14.06.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 14:06:45 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:06:44 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Yassine Oudjana <y.oudjana@protonmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Ilia Lin <ilia.lin@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Andy Gross <agross@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dt-bindings: Convert multiple Qualcomm OPP and
 CPUFreq bindings to DT schema
Message-ID: <YfhddMNAL1mQGtKU@builder.lan>
References: <20220104132618.391799-1-y.oudjana@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104132618.391799-1-y.oudjana@protonmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 04 Jan 07:27 CST 2022, Yassine Oudjana wrote:

> This series is a compilation of DT schema conversions of multiple Qualcomm
> OPP and CPUFreq bindings:
> - qcom-cpufreq-nvmem (operating-points-v2-kryo-cpu)
> - qcom-opp (operating-points-v2-qcom-level)
> - qcom,cpr
> 
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
> that was first sent alone.
> 
> Changes since v1 (PATCH v2 4/7):
>  - Split the schema into an OPP schema and a CPUFreq schema. 
> 
> Changes since v1 (PATCH v2 7/7):
>  - Remove allOf from compatible.
> 

The mixed versioning in this series confuses b4 - and thereby me as
well.  Can you please resubmit this with all patches of the same version
(e.g. v3).

Thanks,
Bjorn

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
> [2]	https://lore.kernel.org/linux-arm-msm/20211221133937.173618-1-y.oudjana@protonmail.com/
> -- 
> 2.34.1
> 
> 
