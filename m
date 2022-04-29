Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAEAA514FFB
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378671AbiD2P4u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378302AbiD2P4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:56:41 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B627EC8670;
        Fri, 29 Apr 2022 08:53:21 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id a10so8912532oif.9;
        Fri, 29 Apr 2022 08:53:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=AmUJmIbdvaqP+LwlAIntrN0W+MZsdnrLEyCto2dXyeE=;
        b=nEobffE4R7s9vRVq6ZQSpscBRZoDorxeVjUR5V15ZTWDOg9zzn6d1x3jzz8apEraPw
         MFz6nAo4IcOfdw7gGrbGOlBpAoCwJ9xwIFYzKJwhlFThwokYQeabMooHzWS88pp2dwLW
         gh8E/TUQrQhpqUc/k1ZI21qMlZgpXL8WTnW1Z86sJoN7xy4OsSWLZwC4c5IDf8Euolr1
         Z5DwY9rvze7bZ8dEh7dG2R14WJTYVJENFM9dTuVaLc/4Oe1AqdOv/cd62+N+axizotpT
         RMcU1RqcmkH0pveFk8AnvdS5NRmvLoZqH0FuHsw2t70L1+fqzZIq2lSRAeEAfVTVgeub
         Nzpw==
X-Gm-Message-State: AOAM532c62whRCKPaP9YOcv2PIHq8QOYiu6rFQ6ICDKxbrQm0qJTwV2W
        kR5wV0m2aofrNJ7gbvjg6A==
X-Google-Smtp-Source: ABdhPJwAjpJx3Zh+JF96gGbdN1Imb3/OBtUK2z+PbCHHuqf2TqnacWjE8AIH07JUwOc45jhuqHDMSg==
X-Received: by 2002:a05:6808:1929:b0:322:695e:3576 with SMTP id bf41-20020a056808192900b00322695e3576mr1728138oib.15.1651247600922;
        Fri, 29 Apr 2022 08:53:20 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n44-20020a056870822c00b000e686d13894sm3088678oae.46.2022.04.29.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 08:53:20 -0700 (PDT)
Received: (nullmailer pid 2344493 invoked by uid 1000);
        Fri, 29 Apr 2022 15:53:16 -0000
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Ene <sebastianene@google.com>
Cc:     devicetree@vger.kernel.org, qperret@google.com, maz@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, will@kernel.org,
        linux-kernel@vger.kernel.org,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20220429083030.3241640-2-sebastianene@google.com>
References: <20220429083030.3241640-1-sebastianene@google.com> <20220429083030.3241640-2-sebastianene@google.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: vm-wdt: Add qemu,vm-watchdog compatible
Date:   Fri, 29 Apr 2022 10:53:16 -0500
Message-Id: <1651247596.116764.2344492.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2022 08:30:31 +0000, Sebastian Ene wrote:
> The stall detection mechanism allows to configure the expiration
> duration and the internal counter clock frequency measured in Hz.
> Add these properties in the schema.
> 
> Signed-off-by: Sebastian Ene <sebastianene@google.com>
> ---
>  .../devicetree/bindings/misc/vm-watchdog.yaml | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/misc/vm-watchdog.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/vm-watchdog.yaml: properties:timeout-sec: '$ref' should not be valid under {'const': '$ref'}
	hint: Standard unit suffix properties don't need a type $ref
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/misc/vm-watchdog.yaml: ignoring, error in schema: properties: timeout-sec
Documentation/devicetree/bindings/misc/vm-watchdog.example.dtb:0:0: /example-0/watchdog: failed to match any schema with compatible: ['qemu,vm-watchdog']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

