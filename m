Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02227468082
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 00:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376688AbhLCXhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 18:37:42 -0500
Received: from mail-oo1-f42.google.com ([209.85.161.42]:35715 "EHLO
        mail-oo1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240573AbhLCXhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 18:37:41 -0500
Received: by mail-oo1-f42.google.com with SMTP id e17-20020a4a8291000000b002c5ee0645e7so2520702oog.2;
        Fri, 03 Dec 2021 15:34:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=HvmUO3stczSOHy4AZ2u5yjtXBe51DiBBMcIExmIvsPk=;
        b=1JIchbjaLZzDknM343KPGEgCIqPPJrvHeVDDbfmLuaCZNcU7k0dOvAdCGp4Rc6TUuX
         fL/1ABebaTigvQBCfPUcW4znZpo1rTYPLU0lcEhwMXwuKYRGrglsakmVTkZxGEdzKbOY
         C3vTv9GILsq57fC/9Ww08EtIVOsfFUp6lfc5z7gxvsKxQep2x//CiwPM0TNSfugUSujY
         dNMPUCjXRayLjWZ6uOBuuPvdg479WWSlCC6IMizDT8w7ZqQUebd+5IiLoW6ngrG9W5Rh
         7qyOyR6CpxjgHBqjOyQATdYEKQJH7lLYmDrDanyKo7VE/705Q/6zBqSLbHUXovul7q3D
         TIJg==
X-Gm-Message-State: AOAM5325xrrAUXovEFxNYS0DHzf98OHq6Z82f+WTa2Rb1Ht1qHf5S+wF
        Lx6WU403cVLdvTbxiEqn7Q==
X-Google-Smtp-Source: ABdhPJwgEbmNp7uLje0JTDCKmsCzjEkEBrgzlOt1VkyxJTN4CmOwWISnvXbaId1z31yTwIqQdnFCXg==
X-Received: by 2002:a4a:9406:: with SMTP id h6mr14654887ooi.80.1638574456759;
        Fri, 03 Dec 2021 15:34:16 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id w71sm939444oiw.6.2021.12.03.15.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:16 -0800 (PST)
Received: (nullmailer pid 1042998 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Jarrett Schultz <jaschultzms@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        platform-driver-x86@vger.kernel.org, devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Andy Gross <agross@kernel.org>, linux-arm-msm@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Jarrett Schultz <jaschultz@microsoft.com>
In-Reply-To: <20211202191630.12450-2-jaschultz@microsoft.com>
References: <20211202191630.12450-1-jaschultz@microsoft.com> <20211202191630.12450-2-jaschultz@microsoft.com>
Subject: Re: [PATCH 1/5] dt-bindings: platform: microsoft: Document surface xbl
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.193372.1042997.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 02 Dec 2021 11:16:26 -0800, Jarrett Schultz wrote:
> Introduce yaml for surface xbl driver.
> 
> Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
> 
> ---
> 
> Changes in v3:
>  - Updated description to only pertain to the hardware
>  - Updated the required field to properly reflect the binding
>  - Removed the first example
>  - Fixed the size of the reg field in the second example
> 
> ---
> 
> Changes in v2:
>  - Removed json-schema dependence
>  - Elaborated on description of driver
>  - Updated example
> ---
>  .../platform/microsoft/surface-xbl.yaml       | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  7 ++
>  2 files changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml: properties:properties: 'compatible' is not one of ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'exclusiveMaximum', 'exclusiveMinimum', 'items', 'if', 'minItems', 'minimum', 'maxItems', 'maximum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'required', 'then', 'type', 'typeSize', 'unevaluatedProperties', 'uniqueItems']
	from schema $id: http://devicetree.org/meta-schemas/keywords.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml: properties: 'properties' should not be valid under {'enum': ['$ref', 'additionalItems', 'additionalProperties', 'allOf', 'anyOf', 'const', 'contains', 'default', 'dependencies', 'dependentRequired', 'dependentSchemas', 'deprecated', 'description', 'else', 'enum', 'if', 'items', 'maxItems', 'maximum', 'minItems', 'minimum', 'multipleOf', 'not', 'oneOf', 'pattern', 'patternProperties', 'properties', 'propertyNames', 'required', 'then', 'unevaluatedProperties']}
	hint: A json-schema keyword was found instead of a DT property name.
	from schema $id: http://devicetree.org/meta-schemas/core.yaml#
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml: ignoring, error in schema: properties: properties
warning: no schema found in file: ./Documentation/devicetree/bindings/platform/microsoft/surface-xbl.yaml
Documentation/devicetree/bindings/platform/microsoft/surface-xbl.example.dt.yaml:0:0: /example-0/imem@146bf000/xbl@a94: failed to match any schema with compatible: ['microsoft,sm8150-surface-duo-xbl']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1562961

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

