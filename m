Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA54F183C
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378543AbiDDPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378539AbiDDPZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 11:25:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452393E5E8;
        Mon,  4 Apr 2022 08:23:04 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id BB1741F44DDE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649085782;
        bh=qbJezh9FVSlhATk9a76wow3aDuv/GZNqoYfnfWao4EU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=R7qKfLTC3UmDAuTrk7Sdcc/sJ1Lpxi0Ca5GwE67PS2YO22fgBBcDd0D7TpqZadE8o
         XGDCbTylFJGGnGuT2B1b5F0SyoKVcubPoi/pJOq0/9RPpumwbMmIHknuX6MErUo7PQ
         sLZZIzPmq2//Lu3qhFR4NxGCkryoWI+uzVu0NcE3TZGh/MYJqcAB1A4V4naOrLYoJ0
         byW0eSj7opuZOsNgMm1+mAPtiplmrzw0nErUW0A6B93An+DljdSfvKGtMStmEi+3oU
         XDuDd/hThpRzIbLLMZ3QmMcuh7bvAhDzkh5daBThqVAzEh1FGIbuMa8i2qNTUN1d5j
         SPd2y3bEPXEmg==
Date:   Mon, 4 Apr 2022 11:22:56 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v1 0/3] Fixes for Mediatek dt-bindings
Message-ID: <20220404152256.mkksr4oqjt65ytlf@notapiano>
References: <20220225225854.81038-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220225225854.81038-1-nfraprado@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

Maybe you could pick this series through your tree? It addresses some dtc
warnings that are introduced with the new nodes in mt8192.dtsi that you just
picked up on your v5.18-next/dts64 branch.

Thanks,
Nícolas

On Fri, Feb 25, 2022 at 05:58:51PM -0500, Nícolas F. R. A. Prado wrote:
> 
> This series has some fixes for Mediatek dt-bindings. It solves some
> warnings printed by dtbs_check, both for already merged Devicetrees, as
> well as some that would be introduced by the changes to mt8192.dtsi in
> [1].
> 
> [1] https://lore.kernel.org/all/20220218091633.9368-1-allen-kh.cheng@mediatek.com/
> 
> 
> Nícolas F. R. A. Prado (3):
>   dt-bindings: remoteproc: mediatek: Add interrupts property to mtk,scp
>   dt-bindings: usb: mtk-xhci: Allow wakeup interrupt-names to be
>     optional
>   media: dt-bindings: mtk-vcodec-encoder: Add power-domains property
> 
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml     | 3 +++
>  Documentation/devicetree/bindings/remoteproc/mtk,scp.yaml      | 3 +++
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.yaml   | 1 +
>  3 files changed, 7 insertions(+)
> 
> -- 
> 2.35.1
