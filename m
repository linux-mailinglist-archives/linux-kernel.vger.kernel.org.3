Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91EF449ADF7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 09:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378795AbiAYI0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 03:26:00 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:44484 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351861AbiAYIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 03:22:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4D3A6135B
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 08:22:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ACE7C340E7;
        Tue, 25 Jan 2022 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643098933;
        bh=Nrabr/OcOOvdlimFsaQ4E0HmI1VcpnyJlH3q8ui7feY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2c6pxQPKaOT2f0GK9blLBCXFQU+7q2DhXofcxJ66U9SicjaNqyDZhQam1+u+NXpCY
         2OlbSBQ+9WP/oXAoVtSSePe/8VJlcnxDnNNxxKnd9wpjRWkvY5IxLwc4X7BmDmbI6M
         mDnjkC8rQS1/xQNUWAiqEC/MrdmTU7+4sgVZNyUY=
Date:   Tue, 25 Jan 2022 09:22:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Aleksa =?utf-8?B?VnXEjWtvdmnEhw==?= <aleksav013@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: dio: fixed coding style issues
Message-ID: <Ye+zMg9RzQ97Sb4f@kroah.com>
References: <20220124190201.26741-1-aleksav013@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220124190201.26741-1-aleksav013@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 08:02:01PM +0100, Aleksa Vučković wrote:
> Fixed multiple coding style issues:
> Converting spaces to tabs and moving braces.
> 
> Signed-off-by: Aleksa Vučković <aleksav013@gmail.com>
> ---
>  drivers/dio/dio.c | 150 +++++++++++++++++++++++-----------------------
>  1 file changed, 74 insertions(+), 76 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
