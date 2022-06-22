Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7D15546B7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351719AbiFVJcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbiFVJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:32:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF2CFB03
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 323DFB81CEF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:32:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F367C34114;
        Wed, 22 Jun 2022 09:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655890369;
        bh=dVRKxuJ7ZZmra+kiXqYKdSDrtj+XLC9PNEXLOYasc68=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kmbptiz6nQSPdMo3tKkoJhMJScYdbwJM9K59QAh8jRFR/dT8ylRUZXKE4xjRg3jLC
         /sI8ldIiGqpkigwl2FWzX8YVeWFQZY3exGwRIC/1C9XutrJlWDzhRYEYKaeUqfjqD3
         5w4tzgrteOa7u8GcBeWDeqVNZ0ywDowdtUUWEyXk=
Date:   Wed, 22 Jun 2022 11:32:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Chang Yu <marcus.yu.56@gmail.com>
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] staging: r8188eu: Fixed a function declaration
 coding style issue
Message-ID: <YrLhv4dqb/Qk+HUU@kroah.com>
References: <cover.1655872968.git.marcus.yu.56@gmail.com>
 <778c21724752f2de136d82b31c9ffc2bf35ced55.1655872968.git.marcus.yu.56@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <778c21724752f2de136d82b31c9ffc2bf35ced55.1655872968.git.marcus.yu.56@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 09:52:30PM -0700, Chang Yu wrote:
> Added an identifier name for function definition argument
> 'struct timer_list *' as per checkpatch.pl
> 
> Note that for the same line checkpatch.pl will also complain "extern
> should be avoided in .c". I am not very familiar with the codebase
> so I decided not to move the declaration to a header file.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_recv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
> index 36ea79586992..7e2f5c2f9111 100644
> --- a/drivers/staging/r8188eu/core/rtw_recv.c
> +++ b/drivers/staging/r8188eu/core/rtw_recv.c
> @@ -24,7 +24,7 @@ static u8 rtw_rfc1042_header[] = {
>         0xaa, 0xaa, 0x03, 0x00, 0x00, 0x00
>  };
>  
> -void rtw_signal_stat_timer_hdl(struct timer_list *);
> +void rtw_signal_stat_timer_hdl(struct timer_list *t);

This really should be a static function, not a global one like this.
That is the correct fix to make, can you do that as an add-on patch?

thanks,

greg k-h
