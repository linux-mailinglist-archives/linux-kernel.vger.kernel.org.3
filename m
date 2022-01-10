Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3454897D4
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245109AbiAJLqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244944AbiAJLoS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:44:18 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE2FCC06173F;
        Mon, 10 Jan 2022 03:44:17 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 1EC331F436F1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641815056;
        bh=sVloC0dkqoMasFv1fJjOkQcxMXUqU480+H//BOCz3X0=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=gM6CRcbhHFtc5HMOBQ5/CcpPa4EH3fQGSibLTqHMNkxNxLpQvmXB0fFppV7fZZtDo
         6FMDayfy9xdsTnLnFkjx2rvqAzif9y2iVKpvqPCoyGKIlv09LnpYWD4GXxMvsdVwmS
         L+WWUeyNJI46qvxMzvCHUWaF3P3Po8Pug6cgzAxuTRVmKYIVRZwQrhVuDaB+mamr/a
         6WZDQjT6UAnU4HNwFeMEafcUR+BTACjY9V55Jm0TSNw4WEn8aCSH4a9f4TUakQ4e+E
         g5EVhNBIPIzMvohnjhtRq2bapylkjzIdtUrvU8DekyP7h0B0Hx4SNZyEPirXY3EHoU
         nFwfwq/z2janw==
Subject: Re: [PATCH v2 4/5] iommu/mediatek: Add tlb_lock in tlb_flush_all
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
 <20211208120744.2415-5-dafna.hirschfeld@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <283e584d-ab72-a3cb-f97e-71eeb16f7834@collabora.com>
Date:   Mon, 10 Jan 2022 12:44:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-5-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Yong Wu <yong.wu@mediatek.com>
> 
> The tlb_flush_all touches the registers controlling tlb operations.
> Protect it with the tlb_lock spinlock.
> This also require the range_sync func to release that spinlock before
> calling tlb_flush_all.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> [refactor commit log]
> Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
