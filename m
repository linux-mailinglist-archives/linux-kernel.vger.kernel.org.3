Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4FD3464A83
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 10:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348189AbhLAJ1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 04:27:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348175AbhLAJ1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 04:27:43 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7435C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:24:22 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id d11so46835480ljg.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 01:24:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gM/Yc8EtoWbZo84DxZuXQbB3MA0/ZTzJxXksQrQpskM=;
        b=p0dwxIjabirFBsABSCPUCdkrccuD7bMLwdD4o3pXTKDnOL7itEU05FMhOJ4P5Cczbe
         YMkOAsr9pm1L5ZEBq+GRMkfQLJzMFQXHpx1gn+FfC+Yby0x6O0xJlQJYXkJEpX6/gLsB
         uw39A6zuQFLKWeMvuPdZNv2n5KmluPqgqBeDrNiAYIQXVO7rN9+cM48vaEaL8yHmZXq4
         KwW70P8SK2mKjC4fimwiq+5Trt4X1Wr5+Vq/wxB9Y69CmhKn/AKmqFK7w3FYGM2t/gRz
         GMh4iKOHldz8EIESw9VNJonRILxub3nUP3bqzCm1ruMA32xgMG2bbxgcFH9PpCElxsda
         dYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gM/Yc8EtoWbZo84DxZuXQbB3MA0/ZTzJxXksQrQpskM=;
        b=JRtiV69KIm0ul+eBeC5qIl+yhASOhLlGpJPpDhbB+G7YMhJ8BGocIA9ZVI0li3gnMC
         39BueJtmf+H6pKEkKbmTAymX+x7j0vyxvbB0L0keD0uSZaVkZd+J0hp5+RvCjKpfsJYJ
         pCXaO8pqKYKmVQcyZEq4qsbFOksd1PKdAlxCAVXP9mR/oi6vtHDBNKJVZNNhJMlj7wQx
         fYsNV/9lgKGDC04G4seE5F6YWiqhe7wD/Rk5YsXZKawDDLmBeuxIKioes+SAO4SqpmjD
         arZxJyHH9Y9QpuSDH80Q/cns28AWRBWz1o/w8IEnM2tiU+9R3nUv4m51Hip1TFhd0Ej+
         Xmtw==
X-Gm-Message-State: AOAM533PWlTByM0oCeV7iBlR9+aump/iH7j9BWiOFMgXNxt8m3VNW0Tr
        gsYX/DHqyuGmgzCQ/ycwn4033E9bt6FneQG8DrabyQ==
X-Google-Smtp-Source: ABdhPJxdaXt+eWtKhQK6uoSvHNyf0JqYJR7quIKd3xMMBh2XBIfik0f8Mkp/IN428brlJT7cIaRLCtFx1oF74H8xIBc=
X-Received: by 2002:a2e:93c4:: with SMTP id p4mr4553125ljh.367.1638350661085;
 Wed, 01 Dec 2021 01:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
In-Reply-To: <20211126181500.3404129-1-daniel.lezcano@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Dec 2021 10:23:44 +0100
Message-ID: <CAPDyKFoZo4p93JZUm4CUqO4DfrL8_YbyomqBzC59C0eTwa60CA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: Powerzone new bindings
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

On Fri, 26 Nov 2021 at 19:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
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
> exists with the hardware or can be represented an computed from the
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
> ---
>    V1: Initial post
>    V2:
>      - Added pattern properties and stick to powerzone-*
>      - Added required property compatible and powerzone-cells
>      - Added additionnal property
>      - Added compatible
>      - Renamed to 'powerzones'
>      - Added missing powerzone-cells to the topmost node
>      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> ---
>  .../devicetree/bindings/power/powerzones.yaml | 109 ++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
>
> diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
> new file mode 100644
> index 000000000000..6e63bbc750c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
> @@ -0,0 +1,109 @@
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
> +  compatible:
> +    const: powerzones

This looks odd. Why do we need const compatible string? Shouldn't this
be allowed to be an SoC-powerzone specific compatible?

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
> +required:
> +  - compatible
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    powerzones {
> +
> +      compatible = "powerzones";
> +
> +      #powerzone-cells = <0>;
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
> +      #powerzone-cells = <0>;
> +      powerzones = <&PKG_PZ>;
> +    };

I think we discussed this in the earlier version too...

The above example describes a powerzone provider, but it doesn't
really conform to the binding. That's because the binding states that
powerzone providers should be inside a top-level "powerzone {" node.

I am wondering if we really need the toplevel "powerzone" node.

> +
> +    A57_1: big@1 {
> +      compatible = "arm,cortex-a57";
> +      reg = <0x0 0x0>;
> +      device_type = "cpu";
> +      #powerzone-cells = <0>;
> +      powerzones = <&PKG_PZ>;
> +    };
> +...
> --
> 2.25.1
>

No further comments from my side.

Kind regards
Uffe
