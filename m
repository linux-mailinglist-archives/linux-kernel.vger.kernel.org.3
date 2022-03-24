Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B50C24E648B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 14:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350703AbiCXN7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 09:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiCXN73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 09:59:29 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B78044C427;
        Thu, 24 Mar 2022 06:57:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id BD17E1F45386
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648130276;
        bh=pN1jpxdf4LxqwDnLQ6UhkLVGWH/ctyBoW4i84SPXeMA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LG/O86QDXq0SgsEO7Pa0W0HufhfQSIhOe0IVzNpYwjc1m5/B2GAxWiXJSqWRfTqzZ
         FyLHZy7Eqxma6zRMLOx36OGjqClNiIRA21Fo95pC+biCGT8WwT97yGxjbSM+uT1Y/z
         2AMT/H89sNaJEMSB/dl+kiRWJjrnXvx5rEukPBHwPiA1Ax5czAiSjQRMJikaKbDOtP
         xiV835X0ZE+KDqnzg45WYO8L4jBiKDO4HSsve7j4+lSRVczDZXlyaNpKQUHuwDaeKP
         Eff4EkTIO1FyU/zFkNl5SEsl2MC220wsOq6pPpB88Yy/uSEAbEKMRgjOYPLC++pVPo
         nRUaMQMSNYHmg==
Date:   Thu, 24 Mar 2022 09:57:50 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v4 08/22] arm64: dts: mt8192: Add infracfg_rst node
Message-ID: <20220324135750.652j2qwjz5lkwejs@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-9-allen-kh.cheng@mediatek.com>
 <20220322215754.j2hzutm775hvr25n@notapiano>
 <17bc30c64db3f3280993669a39edf3a11f76fb68.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <17bc30c64db3f3280993669a39edf3a11f76fb68.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 02:27:00PM +0800, allen-kh.cheng wrote:
> Hi Nícolas,
> 
> On Tue, 2022-03-22 at 17:57 -0400, Nícolas F. R. A. Prado wrote:
> > Hi Allen,
> > 
> > please see my comment below.
> > 
> > On Fri, Mar 18, 2022 at 10:45:20PM +0800, Allen-KH Cheng wrote:
> > > Add infracfg_rst node for mt8192 SoC.
> > >  - Add simple-mfd to allow probing the ti,syscon-reset node.
> > > 
> > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index 40cf6dacca3e..82de1af3f6aa 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > @@ -12,6 +12,7 @@
> > >  #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> > >  #include <dt-bindings/phy/phy.h>
> > >  #include <dt-bindings/power/mt8192-power.h>
> > > +#include <dt-bindings/reset/ti-syscon.h>
> > >  
> > >  / {
> > >  	compatible = "mediatek,mt8192";
> > > @@ -267,10 +268,23 @@
> > >  			#clock-cells = <1>;
> > >  		};
> > >  
> > > -		infracfg: syscon@10001000 {
> > > -			compatible = "mediatek,mt8192-infracfg",
> > > "syscon";
> > > +		infracfg: infracfg@10001000 {
> > > +			compatible = "mediatek,mt8192-infracfg",
> > > "syscon", "simple-mfd";
> > >  			reg = <0 0x10001000 0 0x1000>;
> > >  			#clock-cells = <1>;
> > > +
> > > +			infracfg_rst: reset-controller {
> > > +				compatible = "ti,syscon-reset";
> > > +				#reset-cells = <1>;
> > > +
> > > +				ti,reset-bits = <
> > > +					0x120 0 0x124 0 0 0	(ASSERT_SET
> > > | DEASSERT_SET | STATUS_NONE) /* 0: lvts_ap */
> > > +					0x730 12 0x734 12 0 0	(AS
> > > SERT_SET | DEASSERT_SET | STATUS_NONE) /* 1: lvts_mcu */
> > > +					0x140 15 0x144 15 0 0	(AS
> > > SERT_SET | DEASSERT_SET | STATUS_NONE) /* 2: pcie phy */
> > > +					0x730 1 0x734 1 0 0	(ASSERT_SET
> > > | DEASSERT_SET | STATUS_NONE) /* 3: pcie top */
> > > +					0x150 5 0x154 5 0 0	(ASSERT_SET
> > > | DEASSERT_SET | STATUS_NONE) /* 4: svs */
> > > +				>;
> > 
> > If you see [1], Rob has previously said that there shouldn't be new
> > users of the
> > ti,reset-bits property. I suggest doing like proposed on [2]: moving
> > these bit
> > definitions to the reset-ti-syscon driver, and have them selected
> > through the
> > compatible. You'd need to add a mt8192 specific compatible here too
> > for that.
> > 
> > [1] 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/CAL_JsqJq6gqoXtvG1U7UDsOQpz7oMLMunZHq2njN6nvPr8PZMA@mail.gmail.com/__;!!CTRNKA9wMg0ARbw!1wQAhHnu8bAxe2O51XZ61oWVQU7EFEZcgluzwgP4x4VHRxtb6kAySvsKCGzv8cs8IzVjanDNzBQvOa_Y4OABdRVOzg$
> >  
> > [2] 
> > https://urldefense.com/v3/__https://lore.kernel.org/all/CAATdQgA5pKhjOf5gxo*h7cs7kCts3DeKGU5axeX2t*OaJFHyBg@mail.gmail.com/__;Kys!!CTRNKA9wMg0ARbw!1wQAhHnu8bAxe2O51XZ61oWVQU7EFEZcgluzwgP4x4VHRxtb6kAySvsKCGzv8cs8IzVjanDNzBQvOa_Y4OBLvOYlyQ$
> >  
> > 
> > Thanks,
> > Nícolas
> > 
> 
> Thanks for your comment.
> 
> For nfracfg_rst node, I prefer remove it from this series and
> send another patch series(dts and driver).

Yes, that sounds the best approach to me as well.

> 
> Based on [2], is it ok that we can add mt8192 compatible in reset-ti
> syscon driver? (even if mt8192 is a mediatek platform)

Actually, I think there's an even better way of handling this. Instead of using
the TI syscon reset controller, you could give reset controller capabilities to
the infracfg node directly. This means adding reset controller support to the
common mtk clock driver (clk-mtk.c) and registering the reset controller on
clk-mt8192.c for infracfg. By making this common code you'll also be able to
reuse it for mt8195 as well. And there would no longer be a infracfg_rst node.

Thanks,
Nícolas

> 
> best regards,
> Allen
> 
> > > +			};
> > >  		};
> > >  
> > >  		pericfg: syscon@10003000 {
> > > -- 
> > > 2.18.0
> > > 
> > > 
> 
