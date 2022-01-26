Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB6349D50E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbiAZWLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:11:05 -0500
Received: from mail-ot1-f42.google.com ([209.85.210.42]:37838 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232955AbiAZWK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:10:58 -0500
Received: by mail-ot1-f42.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so702812otp.4;
        Wed, 26 Jan 2022 14:10:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=WkgrBZdK1SLpHGAVXfNOltnYkqtjeMzdyZx8rVxeVCY=;
        b=PrElu5GkwfvdjtqR/rQMr5XEdmQzaok/+dbaeWYH3+mS7GGC3SpyLTpbI60A4wopVf
         wsHV5W+tZGJBdnbalLnAb+jvJiY712KaSUbQdsxB9hsdzOBrpA58dMO6CAgLu9PPPTaT
         8tK4uUfeU58gNFRMxiiXM/Z4r3++XlopWv83fV+OCLyT52EUeL8QziScQXnhJQxGl9vc
         oToUbey+lRHyaQPlSv0URhyHK+my5RPIRGqBZwXym1KSzS2+7qU4IQbI19ZccrTvKzyA
         kbihWY4JMknpDLwcWEKupGIIYbSYAIA9wDdUVTCdWR0c6ed1xC3aXpUy/jbWcNyYbHJl
         STqg==
X-Gm-Message-State: AOAM5326obx1wdBzOYOzDZid+V/Hd0OnqOumr/tC8QC4hZ2yr0NEG2Ts
        dLPAl6gT5apiN2v9HoXxFw==
X-Google-Smtp-Source: ABdhPJyymDD88ZL2LqFkXNFomWKidJoNCsoHOuEjyfp1nr9Pt0JBV3H6ITJqJB5axvda2aZfnTRydg==
X-Received: by 2002:a9d:7683:: with SMTP id j3mr558897otl.252.1643235058121;
        Wed, 26 Jan 2022 14:10:58 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id 124sm9247170oif.7.2022.01.26.14.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:10:57 -0800 (PST)
Received: (nullmailer pid 1535106 invoked by uid 1000);
        Wed, 26 Jan 2022 22:10:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, daniel.lezcano@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20220126160021.3537591-1-clabbe@baylibre.com>
References: <20220126160021.3537591-1-clabbe@baylibre.com>
Subject: Re: [PATCH v2] dt-bindings: timer: Convert faraday,fttmr010 to yaml
Date:   Wed, 26 Jan 2022 16:10:52 -0600
Message-Id: <1643235052.913333.1535105.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 16:00:21 +0000, Corentin Labbe wrote:
> Converts timer/faraday,fttmr010.txt to yaml.
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> Changes since v1:
> - added moxart example
> - relaxed some contraints as driver only support one clock and one
>   interrupt (as used by moxa,moxart-timer)
> 
>  .../bindings/timer/faraday,fttmr010.txt       | 38 --------
>  .../bindings/timer/faraday,fttmr010.yaml      | 88 +++++++++++++++++++
>  2 files changed, 88 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.txt
>  create mode 100644 Documentation/devicetree/bindings/timer/faraday,fttmr010.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1584531


timer@1e782000: interrupts-extended: [[1, 0, 16, 4], [1, 0, 17, 4], [1, 0, 18, 4], [1, 0, 19, 4], [1, 0, 20, 4], [1, 0, 21, 4], [1, 0, 22, 4], [1, 0, 23, 4]] is too long
	arch/arm/boot/dts/aspeed-ast2600-evb-a1.dt.yaml
	arch/arm/boot/dts/aspeed-ast2600-evb.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-bletchley.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-cloudripper.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-elbert.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-facebook-fuji.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-ibm-everest.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-ibm-rainier-1s4u.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-ibm-rainier-4u.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-inventec-transformers.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dt.yaml

timer@1e782000: '#pwm-cells', 'fttmr010,pwm-outputs' do not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/aspeed-bmc-vegman-n110.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-vegman-rx20.dt.yaml
	arch/arm/boot/dts/aspeed-bmc-vegman-sx20.dt.yaml

