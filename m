Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0B7249DA46
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiA0Ffc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:35:32 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:55060 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbiA0Ffb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:35:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 914FC61795
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 05:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A566C340E4;
        Thu, 27 Jan 2022 05:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643261731;
        bh=eShf3b9uqaeTw/KIVZFTE+K6i4YAfGEDzgA7Jc3OfC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oTmDi86Pbqbal5l9qZsrDwlfxf9ZhrsPP7ls0gH0QyxrFnJYNpmjnQu2y7oOT9hU+
         o36gTbRcMyXWnHI0l00YiW5nz5uxDIMi8RUasbBnHCHYJc96uYmKi+jCD5tMh0Bb+o
         IKuc9pcJvncCmJ1hAncePD90gWEMN+ml8o43sdwpEIQZUbwaqA0RKjE2aAHRZa1vLN
         mDtfEQWtjJ9ycVw6358o48N3bXg8FYCGhO8tlLMffgIp2dSU/db06sMogRXnLNUsRY
         XrtT7eXa2kzbwiAoKnxjqA4RL/uPPL70G9uYKq0WdnlUXwD57ZAe+24m9uOy5jAsGX
         oYApgMDf/teuw==
Date:   Thu, 27 Jan 2022 11:05:27 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: freescale: i.MX8 PHYs should depend on ARCH_MXC &&
 ARM64
Message-ID: <YfIvH/f5ZoQQzUF1@matsya>
References: <393868affd830016d35f0d9aba32ccd7098c8073.1641987369.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <393868affd830016d35f0d9aba32ccd7098c8073.1641987369.git.geert+renesas@glider.be>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12-01-22, 12:40, Geert Uytterhoeven wrote:
> The Freescale/NXP i.MX8 USB3, MIPI DSI, and PCIE PHYs are only present
> on the NXP i.MX8 family of SoCs.  Hence wrap the config symbols for
> these PHYs inside a check for ARCH_MXC && ARM64, to prevent asking the
> user about these drivers when configuring a kernel without NXP i.MX SoC
> family support.

Applied, thanks

-- 
~Vinod
