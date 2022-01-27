Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7BD49DAF5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:42:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236931AbiA0Gmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:42:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236929AbiA0Gmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:42:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D38C061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:42:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96EE26192D
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 06:42:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FF12C340E4;
        Thu, 27 Jan 2022 06:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643265750;
        bh=9qlTOBaZNbP5dnlI7UztbiokMnyc69tSR6O4YogHR7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oT3vbOUYhUAMuY09dZB68GNBA9vykrSTmEdZdqPdCmaGpns23+JAGCt+7Q8jHM5Jg
         hhh7/0ycc13nKEdqIQcpg5Tx1rx87tbG//rOIh//8RCiHWr+YbOwTQ0ZwlwUi1aqY2
         ljGIEe65jW3s/met8orQcFc6cDFhfCGv5OlXeDfIRyJzEhN+ZlHV+Pyr+KWIM3vMRC
         GbZgIc8xk3s1DiVzgBe2TXU1V+wV4fLprAQejgCOno5Yd1RylnUizzBKx2tH6VXXYq
         gh1+6dQW5w54G8VEue2W3RTZUGsVkLnbjPRXGNFFPnNYen68bdODXneLkeuz7DSbDW
         fxHUPoWsbQBzw==
Date:   Thu, 27 Jan 2022 12:12:26 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, jiabing.wan@qq.com
Subject: Re: [PATCH] phy: phy-mtk-tphy: Fix dumplicated argument in
 phy-mtk-tphy
Message-ID: <YfI+0uzGZDLig+zC@matsya>
References: <20220107025050.787720-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107025050.787720-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-01-22, 10:50, Wan Jiabing wrote:
> Fix following coccicheck warning:
> ./drivers/phy/mediatek/phy-mtk-tphy.c:994:6-29: duplicated argument
> to && or ||
> 
> The efuse_rx_imp is duplicate. Here should be efuse_tx_imp.

Applied, thanks

-- 
~Vinod
