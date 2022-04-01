Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1AC54EE53F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 02:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243415AbiDAAWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 20:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiDAAWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 20:22:30 -0400
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2D1114340;
        Thu, 31 Mar 2022 17:20:41 -0700 (PDT)
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-df0940c4eeso1054883fac.8;
        Thu, 31 Mar 2022 17:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4igr9f4OAx+0GqMiZjzejmo9S3/Zwq02TEGGH7vAqak=;
        b=bjVK5jio2imxqygKDCzDzEuUzncWlATJwvnC+ZV0XfPd681NzlX2moDKztkicktQdl
         feGjMXxJCzy7FzXZSRwqMa7uxXtsD8m+czfuPbRpL81KTIrO+MQT1UvTwvLl7ZQG/mmw
         1y61XysWbx9fIL98gkRKOLp0oMHBKDCM97/bIvFpC+2i4DtAUM182vUjDzFMw2jIfJdU
         zN32r0MFmR9Kbo3gocwczh6pUI30azRq5hD71e6XAKLw001MA7GN14V/h2C9cX6rnPh6
         odnbyD76qWgUd+JbAJpPGSTTWmfCdqkiVxw3BYDatlF7FaaDUA69RHpKxVfbf9+cVT64
         OGRA==
X-Gm-Message-State: AOAM533W1K3S6y2GUBjfT4qbhBZLbJLGaxVe+cAJ4xHGpXwxBPyVdS+D
        CF2eWEikCbBZdyMmaA2LIg==
X-Google-Smtp-Source: ABdhPJzFUYIpGQyyVqm6vWA6VSvosywkSZl2yAbysfklO1hy93710rPL2xrImvsq3KdzCByeRsPQLw==
X-Received: by 2002:a05:6871:787:b0:df:f1a:2d9c with SMTP id o7-20020a056871078700b000df0f1a2d9cmr3824847oap.1.1648772440982;
        Thu, 31 Mar 2022 17:20:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 11-20020a05687013cb00b000dd9b5dd71csm409914oat.56.2022.03.31.17.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 17:20:40 -0700 (PDT)
Received: (nullmailer pid 1769526 invoked by uid 1000);
        Fri, 01 Apr 2022 00:20:39 -0000
Date:   Thu, 31 Mar 2022 19:20:39 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Aswath Govindraju <a-govindraju@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Roger Quadros <rogerq@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: usb: Add documentation for AM62 USB
 Wrapper module
Message-ID: <YkZFV4h/vvmKg6iw@robh.at.kernel.org>
References: <20220324073425.18607-1-a-govindraju@ti.com>
 <20220324073425.18607-2-a-govindraju@ti.com>
 <93fe6a41-3b59-2fbc-6f95-833f337815ee@kernel.org>
 <41f79aa5-1e04-53f8-ab21-85fe6039e24e@ti.com>
 <2b33798e-23c2-d4a5-171a-55c28bc40c40@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b33798e-23c2-d4a5-171a-55c28bc40c40@kernel.org>
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

On Thu, Mar 24, 2022 at 12:53:08PM +0100, Krzysztof Kozlowski wrote:
> On 24/03/2022 12:40, Aswath Govindraju wrote:
> > Hi Krzysztof,
> > 
> > On 24/03/22 16:37, Krzysztof Kozlowski wrote:
> >> On 24/03/2022 08:34, Aswath Govindraju wrote:
> >>> Add bindings for the TI's AM62 wrapper module for the Synopsys USBSS-DRD
> >>> controller.
> >>>
> >>> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> >>> ---
> >>>
> >>> Changes since v1:
> >>> - made correction in grammer of clocks property description
> >>>   and added maxItems in the interrupts property based on comments
> >>>   received from Roger
> >>> - corrected the title, fixed the description of
> >>>   ti,syscon-phy-pll-refclk, added pattern properties and child node
> >>>   in the example based on the comments from Krzysztof.
> >>>
> >>>  .../devicetree/bindings/usb/ti,am62-usb.yaml  | 117 ++++++++++++++++++
> >>>  1 file changed, 117 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> >>> new file mode 100644
> >>> index 000000000000..452bfdc6fb09
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/usb/ti,am62-usb.yaml
> >>> @@ -0,0 +1,117 @@
> >>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/usb/ti,am62-usb.yaml#
> >>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >>> +
> >>> +title: TI's AM62 wrapper module for the Synopsys USBSS-DRD controller
> >>> +
> >>> +maintainers:
> >>> +  - Aswath Govindraju <a-govindraju@ti.com>
> >>> +
> >>> +properties:
> >>> +  compatible:
> >>> +    const: ti,am62-usb
> >>> +
> >>> +  reg:
> >>> +    maxItems: 1
> >>> +
> >>> +  ranges: true
> >>> +
> >>> +  power-domains:
> >>> +    description:
> >>> +      PM domain provider node and an args specifier containing
> >>> +      the USB ISO device id value. See,
> >>> +      Documentation/devicetree/bindings/soc/ti/sci-pm-domain.yaml
> >>> +    maxItems: 1
> >>> +
> >>> +  clocks:
> >>> +    description: Clock phandle to usb2_refclk
> >>> +    maxItems: 1
> >>> +
> >>> +  clock-names:
> >>> +    items:
> >>> +      - const: ref
> >>> +
> >>> +  id-gpio:
> >>> +    description:
> >>> +      GPIO to be used as ID pin
> >>> +    maxItems: 1
> >>
> >> I have doubts about this. If you USB controller handles the ID pin, then
> >> probably this should be moved to usb-connector.yaml. I did not see
> >> id-gpio in any other USB controller blocks.
> >>
> > 
> > Yes, the USB wrapper handles the ID pin operation only. It also reads
> > the status of VBUS by reading a register from its MMR and not using a
> > gpio. After evaluating the role the based on the states if id pin and
> > VBUS, this role is communicated to the dwc3 core driver using extcon.
> > There is no way for the dwc3 driver to detect the role on its own.
> > 
> > 
> > The usb-connector(drivers/usb/common/usb-conn-gpio.c) driver, seems to
> > be implemented for driving the VBUS, based on ID and VBUS pin status.
> > However, in case of the above implementation we need to communicate the
> > detected role to the dwc3 core driver. Also, the wrapper does not
> > control VBUS but it is the dwc3 core driver that drives the VBUS.
> > Therefore, I think the usb-connector implementation cannot be used here.
> 
> I don't think about usb-conn-gpio.c but using the binding generic
> binding for usb-X-connector and define a connector with ID.
> 
> Actually Rob could help here.
> 
> Rob,
> Should the id-gpio be modeled as a property in this glue/wrapper driver
> or rather as part of usb-connector child node?

That's a simple question. Where does the ID GPIO signal go to? The 
connector, so it goes in the connector node.

If we have a driver for the usb-connector node, that's news to me. Not 
that we couldn't, but that has nothing to do with designing the binding.

Rob
