Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC94249D511
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 23:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbiAZWLH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 17:11:07 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:43693 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiAZWLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 17:11:02 -0500
Received: by mail-oi1-f182.google.com with SMTP id p203so2296284oih.10;
        Wed, 26 Jan 2022 14:11:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QEBmmXY/w14IkJPvP4tfoWBs7S4k/e361MpXKSCcDwQ=;
        b=pTvqzFBbL24wrN7/yqy1OILZvymXIMjqjzIXE+HoOe4COyksQmHwkAuoYBBHG+Muqt
         ZefWTUVm+UOOJawDWFi64ggIRzIbEO+QwFbOOSvl2Jszg9AmhfKaCztG1VN93X18oUSZ
         6EAlb5UN5NiXkn8mLE9IwfvYDT2mv8Nbzr/5MH97dxadYFoQecQiTkTnEnszphAlcCME
         n6piDJ5bXNtcD5Eox+IW6weMcYJyagLY+GBQO7f1CSV071z70vUkXQUVbSbS+G+XF1Ja
         vf/gb9/Py6Q1UAtv8SyygWBH6zjyd1n5HSobTrbXM/j1JDDk4Cg6GFuqqrTm2RvA/jXA
         4RhA==
X-Gm-Message-State: AOAM531rXTGAPE+FqtuHF6JIz9emvkoC6gUOfrtdu/8ZFvwov+HFsr2c
        bSTtms8C1fKF3ImMuY/fapVtczHivA==
X-Google-Smtp-Source: ABdhPJxs9I0NzNRvqp2+Lx+8NbRjWD0I/BTpvalZLOrPhW0GxvleuRy5CNXcqTpBOW70lA8yWRXm/A==
X-Received: by 2002:a54:4e06:: with SMTP id a6mr428051oiy.224.1643235061535;
        Wed, 26 Jan 2022 14:11:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k13sm1074619ots.48.2022.01.26.14.11.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 14:11:00 -0800 (PST)
Received: (nullmailer pid 1535102 invoked by uid 1000);
        Wed, 26 Jan 2022 22:10:52 -0000
From:   Rob Herring <robh@kernel.org>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux@roeck-us.net,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, jdelvare@suse.com
In-Reply-To: <20220126200350.3633576-1-clabbe@baylibre.com>
References: <20220126200350.3633576-1-clabbe@baylibre.com>
Subject: Re: [PATCH] dt-bindings: hwmon: gpio-fan: convert to YAML
Date:   Wed, 26 Jan 2022 16:10:52 -0600
Message-Id: <1643235052.887619.1535101.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2022 20:03:50 +0000, Corentin Labbe wrote:
> Converts hwmon/gpio-fan.txt to YAML
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
> ---
> 
> I didnt found any clear maintainer and since DT yaml mandates a
> maintainer section, I set devicetree@vger.kernel.org.
> 
>  .../devicetree/bindings/hwmon/gpio-fan.txt    | 41 --------
>  .../devicetree/bindings/hwmon/gpio-fan.yaml   | 96 +++++++++++++++++++
>  2 files changed, 96 insertions(+), 41 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.txt
>  create mode 100644 Documentation/devicetree/bindings/hwmon/gpio-fan.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/hwmon/gpio-fan.example.dt.yaml:0:0: /example-0/gpio@4d000000: failed to match any schema with compatible: ['cortina,gemini-gpio', 'faraday,ftgpio010']
Documentation/devicetree/bindings/hwmon/gpio-fan.example.dt.yaml:0:0: /example-0/gpio@4d000000: failed to match any schema with compatible: ['cortina,gemini-gpio', 'faraday,ftgpio010']
Documentation/devicetree/bindings/hwmon/gpio-fan.example.dt.yaml:0:0: /example-1/gpio@4d000000: failed to match any schema with compatible: ['cortina,gemini-gpio', 'faraday,ftgpio010']
Documentation/devicetree/bindings/hwmon/gpio-fan.example.dt.yaml:0:0: /example-1/gpio@4d000000: failed to match any schema with compatible: ['cortina,gemini-gpio', 'faraday,ftgpio010']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1584654

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

