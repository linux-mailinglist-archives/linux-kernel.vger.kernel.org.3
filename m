Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E204BB970
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:53:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiBRMxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:53:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235357AbiBRMxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:53:06 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DA82B4045;
        Fri, 18 Feb 2022 04:52:42 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 8FB211F46910
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188761;
        bh=7bVmllsSdo+zEWIfNE+5yNbesylSATeKRH84GE8XJgE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n0/DAjtxFTgTEf0bWouyCh2A3lkCBOWFQdTJkWoafSl7oIAzgiSpDM8Jr3N3wPkpm
         cvjyL/C3QpVE4cCm/sJxaDj6tmLopwNOwhbrdFqXoNTEpH9dr3HSXXmA/ObhAPbRFX
         7bJNy0HqO2YA8CNEPXZW/NEyC36qqgt4vv9BzZzlvGbs/rfNRYIvGGnSZ/4Mcw82RE
         EZQDW9ihRPTketCFdo2fwNRfDI0SnamcobthmwBNzgRLs8YrbrYfpcdOOQu9vmfl8f
         3oCCmpoalIvSYmyADkRseoS0jgMPZc73OtTahhJavj6RRGmG/zWy7GlnJJ2s1Gew3L
         /8tDPN2MnzCwA==
Message-ID: <d138f7b9-bfa1-8628-5c5c-aca5c9af48a6@collabora.com>
Date:   Fri, 18 Feb 2022 13:52:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 32/34] iommu/mediatek: Initialise/Remove for multi bank
 dev
Content-Language: en-US
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>
Cc:     Robin Murphy <robin.murphy@arm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, xueqi.zhang@mediatek.com,
        yen-chang.chen@mediatek.com, mingyuan.ma@mediatek.com,
        yf.wang@mediatek.com, libo.kang@mediatek.com,
        chengci.xu@mediatek.com
References: <20220217113453.13658-1-yong.wu@mediatek.com>
 <20220217113453.13658-33-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-33-yong.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 17/02/22 12:34, Yong Wu ha scritto:
> The registers for each bank of the IOMMU base are in order, delta is
> 0x1000. Initialise the base for each bank.
> 
> For all the previous SoC, we only have bank0. thus use "do {} while()"
> to allow bank0 always go.
> 
> When removing the device, Not always all the banks are initialised, it
> depend on if there is masters for that bank.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

