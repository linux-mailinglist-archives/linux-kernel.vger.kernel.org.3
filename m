Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E37C4C7C22
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 22:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiB1Vhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 16:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbiB1Vhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 16:37:41 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBC314A202;
        Mon, 28 Feb 2022 13:37:00 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id f38so11421955ybi.3;
        Mon, 28 Feb 2022 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=49RK8fagkzciDmeTkIUa5Y3PaFfL+9gEC9qTeysrkEw=;
        b=Ghc7xyANaUfo3Im8KlGsbHeju/J021WzlgH1XO1+kLhmTwKg6MNa/M/s0wk0QZGJD2
         WjUQcbo2GTyyM6cVHIIb9e9UJTP337Megzc732e3+RfgCvGsevshLw4O34Gev3WM9Iof
         jZ9ksLwhVpDHok8/b5/Ly+5YDywsL852fI5vux7vHc+fQI8lZCjYNvPK673nxBFRIfl4
         7e3X/tHZc+ya/S4KDiIWv0NZha6Npmbx8L7oja3t6QFEaRjqZXocKTnUfcBt7Ucn1/ln
         vA5Un2vuavYPXjxyxs5n/554nrZ76YNRQrSFbKgxNC70ATbbWqtoqSc7npPg4n7T2cNi
         tuVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=49RK8fagkzciDmeTkIUa5Y3PaFfL+9gEC9qTeysrkEw=;
        b=UjZH0xD1t6TTIuydXMPLjBdsq438Ra57QyApn38ElD2uiVumk3dA5fjOEKgxrCQ+E1
         ggRbGvSqog/eCEVvsfvtRtxR66N90qsG+QrkA24ZVqPBBgBcceK4xq58ah/ylVjgD9/Q
         B0EA2dDBnlOBPs8ZeE4Oh4W0/UuvVflmV/5t1Z/oCqOkH8hQW7ORnU5s501b1bfoot4O
         4vHGGn2XSNYt9dy0laNCDL0CZ3I5hjVGGoihyCgnAYYNHy5cHRRu15jaikBtPaIrQ9JC
         9bOjv5ej0phPeaD3L4D+2n4vdaOtt5WrFxqj77p61YS97ypWF4eXMxPhXioMl+83FRj/
         BSXQ==
X-Gm-Message-State: AOAM533REdvPyr5RU0/05Q0b7i5pwBX6R4TzcyjMezoHx28p7Vwz79r8
        KEDRl4FavDB/cgcWJaPChLqBTYpErvxS7PmIFPc=
X-Google-Smtp-Source: ABdhPJwiasc5SG6oyWvTcvWy37s6zd5KJrMwEeLlNDItpQ1esBIXssG8lOe7GAJYo0dA1LW/S2a+CMvmww/+rJBVEx4=
X-Received: by 2002:a25:268c:0:b0:624:b515:5859 with SMTP id
 m134-20020a25268c000000b00624b5155859mr10899928ybm.232.1646084220065; Mon, 28
 Feb 2022 13:37:00 -0800 (PST)
MIME-Version: 1.0
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
 <20220208091326.12495-3-yifeng.zhao@rock-chips.com> <CAL_Jsq+1ixfw4+pwPcM5azPdC_4_bYCPu50jUvKnVMr6dSncpA@mail.gmail.com>
In-Reply-To: <CAL_Jsq+1ixfw4+pwPcM5azPdC_4_bYCPu50jUvKnVMr6dSncpA@mail.gmail.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 28 Feb 2022 16:36:48 -0500
Message-ID: <CAMdYzYryTb4Gvv3XENgUOSrutr7S-5a7GOMRahXWWZOeL1qKWA@mail.gmail.com>
Subject: Re: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY bindings
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Yifeng Zhao <yifeng.zhao@rock-chips.com>, Vinod <vkoul@kernel.org>,
        "heiko@sntech.de" <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        devicetree <devicetree@vger.kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GENERIC PHY FRAMEWORK" <linux-phy@lists.infradead.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Liang Chen <cl@rock-chips.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Lee Jones <lee.jones@linaro.org>, wulf <wulf@rock-chips.com>,
        David Wu <david.wu@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 2:18 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Feb 8, 2022 at 3:15 AM Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote:
> >
> > Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> >
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > ---
> >
> > Changes in v8: None
> > Changes in v7:
> > - remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
> >
> > Changes in v5:
> > - modify description for ssc and ext-refclk
> > - remove apb reset
> >
> > Changes in v4:
> > - restyle
> > - remove some minItems
> > - add more properties
> > - remove reset-names
> > - move #phy-cells
> > - add rockchip,rk3568-pipe-grf
> > - add rockchip,rk3568-pipe-phy-grf
> >
> > Changes in v3: None
> > Changes in v2:
> > - Fix dtschema/dtc warnings/errors
> >
> >  .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
>
> This now fails in linux-next:
>
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
> syscon@fdc50000: compatible: 'oneOf' conditional failed, one must be
> fixed:
>  ['rockchip,rk3568-pipe-grf', 'syscon'] is too short
>  'rockchip,rk3568-pipe-grf' is not one of ['rockchip,rk3288-sgrf',
> 'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
> syscon@fdc70000: compatible: 'oneOf' conditional failed, one must be
> fixed:
>  ['rockchip,rk3568-pipe-phy-grf', 'syscon'] is too short
>  'rockchip,rk3568-pipe-phy-grf' is not one of ['rockchip,rk3288-sgrf',
> 'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
> From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
>
>
> The problem appears to be that patch 1 was applied incorrectly and the
> compatibles ended up in the wrong section (the one requiring
> 'simple-mfd'). Patch 1 probably conflicts as my bot will just skip the
> patch if it conflicts which is why this had a different error report.

Good Afternoon Rob,

This is fixed in the first patch of my rk356x dwc3 enablement series:
https://patchwork.kernel.org/project/linux-rockchip/patch/20220228135700.1089526-2-pgwipeout@gmail.com/

Very Respectfully,
Peter Geis

>
> Rob
>
> _______________________________________________
> Linux-rockchip mailing list
> Linux-rockchip@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-rockchip
