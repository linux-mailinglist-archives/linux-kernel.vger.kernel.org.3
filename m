Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9425951FC9C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 14:23:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234358AbiEIMZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 08:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiEIMZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 08:25:01 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08152573E3;
        Mon,  9 May 2022 05:21:07 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id v65so14916826oig.10;
        Mon, 09 May 2022 05:21:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=eaGt5OyolhplGC6uOu4KJBZNOPQ6VU39njlT+3mB1VQ=;
        b=a4YiBcQT29zWFdXUbOLhZeGpuX434Hlp4O+8xXADEcJ52B/HT5N0JvVyckFg01leww
         J8Ko6q9FsCiswpGhrRRBXqx3ZH9k0ZKd0s70K4ljzUThfNDwbE+YKNV5VspFCdXme6R3
         ANGFjswnuJD1EMZKc3VvZoX08GYvac+NUC1vLE/V6AIEW0kndrASS9k2fRr8YHrNjvah
         3M+Pmr3znA7B30kgwEcZrTluOxEJH2n/M5bcRuXr7unEN/rt7XVKdbc1So52zsbi1W4J
         dI4PJZnkMuX6jQaTliw0UWD6NVYIE/XOtKq41CFu2PvHLfGkhNZ3p4OxAYY0rSDZzPtY
         0Gwg==
X-Gm-Message-State: AOAM530B078SMYZnJAfM4g9by561p4XG8GE1+uN8AvUq1d2QCUhWDl3V
        4Kw1at4bZx4x0qByw7F8pbCGrwX7Hg==
X-Google-Smtp-Source: ABdhPJzk6aBwaYU1fUd7SMLss146WuFEPgsGy12u0eTEobAY+83Gk+1qrXHoH6d1k/T7lx1IxVyHOg==
X-Received: by 2002:a05:6808:10d6:b0:326:d4b2:83b with SMTP id s22-20020a05680810d600b00326d4b2083bmr1150047ois.92.1652098867014;
        Mon, 09 May 2022 05:21:07 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id l21-20020a544515000000b00325cda1ffb8sm4241847oil.55.2022.05.09.05.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 05:21:06 -0700 (PDT)
Received: (nullmailer pid 3576233 invoked by uid 1000);
        Mon, 09 May 2022 12:20:58 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Arnd Bergmann <arnd@arndb.de>, maz@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        will@kernel.org, qperret@google.com, linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
In-Reply-To: <20220509091103.2220604-2-sebastianene@google.com>
References: <20220509091103.2220604-1-sebastianene@google.com> <20220509091103.2220604-2-sebastianene@google.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector compatible
Date:   Mon, 09 May 2022 07:20:58 -0500
Message-Id: <1652098858.579388.3576232.nullmailer@robh.at.kernel.org>
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

On Mon, 09 May 2022 09:11:04 +0000, Sebastian Ene wrote:
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
>  .../bindings/misc/vcpu_stall_detector.yaml    | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
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

