Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E299F487628
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbiAGLEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:04:23 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40752 "EHLO
        mail.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346962AbiAGLEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:04:22 -0500
Received: from localhost (cpc147930-brnt3-2-0-cust60.4-2.cable.virginm.net [86.15.196.61])
        by mail.monkeyblade.net (Postfix) with ESMTPSA id 9244683FD208;
        Fri,  7 Jan 2022 03:04:19 -0800 (PST)
Date:   Fri, 07 Jan 2022 11:04:13 +0000 (GMT)
Message-Id: <20220107.110413.2041294930969536677.davem@davemloft.net>
To:     christophe.jaillet@wanadoo.fr
Cc:     arnd@arndb.de, hch@infradead.org, akpm@linux-foundation.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 06/16] sparc: Remove usage of the deprecated
 "pci-dma-compat.h" API
From:   David Miller <davem@davemloft.net>
In-Reply-To: <86c6275e55abc16137d316e17a8fa0af53fc96ec.1641500561.git.christophe.jaillet@wanadoo.fr>
References: <cover.1641500561.git.christophe.jaillet@wanadoo.fr>
        <86c6275e55abc16137d316e17a8fa0af53fc96ec.1641500561.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.8 on Emacs 27.2
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.6.2 (mail.monkeyblade.net [0.0.0.0]); Fri, 07 Jan 2022 03:04:21 -0800 (PST)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Thu,  6 Jan 2022 22:51:38 +0100

> In [1], Christoph Hellwig has proposed to remove the wrappers in
> include/linux/pci-dma-compat.h.
> 
> Some reasons why this API should be removed have been given by Julia
> Lawall in [2].
> 
> A coccinelle script has been used to perform the needed transformation.
> It can be found in [3].
> 
> [1]: https://lore.kernel.org/kernel-janitors/20200421081257.GA131897@infradead.org/
> [2]: https://lore.kernel.org/kernel-janitors/alpine.DEB.2.22.394.2007120902170.2424@hadrien/
> [3]: https://lore.kernel.org/kernel-janitors/20200716192821.321233-1-christophe.jaillet@wanadoo.fr/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: David S. Miller <davem@davemloft.net>
