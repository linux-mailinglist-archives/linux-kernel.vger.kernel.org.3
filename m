Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDEC74815DA
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 18:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241147AbhL2RfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 12:35:06 -0500
Received: from mail-ua1-f42.google.com ([209.85.222.42]:42528 "EHLO
        mail-ua1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241136AbhL2RfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 12:35:03 -0500
Received: by mail-ua1-f42.google.com with SMTP id p1so16440159uap.9;
        Wed, 29 Dec 2021 09:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CRIcr4dPgsTH+8TrIIEohi32OfaIVizr8YqwXZhHEUg=;
        b=EOemC3O55wuXJ+JLOVlMzpK4CUwxzAbida5n+FpZxaPp5/eA1FmAFNIXRvqoNn9frY
         DJ+aJiq9DnoLqQxC8zwoIePVOOwLIn8f2Qz6RjkTkGg8kFjNGO3pqvUC3vvdEqHkDH+U
         DV9hWPUvksI0VHvDmXdSZ1sI502rq70ymF8e8vX/CradlueVn2m1FHoXreyOBQTJquUW
         9Gcrnkut79T2BS+Q8L/eoUKOvMbJdF11kqFO9xcFmNVbbotwGfdoznwP3+6OSYq1Lc64
         3jE1PGQhRCPMSQoV5jaWqYFI/mDfMKYf32qk+75kPOx0ttY8L6J46yy7fJvCxobUx8er
         9Z/w==
X-Gm-Message-State: AOAM531VfaV/kkCw+MLZEzrXM2vpdTDVZBrZtNX32tPy48ZbYg5k0xNf
        gw4MTofj6vmN2XRU+A45xQ==
X-Google-Smtp-Source: ABdhPJwK+QjIaT0uX/msb/urKRCTnyqMT3ldo30XmO9cX6Q39FkizEoIDbDsGN5GmZcxoeDjQG88Tg==
X-Received: by 2002:a05:6102:3e86:: with SMTP id m6mr542136vsv.77.1640799302106;
        Wed, 29 Dec 2021 09:35:02 -0800 (PST)
Received: from robh.at.kernel.org ([209.91.231.198])
        by smtp.gmail.com with ESMTPSA id h7sm4699302vke.54.2021.12.29.09.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 09:35:01 -0800 (PST)
Received: (nullmailer pid 824020 invoked by uid 1000);
        Wed, 29 Dec 2021 17:34:56 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Mark Brown <broonie@kernel.org>, Pavel Machek <pavel@ucw.cz>,
        Sebastian Reichel <sre@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
In-Reply-To: <20211228163930.35524-2-krzysztof.kozlowski@canonical.com>
References: <20211228163930.35524-1-krzysztof.kozlowski@canonical.com> <20211228163930.35524-2-krzysztof.kozlowski@canonical.com>
Subject: Re: [PATCH 1/4] dt-bindings: leds: maxim,max77693: convert to dtschema
Date:   Wed, 29 Dec 2021 13:34:56 -0400
Message-Id: <1640799296.482933.824019.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2021 17:39:27 +0100, Krzysztof Kozlowski wrote:
> Convert the LEDs bindings of Maxim MAX77693 MUIC to DT schema format.
> The existing bindings were defined in ../bindings/mfd/max77693.txt.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---
>  .../bindings/leds/maxim,max77693.yaml         | 105 ++++++++++++++++++
>  1 file changed, 105 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/maxim,max77693.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/common.example.dt.yaml: led-controller@0: 'reg' does not match any of the regexes: '^([a-z]+-)?led[01]?$', 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/leds/maxim,max77693.yaml

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/leds/maxim,max77693.yaml: Documentation/devicetree/bindings/mfd/maxim,max77693.yaml

See https://patchwork.ozlabs.org/patch/1573762

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

