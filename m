Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF61E491369
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 02:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbiARBcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 20:32:51 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:36428 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiARBcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 20:32:50 -0500
Received: by mail-ot1-f46.google.com with SMTP id l64-20020a9d1b46000000b005983a0a8aaaso9571427otl.3;
        Mon, 17 Jan 2022 17:32:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=P+Jxt0OvUrJ81v3jLKHEhk3u+ZCM+iY0mn9/RH2Mh1M=;
        b=E7nrj5NvGOdT93pGBSG47DBUcQ1ISjAJR1UpXIwgpxqpI7UqE+Fx99+fm44VjcieER
         nUOIoYJWgJQ41yY7G/A8fMqORkHVVsWnEf7tnt5JWxggIPpucspV7hIlXZbW6S7SFNxp
         sMk4RR9yLm1osXHxuouyAo1DFI3Y+S+GXQVyK53f7r/hjRgC0ayJQoOzwWcTH30MckTg
         44kWbrSpo5SPEGcocZXYB8oMH6f9JkD8pPa05/2MuJ8hhjBi9onyDTVqXVuKovO+CkOr
         40Xcoblk2Hz3tSkaWFnshcWQaxRWHzXUCY/bNPCysxtEtxSrnpMnbgOHFZO7wTZ58bj1
         ipUQ==
X-Gm-Message-State: AOAM530ShVGuHuXHUagzXYdmyMlJ3BIxiYxaB16Sv0SHKQ0oRvBn/BOE
        Z4LqiXDVDprWFWxlQ2aHFQ==
X-Google-Smtp-Source: ABdhPJyUxD44GqSdP2i8ENrUIUJgbz0fin17AvAH/WFnn7fl33LyokLUv4ETiqhK5I/PAMSt4H0rLw==
X-Received: by 2002:a9d:77c7:: with SMTP id w7mr5073140otl.48.1642469569535;
        Mon, 17 Jan 2022 17:32:49 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id s11sm1976253otv.19.2022.01.17.17.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jan 2022 17:32:48 -0800 (PST)
Received: (nullmailer pid 545740 invoked by uid 1000);
        Tue, 18 Jan 2022 01:32:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ba6346942dfed14440e0243a6da510581389fbdd.1642434222.git.sylv@sylv.io>
References: <cover.1642434222.git.sylv@sylv.io> <ba6346942dfed14440e0243a6da510581389fbdd.1642434222.git.sylv@sylv.io>
Subject: Re: [PATCH v1 2/4] dt-bindings: hwmon/pmbus: Add vicor,bcm6123 Bus Converter
Date:   Mon, 17 Jan 2022 19:32:47 -0600
Message-Id: <1642469567.779234.545737.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 17:12:48 +0100, Marcello Sylvester Bauer wrote:
> Add bindings for BCM6123 Bus Converter from Vicor Corporation.
> 
> Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
> ---
>  .../bindings/hwmon/pmbus/vicor,bcm6123.yaml   | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml: 'maintainers' is a required property
	hint: Metaschema for devicetree binding documentation
	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.yaml: ignoring, error in schema: 
Documentation/devicetree/bindings/hwmon/pmbus/vicor,bcm6123.example.dt.yaml:0:0: /example-0/i2c/bcm6123@5f: failed to match any schema with compatible: ['vicor,bcm6123']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1580909

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

