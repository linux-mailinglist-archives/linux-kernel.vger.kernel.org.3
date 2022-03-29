Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 657204EB481
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbiC2UNW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiC2UNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:13:16 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93382D372A;
        Tue, 29 Mar 2022 13:11:31 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id EBFE51F4411F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1648584690;
        bh=3+u06kszAFsjGLV5kQ+MCKFOJ2X8S3uDlpfpQmxL90I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hzs3k3hRcp2Xgj8dg4wykt9DEvnOqLtFTAwiQn52KasZKnxABiJ8ZqHm80rFmN2zw
         gk/Nu1NPhJe9wi4hwY4tXBGODvv1+vGcsKnse9BI/+tWrI04U0Q4nKNd0AOt3nCkxt
         Nkj9UbN/BeHI/6eyXcsbIRyGq4iqzqGB6tLrUf8s65ZlshT0HbVlPYM25qmziUFctI
         /jp9wRmW6oE0CtHkd4msDr56ZbZiKVIfSS4mpxLEcr/Yim05SBXzWoKJze20Mh1F0W
         JLCE576lwdtq043wca8cr4hPBYVd0agH2iIflvtZU/6Wx35HJCs3CfvMmNFrCSqtr3
         wA7zhvO7xl94g==
Date:   Tue, 29 Mar 2022 16:11:25 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>,
        Ryder Lee <ryder.lee@kernel.org>,
        Hui Liu <hui.liu@mediatek.com>
Subject: Re: [PATCH v4 03/22] arm64: dts: mt8192: Add gce node
Message-ID: <20220329201125.7l47kl7rmf4hjyvc@notapiano>
References: <20220318144534.17996-1-allen-kh.cheng@mediatek.com>
 <20220318144534.17996-4-allen-kh.cheng@mediatek.com>
 <a4935385-e7a5-8650-914b-73c699d2f8ca@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a4935385-e7a5-8650-914b-73c699d2f8ca@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 23, 2022 at 06:24:03PM +0100, Matthias Brugger wrote:
> 
> 
> On 18/03/2022 15:45, Allen-KH Cheng wrote:
> > Add gce node for mt8192 SoC.
> > 
> > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >   arch/arm64/boot/dts/mediatek/mt8192.dtsi | 10 ++++++++++
> >   1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > index 0f9f211ca986..9e1b563bebab 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > @@ -6,6 +6,7 @@
> >   /dts-v1/;
> >   #include <dt-bindings/clock/mt8192-clk.h>
> > +#include <dt-bindings/gce/mt8192-gce.h>
> >   #include <dt-bindings/interrupt-controller/arm-gic.h>
> >   #include <dt-bindings/interrupt-controller/irq.h>
> >   #include <dt-bindings/pinctrl/mt8192-pinfunc.h>
> > @@ -552,6 +553,15 @@
> >   			#size-cells = <0>;
> >   		};
> > +		gce: mailbox@10228000 {
> > +			compatible = "mediatek,mt8192-gce";
> > +			reg = <0 0x10228000 0 0x4000>;
> > +			interrupts = <GIC_SPI 203 IRQ_TYPE_LEVEL_HIGH 0>;
> > +			#mbox-cells = <3>;
> 
> #mbox-cells should be 2, right?

It should indeed. The mboxes property in patch 21 should also have the third
argument ("1") dropped.

Thanks,
Nícolas
