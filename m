Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03CE3464DE3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 13:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349307AbhLAMdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 07:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243476AbhLAMc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 07:32:59 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2F67C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 04:29:38 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1msOju-00012c-Ll; Wed, 01 Dec 2021 13:29:34 +0100
Message-ID: <1b03b591d51250d5049028e93c1a54ef7f28aeae.camel@pengutronix.de>
Subject: Re: [PATCH v2 0/3] drm/etnaviv: IOMMU related fixes
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Michael Walle <michael@walle.cc>,
        Robin Murphy <robin.murphy@arm.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     "Lukas F . Hartmann" <lukas@mntre.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 01 Dec 2021 13:29:31 +0100
In-Reply-To: <20210907164945.2309815-1-michael@walle.cc>
References: <20210907164945.2309815-1-michael@walle.cc>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

Am Dienstag, dem 07.09.2021 um 18:49 +0200 schrieb Michael Walle:
> This patch series fixes usage of the etnaviv driver with GPUs behind a
> IOMMU. It was tested on a NXP LS1028A SoC. Together with Lucas' MMU patches
> [1] there are not more (GPU internal) MMU nor (system) IOMMU faults on the
> LS1028A.
> 
> [1] https://lists.freedesktop.org/archives/etnaviv/2021-August/003682.html
> 
> changes since v1:
>  - don't move the former dma_mask setup code around in patch 2/3. Will
>    avoid any confusion.
> 
> Michael Walle (3):
>   drm/etnaviv: use PLATFORM_DEVID_NONE
>   drm/etnaviv: fix dma configuration of the virtual device
>   drm/etnaviv: use a 32 bit mask as coherent DMA mask
> 
>  drivers/gpu/drm/etnaviv/etnaviv_drv.c | 41 ++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
Thanks for the patches! I applied them to my etnaviv/next branch.

Regards,
Lucas

