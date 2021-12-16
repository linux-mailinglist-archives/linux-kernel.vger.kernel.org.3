Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB28477CD5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241110AbhLPTwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbhLPTwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:52:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15518C061574;
        Thu, 16 Dec 2021 11:52:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7D12B82619;
        Thu, 16 Dec 2021 19:52:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BD53C36AE7;
        Thu, 16 Dec 2021 19:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639684335;
        bh=1wo4/ak8o23KqAWrQI+B/0IYAI6XmaqSFJPZ7O5ZzDg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YCyh58ux9JZ75uHsUL8ZLNaxO1aPznjxO6QySL+dd4MWk/x/P02Ep5uFTp+3Usu40
         P2Watpgg2ZiKq4t/f2F06UHBZLv2Xbk+5wtDf3Zoy2xBjs+Xt0UZFklzbjgN75/kOt
         /vTJALWEryYYm6sSTmQUxvDw7nCW1E60sg75zZb0CbKUXIBR5imWT4DW3iA/dxz/TA
         YKZoejwk6+WS2YPzc/OBWC+Vn6LBDJQ2sC1iadjlP7nQfHnq4m2YyMSX4RvqFjzljZ
         ubyOg2+zGH54sQtAclVvCHAKHZShbwxJ/0yBhqI2a/eQN28/e/8B7p9VjUrSwNsf+X
         7vn3zD14MxUzg==
Received: by mail-ed1-f50.google.com with SMTP id o20so91297639eds.10;
        Thu, 16 Dec 2021 11:52:15 -0800 (PST)
X-Gm-Message-State: AOAM530fzOc1VRKPUhOtc9tw89Kf/Nuks9mwcwaAK7dUMCPU1HSZUSEM
        Ruktnk7WoPGp4+hMPZ/nKUimF1R0X5gGCIwb2A==
X-Google-Smtp-Source: ABdhPJzdxLKqe4cLLckTiahQqVEOKCAcqB5i0Q1vQ+jpuMsdwWIRe6s/TC20LSMlEHytIJyfHJ8Kcp6w4X2bY1ffWhg=
X-Received: by 2002:a05:6402:84f:: with SMTP id b15mr22106468edz.342.1639684333732;
 Thu, 16 Dec 2021 11:52:13 -0800 (PST)
MIME-Version: 1.0
References: <cover.1639558366.git.mchehab+huawei@kernel.org> <9c3a3ff59408fcb60f7a5817a6f5d5f3053367fc.1639558366.git.mchehab+huawei@kernel.org>
In-Reply-To: <9c3a3ff59408fcb60f7a5817a6f5d5f3053367fc.1639558366.git.mchehab+huawei@kernel.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 16 Dec 2021 13:52:01 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+Nvruuajk1m_za3WVroLhv=i_0YFtfdDbjhjM58dmJ8g@mail.gmail.com>
Message-ID: <CAL_Jsq+Nvruuajk1m_za3WVroLhv=i_0YFtfdDbjhjM58dmJ8g@mail.gmail.com>
Subject: Re: [PATCH RESEND 1/7] dt-bindings: misc: add schema for USB hub on
 Kirin devices
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 2:54 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
> From: Yu Chen <chenyu56@huawei.com>
>
> This patch adds binding documentation to support USB HUB and
> USB data role switch of HiSilicon HiKey960 and HiKey970 boards.

I don't see the point in reviewing this given a driver was already
merged anyways, I can't imagine that plugging in one USB port causing
others to disconnect is a USB compliant design, and there are few
boards and fewer users that care.

> [mchehab: updated OF schema and added HiKey970 example]
> Signed-off-by: Yu Chen <chenyu56@huawei.com>
> Signed-off-by: John Stultz <john.stultz@linaro.org>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/
>
>  .../bindings/misc/hisilicon,hikey-usb.yaml    | 87 +++++++++++++++++++
>  1 file changed, 87 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
>
> diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> new file mode 100644
> index 000000000000..761ab686121a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> @@ -0,0 +1,87 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 Linaro Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: HiKey960/970 onboard USB GPIO Hub
> +
> +maintainers:
> +  - John Stultz <john.stultz@linaro.org>
> +
> +description: |
> +  Supports the onboard USB GPIO hubs found on HiKey960/970.
> +  Such hubs require a power supply for the USB I/O. Depending on the
> +  exact hub model, after USB I/O is powered up, a reset should be needed.
> +
> +  It also acts as a role-switch intermediary to detect the state of
> +  the USB-C port, to switch the hub into dual-role USB-C or host mode,
> +  which enables and powers up the onboard USB-A host ports.
> +
> +  Schematics about such hubs can be found here:
> +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> +    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - hisilicon,usbhub
> +
> +  typec-vbus-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the typec-vbus gpio
> +
> +  otg-switch-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the otg-switch gpio
> +
> +  hub-reset-en-gpios:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description: phandle to the hub reset gpio
> +
> +  usb-role-switch:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: Support role switch.
> +
> +  hub-vdd-supply:
> +    description: regulator for hub power
> +
> +  port:
> +    description: |
> +      describe hadware connections between USB endpoints.

USB endpoints? That's a s/w construct.

> +      Two ports are supported: the first being the endpoint that will

'port' means exactly 1 port.

> +      be notified by this driver, and the second being the endpoint
> +      that notifies this driver of a role switch.

IMO, this node should represent the HS switch. I would expect an input
port connected to the USB host and an output port with 2 endpoints
connected to USB-C connector and the hub.

host(HS port) -> (port@0)Switch(port@1)+--endpoint@0 -> USB-C connector
                                       |--endpoint@1 -> 2.0 hub

Then there's what does the hub look like which has been discussed
separately and is still not upstream I think.

But again, given this is devboard with limited use, I would just make
using USB-C vs. USB host connectors a fixed boot time configuration
with some one time setup and move on...

Rob
