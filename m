Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D48952A59F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349650AbiEQPFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349540AbiEQPFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:05:48 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D3B2F0;
        Tue, 17 May 2022 08:05:47 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 7A1B81F44708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652799946;
        bh=lQaAioMCtJzYV+JsQokqOT8ZO6pFb3WCCN0aLVKRlF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mWyx87AAiAbMwcD6cd7G4OZnTdDs7hrlugoKAY086+/TluU3kCCXiGBkC/cYj2PaK
         PKAEnWgA9214eXGzRtuUtB9fD6PzrxZ9+I+kM1qjbFywDZmWFdSkLs266pqQl9nlJ+
         6kULyYfvupeQqGR0UiBuPe+mpsWUsRz02UqhOJrZjI2sxs3Xh+h0wcNi5S1KyfJM6V
         NMGwEO8hajIykt1it6HMY6lhGFTMWqUXY1SUh5QcOCkplM1dTCMUhcJmV4oKcjmWmd
         kmKLGefjqS+i9HOR3cF6bJupcVxIrByNZKBQyuo6pQTrkV1+NhUEAmhzKgmJsX/2P1
         I9GiuEjByRK6A==
Date:   Tue, 17 May 2022 11:05:42 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] dt-bindings: arm: MediaTek: Fix clock bindings
Message-ID: <20220517150542.cvvescaeohlfurkw@notapiano>
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 12:15:08PM +0200, AngeloGioacchino Del Regno wrote:
> As per Rob Herring's review [1] on my mt6795 clocks bindings patches, for
> which I've used the already upstreamed ones as a base, it was found that
> these bindings have some issues.
> This series is addressing the issues that were found by Rob on my series,
> which are present on all of the already merged bindings.
> 
> [1]: https://patchwork.kernel.org/project/linux-mediatek/patch/20220513165050.500831-5-angelogioacchino.delregno@collabora.com/#24859953
> 
> AngeloGioacchino Del Regno (6):
>   dt-bindings: arm: mt8186-clock: Remove unnecessary 'items' and fix
>     formatting
>   dt-bindings: arm: mt8186: Set #clock-cells as required property
>   dt-bindings: arm: mt8195-clock: Remove unnecessary 'items' and fix
>     formatting
>   dt-bindings: arm: mt8195: Set #clock-cells as required property
>   dt-bindings: arm: mt8192-clock: Remove unnecessary 'items'
>   dt-bindings: arm: mt8192: Set #clock-cells as required property

For the whole series,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> 
>  .../arm/mediatek/mediatek,mt8186-clock.yaml   | 29 ++++-----
>  .../mediatek/mediatek,mt8186-sys-clock.yaml   |  1 +
>  .../arm/mediatek/mediatek,mt8192-clock.yaml   | 46 +++++++--------
>  .../mediatek/mediatek,mt8192-sys-clock.yaml   |  1 +
>  .../arm/mediatek/mediatek,mt8195-clock.yaml   | 59 ++++++++++---------
>  .../mediatek/mediatek,mt8195-sys-clock.yaml   |  1 +
>  6 files changed, 71 insertions(+), 66 deletions(-)
> 
> -- 
> 2.35.1
> 
> 
