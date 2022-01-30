Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D16F4A32CF
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353560AbiA3AW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:22:28 -0500
Received: from mail-oi1-f176.google.com ([209.85.167.176]:43927 "EHLO
        mail-oi1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353529AbiA3AWU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:22:20 -0500
Received: by mail-oi1-f176.google.com with SMTP id t199so3099599oie.10;
        Sat, 29 Jan 2022 16:22:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ibh5bZb+8onvBhI3GZYIGBn3IOvNBzxGMepZQyo+6ek=;
        b=sFW172SNZ/RdnODM/VftOIePk+7FP+koZ3V2qgBqi9Xy79g9Sob7cyONtxyvrHzOsM
         Qo3JnJ+ab8GRUI0Fj3sgq/4jgY257dafsqB580jmhRxI/cvXv/OwHOb4seDULBiv4OQw
         qQklj/BhRXpP6P1Gq4K/E8M4scDYjyR0TWYCds+Wno3+1rR71kgsXyxE2evKH2WpYw02
         BDBfL1zUi6qunUvgrcJazwRryh9qjC1LG8LTDfNMJPx45iJOJZTeRhGp9+al5NTWb4i0
         lI6jJ7OvnRfVyR/TxbtWhbgs8Q+AadAiFDoCgt1A1HajRgS52dadKNLJydTPkG1YB+HT
         qfVA==
X-Gm-Message-State: AOAM531JaBvrTzWB3RF5DsF+s0RX7DI+LTOK5+tntgHI2N1TXf7GC7HH
        t1ewE8HAjqXE3Wzk2RmsMQ==
X-Google-Smtp-Source: ABdhPJxks5VGix5iWHqoMoUIgzq1MfZ1Qhz2CqmrUq3Gw6cO1IsliqmYZDbUrJ6JnFbO8Tb4RG1vDw==
X-Received: by 2002:aca:bb07:: with SMTP id l7mr14920384oif.166.1643502139874;
        Sat, 29 Jan 2022 16:22:19 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id v4sm9027933oou.1.2022.01.29.16.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 16:22:19 -0800 (PST)
Received: (nullmailer pid 416951 invoked by uid 1000);
        Sun, 30 Jan 2022 00:22:17 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Avi Fishman <avifishman70@gmail.com>,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Patrick Venture <venture@google.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        openbmc@lists.ozlabs.org, Nancy Yuen <yuenn@google.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220128214427.1990183-1-j.neuschaefer@gmx.net>
References: <20220128214427.1990183-1-j.neuschaefer@gmx.net>
Subject: Re: [PATCH] dt-bindings: timer: nuvoton,npcm7xx-timer: Convert to YAML
Date:   Sat, 29 Jan 2022 18:22:17 -0600
Message-Id: <1643502137.246273.416950.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jan 2022 22:44:26 +0100, Jonathan Neuschäfer wrote:
> Let's convert this devicetree binding to YAML, to make it easier to
> extend later.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/timer/nuvoton,npcm7xx-timer.txt  | 21 ---------
>  .../bindings/timer/nuvoton,npcm7xx-timer.yaml | 46 +++++++++++++++++++
>  2 files changed, 46 insertions(+), 21 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/timer/nuvoton,npcm7xx-timer.example.dt.yaml:0:0: /example-0/timer@f0008000: failed to match any schema with compatible: ['nuvoton,npcm750-timer']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1585958

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

