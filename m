Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A604ED3B6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:05:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbiCaGHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiCaGHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:07:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81E81DC9A0;
        Wed, 30 Mar 2022 23:05:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 99D63B81EA0;
        Thu, 31 Mar 2022 06:05:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AFDC340ED;
        Thu, 31 Mar 2022 06:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648706743;
        bh=QQKn+Kv4FLipNOaxDBLqAUQ//ylLu2B/5Kt8RPNpRr4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fbInko8+mnPe6uxn0w7FVcGvtXjG+NE7LfwKIopJqKNt8OPhQaDArQMOt0qc8ge/t
         SLJoRK0tMmLrcbeSgGx6LtbRXc8qtzM/Be2+YkRBVmStrHi/VT2RMl8o14WGcwx1J1
         zIDZcTJU56GTnvNNDIk5SSzqqRj2OoHAvFlc+Ikjj0lNDPH349iGDORgJ2OWtMJ6Xp
         P4kxh8gOv+wANKWvGjqEzWIMsPOvxgiIapuvkjPBGGBJhdwDPwJpTiPXotmDdOjYKa
         QG96BQbQl0Ih7K5swrwEPWAXi7Kv402R/xuxng8j/zVMCxB4oigcKrQP4ENgLueBlf
         IUWluFcNjF4HQ==
Date:   Thu, 31 Mar 2022 11:35:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh@kernel.org>
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
Message-ID: <YkVEsqiRamfTmNi0@matsya>
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya>
 <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
 <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
 <YkKmPSesQfS6RLCD@matsya>
 <YkMrPnRbsl3FBig8@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkMrPnRbsl3FBig8@robh.at.kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-03-22, 10:52, Rob Herring wrote:
> On Tue, Mar 29, 2022 at 12:01:52PM +0530, Vinod Koul wrote:
> > On 28-03-22, 13:21, Rob Herring wrote:
> > > On Mon, Mar 28, 2022 at 12:18 PM Krzysztof Kozlowski
> > > <krzysztof.kozlowski@linaro.org> wrote:
> > > >
> > > > On 28/03/2022 19:16, Vinod Koul wrote:
> > > > > On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> > > > >> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> > > > >> <krzysztof.kozlowski@linaro.org> wrote:
> > > > >>>
> > > > >>> The DSI node is not a bus and the children do not have unit addresses.
> > > > >>>
> > > > >>> Reported-by: Vinod Koul <vkoul@kernel.org>
> > > > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > > >>
> > > > >> NAK.
> > > > >> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> > > > >> This is the convention used by other platforms too (see e.g.
> > > > >> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> > > > >
> > > > > So we should add reg = 0, i will update my dtsi fix
> > > > >
> > > >
> > > > To "ports" node? No. The reg=0 is for children of the bus, so the
> > > > panels. How to combine both without warnings - ports and panel@0 - I
> > > > don't know yet...
> > > 
> > > I don't think that should case a warning. Or at least it's one we turn off.
> > 
> > Well in this case I think we might need a fix:
> > Here is the example quoted in the binding. We have ports{} and then the
> > two port@0 and port@1 underneath.
> 
> It's the #address-cells/#size-cells under 'ports' that applies to 'port' 
> nodes. As 'ports' has no address (reg) itself, it doesn't need 
> #address-cells/#size-cells in its parent node.
> 
> > 
> > So it should be okay to drop #address-cells/#size-cells from dsi node
> > but keep in ports node...
> 
> Yes.
> 
> > Thoughts...?
> 
> But I thought a panel@0 node was being added? If so then you need to add 
> them back.

I guess we should make this optional, keep it when adding panel@0 node
and skip for rest where not applicable..? Dmitry is that fine with you?

-- 
~Vinod
