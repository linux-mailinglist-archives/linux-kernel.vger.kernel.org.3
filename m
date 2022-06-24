Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D11D559C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232846AbiFXOi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiFXOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:37:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C081456C34;
        Fri, 24 Jun 2022 07:37:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 732EAB8292C;
        Fri, 24 Jun 2022 14:37:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE7C7C3411C;
        Fri, 24 Jun 2022 14:37:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656081464;
        bh=hwkWxLhPvE3I9Sum64sHBLZwcLuYQFUFCNO9IhEHEpo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sm3+TvzJ17HUWUEtgIhF2H8go4OXYUIVdKKvRuz4TGlSur5GU+FhNSln64m6C4n/Y
         7UBk3N7GkM7SJQAlk/G9D6PHc9Ew5V+VBKFZaNf1PGR69I6wpKb7ELSPXWc25APNP7
         vmguhzWft30H5nOCZ1kgf7EBuYVESnh4aJG3J8HY=
Date:   Fri, 24 Jun 2022 16:37:41 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Zhangfei Gao <zhangfei.gao@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        acc@openeuler.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/2] fix uacce concurrency issue of uacce_remove
Message-ID: <YrXMNePEO+6ZDysd@kroah.com>
References: <20220624142122.30528-1-zhangfei.gao@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624142122.30528-1-zhangfei.gao@linaro.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:21:20PM +0800, Zhangfei Gao wrote:
> When uacce is working, uacce parent module can be rmmod, parent
> device can also be removed anytime, which may cause concurrency issues.
> Here solve the concurrency issue.
> 
> Jean-Philippe Brucker (1):
>   uacce: Handle parent device removal
> 
> Zhangfei Gao (1):
>   uacce: Handle parent driver module removal
> 
>  drivers/misc/uacce/uacce.c | 135 ++++++++++++++++++++++++-------------
>  include/linux/uacce.h      |   6 +-
>  2 files changed, 92 insertions(+), 49 deletions(-)
> 
> -- 
> 2.36.1
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
