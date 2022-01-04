Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA76C48458F
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235389AbiADPza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbiADPy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:54:59 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F0DC061395;
        Tue,  4 Jan 2022 07:54:53 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 697211F43596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311692;
        bh=vzayMLDZjmuU/T7YRMHDZIjwrs5CK4WTNFLBnmYiBTM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mD36jnzaMKvD5o+7fxeQ1bkd+sQm/XLb8FjaIhnKMzkK2CsWfRbrZmigtOFTlt1/K
         sAGzUAavQU3lTvSsdZS4u7UYa2Ik5Cs9xO7IKDfRjCa0TemdEZ2rn4JL7fbHr56a2h
         Q3Mh+MZNkZlQSr7c6qXpeBIp57Qp/NXSgBql5uLQPPEVfqCX3IUxugzBTd1H/z5jIV
         NxfsCqAp3cbZi0eb0jYP989vSqVVG6nelZoL78ISk34B0s8Ijq+EjScT+VfPbUIFWn
         foxdsPlOvKVhui2Tk39F2rFq/5CBySmx5ULpDbH4j5TEyFkalGdxcuro/ws7hUF3O/
         04kY2M0JoWVHQ==
Subject: Re: [PATCH v3 07/33] iommu/mediatek: Add a flag DCM_DISABLE
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
 <20210923115840.17813-8-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4b48b8ee-422b-b3b1-acdc-4e0c0085a20a@collabora.com>
Date:   Tue, 4 Jan 2022 16:54:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-8-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> In the infra iommu, we should disable DCM. add a new flag for this.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
