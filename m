Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1545A4868C0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242002AbiAFRjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:39:44 -0500
Received: from mail-oo1-f54.google.com ([209.85.161.54]:42684 "EHLO
        mail-oo1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242182AbiAFRjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:39:42 -0500
Received: by mail-oo1-f54.google.com with SMTP id y13-20020a4a624d000000b002daae38b0b5so824124oog.9;
        Thu, 06 Jan 2022 09:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=LTH0gxxPTzrpGqblk9l5CWXYgHHQ9ZotfUBcWF1DvpM=;
        b=oPpV4Y9EFDQGG+sNCKhwvw9xkckE6JV2ESvWBcGsnosKOsGIYmE4oxYnnoYZntTQVE
         Yg8lIsH0IyC5qduo+wYguNX0YoF3tWGR+lYLbhC7W9bfkoYWhetTOXfpaecvnOT0mCVK
         Bd4XMX/kYcBRWtatqkpBHI9Fi3TErhbehB8VnN5OarU6DVTewIfwX9qMIFNM76h0W4py
         N9X6NDoBb3JAL9vJ2VeNx0j2OnsfLOKYLDDJUo4vfMYahVVuRffBS71Hd1rokzmDbdwz
         y/jNss7AemLJGpbMQ2niF5qbrwR+ozeESzUgAgfWUraI1UPOxXSXy15RcAPIVXeyaaql
         xmKA==
X-Gm-Message-State: AOAM532TlL8WoXXHFreSYqqOJcTUyVMX/B+gqx/EUpjPtZS/BH4Z6yBH
        V/QcRdnp/eOublANOx4KccQORv+XbA==
X-Google-Smtp-Source: ABdhPJzyP3uuOjPrPqhC3d1Qqu7NKHHwGoHsgf/2aYa8QFCfQy1jTMC6nDHxXabAKYUx+wyz030djA==
X-Received: by 2002:a4a:8701:: with SMTP id z1mr38966341ooh.68.1641490781532;
        Thu, 06 Jan 2022 09:39:41 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id u14sm449787ote.62.2022.01.06.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 09:39:41 -0800 (PST)
Received: (nullmailer pid 1361796 invoked by uid 1000);
        Thu, 06 Jan 2022 17:39:39 -0000
From:   Rob Herring <robh@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lgirdwood@gmail.com, lars@metafoo.de, jic23@kernel.org,
        baolin.wang7@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, zhang.lyra@gmail.com,
        orsonzhai@gmail.com, yuming.zhu1@unisoc.com
In-Reply-To: <20220106125947.139523-2-gengcixi@gmail.com>
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-2-gengcixi@gmail.com>
Subject: Re: [PATCH 1/7] dt-bindings:iio:adc: add sprd,ump9620-adc dtbindings
Date:   Thu, 06 Jan 2022 11:39:39 -0600
Message-Id: <1641490779.987704.1361793.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 06 Jan 2022 20:59:41 +0800, Cixi Geng wrote:
> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> sprd,ump9620-adc is one variant of sc27xx series, add ump9620 in
> dtbindings.
> 
> Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  .../bindings/iio/adc/sprd,sc2720-adc.yaml     | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml: else: 'nvmem-cell-names' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml: then: 'nvmem-cell-names' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.yaml: ignoring, error in schema: else
Documentation/devicetree/bindings/iio/adc/sprd,sc2720-adc.example.dt.yaml:0:0: /example-0/pmic/adc@480: failed to match any schema with compatible: ['sprd,sc2731-adc']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1576074

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

