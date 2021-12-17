Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FFF4783C3
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 04:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbhLQDrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 22:47:36 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41842 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbhLQDrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 22:47:36 -0500
Received: by mail-ot1-f47.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so1312486otl.8;
        Thu, 16 Dec 2021 19:47:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IjN1lQ8TMy6cozBFxz44Wo6W8rmof9sCHtnvpj2Bo38=;
        b=uAGH3B6sc+JS3vMNEzOZb41oxZ1e2DuebanCRayHkCw3WnfJ40SipX0IoGdoJ4X+oe
         FMMl7X5Zs3+pKsptPlvMd9eTs+U35uUoFtGM+41zaTui2NB7C/ikqQ47gtsEFvNLUaB/
         K77L3ddR3ZdAAHQNv4eWbmggnf2XjjcPSun8W/n/a6MFIj740/aEYtTmmxm3yvygciAY
         qmzI7K61tPKVUKzXSaTeXnpg0ta6Y4TvbwxChi/HpdNkqmzd64/QQl4CCXN1rbcB9gUb
         dhAxnBLax0oG7Eq1jUiAJS0YXSCQBHCYmZBuf+bkZigarAsWuGI4wpDUQfUnZBgVynsI
         uhEg==
X-Gm-Message-State: AOAM531EBGbNyleBfwQa8RJxB5CdyH1b7NV10+mHL+QH7Ht/MzM5ydB1
        Xk0U5g4tee9UPem8If22wR6KmtKUeQ==
X-Google-Smtp-Source: ABdhPJy/kY6Z89M12GyVScc3+lNAcRyL5J+2ADa1Hgwv/kSmIaRfly5bpkzE/qTvRVurygXzGDxbLA==
X-Received: by 2002:a9d:73d7:: with SMTP id m23mr877918otk.380.1639712855192;
        Thu, 16 Dec 2021 19:47:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id p14sm1386195oou.31.2021.12.16.19.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 19:47:34 -0800 (PST)
Received: (nullmailer pid 1677946 invoked by uid 1000);
        Fri, 17 Dec 2021 03:47:33 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     Lee Jones <lee.jones@linaro.org>, linux-rtc@vger.kernel.org,
        linux-input@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Support Opensource <support.opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20211216164037.2888316-2-alexandre.ghiti@canonical.com>
References: <20211216164037.2888316-1-alexandre.ghiti@canonical.com> <20211216164037.2888316-2-alexandre.ghiti@canonical.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: Migrate DA9063 text bindings to YAML
Date:   Thu, 16 Dec 2021 21:47:33 -0600
Message-Id: <1639712853.383823.1677945.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Dec 2021 17:40:37 +0100, Alexandre Ghiti wrote:
> DA9063 devices bindings used text format, so migrate those bindings to YAML
> format before adding any new bindings.
> 
> Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
> ---
> 
> Changes in v2:
> - Fix all errors detected with make dt_binding_checks
> 
>  .../bindings/input/da9063-onkey.yaml          |  39 ++++++
>  .../devicetree/bindings/mfd/da9063.txt        | 111 ------------------
>  .../devicetree/bindings/mfd/da9063.yaml       | 105 +++++++++++++++++
>  .../bindings/regulator/da9063-regulator.yaml  |  51 ++++++++
>  .../devicetree/bindings/rtc/da9063-rtc.yaml   |  31 +++++
>  .../bindings/watchdog/da9063-watchdog.yaml    |  31 +++++
>  6 files changed, 257 insertions(+), 111 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/input/da9063-onkey.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/da9063.txt
>  create mode 100644 Documentation/devicetree/bindings/mfd/da9063.yaml
>  create mode 100644 Documentation/devicetree/bindings/regulator/da9063-regulator.yaml
>  create mode 100644 Documentation/devicetree/bindings/rtc/da9063-rtc.yaml
>  create mode 100644 Documentation/devicetree/bindings/watchdog/da9063-watchdog.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.example.dt.yaml: da9063@58: 'interrupt-controller', 'onkey', 'regulators', 'rtc', 'wdt' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/trivial-devices.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.example.dt.yaml: da9063@58: regulators: 'compatible' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.example.dt.yaml: da9063@58: regulators: 'bcore1', 'ldo11' do not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.yaml
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.example.dt.yaml: da9063@58: 'wdt' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mfd/da9063.yaml

doc reference errors (make refcheckdocs):
Documentation/devicetree/bindings/input/da9062-onkey.txt: Documentation/devicetree/bindings/mfd/da9063.txt

See https://patchwork.ozlabs.org/patch/1569315

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

