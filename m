Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8938D480B21
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:14:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhL1QOJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235159AbhL1QOH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:14:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61B32C061574
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 08:14:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 29F26B8125D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 16:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCC0C36AE7;
        Tue, 28 Dec 2021 16:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640708044;
        bh=8pgeOPA8EqGCFEfOIbMvaFwgkk4HKoIO5on3e+sDTLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NGI3XRUg8Sh6IVWeqZh/8rjtALG/l8Iozdk1pklnZwAHIcF1G5xTM7MOsk3AEItn0
         ziNIduXLMrjqRHmJAE+Z6J8rAWXiiVP8Gr6FnuXvYdp1K889k193XKEfcsKKNtmuwx
         k7dLlnyiKwAblrSVf5b0mBdEYHacPGDRm8QdbYPM=
Date:   Tue, 28 Dec 2021 17:14:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] staging: r8188eu: clean up private ioctls
Message-ID: <Ycs3yiJMSWSeehJS@kroah.com>
References: <20211226212535.197989-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211226212535.197989-1-martin@kaiser.cx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 26, 2021 at 10:25:25PM +0100, Martin Kaiser wrote:
> Clean up the definitions of private ioctls.
> (Maybe it would make more sense to remove them completely?)

If none of them are really "standard", then yes, they should be removed.

At the very least, the correct macros should be used for the remaining
ones.

I'll go queue this up now, thanks!

greg k-h
