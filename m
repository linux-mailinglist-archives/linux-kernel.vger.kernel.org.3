Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5690465047
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:44:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351406AbhLAOsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350576AbhLAOrP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:47:15 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB77C061757
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:43:51 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id k37so63522105lfv.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 06:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gxTGNH4RjZnXC09mFHvXZGKvlJs0ViDxwUF13VP4Qnc=;
        b=j1sE7JdBShi/drRIhEhZBO6Hp8GoxIqTZ6X76Z4WdL4ClkjzJQawZwwxSyHJvThbkQ
         ZkA05uk98Wr8NHK3d8DBM0PVbPx1pa1hg5zXgKJEo+k1LSud82VtG94R67OuXuXZEkcw
         A+IOdOXLToG3/WZ0yYJHn0q8H1NuD5Uiuhzi7J87S9U3rIVekTdWElUcXELCpas/s3PR
         TOT7jsRHpS6bMNxCKwv6t3IyPcuYn+A3U3trC4B9K1XlFN+eQHd2jfXkOzEBxb5npEln
         ZPgC6y1dYfkjYJABVbOhiPiFn3SlidHHhD05wboAlT29k+UajlBI0t13iz9+wcaNsSfO
         DspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gxTGNH4RjZnXC09mFHvXZGKvlJs0ViDxwUF13VP4Qnc=;
        b=r9GSacvh8HLUmPvp9dch2Bq94aaEzhh80KhBUBWaRRaT6HO26ho1OQMWggkt6NaLX1
         o37sE1wWbt3E4AaR3iwT7Bb5DlL9YN6WkGPEcvNcYI6NEZUygBc34HOplWFWrbp3ryY8
         DNLRWv+feIm6cdNejayJwRugpVEIIDRElTQGjnUhOBF5CFBm+SrEDQXdoqCE7L/x78x4
         P7i61RZVGx8fyz33LN6E1zLWZL6lubPKHHs2TUoA0Q6ZI5sF/1HNlocLyeVDF5vTkPi2
         VDoKpscbbO+ai0lnnsIN7ykySMoWCcoXFTCmzM3V8W0g5MI9jDqJPD4mtwNFYZZzMZPo
         UIBw==
X-Gm-Message-State: AOAM532fc40kt5YRrZPxJ8mCwusDy+O0QRKtgP25ec+eFwGIjbItQiy4
        xzfosmK9uIGEU6dR3izQBkaGJHwMbEPEMEuYBljzaA==
X-Google-Smtp-Source: ABdhPJxVYx2b3NkGS8YC0h/FYV805PvlFm04JQsMyVC9RHmRfwgvzlv9TZ9QEWvSvv5Kz90my11HVJhsXcHlNDrWXa4=
X-Received: by 2002:ac2:4bc1:: with SMTP id o1mr6344492lfq.254.1638369829729;
 Wed, 01 Dec 2021 06:43:49 -0800 (PST)
MIME-Version: 1.0
References: <20211126181500.3404129-1-daniel.lezcano@linaro.org> <CAPDyKFoZo4p93JZUm4CUqO4DfrL8_YbyomqBzC59C0eTwa60CA@mail.gmail.com>
In-Reply-To: <CAPDyKFoZo4p93JZUm4CUqO4DfrL8_YbyomqBzC59C0eTwa60CA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 1 Dec 2021 15:43:13 +0100
Message-ID: <CAPDyKFoY3b=sbFffDRTAwnXc7OJ9w_B8t337BPbnU66SB-xQjg@mail.gmail.com>
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

On Wed, 1 Dec 2021 at 10:23, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Fri, 26 Nov 2021 at 19:15, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
> >
> > The proposed bindings are describing a set of powerzones.
> >
> > A power zone is the logical name for a component which is capable of
> > power capping and where we can measure the power consumption.
> >
> > A power zone can aggregate several power zones in terms of power
> > measurement and power limitations. That allows to apply power
> > constraint to a group of components and let the system balance the
> > allocated power in order to comply with the constraint.
> >
> > The ARM System Control and Management Interface (SCMI) can provide a
> > power zone description.
> >
> > The powerzone semantic is also found on the Intel platform with the
> > RAPL register.
> >
> > The Linux kernel powercap framework deals with the powerzones:
> >
> > https://www.kernel.org/doc/html/latest/power/powercap/powercap.html
> >
> > The powerzone can also represent a group of children powerzones, hence
> > the description can result on a hierarchy. Such hierarchy already
> > exists with the hardware or can be represented an computed from the
> > kernel.
> >
> > The hierarchical description was initially proposed but not desired
> > given there are other descriptions like the power domain proposing
> > almost the same description.
> >
> > https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/
> >
> > The description gives the power constraint dependencies to apply on a
> > specific group of logically or physically aggregated devices. They do
> > not represent the physical location or the power domains of the SoC
> > even if the description could be similar.
> >
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Ulf Hansson <ulf.hansson@linaro.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >    V1: Initial post
> >    V2:
> >      - Added pattern properties and stick to powerzone-*
> >      - Added required property compatible and powerzone-cells
> >      - Added additionnal property
> >      - Added compatible
> >      - Renamed to 'powerzones'
> >      - Added missing powerzone-cells to the topmost node
> >      - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > ---
> >  .../devicetree/bindings/power/powerzones.yaml | 109 ++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
> > new file mode 100644
> > index 000000000000..6e63bbc750c6
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/power/powerzones.yaml
> > @@ -0,0 +1,109 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/power/powerzones.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Power zones description
> > +
> > +maintainers:
> > +  - Daniel Lezcano <daniel.lezcano@linaro.org>
> > +
> > +description: |+
> > +
> > +  A System on Chip contains a multitude of active components and each
> > +  of them is a source of heat. Even if a temperature sensor is not
> > +  present, a source of heat can be controlled by acting on the
> > +  consumed power via different techniques.
> > +
> > +  A powerzone describes a component or a group of components where we
> > +  can control the maximum power consumption. For instance, a group of
> > +  CPUs via the performance domain, a LCD screen via the brightness,
> > +  etc ...
> > +
> > +  Different components when they are used together can significantly
> > +  increase the overall temperature, so the description needs to
> > +  reflect this dependency in order to assign a power budget for a
> > +  group of powerzones.
> > +
> > +  This description is done via a hierarchy and the DT reflects it. It
> > +  does not represent the physical location or a topology, eg. on a
> > +  big.Little system, the little CPUs may not be represented as they do
> > +  not contribute significantly to the heat, however the GPU can be
> > +  tied with the big CPUs as they usually have a connection for
> > +  multimedia or game workloads.
> > +
> > +properties:
> > +  $nodename:
> > +    const: powerzones
> > +
> > +  compatible:
> > +    const: powerzones
>
> This looks odd. Why do we need const compatible string? Shouldn't this
> be allowed to be an SoC-powerzone specific compatible?

Alright, after our recent discussions offlist, I believe the
compatible property should be entirely removed.

>
> > +
> > +patternProperties:
> > +  "^(powerzone)([@-].*)?$":
> > +    type: object
> > +    description:
> > +      A node representing a powerzone acting as an aggregator for all
> > +      its children powerzones.
> > +
> > +    properties:
> > +      "#powerzone-cells":
> > +        description:
> > +          Number of cells in powerzone specifier. Typically 0 for nodes
> > +          representing but it can be any number in the future to
> > +          describe parameters of the powerzone.
> > +
> > +      powerzones:
> > +        description:
> > +          A phandle to a parent powerzone. If no powerzone attribute is
> > +          set, the described powerzone is the topmost in the hierarchy.
> > +
> > +    required:
> > +      - "#powerzone-cells"
> > +
> > +required:
> > +  - compatible

This should be removed too, of course.

> > +
> > +additionalProperties: true

This should be set to "false", I think. There is no need for any
additional properties besides those that are being part of the binding
above.

> > +
> > +examples:
> > +  - |
> > +    powerzones {
> > +
> > +      compatible = "powerzones";
> > +
> > +      #powerzone-cells = <0>;

This toplevel "powerzones" node, should neither contain a compatible
nor a #powerzone-cells. Please drop this.

Instead we only need to describe the topology by using child nodes, as
in the example below.

> > +
> > +      SOC_PZ: powerzone-soc {
> > +        #powerzone-cells = <0>;
> > +      };
> > +
> > +      PKG_PZ: powerzone-pkg {
> > +        #powerzone-cells = <0>;
> > +        powerzones = <&SOC_PZ>;
> > +      };
> > +
> > +      GPU_PZ: powerzone-gpu {
> > +        #powerzone-cells = <0>;
> > +        powerzones = <&PKG_PZ>;
> > +      };
> > +    };
> > +
> > +  - |
> > +    A57_0: big@0 {
> > +      compatible = "arm,cortex-a57";
> > +      reg = <0x0 0x0>;
> > +      device_type = "cpu";
> > +      #powerzone-cells = <0>;
> > +      powerzones = <&PKG_PZ>;
> > +    };
>
> I think we discussed this in the earlier version too...
>
> The above example describes a powerzone provider, but it doesn't
> really conform to the binding. That's because the binding states that
> powerzone providers should be inside a top-level "powerzone {" node.

From our offlist discussion, it seems like the cpu nodes should not
have a #powerzone-cells. Instead, the powerzones property should be
sufficient, as it allows you to describe what powerzone(s) the cpu
belongs to, which is exactly what you need.

This also means that we need to extend the DT bindings for CPUs
(Documentation/devicetree/bindings/arm/cpus.yaml), to allow cpu nodes
to have a "powerzones" property. I believe we can do that separately,
on top of $subject patch, as cpus.yaml has "additionalProperties:
true".

>
> I am wondering if we really need the toplevel "powerzone" node.

Please ignore this comment. It has become clear to me that the
toplevel node serves a purpose.

>
> > +
> > +    A57_1: big@1 {
> > +      compatible = "arm,cortex-a57";
> > +      reg = <0x0 0x0>;
> > +      device_type = "cpu";
> > +      #powerzone-cells = <0>;

Ditto.

> > +      powerzones = <&PKG_PZ>;
> > +    };
> > +...
> > --
> > 2.25.1
> >
>

Kind regards
Uffe
