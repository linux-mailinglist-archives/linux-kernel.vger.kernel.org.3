Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F09E508D9F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380761AbiDTQtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380497AbiDTQtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791C244A20
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 09:47:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 175E861A5A
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 16:47:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED7DC385A0;
        Wed, 20 Apr 2022 16:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650473223;
        bh=4fRcsXUhyVGIx/AjQuBcKxjrSKJPAxMI3mcZszc6S1A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ns/VOAU3hEltoED5s7v6fzhSb0W6hQRhd/5yUdx1pv7ZV8nNNrxsmkd9gpybhTW4A
         HD0TBIT5tMO+z2aDZIf0Vh/YsMTOWynaCjKWT1cmI3Hrxbx+D0CLzMl2Y1UNWd++fK
         5NE2BJu1ULUgMZ9OGwE1Pz1GgJQU33dtloYIxbQg=
Date:   Wed, 20 Apr 2022 18:47:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Artur Bujdoso <artur.bujdoso@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Hans de Goede <hdegoede@redhat.com>,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH v2] staging: rtl8723bs: remove leftover code for other
 chips
Message-ID: <YmA5BM2Fkie5xMk/@kroah.com>
References: <Yl8bCE8Rjh/w4Ogz@crux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8bCE8Rjh/w4Ogz@crux>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 10:26:48PM +0200, Artur Bujdoso wrote:
> Clean up unreferenced definitions in hal headers and code.
> 
> Signed-off-by: Artur Bujdoso <artur.bujdoso@gmail.com>
> ---
>  drivers/staging/rtl8723bs/hal/HalBtcOutSrc.h  |  11 -
>  drivers/staging/rtl8723bs/hal/hal_btcoex.c    |   8 -
>  drivers/staging/rtl8723bs/include/HalVerDef.h |  10 -
>  .../staging/rtl8723bs/include/hal_com_reg.h   | 295 ------------------
>  4 files changed, 324 deletions(-)
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
