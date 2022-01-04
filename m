Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7407D484559
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbiADPy2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:54:28 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:33126 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiADPy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:27 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0B5281F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311666;
        bh=ulZHjpTu7j0ySO1MMReKIYjoYdR7bbmUzzLd3EJvGds=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=M31g3/2LbHAm51RSMj8gQ/+f16Uz829T17eQnWLzFcVnn+T7o5DjmceJuekSLlCqN
         DHgaVnrL5OdMjSs5yLStZZibQGJ3Ng3+nZtcaQkCigkb5UFYPhDxddqV1r60EyPa3c
         F9xtRxB5ZFeFPW9jvqC+UBLXvEVDo8WBpzw7LK3saWxtKNCHZ9FQnd4r3O6J+UGiMT
         pnWBQTqhT6RYGbm2hnDIjKEY6Ir/rVvgTl3oxYTvu5RaMv5F05VkObmq/RI80YS90H
         bY8vFOJ2iwa/6hS0kaz9t9fDJ4FcymyIPkZUcjo4R2iT7W+7V9NYEpV6lOzvyxWfCP
         o2eLhdMkSIEGw==
Subject: Re: [PATCH v3 24/33] iommu/mediatek: Only adjust code about register
 base
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
 <20210923115840.17813-25-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4dce6fff-1c8f-3ec3-f540-4028241036e1@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-25-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> No functional change. Use "base" instead of the data->base. This is
> avoid to touch too many lines in the next patches.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


