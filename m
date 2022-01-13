Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D4948DAD8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbiAMPoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47550 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiAMPoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:11 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id C463E1F45F54
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642088650;
        bh=3vGVtVzMAhUmYM5YjA6CBnjnlY+uoAIkrXPjo/Gg1GI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Y3KiLojbdjd1lJ/W6NH25Ji0/8OF+E0IkH2Onn7bsAkaEmfjjj02nAY4kSZ1Y+UfI
         94A10jPfHgHlRBJxERt9+viTwuzR18mGLHnUCR/AagKfPO0o5pjAOCuGfow+b1lvuh
         Tlqzq/MQ7aSujocogRWsgNxbGeKDIKUrDut6cpXRIX+Iu5lPFzeks0tonky7C5Aols
         jvJNgrMEYmM1YpqbBnlf0uCEx8OpLuf6K7nTFBuxoYOi9Yw4tYRfG0q6TgPFUQEljs
         uq/4C0kDkcrUAP2QL3QVr6lBpx6fjW3s8Qp9k+X1bwnUajHOQIHeY/DpHMYNyYHylI
         WY+a95p3pxwrQ==
Subject: Re: [PATCH v3 3/7] dt-bindings: memory: mtk-smi: Correct minItems to
 2 for the gals clocks
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-4-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <dbaf0fa5-4900-a59d-b05d-a138464a4f39@collabora.com>
Date:   Thu, 13 Jan 2022 16:44:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113111057.29918-4-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/22 12:10, Yong Wu ha scritto:
> Mute the warning from "make dtbs_check":
> 
> larb@14017000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
> 	...
> 
> larb@16010000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
> 
> larb@17010000: clock-names: ['apb', 'smi'] is too short
> 	arch/arm64/boot/dts/mediatek/mt8183-evb.dt.yaml
> 	arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dt.yaml
> 
> If a platform's larb supports gals, there will be some larbs have one
> more "gals" clock while the others still only need "apb"/"smi" clocks,
> then the minItems for clocks and clock-names are 2.
> 
> Fixes: 27bb0e42855a ("dt-bindings: memory: mediatek: Convert SMI to DT schema")
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

