Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8B74A2C1C
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 07:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240956AbiA2GXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 01:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232116AbiA2GXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 01:23:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2234C061714;
        Fri, 28 Jan 2022 22:23:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F95E60AFD;
        Sat, 29 Jan 2022 06:23:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A834C340E5;
        Sat, 29 Jan 2022 06:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643437425;
        bh=0r6gMpm5Sok9/JeKVpU9GCkUm+UOaHqLrsDFtW2FLjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J8v7c+Z4/3xvyaRIH15J17l+27vUe+E/sbcZKqSh96FZuGNKAdv3oOsObYyQkGHUm
         oxxEifqNN6cRTYlLV1hej6vo/ga27rpI7PCDbFM2itFz9IiNYYr8fh7Nfc5OzJ9dO5
         Qa6B81A2jcjlCyiMQccKkntp0+TTBW+E84cnztJVaHAQ99fF1X1OPr4tcMp85vT5XC
         76NwHsgnLTsAT93no266p7LtMCHbrrDQ//HedYdaN0NIJe58A2C/kdA8BXxsMsVwD/
         3zUeZIHEaEyGnQg+yKrTHW47GKLTioyVWYBfHU/Eu9n7ByXG5xCjoc6dbTQWtUFEvd
         CAqK0/G9tVXbQ==
Date:   Sat, 29 Jan 2022 14:23:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx7ulp: Fix 'assigned-clocks-parents' typo
Message-ID: <20220129062339.GT4686@dragon>
References: <20220120172355.1629650-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120172355.1629650-1-robh@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 11:23:55AM -0600, Rob Herring wrote:
> The correct property name is 'assigned-clock-parents', not
> 'assigned-clocks-parents'. Though if the platform works with the typo, one
> has to wonder if the property is even needed.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

Applied, thanks!
