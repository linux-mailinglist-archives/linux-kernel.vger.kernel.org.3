Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1D0559FD2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232129AbiFXR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiFXR0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:26:38 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36DCEF3B;
        Fri, 24 Jun 2022 10:26:37 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id y18so3400641iof.2;
        Fri, 24 Jun 2022 10:26:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=Rz662/Zn6lBlNQLMw1j2/Ac9WyQjxNUeH6Y/SpV0998=;
        b=llCGrGPy2oR3UKUKf92bQ7HPvyH94xU18QAtz39/zJ78OzV/wJOV6MewVxagwVmFrj
         ocSPqFdKXi4WcXGk5R59hBO9UbRAonS6C061QG1hHZiu4qe9dXrz3wxld9o9eWBuHoCw
         lnsurBw0TkSAAJUqwuszZd1cpmFFQKd44M/3WmKL/f/AZR/fKUws/n4JHNh6keyMDu1t
         /v4J0eHByVXMFcedxp8hJwSX/Ykgk9nG+ciRvsprWup7XZf0IjzTWbnW9RJYZf0qgX5H
         C0yiONSJLfGSqXeszWD5EkU3dahYDHtCc0shE97+mDBJCJNxZX6GQ9ouynQFctqnJIT1
         GStQ==
X-Gm-Message-State: AJIora+a6jTBNSUcw2M4/LG6SXG45P4gjc1HpzQb5DDXcJEp4LPXoVU7
        9G+J3kZC+mi+e8YX1W1hvYM7+mCpog==
X-Google-Smtp-Source: AGRyM1s17ABWF+9JuVgOsvDU0B+DYN2MEhcfHVJ1KI3e8M1JaSdgtpWOtkEOvhi77t18qdtOVHEj5Q==
X-Received: by 2002:a05:6602:2c95:b0:669:e6fa:c3d4 with SMTP id i21-20020a0566022c9500b00669e6fac3d4mr33108iow.33.1656091595980;
        Fri, 24 Jun 2022 10:26:35 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id m16-20020a92cad0000000b002d79f619517sm1370186ilq.26.2022.06.24.10.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:26:35 -0700 (PDT)
Received: (nullmailer pid 146329 invoked by uid 1000);
        Fri, 24 Jun 2022 17:26:34 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, will@kernel.org,
        vdonnefort@google.com, maz@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220621080308.3952915-2-sebastianene@google.com>
References: <20220621080308.3952915-1-sebastianene@google.com> <20220621080308.3952915-2-sebastianene@google.com>
Subject: Re: [PATCH v7 1/2] dt-bindings: vcpu_stall_detector: Add qemu,vcpu-stall-detector compatible
Date:   Fri, 24 Jun 2022 11:26:34 -0600
Message-Id: <1656091594.340446.146328.nullmailer@robh.at.kernel.org>
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

On Tue, 21 Jun 2022 08:03:08 +0000, Sebastian Ene wrote:
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
>  .../misc/qemu,vcpu-stall-detector.yaml        | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.example.dtb: vmwdt@9030000: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/qemu,vcpu-stall-detector.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

