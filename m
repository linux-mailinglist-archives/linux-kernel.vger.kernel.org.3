Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984D24FAC4A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232759AbiDJGYp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 02:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbiDJGYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 02:24:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E302954F99
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 23:22:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4DC8260DDC
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 06:22:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 346AAC385A1;
        Sun, 10 Apr 2022 06:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649571751;
        bh=62ZM2k+nlOZ6MmyQlNkdqC5FBtCMerHAYg0IffedikM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iV5I24j6Pe6TIdDBCUkZY3gbpWdcZUHR1BLoBjCSGFTjN1mjVHZQZsgKJJ7bbvkgd
         IyExQYf1YfZ52ssbWqCYxs/w3wof3pTGhme5bZXOagRIdEPnz0ebrQX3jXP7TNfZt+
         JfCAsx4ZyPerlSASyEdR+ZluL/gOC+ev//Q7c05I=
Date:   Sun, 10 Apr 2022 08:22:26 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Liu Junqi <liujunqi@pku.edu.cn>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Leonardo Araujo <leonardo.aa88@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, sparmaintainer@unisys.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Remove D. Kershner from Unisys S-PAR
 maintainers
Message-ID: <YlJ3ot74ZwfGx53i@kroah.com>
References: <20220409205857.32083-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409205857.32083-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 10:58:57PM +0200, Fabio M. De Francesco wrote:
> The email address of David Kershner is no more reachable. Remove his
> entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS.
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba405f6ec31a..3b7497359c2b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20188,7 +20188,6 @@ F:	include/linux/cdrom.h
>  F:	include/uapi/linux/cdrom.h
>  
>  UNISYS S-PAR DRIVERS
> -M:	David Kershner <david.kershner@unisys.com>
>  L:	sparmaintainer@unisys.com (Unisys internal)
>  S:	Supported

If so, then that means this list needs to be dropped and the entry
changed to orphaned :(

thanks,

greg k-h
