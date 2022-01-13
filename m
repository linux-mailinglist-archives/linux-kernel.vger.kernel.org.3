Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3AF48E0EF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 00:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235592AbiAMXd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 18:33:58 -0500
Received: from mail-oi1-f178.google.com ([209.85.167.178]:42873 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230181AbiAMXd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 18:33:57 -0500
Received: by mail-oi1-f178.google.com with SMTP id y14so10030719oia.9;
        Thu, 13 Jan 2022 15:33:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nnDiZcTRb0Vq5tmUrkIdnau18hy40OrJF8krgzeHM4s=;
        b=XQz6Z4t+F3adhTYOXt0nwVLR33gepgs6+MGttHR8b5LmIwWgoyPXy0p70UCjphieTh
         5MJzQDVgIfqBjo3+RcSMAdX9gPWyojBSpNCn3ddA92e8E7H+eWXCufB+H/eRQ8MgntMw
         fqDqhyncKrKkVyr4RT7QvtbhnYaIIugqtFOS56+9ZHnHZSOPi2GTJg83Tjq31Loug4Us
         8gGLlh+O1cr9UN2fydJiNxgDCuwOlelg08RLyRSLtAMSKuqKmGzFgJWFnTM++EzpZOcK
         aiIBRRS5Q3aJVxKip4A+pmMzsWalqfvUEmO7FWVHQU2XWkDDoj0nKg8musqQRw69sqo4
         ++8g==
X-Gm-Message-State: AOAM533TzdRrSyLQn/XwHYf0TrUwDA3c61pRQm3qZimvdj/oFvy9cDCU
        JtwASTXP8HC2G5+1L8ZOWA==
X-Google-Smtp-Source: ABdhPJx0Y77Qvs2DmF3Cj72zTuxyrO8FZtkPJTHmtmi99ENq20DZ3v9GIO8BFW0+Lhurn8Yq7qzA/g==
X-Received: by 2002:a05:6808:15a0:: with SMTP id t32mr4881818oiw.60.1642116836724;
        Thu, 13 Jan 2022 15:33:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id j77sm1154569oih.35.2022.01.13.15.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 15:33:56 -0800 (PST)
Received: (nullmailer pid 374229 invoked by uid 1000);
        Thu, 13 Jan 2022 23:33:55 -0000
From:   Rob Herring <robh@kernel.org>
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        s.nawrocki@samsung.com, linus.walleij@linaro.org, soc@kernel.org,
        olof@lixom.net, pankaj.dubey@samsung.com, linux-fsd@tesla.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        catalin.marinas@arm.com
In-Reply-To: <20220113121143.22280-2-alim.akhtar@samsung.com>
References: <20220113121143.22280-1-alim.akhtar@samsung.com>        <CGME20220113122311epcas5p4b7c253b49dce3bd3580407fcf312e70e@epcas5p4.samsung.com> <20220113121143.22280-2-alim.akhtar@samsung.com>
Subject: Re: [PATCH 01/23] dt-bindings: clock: Document FSD CMU bindings
Date:   Thu, 13 Jan 2022 17:33:55 -0600
Message-Id: <1642116835.548930.374228.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 17:41:21 +0530, Alim Akhtar wrote:
> Add dt-schema documentation for Tesla FSD SoC clock controller.
> 
> Cc: linux-fsd@tesla.com
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>  .../bindings/clock/tesla,fsd-clock.yaml       | 212 ++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/tesla,fsd-clock.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/clock/tesla,fsd-clock.example.dts:19:18: fatal error: dt-bindings/clock/fsd-clk.h: No such file or directory
   19 |         #include <dt-bindings/clock/fsd-clk.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:373: Documentation/devicetree/bindings/clock/tesla,fsd-clock.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1413: dt_binding_check] Error 2

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1579595

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

