Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 335534BFAD5
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 15:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbiBVOXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 09:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbiBVOXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:23:17 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE0C6813;
        Tue, 22 Feb 2022 06:22:51 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id k22-20020a9d4b96000000b005ad5211bd5aso7861419otf.8;
        Tue, 22 Feb 2022 06:22:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=IMZlAYGiwJD5sHSejY7WoROZxPqqlfkfVkhfdzNETfk=;
        b=KsN3KN0P/WcNjJEHdzHld4Xr6e7EibkgDALknPYVN4AvBbCSrRkoNz1yyr6WXR7jWj
         VH0QpGp8r8QEqRqqkZlLVZsxHGnMFfgzJBja87EXu+AScRelN3nwMW4v+XRsmJNkXgG4
         8o0BC9AebVdYnx8UbF2VwSV0+RWvi4AoFEvIrISzIdq1KO8C2039IjClgEevq7T0fO/D
         QHEkbl4s33YqDwKuf9UAkS654vLnjxRZpfNDblQIGoP/PCQxTWy279COxkH6wAIpaaeK
         vL7LLBRvQM4YAh7O4R8LRnKXrzVbHWvtUE12q1WFUYNky/Kpbo5j3JWD6COGVk0LUC3/
         ESUA==
X-Gm-Message-State: AOAM532qCqhJgX1d2/JaOMpwFCM1IJJz+GULjwVu6Qd1Aq6FOpGTiDqW
        GhxS76EpcAN0uDC1+eAbew==
X-Google-Smtp-Source: ABdhPJxEx+QyS02LqedHee8+Ye4Gvlv0ihOCs/D6zlZ3aFsC04yIZpghl9cUEvUCXiyoa3CGhuURTQ==
X-Received: by 2002:a05:6830:916:b0:5af:145f:2cdf with SMTP id v22-20020a056830091600b005af145f2cdfmr4362401ott.363.1645539770507;
        Tue, 22 Feb 2022 06:22:50 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id l7sm1684753otk.63.2022.02.22.06.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 06:22:49 -0800 (PST)
Received: (nullmailer pid 3016154 invoked by uid 1000);
        Tue, 22 Feb 2022 14:22:43 -0000
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
In-Reply-To: <c751add9b54e9661e463ae265d8d5f0314eac33e.1645460043.git.oleksii_moisieiev@epam.com>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com> <c751add9b54e9661e463ae265d8d5f0314eac33e.1645460043.git.oleksii_moisieiev@epam.com>
Subject: Re: [RFC PATCH 1/1] dt-bindings: arm: Add scmi_devid property description for SCMI
Date:   Tue, 22 Feb 2022 08:22:43 -0600
Message-Id: <1645539763.068794.3016153.nullmailer@robh.at.kernel.org>
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

On Mon, 21 Feb 2022 17:26:47 +0000, Oleksii Moisieiev wrote:
> Document scmi_devid property for the devices, using SCMI protocol
> to work with clocks/resets/power-domains etc. This property is intended
> to set the device id, which should be used to manage device permissions
> in the firmware. Device permissions management is descibed in DEN 0056,
> Section 4.2.2.10 [0].
> 
> This property is useful for the virtualized systems, when several agents
> are running on the same platform. Agent term is descibed in Section
> 4.1.1 [0].
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> 
> Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>
> ---
>  .../bindings/firmware/arm,scmi-devid.yaml     | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/arm,scmi-devid.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/firmware/arm,scmi-devid.example.dt.yaml: example-0: usb@ee0a0000:reg:0: [0, 3993632768, 0, 256] is too long
	From schema: /usr/local/lib/python3.8/dist-packages/dtschema/schemas/reg.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1595720

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

