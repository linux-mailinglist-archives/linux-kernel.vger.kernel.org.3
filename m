Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE6F54E2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377481AbiFPOFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 10:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376712AbiFPOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 10:05:05 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21582381B3;
        Thu, 16 Jun 2022 07:05:04 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id d123so1557507iof.10;
        Thu, 16 Jun 2022 07:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=QHrVv7NXWiujBosHB8gys2mN+dR79RUZ7jVtVzSWvms=;
        b=jjF+JjEe9DXDWtxSjMhIEiT5qaz69K9kGEEwbP8OhxCEVzDlCPy5RgVYZ2l2ppG5NW
         AKaUyom+FufuVKJmIoyQEFOJJx/Fm0t5VHvDcq3awZkdjtZ1dp2Y9T9aYKTLl2/LxEe9
         kORB1iphu0Q10uyeykH/z7SAgLKsCFYqycGDH4HtKRgniQL8KEhrbGGtkdbRhzExkFuS
         44Qc441f7mtdEFt7tukrpB8D6K6Eu/AI6ZBqcB8t5cSgqVk8kge/YOMIukamWwuYGDbl
         csadTn842RACmLB+U3yi+4yxTHwTlD77+GGl6sl9VPpPPPBmY+Ch5o2tSJUgvrFQfbW4
         M5ow==
X-Gm-Message-State: AJIora8J3A2gNWJZfZxPIMXu5caa3QU2y5SlhBZ/hMbjSKiJ2WYGsNFs
        2bBzq463yFe9Ma2JJKP7qQ==
X-Google-Smtp-Source: AGRyM1tmMBpewtMPlbEJ5qaei0T+/HbeN+LtCnmNuQ4BMbDmbM2P9VoMHC/89YMSuzPAVYkshEC1gw==
X-Received: by 2002:a05:6638:1a0e:b0:331:9a26:57c3 with SMTP id cd14-20020a0566381a0e00b003319a2657c3mr2714961jab.310.1655388302928;
        Thu, 16 Jun 2022 07:05:02 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id s20-20020a6bdc14000000b0066579afd3cbsm1171751ioc.50.2022.06.16.07.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 07:05:02 -0700 (PDT)
Received: (nullmailer pid 3391578 invoked by uid 1000);
        Thu, 16 Jun 2022 14:05:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, vdonnefort@google.com,
        maz@kernel.org, will@kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20220616092737.1713667-2-sebastianene@google.com>
References: <20220616092737.1713667-1-sebastianene@google.com> <20220616092737.1713667-2-sebastianene@google.com>
Subject: Re: [PATCH v6 1/2] dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector compatible
Date:   Thu, 16 Jun 2022 08:05:01 -0600
Message-Id: <1655388301.043228.3391577.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 09:27:38 +0000, Sebastian Ene wrote:
> The VCPU stall detection mechanism allows to configure the expiration
> duration and the internal counter clock frequency measured in Hz.
> Add these properties in the schema.
> 
> While this is a memory mapped virtual device, it is expected to be loaded
> when the DT contains the compatible: "qemu,vcpu-stall-detector" node.
> In a protected VM we trust the generated DT nodes and we don't rely on
> the host to present the hardware peripherals.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../bindings/misc/vcpu_stall_detector.yaml    | 49 +++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml: properties:timeout-sec: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/vcpu_stall_detector.yaml: ignoring, error in schema: properties: timeout-sec
Documentation/devicetree/bindings/misc/vcpu_stall_detector.example.dtb:0:0: /example-0/vmwdt@9030000: failed to match any schema with compatible: ['qemu,vcpu-stall-detector']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

