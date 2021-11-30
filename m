Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D6462AB4
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 03:50:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbhK3CxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 21:53:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbhK3CxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 21:53:21 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D644C061748
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:50:03 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id f125so4886517pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 18:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=koRfBp4VpgjWJfC/0JEHPzq77c2QcCg2LBZMxLjnjcw=;
        b=kQdAJbtUSkt+KdGki/UVNknRsYpeAsuwfQb3rAWIfM/9m5HPZP1V9zmEUkwQ5/1bmO
         Jz3hr8zFnabd78Zfx78i4DVoKT2M/QtpXhli2BpQg72FdVprlDAM4ubbXONmGGM9HRfy
         EGjEQvWf+FdzCSqc+emgqogNFUZjawAzyD2OJrrU+HCvq2f8iX6kHLhzre9LlvLotyLT
         lmIMmypRFciVvQm2fKZr15w3kOBd/KawzHHRBy95FbjzT1x+1O48Qkpj3DYebbXNFwic
         LitZr57k3GCQXjMirxVqTKx6/r9QKwJooGvOaVBrjGzWcDDLRC/3j+RNwY7XmMXQcSMJ
         o0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=koRfBp4VpgjWJfC/0JEHPzq77c2QcCg2LBZMxLjnjcw=;
        b=3OGEi8KyuXWBzBODrQ4kFepEt03kYcv8G/3ECmwXuMDVN+AwWCYmX2jztlNZv+iOR8
         t04u/OiHBBp1JZMGS6FqwdpoWgSqzJCqyTouqQD12TXFbE3OI8HIuibgrNoElQe147+P
         YHp69V49jwe3D+p9s0HU8O51pUKSg2520INywXmQ3yDs1hfFzPd4hwcKUvcUBCSlNkUK
         pOBz8CA72Mo3P8PXCqPB8CkEcWOQxr47xL4kR3VUwme71Ol85s4xF+xISMplkc6g0h3Z
         Cf4/XAtRvQQxgXstw5YDyt9lxZxPOPMdBGwiNN5wHFG3I1cxWlgpAWy0VC9KGn8tN9G6
         0gVw==
X-Gm-Message-State: AOAM531gFUSNiUevsLKKEXvwbNDpjyLE9p5OwJzWLz7XPpRVjcPXEDth
        qAlsX6SfCrZ1dlShw7811WfoVw==
X-Google-Smtp-Source: ABdhPJxEIkpoVr0R7RjxZ1wJ3uZ+NmxlaVH6sjBftFGnmD94mx15PURSCA1UMDwmChno3ARXM54o9A==
X-Received: by 2002:a05:6a00:1145:b0:4a2:6a03:c592 with SMTP id b5-20020a056a00114500b004a26a03c592mr42467227pfm.65.1638240602819;
        Mon, 29 Nov 2021 18:50:02 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id e29sm9354659pge.17.2021.11.29.18.50.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Nov 2021 18:50:02 -0800 (PST)
Date:   Tue, 30 Nov 2021 10:49:57 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/6] dt-bindings: interconnect: Add Qualcomm QCM2290
 NoC support
Message-ID: <20211130024956.GE10105@dragon>
References: <20211122085123.21049-1-shawn.guo@linaro.org>
 <20211122085123.21049-6-shawn.guo@linaro.org>
 <YaWLGAvZJ1dZwWNj@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaWLGAvZJ1dZwWNj@robh.at.kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 08:23:20PM -0600, Rob Herring wrote:
> On Mon, Nov 22, 2021 at 04:51:22PM +0800, Shawn Guo wrote:
> > Add bindings for Qualcomm QCM2290 Network-On-Chip interconnect devices.
> > 
> > Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> > ---
> >  .../bindings/interconnect/qcom,qcm2290.yaml   | 116 ++++++++++++++++++
> >  .../dt-bindings/interconnect/qcom,qcm2290.h   |  94 ++++++++++++++
> >  2 files changed, 210 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> >  create mode 100644 include/dt-bindings/interconnect/qcom,qcm2290.h
> > 
> > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> > new file mode 100644
> > index 000000000000..fb5e62196d9a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/interconnect/qcom,qcm2290.yaml
> > @@ -0,0 +1,116 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/interconnect/qcom,qcm2290.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Qualcomm QCM2290 Network-On-Chip interconnect
> > +
> > +maintainers:
> > +  - Shawn Guo <shawn.guo@linaro.org>
> > +
> > +description: |
> > +  The Qualcomm QCM2290 interconnect providers support adjusting the
> > +  bandwidth requirements between the various NoC fabrics.
> > +
> > +properties:
> > +  reg:
> > +    maxItems: 1
> > +
> > +  compatible:
> > +    enum:
> > +      - qcom,qcm2290-bimc
> > +      - qcom,qcm2290-cnoc
> > +      - qcom,qcm2290-snoc
> > +      - qcom,qcm2290-qup-virt
> > +      - qcom,qcm2290-mmrt-virt
> > +      - qcom,qcm2290-mmnrt-virt
> > +
> > +  '#interconnect-cells':
> > +    const: 1
> > +
> > +  clock-names:
> > +    items:
> > +      - const: bus
> > +      - const: bus_a
> > +
> > +  clocks:
> > +    items:
> > +      - description: Bus Clock
> > +      - description: Bus A Clock
> > +
> > +required:
> > +  - compatible
> > +  - '#interconnect-cells'
> > +  - clock-names
> > +  - clocks
> > +
> > +additionalProperties: true
> 
> Nope. You have to define the child nodes.

Thanks for spotting it!  Will fix.

> Though the 'virt' looks 
> suspicious. 

They are interconnect providers which do not have a separate QoS
register space, but do have corresponding bus clocks to scale.  They are
named as 'virt' by following downstream and qcom,rpmh.yaml binding.

Shawn
