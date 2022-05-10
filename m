Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189F52248E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 21:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233704AbiEJTPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 15:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiEJTPj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 15:15:39 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB4B1F1C8E;
        Tue, 10 May 2022 12:15:38 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id s12-20020a4aeacc000000b0035ebb6d1a5fso3680054ooh.3;
        Tue, 10 May 2022 12:15:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UWdmzVGiWJEQpiXknEZ2ZsL5Gp0ikmaqn7ovyBn/uhI=;
        b=dEYkytqPyG9RY/DD3l/ReKtLEhi8ug0jH7nsqfKtwvpvF5ftG0H0hnUt0KThXyv5gJ
         trCryfZvw/qiCRcCiq0kbVfLkd246bDcB/aFsJRf5s5+3K8FcDldscAdAsk+sBHO1YDk
         b32/BJYbT0ec6c8SyQt/QuszWf9Wgjt1jOvAwSV2HeosKBxJdJIjVh4TmMJmnCc3u8sY
         2sPyjn9cqU7Z1OEKN2HVG0BArfYkFu6TKX7FOihTCa0k78b+p7+DhAxjfSibsN9S5/5u
         ZTmv8w2xPdrRqYe5JQaVjVXKqVPwJNYecyDOg2VvnDT9z7MqyyUjbCS6r6Jaxx3aICtW
         uOAw==
X-Gm-Message-State: AOAM533eT9xhUMdGrfVOCvlBdIIIhhXmyuRdbaL9s6pusAmkr1SaKKBx
        Ia18U8qzToLad2Wx/pnCaQ==
X-Google-Smtp-Source: ABdhPJymEIx0DSq4CwAZWyZqEOyBdFZqggzMouoTPYGQBph+ZmfCLYrx+F2v8IQfSOvMCJIG824wKw==
X-Received: by 2002:a05:6830:3143:b0:606:4edc:7e86 with SMTP id c3-20020a056830314300b006064edc7e86mr8465081ots.170.1652210137991;
        Tue, 10 May 2022 12:15:37 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 3-20020aca1003000000b00325cda1ffa0sm5605817oiq.31.2022.05.10.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 12:15:37 -0700 (PDT)
Received: (nullmailer pid 2426705 invoked by uid 1000);
        Tue, 10 May 2022 19:15:36 -0000
Date:   Tue, 10 May 2022 14:15:36 -0500
From:   Rob Herring <robh@kernel.org>
To:     matthew.gerlach@linux.intel.com
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v4 1/3] dt-bindings: soc: add bindings for Intel HPS Copy
 Engine
Message-ID: <Ynq52E93mcTXcw9H@robh.at.kernel.org>
References: <20220508142624.491045-1-matthew.gerlach@linux.intel.com>
 <20220508142624.491045-2-matthew.gerlach@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220508142624.491045-2-matthew.gerlach@linux.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2022 at 07:26:22AM -0700, matthew.gerlach@linux.intel.com wrote:
> From: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> 
> Add device tree bindings documentation for the Intel Hard
> Processor System (HPS) Copy Engine.
> 
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> ---
> v4:
>   - move from soc to soc/intel/
> 
> v3:
>   - remove unused label
>   - move from misc to soc
>   - remove 0x from #address-cells/#size-cells values
>   - change hps_cp_eng@0 to dma-controller@0
>   - remote inaccurate 'items:' tag
> ---
>  .../soc/intel/intel,hps-copy-engine.yaml      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
> new file mode 100644
> index 000000000000..8634865015cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soc/intel/intel,hps-copy-engine.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2022, Intel Corporation
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/soc/intel/intel,hps-copy-engine.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Intel HPS Copy Engine
> +
> +maintainers:
> +  - Matthew Gerlach <matthew.gerlach@linux.intel.com>
> +
> +description: |
> +  The Intel Hard Processor System (HPS) Copy Engine is an IP block used to copy
> +  a bootable image from host memory to HPS DDR.  Additionally, there is a
> +  register the HPS can use to indicate the state of booting the copied image as
> +  well as a keep-a-live indication to the host.
> +
> +properties:
> +  compatible:
> +    const: intel,hps-copy-engine
> +
> +  '#dma-cells':
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    bus@80000000 {
> +        compatible = "simple-bus";
> +        reg = <0x80000000 0x60000000>,
> +              <0xf9000000 0x00100000>;
> +        reg-names = "axi_h2f", "axi_h2f_lw";

A simple-bus doesn't have regs because it is simple. If you have 
registers, then you need a specific compatible. You can have 
'simple-bus' as a fallback if the bus is completely setup by firmware 
and the OS never needs to configure/manage it.

It also looks odd that ranges only has 4K of bus space and the bus 
registers are 1.5GB of space.

That's all kind of outside of the scope of this binding and you should 
just drop that part.

> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +        ranges = <0x00000000 0x00000000 0xf9000000 0x00001000>;
> +
> +        dma-controller@0 {
> +            compatible = "intel,hps-copy-engine";
> +            reg = <0x00000000 0x00000000 0x00001000>;
> +            #dma-cells = <1>;
> +        };
> +    };
> -- 
> 2.25.1
> 
> 
