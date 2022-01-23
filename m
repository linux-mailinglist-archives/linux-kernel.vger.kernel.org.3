Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556ED49729A
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237744AbiAWPdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:33:16 -0500
Received: from relay11.mail.gandi.net ([217.70.178.231]:54085 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237732AbiAWPdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:33:15 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 0C326100003;
        Sun, 23 Jan 2022 15:33:12 +0000 (UTC)
Date:   Sun, 23 Jan 2022 16:33:11 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>, miquel.raynal@bootlin.com,
        krzysztof.kozlowski@canonical.com
Cc:     vigneshr@ti.com, nm@ti.com, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: rawnand: omap2: Prevent invalid configuration and
 build error
Message-ID: <20220123163312.31866853@xps13>
In-Reply-To: <20220123152301.529360-1-miquel.raynal@bootlin.com>
References: <20220118123525.8020-1-rogerq@kernel.org>
        <20220123152301.529360-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Sun, 23 Jan 2022 16:23:01 +0100:

> On Tue, 2022-01-18 at 12:35:25 UTC, Roger Quadros wrote:
> > We need to select MEMORY as well otherwise OMAP_GPMC will not be built.
> > For simplicity let's select MEMORY and OMAP_GPMC unconditionally as
> > this driver depends on OMAP_GPMC driver and uses symbols from there.
> > 
> > Fixes: dbcb124acebd ("mtd: rawnand: omap2: Select GPMC device driver for ARCH_K3")
> > Reported-by: kernel test robot <lkp@intel.com>
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Pushed on mtd/fixes, actually.
