Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0CF48E9E3
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241064AbiANMbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241059AbiANMbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:31:17 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E4CC06161C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:31:17 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id x7so29745936lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=77pmSAVRNpTBl60Re2sb+7w1VmXhgke73Gpf6n2PGxs=;
        b=u8JT84qg75lLSuTTWLGIS/1OXD7xC58SB3A5CQZw9Xc7sg1yWKoVGF+AcYxr+pKx5o
         k9lrBXrp7nI4CpK5ZumP5Nr1ra5RCLYsLHUmmn4prpyv53hN8pLq0vKI8irr0Fa3IU6t
         AiWI83RHtiSCCIvts6okiYIdrCjqK4ICEk3a6U88UaxBii3JBx2yAQb/iXhO1JgHnMh5
         8asrU6YcLolV9jsAYD3TWIQRnZlhwTom97GiDgJkrdSWumjSxYscdstInWSUD7ftsPTa
         MjeefO7qRj2xlSRLQ/9892PuGZnWdXdTWDniVQ9D2Pnvz59OkhBmDuUdW1j23G0Zs38M
         GpQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=77pmSAVRNpTBl60Re2sb+7w1VmXhgke73Gpf6n2PGxs=;
        b=WzotrGKZZ9usPY+7Mg7j1e+jwxye7aTKXCJCeQv7c6xiAdy1+UcTvzA8sdgeSYYVBR
         Qilk7zVjYR1AW88xH3wL7xT2R5uvk/JqgUDHM7DsH6rpOGDTI44aWSzAmXy87Ffz8svv
         5Y7oGd7oOWDVJ9nB1sZQocLHrrOwFyUH6zVrGCgc3Q9y6hEnvKJv4udTDd9IpyD0429D
         gA9bcR61raqkpavJR6vOg+FjYBUDt52y5c2fUBs3Jybwla0amVuvms84qJCNwU4b5CLr
         fAPEwuTrVUwCQalLNY+vjQ2nDJT0CzEgxmv2JFxtdbHlbt2A8Ov7almMKj1kib/THA9D
         ky9w==
X-Gm-Message-State: AOAM53368IqwAe0hTlJmk+6oqpfb5kRkqt0NR0bavZXtH2OqQU8xwHbW
        6up0Id59GH3qsuIi2CTT1Pg0MvWb2xK04F7vLMTPW8Z983Vkmw==
X-Google-Smtp-Source: ABdhPJzL858sbSIeSFslDgms1hO8AEUIhi8mqI5Y9dfyEjmBqXbKAslXoL1d45Lta2VqXcupfIZPklLUbTQNQcDYYjY=
X-Received: by 2002:a05:6512:20ca:: with SMTP id u10mr6555036lfr.71.1642163475421;
 Fri, 14 Jan 2022 04:31:15 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-5-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-5-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jan 2022 13:30:38 +0100
Message-ID: <CAPDyKFrrajGPsH5=iqtB6PAuO6Y9C8_QfbF8yF2PKqrVuCmZ9g@mail.gmail.com>
Subject: Re: [PATCH 04/10] arm64: dts: qcom: sm8450: Update cpuidle states parameters
To:     Maulik Shah <quic_mkshah@quicinc.com>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        quic_lsrao@quicinc.com, quic_rjendra@quicinc.com,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 9 Jan 2022 at 18:25, Maulik Shah <quic_mkshah@quicinc.com> wrote:
>
> This change updates/corrects below cpuidle parameters
>
> 1. entry-latency, exit-latency and residency for various idle states.
> 2. arm,psci-suspend-param which is same for CLUSTER_SLEEP_0/1 states.
> 3. Add CLUSTER_SLEEP_1 in CLUSTER_PD.
>
> Cc: devicetree@vger.kernel.org
> Fixes: 5188049c9b36 ("arm64: dts: qcom: Add base SM8450 DTSI")
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index 10c25ad..5e329f8 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> @@ -203,9 +203,9 @@
>                                 compatible = "arm,idle-state";
>                                 idle-state-name = "silver-rail-power-collapse";
>                                 arm,psci-suspend-param = <0x40000004>;
> -                               entry-latency-us = <274>;
> -                               exit-latency-us = <480>;
> -                               min-residency-us = <3934>;
> +                               entry-latency-us = <800>;
> +                               exit-latency-us = <750>;
> +                               min-residency-us = <4090>;
>                                 local-timer-stop;
>                         };
>
> @@ -213,9 +213,9 @@
>                                 compatible = "arm,idle-state";
>                                 idle-state-name = "gold-rail-power-collapse";
>                                 arm,psci-suspend-param = <0x40000004>;
> -                               entry-latency-us = <327>;
> -                               exit-latency-us = <1502>;
> -                               min-residency-us = <4488>;
> +                               entry-latency-us = <600>;
> +                               exit-latency-us = <1550>;
> +                               min-residency-us = <4791>;
>                                 local-timer-stop;
>                         };
>                 };
> @@ -224,10 +224,10 @@
>                         CLUSTER_SLEEP_0: cluster-sleep-0 {
>                                 compatible = "domain-idle-state";
>                                 idle-state-name = "cluster-l3-off";
> -                               arm,psci-suspend-param = <0x4100c344>;
> -                               entry-latency-us = <584>;
> -                               exit-latency-us = <2332>;
> -                               min-residency-us = <6118>;
> +                               arm,psci-suspend-param = <0x41000044>;
> +                               entry-latency-us = <1050>;
> +                               exit-latency-us = <2500>;
> +                               min-residency-us = <5309>;
>                                 local-timer-stop;
>                         };
>
> @@ -235,9 +235,9 @@
>                                 compatible = "domain-idle-state";
>                                 idle-state-name = "cluster-power-collapse";
>                                 arm,psci-suspend-param = <0x4100c344>;
> -                               entry-latency-us = <2893>;
> -                               exit-latency-us = <4023>;
> -                               min-residency-us = <9987>;
> +                               entry-latency-us = <2700>;
> +                               exit-latency-us = <3500>;
> +                               min-residency-us = <13959>;
>                                 local-timer-stop;
>                         };
>                 };
> @@ -315,7 +315,7 @@
>
>                 CLUSTER_PD: cpu-cluster0 {
>                         #power-domain-cells = <0>;
> -                       domain-idle-states = <&CLUSTER_SLEEP_0>;
> +                       domain-idle-states = <&CLUSTER_SLEEP_0 &CLUSTER_SLEEP_1>;

Should this be like the below instead?

<&CLUSTER_SLEEP_0>,  <&CLUSTER_SLEEP_1>;

>                 };
>         };
>
> --
> 2.7.4
>

Other than the above, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe
