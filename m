Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F37753AD76
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 21:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiFATnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 15:43:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiFATnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 15:43:14 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE12612B8;
        Wed,  1 Jun 2022 12:41:16 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id t22-20020a0568301e3600b0060b333f7a1eso1990641otr.0;
        Wed, 01 Jun 2022 12:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+v5j5ekx2Jgon4FWC0grFHHMjkCKNZHQytb0+MZZAWQ=;
        b=Emeeb9+DM/HcvZnRMpwpOi0RxVpL67MnQw522F7NX0BAnwMdF8Ox/LAaAcFeeKOIaY
         YZcjLzgyH5XfKmYPi425vZR0DZpOv6eonu7NuIKUoCsHcFP6ZXUyG/1XKaQBVtHJpLz3
         Ft9VBtD1NtFmuBlgCdXAATsEer7pFT+U2Zz5xXAP63enx28FS/JEs4kxeeZ6NQTx1BIe
         LZ5fySk3+Xb1zuWvNUeAI67N93INkt2gWvr2eFoBFONbFgppbnqGfQv6Jo8rdSmfo0w9
         Ol/bQk2LOZ2wT3xwWeSzGB8Tqj71JcqJNTPCii7O6koAd8SRu0IkTqgQy232ro6QGhD7
         5Y9A==
X-Gm-Message-State: AOAM533VhaCHSCyttNHRdyGzNdwKKsTjz55rarEA75Y4+zxvOlCVT9VK
        aXSrziIigQjV4GOGn00OdQbjrv+QKQ==
X-Google-Smtp-Source: ABdhPJx/fJbMfVLJruJz1q5U9ewNqzGJeM1ex5DJpVTEeuXhhWvntCyhTm1jZcpILyQZakLjHaqNNw==
X-Received: by 2002:a9d:694a:0:b0:60b:275f:fe2d with SMTP id p10-20020a9d694a000000b0060b275ffe2dmr621608oto.49.1654112397104;
        Wed, 01 Jun 2022 12:39:57 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0542000000b00325643bce40sm1386527oif.0.2022.06.01.12.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 12:39:56 -0700 (PDT)
Received: (nullmailer pid 300162 invoked by uid 1000);
        Wed, 01 Jun 2022 19:39:56 -0000
Date:   Wed, 1 Jun 2022 14:39:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 0/1] dt-bindings: Add device-perms property description
Message-ID: <20220601193956.GA234900-robh@kernel.org>
References: <cover.1651749565.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1651749565.git.oleksii_moisieiev@epam.com>
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

On Thu, May 05, 2022 at 11:23:50AM +0000, Oleksii Moisieiev wrote:
> Introduce device-perms property which is intended to set the device
> permissions for the System Management interfaces.
> An example of this interface is SCMI (System Control and Management
> Interface) which controls clocks/power-domains/resets etc from the
> Firmware. This property sets the device_id to set the device permissions
> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10 of [0]).

Is that an exhaustive list of controls? Seems like there would be a 
GET_DEVICE_PERMISSIONS.

> Device permissions management described in DEN 0056, Section 4.2.2.10 [0].
> Given parameter should set the device_id, needed to set device
> permissions in the Firmware.
> This property is used by trusted Agent to set permissions for the devices,
> passed-through to the non-trusted Agents. Trusted Agent will use device-perms to
> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> for details).
> Agents concept is described in Section 4.2.1 [0].

As I said on the call discussing this, this looks very similar to other 
proposals wanting to control or check permissions on devices handled by 
some provider. While the consumer of the binding is different in various 
proposals, that doesn't really matter from a DT perspective. DT is just 
describing some type of connection between nodes. So I'm looking for 
collaboration here with folks that have made prior proposals. To put it 
another way, for a new common binding like this, I want to see more than 
one user. 

> 
> device-perms in Device-tree node example:
> usb@e6590000
> {
>     device-perms = <&scmi 19>;

Please follow typical design patterns. For example, all of these:

>     clocks = <&scmi_clock 3>, <&scmi_clock 2>;
>     resets = <&scmi_reset 10>, <&scmi_reset 9>;
>     power-domains = <&scmi_power 0>;

The provider is what determines the number of cells and their meaning. 
That's certainly the case here.

> };
> 
> Given example shows the configuration of the hsusb node, which is using
> scmi to contol clocks, resets and power-domains. device-perms links to
> &scmi phandle and set the permission parameter 19, which should match
> defined id for usb in the Firmware.

See, the provider is what determines the meaning.

> Current implementation defines Xen hypervisor as trusted Agent and OS
> (Linux or other) as non-trusted Agent.
> Trusted Agent will use device-perms to set the device permissions for
> the Agents. Non-trusted Agent (OS) should not have an access to the permissions
> settings, so no code to process device-perms was presented in Linux
> kernel.
> 
> We are currently contributing changes to Xen, which are intended to
> mediate SCMI access from Guests to the Firmware. Xen uses device-perms to set
> the permissions for the devices. See [1] thread for details.
> 
> [0] https://developer.arm.com/documentation/den0056/latest
> [1] https://xen.markmail.org/message/mmi4fpb4qr6e3kad
> 
> ---
> Changes V1 -> V2:
>    - update parameter name, made it xen-specific
>    - add xen vendor bindings
> 
> Changes V2 -> V3:
>    - update parameter name, make it generic
>    - update parameter format, add link to controller
>    - do not include xen vendor bindings as already upstreamed
> 
> Oleksii Moisieiev (1):
>   dt-bindings: Add device-perms property description
> 
>  .../bindings/firmware/device-perms.yaml       | 43 +++++++++++++++++++
>  1 file changed, 43 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/firmware/device-perms.yaml
> 
> -- 
> 2.27.0
> 
