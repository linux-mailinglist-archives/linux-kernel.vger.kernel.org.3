Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40474EA7E2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiC2Gdo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiC2Gdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:33:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB608199E02;
        Mon, 28 Mar 2022 23:31:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8947EB815AA;
        Tue, 29 Mar 2022 06:31:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD40C2BBE4;
        Tue, 29 Mar 2022 06:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648535517;
        bh=qQdEegtTay97bdLFpDoQhHXRXAb8Gb7e6nlf1kKCkVk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XC8bQVeQEmhTJk/J+uyEhRZ4t4eJ4J5h0wqWTevizVDXWn0WM/OeI65K9IhfoPNoN
         W/xSTBLECpgkuX85RagScxcKu0QM6GQU305VIkG0DXsxm1UBzhrlI1J8KzgUOg7X+r
         WWX8Iq+sQjENxQt7jEzFKg9HhjAmk3lIVnPZbAlqdsx51JU4hhrUyCWmwqTHUbqQVx
         Ab7nb8ByDqBxvdE5F+Sv1BABrZjJ+BJOADiCxhioMsJehaF6xraVtQ85f7XJKCUh50
         LuXe+ALG9iGEORdqEf87r0r0dj1U8oEd8sX5JoOPp7pf1iNTsgJ9clgzrBcZ2A7rnb
         WUr0CD89snmVw==
Date:   Tue, 29 Mar 2022 12:01:52 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
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
Message-ID: <YkKmPSesQfS6RLCD@matsya>
References: <20220328152923.90623-1-krzysztof.kozlowski@linaro.org>
 <CAA8EJprWoxWwk5EWEfWdLquPR+2=u6V0-v1-+wHMHOk8HiEyNw@mail.gmail.com>
 <YkHtY9absUjmqmW7@matsya>
 <12b0056b-8032-452b-f325-6f36037b5a80@linaro.org>
 <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_Jsq+6rx0UU6ryH+z_8KLQqKKuhTCnh=Oft2F03bcze+EV0Q@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-03-22, 13:21, Rob Herring wrote:
> On Mon, Mar 28, 2022 at 12:18 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > On 28/03/2022 19:16, Vinod Koul wrote:
> > > On 28-03-22, 19:43, Dmitry Baryshkov wrote:
> > >> On Mon, 28 Mar 2022 at 18:30, Krzysztof Kozlowski
> > >> <krzysztof.kozlowski@linaro.org> wrote:
> > >>>
> > >>> The DSI node is not a bus and the children do not have unit addresses.
> > >>>
> > >>> Reported-by: Vinod Koul <vkoul@kernel.org>
> > >>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > >>
> > >> NAK.
> > >> DSI panels are children of the DSI device tree node with the reg = <0>; address.
> > >> This is the convention used by other platforms too (see e.g.
> > >> arch/arm64/boot/dts/freescale/imx8mq-evk.dts).
> > >
> > > So we should add reg = 0, i will update my dtsi fix
> > >
> >
> > To "ports" node? No. The reg=0 is for children of the bus, so the
> > panels. How to combine both without warnings - ports and panel@0 - I
> > don't know yet...
> 
> I don't think that should case a warning. Or at least it's one we turn off.

Well in this case I think we might need a fix:
Here is the example quoted in the binding. We have ports{} and then the
two port@0 and port@1 underneath.

So it should be okay to drop #address-cells/#size-cells from dsi node
but keep in ports node...

Thoughts...?


     dsi@ae94000 {
           compatible = "qcom,mdss-dsi-ctrl";
           reg = <0x0ae94000 0x400>;
           reg-names = "dsi_ctrl";

           #address-cells = <1>;
           #size-cells = <0>;

           interrupt-parent = <&mdss>;
           interrupts = <4>;

           clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
                    <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
                    <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
                    <&dispcc DISP_CC_MDSS_ESC0_CLK>,
                    <&dispcc DISP_CC_MDSS_AHB_CLK>,
                    <&dispcc DISP_CC_MDSS_AXI_CLK>;
           clock-names = "byte",
                         "byte_intf",
                         "pixel",
                         "core",
                         "iface",
                         "bus";

           phys = <&dsi0_phy>;
           phy-names = "dsi";

           assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>, <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
           assigned-clock-parents = <&dsi_phy 0>, <&dsi_phy 1>;

           power-domains = <&rpmhpd SC7180_CX>;
           operating-points-v2 = <&dsi_opp_table>;

           ports {
                  #address-cells = <1>;
                  #size-cells = <0>;

                  port@0 {
                          reg = <0>;
                          dsi0_in: endpoint {
                                   remote-endpoint = <&dpu_intf1_out>;
                          };
                  };

                  port@1 {
                          reg = <1>;
                          dsi0_out: endpoint {
                                   remote-endpoint = <&sn65dsi86_in>;
                                   data-lanes = <0 1 2 3>;
                          };
                  };
           };
     };

> 
> Rob

-- 
~Vinod
