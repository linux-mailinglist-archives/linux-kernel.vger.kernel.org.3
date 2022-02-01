Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A714A675F
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 22:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236840AbiBAVxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 16:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236700AbiBAVxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 16:53:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60CD8C061714;
        Tue,  1 Feb 2022 13:53:31 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id a13so34633254wrh.9;
        Tue, 01 Feb 2022 13:53:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xO39BmkI2FGjUMBOjrgQHT01JzWS5Ploj3Qtkh1kqM8=;
        b=LbtPvwiUa0ZBOZVtQKYrWwxUBVRuktbH/zhVkCPg1VMuhzoiQlij0/4WvK4duTmS/J
         pwfS5qbR3InvFv8va8K9f5Axvm+dNkAnrUTaW+gAgWqMzNiVwYINEV3fX9y9kgriqcKa
         vDVFUhSZPE84JQtm0mJEc9jUmVE621/5BvhcTuiUWMDTeuLlImcTjo8ySxAdoQ2ioC35
         nOz+bCYrCxq8m3Shd9Ljj5tqQaqf/eg0Ygp+rndTW8VTzPtMZapDR0hUC+hhUcNg9Uk7
         AOnJM611js4IISbS/sUguO3WksWXpslAGVAanuNc6YSbcmvILqvH04Yz+j4UeBh0VGza
         eM7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xO39BmkI2FGjUMBOjrgQHT01JzWS5Ploj3Qtkh1kqM8=;
        b=LXdAbVIMELJ9WFbWW78MT1+vljg2zysl9wpnzJcf4hhql5FAZhmdYEDs313nnsXj+m
         i5sd9gH1dn1cuTBm+LS1WO+zIuuw/b+RTnCZs4uHToX5TW/rV8nCQ6HiiycKYg385rV6
         QoU14ORb/T0nyPjyQiYwL1ilRkvOo9bAV9Gvr2LTB1c9DX/TmkweWXzm2zwNUWqlKbz2
         wn94Pjjq/3R1hEq3Gl3K/s5BNpyIx0sStscpSqi0nZZhDGglNx9bXVZA1znPUUu5B8WX
         k8+QOeOJ6zZWyp7crLPv44MPSp7mLctv85iW6yglnJA4GQhf6BO71LVEfSnIM95sFeyN
         M0rQ==
X-Gm-Message-State: AOAM532fb9p7Q197ZMHcMhxAk42PQ7m1nPOARuI+cfuOxc2/X7sHtvMs
        yriq99CSG9lAjBXJLtOvTAA=
X-Google-Smtp-Source: ABdhPJzEkqh/6jLqdmWjCaDnCRG8wWWukjaLy2m4mvM9Bt8sevDDg82ArhnDf23q8Ji3zwt1tCW5hQ==
X-Received: by 2002:adf:ffce:: with SMTP id x14mr23213863wrs.128.1643752408921;
        Tue, 01 Feb 2022 13:53:28 -0800 (PST)
Received: from Ansuel-xps.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.gmail.com with ESMTPSA id l4sm16808867wrs.6.2022.02.01.13.53.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:53:28 -0800 (PST)
Date:   Tue, 1 Feb 2022 22:53:26 +0100
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 01/15] dt-bindings: clock: split qcom,gcc.yaml to
 common and specific schema
Message-ID: <Yfmr1kNGIN9OMiz5@Ansuel-xps.localdomain>
References: <20220121210340.32362-1-ansuelsmth@gmail.com>
 <20220121210340.32362-2-ansuelsmth@gmail.com>
 <YfhssKqI5U8X+Akn@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfhssKqI5U8X+Akn@builder.lan>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 05:11:44PM -0600, Bjorn Andersson wrote:
> On Fri 21 Jan 15:03 CST 2022, Ansuel Smith wrote:
> 
> > Split qcom,gcc.yaml to common and specific schema to use it as a
> > template for schema that needs to use the gcc bindings and require
> > to add additional bindings.
> > 
> 
> Nice!
> 
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> > ---
> >  .../bindings/clock/qcom,gcc-common.yaml       | 42 +++++++++++++++++++
> >  .../devicetree/bindings/clock/qcom,gcc.yaml   | 25 ++---------
> >  2 files changed, 46 insertions(+), 21 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml
> > new file mode 100644
> > index 000000000000..ea1dd94d8bf1
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc-common.yaml
> 
> It seems reasonable to expect that qcom,gcc.yaml should be split out in
> a number of trivial qcom,gcc-platform.yaml files to define input clock
> etc. So how about using qcom,gcc.yaml for the common properties and for
> now rename the existing file to something like qcom,gcc-others.yaml
> ?
>

Ok, just to make sure.
gcc-common.yaml -> gcc.yaml (the template)
gcc.yaml -> gcc-others.yaml (the generic gcc schema)

Correct?

> > @@ -0,0 +1,42 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/clock/qcom,gcc-common.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm Global Clock & Reset Controller Binding Common Bindings
> > +
> > +maintainers:
> > +  - Stephen Boyd <sboyd@kernel.org>
> > +  - Taniya Das <tdas@codeaurora.org>
> > +
> > +description: |
> 
> No need to preserve the formatting here, so the pipe can go.
> 
> Regards,
> Bjorn
> 
> > +  Common bindings for Qualcomm global clock control module which supports
> > +  the clocks, resets and power domains.
> > +
> > +properties:
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
> > +  protected-clocks:
> > +    description:
> > +      Protected clock specifier list as per common clock binding.
> > +
> > +required:
> > +  - reg
> > +  - '#clock-cells'
> > +  - '#reset-cells'
> > +  - '#power-domain-cells'
> > +
> > +additionalProperties: true
> > +
> > +...
> > diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> > index f66d703bd913..73e3ff4979c6 100644
> > --- a/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> > +++ b/Documentation/devicetree/bindings/clock/qcom,gcc.yaml
> > @@ -34,6 +34,9 @@ description: |
> >    - dt-bindings/reset/qcom,gcc-mdm9615.h
> >    - dt-bindings/clock/qcom,gcc-sdm660.h  (qcom,gcc-sdm630 and qcom,gcc-sdm660)
> >  
> > +allOf:
> > +  - $ref: "qcom,gcc-common.yaml#"
> > +
> >  properties:
> >    compatible:
> >      enum:
> > @@ -55,30 +58,10 @@ properties:
> >        - qcom,gcc-sdm630
> >        - qcom,gcc-sdm660
> >  
> > -  '#clock-cells':
> > -    const: 1
> > -
> > -  '#reset-cells':
> > -    const: 1
> > -
> > -  '#power-domain-cells':
> > -    const: 1
> > -
> > -  reg:
> > -    maxItems: 1
> > -
> > -  protected-clocks:
> > -    description:
> > -      Protected clock specifier list as per common clock binding.
> > -
> >  required:
> >    - compatible
> > -  - reg
> > -  - '#clock-cells'
> > -  - '#reset-cells'
> > -  - '#power-domain-cells'
> >  
> > -additionalProperties: false
> > +unevaluatedProperties: false
> >  
> >  examples:
> >    # Example for GCC for MSM8960:
> > -- 
> > 2.33.1
> > 

-- 
	Ansuel
