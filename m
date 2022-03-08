Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40E144D225C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 21:14:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242939AbiCHUOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 15:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233734AbiCHUOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 15:14:34 -0500
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F664754D;
        Tue,  8 Mar 2022 12:13:36 -0800 (PST)
Received: by mail-oo1-f53.google.com with SMTP id x26-20020a4a9b9a000000b003211029e80fso338906ooj.5;
        Tue, 08 Mar 2022 12:13:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B43sDa5IY09ADYu+PZSx8NGVWf+9ZREQp5UYG9QIQzw=;
        b=QKcshtdyw4BD5SzWD6y3VqV1F4zHsQUvHRNNlvhKvAITiM827Jai5E7TVxMkgYohuo
         RnlFZyJHur3jF6FmqDKtOX5Jb+tjd3SDjUv2hyj0GvDYPzJf2FYj/WLXN/Z1zHaNnegU
         TU1Lm6oMoM2CUkETl3okkePqUq2l4oaXoEqalKZNWtX5bdpDIIt3Gc1vsQvCKalr71ES
         3CqElV5pcE9Kcn9SOXwdSZSKU+XUhQ1lR40tekqHigP9IxusrItswEOGc1Zctrua6y6S
         0gZ9ZRqA/ALKVdkLrU7KmCPxgq4YmFK91RcllbKQIkGGJvNH6znlsHD21Jd97MqwJI6g
         Xc1g==
X-Gm-Message-State: AOAM5332TYNIN72BZLYuag095hTrd5U7CokiTOE0q2DkaF1d6wwL+ji/
        al7ylp1q2jTZGrD++0FheA==
X-Google-Smtp-Source: ABdhPJyVFLrH9wLh7qnSiBwweChAbzc3h+964cJ6ZzDM+rUCmw/SXHToHOmTu+xr+Z2DPViVXKYiaQ==
X-Received: by 2002:a4a:e216:0:b0:320:5471:3284 with SMTP id b22-20020a4ae216000000b0032054713284mr7693135oot.70.1646770415647;
        Tue, 08 Mar 2022 12:13:35 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id dy38-20020a056870c7a600b000d9b7eef08csm6739587oab.39.2022.03.08.12.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Mar 2022 12:13:34 -0800 (PST)
Received: (nullmailer pid 1275896 invoked by uid 1000);
        Tue, 08 Mar 2022 20:13:33 -0000
Date:   Tue, 8 Mar 2022 14:13:33 -0600
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Message-ID: <Yie47a4lqXjVzgxI@robh.at.kernel.org>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2022 at 08:17:44AM +0000, Oleksii Moisieiev wrote:
> Document xen,scmi-devid property for the devices, using SCMI protocol
> to work with clocks/resets/power-domains etc. This property is intended
> to set the device_id, which should be used to manage device permissions
> in the Firmware. Device permissions management described in DEN 0056,
> Section 4.2.2.10 [0].

If device_id is a SCMI thing, how is it set for other platforms and 
bindings? With clocks or power-domains, the device_id is the cell value, 
right?
 
Since we don't yet have a device assignment, security, or partitioning 
binding, you've come up with some Xen specific solution. Given I know 
multiple people want some sort of binding for this, I'm not going to 
accept anything short of a common binding addressing the various needs.


> This property is used by Xen hypervisor, which works as trusted Agent, to
> set permissions for the devices, passed-through to the Guest Domains,
> which are non-trusted Agents. Trusted and non-trusted Agent terms described
> in Section 4.1.1 [0].
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  .../bindings/firmware/xen,scmi-devid.yaml     | 42 +++++++++++++++++++
>  1 file changed, 42 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml b/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
> new file mode 100644
> index 000000000000..49dc9951b54d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/firmware/xen,scmi-devid.yaml
> @@ -0,0 +1,42 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2022 EPAM Systems.
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/firmware/xen,scmi-devid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Xen SCMI (System Control and Management Interface) Device ID binding
> +
> +maintainers:
> +  - Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> +
> +select: true
> +
> +description: |
> +  SCMI device_id property is intended to set the device id, needed to manage
> +  the device permissions via SCMI protocol in the firmware. The device_id
> +  should match device ids, defined in the firmware so the device permissions
> +  can be requested by sending BASE_SET_DEVICE_PERMISSIONS (see 4.2.2.10 of [0]).
> +
> +  This property is used by Xen hypervisor to set the device permissions for
> +  the Guest Domains. Where Xen is trusted Agent and Guest Domains are
> +  non-trusted Agents.
> +
> +  [0] https://developer.arm.com/documentation/den0056/latest
> +
> +properties:
> +  xen,scmi-devid:
> +    description: Identifier of the device, matching device id, defined in
> +      the firmware.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +
> +additionalProperties: true
> +
> +examples:
> +  - |
> +    ohci1: usb@ee0a0000 {
> +        /* ... */
> +        reg = <0xee0a0000 0x100>;
> +        xen,scmi-devid = <11>;

This will cause validation errors unless xen,scmi-devid is listed or 
this schema is referenced in every possible device schema. That 
doesn't scale, but we don't really have a solution to that. For some 
common properties, the tools will add certain properties. If we 
come up with something common, we'll need to add it. Or we may 
need to come up with something more data driven where certain schemas 
are automatically added.

Rob

> +        clocks = <&scmi_clock 4>;
> +    };
> -- 
> 2.27.0
> 
