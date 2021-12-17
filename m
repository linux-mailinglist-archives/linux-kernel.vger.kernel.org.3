Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0B34478B29
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbhLQMOU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:14:20 -0500
Received: from muru.com ([72.249.23.125]:39448 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229891AbhLQMOS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:14:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id CB04880FB;
        Fri, 17 Dec 2021 12:15:00 +0000 (UTC)
Date:   Fri, 17 Dec 2021 14:14:16 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Paul Walmsley <paul@pwsan.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] ARM: OMAP2+: hwmod: Add of_node_put() before break
Message-ID: <Ybx/GOt2v2NC9yqZ@atomide.com>
References: <20211014085719.23739-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211014085719.23739-1-wanjiabing@vivo.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wan Jiabing <wanjiabing@vivo.com> [211014 11:58]:
> Fix following coccicheck warning:
> ./arch/arm/mach-omap2/omap_hwmod.c:753:1-23: WARNING: Function
> for_each_matching_node should have of_node_put() before break
> 
> Early exits from for_each_matching_node should decrement the
> node reference counter.

Thanks adding into omap-for-v5.17/fixes-not-urgent.

Tony
