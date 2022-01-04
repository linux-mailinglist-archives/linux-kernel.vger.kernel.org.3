Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23916484575
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiADPzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiADPyv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259B0C061785;
        Tue,  4 Jan 2022 07:54:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 0A9091F43595
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311690;
        bh=JixWBKej1ixfPa77aO+5D2vj0ASC2Uq4LukcRKfv9Z0=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=VHANxf2zE9WxqtsQfRJKx6SwX2NarUozgVSW91IC5zSVJlMV//NHrw5Gjbdo2Xyi2
         9DmMQx3n0jM0yz4QTW1iAa22La2iPgH41Oo0fb9P48uuMK8iyfkHmtduAZfSjygpJ8
         QtQh5VXKMR5n3hjIzJUL19zvOGdlEyIhAzrosi4iliL4oSfD5WYggfIaPhUDXBxV4r
         hkQOuUIPCNmr+N0L+/afL05OqtMFLTfIEOkVlyB/LshkDv4XhIbOFyVUwOAjd3S2Dv
         NpWxijPDULUl32hztQvwmMYoG15OKIr7zTXoYrNbgjjQ5Jnq+azdKSLfO7iHVRmk4l
         NY95NIhP+gx0A==
Subject: Re: [PATCH v3 08/33] iommu/mediatek: Add a flag NON_STD_AXI
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
 <20210923115840.17813-9-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <c8c44971-482d-6806-8209-e4da6f86551d@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-9-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> Add a new flag NON_STD_AXI, All the previous SoC support this flag.
> Prepare for adding infra and apu iommu which don't support this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>



Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
