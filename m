Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBCD74897CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 12:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbiAJLpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 06:45:15 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35628 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244991AbiAJLnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 06:43:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 675691F4341F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641815001;
        bh=qfdA38UV8rxTxGZXUeaOK67ifAtN+GX7ogFR3pqhe3E=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=GbGeOl3ElrEfAbWKu7HuLcsqmZNTsV5mLhcFol3/mI7QS14/9DcbiP9i1TRFU2C2f
         l8OSZ+mkmPzoq4KRAJThArDrwv4rDvuKF8Cv6KS9ce33lwgBzJdYZCnvnGxQuYfdEL
         bqDeUO5LVTtsrN8THSCo3XuA19u29dlPi0Em94ZsJQlJdvLqCWwH4u0M+wUrRnczVi
         7C1ZC0NsjEfFE2LiKhRwainELvqFgypkULQbbJIITPehBElsslgS1nauOGmSBKtEbI
         OUQ0yiW+3whbBsbblvBjOYMNRxxT1u73ToGdYHqKeCDm2dG1V7HRJ3tGhu66r7bowU
         MDHQZVWe/XXbQ==
Subject: Re: [PATCH v2 2/5] iommu/mediatek: Always check runtime PM status in
 tlb flush range callback
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
 <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <f91157b6-886c-2d69-451e-6ddeb52f95d7@collabora.com>
Date:   Mon, 10 Jan 2022 12:43:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211208120744.2415-3-dafna.hirschfeld@collabora.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 08/12/21 13:07, Dafna Hirschfeld ha scritto:
> From: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> In case of v4l2_reqbufs() it is possible, that a TLB flush is done
> without runtime PM being enabled. In that case the "Partial TLB flush
> timed out, falling back to full flush" warning is printed.
> 
> Commit c0b57581b73b ("iommu/mediatek: Add power-domain operation")
> introduced has_pm as optimization to avoid checking runtime PM
> when there is no power domain attached. But without the PM domain
> there is still the device driver's runtime PM suspend handler, which
> disables the clock. Thus flushing should also be avoided when there
> is no PM domain involved.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> Reviewed-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
