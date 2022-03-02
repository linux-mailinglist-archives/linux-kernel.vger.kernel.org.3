Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775034C9F02
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:16:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240040AbiCBIQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240031AbiCBIQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:16:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52305B7C44;
        Wed,  2 Mar 2022 00:16:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 12568B81ED1;
        Wed,  2 Mar 2022 08:16:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D631C004E1;
        Wed,  2 Mar 2022 08:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646208965;
        bh=XZmYOYtMmwo2P8dkntVlx9JQ2MUJP9KNkRguDCErpIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WDCy5Z6KWGROQHThae/yU5BrZuHCU9dZq/2cNdJdxg0V6Hof+D1ToifbE+FwwAKyT
         2iOaaD0IXi1xgmb1cngtu9WMV3lT8d/4J0FL3zIA2b/5105dRtABUPKpUUf6gsR+y1
         Doh3hXkIwRcc/p/nl2D/FXKuXkberO3ONKsPSJklPVple89omC2Esp1QSpDKyzYpnL
         fG2EE0PjfADIMl8BgAylOqpqEODALYuX8juYiooud5uzVB7tsy28W94dO12MBnZU51
         fs7Kn3MUkc0QNs+nxPJTUeXZYFN9VI3FOZAQTWfvSyHd8lp/nIYWPFcczFJ9n2QEzd
         Jdr+OcECbqWfg==
Date:   Wed, 2 Mar 2022 13:46:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>,
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
Subject: Re: [PATCH v8 2/4] dt-bindings: phy: rockchip: Add Naneng combo PHY
 bindings
Message-ID: <Yh8nwS7iAKgJZeFa@matsya>
References: <20220208091326.12495-1-yifeng.zhao@rock-chips.com>
 <20220208091326.12495-3-yifeng.zhao@rock-chips.com>
 <CAL_Jsq+1ixfw4+pwPcM5azPdC_4_bYCPu50jUvKnVMr6dSncpA@mail.gmail.com>
 <CAMdYzYryTb4Gvv3XENgUOSrutr7S-5a7GOMRahXWWZOeL1qKWA@mail.gmail.com>
 <CAL_JsqLsLU5-bJVRWv_TzGUZdFHOx7tdzqV2piNfacNkXg=zww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLsLU5-bJVRWv_TzGUZdFHOx7tdzqV2piNfacNkXg=zww@mail.gmail.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01-03-22, 08:06, Rob Herring wrote:
> On Mon, Feb 28, 2022 at 3:37 PM Peter Geis <pgwipeout@gmail.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 2:18 PM Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > On Tue, Feb 8, 2022 at 3:15 AM Yifeng Zhao <yifeng.zhao@rock-chips.com> wrote:
> > > >
> > > > Add the compatible strings for the Naneng combo PHY found on rockchip SoC.
> > > >
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
> > > > Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> > > > ---
> > > >
> > > > Changes in v8: None
> > > > Changes in v7:
> > > > - remove u3otg0_port_en, u3otg1_port_en and pipe_sgmii_mac_sel
> > > >
> > > > Changes in v5:
> > > > - modify description for ssc and ext-refclk
> > > > - remove apb reset
> > > >
> > > > Changes in v4:
> > > > - restyle
> > > > - remove some minItems
> > > > - add more properties
> > > > - remove reset-names
> > > > - move #phy-cells
> > > > - add rockchip,rk3568-pipe-grf
> > > > - add rockchip,rk3568-pipe-phy-grf
> > > >
> > > > Changes in v3: None
> > > > Changes in v2:
> > > > - Fix dtschema/dtc warnings/errors
> > > >
> > > >  .../phy/phy-rockchip-naneng-combphy.yaml      | 109 ++++++++++++++++++
> > > >  1 file changed, 109 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.yaml
> > >
> > > This now fails in linux-next:
> > >
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
> > > syscon@fdc50000: compatible: 'oneOf' conditional failed, one must be
> > > fixed:
> > >  ['rockchip,rk3568-pipe-grf', 'syscon'] is too short
> > >  'rockchip,rk3568-pipe-grf' is not one of ['rockchip,rk3288-sgrf',
> > > 'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
> > > From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > > /builds/robherring/linux-dt/Documentation/devicetree/bindings/phy/phy-rockchip-naneng-combphy.example.dt.yaml:
> > > syscon@fdc70000: compatible: 'oneOf' conditional failed, one must be
> > > fixed:
> > >  ['rockchip,rk3568-pipe-phy-grf', 'syscon'] is too short
> > >  'rockchip,rk3568-pipe-phy-grf' is not one of ['rockchip,rk3288-sgrf',
> > > 'rockchip,rk3568-usb2phy-grf', 'rockchip,rv1108-usbgrf']
> > > From schema: /builds/robherring/linux-dt/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
> > >
> > >
> > > The problem appears to be that patch 1 was applied incorrectly and the
> > > compatibles ended up in the wrong section (the one requiring
> > > 'simple-mfd'). Patch 1 probably conflicts as my bot will just skip the
> > > patch if it conflicts which is why this had a different error report.
> >
> > Good Afternoon Rob,
> >
> > This is fixed in the first patch of my rk356x dwc3 enablement series:
> > https://patchwork.kernel.org/project/linux-rockchip/patch/20220228135700.1089526-2-pgwipeout@gmail.com/
> 
> Where does that say Vinod incorrectly applied the original patch and
> needs to apply it? What's the status of the series? Do we have to wait
> for the rest of the series to be applied?

Thanks for pointing that out, I can revert this patch so that corrected
one can be applied... Does that look better

-- 
~Vinod
