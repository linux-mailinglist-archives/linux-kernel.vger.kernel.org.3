Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C5497298
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 16:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237719AbiAWPcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 10:32:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237696AbiAWPcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 10:32:42 -0500
X-Greylist: delayed 567 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 23 Jan 2022 07:32:42 PST
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FDDC06173B;
        Sun, 23 Jan 2022 07:32:41 -0800 (PST)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 526A7FF802;
        Sun, 23 Jan 2022 15:32:39 +0000 (UTC)
Date:   Sun, 23 Jan 2022 16:32:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mtd: parsers: qcom: Fix kernel panic on skipped
 partition
Message-ID: <20220123163238.12eb2616@xps13>
In-Reply-To: <20220123152316.529559-1-miquel.raynal@bootlin.com>
References: <20220116032211.9728-1-ansuelsmth@gmail.com>
        <20220123152316.529559-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


miquel.raynal@bootlin.com wrote on Sun, 23 Jan 2022 16:23:16 +0100:

> On Sun, 2022-01-16 at 03:22:10 UTC, Ansuel Smith wrote:
> > In the event of a skipped partition (case when the entry name is empty)
> > the kernel panics in the cleanup function as the name entry is NULL.
> > Rework the parser logic by first checking the real partition number and
> > then allocate the space and set the data for the valid partitions.
> > 
> > The logic was also fundamentally wrong as with a skipped partition, the
> > parts number returned was incorrect by not decreasing it for the skipped
> > partitions.
> > 
> > Fixes: 803eb12 ("mtd: parsers: Add Qcom SMEM parser")
> > Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>  
> 
> Applied to https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next, thanks.

Both patches applied on mtd/fixes, actually.
