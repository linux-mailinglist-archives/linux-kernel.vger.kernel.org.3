Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27C9578E3E
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 01:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233838AbiGRXXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 19:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbiGRXXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 19:23:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289042CCA4;
        Mon, 18 Jul 2022 16:23:33 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A1B876601A63;
        Tue, 19 Jul 2022 00:23:30 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1658186611;
        bh=ueHareq2lBmSzrfXkKzx7fGfwxDmuIWF5D8pgRa5xxU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NWa23fDATco2oFnMi8UA3XKmwA+raBTNgR8E/pk0t5Kc11Pxkz+XUP82VH96guprU
         ZMtjFx0xxB5cT5vO6Sfa24m/vIzNO+bmiic6PAv2f5vej4eHRZj1ulkSnTU1F1sCKE
         ryBvTsL6E8xqS9TV5FvXZthYWYGAoi5VmrMJ2J0dtiIK9esBvwTecym5oeEnaA09gx
         cMwwGck9SeYsN5unYjF7MdycYxME+C7MAVynUo7PtsL7yZUca/Fy47MVyzElvTaZqd
         +V2vKsTSuRGIN4TMjeWaNEUzoD9qv2fFCoy/3cqZiM+b0iCPqvEc/Z53yMN/HxEqbY
         JfFzt9San8/FQ==
Date:   Mon, 18 Jul 2022 19:23:26 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: Re: [PATCH v3 0/5] Complete driver nodes for MT8192 SoC
Message-ID: <20220718232326.l7cffiighmcdl3at@notapiano>
References: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220712114046.15574-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 07:40:41PM +0800, Allen-KH Cheng wrote:
> This series are based on matthias.bgg/linux.git, for-next.
> 
> I remove vcodec lat and core nodes PATCH from series and will comfirm
> clocks usage then resend PATCH.
> 
> Also should reference below PATCH for dsi in chunkuang.hu/linux.git
> dt-bindings: display: mediatek: dsi: Convert dsi_dtbinding to .yaml
> 
> changes since v2:
>  - add mmsys #reset-cells PATCH
>  - add missing fallback compatible
>  - add display aliases
>  - remove vcodec lat and core nodes PATCH
> 
> changes since v1:
>  - add Reviewed-by Tag
>  - rename dsi-phy from dsi-dphy
>  - add missing power-domains in disp mutex
>  - Add remove mt8192 display rdma compatible PATCH in series
>  - use "mediatek,mt8183-disp-rdma" as fallback
>  - remove mediatek,larb from rdma node
>  - remove syscon-dsi and add power-domains in dsi
>  - add reset property in dsi and mt8192-resets.h
>  - correct Typo: s/ndoe/node in commit message
> 
> Allen-KH Cheng (5):
>   arm64: dts: mt8192: Add pwm node
>   arm64: dts: mt8192: Add mipi_tx node
>   arm64: dts: mediatek: Add mmsys #reset-cells property for mt8192
>   arm64: dts: mt8192: Add display nodes
>   arm64: dts: mt8192: Add dsi node

For the whole series

Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Tested on mt8192-asurada-spherion. I have a working display with some additional
nodes on the mt8192-asurada DT.

Thanks,
Nícolas
