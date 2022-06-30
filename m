Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B04A561B83
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 15:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiF3NmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 09:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3NmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 09:42:19 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1622020F55;
        Thu, 30 Jun 2022 06:42:18 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CEA06601946;
        Thu, 30 Jun 2022 14:42:15 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656596536;
        bh=zjw1NKua1OqhkkVVGCT+4W7JxDOLoG6XHBVU7jGOB78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P9919LpkeDWT5+HIeeW2bFNEx3vluBXhRHVunbOdmiOxE5AMsYc3EIknZZC8HTypM
         4Dp+4pbIvhlvpeL8um1PDGdwC7Vi5vSzfxtjECgd4OH9Qfc/XUIl3OBwkWd0atKeyZ
         NdskSN9hnlzhV8zbWFxpw2YCGcVmTjLWu22cvtz8l+TaLfXiQ2Em79ySYC8eZFJEfq
         wqvkcKWLsSI0ISmzWwKJY9jSrrECO1E12OxA27xzCJxJN5FxMIQ6rY3Dte0qCVrbGJ
         ewSmuHn3Zja+o7xQdK1bEesESYxYl0ojf9/egs/8r1Uf3P0zMTJbo4c8L5Y/mo4h0E
         fwJk5jdV6EvLw==
Date:   Thu, 30 Jun 2022 09:42:10 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH 3/5] arm64: dts: mt8192: Add display nodes
Message-ID: <20220630134210.7j665amh6tbeaecv@notapiano>
References: <20220629121358.19458-1-allen-kh.cheng@mediatek.com>
 <20220629121358.19458-4-allen-kh.cheng@mediatek.com>
 <20220629232429.c5oysjgy6gflqhct@notapiano>
 <99342f13190cb4ea103c4227e6672eb5cad63b82.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <99342f13190cb4ea103c4227e6672eb5cad63b82.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:41:31PM +0800, allen-kh.cheng wrote:
> Hi Nícolas, 
> 
> On Wed, 2022-06-29 at 19:24 -0400, Nícolas F. R. A. Prado wrote:
> > On Wed, Jun 29, 2022 at 08:13:56PM +0800, Allen-KH Cheng wrote:
> > > Add display nodes and gce info for mt8192 SoC.
> > > 
> > > GCE (Global Command Engine) properties to the display nodes in
> > > order to
> > > enable the usage of the CMDQ (Command Queue), which is required for
> > > operating the display.
> > > 
> > > Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> > > Reviewed-by: AngeloGioacchino Del Regno <
> > > angelogioacchino.delregno@collabora.com>
> > > ---
> > >  arch/arm64/boot/dts/mediatek/mt8192.dtsi | 136
> > > +++++++++++++++++++++++
> > >  1 file changed, 136 insertions(+)
> > > 
> > > diff --git a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > index a07edc82d403..26d01544b4ea 100644
> > > --- a/arch/arm64/boot/dts/mediatek/mt8192.dtsi
> > > +++ b/arch/arm64/boot/dts/mediatek/mt8192.dtsi
[..]
> > > +		rdma0: rdma@14007000 {
> > > +			compatible = "mediatek,mt8192-disp-rdma";
> > 
> > dtbs_check is complaining that there isn't a "mediatek,mt8183-disp-
> > rdma"
> > fallback compatible here. But given that the rdma driver matches
> > directly to the
> > mt8192 compatible, I think the node here is fine, and the binding is
> > the one
> > that should be updated.
> > 
> 
> I have checked the binding and driver again.
> 
> I prefer use "mediatek,mt8186-disp-rdma" as fallback and remove mt8192
> compatible and data in mtk_disp_rdma.c because they are the same with
> mt8183.
> 
> Do you think it is okay?

Sure, that sounds good to me as well.

Thanks,
Nícolas
