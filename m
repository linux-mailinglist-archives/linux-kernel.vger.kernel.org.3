Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E77604E9D36
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 19:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244520AbiC1RSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 13:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244582AbiC1RSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 13:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F3D84F9C2;
        Mon, 28 Mar 2022 10:16:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 32C7760C1A;
        Mon, 28 Mar 2022 17:16:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E380C340F0;
        Mon, 28 Mar 2022 17:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648487784;
        bh=o14EgBIuBc/4hkkPdrc5dpLxJVeRUhse87xGCCnnTtE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DkVASHPDf7Lp+C5wh52bc+X1BzB4Dao314D1FoJjWLbb5s+2hb6PJh1EVKiWtNiM3
         xQeX9+olf3lt0FAL0khKzGyPPLxwkE/+WFTFs/AFjdwl2tSMFjj43ubNPugBIFXZoh
         4/BR93Plhr7H35FHGEYD3qnM8N2t7SrD58TbBrEX8WGjDaQ5vedHSNYQ8WmdLkV1qY
         xmFjxJdZhMLglZQj4jrusVBPuQeje4TjzUEbMeRxyTPg58UjgS2iAVTAQgXVZSIgqa
         4i2CBGb4qY5kC2CuFCPmOgCxOzWmLhfInCj7/D0yWzdYT2ry+OfwzrldoVYs26kxg5
         Hre5eJTpqwytA==
Date:   Mon, 28 Mar 2022 22:46:19 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: msm: dsi: remove address/size cells
Message-ID: <YkHtY9absUjmqmW7@matsya>
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > The DSI node is not a bus and the children do not have unit addresses.
> >
> > Reported-by: Vinod Koul <vkoul@kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> NAK.
> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> This is the convention used by other platforms too (see e.g.
> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).

So we should add reg = 0, i will update my dtsi fix

> With the DSI split link it is possible to attach two panels to a
> single DSI host, so addresses are necessary.
> 
> > ---
> >  .../bindings/display/msm/dsi-controller-main.yaml          | 7 -------
> >  1 file changed, 7 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > index 7095ec3c890d..57f238f72326 100644
> > --- a/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > +++ b/Documentation/devicetree/bindings/display/msm/dsi-controller-main.yaml
> > @@ -51,10 +51,6 @@ properties:
> >    phy-names:
> >      const: dsi
> >
> > -  "#address-cells": true
> > -
> > -  "#size-cells": true
> > -
> >    syscon-sfpb:
> >      description: A phandle to mmss_sfpb syscon node (only for DSIv2).
> >      $ref: "/schemas/types.yaml#/definitions/phandle"
> > @@ -154,9 +150,6 @@ examples:
> >             reg = <0x0ae94000 0x400>;
> >             reg-names = "dsi_ctrl";
> >
> > -           #address-cells = <1>;
> > -           #size-cells = <0>;
> > -
> >             interrupt-parent = <&mdss>;
> >             interrupts = <4>;
> >
> > --
> > 2.32.0
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
~Vinod
