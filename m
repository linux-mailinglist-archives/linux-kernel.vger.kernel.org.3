Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5249C5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 10:10:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbiAZJKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 04:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238789AbiAZJKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 04:10:49 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE1C06161C;
        Wed, 26 Jan 2022 01:10:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 47719B81B99;
        Wed, 26 Jan 2022 09:10:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC86C340E3;
        Wed, 26 Jan 2022 09:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643188246;
        bh=EbY6JvAXqD+CkG3ubM/XShZR9U8dHFH0D6GHyMFVqpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pwL6+PnaOvEYrBgbAS72q/4wlMdOJzMXXyl/GYED5+OCC0TcMBO9Y2/aiEit6DsNF
         YAwkaFXa+vlRqqIj/U/Uq/ggdjkPhu+X2tR4bV6XW3RQNfc2rNpqLcrfgNYavOQRuI
         DcdisBXro8Q/bLCptYbVDunwTBqhVH5LKdQ6W4gFsqnp3NZqPhCb/9IcdmAucSIyv1
         MtQZXvzcCtT/MOVrgvdGieCQbi/QtaZYJm8WMMX26o4I9W9tt+W0LxTlMXnY8g0/0b
         hOb85pmzjt9YcGV3CPTir2S8Z7zVAnL1/Biz4Plek7q9XofscF1mrLB4tMVhFNorrq
         dhA2LJETbr2AA==
Date:   Wed, 26 Jan 2022 17:10:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, tharvey@gateworks.com,
        aford@beaconembedded.com, michael@amarulasolutions.com,
        jagan@amarulasolutions.com, Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V5 6/9] arm64: dts: imx8mn: add GPC node
Message-ID: <20220126091038.GI4686@dragon>
References: <20211215004626.2241839-1-aford173@gmail.com>
 <20211215004626.2241839-7-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215004626.2241839-7-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 06:46:23PM -0600, Adam Ford wrote:
> Add the DT node for the GPC, including all the PGC power domains,
> some of them are not fully functional yet, as they require interaction
> with the blk-ctrls to properly power up/down the peripherals.
> 
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied #6 ~ #9, thanks!
