Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66CAA4A675A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiBAVt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235481AbiBAVt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:49:57 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5408C061714;
        Tue,  1 Feb 2022 13:49:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e2so34668309wra.2;
        Tue, 01 Feb 2022 13:49:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4Hyu/VUYheXrOABb43glnjnbZby65idXFVWG0Y4WTY=;
        b=O9TKvh/hTGTM4UMGMvIPoRUSjN+6tqaijsZkEixbdskujJqUkgj0VEByuscOzEF4je
         +buhBPGDLh3n/vGSghZrAcUVxGjoOin64pL+biZDjqGje3mJbOg9BidtqXVGE7Uqbzb/
         PGgUS+/Pz8xUykRAjU13HY076/u+S+nypid4DDaoKCLwI3T7MHTCepg+gpQHh+56WBkR
         bARbnBUh75onjg2uQoqu6ou7CgSzVsfKGWtLjDT+H7O73QmU2f5p18QDOK4E4TUWRKI+
         2PmCz2GM4cw53pN2of7KicIjahIvBiCAZ1NRjKJVNN00Qi1ZhFjGUdtrJw8ux9/7I2Sb
         wf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4Hyu/VUYheXrOABb43glnjnbZby65idXFVWG0Y4WTY=;
        b=raDysHcU4ldcn/MJn/e2ZnwwdXhsk6TySkknNkFDl8P9BJR2cyUcOCg64/EUJm65Lv
         wp5DLEj7xx1GHfj58oXnvfBQDwvJNhEu424mOVR/5qS7sDuVXMa2cb0EF0BBTigUNoWU
         vfiMeL6KqBwE3cdKCSdw+DergU7YFE25HtsX6zccWwX2nOXbYX/EN7gJ37VwWKVORbOd
         nKTFFkz3iD9QkAdQEXMhabM6skx3T5IJOYxVXipTHO/TOMNYxWi/TadS0g1LNwzpiiXQ
         QYkO2OZlfFNH4wt290O93RJPSpRJiH/nq4CqNo3+iyVt3Q9HILaEciExhDkYFzublSiD
         3sKQ==
X-Gm-Message-State: AOAM531cugQr8ZI8LTC1lMzz0LC1AWaBqHC1ZfsBlAXnfIp+BPjo4Bp4
        nIxz9SSNwiNbvRkhV2efC4o=
X-Google-Smtp-Source: ABdhPJzNECjAmt68HyqKg9OizaVVm6XVr0LfrRCL1sgj7sW5Py7PSaXx7j0eZgnGRhQbkHSd7lblTQ==
X-Received: by 2002:a5d:47cf:: with SMTP id o15mr22871041wrc.577.1643752195020;
        Tue, 01 Feb 2022 13:49:55 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id r12sm15634699wrw.73.2022.02.01.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:49:54 -0800 (PST)
Date:   Tue, 1 Feb 2022 22:49:16 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: add qcom,tcsr bindings
Message-ID: <Yfmq3IpjHZXdtEQR@Ansuel-xps.localdomain>
References: <20220122001609.15904-1-ansuelsmth@gmail.com>
 <20220122001609.15904-2-ansuelsmth@gmail.com>
 <Yfhzqvrj6bIPmV2S@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yfhzqvrj6bIPmV2S@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:41:30PM -0600, Bjorn Andersson wrote:
> On Fri 21 Jan 18:16 CST 2022, Ansuel Smith wrote:
> 
> > Add qcom,tcsr-ipq8064 and qcom,tcsr-ipq4019 Documentation for the
> > tcsr present in ipq8064 and ipa4019 required to configure and
> > set various peripherals present in the SoC.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/soc/qcom/qcom,tcsr-ipq4019.yaml  | 93 +++++++++++++++++++
> >  .../bindings/soc/qcom/qcom,tcsr-ipq8064.yaml  | 47 ++++++++++
> >  2 files changed, 140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> >  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> > new file mode 100644
> > index 000000000000..3a82ccbb6588
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq4019.yaml
> > @@ -0,0 +1,93 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq4019.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm Top Control and Status Registers binding for IPQ4019
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  This binding describes the Qualcomm Top Control and Status Registers, used
> > +  for accessing configuration and mux settings for a variety of peripherals
> > +  for ipq4019.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: qcom,tcsr-ipq4019
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  qcom,usb-hsphy-mode-select:
> > +    description: Select usb hsphy mode for ipq4019
> 
> Why isn't this driven by the USB node, where I presume you otherwise
> need to duplicate this decision?
> 

From what I understand this is global, setting this will apply on any
usb present.

> Is this platform not capable of OTG?
> 

I assume it's capable by selecting the correct mode using tcsr.

> > +    enum:
> > +      - 'host'
> > +      - 'device'
> > +
> > +  qcom,ess-interface-select:
> > +    description: Select ess interface mode for ipq4019
> > +    enum:
> > +      - 'psgmii'
> > +      - 'rgmii5'
> > +      - 'rmii0'
> > +      - 'rmii1'
> > +      - 'rmii0_rmii1'
> > +      - 'rgmii4'
> > +
> > +  qcom,wifi-glb-cfg-enable-axid:
> > +    description: Enable AXI master bus Axid translating
> > +                  to confirm all txn submitted by order for ipq4019
> > +    type: boolean
> > +
> > +  qcom,wifi-glb-cfg-socslv-mode:
> > +    description: Select wifi socslv mode for ipq4019
> > +                  snoc use SNOC socslv_wxi_bvalid.
> > +                  local use locally generate socslv_wxi_bvalid for performance.
> > +    enum:
> > +      - 'snoc'
> > +      - 'local'
> > +
> > +  qcom,wifi_noc_memtype_m0_m2:
> > +    description: Configure special wifi memory type needed for
> > +                  some IPQ40xx devicesfor ipq4019
> > +    type: boolean
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    tcsr@194b000 {
> > +      compatible = "qcom,tcsr-ipq4019", "syscon";
> 
> There's a single "tcsr" register block at 0x1937000 of size 0x21000.
> The binding should describe that entire block, not convenient pieces of
> it.
> 

The current driver implementation works with the offset provided by the
reg. I assume I can just hardcode the offset in the driver and declare a
single tcsr node. Will do this change.

> > +      reg = <0x194b000 0x100>;
> > +      qcom,usb-hsphy-mode-select = "host";
> > +    };
> > +
> > +    tcsr@1949000 {
> > +      compatible = "qcom,tcsr-ipq4019", "syscon";
> > +      reg = <0x1949000 0x100>;
> > +      qcom,wifi-glb-cfg-enable-axid;
> > +      qcom,wifi-glb-cfg-socslv-mode = "local";
> > +    };
> > +
> > +    ess_tcsr@1953000 {
> > +      compatible = "qcom,tcsr-ipq4019", "syscon";
> > +      reg = <0x1953000 0x1000>;
> > +      qcom,ess-interface-select = "psgmii";
> > +    };
> > +
> > +    tcsr@1957000 {
> > +      compatible = "qcom,tcsr-ipq4019", "syscon";
> > +      reg = <0x1957000 0x100>;
> > +      qcom,wifi_noc_memtype_m0_m2;
> > +    };
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> > new file mode 100644
> > index 000000000000..4ccc0bfccec5
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/qcom/qcom,tcsr-ipq8064.yaml
> > @@ -0,0 +1,47 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: "http://devicetree.org/schemas/soc/qcom/qcom,tcsr-ipq8064.yaml#"
> > +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> > +
> > +title: Qualcomm Top Control and Status Registers binding for IPQ8064
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  This binding describes the Qualcomm Top Control and Status Registers, used
> > +  for accessing configuration and mux settings for a variety of peripherals
> > +  for ipq8064.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - const: qcom,tcsr-ipq8064
> > +      - const: syscon
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  qcom,usb-ctrl-select:
> > +    description: Select usb3 ctrl type for ipq8064
> > +    enum:
> > +      - 'p0'
> > +      - 'p1'
> > +      - 'dual'
> 
> Again, it seems reasonable to get this form the dwc3 node, rather than
> duplicating the configuration.
> 

As I said up, it seems to be global, that's the reason I didn't put this
handling in the dwc-qcom driver. (I mean it seems wrong that dwc3 would
set the same value twice). If this is necessary I will add support for
this in dwc-qcom.

> Regards,
> Bjorn
> 
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    tcsr: syscon@1a400000 {
> > +      compatible = "qcom,tcsr-ipq8064", "syscon";
> > +      reg = <0x1a400000 0x100>;
> > +      qcom,usb-ctrl-select = "dual";
> > +    };
> > +
> > +...
> > -- 
> > 2.33.1
> > 

-- 
	Ansuel
