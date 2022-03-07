Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AA4D0C1B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 00:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245151AbiCGXjN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 18:39:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343926AbiCGXjL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:39:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1A312757;
        Mon,  7 Mar 2022 15:38:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89477B81752;
        Mon,  7 Mar 2022 23:38:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564EC340E9;
        Mon,  7 Mar 2022 23:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646696293;
        bh=jhGr9NkWZt9zE+HHj57EU6ZdMbZueXf/ABsXGJyFl8E=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=Q1gTJo6Celg3YmEn631kbFQ6bxwhIiW/O63/pkg6HJt5mKOKXEtkSqRG7zBxv/+PZ
         FPnRRY3C7Z2bYccvfzpAmq6TNRrXT5n1lYRjWs8/pj1fUt1f16a+QXFJ35PIaH8zwT
         QNDsb2ii9fJvtU7eznqNs66gYdQ76nNmsQtE/4EvDJd0P+XHfZX62XGGyt8khWXRZ4
         Rka0qWLzbt7vIuW9hfsqaeshlb+AF34BGwAVdEbtyHaYfACzQvYV3Ka4OULkvaIAIU
         nSayQKzbihvPdBUk09mp4cAk8aHBOD2AuPqyzl3kQW6XQqSpUPHfUrQSwDpdHRIYvB
         cUHjuAbJvINLw==
Date:   Mon, 7 Mar 2022 15:38:12 -0800 (PST)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
In-Reply-To: <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
Message-ID: <alpine.DEB.2.22.394.2203071530510.3261@ubuntu-linux-20-04-desktop>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com> <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Mar 2022, Oleksii Moisieiev wrote:
> Document xen,scmi-devid property for the devices, using SCMI protocol
> to work with clocks/resets/power-domains etc. This property is intended
> to set the device_id, which should be used to manage device permissions
> in the Firmware. Device permissions management described in DEN 0056,
> Section 4.2.2.10 [0].
> 
> This property is used by Xen hypervisor, which works as trusted Agent, to
> set permissions for the devices, passed-through to the Guest Domains,
> which are non-trusted Agents. Trusted and non-trusted Agent terms described
> in Section 4.1.1 [0].
> 
> [0] https://developer.arm.com/documentation/den0056/latest

Aside from minor grammar improvements (see below), I don't have any
feedback. This is OK from my point of view.


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

I would say:

The xen,scmi-devid property is the SCMI device id, which is needed to
manage device permissions with the SCMI protocol. The xen,scmi-devid
property should match device ids as defined in firmware, so that device
permissions can be requested with BASE_SET_DEVICE_PERMISSIONS (see
4.2.2.10 of [0]).


> +  This property is used by Xen hypervisor to set the device permissions for
> +  the Guest Domains. Where Xen is trusted Agent and Guest Domains are
> +  non-trusted Agents.

I would say:

This property is used by a Trusted Agent, e.g. the Xen hypervisor, to
set device permissions for non-trusted Agents, e.g. Xen domains.


> +  [0] https://developer.arm.com/documentation/den0056/latest
> +
> +properties:
> +  xen,scmi-devid:
> +    description: Identifier of the device, matching device id, defined in
> +      the firmware.

description: Identifier of the device, matching the SCMI device id as
defined in firmware


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
> +        clocks = <&scmi_clock 4>;
> +    };
> -- 
> 2.27.0
> 
