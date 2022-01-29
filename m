Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA0C84A2C05
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 06:46:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiA2Fqj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 00:46:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230162AbiA2Fqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 00:46:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67342C061714;
        Fri, 28 Jan 2022 21:46:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80AD060B68;
        Sat, 29 Jan 2022 05:46:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF373C340E7;
        Sat, 29 Jan 2022 05:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643435195;
        bh=VaX/WR7mCWd/wmxf+sRub6dqv4ltAAM+RLPPPpIrJwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lDlKOvVIhtnMdC6KfZ8+e4QFh9SQcJu8n/Bz4dl9Ob95n6QCEfcuxtEOOUy9qEI9j
         TvWpfM/6lypE+fCunAntuQcK9+cyjOWRDTQYsNo90411VpmHrM8NvONEwP71xhQGho
         V+BMnCksbrxtRuyJINXK1ZHWs8RD4GbNYZfB2AiUO8k9Z3Vnq2MC8r7iiM3q+70cuI
         B/fZVbxadfvRc3UOeN6E30Rkr4dInjf05PqzQL6Z+8UOwMdc2RStIdsmTGp1/3jA6q
         SaCHYZk313vPk8b9www2Mqk/IrbqP38Wsh+GzNyxLbTyoDvbvgtPRc+OcBwIMGK4AL
         14Zo0+hVekwig==
Date:   Sat, 29 Jan 2022 13:46:30 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v3 1/4] ARM: dts: imx28: reparent gpmi clock to
 ref_gpmi
Message-ID: <20220129054629.GP4686@dragon>
References: <20220117161755.1863579-1-dario.binacchi@amarulasolutions.com>
 <20220117161755.1863579-2-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220117161755.1863579-2-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 05:17:52PM +0100, Dario Binacchi wrote:
> Since ref_gpmi is sourced from pll0 (480MHz), It allows the GPMI
> controller to manage High-Speed ​​NAND Timing (edo mode 3,4 and 5).
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Applied, thanks!
