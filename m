Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D765E482C86
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 19:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbiABSGn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 13:06:43 -0500
Received: from isilmar-4.linta.de ([136.243.71.142]:39786 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiABSGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 13:06:36 -0500
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id A49AE201410;
        Sun,  2 Jan 2022 18:06:30 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id DFF0F80654; Sun,  2 Jan 2022 18:37:23 +0100 (CET)
Date:   Sun, 2 Jan 2022 18:37:23 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Cai Huoqing <caihuoqing@baidu.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: Make use of the helper macro
 SET_NOIRQ_SYSTEM_SLEEP_PM_OPS()
Message-ID: <YdHi06jqvg4w8ifP@owl.dominikbrodowski.net>
References: <20210828090011.635-1-caihuoqing@baidu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210828090011.635-1-caihuoqing@baidu.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Sat, Aug 28, 2021 at 05:00:11PM +0800 schrieb Cai Huoqing:
> Use the helper macro SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() instead of
> the verbose operators ".suspend_noirq /.resume_noirq/.freeze_noirq/
> .thaw_noirq/.poweroff_noirq/.restore_noirq", because the
> SET_NOIRQ_SYSTEM_SLEEP_PM_OPS() is a nice helper macro that could
> be brought in to make code a little clearer, a little more concise.
> 
> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>

Applied to pcmcia-next.

Thanks,
	Dominik
