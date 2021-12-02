Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10746658B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355653AbhLBOqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 09:46:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355270AbhLBOqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 09:46:13 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBC0C061759
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 06:42:50 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id n12so72121724lfe.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 06:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1gVv0etm4GE993dQO3eB/dIS4SnHr6m6vfiEpAtF7aU=;
        b=JJXN9sqOBx56Tsg/1u+/d0K/NEyFTzBSxlXbFhXTiSyyDTZ3K0D88ask1mVp0D2b7Q
         EiJ3/q4CDQkF+G+sArHeIV5aqEOsFcx1o1lSEWXru1qW48nQRaEUiaOPiDIT3KFAHpii
         Ao1PDWWiVPmTPo/hqnqYbO0DTKW+JTR6aGKa6exbGN2hWTW6/5kMRPSm0qTbxVPCSIpA
         ZDMN4dfehwZtK7DprJ/msGh167OncvlS2LWw0ZIG6EV0+/mpPZbbKFwll6FEpIquTBic
         4xYGux6CnibaxDUucOYhcoY9r95PScTcHZ4iYW2xAiQuC0gFf1yE0MycHKnHI5A+EA7y
         yKbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1gVv0etm4GE993dQO3eB/dIS4SnHr6m6vfiEpAtF7aU=;
        b=zAB+DUqGU2S4jk6GrvBjLrsOc7HAB5kLDhDxgnIdoOhC0GzrYhRB8I4TTsGBQd9VeO
         CrOPc1n6EMN4WGms7OwA7tVbzVpY8ulT7ruGDcrVD4MDBX2jPVwtKhBCbr8UFnL4CEdV
         XX8M7omDN1ZFtUmA50woZfgedBx0iU0iprXL6OKtYIWr9NNoQg87CyPV4k7T4d7/ZP1c
         NFQvG3UF++eLiS3cX06qX/Zlau8rkR3QH7EEDv3mR5ROFVOdQmYHt5TlWGqEP2dUrRSY
         11A8Np3/CGhYjFLUBcvs/ROs93kAxw8adLltPa4IpZsJCR3bYr0TgkZruvqFx+nwaZTP
         Fj0A==
X-Gm-Message-State: AOAM532dx7F+n5FAfAYpa/X9PmJOHn7t0feZkp7tpdCrm0Up/lJrkYGm
        TtcoPPHd0qijenoRfAGVvaDHGzGQt6uWD+Mzz4WAXsCM4BA=
X-Google-Smtp-Source: ABdhPJyrT9kMPeIIlRKi/Kp/85yxnQAc1+U0bxMck/R189/VGs3/nm3pgYCLFcvlAVpI0ZHqgRVlrV/YSDOzUxfz8JE=
X-Received: by 2002:a05:6512:3e04:: with SMTP id i4mr12793780lfv.167.1638456168960;
 Thu, 02 Dec 2021 06:42:48 -0800 (PST)
MIME-Version: 1.0
References: <20211201163856.41419-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211201163856.41419-1-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 2 Dec 2021 15:42:13 +0100
Message-ID: <CAPDyKFor=OCOYqY2K9WyOa5FrM+tCE8KR8CuBOxHdz-ch9Tzkg@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: Powerzone new bindings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     robh@kernel.org, arnd@linaro.org, heiko@sntech.de,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Dec 2021 at 17:41, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> The proposed bindings are describing a set of powerzones.
>
> A power zone is the logical name for a component which is capable of
> power capping and where we can measure the power consumption.
>
> A power zone can aggregate several power zones in terms of power
> measurement and power limitations. That allows to apply power
> constraint to a group of components and let the system balance the
> allocated power in order to comply with the constraint.
>
> The ARM System Control and Management Interface (SCMI) can provide a
> power zone description.
>
> The powerzone semantic is also found on the Intel platform with the
> RAPL register.
>
> The Linux kernel powercap framework deals with the powerzones:
>
> https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
>
> The powerzone can also represent a group of children powerzones, hence
> the description can result on a hierarchy. Such hierarchy already
> exists with the hardware or can be represented and computed from the
> kernel.
>
> The hierarchical description was initially proposed but not desired
> given there are other descriptions like the power domain proposing
> almost the same description.
>
> https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
>
> The description gives the power constraint dependencies to apply on a
> specific group of logically or physically aggregated devices. They do
> not represent the physical location or the power domains of the SoC
> even if the description could be similar.
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

This looks good to me, feel free to add:

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>    V3:
>      - Removed required property 'compatible'
>      - Removed powerzone-cells from the topmost node
>      - Removed powerzone-cells from cpus 'consumers' in example
>      - Set additionnal property to false
>    V2:
>      - Added pattern properties and stick to powerzone-*
>      - Added required property compatible and powerzone-cells
>      - Added additionnal property
>      - Added compatible
>      - Renamed to 'powerzones'
>      - Added missing powerzone-cells to the topmost node
>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
>    V1: Initial post
> ---
>  .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
> new file mode 100644
> index 000000000000..ddb790acfea6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/powerzones.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Power zones description
> +
> +maintainers:
> +  - Daniel Lezcano <daniel.lezcano@linaro.org>
> +
> +description: |+
> +
> +  A System on Chip contains a multitude of active components and each
> +  of them is a source of heat. Even if a temperature sensor is not
> +  present, a source of heat can be controlled by acting on the
> +  consumed power via different techniques.
> +
> +  A powerzone describes a component or a group of components where we
> +  can control the maximum power consumption. For instance, a group of
> +  CPUs via the performance domain, a LCD screen via the brightness,
> +  etc ...
> +
> +  Different components when they are used together can significantly
> +  increase the overall temperature, so the description needs to
> +  reflect this dependency in order to assign a power budget for a
> +  group of powerzones.
> +
> +  This description is done via a hierarchy and the DT reflects it. It
> +  does not represent the physical location or a topology, eg. on a
> +  big.Little system, the little CPUs may not be represented as they do
> +  not contribute significantly to the heat, however the GPU can be
> +  tied with the big CPUs as they usually have a connection for
> +  multimedia or game workloads.
> +
> +properties:
> +  $nodename:
> +    const: powerzones
> +
> +patternProperties:
> +  "^(powerzone)([@-].*)?$":
> +    type: object
> +    description:
> +      A node representing a powerzone acting as an aggregator for all
> +      its children powerzones.
> +
> +    properties:
> +      "#powerzone-cells":
> +        description:
> +          Number of cells in powerzone specifier. Typically 0 for nodes
> +          representing but it can be any number in the future to
> +          describe parameters of the powerzone.
> +
> +      powerzones:
> +        description:
> +          A phandle to a parent powerzone. If no powerzone attribute is
> +          set, the described powerzone is the topmost in the hierarchy.
> +
> +    required:
> +      - "#powerzone-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    powerzones {
> +
> +      SOC_PZ: powerzone-soc {
> +        #powerzone-cells = <0>;
> +      };
> +
> +      PKG_PZ: powerzone-pkg {
> +        #powerzone-cells = <0>;
> +        powerzones = <&SOC_PZ>;
> +      };
> +
> +      GPU_PZ: powerzone-gpu {
> +        #powerzone-cells = <0>;
> +        powerzones = <&PKG_PZ>;
> +      };
> +    };
> +
> +  - |
> +    A57_0: big@0 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      powerzones = <&PKG_PZ>;
> +    };
> +
> +    A57_1: big@1 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      powerzones = <&PKG_PZ>;
> +    };
> +...
> --
> 2.25.1
>
