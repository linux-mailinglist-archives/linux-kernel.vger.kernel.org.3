Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29732481B87
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238730AbhL3Kzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:55:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235617AbhL3Kzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:55:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:55:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AE1FB81AA0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:55:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64146C36AE9;
        Thu, 30 Dec 2021 10:55:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640861735;
        bh=dMxn6IBbP5mUEAprk6i4m7xLYEImuyofVPmBHIqkSTU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JomEsqMZbiAIIbzwfzQ2avuBfrAVxV+KhbbIPI9Okc8zQDudEn/C6kGHncgFtNArX
         Xd+D8DmenRWjUvDOEsFkt3yG9jv7nRSwP9RVHLs95py8xvsDn3dexVt2uS6GxaVKzP
         E82GP6nRb0B6JeAU75lsn9o8Pv2tDPcr+RIXDjYM=
Date:   Thu, 30 Dec 2021 11:55:32 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH v5] staging: r8188eu: Remove useless function rtw_test()
Message-ID: <Yc2QJHT0Z3EMxJrv@kroah.com>
References: <20211227113305.86407-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227113305.86407-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 07:33:05PM +0800, Jiapeng Chong wrote:
> This function does nothing, so it should just be deleted entirely.
> 
> Fix following coccicheck warning:
> 
> ./drivers/staging/r8188eu/os_dep/ioctl_linux.c:4253:8-15: WARNING
> opportunity for memdup_user.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Fixes: 2b42bd58b321 ("staging: r8188eu: introduce new os_dep dir for RTL8188eu driver")
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
> Changes in v2:
>   -Modified subject line and commit message.
> 
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 38 --------------------
>  1 file changed, 38 deletions(-)

Does not apply to my tree at all anymore, please rebase and resend.

thanks,

greg k-h
