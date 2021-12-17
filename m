Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4EA478746
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 10:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhLQJcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 04:32:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49086 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232736AbhLQJcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 04:32:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B66B4B8276B;
        Fri, 17 Dec 2021 09:32:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 113E9C36AE5;
        Fri, 17 Dec 2021 09:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639733558;
        bh=jaizY8b2aI6cFwsMEHHuEbYQz3Xdxmml90aZnkxsffk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F6lH9tFlrePPlhLePh13hRLYoXHUFsgoxq7Q2cLzPVX+fUmzGvg2tUmWUK+TbrmXX
         KR5I3EkahCCT3r9aABcY49frBbstudTkr6rxbVewvebBmt/+LKivmnS9JR0vUPvg2B
         v9jcEzLdnlNtYzweaLwthWCM7tC4LOdP9mnV9Ds/rIWJWX+XJyT0YtYpXFZ7sER0vv
         3uneuBlT27Nb3Tc89eNHHLb8pnwkQXCQj2exTKBp6FTqBdYk8KYK82dBD9oDcnWE66
         MXLq52zR4PvGiG6LWV23i0mMcMBwDWHq4mc/PU1cK2Bv3nrHuBcKAIzfbUBnPTkTTI
         I3b+jkh6Vc+Wg==
Date:   Fri, 17 Dec 2021 10:32:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Wei Xu <xuwei5@hisilicon.com>, Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RESEND 1/7] dt-bindings: misc: add schema for USB hub on
 Kirin devices
Message-ID: <20211217103233.14e6e701@coco.lan>
In-Reply-To: <CAL_Jsq+Nvruuajk1m_za3WVroLhv=i_0YFtfdDbjhjM58dmJ8g@mail.gmail.com>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
        <9c3a3ff59408fcb60f7a5817a6f5d5f3053367fc.1639558366.git.mchehab+huawei@kernel.org>
        <CAL_Jsq+Nvruuajk1m_za3WVroLhv=i_0YFtfdDbjhjM58dmJ8g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 16 Dec 2021 13:52:01 -0600
Rob Herring <robh+dt@kernel.org> escreveu:

> On Wed, Dec 15, 2021 at 2:54 AM Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > From: Yu Chen <chenyu56@huawei.com>
> >
> > This patch adds binding documentation to support USB HUB and
> > USB data role switch of HiSilicon HiKey960 and HiKey970 boards.  
> 
> I don't see the point in reviewing this given a driver was already
> merged anyways,

Makes sense. On the other hand, it also makes sense to apply
the DTS patches from this series, as those are the only things
pending for PCI/USB to work on those devices.

> I can't imagine that plugging in one USB port causing
> others to disconnect is a USB compliant design, and there are few
> boards and fewer users that care.

Afaikt, Kirin SoCs are designed for cell phones, with has just one
USB port. That's maybe the reason for such design.

Btw, this DT binding is used by both HiKey 960 and HiKey 970.
The HiKey960 board comes with just one port, which can either be 
host or gadget. So, it seems to be an USB-compliant design on
such hardware.

> > [mchehab: updated OF schema and added HiKey970 example]
> > Signed-off-by: Yu Chen <chenyu56@huawei.com>
> > Signed-off-by: John Stultz <john.stultz@linaro.org>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >
> > To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> > See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/
> >
> >  .../bindings/misc/hisilicon,hikey-usb.yaml    | 87 +++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> > new file mode 100644
> > index 000000000000..761ab686121a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
> > @@ -0,0 +1,87 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2019 Linaro Ltd.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: HiKey960/970 onboard USB GPIO Hub
> > +
> > +maintainers:
> > +  - John Stultz <john.stultz@linaro.org>
> > +
> > +description: |
> > +  Supports the onboard USB GPIO hubs found on HiKey960/970.
> > +  Such hubs require a power supply for the USB I/O. Depending on the
> > +  exact hub model, after USB I/O is powered up, a reset should be needed.
> > +
> > +  It also acts as a role-switch intermediary to detect the state of
> > +  the USB-C port, to switch the hub into dual-role USB-C or host mode,
> > +  which enables and powers up the onboard USB-A host ports.
> > +
> > +  Schematics about such hubs can be found here:
> > +    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
> > +    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - hisilicon,usbhub
> > +
> > +  typec-vbus-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle to the typec-vbus gpio
> > +
> > +  otg-switch-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle to the otg-switch gpio
> > +
> > +  hub-reset-en-gpios:
> > +    $ref: /schemas/types.yaml#/definitions/phandle-array
> > +    description: phandle to the hub reset gpio
> > +
> > +  usb-role-switch:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description: Support role switch.
> > +
> > +  hub-vdd-supply:
> > +    description: regulator for hub power
> > +
> > +  port:
> > +    description: |
> > +      describe hadware connections between USB endpoints.  
> 
> USB endpoints? That's a s/w construct.
> 
> > +      Two ports are supported: the first being the endpoint that will  
> 
> 'port' means exactly 1 port.
> 
> > +      be notified by this driver, and the second being the endpoint
> > +      that notifies this driver of a role switch.  
> 
> IMO, this node should represent the HS switch. I would expect an input
> port connected to the USB host and an output port with 2 endpoints
> connected to USB-C connector and the hub.
> 
> host(HS port) -> (port@0)Switch(port@1)+--endpoint@0 -> USB-C connector
>                                        |--endpoint@1 -> 2.0 hub

Yeah, that's what I meant to say. One port with two endpoints.
I'll fix the description. 

See, this is the properties used by the USB hub to work for HiKey 960:

	usb-hub {
			compatible = "hisilicon,usbhub";
			typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
			otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
			hub-vdd-supply = <&usb_hub_vdd>;
			usb-role-switch;
	
		port {
			#address-cells = <1>;
			#size-cells = <0>;

			hikey_usb_ep0: endpoint@0 {
				reg = <0>;
				remote-endpoint = <&dwc3_role_switch>;
			};
			hikey_usb_ep1: endpoint@1 {
				reg = <1>;
				remote-endpoint = <&rt1711h_ep>;
			};
		};
	};

> Then there's what does the hub look like which has been discussed
> separately and is still not upstream I think.

No, the hub driver was already merged.

> But again, given this is devboard with limited use, I would just make
> using USB-C vs. USB host connectors a fixed boot time configuration
> with some one time setup and move on...

Provided that everything was merged already, including the hub driver,
IMO the best would be to address the points you took on this patch
and apply them with your ack, via Wei's tree.

Mauro
