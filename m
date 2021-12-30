Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38E2481C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239439AbhL3NTl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbhL3NTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:19:35 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8762C061574;
        Thu, 30 Dec 2021 05:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 60B4F616D2;
        Thu, 30 Dec 2021 13:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44040C36AEA;
        Thu, 30 Dec 2021 13:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640870373;
        bh=ZOW008UJxd8/AHVoXx1p3xvPXuC7Bcr4U9YOzazELzY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yefZIJhLqQoPxRVrtzVS2XI6CWTOLdgHEkGZephF+fcWsaAhx86SlxW0FYu5k/KR4
         m3Ux9ZtzrNymhHYq8ReOFS88MynDYPgfEIejoPAeT9Pfg+u8yS4lD/keqv5OC1hGH+
         Zt0NDEmAo0xXhoWJXWRUtmmzKO6qIF9asqKFp7Hk=
Date:   Thu, 30 Dec 2021 14:19:25 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     William Breathitt Gray <vilhelm.gray@gmail.com>,
        linux-iio@vger.kernel.org, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>
Subject: Re: [PATCH v3 05/23] counter: 104-quad-8: Convert to counter_priv()
 wrapper
Message-ID: <Yc2x3ffQN05tcTrO@kroah.com>
References: <20211229154441.38045-1-u.kleine-koenig@pengutronix.de>
 <20211229154441.38045-6-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211229154441.38045-6-u.kleine-koenig@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 04:44:23PM +0100, Uwe Kleine-König wrote:
> This is a straight forward conversion to the new counter_priv() wrapper.
> 
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/counter/104-quad-8.c | 58 ++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)

This patch fails to apply to my tree:

checking file drivers/counter/104-quad-8.c
Hunk #1 succeeded at 112 (offset -1 lines).
Hunk #2 succeeded at 130 (offset -1 lines).
Hunk #3 succeeded at 162 (offset -1 lines).
Hunk #4 succeeded at 212 (offset -1 lines).
Hunk #5 succeeded at 242 (offset -1 lines).
Hunk #6 succeeded at 304 (offset -1 lines).
Hunk #7 succeeded at 334 (offset -1 lines).
Hunk #8 succeeded at 397 with fuzz 1 (offset -2 lines).
Hunk #9 FAILED at 442.
Hunk #10 succeeded at 495 (offset -2 lines).
Hunk #11 succeeded at 507 (offset -2 lines).
Hunk #12 succeeded at 536 (offset -2 lines).
Hunk #13 succeeded at 548 (offset -2 lines).
Hunk #14 succeeded at 587 (offset -2 lines).
Hunk #15 succeeded at 612 (offset -2 lines).
Hunk #16 succeeded at 659 (offset -2 lines).
Hunk #17 succeeded at 669 (offset -2 lines).
Hunk #18 succeeded at 697 (offset -2 lines).
Hunk #19 succeeded at 708 (offset -2 lines).
Hunk #20 succeeded at 734 (offset -2 lines).
Hunk #21 succeeded at 753 (offset -2 lines).
Hunk #22 succeeded at 778 (offset -2 lines).
Hunk #23 succeeded at 805 (offset -2 lines).
Hunk #24 succeeded at 816 (offset -2 lines).
Hunk #25 succeeded at 843 (offset -2 lines).
Hunk #26 succeeded at 873 (offset -2 lines).
Hunk #27 succeeded at 885 (offset -2 lines).
Hunk #28 succeeded at 911 (offset -2 lines).
Hunk #29 succeeded at 922 (offset -2 lines).
1 out of 29 hunks FAILED

Please rebase and resend the series against my char-misc-next branch.

thanks,

greg k-h
