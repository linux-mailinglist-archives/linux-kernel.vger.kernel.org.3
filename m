Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109D5563C33
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiGAWML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiGAWMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:12:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D56599F2;
        Fri,  1 Jul 2022 15:12:07 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 644AE660177B;
        Fri,  1 Jul 2022 23:12:03 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656713526;
        bh=vO57gVtWH9VVPfhwKrj1w3mSb/OAbqwWY5Fzq8waJtc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GAm9TKTeIYFZ/1jL+pZskQdvoZt5+1rr5343uvEnaRAtQV+EL1LFP6YYQcfzrWG9d
         VRY022M79HIK2A0ZUANLfskx0Ncqojd+6Adb+QtNfIf8tMNH1AemTQoZFZqBUk+RLJ
         OH+M/knafQKaYdHgOXC3dftIiL/rqg/cZyAZI3W40RVx6ozGh4L2X1fhd82qPGC50S
         RQkWhw/P7QlfXYjVQnCjNUqapiz777M+zWhpUxJD8TS6mONJD9TRkIB340QaXCt9sZ
         O+sAE99EM0vQVYo6E8eYK+5Kmvx6VgLgDl7D/ijhbCCr+tP061/iCslhYfE8w7mM7o
         XYpSBMJxfKdRQ==
Date:   Fri, 1 Jul 2022 18:11:58 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH 02/11] arm64: dts: mediatek: Introduce MT8195 Cherry
 platform's Tomato
Message-ID: <20220701221158.iuw5fehgkjrqw6zh@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-3-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-3-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:07PM +0200, AngeloGioacchino Del Regno wrote:
> Introduce the MT8195 Cherry Chromebook platform, including three
> revisions of Cherry Tomato boards.
> 
> This basic configuration allows to boot Linux on all board revisions
> and get a serial console from a ramdisk.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  arch/arm64/boot/dts/mediatek/Makefile         |  3 +++
>  .../dts/mediatek/mt8195-cherry-tomato-r1.dts  | 11 ++++++++
>  .../dts/mediatek/mt8195-cherry-tomato-r2.dts  | 11 ++++++++
>  .../dts/mediatek/mt8195-cherry-tomato-r3.dts  | 12 +++++++++
>  .../boot/dts/mediatek/mt8195-cherry.dtsi      | 26 +++++++++++++++++++
>  5 files changed, 63 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts
>  create mode 100644 arch/arm64/boot/dts/mediatek/mt8195-cherry.dtsi
[..]
> diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> new file mode 100644
> index 000000000000..17e9e4d6f6ab
> --- /dev/null
> +++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts
> @@ -0,0 +1,11 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR MIT)
> +/*
> + * Copyright (C) 2021 MediaTek Inc.
> + */
> +/dts-v1/;
> +#include "mt8195-cherry.dtsi"
> +
> +/ {
> +	model = "MediaTek Tomato (rev1) board";

Given that the compatible is "google," I believe we'll want to rename the model
to "Google Tomato", much like was commented on the Asurada series [1], but
better to have confirmation from someone from Google. Chen-Yu? :)

Otherwise,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

[1] https://lore.kernel.org/all/CAGXv+5Gv2pjPXynz6HCdgux+giPDC5qRk+KW1aFduVz82rM=+g@mail.gmail.com/

> +	compatible = "google,tomato-rev1", "google,tomato", "mediatek,mt8195";
> +};
[..]
> -- 
> 2.35.1
> 
