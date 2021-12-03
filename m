Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 492F74680A1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383545AbhLCXiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:38:04 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:42653 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383542AbhLCXh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:56 -0500
Received: by mail-oi1-f181.google.com with SMTP id n66so8743252oia.9;
        Fri, 03 Dec 2021 15:34:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eoZz1/dE2uVxxnzNEe6cyt2XRJa+hiTl6N5jptXjP3M=;
        b=qayHWLvM2KIiHe/I3+K/oerdt+5asL6KRusXS4FjOv2KVVT4akFoCd4M4TjNDi4GBF
         LdS924BRMOo0KxoSAZilcRLGPsREcuGNZy3SRrVVf4i3ooFE2EdiKaYfLo9Z1QpWFfwx
         fiyyjzjA0JsRy9pIe1KYFWjaIkE4ML+WMO9QCTKLBcWopW/1WgX+Hoy0xMcSwRyB0M8p
         tgn/U7gkqBeg4g6TM1xEL6Yf40ToIlbWZfFVS27S5Yquh6XKCQcQVNloodcJcX/+fd9X
         g+SFPKY7ebJgmIonoFBjLKeQgYuafpBDzypWVLk8OuIieHPIyb/WoUiaCwOfpg7E0O6Y
         XjSw==
X-Gm-Message-State: AOAM532Mb6Ezk/S+KuCjtJwXJ7sXD+snDk3UI6kFCAwp/olWxpMGMVnm
        RMCK9pGx+3ve2hhrYei7TA==
X-Google-Smtp-Source: ABdhPJwDbeAXVAQZ2vLphcIxOo4mkEU5tjYPEpZZO3smEEfXMEv5SE51yep6JOTtmec1IaaZujuNXA==
X-Received: by 2002:a05:6808:23cb:: with SMTP id bq11mr12281951oib.2.1638574471549;
        Fri, 03 Dec 2021 15:34:31 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k16sm877919otp.21.2021.12.03.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:31 -0800 (PST)
Received: (nullmailer pid 1043015 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jayesh Choudhary <j-choudhary@ti.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        alsa-devel@alsa-project.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, peter.ujfalusi@gmail.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211203120243.24173-1-j-choudhary@ti.com>
References: <20211203120243.24173-1-j-choudhary@ti.com>
Subject: Re: [PATCH v4] ASoC: dt-bindings: davinci-mcasp: convert McASP bindings to yaml schema
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.292522.1043014.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 03 Dec 2021 17:32:43 +0530, Jayesh Choudhary wrote:
> Convert the bindings for McASP controllers for TI SOCs from txt
> to YAML schema.
> 
> Adds additional properties 'clocks', 'clock-names', 'power-domains',
> '#sound-dai-cells' and 'port' which were missing from txt file.
> Removes properties 'sram-size-playback' and 'sram-size-capture'
> since they are not used.
> Adds 'dmas' and 'dma-names' in the example which were missing from
> the txt file.
> Changes 'interrupts' and 'interrupt-names' from optional to
> required properties.
> Changes 'op-mode', 'serial-dir' and 'tdm-slots' to optional properties
> as they are not needed if the McASP is used only as GPIO.
> 
> Adds the yaml file in the 'MAINTAINERS' under the heading 'TEXAS
> INSTRUMENTS ASoC DRIVERS'
> 
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
> Changelog:
> v4:
> - changes the commit message
> - adds type and description to relevant properties
> - changes maxItems for 'serial-dir'
> - removes properties 'sram-size-playback' and 'sram-size-capture'
>   as they are not used
> - removes 'function-gpios'
> - removes 'num-serializer'
> - marks 'tdm-slots', 'serial-dir' and 'op-mode' as optional properties
> - adds the yaml file in MAINTAINERS
> 
> v3:
> - removes maxItems from 'clock-names'
> 
> v2:
> - changes the commit message
> - modifies the properties 'clocks', 'clock-names', 'dma-names',
>   'dmas', 'interrupts' and 'interrupt-names' according to the
>   arm SOCs
> - adds 'ports' and 'num-serializer' as node properties
> 
>  .../bindings/sound/davinci-mcasp-audio.txt    |  86 --------
>  .../bindings/sound/davinci-mcasp-audio.yaml   | 185 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  3 files changed, 186 insertions(+), 86 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/davinci-mcasp-audio.yaml
> 

Running 'make dtbs_check' with the schema in this patch gives the
following warnings. Consider if they are expected or the schema is
incorrect. These may not be new warnings.

Note that it is not yet a requirement to have 0 warnings for dtbs_check.
This will change in the future.

Full log is available here: https://patchwork.ozlabs.org/patch/1563206


mcasp@0: 'num-serializer' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-cm-t335.dt.yaml
	arch/arm/boot/dts/am335x-sbc-t335.dt.yaml

mcasp@0: 'rt-num-evt' does not match any of the regexes: 'pinctrl-[0-9]+'
	arch/arm/boot/dts/am335x-wega-rdk.dt.yaml

