Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FF0486A37
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243107AbiAFSzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:55:45 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46242 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243061AbiAFSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:55:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F22DA61DC2;
        Thu,  6 Jan 2022 18:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68643C36AEB;
        Thu,  6 Jan 2022 18:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641495340;
        bh=hUSBuncfdYSMo8JYah8e80uOyS1OIGFpsNc2vV+EOuo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OXdd6Z0116/9Sx5fcHmCnUWOjkYlE+rfSgQ3/vq1G42Pmvu6g/SJF6ELx2+huB91g
         XoLKXn4Zc3hhOAkggWalI25A2HrPo+LLy+ZzK/ci6L9axJqtZOGneYNF/3tT4Vsuxv
         rJ1HnD34j7hq4+z1XNHWUltg8nO7EULrVBqsbSlgTw4HL8n2tpnaEOEoQBUII5gGlE
         uqj93jY/Pkk7BwhUE/CtCGmVBlHbsFBDcD4/SpKcTrzpe6j6WtsePgFm8qY5aCOOM6
         uWxalChD6rY1aOhnzsJqcHl7AMFlUckyr3t70wGuYuF4wOkVlzoVMki3IB9vClXEIR
         MiFwHRj8lOEKg==
Received: by mail-ed1-f50.google.com with SMTP id q25so4451865edb.2;
        Thu, 06 Jan 2022 10:55:40 -0800 (PST)
X-Gm-Message-State: AOAM53134R4b6+evWffGty7j5HUqV1a5SaQprjBoSkgMmU1Z6SF2W+VS
        icmQO4foSS4IpFHfxpJpXPwIcz7V57ZkdwIIxQ==
X-Google-Smtp-Source: ABdhPJw9WxLjYgVOSm32VR2+V+3X6pv+18TJ2gujjOSgM+fLMn8xkbFnouhimP1Rqm6xeCbe28L+fy93zOCBGcPfc30=
X-Received: by 2002:aa7:d5c7:: with SMTP id d7mr2854351eds.280.1641495338714;
 Thu, 06 Jan 2022 10:55:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1641354285.git.tonyhuang.sunplus@gmail.com> <1d946b61174adf4216c79728d56dcc1eb8a86b38.1641354285.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <1d946b61174adf4216c79728d56dcc1eb8a86b38.1641354285.git.tonyhuang.sunplus@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 6 Jan 2022 12:55:25 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLtP+2BaHUxTpYUBtCY13UHY8hs677PPBtZD20Vdwq65g@mail.gmail.com>
Message-ID: <CAL_JsqLtP+2BaHUxTpYUBtCY13UHY8hs677PPBtZD20Vdwq65g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-binding: mmc: Add mmc yaml file for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 4, 2022 at 11:20 PM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> Add mmc yaml file for Sunplus SP7021

There's a typo in the DT list address. Please resend so checks run.
Looks fine otherwise.

>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v2:
>  - Modify maintainers e-mail address.
>
>  .../devicetree/bindings/mmc/sunplus-mmc.yaml       | 60 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 65 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
>
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> new file mode 100644
> index 0000000..1c39af2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus-mmc.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Ltd. Co. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus-mmc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: sunplus MMC controller
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +maintainers:
> +  - Tony Huang <tonyhuang.sunplus@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: sunplus,sp7021-emmc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    minItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    mmc0: mmc@9c003b00 {
> +        compatible = "sunplus,sp7021-emmc";
> +        reg = <0x9c003b00 0x180>;
> +        interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&clkc 0x4e>;
> +        resets = <&rstc 0x3e>;
> +        bus-width = <8>;
> +        max-frequency = <52000000>;
> +        non-removable;
> +        disable-wp;
> +        cap-mmc-highspeed;
> +        mmc-ddr-3_3v;
> +        no-sdio;
> +        no-sd;
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fb18ce7..01ed57a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18242,6 +18242,11 @@ L:     netdev@vger.kernel.org
>  S:     Maintained
>  F:     drivers/net/ethernet/dlink/sundance.c
>
> +SUNPLUS MMC DRIVER
> +M:     Tony Huang <tonyhuang.sunplus@gmail.com>
> +S:     Maintained
> +F:     Documentation/devicetree/bindings/mmcc/sunplu-mmc.yaml
> +
>  SUPERH
>  M:     Yoshinori Sato <ysato@users.sourceforge.jp>
>  M:     Rich Felker <dalias@libc.org>
> --
> 2.7.4
>
