Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7445100E7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 16:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351714AbiDZOxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 10:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351708AbiDZOw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:52:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61CA140A37
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:49:48 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg25so10660666wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 07:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RLGWU04c675XlHK6myuRCpBGcz37JKCbqjttUkQFES0=;
        b=GCHLhzgWRijFMtvDIhvF6Xefj9n/89975AJj1eZC9ENu6LdHtKNuwzPoa4y4msL63j
         yzqPOcXjls1/Y/kQLIxN61hvrPrHb8QGvYc6LyeqXQtLAsjQSXSTbPL//zBTw+AxvpzZ
         NeRHRiYvgpmpU8U0pw7bJOsI6pLoWrj/CMpcwUjrzdtMVeOb3BeddCmWS0qx4MAF/F0T
         H6QKqIvkRTZy0zcKoPxgN39AYWX7PFxwPAdpSeMOQ5QNKvW8SmIJoj5TvTOxVVpZOA8R
         lUgC95aGT3pPiW/F0hUuKgCShxOKs1TwARYm1yP9fzrtvQDcNlikLsnHA05mROc1Kphl
         Gk5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RLGWU04c675XlHK6myuRCpBGcz37JKCbqjttUkQFES0=;
        b=3sqmavsWFIw8iXw60l+aaGk/KKOqe5P/TZvrtCCZ/fL00kHYsV6P7pEyBFJP++ewC0
         Qy6wVd/hXfLqItQG0vEcO0KjWqItJLJZqPoqg/y+gpxk+LILroY6U82M0nolGe5sAEnD
         6UaVUbR9PtX7MYmFCZANO+M7Q1YHxzcGkyLh7EGCsRLjCYz4qlaDEzvGq2pdT0631769
         Tpp6gYrmBaktVRMwcz1y/+Sp2i4tsWIeHzpHTH8IF9AjO3QAm4ktuQdvST/JnwSGdx2w
         iuZ2frpd+gtLuGGF1XXPJHvLGUMU4iFJu4v/Cknz3Quq5Afi0001K3oqbnTu8C2sa7Dm
         /LhQ==
X-Gm-Message-State: AOAM532XoEfCqofgHMjtNqR7Ld1ZQzl9heXfV9g9HtcsCuEnJTxlxGl7
        CqqLsr3xczeF/VgE5b/2GKGUXA==
X-Google-Smtp-Source: ABdhPJwpFyU97+6FmiY+PACooSx+7HoLi14xLzDXm/7xn/H2+QjgPDLvDKPlQxqggw2HUQrD3rHqhA==
X-Received: by 2002:a05:600c:2f0f:b0:393:fbd1:cc94 with SMTP id r15-20020a05600c2f0f00b00393fbd1cc94mr1960732wmn.162.1650984586898;
        Tue, 26 Apr 2022 07:49:46 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id e12-20020a056000178c00b0020aaf8d351bsm11338068wrg.103.2022.04.26.07.49.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 07:49:46 -0700 (PDT)
Date:   Tue, 26 Apr 2022 15:49:44 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peter Rosin <peda@axentia.se>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Drop undocumented i.MX iomuxc-gpr bindings
 in examples
Message-ID: <YmgGiNCzluNpJOiE@google.com>
References: <20220422192121.2592030-1-robh@kernel.org>
 <YmZUko/EQkKl6Npl@google.com>
 <Ymf+OmNBaZ+7OrxD@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ymf+OmNBaZ+7OrxD@robh.at.kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Apr 2022, Rob Herring wrote:

> On Mon, Apr 25, 2022 at 08:58:10AM +0100, Lee Jones wrote:
> > On Fri, 22 Apr 2022, Rob Herring wrote:
> > 
> > > The i.MX iomuxc-gpr bindings are undocumented and a mess. Drop their use
> > > from the examples.
> > > 
> > > The problem with the binding beyond the just random variations is that
> > > the iomuxc-gpr is not a separate block, but registers within the iomuxc
> > > block containing random leftover controls. As a separate DT node, it
> > > creates nodes with overlapping memory addresses.
> > > 
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/mfd/syscon.yaml  | 8 --------
> > >  Documentation/devicetree/bindings/mux/reg-mux.yaml | 1 -
> > >  2 files changed, 9 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > > index 13baa452cc9d..fb784045013f 100644
> > > --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> > > +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> > > @@ -100,12 +100,4 @@ examples:
> > >          compatible = "allwinner,sun8i-h3-system-controller", "syscon";
> > >          reg = <0x01c00000 0x1000>;
> > >      };
> > > -
> > > -  - |
> > > -    gpr: iomuxc-gpr@20e0000 {
> > > -        compatible = "fsl,imx6q-iomuxc-gpr", "syscon";
> > > -        reg = <0x020e0000 0x38>;
> > > -        hwlocks = <&hwlock1 1>;
> > > -    };
> > > -
> > >  ...
> > > diff --git a/Documentation/devicetree/bindings/mux/reg-mux.yaml b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > > index 60d5746eb39d..df4db96b5391 100644
> > > --- a/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > > +++ b/Documentation/devicetree/bindings/mux/reg-mux.yaml
> > > @@ -96,7 +96,6 @@ examples:
> > >  
> > >      #include <dt-bindings/mux/mux.h>
> > >      syscon@1000 {
> > > -        compatible = "fsl,imx7d-iomuxc-gpr", "fsl,imx6q-iomuxc-gpr", "syscon", "simple-mfd";
> > >          reg = <0x1000 0x100>;
> > 
> > Is leaving no compatible the correct solution here?
> 
> Documenting iomuxc-gpr is really the right one, but as I said it is a 
> mess and I'm not touching that.
> 
> But compatible is not really important in terms of what the example 
> shows. 
> 
> > Do we have another (working) platform that we can use in its place?
> 
> Not one for video muxing that I'm aware of.
> 
> > Does it make sense to leave the "syscon" and "simple-mfd" entries?
> 
> No, because we don't allow those on their own.

Very well.  I applied this for now.

... pending any fall-out from the Mux Maintainer. :)

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
