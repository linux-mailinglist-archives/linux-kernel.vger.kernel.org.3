Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14EE74EB112
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238921AbiC2PyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 11:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238845AbiC2PyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 11:54:16 -0400
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43CEF22C8C2;
        Tue, 29 Mar 2022 08:52:33 -0700 (PDT)
Received: by mail-ot1-f54.google.com with SMTP id k25-20020a056830151900b005b25d8588dbso13028326otp.4;
        Tue, 29 Mar 2022 08:52:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=53EmT+0Iq+omqog9hMr5TTHzAfJsIFc7d5dRnXaOt/M=;
        b=bQCYhcqHZiYofvN3bGLNEHdT+KCxqODKi2B0KxWgSr8IEntcla+T/YLOMXgZ5cIp+B
         axJkPqYxHweWspaR19k1iEmNetpgG7BznONpH/lZ30zn5jx9mGhvInuHVdgWfafrkvNB
         h5v0O8eiO5R+MyHTzjQBmax57MLyXXbhabG2upDphiqTMQ5jA+NxlkLrKjIGC+74tqbB
         DQ9I9D9oBHfC4amNQaWkYABHpyxksOyOTFAli144OWi61tRXcG8ICIM9/38LersN/Wau
         xz6jYqrMN8Afx42yGZCS4TIdw255b04bQ3Z0B1QMdzkMlpUf2XaK1gZDPw1sm7yQXejP
         qhuw==
X-Gm-Message-State: AOAM532CsLyzPrWAVz5RswYyXAbf00ZXTIiI9MW8LAwGyzIv1Lpv5aTN
        YgrCByg8tDmC9pJyn2EZnOo/Nl3NGw==
X-Google-Smtp-Source: ABdhPJxC5Hfm9CPFftdhNmRBujVYhVRHBBUN06bjxcKnKO/caVZGn/GJf5+6eZLXAAmSoxm06F8jyA==
X-Received: by 2002:a9d:1991:0:b0:5cd:b2a1:5c50 with SMTP id k17-20020a9d1991000000b005cdb2a15c50mr1389734otk.217.1648569152513;
        Tue, 29 Mar 2022 08:52:32 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w7-20020a9d6387000000b005b2265711fcsm7520205otk.16.2022.03.29.08.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 08:52:31 -0700 (PDT)
Received: (nullmailer pid 753124 invoked by uid 1000);
        Tue, 29 Mar 2022 15:52:30 -0000
Date:   Tue, 29 Mar 2022 10:52:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dt-bindings: display: msm: dsi: remove address/size cells
Message-ID: <YkMrPnRbsl3FBig8@robh.at.kernel.org>
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya>
 <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
 <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
 <YkKmPSesQfS6RLCD@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkKmPSesQfS6RLCD@matsya>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 12:01:52PM +0530, Vinod Koul wrote:
> On 28-03-22, 13:21, Rob Herring wrote:
> > On Mon, Mar 28, 2022 at 12:18 PM Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> > >
> > > On 28/03/2022 19:16, Vinod Koul wrote:
> > > > On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> > > >> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> > > >> <krzysztof.kozlowski@linaro.org> wrote:
> > > >>>
> > > >>> The DSI node is not a bus and the children do not have unit addresses.
> > > >>>
> > > >>> Reported-by: Vinod Koul <vkoul@kernel.org>
> > > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > >>
> > > >> NAK.
> > > >> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> > > >> This is the convention used by other platforms too (see e.g.
> > > >> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> > > >
> > > > So we should add reg = 0, i will update my dtsi fix
> > > >
> > >
> > > To "ports" node? No. The reg=0 is for children of the bus, so the
> > > panels. How to combine both without warnings - ports and panel@0 - I
> > > don't know yet...
> > 
> > I don't think that should case a warning. Or at least it's one we turn off.
> 
> Well in this case I think we might need a fix:
> Here is the example quoted in the binding. We have ports{} and then the
> two port@0 and port@1 underneath.

It's the #address-cells/#size-cells under 'ports' that applies to 'port' 
nodes. As 'ports' has no address (reg) itself, it doesn't need 
#address-cells/#size-cells in its parent node.

> 
> So it should be okay to drop #address-cells/#size-cells from dsi node
> but keep in ports node...

Yes.

> Thoughts...?

But I thought a panel@0 node was being added? If so then you need to add 
them back.

Rob
