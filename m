Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00B8E4775E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 16:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbhLPP3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 10:29:34 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:42715 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbhLPP3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 10:29:32 -0500
Received: by mail-ot1-f42.google.com with SMTP id 47-20020a9d0332000000b005798ac20d72so29339037otv.9;
        Thu, 16 Dec 2021 07:29:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=nd0xNoxLdpMIETPTqt7EOTZuURPFhkkV6DEMEZNnfsY=;
        b=dxcHcIHz5LNrvLJ0cYk6A19BLsA9FLDW2QFrKojP3bGuc2mXHSwxeo/WbUZdKHuwS1
         52qXsQh53ECh7irK6EDhdLz6h7sCg8UhALOD62jPjl1D9HneT6eSjl3eTkKDyqEuxi+N
         Yru4J0aHWTcu+eTqCjWPprrR1JxDBYDjTcYhNjgWsLLAjDtd4R4WFD1wlHgZUfu2C9vc
         lB0rAU0tx99L3w7wTzPshvoOncdL94vd3iJVd57mhqBt+s9JK3ufcnZZfhifNfJ1zt4q
         ML8aiARsKeSxKLg+SACLHKhnrMBlRXl11y363c3NXXiRbc9A0wBjA2qF7klaQMWTe5/6
         OuYA==
X-Gm-Message-State: AOAM530dOKKYsNJpnbLhRObAcJ76alONMYJhNDvQoFaFvXfDFFmaaC5M
        TSNmXamBm4bjuGkCAfUsmw==
X-Google-Smtp-Source: ABdhPJxkmQtefEO2GB4IesaVw1R5Cx1RYgQ2YBifPAlnsoTenbd4aeBi77x3cWkw+Dtx8+aTJgXrNw==
X-Received: by 2002:a9d:6a56:: with SMTP id h22mr12884867otn.135.1639668571810;
        Thu, 16 Dec 2021 07:29:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q9sm1078070oti.32.2021.12.16.07.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 07:29:31 -0800 (PST)
Received: (nullmailer pid 251708 invoked by uid 1000);
        Thu, 16 Dec 2021 15:29:30 -0000
Date:   Thu, 16 Dec 2021 09:29:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Dejia Shang <dejia.shang@armchina.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        toby.shang@armchina.com
Subject: Re: [PATCH 3/4] dt-bindings: add vendor-prefix and documentation for
 Zhouyi NPU
Message-ID: <YbtbWh2dhMhMHMfX@robh.at.kernel.org>
References: <20211215103609.9268-1-dejia.shang@armchina.com>
 <20211215103609.9268-4-dejia.shang@armchina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211215103609.9268-4-dejia.shang@armchina.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 06:36:08PM +0800, Dejia Shang wrote:
> To enable this NPU IP in Arm-Linux system, SoC vendors should
> write devicetree files as documented.
> 
> Signed-off-by: Dejia Shang <dejia.shang@armchina.com>
> ---
>  .../bindings/misc/armchina,zhouyi-npu.yaml    | 57 +++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml b/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
> new file mode 100644
> index 000000000000..d3fdea101114
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/misc/armchina,zhouyi-npu.yaml
> @@ -0,0 +1,57 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/misc/armchina,zhouyi-npu.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: ArmChina Zhouyi NPU bindings
> +
> +maintainers:
> +  - Dejia Shang <dejia.shang@armchina.com>
> +
> +description: |
> +  Armchina AI accelerator IP - Zhouyi NPU
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: armchina,zhouyi-v1
> +      - const: armchina,zhouyi-v2
> +      - const: armchina,zhouyi

This says compatible must be a list of all 3 of these.

Where do v1 and v2 come from? We don't do version numbers in DT usually 
unless they correspond to h/w revision registers or h/w documentation. I 
would assume the h/w follows the Arm rXpY form?

> +
> +  reg:
> +    maxItems: 1
> +
> +  memory-region:
> +    maxItems: 2

What is each region?

This requires 2 entries, but the example only has 1.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    reserved-memory {
> +                #address-cells = <2>;
> +                #size-cells = <2>;
> +                ranges;
> +
> +                aipu_ddr_reserved: aipu-shmem@0xA0000000 {

aipu-shmem@a0000000

> +                        compatible = "shared-dma-pool";
> +                        no-map;
> +                        reg = <0x0 0xA0000000 0x0 0x4000000>;
> +                };
> +    };
> +
> +    aipu0@0x64000000 {

Drop '0x'

> +                compatible = "armchina,zhouyi";
> +                reg = <0x0 0x64000000 0x0 0x1000>;
> +                memory-region=<&aipu_ddr_reserved>;
> +                interrupts = <0 168 1>;
> +    };
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 66d6432fd781..4b1865d92455 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -123,6 +123,8 @@ patternProperties:
>      description: ARM Ltd.
>    "^armadeus,.*":
>      description: ARMadeus Systems SARL
> +  "^armchina,.*":
> +    description: Arm Technology (China) Co., Ltd.
>    "^arrow,.*":
>      description: Arrow Electronics
>    "^artesyn,.*":
> --
> 2.17.1
> 
> IMPORTANT NOTICE: The contents of this email and any attachments may be privileged and confidential. If you are not the intended recipient, please delete the email immediately. It is strictly prohibited to disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium. Thank you. ©Arm Technology (China) Co., Ltd copyright and reserve all rights. 重要提示：本邮件（包括任何附件）可能含有专供明确的个人或目的使用的机密信息，并受法律保护。如果您并非该收件人，请立即删除此邮件。严禁通过任何渠道，以任何目的，向任何人披露、储存或复制邮件信息或者据此采取任何行动。感谢您的配合。 ©安谋科技（中国）有限公司 版权所有并保留一切权利。
> 
