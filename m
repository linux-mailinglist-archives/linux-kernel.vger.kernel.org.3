Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7514470330
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 15:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242413AbhLJO6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 09:58:11 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:38403 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhLJO6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 09:58:10 -0500
Received: by mail-ot1-f47.google.com with SMTP id n104-20020a9d2071000000b005799790cf0bso9866313ota.5;
        Fri, 10 Dec 2021 06:54:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Zdc9H3YW1oDCCZbDFkL7On4+7T8yfSZEeO3EBNfcdBg=;
        b=xsiGoXSr2BYBb/FXfU62VAOaGv4HCaTd3tlKh/Cs3mOVywiTPo0XF+yMMZWH298Z/6
         kiykZOK5gw/bRrAFpDjiVKOCCUVTdEKEhvOULgiRePKvZ9FYa5roc5zceN91hP1/Ajuq
         Y5y9lMB4dKwS+DtdHc7nv0oKUw7+cWWLewMc0s4lG+r//69oiv8fBYR+RJ3C2X3P/u7g
         pQM/DpSUYXQ9POII1tctpQfBeTxrjgFHP0Yvul3giJzZk0TbgE7M0F52JGUN6B0nw0cL
         nK724Z7x9LXDzd2HuoE025YAsGC3YcZMgDXxyer92E58LW+Bbr+6krY86LD6Uy2cVU3M
         jlWA==
X-Gm-Message-State: AOAM531O6JFXAeVuI82KIRUyjpw8hH1bHNxywHcjaAEcEADQ2/U2nuzc
        1W18YNN9xUgC93YzZg6gMw==
X-Google-Smtp-Source: ABdhPJxXAJ4hmhe+SH4o7q5tMWlEJ/ynPJzoWoPjxoYwskrBvavXsrur1xInHiNIsTpZzFWEhKFJUg==
X-Received: by 2002:a05:6830:1688:: with SMTP id k8mr11262889otr.238.1639148075315;
        Fri, 10 Dec 2021 06:54:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id n22sm565324oop.29.2021.12.10.06.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:54:34 -0800 (PST)
Received: (nullmailer pid 1333370 invoked by uid 1000);
        Fri, 10 Dec 2021 14:54:33 -0000
Date:   Fri, 10 Dec 2021 08:54:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        openbmc@lists.ozlabs.org, Tomer Maimon <tmaimon77@gmail.com>,
        Joel Stanley <joel@jms.id.au>, linux-kernel@vger.kernel.org,
        Avi Fishman <avifishman70@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>
Subject: Re: [PATCH v2 1/8] dt-bindings: arm/npcm: Add binding for global
 control registers (GCR)
Message-ID: <YbNqKfwYes0rH07B@robh.at.kernel.org>
References: <20211207210823.1975632-1-j.neuschaefer@gmx.net>
 <20211207210823.1975632-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211207210823.1975632-2-j.neuschaefer@gmx.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 10:08:16PM +0100, Jonathan Neuschäfer wrote:
> A nuvoton,*-gcr node is present in nuvoton-common-npcm7xx.dtsi and will
> be added to nuvoton-wpcm450.dtsi. It is necessary for the NPCM7xx and
> WPCM450 pinctrl drivers, and may later be used to retrieve SoC model and
> version information.
> 
> This patch adds a binding to describe this node.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> 
> ---
> v2:
> - Rename node in example to syscon@800000
> - Add subnode to example
> 
> v1:
> - https://lore.kernel.org/lkml/20210602120329.2444672-2-j.neuschaefer@gmx.net/
> ---
>  .../bindings/arm/npcm/nuvoton,gcr.yaml        | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
> new file mode 100644
> index 0000000000000..62020d7ac305b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/npcm/nuvoton,gcr.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/npcm/nuvoton,gcr.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Global Control Registers block in Nuvoton SoCs
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +description: |

Don't need '|' if no formatting.

> +  The Global Control Registers (GCR) are a block of registers in Nuvoton SoCs
> +  that expose misc functionality such as chip model and version information or
> +  pinmux settings.
> +
> +properties:
> +  compatible:
> +    items:
> +      - enum:
> +          - nuvoton,wpcm450-gcr
> +          - nuvoton,npcm750-gcr
> +      - const: syscon
> +      - const: simple-mfd

blank line

> +  reg: true

Need to define how many entries:

maxItems: 1


> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false

Ideally, you should define the child node names, but you can do this:

additionalProperties:
  type: object

which means anything undefined must be a node.

> +
> +examples:
> +  - |
> +    gcr: syscon@800000 {
> +      compatible = "nuvoton,npcm750-gcr", "syscon", "simple-mfd";
> +      reg = <0x800000 0x1000>;
> +
> +      uart-mux-controller {
> +        compatible = "mmio-mux";
> +        #mux-control-cells = <1>;
> +        mux-reg-masks = <0x38 0x07>;
> +        idle-states = <2>;
> +      };
> +    };
> --
> 2.30.2
> 
> 
