Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33394FDEC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236806AbiDLL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345829AbiDLL44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:56:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44F8260CCB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:41:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2E2EB81C9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 325EDC385A1;
        Tue, 12 Apr 2022 10:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649760090;
        bh=rzfnknouQo5spyE2oJ6VE8AOEpQ+Y5ZYUDR0kz+9OVc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDZ0iKHFFnabFQIaa82O7sHgKBb5LcVgEyFz1DPLMR6R6VoM+kFf6WUVIhBDVd6ZP
         taP+8yA7WeqdWfgNNBrdhugZbsktvG8WLiBlX1Cvaneqfg/XnV8HFmaBpXjLiEQZ2Y
         pURIIQ81cvB2pAOD+jzCRUrvzE0w9BtfghCTQZEo=
Date:   Tue, 12 Apr 2022 12:41:27 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Liu Junqi <liujunqi@pku.edu.cn>,
        Bart Van Assche <bvanassche@acm.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        sparmaintainer@unisys.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: Remove D. Kershner from Unisys S-PAR
 maintainers
Message-ID: <YlVXV4J41KBzKHtm@kroah.com>
References: <20220412103629.8029-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412103629.8029-1-fmdefrancesco@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2022 at 12:36:29PM +0200, Fabio M. De Francesco wrote:
> The email address of David Kershner is no more reachable. Remove his
> entry from the MAINTAINERS file for UNISYS S-PAR DRIVERS and change
> the status to "Orphan".
> 
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> ---
> 
> v1->v2: Change also the status of the entry to "Orphan" and rework the
> commit message. (Thanks to Greg Kroah-Hartman).
> 
>  MAINTAINERS | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3ed62dcd144e..9283c63565b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -20184,9 +20184,8 @@ F:	include/linux/cdrom.h
>  F:	include/uapi/linux/cdrom.h
>  
>  UNISYS S-PAR DRIVERS
> -M:	David Kershner <david.kershner@unisys.com>
>  L:	sparmaintainer@unisys.com (Unisys internal)

Again, please drop this "list" as it obviously is not going to anyone.

And really, this whole code should be removed, no one seems to be using
it, and if they are, we can easily revert the removal and mark them as
the maintainer.

thanks,

greg k-h
