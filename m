Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF70484567
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235172AbiADPyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33210 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbiADPys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:48 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 77F4B1F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311687;
        bh=+EjaNGSwAWDlrlXS6ayy7mmIq1DUC6VaOMAwEnZbCLE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KXuioa6ya/0l9ax/FeyYfJTwPxq/3r/sBYqSNJDamQaA2jw0qbhkj7UY+6uTPN+Q4
         O57SNua103TYclQYgq1jRWU1xr5O+baJHQ9d+weMkvd3ndaLbhc+u3v4o2RyodMO8I
         N+WNXuhZpba5gvgEFUvuRHTA9ac20FXrk6/rJ9gHZn756OFisCcm412RVyjWTvBK9a
         QG6CCurHxygPf0KYzjPlfA94AdFr0wujLWht/+b6XEZmeajQKeEdd93Nrs9IOKxyPM
         isCwux/qfdr6wgeBY9PtpVu8r5t4w3DOpfXNwBoHL0QxknpLH1B2V0KpvA7LI0aVvX
         R67ygosdoQW2g==
Subject: Re: [PATCH v3 11/33] iommu/mediatek: Remove the granule in the tlb
 flush
To:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org,
        Hsin-Yi Wang <hsinyi@chromium.org>, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, chao.hao@mediatek.com,
        yen-chang.chen@mediatek.com
References: <20210923115840.17813-1-yong.wu@mediatek.com>
 <20210923115840.17813-12-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <428bbee6-d680-6188-9961-f13f64cc7c40@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-12-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> The MediaTek IOMMU don't care about granule when tlb flushing.
> Remove this variable.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

