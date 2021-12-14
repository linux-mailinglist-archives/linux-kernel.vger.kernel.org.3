Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A867473E20
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231776AbhLNISt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhLNISs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:18:48 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA051C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 00:18:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5159961326
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 08:18:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E9EC34601;
        Tue, 14 Dec 2021 08:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639469927;
        bh=NSwKZmc1ZcIiwD2DETHSMdQos9aeNA1E60e5PrDde7A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mE5nRdQyNtvTzXtg4LPOcfyqWRxPTPzMi+GsUov8FLZ4abStdbGMiVPc3kuzAJnQT
         +jVxox0Rrdjm6qT/itRKBxO+Y4e+B0O9U5GoEHsowUcVjWWb2edAX3aSMqZGOh9ILc
         KNlraArcTl2Rp4sKikC/Ai9QGgbtN6el02KsfBKM9ajALVbVc8un27mNvFHdle6Vea
         ypQOJm37PrVbK8DkkM2eNNZXIAfErw9JDh3s+Ml5dbMT6jf+EzbTmaxdRHtCsA/UKZ
         9avhr9DAHSWmZ/x3hF+wJh7vAnPnPeoNDnanMZooLqr5fXeyS1A/5Y+Daao9zTF5h/
         2w0n/oCcfXd2Q==
Date:   Tue, 14 Dec 2021 16:18:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        ping.bai@nxp.com, aisheng.dong@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: enable drivers for booting i.MX8ULP
Message-ID: <20211214081840.GC14056@dragon>
References: <20211207083457.2932511-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207083457.2932511-1-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 04:34:57PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Select i.MX8ULP CLK and PINCTRL driver to make it boot.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
