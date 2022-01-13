Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A7A48DBC8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236721AbiAMQ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:29:44 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:34684 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236701AbiAMQ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:29:42 -0500
Received: by mail-oi1-f182.google.com with SMTP id r131so8407416oig.1;
        Thu, 13 Jan 2022 08:29:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=CusFUBG9Oz+FsYX8f2EjVVpRfC5MMMM3gtsBOX9vADQ=;
        b=MGJxMDZJgu0oj7goQVEaUltrBiyNYQHiNV+EPBiiaihaaS48qBRiAV5KBAU4L4+r5u
         GLDJnA9Nx9O55vG6HyjzQ+z8Z5KXFipxwopgIBJD93JNOXWEzeFv0JIDAFhzrHb2XFWJ
         ngo48l2dspwotml8FlQlC8qkegv+SYz8rdAvvQzqfx2BpK9fcJfC8VYgUw2xWgq1YBwA
         eEKSELHklV9A/XmyA8zRcNKug0S2SudxDaANnDLIuWqA2/bxekZ5YoTf5dsU3jXk2qSh
         FDj76gRbfIFGYhirLIUkqcWHsunu72Q3zS6f27y3rJi0ntD6RO+9HGCwcqX/+pff5FUq
         Qcrg==
X-Gm-Message-State: AOAM533NeM+nbvfQnV0+usayembrcNRt3nfTbPPMJwU8V7wgujDRIaki
        Vf7t3u+WXEei36HGkdUGu3VAWekSqg==
X-Google-Smtp-Source: ABdhPJyRgESHBfGHq7zyS63j/N2RP/5yfJZqpp+OQ6tJcIGznR8kw0goZE3ZrNBY6fLox981RdQNPA==
X-Received: by 2002:a05:6808:1a28:: with SMTP id bk40mr3803203oib.26.1642091381706;
        Thu, 13 Jan 2022 08:29:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id f9sm557489oto.56.2022.01.13.08.29.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:29:40 -0800 (PST)
Received: (nullmailer pid 3647189 invoked by uid 1000);
        Thu, 13 Jan 2022 16:29:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     david.abdurachmanov@sifive.com, geert@linux-m68k.org,
        ulf.hansson@linaro.org, linux-kernel@vger.kernel.org,
        mdudek@internships.antmicro.com, shorne@gmail.com,
        paulus@ozlabs.org, joel@jms.id.au, andy.shevchenko@gmail.com,
        kgugala@antmicro.com, florent@enjoy-digital.fr, hdanton@sina.com,
        devicetree@vger.kernel.org, mholenko@antmicro.com,
        linux-mmc@vger.kernel.org, krakoczy@antmicro.com,
        robh+dt@kernel.org, rdunlap@infradead.org
In-Reply-To: <20220112222747.3135585-3-gsomlo@gmail.com>
References: <20220112222747.3135585-1-gsomlo@gmail.com> <20220112222747.3135585-3-gsomlo@gmail.com>
Subject: Re: [PATCH v13 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Thu, 13 Jan 2022 10:29:34 -0600
Message-Id: <1642091374.254625.3647188.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jan 2022 17:27:46 -0500, Gabriel Somlo wrote:
> LiteSDCard is a small footprint, configurable SDCard core for
> FPGA based SoCs.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
> 
> New in v13:
>   - add `vmmc-supply` requirement
> 
>  .../devicetree/bindings/mmc/litex,mmc.yaml    | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.example.dt.yaml: mmc@12005000: 'vmmc-supply' is a required property
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1579360

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

