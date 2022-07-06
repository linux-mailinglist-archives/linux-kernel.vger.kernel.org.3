Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7104F56950A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbiGFWJz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:09:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGFWJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:09:49 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDD7DF29;
        Wed,  6 Jul 2022 15:09:48 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id h85so15273770iof.4;
        Wed, 06 Jul 2022 15:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N6xflz9vD0yiGlrc+/T2LaSMZ/jPXZZSDgZSh32kmN0=;
        b=m4doDCuH08b9BIgHolzVprURZq3utV1nYSr+bUf96qqxm+mYCN7H/ChtsOhd5jC2Kj
         1L2r70LyVY4rA0AVVzzkDkxbouXl0MnJ8KCguj4kUI6pcWde3ZGp0XCUN9v/rIGvm+Jm
         6bNz4y+6tsLyhRUlJlBJzzKuFYxG1DhfJjdBb8hz18XRX3DhyhUwx9a3iiCRsayDyp6o
         tZAnrHoNGi+HCNXFaFRVgPMfMHqv1dOGH2Q+N7Kh0Su9G0hEnjC7yc2Loibm3a7dRV16
         cRYVIh8hkPzb0ckTJ9IhjCRrhV4ilrcJE+6VCHE9SoK3f5XqaF16kkVtVKBEQNSQspCw
         WBmQ==
X-Gm-Message-State: AJIora8Db0BSnmF8KMq/MJraTRwFDRDAIUr6Pr9uV+Nu/XSFMkUhf69d
        CCLNDVoH7cyIA3+utTImsA==
X-Google-Smtp-Source: AGRyM1sb8UnKU4z6NZCwAF3E5qXXM+o/lEcLdtxI4ZJmA2Ei7IPysn1nWH37JbzVReJdXhRNAVXUzw==
X-Received: by 2002:a05:6638:1686:b0:33e:9977:2e1f with SMTP id f6-20020a056638168600b0033e99772e1fmr20045137jat.7.1657145388099;
        Wed, 06 Jul 2022 15:09:48 -0700 (PDT)
Received: from robh.at.kernel.org ([172.58.139.118])
        by smtp.gmail.com with ESMTPSA id t8-20020a5e9908000000b00674eedf7bbfsm17220697ioj.33.2022.07.06.15.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 15:09:47 -0700 (PDT)
Received: (nullmailer pid 622701 invoked by uid 1000);
        Wed, 06 Jul 2022 22:09:43 -0000
Date:   Wed, 6 Jul 2022 16:09:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Harsh Agarwal <quic_harshq@quicinc.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_pkondeti@quicinc.com,
        quic_ppratap@quicinc.com, quic_jackp@quicinc.com,
        ahalaney@redhat.com
Subject: Re: [PATCH v3 1/3] dt-bindings: usb: dwc3: Add support for multiport
 related properties
Message-ID: <20220706220943.GB572635-robh@kernel.org>
References: <1654709787-23686-1-git-send-email-quic_harshq@quicinc.com>
 <1654709787-23686-2-git-send-email-quic_harshq@quicinc.com>
 <20220609153826.GA3828657-robh@kernel.org>
 <ac3676bf-cd5c-be21-913a-0de6dc55bc7c@quicinc.com>
 <20220610172210.GE1787330-robh@kernel.org>
 <5d2a3a55-ae24-1bbb-2448-e7a23b9debde@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d2a3a55-ae24-1bbb-2448-e7a23b9debde@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 06:36:53PM +0530, Harsh Agarwal wrote:
> 
> On 6/10/2022 10:52 PM, Rob Herring wrote:
> > On Fri, Jun 10, 2022 at 05:25:25PM +0530, Harsh Agarwal wrote:
> > > On 6/9/2022 9:08 PM, Rob Herring wrote:
> > > > On Wed, Jun 08, 2022 at 11:06:25PM +0530, Harsh Agarwal wrote:
> > > > > Added support for multiport, mport, num_usb2_phy and num_usb3_phy
> > > > > properties. These properties are used to support devices having
> > > > > a multiport controller.
> > > > > 
> > > > > Signed-off-by: Harsh Agarwal <quic_harshq@quicinc.com>
> > > > > ---
> > > > >    .../devicetree/bindings/usb/snps,dwc3.yaml         | 53 ++++++++++++++++++++++
> > > > >    1 file changed, 53 insertions(+)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > index d41265b..9332fa2 100644
> > > > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > > > @@ -343,6 +343,32 @@ properties:
> > > > >          This port is used with the 'usb-role-switch' property  to connect the
> > > > >          dwc3 to type C connector.
> > > > > +  multiport:
> > > > Again, I don't think this is going to play well if you need to describe
> > > > USB devices in your DT. For example, a USB hub with additional DT
> > > > properties.
> > > Thanks for the review Rob.
> > > Can you please explain why would one want to describe a USB hub in device
> > > tree ?
> > Because someone soldered a hub on the board and then connected extra
> > things like resets, GPIOs, supplies which are all outside of standard
> > USB. It's quite common...
> > 
> > There's some flavors of Beagle boards that have a USB ethernet on board.
> > Guess what, they skipped out on a eeprom and so the device and a MAC
> > address has to be described in DT (if you want a stable MAC addr).
> > 
> > > IF USB hub is attached to a root port , it would be enumerated by the SW. I
> > > am not clear how DT is coming
> > > into picture. Even if there was a scenario to add DT properties for a hub,
> > > then this multiport node would be like a nop
> > > as it just helps us to get the PHY phandles in a proper way.
> > It won't be enumerated by the SW if it has to be powered on first using
> > non-standard resources.
> > 
> > > Do you feel we still might have a problem with multiport node ?
> > A board design could have a hub or device on any or all your ports.
> > 
> > > > > +    description:
> > > > > +      If a single USB controller supports multiple ports, then it's referred to as
> > > > > +      a multiport controller. Each port of the multiport controller can support
> > > > > +      either High Speed or Super Speed or both and have their own PHY phandles. Each
> > > > > +      port is represented by "mport" node and all the "mport" nodes are grouped
> > > > > +      together inside the "multiport" node where individual "mport" node defines the
> > > > > +      PHYs supported by that port.
> > > > > +
> > > > > +  num_usb2_phy:
> > > > > +    description: Total number of HS-PHYs defined by the multiport controller.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +
> > > > > +  num_usb3_phy:
> > > > > +    description: Total number of SS-PHYs defined by the multiport controller.
> > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +
> > > > > +  mport:
> > > > > +    description: Each mport node represents one port of the multiport controller.
> > > > > +    oneOf:
> > > > > +      - required:
> > > > > +        - usb-phy
> > > > This is deprecated. Why are you adding it?
> > > Do you mean "usb-phy" is deprecated ?
> > It is replaced by 'phys'. Any new user should use 'phys'.
> > 
> > > Internally we use usb-phy with our downstream GLUE driver
> > Upstream does not care about that.
> > 
> > > > > +      - required:
> > > > > +        - phys
> > > > > +        - phy-names
> > > > Other multi port USB hosts just have a list of phys. Why can't you just
> > > > use phy-names to identify each phy:
> > > > 
> > > > phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
> > > >     "port3-hs";
> > > With the above method we would have to do some kind of string parsing on the
> > > phy-names to get the HS and SS PHYs as we need to cater to different
> > > combinations of Ports ( some support HS+SS , other supports SS only).
> > You are doing string parsing anyways to get the child nodes and
> > properties.
> > 
> > > So one challenge here is with the "usb-phy". There we directly define the
> > > phy phandles and that might/might-not have proper sub-strings. eg
> > > USB_QMP_PHY . So extracting PHYS could be tricky if the phy-handle does not
> > > have proper substring like "SS" "HS" etc.
> > The schema can and should enforce that you have the proper strings.
> Hi Rob,
> Apologies for replying late.
> 
> I get your concern. Yes we can remove the "multiport" node and instead
> define the
> USB phy phandles all in one place. Still I would need to add support for
> both generic-phy and
> usb-phy framework as downstream many vendors are using "usb-phy" and it's
> supported by ACK as well.

Upstream is not concerned with downstream. The generic PHY has replaced 
usb-phy for many years now.

Furthermore, if downstream was using documented bindings, then we 
wouldn't be having this conversation.

> This would not regress anything with Generic PHY.
> 
> @Greg can you please comment as ACK has support for usb-phy framework.
> 
> Now coming to implementation, let's consider a 4 port USB multiport
> controller having
> 4 HS PHYs and 2 SS PHYs.  We can have two approaches here
> 
> #1 -> If we could mandate using "HS" or "SS" as substring in
> phy-names or usb-phy, then we can calculate number of HS and SS phy and also
> get
> corresponding PHY nodes. Only concern here is that downstream vendors might
> need
> to change their existing usb-phy names and add proper substring if they are
> not doing so ;
> 
> phy = <&usb-hs-phy>,<&usb-ss-phy>,
>       <&usb-hs-phy1>, <&usb-ss-phy1>,
>       <&usb-hs-phy2>, <&usb-hs-phy3>;
> 
> phy-names = "port0-hs", "port0-ss", "port1-hs", "port1-ss", "port2-hs",
>    "port3-hs";
> 
> 
> OR
> 
> 
> #2-> We could mandate defining the USB phy in HS - SS pairs.
> For ports that has only HS PHY, we would need to define usb_nop_phy in SS
> place.
> Then we can calculate the number of HS & SS phys and get corresponding
> PHY nodes by using simple fact that HS phy would be defined at odd places &
> SS phy defined at even. Here substrings are not mandated.
> 
> phy = <&usb-hs-phy>,<&usb-qmp-phy>,
>       <&usb-hs-phy1>, <&usb-qmp-phy1>,
>       <&usb-hs-phy2>, <&usb_nop_phy>
>       <&usb-hs-phy3>, <&usb_nop_phy>;
> 
> phy-names = "port0-hs", "port0-ss",
> 	    "port1-hs", "port1-ss",
> 	    "port2-hs", "usb-nop",
> 	    "port3-hs", "usb-nop";

The whole reason for -names is to avoid something like this with filler 
entries. So I prefer #1 as I suggested.

Rob
