Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF4C46DED6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241073AbhLHXKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:10:22 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:38760 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbhLHXKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:10:21 -0500
Received: by mail-oi1-f181.google.com with SMTP id r26so6213808oiw.5;
        Wed, 08 Dec 2021 15:06:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=ZTyMJI4hTyE9L4Zhb7j0sOWecejaECV3ht0mOq9ry8g=;
        b=KhSsnwmpoa1/V85OtmTMczw3ctercu6HA+1scTqeB/KOkfrxoYuicysXJwpjjWLFHc
         VBXtFrt/d05XF0phu2NZ6aVxBvyix5dNAPTaWJzeWNkEKHrfmxcp9dhHOhrmE1Kg5543
         LKq5Kqe2cxb1AZPevWTFLe3Asc3Dz8FIs+4XlXhnjPDONQvXO5UYEHyuuA3imrnpxCvD
         rt5M2bImX5DQRhR81eoq7c14Q/AENgrKPJHndK7qfCN7je9jRw4Kzp9/8FtX3cTwnoCN
         4J7ZTOKXGsuw2ssf0nNOkyQ/feYNGbdVE9CFLh2XE8f7TA8B/LY90nWEzkCGcu9D88gA
         x11Q==
X-Gm-Message-State: AOAM530/xNwUgSGNjq0RHew1Is2U+2Btlf4viLvPxYHLUhSAI6Z4bRxq
        ApGLoijfOMwv8Oo3YBR4TfArf0OKqw==
X-Google-Smtp-Source: ABdhPJy572TEFvmQ84InPEY2Apekh9OAe6oDDy5/LdsgMAOOq8+29sIsh1dXymCw8zpSWn7RI+0T4Q==
X-Received: by 2002:a05:6808:350:: with SMTP id j16mr2336064oie.47.1639004808210;
        Wed, 08 Dec 2021 15:06:48 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id t14sm751222oth.81.2021.12.08.15.06.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:06:47 -0800 (PST)
Received: (nullmailer pid 596178 invoked by uid 1000);
        Wed, 08 Dec 2021 23:06:46 -0000
From:   Rob Herring <robh@kernel.org>
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kgugala@antmicro.com,
        mdudek@internships.antmicro.com, rdunlap@infradead.org,
        paulus@ozlabs.org, joel@jms.id.au, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        linux-mmc@vger.kernel.org, shorne@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krakoczy@antmicro.com, ulf.hansson@linaro.org,
        mholenko@antmicro.com
In-Reply-To: <20211208132042.3226275-3-gsomlo@gmail.com>
References: <20211208132042.3226275-1-gsomlo@gmail.com> <20211208132042.3226275-3-gsomlo@gmail.com>
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Date:   Wed, 08 Dec 2021 17:06:46 -0600
Message-Id: <1639004806.166681.596177.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 08 Dec 2021 08:20:41 -0500, Gabriel Somlo wrote:
> LiteSDCard is a small footprint, configurable SDCard core for FPGA
> based system on chips.
> 
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> 
> New in v3:
>   - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
>     bindings document (please let me know if that was premature, and
>     happy to take further review if needed :)
>   - add dedicated DT property for source clock frequency
> 
>  .../devicetree/bindings/mmc/litex,mmc.yaml    | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: properties:reg-names:items: 'oneOf' conditional failed, one must be fixed:
	[{'const': 'phy'}, {'const': 'core'}, {'const': 'reader'}, {'const': 'writer'}, {'const': 'irq (optional)'}] is not of type 'object'
	'irq (optional)' does not match '^[a-zA-Z0-9,.\\-_ #+/]+$'
	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: properties:reg: {'items': [{'description': 'PHY registers'}, {'description': 'CORE registers'}, {'description': 'DMA Reader buffer'}, {'description': 'DMA Writer buffer'}, {'description': 'IRQ registers (optional)'}], 'minItems': 4, 'maxItems': 5} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: properties:reg-names: {'items': [{'const': 'phy'}, {'const': 'core'}, {'const': 'reader'}, {'const': 'writer'}, {'const': 'irq (optional)'}], 'minItems': 4, 'maxItems': 5} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: ignoring, error in schema: properties: reg-names: items
warning: no schema found in file: ./Documentation/devicetree/bindings/mmc/litex,mmc.yaml
Documentation/devicetree/bindings/mmc/litex,mmc.example.dt.yaml:0:0: /example-0/mmc@12005000: failed to match any schema with compatible: ['litex,mmc']

doc reference errors (make refcheckdocs):


See https://patchwork.ozlabs.org/patch/1565210

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

