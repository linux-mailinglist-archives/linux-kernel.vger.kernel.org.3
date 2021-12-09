Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D373646E2C8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 07:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbhLIGyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 01:54:35 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42690 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231487AbhLIGye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 01:54:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A031CE2424;
        Thu,  9 Dec 2021 06:51:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94127C341C8;
        Thu,  9 Dec 2021 06:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639032658;
        bh=Y8ia7sO/6Urs5myOKErTCIAHvtl623l8ADMiE0qzM1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lYEQJEwYainl775nrLAU7h0sHh7LXZ/AfbP3c24TQMSymd05bXW41s3qd2+K0id8E
         k9HBnOvkFlHXE9nwSdX1+e3xXttLD0mgvlVFu4FS1xosgGn8ObiIBj4Ho7jUJjTZLL
         H4kDeDBBGB+GMI0jzLSY8+U0vGTqlwb3X2MkGC7U=
Date:   Thu, 9 Dec 2021 07:50:50 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     Ricky WU <ricky_wu@realtek.com>
Cc:     "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mmc: rtsx: improve performance for multi block rw
Message-ID: <YbGnSheDLPNzkc+G@kroah.com>
References: <1d97432a46a4467bb8e0a4fa5a7bdf6e@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d97432a46a4467bb8e0a4fa5a7bdf6e@realtek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 06:40:55AM +0000, Ricky WU wrote:
> Improving performance for the CMD is multi-block read/write
> and the data is sequential.
> sd_check_multi_seq() to distinguish multi-block RW (CMD 18/25)
> or normal RW (CMD 17/24) if the CMD is multi-block and the data is
> sequential then call to sd_rw_multi_seq()
> 
> Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
> ---
>  drivers/mmc/host/rtsx_pci_sdmmc.c | 185 +++++++++++++++++++++++++++++-
>  1 file changed, 180 insertions(+), 5 deletions(-)
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
