Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA7F646C495
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 21:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbhLGU3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 15:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhLGU3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 15:29:51 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15AA7C061748
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 12:26:21 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a18so177267wrn.6
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 12:26:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkXmbOcSXdtBG8nSV6cZZ9ohzVatbQZOqgA3s3vf5hk=;
        b=CpYwtWNW9N1tad35IcVKqSCOmg5c7BRdaiGws5zViiwbeblQfP18LkmVajHrVrWIZD
         fREkYoM1VTfwF/G+pVq/lj3VZ1E5a8Ugw1ZU15kJvU+Vl+TdeHD8KpARKW9EKKGno4cj
         rkvzl900/pYyohxrMHJSAWJrS7Yv4KC4BSqm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkXmbOcSXdtBG8nSV6cZZ9ohzVatbQZOqgA3s3vf5hk=;
        b=AWsOIicyrIphHWXstoeYuJAxRkE2YJ+r1oKTdJGuG6RdXtYANfwu1ZwkCn4pIDlhWq
         5dFsiSTSU27PHH1KO18bgsC3yIy0MLvwu/OFDvdzi3BK0Zm4YxSuiLmOWDQu/LfCBNV5
         vU87nhcTy/x0uBPwXv9IEbGthpqs4FrjZzHcDRhMyy+RsnzuACufSipSbo2NvSKeeVqO
         VoSTD4iDWGX3FlT3mFeqbJqWw1DYyVOyY5ngA6LawrGGmCntDuSnyv3MwSHn2Ncx8EBL
         TDZvD5TtzhnqwR5V0ZPmjx1koI/wa9hjF/7Q0//WhkmWHihTbHb+IelGqfe7Gef5ZoE7
         BE3A==
X-Gm-Message-State: AOAM531BbFcDW7xOnByVXtfhOmBpgkC1VNKQz7aPxhvBf+zSZsqRcqUn
        pN2f7lHbTXRP1vjING22thAJE/gRz8VA/X1S8ZWIag==
X-Google-Smtp-Source: ABdhPJwrsYzc2lhEB34KbJU1bpdv+YpbHX452by5m4olrT0QC+t3vm5PQ44H/vfQm/J1llb7cPkre2Nq/HNDi+9AOOQ=
X-Received: by 2002:adf:f786:: with SMTP id q6mr54002268wrp.356.1638908779497;
 Tue, 07 Dec 2021 12:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20211119220756.18628-1-jim2101024@gmail.com> <20211119220756.18628-4-jim2101024@gmail.com>
 <Ya/Bar212Tb+S9Eo@robh.at.kernel.org>
In-Reply-To: <Ya/Bar212Tb+S9Eo@robh.at.kernel.org>
From:   Jim Quinlan <james.quinlan@broadcom.com>
Date:   Tue, 7 Dec 2021 15:26:08 -0500
Message-ID: <CA+-6iNzSOY-D_O5rD=+oyxNnjZxpWS-uBQY1mRabQ1AHMfTqwA@mail.gmail.com>
Subject: Re: [PATCH v9 3/7] dt-bindings: PCI: Add bindings for Brcmstb EP
 voltage regulators
To:     Rob Herring <robh@kernel.org>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" 
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 3:17 PM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Nov 19, 2021 at 05:07:50PM -0500, Jim Quinlan wrote:
> > Add bindings for Brcmstb EP voltage regulators.  A new mechanism is to be
> > added to the Linux PCI subsystem that will allocate and turn on/off
> > regulators.  These are standard regulators -- vpcie12v, vpcie3v3, and
> > vpcie3v3aux -- placed in the DT in the bridge node under the host bridge
> > device.
> >
> > The use of a regulator property in the pcie EP subnode such as
> > "vpcie12v-supply" depends on a pending pullreq to the pci-bus.yaml
> > file at
> >
> > https://github.com/devicetree-org/dt-schema/pull/63
> >
> > Signed-off-by: Jim Quinlan <jim2101024@gmail.com>
> > ---
> >  .../bindings/pci/brcm,stb-pcie.yaml           | 23 +++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > index 22f2ef446f18..7113a7f726e7 100644
> > --- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > +++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
> > @@ -159,5 +159,28 @@ examples:
> >                                   <0x42000000 0x1 0x80000000 0x3 0x00000000 0x0 0x80000000>;
> >                      brcm,enable-ssc;
> >                      brcm,scb-sizes =  <0x0000000080000000 0x0000000080000000>;
> > +
> > +                    /* PCIe bridge */
>
> Root port specifically. Didn't Pali mention that before?
Yes,  my miss, will fix.
>
> > +                    pci@0,0 {
> > +                            #address-cells = <3>;
> > +                            #size-cells = <2>;
> > +                            reg = <0x0 0x0 0x0 0x0 0x0>;
> > +                            compatible = "pciclass,0604";
> > +                            device_type = "pci";
> > +                            vpcie3v3-supply = <&vreg7>;
> > +                            ranges;
> > +
> > +                            /* PCIe endpoint */
> > +                            pci-ep@0,0 {
> > +                                    assigned-addresses =
> > +                                        <0x82010000 0x0 0xf8000000 0x6 0x00000000 0x0 0x2000>;
> > +                                    reg = <0x0 0x0 0x0 0x0 0x0>;
> > +                                    compatible = "pci14e4,1688";
>
> > +                                    #address-cells = <3>;
> > +                                    #size-cells = <2>;
> > +
> > +                                    ranges;
>
> These aren't appropriate for an endpoint.
Got it.

Do you have feedback for any of the other commits?

Thanks,
Jim Quinlan
Broadcom STB

>
> > +                            };
> > +                    };
> >              };
> >      };
> > --
> > 2.17.1
> >
> >
