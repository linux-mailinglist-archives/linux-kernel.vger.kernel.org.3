Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEDD34C166A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 16:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241775AbiBWPUz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 10:20:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbiBWPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 10:20:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8ECE39698;
        Wed, 23 Feb 2022 07:20:23 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id C18CE1F44A52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645629621;
        bh=jdy98UlpZp4yYyNgJgTnj63KiB3Y1ffMm1m1vA+HNuk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WzKloTRB2XvEBA4y+u09U1ZlRrBoMkal3rajxL1xbBRiChBpJgO4UshC+8GcqtZ87
         IVYDTYaISfOwenkbWeJZwk/COcmPKYI4QgbPW6VLS4vd5FmKe83KkVIO4iPRRe/zjf
         NuXEssJQsc6EKnfWuXz3hvmS8jzXcEYGXydpDFVMc3sLEJ2yuaViUjVa15+NXCAwID
         /g4KOtca9e94SvcqOP8w/XHr6shwyQ9XtLWLrnl0mF2RzMZ6X+zjAEE9Hps2KO1XwK
         lR9+WFlqWdjaJC3zIyGlgKiavlNw9Xy7CKgTF4y9vaioDK1KCyZVHWikWBiKMBPJDc
         8YgFE5sDFSnnQ==
Date:   Wed, 23 Feb 2022 10:20:15 -0500
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
        Ryder Lee <ryder.lee@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v2 22/23] arm64: dts: mt8192: Add gce info for display
 nodes
Message-ID: <20220223152015.vsuuycfvmgm5yi3x@notapiano>
References: <20220218091633.9368-1-allen-kh.cheng@mediatek.com>
 <20220218091633.9368-23-allen-kh.cheng@mediatek.com>
 <20220222232439.dhsvnut3phudlsls@notapiano>
 <d82cd71f06c803d15c1f2b86123c0ba63e7c5ed7.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d82cd71f06c803d15c1f2b86123c0ba63e7c5ed7.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:12:37PM +0800, allen-kh.cheng wrote:
> On Tue, 2022-02-22 at 18:24 -0500, Nícolas F. R. A. Prado wrote:
> > On Fri, Feb 18, 2022 at 05:16:32PM +0800, Allen-KH Cheng wrote:
> > > Add gce info for display nodes.
> > > 
> > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index 1f1555fd18f5..df884c48669e 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > @@ -1226,6 +1226,9 @@
> > >  		mmsys: syscon@14000000 {
> > >  			compatible = "mediatek,mt8192-mmsys", "syscon";
> > >  			reg = <0 0x14000000 0 0x1000>;
> > > +			mboxes = <&gce 0 CMDQ_THR_PRIO_HIGHEST 1>,
> > > +				 <&gce 1 CMDQ_THR_PRIO_HIGHEST 1>;
> > > +			mediatek,gce-client-reg = <&gce SUBSYS_1400XXXX
> > > 0 0x1000>;
> > 
> > As a side note, the current mmsys dt-binding,
> > Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml,
> > doesn't
> > define mboxes or mediatek,gce-client-reg, but looks like there's
> > already a patch
> > in the ML adding those:
> > 
> > 
> https://urldefense.com/v3/__https://lore.kernel.org/all/20220126071932.32615-2-jason-jh.lin@mediatek.com/__;!!CTRNKA9wMg0ARbw!zNfQkN-YYjiqPCd5m9DsLhrQDymgEZJoY4oSl24nC3R95P0gIXEmNjyJMhjQZXkWX7mZPa5QS7KIMlGXMbDjDA1_2A$
> > 
> 
> Hi Nícolas,
> 
> Thanks for your reminding, Should I need to remove this patch from
> series?
> 
> or I can add this ML to base and mention it in cover letter.

I think it should be OK to just mention it in the cover letter.

Thanks,
Nícolas
