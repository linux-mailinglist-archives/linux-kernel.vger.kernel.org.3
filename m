Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B02A5478B2B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235937AbhLQMO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:14:28 -0500
Received: from muru.com ([72.249.23.125]:39462 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhLQMO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:14:27 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 038D280FB;
        Fri, 17 Dec 2021 12:15:09 +0000 (UTC)
Date:   Fri, 17 Dec 2021 14:14:24 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     cgel.zte@gmail.com
Cc:     linux@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ye Guojin <ye.guojin@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH] ARM: OMAP2+: adjust the location of put_device() call in
 omapdss_init_of
Message-ID: <Ybx/IHXc9BRfT+pR@atomide.com>
References: <20211116062726.154689-1-ye.guojin@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211116062726.154689-1-ye.guojin@zte.com.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* cgel.zte@gmail.com <cgel.zte@gmail.com> [211116 08:28]:
> From: Ye Guojin <ye.guojin@zte.com.cn>
> 
> This was found by coccicheck:
> ./arch/arm/mach-omap2/display.c, 272, 1-7, ERROR missing put_device;
> call of_find_device_by_node on line 258, but without a corresponding
> object release within this function.
> 
> Move the put_device() call before the if judgment.

Thanks applying into omap-for-v5.17/fixes-not-urgent.

Tony
