Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C163488A1F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 16:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbiAIPM4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 10:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiAIPMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 10:12:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FB6C06173F;
        Sun,  9 Jan 2022 07:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACDE960E71;
        Sun,  9 Jan 2022 15:12:54 +0000 (UTC)
Received: from jic23-huawei (cpc108967-cmbg20-2-0-cust86.5-4.cable.virginm.net [81.101.6.87])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.kernel.org (Postfix) with ESMTPSA id 13E7EC36AEB;
        Sun,  9 Jan 2022 15:12:50 +0000 (UTC)
Date:   Sun, 9 Jan 2022 15:18:46 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: rzg2l_adc: Fix typo
Message-ID: <20220109151821.09af394d@jic23-huawei>
In-Reply-To: <20220108095306.GA32266@amd>
References: <20220107172529.12361-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
        <20220108095306.GA32266@amd>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jan 2022 10:53:06 +0100
Pavel Machek <pavel@denx.de> wrote:

> On Fri 2022-01-07 17:25:29, Lad Prabhakar wrote:
> > Fix typo RZG2L_ADSMP_DEFUALT_SAMPLING -> RZG2L_ADSMP_DEFAULT_SAMPLING.
> > 
> > Reported-by: Pavel Machek <pavel@denx.de>
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>  
> 
> Reviewed-by: Pavel Machek <pavel@denx.de>
Applied, thanks,

Jonathan

> 
> Thank you.
> 
> Best regards,
> 								Pavel

