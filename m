Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB4A59F3DA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 09:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiHXHAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 03:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiHXG76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 02:59:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9384C80EB1;
        Tue, 23 Aug 2022 23:59:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DB07615FE;
        Wed, 24 Aug 2022 06:59:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F278C433C1;
        Wed, 24 Aug 2022 06:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661324396;
        bh=kUhuHogZRdcbp2ZJRCL/8SIulY/GyA5TeDzl1V6BBgU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x+kdHtYBKuP3Eijlysoi+VdnEELMuRIzTVB8DRlYxNVc5K37RIf4ysXNrHoozVk/H
         FO3GtHpHt3rrHPXd8MBCX4n9iUaHmg+Jzt22CM5XO+e9U5k6Gd9pcTPZUj2bSdrfPr
         +2xRT81FVds52OQxNVJm3rlxpY3YVxduGL0m9yXA=
Date:   Wed, 24 Aug 2022 08:59:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hu Xiaoying <huxiaoying2008@gmail.com>
Cc:     usb-storage@lists.one-eyed-alien.net, linux-usb@vger.kernel.org,
        stern@rowland.harvard.edu, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-media@vger.kernel.org
Subject: Re: Confirmation for subscribe linux-usb
Message-ID: <YwXMaUexmgIrnI4W@kroah.com>
References: <S240916AbiHWHMh/20220823071237Z+20120@vger.kernel.org>
 <CABd4Uja9SoHpiMr2gDFcEP2Cudp7dcWJ_2i+KTEse9CU=KMtzw@mail.gmail.com>
 <CABd4UjYB=nzha=eoogNJU4pFwW9+4PQ65bC5u=R-gCE_ZLSQXw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABd4UjYB=nzha=eoogNJU4pFwW9+4PQ65bC5u=R-gCE_ZLSQXw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 02:36:55PM +0800, Hu Xiaoying wrote:
> submit patch
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

- Your patch was attached, please place it inline so that it can be
  applied directly from the email message itself.

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
