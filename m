Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D6350C3FB
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:12:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbiDVWUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbiDVWTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:19:00 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6946619F406;
        Fri, 22 Apr 2022 14:10:54 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-e2fa360f6dso9916595fac.2;
        Fri, 22 Apr 2022 14:10:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=nkpxWseBP/plo2DUBRDP5JN3Nr8hDiVwhBve5yLw9dk=;
        b=6OECoqeiSGi8hqQDJ9ZQvnV/YW/Hpi2qrDOLGanOjCKINS8zXHR6S+WkNT08gZmLUg
         BmzWf/6US1PpLIyMoOXMoCfYtnpsKpB0347aP3zUWyuFlt6hQ2+j278jqaaXqqDkXXTK
         UmC3y3DMyHVJMu22Jr9Zm5vQjyv1D9n4UpfqfuZwOU5RLzQGcxgi6CEPdKokEzR4qhhI
         cszt+S5UVozKJ2KIpSmJCBUgLlbq3lgVSxrwrrysNNzNLwogNrVMar4imFMqGi5qkxzW
         TR7xn2wYDX6IE+WhDdkE+MF71iOLV3Q6n8QQnQPhOpa73ZQXsv1dxYhRgWlJ2/zuYlVL
         cLkA==
X-Gm-Message-State: AOAM5323Hs656mNy0sCOahEtDWQMtSSdNiZsG/VjmArWemqYmPlhXEUG
        WFkYtBguW1K+kMXqZHZ6Uw==
X-Google-Smtp-Source: ABdhPJyoDysv6ZfgdENY7PnCtNJ8UmdbnZxI0xJW/Jg5VPpPUi2roXtYVnAni5zJe8V14oMBYLUHuA==
X-Received: by 2002:a05:6870:40c3:b0:e6:81ae:a75a with SMTP id l3-20020a05687040c300b000e681aea75amr2774139oal.268.1650661853723;
        Fri, 22 Apr 2022 14:10:53 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p1-20020a05683003c100b005c927b6e645sm1107076otc.20.2022.04.22.14.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 14:10:53 -0700 (PDT)
Received: (nullmailer pid 2784284 invoked by uid 1000);
        Fri, 22 Apr 2022 21:10:47 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     maz@kernel.org, qperret@google.com,
        Rob Herring <robh+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        linux-kernel@vger.kernel.org, will@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org
In-Reply-To: <20220422141949.3456505-2-sebastianene@google.com>
References: <20220422141949.3456505-1-sebastianene@google.com> <20220422141949.3456505-2-sebastianene@google.com>
Subject: Re: [PATCH  v2 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
Date:   Fri, 22 Apr 2022 16:10:47 -0500
Message-Id: <1650661847.247811.2784283.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Apr 2022 14:19:49 +0000, Sebastian Ene wrote:
> The stall detection mechanism allows to configure the expiration
> duration and the internal counter clock frequency measured in Hz.
> Add these properties in the schema.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../devicetree/bindings/misc/vm-wdt.yaml      | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/vm-wdt.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/vm-wdt.yaml: properties:timeout-sec: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/vm-wdt.yaml: ignoring, error in schema: properties: timeout-sec
Documentation/devicetree/bindings/misc/vm-wdt.example.dtb:0:0: /example-0/watchdog: failed to match any schema with compatible: ['qemu,vm-watchdog']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

