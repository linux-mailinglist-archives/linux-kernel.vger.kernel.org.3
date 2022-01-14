Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAD9048E9DF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 13:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiANMa7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 07:30:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241051AbiANMa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 07:30:58 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B6AC06173E
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:30:58 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x22so29670022lfd.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 04:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ws2LMZ5nWWo85ltRjOHPxrAJcfufwTYWFr7QIEeNBz4=;
        b=IRwaov5nNzKhqzILCR7xKnU588447yjbVN5r8tk8fbVWOCgvtxko6yXqu/aP3wk74X
         WZ+uhaaI2tSAK9YqPzXuqpK1P2lhM7MK+NIElRmh0FFbfmAbNYTMq7OL7wV9gV98inaG
         bep2hY1c3Cd+nlDHNJ9zmzmQlcnV+myVv+B6lOTzyWQoUw3/YNhRL5UUlaXcmdjnPxxB
         IHLojo7NNqPsmpp6jAsbM+lhsjNJtjz3RMkC3PvrWxwu4k3eGmCuj5zM63d7apZmz5yn
         KK8evaG9XfxJ3frcitYbz7C1wbD4Aa53umxGhSU0ezTmncsZ1C9J2OTJ3g9Tswfad179
         zJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ws2LMZ5nWWo85ltRjOHPxrAJcfufwTYWFr7QIEeNBz4=;
        b=n+L3zMYe1C2R9UC/bYs13FxJ5EKo8JbWiGLY5kuQgKSMCBByi0ENlZGqDmkPeiiKrn
         w+lTTi89AI94znNK537GVx3Ophozl+nOZLb4h7o+UiRGebOeaKU+Bq8A3/FqUVDAhikM
         gM/dF33CMgjf17OFfO/m3n0LCKC/c+Sx7ySw1icfOIbfYbjihURPHKxBEZVwZLJNLCvh
         DCeBrRVh2gxKHYOHJph5mXtPZGkx+OBdQibw2RLh+laQzhg1o6u3wePL3i0WMrK91H9V
         uHFSK9bAzeiyRRKu4Fnv06JxFxsORNLfgtUoRT1n2k1Ykr7dR8duwGFocPdz/YGOXfJZ
         SvhA==
X-Gm-Message-State: AOAM530lcctjLvT+FZJMFAl5f4DwIcK4eyeU6jxU9XwljD33uqdTMUwP
        OCin1oJagLay/OJnjs1dhbRD9dCtW+dYTFTbJle/cw==
X-Google-Smtp-Source: ABdhPJyb+WRkCf4D+uR0dqONoC4HWsyFnEUmzHebA+YTiyB3aKkKGX9UG5M5JiKdKZxHP3NYuOCWMhQvHIOq4p3hq3w=
X-Received: by 2002:a2e:947:: with SMTP id 68mr6711799ljj.300.1642163456710;
 Fri, 14 Jan 2022 04:30:56 -0800 (PST)
MIME-Version: 1.0
References: <1641749107-31979-1-git-send-email-quic_mkshah@quicinc.com> <1641749107-31979-3-git-send-email-quic_mkshah@quicinc.com>
In-Reply-To: <1641749107-31979-3-git-send-email-quic_mkshah@quicinc.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 14 Jan 2022 13:30:20 +0100
Message-ID: <CAPDyKFr3_RJXE7_6YQzgusRNhsZ1F8CBG5iV27ZTspGacwo6uA@mail.gmail.com>
Subject: Re: [PATCH 02/10] arm64: dts: qcom: sm8250: Add cpuidle states
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
> This change adds various idle states and add devices to power domains.
>
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe


> ---
>  arch/arm64/boot/dts/qcom/sm8250.dtsi | 105 +++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> index 5617a46..077d0ab 100644
> --- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
> @@ -98,6 +98,8 @@
>                         capacity-dmips-mhz = <448>;
>                         dynamic-power-coefficient = <205>;
>                         next-level-cache = <&L2_0>;
> +                       power-domains = <&CPU_PD0>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -120,6 +122,8 @@
>                         capacity-dmips-mhz = <448>;
>                         dynamic-power-coefficient = <205>;
>                         next-level-cache = <&L2_100>;
> +                       power-domains = <&CPU_PD1>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -139,6 +143,8 @@
>                         capacity-dmips-mhz = <448>;
>                         dynamic-power-coefficient = <205>;
>                         next-level-cache = <&L2_200>;
> +                       power-domains = <&CPU_PD2>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -158,6 +164,8 @@
>                         capacity-dmips-mhz = <448>;
>                         dynamic-power-coefficient = <205>;
>                         next-level-cache = <&L2_300>;
> +                       power-domains = <&CPU_PD3>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 0>;
>                         operating-points-v2 = <&cpu0_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -177,6 +185,8 @@
>                         capacity-dmips-mhz = <1024>;
>                         dynamic-power-coefficient = <379>;
>                         next-level-cache = <&L2_400>;
> +                       power-domains = <&CPU_PD4>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         operating-points-v2 = <&cpu4_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -196,6 +206,8 @@
>                         capacity-dmips-mhz = <1024>;
>                         dynamic-power-coefficient = <379>;
>                         next-level-cache = <&L2_500>;
> +                       power-domains = <&CPU_PD5>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         operating-points-v2 = <&cpu4_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -216,6 +228,8 @@
>                         capacity-dmips-mhz = <1024>;
>                         dynamic-power-coefficient = <379>;
>                         next-level-cache = <&L2_600>;
> +                       power-domains = <&CPU_PD6>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 1>;
>                         operating-points-v2 = <&cpu4_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -235,6 +249,8 @@
>                         capacity-dmips-mhz = <1024>;
>                         dynamic-power-coefficient = <444>;
>                         next-level-cache = <&L2_700>;
> +                       power-domains = <&CPU_PD7>;
> +                       power-domain-names = "psci";
>                         qcom,freq-domain = <&cpufreq_hw 2>;
>                         operating-points-v2 = <&cpu7_opp_table>;
>                         interconnects = <&gem_noc MASTER_AMPSS_M0 &mc_virt SLAVE_EBI_CH0>,
> @@ -281,6 +297,42 @@
>                                 };
>                         };
>                 };
> +
> +               idle-states {
> +                       entry-method = "psci";
> +
> +                       LITTLE_CPU_SLEEP_0: cpu-sleep-0-0 {
> +                               compatible = "arm,idle-state";
> +                               idle-state-name = "silver-rail-power-collapse";
> +                               arm,psci-suspend-param = <0x40000004>;
> +                               entry-latency-us = <360>;
> +                               exit-latency-us = <531>;
> +                               min-residency-us = <3934>;
> +                               local-timer-stop;
> +                       };
> +
> +                       BIG_CPU_SLEEP_0: cpu-sleep-1-0 {
> +                               compatible = "arm,idle-state";
> +                               idle-state-name = "gold-rail-power-collapse";
> +                               arm,psci-suspend-param = <0x40000004>;
> +                               entry-latency-us = <702>;
> +                               exit-latency-us = <1061>;
> +                               min-residency-us = <4488>;
> +                               local-timer-stop;
> +                       };
> +               };
> +
> +               domain-idle-states {
> +                       CLUSTER_SLEEP_0: cluster-sleep-0 {
> +                               compatible = "domain-idle-state";
> +                               idle-state-name = "cluster-llcc-off";
> +                               arm,psci-suspend-param = <0x4100c244>;
> +                               entry-latency-us = <3264>;
> +                               exit-latency-us = <6562>;
> +                               min-residency-us = <9987>;
> +                               local-timer-stop;
> +                       };
> +               };
>         };
>
>         cpu0_opp_table: cpu0_opp_table {
> @@ -594,6 +646,59 @@
>         psci {
>                 compatible = "arm,psci-1.0";
>                 method = "smc";
> +
> +               CPU_PD0: cpu0 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD1: cpu1 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD2: cpu2 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD3: cpu3 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&LITTLE_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD4: cpu4 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD5: cpu5 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD6: cpu6 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +               };
> +
> +               CPU_PD7: cpu7 {
> +                       #power-domain-cells = <0>;
> +                       power-domains = <&CLUSTER_PD>;
> +                       domain-idle-states = <&BIG_CPU_SLEEP_0>;
> +               };
> +
> +               CLUSTER_PD: cpu-cluster0 {
> +                       #power-domain-cells = <0>;
> +                       domain-idle-states = <&CLUSTER_SLEEP_0>;
> +               };
>         };
>
>         reserved-memory {
> --
> 2.7.4
>
