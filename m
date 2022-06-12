Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A99D5478EE
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 06:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiFLEz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 00:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiFLEzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 00:55:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C0419C32
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 21:55:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DB5760B00
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 04:55:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806A0C34115;
        Sun, 12 Jun 2022 04:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1655009753;
        bh=j+exlD5ZmlLNxT1KbEFefcTxveVGoTQlPXTT5epJRck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ltH7y7GteF+GFzn/o+6SxCQaBJsJ7E4zZtlTbGGum7FDMQnev/u26MScXqeDtTvin
         +73NiswAQET7j0G3HjJcqeZLAiR4S0wQnXJM+KyA60W55GzNLW8Tfp0sZ+aN2UqUK6
         ofeOzZ+PxgDI6yCNm6LxLiO+Un90OtjpzOxeVIkM=
Date:   Sun, 12 Jun 2022 06:55:51 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     daniel watson <ozzloy@challenge-bot.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: put spaces after commas
Message-ID: <YqVx12VsxlH1UaRt@kroah.com>
References: <20220612040628.6433-1-ozzloy@challenge-bot.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220612040628.6433-1-ozzloy@challenge-bot.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 09:06:28PM -0700, daniel watson wrote:
> From: Daniel Watson <ozzloy@challenge-bot.com>
> 
> conform to kernel style by putting spaces after commas
> this was found by checkpatch
> 
> Signed-off-by: Daniel Watson <ozzloy@challenge-bot.com>
> ---
>  drivers/staging/r8188eu/include/rtw_iol.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/r8188eu/include/rtw_iol.h b/drivers/staging/r8188eu/include/rtw_iol.h
> index fb88ebc1dabb1..b39ecfb75ade0 100644
> --- a/drivers/staging/r8188eu/include/rtw_iol.h
> +++ b/drivers/staging/r8188eu/include/rtw_iol.h
> @@ -50,13 +50,13 @@ int _rtw_IOL_append_WD_cmd(struct xmit_frame *xmit_frame, u16 addr,
>  int _rtw_IOL_append_WRF_cmd(struct xmit_frame *xmit_frame, u8 rf_path,
>  			    u16 addr, u32 value, u32 mask);
>  #define rtw_IOL_append_WB_cmd(xmit_frame, addr, value, mask)		\
> -	_rtw_IOL_append_WB_cmd((xmit_frame), (addr), (value) ,(mask))
> +	_rtw_IOL_append_WB_cmd((xmit_frame), (addr), (value), (mask))
>  #define rtw_IOL_append_WW_cmd(xmit_frame, addr, value, mask)		\
> -	_rtw_IOL_append_WW_cmd((xmit_frame), (addr), (value),(mask))
> +	_rtw_IOL_append_WW_cmd((xmit_frame), (addr), (value), (mask))
>  #define rtw_IOL_append_WD_cmd(xmit_frame, addr, value, mask)		\
>  	_rtw_IOL_append_WD_cmd((xmit_frame), (addr), (value), (mask))
>  #define rtw_IOL_append_WRF_cmd(xmit_frame, rf_path, addr, value, mask)	\
> -	_rtw_IOL_append_WRF_cmd((xmit_frame),(rf_path), (addr), (value), (mask))
> +	_rtw_IOL_append_WRF_cmd((xmit_frame), (rf_path), (addr), (value), (mask))

These #defines shouldn't even be needed, can you just remove them and
rename the _rtw_IOL_append_WRF_cmd() function to be
rtw_IOL_append_WRF_cmd() (and same for the others), as a patch series?

thanks,

greg k-h
