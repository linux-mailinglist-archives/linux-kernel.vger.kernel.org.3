Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BD7D53E0BC
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 08:03:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiFFFtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 01:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbiFFFtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 01:49:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC972DA8E
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 22:49:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5797E60F9E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 05:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51EE3C385A9;
        Mon,  6 Jun 2022 05:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654494568;
        bh=bvq1JRPilmHtlKkjFDH6DUlt2t9c+LWSpYiZiLwBmsc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=taW66KvRj6AIi30v46IlXtETnYb24uA43Fe6oFUn4ZV8732w13Ica+/dv5tzlWuBJ
         lHn+x1L4lesdvnTLqVx4yrei5ixU98wzoho/BRqzBgH5bsmK6H75CuB0zrKOsvn2gA
         4WwEVo34B6KKzydPVGwrZ+vXKbaMa85N9A/fJYOg=
Date:   Mon, 6 Jun 2022 07:49:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        straube.linux@gmail.com, dan.carpenter@oracle.com,
        fmdefrancesco@gmail.com, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 4/4] MAINTAINERS: add myself as r8188eu reviewer
Message-ID: <Yp2VZkfEv2pemEDi@kroah.com>
References: <cover.1652993983.git.paskripkin@gmail.com>
 <7656c9eb3d430524373f4826714f7d205480c3e2.1652993983.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7656c9eb3d430524373f4826714f7d205480c3e2.1652993983.git.paskripkin@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022 at 12:10:08AM +0300, Pavel Skripkin wrote:
> I was reviewing r8188eu patches for a while, but I am missing some of
> them, since I am not in CC list. I want to be CC'ed to help reviewing
> and testing more patches.
> 
> Acked-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
> ---
> 
> Changes since v1:
> 	- Added Dan's Ack. Thanks to Dan! :)
> 
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0a635f2ae5b9..bd38a2e465cc 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -18716,6 +18716,7 @@ F:	drivers/staging/olpc_dcon/
>  STAGING - REALTEK RTL8188EU DRIVERS
>  M:	Larry Finger <Larry.Finger@lwfinger.net>
>  M:	Phillip Potter <phil@philpotter.co.uk>
> +R:	Pavel Skripkin <paskripkin@gmail.com>

For obvious reasons, I can't take changes like this unless the
maintainers agree with it.

thanks,

greg k-h
