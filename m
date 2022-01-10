Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6A7489DD3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237704AbiAJQtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:49:02 -0500
Received: from mail-oi1-f180.google.com ([209.85.167.180]:37655 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbiAJQtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:49:01 -0500
Received: by mail-oi1-f180.google.com with SMTP id i9so19497836oih.4;
        Mon, 10 Jan 2022 08:49:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=PcweNAAyqTtCgPxQQaHXUvqxCWk/Vwq0k3RGXJnNlJo=;
        b=c+D1SPgv8VE+7ixpSITfmmHeVLUQLgaLdpNLlR01gH0I4RjQWIe/9Z+WKFhSfddq9b
         uju12dslFksw/fhIfM6q18FZEtC4JnlFA1MQ3LkRTwilv4sBWpnwpMvee+ZIsO1P4GnC
         ZDkI/DBqniUjerjUBoeOc7affBzYOcYSNnldJQHdlcqpYzE5PQSx8ytwJa+KIWHrBQxt
         Bm+kfncjyoMTU2j1vnVtz0aQc74HVXeQ+hRuZ2riDAuiL99nZQljbLuBG8OBcW8jDGU5
         /aBxhZQ5NNdg5mJKGhiG2QTyC8rDMdPLIrmRMCvdaliu8t4ncTotW1ykanV/e55upiiO
         Xamg==
X-Gm-Message-State: AOAM531KOaMGOpJ6l3DBd2w4Eeuy5eWkAiC8katRtAagaiLTv6QqvK1A
        DiBnCX2SAdcJr0QmSIpQyg==
X-Google-Smtp-Source: ABdhPJzmfBgp0bKgpoqASyCFdgI+r5ioWFa75FF5Ozek+i/mv86mQuy/p6hZZ6ozGyUSF/tQwF6kdg==
X-Received: by 2002:aca:1811:: with SMTP id h17mr17991649oih.178.1641833341058;
        Mon, 10 Jan 2022 08:49:01 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id c6sm1538169oto.19.2022.01.10.08.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 08:49:00 -0800 (PST)
Received: (nullmailer pid 1067451 invoked by uid 1000);
        Mon, 10 Jan 2022 16:48:59 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hari Nagalla <hnagalla@ti.com>
Cc:     linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bjorn.andersson@linaro.org,
        mathieu.poirier@linaro.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <20220110040650.18186-2-hnagalla@ti.com>
References: <20220110040650.18186-1-hnagalla@ti.com> <20220110040650.18186-2-hnagalla@ti.com>
Subject: Re: [PATCH 1/2] dt-bindings: remoteproc: k3-m4f: Add bindings for K3 AM64x SoCs
Date:   Mon, 10 Jan 2022 10:48:59 -0600
Message-Id: <1641833339.676351.1067450.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 09 Jan 2022 22:06:49 -0600, Hari Nagalla wrote:
> K3 AM64x SoC has a Cortex M4F subsystem in the MCU volatge domain.
> The remote processor's life cycle management and IPC mechanisms are
> similar across the R5F and M4F cores from remote processor driver
> point of view. However, there are subtle differences in image loading
> and starting the M4F subsystems.
> 
> The YAML binding document provides the various node properties to be
> configured by the consumers of the M4F subsystem.
> 
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> ---
>  .../bindings/remoteproc/ti,k3-m4f-rproc.yaml  | 121 ++++++++++++++++++
>  1 file changed, 121 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: properties:memory-region: 'anyOf' conditional failed, one must be fixed:
	'minItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'additionalItems' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	'unevaluatedProperties' is not one of ['maxItems', 'description', 'deprecated']
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	Additional properties are not allowed ('unevaluatedProperties' was unexpected)
		hint: Arrays must be described with a combination of minItems/maxItems/items
	'minItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'maxItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'additionalItems' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	'unevaluatedProperties' is not one of ['description', 'deprecated', 'const', 'enum', 'minimum', 'maximum', 'multipleOf', 'default', '$ref']
	1 was expected
		hint: Only "maxItems" is required for a single entry if there are no constraints defined for the values.
	hint: cell array properties must define how many entries and what the entries are when there is more than one entry.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.yaml: ignoring, error in schema: properties: memory-region
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dts:19.31-36.11: Warning (unit_address_vs_reg): /example-0/bus@f4000: node has a unit name, but no reg or ranges property
Documentation/devicetree/bindings/remoteproc/ti,k3-m4f-rproc.example.dt.yaml:0:0: /example-0/bus@f4000/m4fss@5000000: failed to match any schema with compatible: ['ti,am64-m4fss']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1577759

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

