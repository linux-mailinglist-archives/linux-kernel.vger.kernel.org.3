Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D8848AA42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 10:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236988AbiAKJO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 04:14:29 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47116 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234465AbiAKJO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 04:14:28 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 406F31F41CF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641892467;
        bh=OpxYFNpUHYIuTIBv0HTc/nmFe9b8Qv/VGZti7c3+o2U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=E36tFSyAwJ9yqEtW4Zcvc4HVc5FLPeXnQLYaUHLeifo11gu0nrFYC+KLoL1I5wQUc
         S0gtJ6Wg+HcWrdQXzuQDhl2NIWOZrk5opIpPRITsMDsDkSi/XOTvWCzr0mJ1JwfN49
         +X1aS8HgGRjr3ngm3mHvdVKIcGjWxBz13wCTl5Eqwqm43o7GXVdyQXuf48BK3xr5Nk
         otD8S5HJwXMMl+A2AUoM/aWxIJb+fSeAy3rcEa9DkbfP5YempRDLYjmk4Mla6C1e5D
         dbCv8ynX5pr2F12D3mVTfuXItQeE/PxnxUUcjyl582bHDOM2MdwgXYK7pwCW1yRASV
         JiDoBJx+kpv3w==
Subject: Re: [PATCH v2 5/6] memory: mtk-smi: Add sleep ctrl function
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com
References: <20220111063904.7583-1-yong.wu@mediatek.com>
 <20220111063904.7583-6-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <e3815197-8963-99a6-e83d-b801de1725f3@collabora.com>
Date:   Tue, 11 Jan 2022 10:14:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220111063904.7583-6-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/01/22 07:39, Yong Wu ha scritto:
> Sleep control means that when the larb goes to sleep, we should wait a bit
> until all the current commands are finished. Thus, when the larb runtime
> suspends, we need to enable this function to wait until all the existed
> commands are finished. When the larb resumes, just disable this function.
> This function only improves the safety of bus. Add a new flag for this
> function. Prepare for mt8186.
> 
> Signed-off-by: Anan Sun <anan.sun@mediatek.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

