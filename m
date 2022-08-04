Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F3B589B04
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232448AbiHDL0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:26:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239031AbiHDLZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:25:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42E463C7;
        Thu,  4 Aug 2022 04:25:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F66F61740;
        Thu,  4 Aug 2022 11:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FC9EC433C1;
        Thu,  4 Aug 2022 11:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659612342;
        bh=IF6SbhssTpM3bUr5PWdFXbj2hE9snUllT+gSdTuIUbk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FUvcvNVDPHQ8+RgZmovIJWL/e7ODe+s0WFWqwmx02U0wQzSJg+cMAoyuG3FBL+87N
         ZnUUULFkAJpMuYPu9SJA1ULUvOmF2jEGND/rs7kDt9YZnkLBPLpj+ZRe8QCit6S2cD
         qPMt9W0k6w8PEbZUdRSG+3HBcmi/GRB7kZ5LI4qc=
Date:   Thu, 4 Aug 2022 13:25:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ray Hung <tw.rayhung@gmail.com>
Cc:     balbi@kernel.org, akpm@linux-foundation.org, dh10.jung@samsung.com,
        songmuchun@bytedance.com, dan.carpenter@oracle.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: rndis: use %u instead of %d to print u32
 values
Message-ID: <YuustIMaImn+0UYc@kroah.com>
References: <20220804110836.138614-1-tw.rayhung@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804110836.138614-1-tw.rayhung@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 04, 2022 at 07:08:36PM +0800, Ray Hung wrote:
> The driver uses the %d format to print u32 values. The correct
> format is %u. Fix it.
> 
> Signed-off-by: Ray Hung <tw.rayhung@gmail.com>
> ---
>  drivers/usb/gadget/function/rndis.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/function/rndis.c b/drivers/usb/gadget/function/rndis.c
> index 713efd9aefde..10ba339bcea4 100644
> --- a/drivers/usb/gadget/function/rndis.c
> +++ b/drivers/usb/gadget/function/rndis.c
> @@ -1105,7 +1105,7 @@ static int rndis_proc_show(struct seq_file *m, void *v)
>  			 "used      : %s\n"
>  			 "state     : %s\n"
>  			 "medium    : 0x%08X\n"
> -			 "speed     : %d\n"
> +			 "speed     : %u\n"
>  			 "cable     : %s\n"
>  			 "vendor ID : 0x%08X\n"
>  			 "vendor    : %s\n",
> -- 
> 2.25.1
> 

What commit id does this fix?

And given this is only for debugging, there's no rush, right?

thanks,

greg k-h
