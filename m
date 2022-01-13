Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D8E48D0C3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 04:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbiAMDRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 22:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiAMDRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 22:17:34 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D146C06173F;
        Wed, 12 Jan 2022 19:17:34 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id a8so5337332qvx.2;
        Wed, 12 Jan 2022 19:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uG3pQtxj+kQP2KxNRSNQ4XEjcKAyEOlbmdPqDMlp97U=;
        b=gOpr/UNr5eV3u2bPC4IcBiiUqwRwQ+WMuDmso5ArSWRxh6g20AOMev/7Lb9F0ziqTQ
         J/G66KrzrY9GXZdT1Jtir1odGWcuStmjrttmUvxvLB7VUH8RX29xDQqRXj3TRWIGhWqw
         gBWO8bHq/0Ru4Ygd2K1ZYA4yi41H/CoI5VCKE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uG3pQtxj+kQP2KxNRSNQ4XEjcKAyEOlbmdPqDMlp97U=;
        b=ltAQqjes0320aFvhc+ejB1f+ewePU5dhcvoO5GH4Jzvmk0f8SqeBzR7G+/dK0DK9Bv
         hlVxyX0/bLt0XOXcwA1eaI0UKdEjXp6awytVSAtVhGap4U574DsUpeFZkjWEK39fy5Ju
         2LK0UdgflVW177vr+VXO4gHvOOEcQYdSzq35NjsR/qr2cNqtU4BljOWJwuos+xM8sBTU
         ZqTOMkmQip88O4z7qEO/ai1P5MGgmoRnJtPSM2RQ8tz8VC8v4Nk7JywLFUmbdDWRDKRJ
         E08arMI/XjvCQQWda2GDSz+TwxMwHT9KUBSLOWRj637Go8umg04jb5WfdDSPrnDe+k+i
         67Tw==
X-Gm-Message-State: AOAM531Kf38udWkYywMjcmiSX+Nff9dmyAwOOcVtXOxjuNlUYUFZ0fkd
        huXI2bSebftZRGCQtPndJhJich6vJiiXCFU9DZo=
X-Google-Smtp-Source: ABdhPJyYGgH51sQaqThiK/5CYNiJpMX4YiNmqrsx1jEIHvc0haWlE/tgAVrGGTbvfB3C4t16ThzTXF+ogb1+jCesuiE=
X-Received: by 2002:ad4:5e87:: with SMTP id jl7mr1404945qvb.130.1642043853106;
 Wed, 12 Jan 2022 19:17:33 -0800 (PST)
MIME-Version: 1.0
References: <20220112230247.982212-1-iwona.winiarska@intel.com> <20220112230247.982212-3-iwona.winiarska@intel.com>
In-Reply-To: <20220112230247.982212-3-iwona.winiarska@intel.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 13 Jan 2022 03:17:20 +0000
Message-ID: <CACPK8XcO5Z0f2bU6=+o2q7caGnoBdzQ5Dm8AVt-BNs3d_xmOJg@mail.gmail.com>
Subject: Re: [PATCH v5 02/13] dt-bindings: Add bindings for peci-aspeed
To:     Iwona Winiarska <iwona.winiarska@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Zev Weiss <zweiss@equinix.com>,
        David Muller <d.mueller@elsoft.ch>,
        Dave Hansen <dave.hansen@intel.com>,
        Billy Tsai <billy_tsai@aspeedtech.com>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 at 23:04, Iwona Winiarska <iwona.winiarska@intel.com> wrote:
>
> Add device tree bindings for the peci-aspeed controller driver.
>
> Co-developed-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> Signed-off-by: Iwona Winiarska <iwona.winiarska@intel.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  .../devicetree/bindings/peci/peci-aspeed.yaml | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/peci/peci-aspeed.yaml
>
> diff --git a/Documentation/devicetree/bindings/peci/peci-aspeed.yaml b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> new file mode 100644
> index 000000000000..1e68a801a92a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/peci/peci-aspeed.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/peci/peci-aspeed.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Aspeed PECI Bus Device Tree Bindings
> +
> +maintainers:
> +  - Iwona Winiarska <iwona.winiarska@intel.com>
> +  - Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> +
> +allOf:
> +  - $ref: peci-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - aspeed,ast2400-peci
> +      - aspeed,ast2500-peci
> +      - aspeed,ast2600-peci
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    description:
> +      Clock source for PECI controller. Should reference the external
> +      oscillator clock.
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  cmd-timeout-ms:
> +    minimum: 1
> +    maximum: 1000
> +    default: 1000
> +
> +  clock-frequency:
> +    description:
> +      The desired operation frequency of PECI controller in Hz.
> +    minimum: 2000
> +    maximum: 2000000
> +    default: 1000000
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/ast2600-clock.h>
> +    peci-controller@1e78b000 {
> +      compatible = "aspeed,ast2600-peci";
> +      reg = <0x1e78b000 0x100>;
> +      interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> +      clocks = <&syscon ASPEED_CLK_GATE_REF0CLK>;
> +      resets = <&syscon ASPEED_RESET_PECI>;
> +      cmd-timeout-ms = <1000>;
> +      clock-frequency = <1000000>;
> +    };
> +...
> --
> 2.31.1
>
