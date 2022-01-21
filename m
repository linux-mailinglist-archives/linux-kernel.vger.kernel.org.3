Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D3F496576
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiAUTHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAUTHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:07:54 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431C0C06173B;
        Fri, 21 Jan 2022 11:07:54 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jx6so2647362ejb.0;
        Fri, 21 Jan 2022 11:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=NXJWnollkpJvI1aepiBIBMujy+bg/gCa9e9nqfwYgA0=;
        b=kjEAeSKxvQVjnf9hGnoDkajMluX7s5BTbxn+7H14vx7dKaSTk4BSHwuxFJ1CF7jMRt
         /oFo4c0v/kKQtj2pLVjE2uAaK24i/O8Bex8nqEvw92K3UvMm170Qc8pVsRGuFHTvx/xN
         HmdiEXGWE1uctMnc3AmvLqv+2IRj9qzrhr3VTbW8fCpKfP+JzUUK+ai6STwgGPtGCoGl
         aDwB5dm6Sgrhjtbm5HfCraDjEet673mDm0TUoGMUZRdatYc2z1Dvu6XVO3yWsXYKmJtN
         iuuBTMC2k7fm69KjcW1VsKDttH7u1g+KHq5wQwx/+lRVOu7XvH8kz24Gj/3MbS+3BZgr
         zmiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=NXJWnollkpJvI1aepiBIBMujy+bg/gCa9e9nqfwYgA0=;
        b=wVzIywdjpUbfHRFlbxjNfvhto9OWD++W2C+0iwZubLHcU6FPKnHj0DDGZjVyTyFAea
         DAxZAg/K9hcVVwa4+Xwk2KyO11e0hkIzg+V+JdbGZGXjCbxGQ5W5n3w4OxytEqhLr0NK
         C+dnqDToGOGNyJa63jZNRCb39P6jVPvCl5t4zguGpWwkPTS/f5XSheU5EJUfBa4I5s3K
         EWCKMgW8ZoS2VCYgkCHHw5wCyO3Z3R+EEsYY9RVR5m8UbvqTXN5/owTmo4xsdyVtu1AC
         W32WvyHC0DVIvugWcFUAPQ5IuIdEFaUa1hMXiccBS/sCCOQ3YK5WSKCLdQuc5FsFrLl1
         Hd4g==
X-Gm-Message-State: AOAM530ZmZZrxqLCmdB8/M6/cle4iiZ4m9MD44j5W5cWFs71iJyq1M/k
        ja02EjD8VEUisTPGS/Hgw3o=
X-Google-Smtp-Source: ABdhPJwTFte3UxKMd9TLrKA5gvTz0mtaMMwNW6kVsYHvFyNaXb9g/4ldqgN4MJtanX1lR4GrWmFZ2g==
X-Received: by 2002:a17:907:7e85:: with SMTP id qb5mr204538ejc.557.1642792072551;
        Fri, 21 Jan 2022 11:07:52 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id zm17sm712255ejb.213.2022.01.21.11.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 11:07:52 -0800 (PST)
Message-ID: <61eb0488.1c69fb81.d267e.3b1f@mx.google.com>
X-Google-Original-Message-ID: <YesEhlF2q76/NjU2@Ansuel-xps.>
Date:   Fri, 21 Jan 2022 20:07:50 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/15] dt-bindings: clock: Document qcom,gcc-ipq8064
 binding
References: <20220120232028.6738-1-ansuelsmth@gmail.com>
 <20220120232028.6738-4-ansuelsmth@gmail.com>
 <YeoUk3t2iVbQwj5s@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeoUk3t2iVbQwj5s@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 08:04:03PM -0600, Rob Herring wrote:
> On Fri, Jan 21, 2022 at 12:20:16AM +0100, Ansuel Smith wrote:
> > Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> > clocks. The gcc node is also used by the tsens driver, already documented,
> > to get the calib nvmem cells and the base reg from gcc.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 70 +++++++++++++++++++
> >  1 file changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > new file mode 100644
> > index 000000000000..abc76a46b2ca
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > @@ -0,0 +1,70 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
> > +
> > +allOf:
> > +  - $ref: qcom,gcc.yaml#
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains on IPQ8064.
> > +
> > +  See also:
> > +  - dt-bindings/clock/qcom,gcc-ipq806x.h
> > +  - dt-bindings/reset/qcom,gcc-ipq806x.h
> > +
> > +properties:
> 
> This schema will never be applied because there is not a compatible 
> property to use for matching. The base/common schema is the one that 
> shouldn't have a compatible and then the specific schemas like this 
> one do.
>

Just to make things clear. To fix things up, what changes should I do?
- I should remove the compatible from the base schema qcom,gcc.yaml
- Add the compatible to this schema
- Create another schema that includes all the others compatible?

Can I instead:
- Create a qcom,gcc-common.yaml schema
- Modify the qcom,gcc.yaml schema to ref the common one and drop the
  other binding.
- Fix this schema with the missing compatible?

Tell me how I should proceed since it looks to me that all the
Documentation for the gcc driver looks a bit mess and full of
duplicated stuff.

> > +  clocks:
> > +    items:
> > +      - description: PXO source
> > +      - description: CXO source
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pxo
> > +      - const: cxo
> > +
> > +  thermal-sensor:
> > +    type: object
> > +
> > +    allOf:
> > +      - $ref: /schemas/thermal/qcom-tsens.yaml#
> > +
> > +required:
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    gcc: clock-controller@900000 {
> > +      compatible = "qcom,gcc-ipq8064", "syscon";
> > +      reg = <0x00900000 0x4000>;
> > +      clocks = <&pxo_board>, <&cxo_board>;
> > +      clock-names = "pxo", "cxo";
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> > +      #power-domain-cells = <1>;
> > +
> > +      tsens: thermal-sensor {
> > +        compatible = "qcom,ipq8064-tsens";
> > +
> > +        nvmem-cells = <&tsens_calib>, <&tsens_calib_backup>;
> > +        nvmem-cell-names = "calib", "calib_backup";
> > +        interrupts = <GIC_SPI 178 IRQ_TYPE_LEVEL_HIGH>;
> > +        interrupt-names = "uplow";
> > +
> > +        #qcom,sensors = <11>;
> > +        #thermal-sensor-cells = <1>;
> > +      };
> > +    };
> > -- 
> > 2.33.1
> > 
> > 

-- 
	Ansuel
