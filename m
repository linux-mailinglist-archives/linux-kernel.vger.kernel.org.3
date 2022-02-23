Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41DA4C1635
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbiBWPMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:12:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiBWPM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:12:28 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65756E28F;
        Wed, 23 Feb 2022 07:12:00 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id AF9001F44A38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645629119;
        bh=ELPweJBc6ajob3F7Lui867O0B7uOutbKAFuyBG7+YpI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dRntzR73s7+bZmeaMg/SQxnWDBkL1AIhU6PAT8n/MPSuMwzDE8nUHna9JAKcikkdw
         aSy2WBCmWQ+vXwLyYfzNZIhhxk5buaVev1Xgps9sROqdLeua7TI+F9VlJEN0fA2VnG
         KnV6g/R3LZMyXjBwQe2BlD3oCA07ZwdA91ajkVZiBwt08PGs6y3HcdkNKBAONKJ8vT
         nj80NEBPGkw6ahUoP+pA6/prEYTa2vhG0K7q06uMuq0Bv58Lb6lYuEcb23SykAz0yE
         FMfmERBoqjWOfTEi+oeiwoj0TVXa+4ZlqgqSVNKKVkYJu0gcn9U0lfq75fjPLj4YV5
         EmUUwg8++EPuQ==
Date:   Wed, 23 Feb 2022 10:11:53 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        --to=Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>
Subject: Re: [PATCH v2 06/23] arm64: dts: mt8192: Add usb-phy node
Message-ID: <20220223151153.mjmo6vspg6cior2i@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-7-allen-kh.cheng@mediatek.com>
 <20220222201034.pb36pfrgujushsge@notapiano>
 <ef364c56deef3cc20d7d7d9ca6c568c0612c7a2a.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ef364c56deef3cc20d7d7d9ca6c568c0612c7a2a.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:24:12PM +0800, allen-kh.cheng wrote:
> On Tue, 2022-02-22 at 15:10 -0500, Nícolas F. R. A. Prado wrote:
> > On Fri, Feb 18, 2022 at 05:16:16PM +0800, Allen-KH Cheng wrote:
> > > Add xhci node for mt8192 SoC.
> > > 
> > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 25
> > > ++++++++++++++++++++++++
> > >  1 file changed, 25 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index 61aadd7bd397..ce18d692175f 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > @@ -875,6 +875,31 @@
> > >  			#clock-cells = <1>;
> > >  		};
> > >  
> > > +		u3phy0: usb-phy@11e40000 {
> > 
> > According to
> > Documentation/devicetree/bindings/phy/mediatek,tphy.yaml, this node
> > should be called t-phy. Only the child nodes should be usb-phy.
> > 
> Hi Nícolas,
> 
> I think it should be "u3phy0: t-phy@11e40000". am I right?

Yes, that's it.
