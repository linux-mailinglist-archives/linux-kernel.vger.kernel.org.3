Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED104640DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240752AbhK3WF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:05:27 -0500
Received: from mail-ot1-f49.google.com ([209.85.210.49]:45883 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbhK3WF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:05:26 -0500
Received: by mail-ot1-f49.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso32220606otf.12;
        Tue, 30 Nov 2021 14:02:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nyqqj0x2xxep7p7TFP8Hievf+hkLs5bt7I85nyKY2kA=;
        b=Gm1mpJWT5P97yskdaTY0ZiidHo4RAL6WClQ4+e7X3vUG5kcO8QWfsKUXqnlZkPN9Qk
         rFrK33y+XlOPf4lR2IWaMvDCEK4m9PcyBMZJHWVfJBM+zZes6TveNHeBGHWgjoWXql4B
         R3BH7awyUAeGaU3ySbw7+oFHGi+a1OtBeiglEDhCWT6yi2S2dGmUgQZLJGR/pNt8xCVE
         oTFRMHUnK8D9fYgkylzGis+p9bs3BZf6Qh7BRhbqZL6wpxtFVes3t6KpQ/wJHV8Frro9
         fBSOin0MzajLl0jC2d7MJe7y0QreKEkSGB6St654VwtKCNrMz86y0lAF47WCxYPchF6k
         sq0A==
X-Gm-Message-State: AOAM532IMIMJDtMAWss42qn2akHX38709Cbx9bfqVk7flJ2gIgDtxDhr
        7i/l0fEbG3vHYUH3QzWsgSBoZZ113A==
X-Google-Smtp-Source: ABdhPJyh2obM5pyW+RLRyFYGr02+ZnkGN+za3tNAplswfoYTEQGLXa8iULAw3rYFnLixvxdX2lFB+Q==
X-Received: by 2002:a9d:4f0e:: with SMTP id d14mr1856656otl.137.1638309726058;
        Tue, 30 Nov 2021 14:02:06 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r11sm3510242oth.48.2021.11.30.14.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 14:02:05 -0800 (PST)
Received: (nullmailer pid 3088815 invoked by uid 1000);
        Tue, 30 Nov 2021 22:02:04 -0000
Date:   Tue, 30 Nov 2021 16:02:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Roger Quadros <rogerq@kernel.org>, tony@atomide.com, kishon@ti.com,
        nm@ti.com, vigneshr@ti.com, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] dt-bindings: memory-controllers: ti,gpmc: Add
 compatible for AM64
Message-ID: <YaafXKXfzBQaNSvq@robh.at.kernel.org>
References: <20211123102607.13002-1-rogerq@kernel.org>
 <20211123102607.13002-2-rogerq@kernel.org>
 <a28532b1-bfa0-031b-91cc-070cad557599@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a28532b1-bfa0-031b-91cc-070cad557599@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 23, 2021 at 08:47:57PM +0100, Krzysztof Kozlowski wrote:
> On 23/11/2021 11:26, Roger Quadros wrote:
> > AM64 SoC contains the GPMC module. Add compatible for it.
> > 
> > Newer SoCs don't necessarily map GPMC data region at the same place
> > as legacy SoCs. Add reg-names "data", to provide this information to
> > the device driver.
> > 
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  .../bindings/memory-controllers/ti,gpmc.yaml         | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> > index 25b42d68f9b3..1869cc6f949b 100644
> > --- a/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> > +++ b/Documentation/devicetree/bindings/memory-controllers/ti,gpmc.yaml
> > @@ -23,13 +23,20 @@ properties:
> >      items:
> >        - enum:
> >            - ti,am3352-gpmc
> > +          - ti,am64-gpmc
> >            - ti,omap2420-gpmc
> >            - ti,omap2430-gpmc
> >            - ti,omap3430-gpmc
> >            - ti,omap4430-gpmc
> >  
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  reg-names:
> > +    items:
> > +      - const: cfg
> > +      - const: data
> 
> I see your driver handles cases with only one reg item, but I have other
> question - is it correct to have older (ARMv7) platform with two reg
> items? Or can am64-gpmc come with only one reg?
> IOW, I am surprised there is no if-else case precising this minItems
> requirement for different SocS.

I don't think that is needed here. If the assumption is 'reg-names' is 
only present when there are 2 entries, then it is fine. Maybe 
'reg-names' should be required for ti,am64-gpmc though.

Rob
