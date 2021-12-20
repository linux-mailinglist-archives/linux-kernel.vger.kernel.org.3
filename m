Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 555BB47B07B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237247AbhLTPkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:40:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:35464 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbhLTPke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:40:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1637AB80EF4;
        Mon, 20 Dec 2021 15:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43A54C36AE7;
        Mon, 20 Dec 2021 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1640014831;
        bh=Xoihq8kvKvktAGd2hXqEi3P1s3byYn9KFsMfwXpRhXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5UGZpjRt9y92DXCtQ5ldWCj+StRaSayDxNFEc4ZzfG/hZn0Xg+oFuoklfwN4mHyI
         zBfCZ1zT4MoCkLtrpgCy9zq6pbRjokXsb3jJHrevBsxEAxBPr7SBGEM6YbS4+MBJi0
         bTpzGXgU3U6k291aNziTnxE0p/xt9fXK+DKnH0fk=
Date:   Mon, 20 Dec 2021 16:40:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: timbuart: Check for null res pointer
Message-ID: <YcCj7cj4JlCwoyhH@kroah.com>
References: <20211220082127.883885-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220082127.883885-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 20, 2021 at 04:21:27PM +0800, Jiasheng Jiang wrote:
> The return value of platform_get_resource() needs to be checked.
> To avoid use of error pointer in case that there is no suitable
> resource.
> 
> Fixes: ab4382d27412 ("tty: move drivers/serial/ to drivers/tty/serial/")

No it does not.  I thought I said that already.

I am going to just add your emails to a "ignore filter" for a while.
Your changes are not correct, and when asked about them, you just send
another version of the patch, which is not how to have a conversation
about a review.

good luck,

greg k-h
