Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5271497266
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237445AbiAWPXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:23:11 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:40239 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237441AbiAWPXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:23:10 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 106DD100003;
        Sun, 23 Jan 2022 15:23:06 +0000 (UTC)
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Han Xu <han.xu@nxp.com>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: Re: [PATCH 2/4] mtd: rawnand: gpmi: fix controller timings setting
Date:   Sun, 23 Jan 2022 16:23:06 +0100
Message-Id: <20220123152306.529424-1-miquel.raynal@bootlin.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220118095434.35081-3-dario.binacchi@amarulasolutions.com>
References: 
MIME-Version: 1.0
X-linux-mtd-patch-notification: thanks
X-linux-mtd-patch-commit: b'136101c26073ff34b27b0b8fadd0abc5c7ad51f0'
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-01-18 at 09:54:32 UTC, Dario Binacchi wrote:
> Set the controller registers according to the real clock rate. The
> controller registers configuration (setup, hold, timeout, ... cycles)
> depends on the clock rate of the GPMI. Using the real rate instead of
> the ideal one, avoids that this inaccuracy (required_rate - real_rate)
> affects the registers setting.
> 
> This patch has been tested on two custom boards with i.MX28 and i.MX6
> SOCs:
> - i.MX28:
>   required rate 100MHz, real rate 99.3MHz
> - i.MX6
>   required rate 100MHz, real rate 99MHz
> 
> Fixes: b1206122069a ("mtd: rawnand: gpmi: use core timings instead of an empirical derivation")
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> Tested-by: Sascha Hauer <s.hauer@pengutronix.de>
> Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Miquel
