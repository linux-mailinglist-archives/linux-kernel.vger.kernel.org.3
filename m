Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76C748BC86
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 02:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347839AbiALBjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 20:39:33 -0500
Received: from mail-oi1-f177.google.com ([209.85.167.177]:37776 "EHLO
        mail-oi1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347577AbiALBjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 20:39:32 -0500
Received: by mail-oi1-f177.google.com with SMTP id i9so1515145oih.4;
        Tue, 11 Jan 2022 17:39:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qdIcRKaVDKEiavDCLtRMCg5WPuA7iCwXkSufra4ZQJg=;
        b=ZYif7v83ZybSqHcj8y8iMEwme+32t42K7s3orPPw2bq9TiKCOFMKB3HVHyCCJzAMTs
         1BhX1rL/uxQE97MRyW+mXvft0VZIOsUYSuU45YgmHUffsmURFv7/cE7xkmXBqV959xsY
         gK9dGxaqIACu4e3z8kAVAV/rQxiO8CxNxakTu2B0xxB83fCFt7qMMXUk0SVIecCKlSjA
         i8uRkTWTe+SreK8EmbccM779eHYcpmASU2NvVpJio8JYRAkHpl96I54xiDh3oRX/9xbw
         CTO4XzcTtIs8/pnfXTHdUhkrBNo6l+8hzj3Eqzwu00LsDLmOXSy/6jXd4p8+doJu29iQ
         /FFg==
X-Gm-Message-State: AOAM533lcXnn+9tNhzmaO3RbU0VDt3if8JUJfCWrHwKw/Xtt1eKBXMwc
        ylWMv9LtqwpitV7/T/qVvQ==
X-Google-Smtp-Source: ABdhPJyvaylwY+Lk8pQNxsY/F4ltABSH6XPfCndrxTlgQuwwQYB4L64RAM4ldTXZjDg4em/HmLyokQ==
X-Received: by 2002:a05:6808:1150:: with SMTP id u16mr3797134oiu.74.1641951571882;
        Tue, 11 Jan 2022 17:39:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id x14sm565828oiv.39.2022.01.11.17.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 17:39:31 -0800 (PST)
Received: (nullmailer pid 3882056 invoked by uid 1000);
        Wed, 12 Jan 2022 01:39:30 -0000
Date:   Tue, 11 Jan 2022 19:39:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Edwin Chiu <edwinchiu0505tw@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, daniel.lezcano@linaro.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bingings:arm:sunplus:add sp7021 compatible
 string to sunplus,idle-state.yaml
Message-ID: <Yd4xUscZwoRHiOzF@robh.at.kernel.org>
References: <cover.1641432983.git.edwinchiu0505tw@gmail.com>
 <317c55864546698b02c39b16b082812c2ac9400c.1641432983.git.edwinchiu0505tw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <317c55864546698b02c39b16b082812c2ac9400c.1641432983.git.edwinchiu0505tw@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 10:00:07AM +0800, Edwin Chiu wrote:
> Add the compatible string for cpuidle state on sp7021
> 
> Signed-off-by: Edwin Chiu <edwinchiu0505tw@gmail.com>
> ---
> Changes in v3
>  - Align email address of sob and sender
>  - Added sp7021 compatible string
> 
>  .../bindings/arm/sunplus/sunplus,idle-state.yaml   | 59 ++++++++++++++++++++++
>  MAINTAINERS                                        |  5 ++
>  2 files changed, 64 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
> new file mode 100644
> index 0000000..64281ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/sunplus/sunplus,idle-state.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) Sunplus Co., Ltd. 2021
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/sunplus/sunplus,idle-state.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sunplus SOC cpuidle state
> +
> +maintainers:
> +  - Edwin Chiu<edwinchiu0505tw@gmail.com>
> +
> +description: |
> +  Sunplus SOC cpuidle state
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - sunplus,sp7021-idle-state
> +
> +  entry-latency-us:
> +    description:
> +      Worst case latency in microseconds required to enter the idle state.
> +
> +  exit-latency-us:
> +    description:
> +      Worst case latency in microseconds required to exit the idle state.
> +      The exit-latency-us duration may be guaranteed only after
> +      entry-latency-us has passed.
> +
> +  min-residency-us:
> +    description:
> +      Minimum residency duration in microseconds, inclusive of preparation
> +      and entry, for this idle state to be considered worthwhile energy wise
> +      (refer to section 2 of this document for a complete description).
> +
> +required:
> +  - compatible
> +  - entry-latency-us
> +  - exit-latency-us
> +  - min-residency-us
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +
> +    idle-state {
> +      CPU_IDLE: cpu_idle {
> +        compatible = "sunplus,sp7021-idle-state";
> +        entry-latency-us = <8000>;
> +        exit-latency-us = <700>;
> +        min-residency-us = <9000>;
> +      };
> +    };

Again, this is no different than the generic binding. There is no need 
for this binding. Just wanting a different driver is not a reason for a 
duplicate schema.

Rob
