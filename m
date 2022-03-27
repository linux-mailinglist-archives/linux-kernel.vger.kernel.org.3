Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03534E866A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 09:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiC0HJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 03:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiC0HJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 03:09:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1A21A4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 00:07:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 078F2B80CC7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 07:07:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B93C340EC;
        Sun, 27 Mar 2022 07:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648364852;
        bh=Wy+/kbTqX0Ydc2b+R/ChvMSaHemRdhbRDkg/zZc7cW0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GrN30X4J+g58lJKL5q5KsSFlO4qv2GW8jUEhnyaF01yU7Ugt+cJYQ/WP9lz2cvGYz
         oyuyy1feA5U4RQHk0l5bMaGWS0db9YxQk0yMk2aaa/7MoYUPb941DRDewpMm0fJBI5
         +OzXTQLH6NOyViz6PINYC8ECNtJuCRn2M3AxsSo0=
Date:   Sun, 27 Mar 2022 09:07:28 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yusuf Khan <yusisamerican@gmail.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com,
        mikelley@microsoft.com, mst@redhat.com, javier@javigon.com,
        arnd@arndb.de, will@kernel.org, axboe@kernel.dk,
        Christoph Grenz <christophg+lkml@grenz-bonn.de>
Subject: Re: [PATCH v9 1/3] drivers: ddcci: upstream DDCCI driver
Message-ID: <YkANMPtg7pN7sF0L@kroah.com>
References: <20220327045845.144742-1-yusisamerican@gmail.com>
 <20220327045845.144742-2-yusisamerican@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327045845.144742-2-yusisamerican@gmail.com>
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 26, 2022 at 09:58:43PM -0700, Yusuf Khan wrote:
> This patch adds the main DDCCI driver.
> 
> Signed-off-by: Yusuf Khan <yusisamerican@gmail.com>
> Signed-off-by: Christoph Grenz <christophg+lkml@grenz-bonn.de>
> ---

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
