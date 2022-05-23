Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C67531265
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiEWN5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:57:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236786AbiEWN5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:57:14 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB77B5640D;
        Mon, 23 May 2022 06:57:11 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id r68so3678017oie.12;
        Mon, 23 May 2022 06:57:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Po7FG18ouzsaIFjxHouDmjoMSySPkXjz2dpCEjFO8eo=;
        b=KkM3K3kVdH+7ev8c1Eu0/vxsMhuzt0iqICeG6cqEkOx4Iy/lbGhdb1i87c1cWVQlqB
         tPqV4KcT2S+/z5yfeWNDsHb08GsGLzJ/LaDAopo0nbtctSP6HaBZ+Px1D3jtgP9fkwue
         f36FQmMYKQ2x9Una1bPkL7tFDhOGmqY3F4tR18e3FGwFCYfLR0DkCiVhzji9yyeicKD0
         UEYJoukndo3wQrxxHACS6ks/WTh7DBel3egNDeUbkb/o51a6MsyFrKeR3WrvJRpDraqH
         wbReb4qjbWDbwYNF8l8Joypx0/WAwvS9yZEMG5hjSvMRykyA1Nzf7Y/681D2Ikjj+/Wf
         xa/w==
X-Gm-Message-State: AOAM53245PhPqp5zGsvL3SdW520DR/0h2u0amU8ulspOSFvLtLTyleRd
        vgvR2+RKLs/hLjAzrR3wYg==
X-Google-Smtp-Source: ABdhPJwlzEkicwFPVbidQP0R1gspMyr9ArD/Z5ORMkC6y/9Bomvgsb1YW74/8oDH+BhWuSEvJmr8FQ==
X-Received: by 2002:aca:d8c5:0:b0:325:e353:a6b9 with SMTP id p188-20020acad8c5000000b00325e353a6b9mr10790833oig.135.1653314230773;
        Mon, 23 May 2022 06:57:10 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w12-20020a4ab6cc000000b0035eb4e5a6d0sm4190681ooo.38.2022.05.23.06.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:57:10 -0700 (PDT)
Received: (nullmailer pid 1499377 invoked by uid 1000);
        Mon, 23 May 2022 13:57:09 -0000
Date:   Mon, 23 May 2022 08:57:09 -0500
From:   Rob Herring <robh@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "coresight >> Coresight ML" <coresight@lists.linaro.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm: Convert CoreSight bindings to DT
 schema
Message-ID: <20220523135709.GB1385486-robh@kernel.org>
References: <20220520214416.302127-1-robh@kernel.org>
 <20220520214416.302127-2-robh@kernel.org>
 <9a9b40eb-be8d-bf8c-39be-e0abb507820f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a9b40eb-be8d-bf8c-39be-e0abb507820f@arm.com>
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

On Mon, May 23, 2022 at 12:03:36PM +0100, Suzuki K Poulose wrote:
> Hi Rob,
> 
> Thanks a lot for converting these to yaml. Some minor comments below.
> 
> In general, the "clocks" and "clock-names" are optional (e.g, for
> etm4 with system register access).

Reality, based on running dtbs_checks, seems to be that all 
instances have them, and the original doc said required.

> 
> On 20/05/2022 22:44, Rob Herring wrote:
> > Each CoreSight component has slightly different requirements and
> > nothing applies to every component, so each CoreSight component has its
> > own schema document.
> > 
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >   .../bindings/arm/arm,coresight-catu.yaml      | 101 +++++
> >   .../arm/arm,coresight-dynamic-funnel.yaml     | 126 ++++++
> >   .../bindings/arm/arm,coresight-etb10.yaml     |  92 ++++
> >   .../bindings/arm/arm,coresight-etm.yaml       | 156 +++++++
> >   .../arm/arm,coresight-static-replicator.yaml  |  90 ++++
> >   .../bindings/arm/arm,coresight-stm.yaml       | 101 +++++
> >   .../bindings/arm/arm,coresight-tmc.yaml       | 132 ++++++
> >   .../bindings/arm/arm,coresight-tpiu.yaml      |  91 ++++
> >   .../devicetree/bindings/arm/coresight.txt     | 402 ------------------
> >   9 files changed, 889 insertions(+), 402 deletions(-)
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-catu.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-dynamic-funnel.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etb10.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-etm.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-static-replicator.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-stm.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> >   create mode 100644 Documentation/devicetree/bindings/arm/arm,coresight-tpiu.yaml
> >   delete mode 100644 Documentation/devicetree/bindings/arm/coresight.txt
> 
> ...
> 
> > diff --git a/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> > new file mode 100644
> > index 000000000000..ee1ce47225be
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/arm,coresight-tmc.yaml
> > @@ -0,0 +1,132 @@
> > +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/arm/arm,coresight-tmc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Arm CoreSight Trace Memory Controller
> > +
> 
> ...
> 
> > +  out-ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    additionalProperties: false
> > +
> > +    properties:
> > +      port:
> > +        description: AXI Master output connection. Used for ETR and ETF
> > +          configurations.
> 
> nit: This is only for ETRs. Never for ETFs.

What about this example[1]? It's not AXI, but ATB actually.

Rob

[1] https://developer.arm.com/documentation/ddi0461/b/Introduction/Example-systems-with-different-configurations/ETF--ETR--and-TPIU
