Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8247B46E011
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241817AbhLIBMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 20:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234907AbhLIBMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 20:12:18 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09EA6C061746;
        Wed,  8 Dec 2021 17:08:46 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id u16so3834164qvk.4;
        Wed, 08 Dec 2021 17:08:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bQfC/GjazGM6i3ob6YqlN4SlMkdDBtM8EjnGT/4dlHA=;
        b=n5KQPA9KckKPDYCGROCtWZ7JDe9N0w1yHfaF4JKcmcQRoFQ9zmED72mSjErMvXSNBO
         nlQmP/UxVlNwJhJkCfAfDeISKRdobvvBBdROq0aDOI1C7oWcFKC5lLW9NiiHaXYlEVrl
         2qGeQxnsl5nujBvbXDyuLDnIzgpr+scmg6B13xVLqgNVwjLM+yZzUAdsN7mCyWJToPQs
         12BL2tbmTFqnkN6F6JCgdFc71kmU8S92egLuvkrMqagdG0AEiQhlRfLD42rv7VRg/3UX
         BAZL/7MrRwc7iMFGNUZ+kNmgA04Mgk7X3F1tR1lDqXvxmutFLNyd06FHvpPaoXJgWu7/
         0y/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bQfC/GjazGM6i3ob6YqlN4SlMkdDBtM8EjnGT/4dlHA=;
        b=qQIIqj4Ne7WdX3LEMChoWCNPPTnuvshJuzdLuLQx/dcLDr3UbrEUbdDq2Pz10gf60q
         FIcA33IIO2bPuEPxJPUOG20oNJkLD0qHWR9CzVpE9XKFfxNMXKMIvjotJ/tJrIhJRtTp
         pYGYS7NdsWuixUMVvrjV6RfGjWo+gLRau00Y/c8Eam9Bw2Vvc0iSkNU5cWOyjZoAwQFN
         llh63THaIM1X7QcJ5ftWP3Y4LNYXeMOw2sHI2f/NW1vAmTxxFRLSk9plLGaJIQ2go5Nf
         4zSaXvfgr3NFT2y0UX9Km7OLO2o0iktN0koTNBtAp3X1GLjWabJNFBUA88uy5UqepH/3
         ZIOA==
X-Gm-Message-State: AOAM532UFSjMsLAo/4Uv+n0de1eMbdZSq6s3ftyl4lWxCAr67tC9YVlX
        8euGTzYEbJ4cx3opKeBPEW8lXESaZYruMw==
X-Google-Smtp-Source: ABdhPJxJdFHNn8qL8IGdjSDFKRLcBH1y5qpJE6kmuOrHiZQ1byqi6q+7qQf6gL8D+Qhd6zFeI/rI3Q==
X-Received: by 2002:a0c:ef03:: with SMTP id t3mr11648614qvr.32.1639012121554;
        Wed, 08 Dec 2021 17:08:41 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id l2sm2682113qtk.41.2021.12.08.17.08.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 17:08:41 -0800 (PST)
Date:   Wed, 8 Dec 2021 20:08:33 -0500
From:   "Gabriel L. Somlo" <gsomlo@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kgugala@antmicro.com,
        mdudek@internships.antmicro.com, rdunlap@infradead.org,
        paulus@ozlabs.org, joel@jms.id.au, geert@linux-m68k.org,
        david.abdurachmanov@sifive.com, florent@enjoy-digital.fr,
        linux-mmc@vger.kernel.org, shorne@gmail.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org,
        krakoczy@antmicro.com, ulf.hansson@linaro.org,
        mholenko@antmicro.com
Subject: Re: [PATCH v3 2/3] dt-bindings: mmc: Add bindings for LiteSDCard
Message-ID: <YbFXERe0K3rfzZem@glsvmlin.ini.cmu.edu>
References: <20211208132042.3226275-1-gsomlo@gmail.com>
 <20211208132042.3226275-3-gsomlo@gmail.com>
 <1639004806.166681.596177.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1639004806.166681.596177.nullmailer@robh.at.kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 05:06:46PM -0600, Rob Herring wrote:
> On Wed, 08 Dec 2021 08:20:41 -0500, Gabriel Somlo wrote:
> > LiteSDCard is a small footprint, configurable SDCard core for FPGA
> > based system on chips.
> > 
> > Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
> > Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > ---
> > 
> > New in v3:
> >   - picked up r/b Geert Uytterhoeven <geert@linux-m68k.org> in DT
> >     bindings document (please let me know if that was premature, and
> >     happy to take further review if needed :)
> >   - add dedicated DT property for source clock frequency
> > 
> >  .../devicetree/bindings/mmc/litex,mmc.yaml    | 72 +++++++++++++++++++
> >  1 file changed, 72 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: properties:reg-names:items: 'oneOf' conditional failed, one must be fixed:
> 	[{'const': 'phy'}, {'const': 'core'}, {'const': 'reader'}, {'const': 'writer'}, {'const': 'irq (optional)'}] is not of type 'object'
> 	'irq (optional)' does not match '^[a-zA-Z0-9,.\\-_ #+/]+$'
> 	from schema $id: http://devicetree.org/meta-schemas/string-array.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: properties:reg: {'items': [{'description': 'PHY registers'}, {'description': 'CORE registers'}, {'description': 'DMA Reader buffer'}, {'description': 'DMA Writer buffer'}, {'description': 'IRQ registers (optional)'}], 'minItems': 4, 'maxItems': 5} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: properties:reg-names: {'items': [{'const': 'phy'}, {'const': 'core'}, {'const': 'reader'}, {'const': 'writer'}, {'const': 'irq (optional)'}], 'minItems': 4, 'maxItems': 5} should not be valid under {'required': ['maxItems']}
> 	hint: "maxItems" is not needed with an "items" list
> 	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
> /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/mmc/litex,mmc.yaml: ignoring, error in schema: properties: reg-names: items
> warning: no schema found in file: ./Documentation/devicetree/bindings/mmc/litex,mmc.yaml
> Documentation/devicetree/bindings/mmc/litex,mmc.example.dt.yaml:0:0: /example-0/mmc@12005000: failed to match any schema with compatible: ['litex,mmc']
> 
> doc reference errors (make refcheckdocs):
> 
> 
> See https://patchwork.ozlabs.org/patch/1565210
> 
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit.
> 

Thanks! 

I made the following changes:

--- a/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/litex,mmc.yaml
@@ -29,9 +29,8 @@ properties:
       - description: CORE registers
       - description: DMA Reader buffer
       - description: DMA Writer buffer
-      - description: IRQ registers (optional)
+      - description: IRQ registers
     minItems: 4
-    maxItems: 5

   reg-names:
     items:
@@ -39,12 +38,13 @@ properties:
       - const: core
       - const: reader
       - const: writer
-      - const: irq (optional)
+      - const: irq
     minItems: 4
-    maxItems: 5

   clocks:
     maxItems: 1
+    description:
+      Handle to reference clock.

   interrupts:
     maxItems: 1

... which took care of the bulk of the error messages reported. However,
I'm still getting the one below, whether or not I leave the `maxItems 1`
line there under `clocks:`

$ make ARCH=riscv CROSS_COMPILE=riscv64-unknown-linux-gnu-  dt_binding_check
  LINT    Documentation/devicetree/bindings
  CHKDT   Documentation/devicetree/bindings/processed-schema-examples.json
/home/somlo/linux/Documentation/devicetree/bindings/clock/litex,clock.yaml: properties:clock-output-names: {'description': 'List of strings of clock output signal names indexed by the first cell in the clock specifier.', 'minItems': 1, 'maxItems': 7, 'items': [{'const': 'CLKOUT0'}, {'const': 'CLKOUT1'}, {'const': 'CLKOUT2'}, {'const': 'CLKOUT3'}, {'const': 'CLKOUT4'}, {'const': 'CLKOUT5'}, {'const': 'CLKOUT6'}]} should not be valid under {'required': ['maxItems']}
	hint: "maxItems" is not needed with an "items" list
	from schema $id: http://devicetree.org/meta-schemas/items.yaml#
  SCHEMA  Documentation/devicetree/bindings/processed-schema-examples.json
/home/somlo/linux/Documentation/devicetree/bindings/clock/litex,clock.yaml: ignoring, error in schema: properties: clock-output-names
warning: no schema found in file: ./Documentation/devicetree/bindings/clock/litex,clock.yaml
  DTEX    Documentation/devicetree/bindings/mmc/litex,mmc.example.dts
  DTEX    Documentation/devicetree/bindings/media/renesas,imr.example.dts
  ...

It appears as though `make dt_binding_check` is trying to read from
`Documentation/devicetree/bindings/clock/litex,clock.yaml`, which
does not exist. The clock reference I'm talking about could be *any*
clock elsewhere in the dts!

This wasn't part of the originally reported errors, not sure why I'm
seeing it now. Also, not sure what (if anything) I still need to do
about it, any advice much appreciated!

Thanks,
--Gabriel
