Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BB746C300
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:41:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240629AbhLGSot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:44:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhLGSos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:44:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB78BC061574;
        Tue,  7 Dec 2021 10:41:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 23697CE1D90;
        Tue,  7 Dec 2021 18:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50A5CC341CA;
        Tue,  7 Dec 2021 18:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638902474;
        bh=BD7y6nHDHYvwF8F0ey/Mk8ZBpokO5pKuXGZlYMItmjk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XYRyupyxYqJ1J2Xzzy1fbDAcK8U9EmRcrld67xacdQOCmUHzbODW7peeYiDwZrj3u
         AAkkDDnUYN3tbSBkG8UlHGdxboK6IuLb2BAQQASbgdWxGCFISUaZRIGDhgLbnG48cz
         siNPn1nu/axEkF9uldG4y4g9XdJ7SG3qoGjVeK/8chFCXZ8bMNRTKgdW1BAny1jfzx
         EcrXYOZj3qZrX28TtJJ+5tU4GTVkhF0tWH7ald/YdXYQWmXgLM05MTqOf7Eb+8HuTo
         8xt6IKmU4dJOc//poaAiHnlFV10RNIqgr6tpoX5NFDhg2CZOq3jm7pIxEq/uR2U41l
         M3la7iG9doIFQ==
Received: by mail-ed1-f46.google.com with SMTP id l25so60416874eda.11;
        Tue, 07 Dec 2021 10:41:14 -0800 (PST)
X-Gm-Message-State: AOAM530KQYWFwmBU5pWod420bFn9iDmSk7C+yt2KI+6x2mKc+lM015v8
        hT0J9rUvi3YSuKvIWJVPzMho5DNOmNGEYU/FcA==
X-Google-Smtp-Source: ABdhPJzcwDO/upO0y0Heow+dDIweLmSN4XLEBMezQBu999RnN0nYR8CEhaX/FQ9NPwIz30CbYJUz7q1kPpylgv6jWiU=
X-Received: by 2002:a17:906:5e14:: with SMTP id n20mr1338660eju.466.1638902472240;
 Tue, 07 Dec 2021 10:41:12 -0800 (PST)
MIME-Version: 1.0
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org> <20211126181500.3404129-2-daniel.lezcano@linaro.org>
In-Reply-To: <20211126181500.3404129-2-daniel.lezcano@linaro.org>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 7 Dec 2021 12:41:00 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK1tsOqUYrLkZCo95BC=AXwZxai947x41zYpeHbodvwFg@mail.gmail.com>
Message-ID: <CAL_JsqK1tsOqUYrLkZCo95BC=AXwZxai947x41zYpeHbodvwFg@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] arm64: dts: rockchip: Add powerzones definition
 for rock960
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Robin Murphy <robin.murphy@arm.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Helen Koike <helen.koike@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        "moderated list:ARM/Rockchip SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 12:15 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Add the powerzones description. This first step introduces the big,
> the little and the gpu as a powerzone place.
>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---
>    V1: Initial post
>    V2:
>      - Move description in the SoC dtsi specific file
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 25 ++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index d3cdf6f42a30..3c0dbc0cb2bc 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -76,6 +76,8 @@ cpu_l0: cpu@0 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       #powerzone-cells = <0>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_l1: cpu@1 {
> @@ -88,6 +90,8 @@ cpu_l1: cpu@1 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       #powerzone-cells = <0>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_l2: cpu@2 {
> @@ -100,6 +104,8 @@ cpu_l2: cpu@2 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       #powerzone-cells = <0>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_l3: cpu@3 {
> @@ -112,6 +118,8 @@ cpu_l3: cpu@3 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <100>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       #powerzone-cells = <0>;
> +                       powerzone = <&PKG_PZ>;
>                 };
>
>                 cpu_b0: cpu@100 {
> @@ -124,6 +132,8 @@ cpu_b0: cpu@100 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <436>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       #powerzone-cells = <0>;
> +                       powerzone = <&PKG_PZ>;
>
>                         thermal-idle {
>                                 #cooling-cells = <2>;
> @@ -142,6 +152,8 @@ cpu_b1: cpu@101 {
>                         #cooling-cells = <2>; /* min followed by max */
>                         dynamic-power-coefficient = <436>;
>                         cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
> +                       #powerzone-cells = <0>;
> +                       powerzone = <&PKG_PZ>;
>
>                         thermal-idle {
>                                 #cooling-cells = <2>;
> @@ -791,6 +803,17 @@ spi5: spi@ff200000 {
>                 status = "disabled";
>         };
>
> +       powerzones {
> +
> +               PKG_PZ: pkg {
> +                       #powerzone-cells = <0>;
> +                        powerzone = <&SOC_PZ>;
> +               };
> +
> +               SOC_PZ: soc {
> +               };
> +       };
> +
>         thermal_zones: thermal-zones {
>                 cpu_thermal: cpu-thermal {
>                         polling-delay-passive = <100>;
> @@ -2027,6 +2050,8 @@ gpu: gpu@ff9a0000 {
>                 clocks = <&cru ACLK_GPU>;
>                 #cooling-cells = <2>;
>                 power-domains = <&power RK3399_PD_GPU>;
> +               #powerzone-cells = <0>;
> +               powerzone = <&PKG_PZ>;

Every CPU and the GPU are in the same powerzone. What is the point? Do
you really have to be told that CPUs and GPU are a source of heat and
might need to be limited?

Rob
