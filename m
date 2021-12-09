Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0610F46E91E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbhLINbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhLINba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:31:30 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C99C061746;
        Thu,  9 Dec 2021 05:27:57 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id g14so19150026edb.8;
        Thu, 09 Dec 2021 05:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vk2daIF5OXYXtedM90x7+5/RslfJ4qFjoxA4nldC5xI=;
        b=Q0Gd2NGlWZwB0ffQwyngb7goPVM+F4uqnbrLSKeTgqWNX/Orlc4nOU/zFVRvQwAjyw
         eOjidV+BAKiiEGOMtYKpomvwBg9zNwg6FoVXc9pzlN393aslRq1j6L7n4B1PuNrmRDFm
         oQzgVPwZTdSKjBKWWZMTztQe7lEYDC+FRaB5uTbEY8emBDvwjEd4uvtNI6Q8K2eahbJ1
         PEGTXpzUEIPIk3Z9YZg6Ty2OxWlfwm7JG8owrpfRGA294YyYZE5HOj45YiSoF+ldsXW2
         BvGt5w14sp2qXvDRxIc1oYY9TX9zsi52OfuBi10qW6Jw8rbO++BGabpTtOtRMqmX4IuF
         JKpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vk2daIF5OXYXtedM90x7+5/RslfJ4qFjoxA4nldC5xI=;
        b=tNeofs2EcdVwgAIbK88stXMf2aY/L35vQSHnE3apvLkaoHdFqOccrYik9EHd1ER3Cw
         v/ogU3J/QGmNjNrr9ulF7CDTDsw0pXwmSKW7RKEpejeEmATfTOvSID5Wd8h3UR6hs6yf
         rXn3X24LgOPbjYjXbiZ9lBIWZrLLsL+g6dCFiDgNZFxr+SbCwK5DsA6ZXiq6M5EIpNL9
         B0SwPu8FC1FC/vUSLxlKisM+iBjSM80HrLHX57Pwk4zjQoInVmfCwavhK79DL/yZrFCL
         mw60zlwvhhTWA4u2HtXJ5cERa60jVmAHOiDGHX0JZhv9zD5708XzD+u0tZyjMPug/shZ
         0OAA==
X-Gm-Message-State: AOAM5316xywLtq9FqSCkk+KRw23Gk6HmVSZn01j6Tnudbfojldgeoi/h
        Bik0SDLjkLbYqvYTwvbf0sbD55Lpw3dwP+9FQFc=
X-Google-Smtp-Source: ABdhPJyfw2zPYQLV3YO7vMfLh0nkkIcyyqRHexzFZSK4l5QwlPaQAtz8JK/Q6+yGjiySlrzL92jZW60N8glP6JBv4cQ=
X-Received: by 2002:a17:907:1b17:: with SMTP id mp23mr14969273ejc.521.1639056473627;
 Thu, 09 Dec 2021 05:27:53 -0800 (PST)
MIME-Version: 1.0
References: <20211202143828.3335-1-aford173@gmail.com>
In-Reply-To: <20211202143828.3335-1-aford173@gmail.com>
From:   Adam Ford <aford173@gmail.com>
Date:   Thu, 9 Dec 2021 07:27:42 -0600
Message-ID: <CAHCN7xKGq4ajoKCpTwPhwd45xrRecsh7_uqC4TLEahhZxvL8aA@mail.gmail.com>
Subject: Re: [PATCH V6 1/2] dt-bindings: soc: imx: Add binding doc for spba bus
To:     arm-soc <linux-arm-kernel@lists.infradead.org>
Cc:     Adam Ford-BE <aford@beaconembedded.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 8:38 AM Adam Ford <aford173@gmail.com> wrote:
>
> Add binding doc for fsl,spba-bus.
>

Rob / Shawn,

Any feedback on this series?  I am not very good with YAML, but my
intent was to name the bus 'spba-bus' and the second patch in the
series was designed to go through all the SoC device trees and update
them to reflect this name to remove a bunch of the splat generated
when building various imx boards.

thanks

adam

> Signed-off-by: Adam Ford <aford173@gmail.com>
> ---
> V6:  Rebase on 5.16-rc and rename spba@xxxx to spba-bus@xxxx since
>      most dsti files use that naming convention.
>
> V5:  Rebase on 5.10-rc2 to be able to check yaml
>      Add Reg entry
>
> V4:  Remove an accidental makefile change
>      Move type:object under additional properties
>
> V3:  Rebase sample from aips-bus example
>      Split off from series adding i.MX8M Nano functions to reduce noise
>
> V2:  Attempted to update yaml from feedback
>
> diff --git a/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> new file mode 100644
> index 000000000000..d42dbb0bbc2e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/bus/fsl,spba-bus.yaml
> @@ -0,0 +1,68 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bus/fsl,spba-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Shared Peripherals Bus Interface
> +
> +maintainers:
> +  - Shawn Guo <shawnguo@kernel.org>
> +
> +description: |
> +  A simple bus enabling access to shared peripherals.
> +
> +  The "spba-bus" follows the "simple-bus" set of properties, as
> +  specified in the Devicetree Specification.  It is an extension of
> +  "simple-bus" because the SDMA controller uses this compatible flag to
> +  determine which peripherals are available to it and the range over which
> +  the SDMA can access.  There are no special clocks for the bus, because
> +  the SDMA controller itself has its interrupt and clock assignments.
> +
> +select:
> +  properties:
> +    compatible:
> +      contains:
> +        const: fsl,spba-bus
> +  required:
> +    - compatible
> +
> +properties:
> +  $nodename:
> +    pattern: "^spba-bus(@[0-9a-f]+)?$"
> +
> +  compatible:
> +    items:
> +      - const: fsl,spba-bus
> +      - const: simple-bus
> +
> +  '#address-cells':
> +    enum: [ 1, 2 ]
> +
> +  '#size-cells':
> +    enum: [ 1, 2 ]
> +
> +  reg:
> +    maxItems: 1
> +
> +  ranges: true
> +
> +required:
> +  - compatible
> +  - '#address-cells'
> +  - '#size-cells'
> +  - reg
> +  - ranges
> +
> +additionalProperties:
> +  type: object
> +
> +examples:
> +  - |
> +    spba-bus@30000000 {
> +        compatible = "fsl,spba-bus", "simple-bus";
> +        #address-cells = <1>;
> +        #size-cells = <1>;
> +        reg = <0x30000000 0x100000>;
> +        ranges;
> +    };
> --
> 2.32.0
>
