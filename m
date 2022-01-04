Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8A3548495B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbiADUhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:37:03 -0500
Received: from mail-oo1-f45.google.com ([209.85.161.45]:39624 "EHLO
        mail-oo1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiADUg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:36:58 -0500
Received: by mail-oo1-f45.google.com with SMTP id t13-20020a4a760d000000b002dab4d502dfso11657211ooc.6;
        Tue, 04 Jan 2022 12:36:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nv0bgOiiS/Wu+H1BCtcmnc11mDx7WiCemyjztTm21Mw=;
        b=x6qjUbKAgmzS3grnGrjATY8V2t/byjujNjnAVD3gY+BDSlZE7jMp0zZPY7kVSbnulQ
         x2U/k7abCcxdd/FOGXr+4Lroey9bR6txIBVjsPtLbYi4fhTIIma3G+Lx8OlvAlYAouvz
         ScQAnKAsEQSRHz7AwjZC7QJCvsd7JIyf//JPSxU0QfTsSb5DMU+Z6DmsRW1xTrcirFih
         JjrJq/QWLS7RegmGkLao+cELPtrt91GfK5xPiFjW0VGgAXQSvhF9MxamGMw/vqOz3Cav
         2DPrktN5sycj2EmzJt8CVdq5YzebN6cSLrz7GcYTb0qweTp55sEtKcrVkjTdIk+Oj6M4
         G3rw==
X-Gm-Message-State: AOAM531IOy3WlIhPwuEdghhslZ9M+fZDVOejoUdeXBlTZARw5hwogzzb
        hTD48+KiAp2n3wPnc2+QGw==
X-Google-Smtp-Source: ABdhPJzXPEcfT9GJOOYRk1n/ghzYHuu0N2mU0VfZIDsZkkPabESTUOgrAt1KKprLmE/mMlZPiyJrlg==
X-Received: by 2002:a4a:d184:: with SMTP id j4mr32438054oor.72.1641328617311;
        Tue, 04 Jan 2022 12:36:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t26sm7918184ott.28.2022.01.04.12.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jan 2022 12:36:56 -0800 (PST)
Received: (nullmailer pid 1378686 invoked by uid 1000);
        Tue, 04 Jan 2022 20:36:55 -0000
Date:   Tue, 4 Jan 2022 14:36:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Li-hao Kuo <lhjeff911@gmail.com>
Cc:     p.zabel@pengutronix.de, daniel.thompson@linaro.org,
        lee.jones@linaro.org, u.kleine-koenig@pengutronix.de,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        lh.kuo@sunplus.com, wells.lu@sunplus.com
Subject: Re: [PATCH v3 2/2] devicetree bindings mmc Add bindings doc for
 Sunplus SP7021
Message-ID: <YdSv53g+js4MnkEY@robh.at.kernel.org>
References: <cover.1640325539.git.lhjeff911@gmail.com>
 <9da84bfbb6d4d086a8f905dd0d80fb81720987f7.1640325539.git.lhjeff911@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9da84bfbb6d4d086a8f905dd0d80fb81720987f7.1640325539.git.lhjeff911@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 24, 2021 at 02:05:39PM +0800, Li-hao Kuo wrote:
> Add devicetree bindings mmc Add bindings doc for Sunplus SP7021
> 
> Signed-off-by: Li-hao Kuo <lhjeff911@gmail.com>
> ---
> Changes in v3:
>  - Addressed all comments from Mr. Rob Herring

No. The subject is still wrong and my comments on compatible still 
remain. For the latter, I just replied on the original thread.

>  - Modified SD/SDIO driver.

Wrong patch. And modified how? You need to list the changes from the 
last version one by one. This list should give the reviewer a clue as to 
which parts need to be reviewed again so we don't have to review the 
whole thing again nor remember what we said to change. The reviewer has 
probably reviewed 10s to 100 patches since the last version and doesn't 
remember what they said.

> 
>  .../devicetree/bindings/mmc/sunplus-sd2.yaml       | 73 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 74 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
> 
> diff --git a/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
> new file mode 100644
> index 0000000..2f96e35
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/mmc/sunplus-sd2.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SD/SDIO controller
> +
> +maintainers:
> +  - Li-hao Kuo <lhjeff911@gmail.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sunplus,sp7021-card
> +      - sunplus,sp7021-sdio
> +
> +  reg:
> +    items:
> +      - description: Base address and length of the SD/SDIO registers
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 1
> +
> +  max-frequency: true
> +
> +allOf:
> +  - $ref: "mmc-controller.yaml"
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - resets
> +  - pinctrl-names
> +  - pinctrl-0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/sp-sp7021.h>
> +    #include <dt-bindings/reset/sp-sp7021.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    sdcard: sdcard@9c003e80 {
> +       compatible = "sunplus,sp7021-card";
> +       reg = <0x9c003e80 0x280>;
> +       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clkc CARD_CTL1>;
> +       resets = <&rstc RST_CARD_CTL1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&mmc1_mux &mmc1_mux_cd>;
> +       max-frequency = <52000000>;
> +    };
> +    sdio: mmc@9c008400 {
> +       compatible = "sunplus,sp7021-sdio";
> +       reg = <0x9c008400 0x280>;
> +       interrupts = <21 IRQ_TYPE_LEVEL_HIGH>;
> +       clocks = <&clkc CARD_CTL1>;
> +       resets = <&rstc RST_CARD_CTL1>;
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pins_sdio>;
> +       max-frequency = <52000000>;
> +    };
> +...
> \ No newline at end of file
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2c1d9e8..297d512 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18246,6 +18246,7 @@ SUNPLUS SD/SDIO HOST CONTROLLER INTERFACE DRIVER
>  M:	Li-hao Kuo <lhjeff911@gmail.com>
>  L:	linux-mmc@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/mmc/sunplus-sd2.yaml
>  F:	drivers/mmc/host/sunplus_sd2.c
>  
>  SUPERH
> -- 
> 2.7.4
> 
> 
