Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7764897C0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:43:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245024AbiAJLnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244865AbiAJLmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:42:44 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F99BC061759;
        Mon, 10 Jan 2022 03:42:44 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id ADF631F436AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641814962;
        bh=aqM6eqxL/59SPD0eLrWoMsGRIH1ySplA/RdbUjqnt8U=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GrzWeHv93tECgVuNmZxUxZC4fPMVBCiQo7mvSPzNZ3hg2p+QGENhVRjmQkSEDJfnW
         lKx0Ea9CeFfhLAThUhzRSS6ojKyuybjnRBt2Y7KoTUZ7tPAM9OcdAzFeRvGhNBMPqR
         QDEqwtA5Nh7h0AjAXkZ4bzrOXS7noHPeoHxbDybSDiMozZQkXMOfAD8ui/xgBR6KVH
         k/9yaqnBJdcEOaF9qtn94YIRutW5mQ+YKWBzxWpaYsMOaW/Pr9rV1E2fLyKTp9Wy0T
         FX58Lx66RLgCKxItga/eNE3Jm1mKdortyVFI7xCbTtGwWecg2JhsIJDjE9Jn6gIAdL
         7BXriwcntmLKw==
Subject: Re: [PATCH v2 1/5] iommu/mediatek: Remove for_each_m4u in
 tlb_sync_all
To:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        iommu@lists.linux-foundation.org, Yong Wu <yong.wu@mediatek.com>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:MEDIATEK IOMMU DRIVER" 
        <linux-mediatek@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        linux-media@vger.kernel.org, sebastian.reichel@collabora.com
References: <20211208120744.2415-1-dafna.hirschfeld@collabora.com>
 <20211208120744.2415-2-dafna.hirschfeld@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <41c17006-af5d-19ec-210e-f6f12542eb75@collabora.com>
Date:   Mon, 10 Jan 2022 12:42:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-2-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> The tlb_sync_all is called from these three functions:
> a) flush_iotlb_all: it will be called for each a iommu HW.
> b) tlb_flush_range_sync: it already has for_each_m4u.
> c) in irq: When IOMMU HW translation fault, Only need flush itself.
> 
> Thus, No need for_each_m4u in this tlb_sync_all. Remove it.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
