Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D7E468F3C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 03:37:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbhLFCkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 21:40:32 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34966 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbhLFCkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 21:40:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AEF4B80EDA;
        Mon,  6 Dec 2021 02:37:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE40C00446;
        Mon,  6 Dec 2021 02:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638758221;
        bh=uh+ev6MS8/oi5tL+V6gOiL502llJGKSw6NHvNHqBqEc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Di9uC+hRAoF3vbyM6obFSFqxhB6gtiAWCrCS5bUI1H7/egzf0nmnKJ25O840IXXTT
         EhchcvjzE9BN6vK5K7LK983i6gGiP+FtlwtnnzM1gZLRNDy8u87njGUp6jL2wtao2/
         d7AMx6ByVlG2aH/i18Z7YSGs73D5QAvWVyjKGg/pldsOmGgoQZqphYvuFa5fNybVcZ
         DcCUA3a/tpLLmMiXQYh9MoNTAxHHXU0s9fFxL4nW0m5xIXOVUJBeySulKJneN8U0gu
         hgpEIz7rhHVVmxQJQWbdhSQmnZTkgPYICz0neTssrlsTzfAcMYA8wmqoU3IsaFIkjx
         Mc3PdRdmtS4ng==
Date:   Mon, 6 Dec 2021 10:36:53 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        laurent.pinchart@ideasonboard.com, tharvey@gateworks.com,
        aford@beaconembedded.com, Fabio Estevam <festevam@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Peng Fan <peng.fan@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 1/5] soc: imx: imx8m-blk-ctrl: Fix imx8mm mipi reset
Message-ID: <20211206023650.GV4216@dragon>
References: <20211128125011.12817-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211128125011.12817-1-aford173@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 28, 2021 at 06:50:07AM -0600, Adam Ford wrote:
> Most of the blk-ctrl reset bits are found in one register, however
> there are two bits in offset 8 for pulling the MIPI DPHY out of reset
> and one of them needs to be set when IMX8MM_DISPBLK_PD_MIPI_CSI is brought
> out of reset or the MIPI_CSI hangs.
> 
> Since MIPI_DSI is impacted, add the additional one for MIPI_DSI too.
> 
> Fixes: 926e57c065df ("soc: imx: imx8m-blk-ctrl: add DISP blk-ctrl")
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Fabio Estevam <festevam@gmail.com>
> Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

Applied all, thanks!
