Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8948C4828A8
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jan 2022 23:02:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiAAWB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jan 2022 17:01:56 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:38838 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiAAWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jan 2022 17:01:55 -0500
Received: by mail-ua1-f41.google.com with SMTP id o63so51960268uao.5;
        Sat, 01 Jan 2022 14:01:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=bX+hkhZ7Eih2D+5ldSl67WIDkHYTAjcaTRxOe2M6/bI=;
        b=BaIBmznt5j6Opl9ej0mSogv4SshBQWsNkb1UjsOV9oVIPc5CWmWpfMPY5zHKA3oGPl
         wort2Z/qMpsxZwFb7Gt2atlf8l25aOV6B18Yoqdhe/pXb+ArLitAs8jvSPEJNSke1PZs
         IMCeuUNYVG3pUMhKRuo9p6iF43dmJ3vAPNDQ10vlC1odP0kAjESPDhLx3S8uvE0h8nej
         FAw1TU9fF3tKMz5T/mBuiQIFoD8WIX4gA5fTUBoiDKPlxvcog/MNdVpVqY4XazZDJtcY
         6AU8o+AYW5I/Dvg/e8d8eclKs+Yib4Arv3RrcvOMtnlyvcwg3gM/qbXqY78tWDfi1pP9
         g+PQ==
X-Gm-Message-State: AOAM5315Cxib+ufmrTYVmGsGG3pdok9Z1ZVyfHpn9ceVCDKsVJjlH4MN
        cfQOA9Un7f5epashpoR2Cw==
X-Google-Smtp-Source: ABdhPJyWdNLwpfnF94PFb/qTr0tF3rgBARt7e7hWAwX8GRgLeaPIwaDnFO3VfDNxDAD+pvEzwpKRCw==
X-Received: by 2002:a05:6102:f12:: with SMTP id v18mr11491694vss.21.1641074514165;
        Sat, 01 Jan 2022 14:01:54 -0800 (PST)
Received: from robh.at.kernel.org ([209.91.235.3])
        by smtp.gmail.com with ESMTPSA id y7sm6542277uac.3.2022.01.01.14.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Jan 2022 14:01:53 -0800 (PST)
Received: (nullmailer pid 839551 invoked by uid 1000);
        Sat, 01 Jan 2022 22:01:44 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-pm@vger.kernel.org, Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
In-Reply-To: <c47705dbf6e9e287332f3ccb91578e81dbb81625.1640887456.git.sander@svanheule.net>
References: <cover.1640887456.git.sander@svanheule.net> <c47705dbf6e9e287332f3ccb91578e81dbb81625.1640887456.git.sander@svanheule.net>
Subject: Re: [RFC PATCH v1 1/3] dt-bindings: power: reset: Convert gpio-restart binding to schema
Date:   Sat, 01 Jan 2022 18:01:44 -0400
Message-Id: <1641074504.078105.839550.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Dec 2021 19:06:01 +0100, Sander Vanheule wrote:
> Convert the gpio-restart binding from plain text format to a schema
> binding, maintaining the original content and updating formatting where
> required.
> 
> Signed-off-by: Sander Vanheule <sander@svanheule.net>
> ---
>  .../bindings/power/reset/gpio-restart.txt     | 54 -----------
>  .../bindings/power/reset/gpio-restart.yaml    | 92 +++++++++++++++++++
>  2 files changed, 92 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.txt
>  create mode 100644 Documentation/devicetree/bindings/power/reset/gpio-restart.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml: maintainers:0: 'TODO' is not a 'email'
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/power/reset/gpio-restart.yaml: ignoring, error in schema: maintainers: 0
Documentation/devicetree/bindings/power/reset/gpio-restart.example.dt.yaml:0:0: /example-0/gpio-restart: failed to match any schema with compatible: ['gpio-restart']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1574223

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

