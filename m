Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19B444A2C00
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:35:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235938AbiA2Fe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:34:59 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52008 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiA2Fe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:34:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D65CB810A9;
        Sat, 29 Jan 2022 05:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D54C340E5;
        Sat, 29 Jan 2022 05:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643434495;
        bh=/VEtJ38Kd1gSMNdRAR5gog4SNzQFvYdSqW2OGfK7wg4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iv4DTFE3Q4DlbRfyeKb3eWdFiY+BKAY8XQkXsmiaYGttXe4nl81ssS+nFXK80LMOD
         F9319pbUTmSJgehfFVqeHD27HUbQ2BFh41gfA08Z0QjDqqOFTzDK7ELdY2h4z1szCz
         31G05owDIHLMmaQTgD7cpywqPCNf/MiTH02w1B1Z7z9ISHfQRertu0Wh/SYiIc9pD6
         MgTqStJPKS1M9RsWiZeNpuEdlBUeY6QxGdab0IIUxFCYNV0npPbEHdFoTADZBbWOGy
         gxkiRO9P26ZEB8IaA5P6L8fm8sb4RvJmhRHjbA8DAbUJy0QW5xpX2x/irk9PQ561Qd
         Y/azG6poouf3w==
Date:   Sat, 29 Jan 2022 13:34:49 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Michael Walle <michael@walle.cc>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Biwen Li <biwen.li@nxp.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        "kernelci.org bot" <bot@kernelci.org>
Subject: Re: [PATCH] arm64: dts: ls1028a: sl28: re-enable ftm_alarm0
Message-ID: <20220129053448.GN4686@dragon>
References: <20220115210432.449968-1-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220115210432.449968-1-michael@walle.cc>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 15, 2022 at 10:04:32PM +0100, Michael Walle wrote:
> Commit dd3d936a1b17 ("arm64: dts: ls1028a: add ftm_alarm1 node to be
> used as wakeup source") disables ftm_alarm0 in the SoC dtsi but doesn't
> enable it on the board which is still using it. Re-enable it on the sl28
> board.
> 
> Fixes: dd3d936a1b17 ("arm64: dts: ls1028a: add ftm_alarm1 node to be used as wakeup source")
> Reported-by: Guillaume Tucker <guillaume.tucker@collabora.com>
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Michael Walle <michael@walle.cc>

Applied, thanks!
