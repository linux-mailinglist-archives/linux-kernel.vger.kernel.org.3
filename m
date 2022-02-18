Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 504AC4BB97F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiBRMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:54:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiBRMyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:54:09 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF342B3545;
        Fri, 18 Feb 2022 04:53:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 96DCE1F4241F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645188830;
        bh=Gv8c/LMKo6rxgaMQAVOHcLVtihxtts7Lugi4FWiRWzg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=jsc+Jd7YNSdcSO7Arwmg5Oa5RcOIdQwAd1Vp9MCMsz3njw0Lh3TqNOjD/5VdNV7ds
         iI3sQ1uy1f4dMupHFJbAhjHvePu0G0116Qam/iDQKq9ZgrL0iriNP/ImzZMPuG8Vq5
         VhVTNL3KhMozEcwOSBxxcKRacJVHokQNnQQdmJZ7DUGkfshLwdu6xJXMYncEG4B1+7
         KqStXONu4k1fHPNg9tPMMZq+sUaWrDAjDFPdTLD4rsKaXEq3pGGed8UM2lDEJt2esm
         IFY5E1Pl5wyQLlXs885fc9PrvpIC87ygeqRuDdtm/39jVwdEwND1zAafv7zWPVbFzL
         /TW6GzjnqRNcg==
Message-ID: <b69b6a18-c991-4c37-fff1-d68d140e4901@collabora.com>
Date:   Fri, 18 Feb 2022 13:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v5 27/34] iommu/mediatek-v1: Just rename mtk_iommu to
 mtk_iommu_v1
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
 <20220217113453.13658-28-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220217113453.13658-28-yong.wu@mediatek.com>
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
> No functional change. Just rename this for readable. Differentiate this
> from mtk_iommu.c
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/iommu/mtk_iommu_v1.c | 211 +++++++++++++++++------------------
>   1 file changed, 103 insertions(+), 108 deletions(-)
> 
