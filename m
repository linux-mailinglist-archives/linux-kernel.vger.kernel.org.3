Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E634845A7
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 16:56:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbiADP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 10:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235220AbiADPzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 10:55:51 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E84FC061799;
        Tue,  4 Jan 2022 07:55:51 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 3F0BA1F43593
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641311750;
        bh=xfvIzyJHMkDZP1e9u2yfDSHp2jeB+W9uFbn9UswbT0Q=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=bwlABhPSumyKxseog6CQy9zWKiKTLbBbFVRnwlqfAusVMPEcuOabM19Dm9AD+pqak
         RmrVCYDbJV1zhCBxr/vC6AxIbq8pvQ8JqqO8IWqXpL5Erhsj2NrC3YHkGnluGC35/e
         pJogO5aqPgbSKfFbv+paLvf7FW8k06J6heDnHWJ76gcbgsxfWx7p69ij1vTEoi0H0W
         jg3+C0RxGyfOdSo3B/H2fPk7KFo7WrcOsjvCjW2HH16Tx6vQMAP4tI3coZYCzP08AW
         KKDZ6dZxadOqdy9gBwKII1ZvK5BM4nzUMLxeyJTYJTHQey26U++krzElrqvR/I854c
         g8XjyIWvfNscg==
Subject: Re: [PATCH v3 15/33] iommu/mediatek: Add SUB_COMMON_3BITS flag
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
 <20210923115840.17813-16-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <4a9660ad-032a-5319-de29-d088e607310d@collabora.com>
Date:   Tue, 4 Jan 2022 16:55:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210923115840.17813-16-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 23/09/21 13:58, Yong Wu ha scritto:
> In prevous SoC, the sub common id occupy 2 bits. the mt8195's sub common
> id has 3bits. Add a new flag for this. and rename the prevous flag to
> _2BITS. For readable, I put these two flags together, then move the
> other flags. no functional change.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
