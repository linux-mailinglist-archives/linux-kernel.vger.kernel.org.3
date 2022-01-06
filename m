Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECB574865E5
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:15:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240024AbiAFOPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239888AbiAFOPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:15:46 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC46C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 06:15:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E88B61A32
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 14:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE104C36AE3;
        Thu,  6 Jan 2022 14:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641478545;
        bh=kcvI9ZzlAFYQBbxp/0M3tfZnpk9RTo5pBy0X5WvTUd0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IkeV23DoOX+j5K6xUmO44sdnJWL4Fxyab3t3v4vF6YZwIyKjYIOm1TvLiqWfy6oYp
         RWZzOG9H8kNDuS6dX4uS1GoX/V/Cktewc68aoPW9nGp2e6LGmTd1L3LzKmC7Ik2xxh
         BzetE0U2zGt9dDFF2g+j88xCeigiT0cpX4MdFZWg=
Date:   Thu, 6 Jan 2022 15:15:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alberto Merciai <alb3rt0.m3rciai@gmail.com>
Cc:     linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: rename camelcase variable peerMAC to
 peer_mac
Message-ID: <Ydb5jsA16sWGBjCN@kroah.com>
References: <20220104165236.462551-1-alb3rt0.m3rciai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104165236.462551-1-alb3rt0.m3rciai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 05:52:32PM +0100, Alberto Merciai wrote:
> Rename camelcase variable peerMAC to peer_mac.
> 
> Signed-off-by: Alberto Merciai <alb3rt0.m3rciai@gmail.com>
> ---
>  drivers/staging/r8188eu/os_dep/ioctl_linux.c | 46 ++++++++++----------
>  1 file changed, 23 insertions(+), 23 deletions(-)

This patch does not apply to my tree at all, sorry.

Please rebase and resend.

thanks,

greg k-h
