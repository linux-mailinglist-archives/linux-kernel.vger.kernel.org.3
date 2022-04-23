Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A192050C6E2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 05:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiDWDRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 23:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232414AbiDWDQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 23:16:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AEC0C60;
        Fri, 22 Apr 2022 20:13:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4CDECB8335D;
        Sat, 23 Apr 2022 03:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01299C385A0;
        Sat, 23 Apr 2022 03:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650683630;
        bh=cAjB3SwesxGlhRGXCKftp+OPMZZqvtJP/UCppIG/HvA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=OP0hdxPZNSvivrDZoK0G6hQtq+j61ny5knTMEfFwL0Con60lrQ1oaYhaVVB7LJ79V
         4baTC7tvXP6FwN2rTlcdvLumGdhHfS5Qp7ChLxmqiIWwFSto95M54Hr22HFEufPOH9
         wcvdrNcMMsrwnBUx9GgqLbmL4vCFpwta7TugRPl/HoeVcjHIbDoovqdeEPo1Giy4xz
         BI+QlrKhBYdyynnPalzlwH7TZpHZYtEgXMlN0xYKK2g+gP05Im1V8alSHjBifY9ZvG
         dWicF5RDot33bfL5HKhXthcURnzQj2IVoal3mZGePG8EB32p2jltoqMle4zwgRtlb8
         pNAlaYY498otg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <YmNsYSxLtwLpw98t@ripper>
References: <20220422230013.1332993-1-bjorn.andersson@linaro.org> <20220423014824.912ACC385A0@smtp.kernel.org> <YmNsYSxLtwLpw98t@ripper>
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add Qualcomm SC8280XP GCC bindings
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_tdas@quicinc.com
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Date:   Fri, 22 Apr 2022 20:13:48 -0700
User-Agent: alot/0.10
Message-Id: <20220423031350.01299C385A0@smtp.kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-04-22 20:02:57)
> On Fri 22 Apr 18:48 PDT 2022, Stephen Boyd wrote:
>=20
> > Quoting Bjorn Andersson (2022-04-22 16:00:12)
> > > Add binding for the Qualcomm SC8280XP Global Clock controller.
> > >=20
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >=20
> > Why no cover letter?
> >=20
>=20
> I didn't have anything useful to write in it. Will provide you one in
> the future...

Thanks!

> > > +  clocks:
> > > +    items:
> > > +      - description: XO reference clock
> >=20
> > "clock" is redundant in all these descriptions. Please remove.
> >=20
>=20
> You don't think it's a little bit odd to have description such as
> "Sleep", "PCIe 2a pipe" or First EMAC controller reference"?
>=20
> I mean I agree that it's obviously clocks we're talking about, but to me
> that makes it seems like the descriptions are cut short, just for the
> sake of avoiding "clock".

Alright, keeping clock is OK as long as

>=20
> > > +      - description: Sleep clock
> > > +      - description: UFS memory first RX symbol clock
> > > +      - description: UFS memory second RX symbol clock
> > > +      - description: UFS memory first TX symbol clock
> > > +      - description: UFS card first RX symbol clock
> > > +      - description: UFS card second RX symbol clock
> > > +      - description: UFS card first TX symbol clock
> > > +      - description: Primary USB SuperSpeed pipe clock
> > > +      - description: gcc_usb4_phy_pipegmux_clk_src

there is a better name for this and the other non-word descriptions.

USB4 phy pipe gmux clock source?

> > > +      - description: gcc_usb4_phy_dp_gmux_clk_src
> > > +      - description: gcc_usb4_phy_sys_pipegmux_clk_src
> > > +      - description: usb4_phy_gcc_usb4_pcie_pipe_clk
> > > +      - description: usb4_phy_gcc_usb4rtr_max_pipe_clk
> > > +      - description: Primary USB4 RX0 clock
> > > +      - description: Primary USB4 RX1 clock
> > > +      - description: Secondary USB SuperSpeed pipe clock
> > > +      - description: gcc_usb4_1_phy_pipegmux_clk_src
> > > +      - description: gcc_usb4_1_phy_dp_gmux_clk_src
> > > +      - description: gcc_usb4_1_phy_sys_pipegmux_clk_src
> > > +      - description: usb4_1_phy_gcc_usb4_pcie_pipe_clk
> > > +      - description: usb4_1_phy_gcc_usb4rtr_max_pipe_clk
> > > +      - description: Secondary USB4 RX0 clock
> > > +      - description: Secondary USB4 RX0 clock
> > > +      - description: Multiport USB first SupserSpeed pipe clock
> > > +      - description: Multiport USB second SuperSpeed pipe clock
> > > +      - description: PCIe 2a pipe clock
> > > +      - description: PCIe 2b pipe clock
> > > +      - description: PCIe 3a pipe clock
> > > +      - description: PCIe 3b pipe clock
> > > +      - description: PCIe 4 pipe clock
> > > +      - description: First EMAC controller reference clock
> > > +      - description: Second EMAC controller reference clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: bi_tcxo
> > > +      - const: sleep_clk
> >=20
> > And "_clk" postfix is redundant in all these strings. Remove?
> >=20
>=20
> In this case I think they should include _clk, as they actually matches
> the clock names in the documentation.
>=20

I'd really rather not have clock-names at all because we spend a bunch
of time comparing strings with them when we could just as easily use
a number.
