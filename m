Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E2E4C5462
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiBZH0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiBZH0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:26:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5B7164D2C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:26:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01CCC60DFB
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:26:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBFBC340E8;
        Sat, 26 Feb 2022 07:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645860361;
        bh=8wbO9/pBPL45mNpvuDt+/stdILD+iFAY5PrRIKv1krA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2wOfC3YO3R3Apwl03V/UXG3lnDriu66U0gfhKHsSteMfPuqmc40FvOxDbbBoF1sh
         eFOCDx1wpEYC8kHfRvoCdilx9XsM1jJEywBq67B3g8g96L8xHuCMxE1WwsarIiuhcE
         YDd2t8zLcMG/GbGZYfzGPMN4yHjWixeKQcrAm4nU=
Date:   Sat, 26 Feb 2022 08:25:56 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        bjorn.andersson@linaro.org
Subject: Re: [PATCH v2] drivers: ddcci: upstream DDCCI driver
Message-ID: <YhnWBBhiG7+1moqs@kroah.com>
References: <20220226040429.1035368-1-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220226040429.1035368-1-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:04:29PM -0800, Yusuf Khan wrote:
> This patch upstreams the DDCCI driver by Christoph Grenz into
> the kernel. The original gitlab page is loacted at https://gitlab
> .com/ddcci-driver-linux/ddcci-driver-linux/-/tree/master.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> ---
>  drivers/Kconfig                 |    2 +
>  drivers/Makefile                |    1 +
>  drivers/ddcci/Kconfig           |    5 +
>  drivers/ddcci/Makefile          |    3 +
>  drivers/ddcci/ddcci-backlight.c |  411 +++++++
>  drivers/ddcci/ddcci.c           | 1887 +++++++++++++++++++++++++++++++
>  include/linux/ddcci.h           |  164 +++
>  7 files changed, 2473 insertions(+)
>  create mode 100644 drivers/ddcci/Kconfig
>  create mode 100644 drivers/ddcci/Makefile
>  create mode 100644 drivers/ddcci/ddcci-backlight.c
>  create mode 100644 drivers/ddcci/ddcci.c
>  create mode 100644 include/linux/ddcci.h
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
