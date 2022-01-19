Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 699B1493BC0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 15:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355088AbiASOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 09:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355060AbiASOKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 09:10:14 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 453E9C061574;
        Wed, 19 Jan 2022 06:10:14 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id f21so12325596eds.11;
        Wed, 19 Jan 2022 06:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0Kq5PyyXWYYGOifzNFKVcshKPptWhT8fq2YlzQ9eaM=;
        b=QE8O0Gm4767LFQfVuqRlfHE0giY0dAqTb8W9Ny9v6eDo7L93KJDoSBpgAG33CXCpPG
         p0K2cD97iFrfabHYMvAv0GoECal6Fml0j1G0bu5ZosSQWFSfhJpQybOt8cCVTVC1UykA
         Jqlzn2H7I0xoluHJGDk7xrMMoLnGXdtWwOnMd2qeXbEcXEmh235IH5aFFNvMKJnINc1O
         VHn2VhqUIS8mJ6f291f9HJi4LNy72AvcIB5C7QgxQmn3rxn425x/USsNkLRrOgOBHwRi
         3rIHczsVnRwFVUeppVqs859CNxwo7xood/WSVSu3aIUT6xyCGhFrPMzoG4gA1Jf3+Dld
         HkkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0Kq5PyyXWYYGOifzNFKVcshKPptWhT8fq2YlzQ9eaM=;
        b=mgkafQ+Jn6bFhMLeizvBFv7VofHrIkKyyjgD242NkH00Q7HthvscY02SWIiTsswfBT
         DUaFvY+tRfO6NHdhNOwR42zwIc4TplHBP3JSlB27KD2OqhvuLaBuEnV7nbqMK/QZklDP
         n1WggEu1e+VEQij9DaGoyXanbJVLrV1D9uVRhzjc4rd9O5NMck4kHTs1X5qsoC/0V5YP
         BYdpPsWkYAbm9xLomuVcPOa7Vnz/h32c7Bsebal9ZT7aOsnCCkYJXbIYeWjQ4Pt1GRF9
         REe/hAwv6lovkisqU52pKz8AIsgFNOoMWrhyFXzIyjpa+6Wq1uxqRr3eFM9Y6xb0253s
         xL4w==
X-Gm-Message-State: AOAM531fI6fYlrz/gUihb7YmJETOG73Rl80gPX5RNGgTgo94LIiS6owJ
        oDhqVX81l/zOA4wpu35YGDk=
X-Google-Smtp-Source: ABdhPJx8Tn89U3h6jBmGY5pjo0cmtIUSXZW92HpbOxEA/A58ZhHBvYvSKMNcYnOWg9tr4lVg0NSs0A==
X-Received: by 2002:a05:6000:1a43:: with SMTP id t3mr17729790wry.237.1642601412433;
        Wed, 19 Jan 2022 06:10:12 -0800 (PST)
Received: from Ansuel-xps. (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id m5sm5192083wmq.6.2022.01.19.06.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 06:10:12 -0800 (PST)
Message-ID: <61e81bc4.1c69fb81.24431.2990@mx.google.com>
X-Google-Original-Message-ID: <YegbvyGnPJXKf8fD@Ansuel-xps.>
Date:   Wed, 19 Jan 2022 15:10:07 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/14] dt-bindings: clock: Document qcom,gcc-ipq8064
 binding
References: <20220118004434.17095-1-ansuelsmth@gmail.com>
 <20220118004434.17095-2-ansuelsmth@gmail.com>
 <YegZJyIredPbQUKv@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YegZJyIredPbQUKv@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 07:59:03AM -0600, Rob Herring wrote:
> On Tue, Jan 18, 2022 at 01:44:21AM +0100, Ansuel Smith wrote:
> > Document qcom,gcc-ipq8064 binding needed to declare pxo and cxo source
> > clocks. The gcc node is also used by the tsens driver, already Documented,
> > to get the calib nvmem cells and the base reg from gcc.
> > 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/clock/qcom,gcc-ipq8064.yaml      | 67 +++++++++++++++++++
> >  1 file changed, 67 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > new file mode 100644
> > index 000000000000..2dc254fdf161
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-ipq8064.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-ipq8064.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding for IPQ8064
> > +
> > +maintainers:
> > +  - Ansuel Smith <ansuelsmth@gmail.com>
> > +
> > +description: |
> > +  Qualcomm global clock control module which supports the clocks, resets and
> > +  power domains on IPQ8064.
> > +
> > +properties:
> > +  compatible:
> > +    const: qcom,gcc-ipq8064
> > +
> > +  '#clock-cells':
> > +    const: 1
> > +
> > +  '#reset-cells':
> > +    const: 1
> > +
> > +  '#power-domain-cells':
> > +    const: 1
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: PXO source
> > +      - description: CX0 source
> > +
> > +  clock-names:
> > +    items:
> > +      - const: pxo
> > +      - const: cxo
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - '#clock-cells'
> > +  - '#reset-cells'
> > +  - '#power-domain-cells'
> > +  - clocks
> > +  - clock-names
> > +
> > +additionalProperties: true
> 
> Must be 'false'. True is only for incomplete schemas included by other 
> schemas.
> 
> > +
> > +examples:
> > +  - |
> > +    gcc: clock-controller@900000 {
> > +      compatible = "qcom,gcc-ipq8064", "syscon";
> > +      reg = <0x00900000 0x4000>;
> > +      clocks = <&pxo_board>, <&cxo_board>;
> > +      clock-names = "pxo", "cxo";
> > +      #clock-cells = <1>;
> > +      #reset-cells = <1>;
> > +      #power-domain-cells = <1>;
> > +
> > +      /* Tsens node definition */
> 
> You need to define child nodes.
>

Is it correct to put in the example the tsens node Documented in another
file? Or should I just remove the comment?

> > +
> > +    };
> > +...
> > -- 
> > 2.33.1
> > 
> > 

-- 
	Ansuel
