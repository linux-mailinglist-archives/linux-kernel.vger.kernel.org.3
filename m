Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9517501916
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239458AbiDNQwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiDNQwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:52:12 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F419D64F8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 09:20:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A7B70B82AA6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 16:20:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D790DC385A1;
        Thu, 14 Apr 2022 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649953248;
        bh=tiyJ2JIyCWlbSvdbIuE1YHMitWL+/q+dCKeO9CWU5no=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=f016bHrdb8UeK2VY3UWMzn2S+oJkTTnC687jvYGQND3PdsLB0RK6WBRKBZofAuSVV
         Xqwvrbn2J8YJLjRR82V8WejkFRL4IeHmzXwxfwARhiakUMphmXhxpthVr+X1QJaWV4
         4Ot4l43yNv5kPYw1Ik+xhkiMi/uh5DOnCXGJGmA4=
Date:   Thu, 14 Apr 2022 18:20:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Adrien Thierry <athierry@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Maxime Ripard <mripard@kernel.org>,
        Takashi Iwai <tiwai@suse.com>, linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: bcm2835-audio: clean code style warnings
Message-ID: <YlhJ3WKKHhUN/l/1@kroah.com>
References: <20220414152340.68932-1-athierry@redhat.com>
 <20220414152340.68932-3-athierry@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414152340.68932-3-athierry@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:23:40AM -0400, Adrien Thierry wrote:
> Clean a few minor code style warnings.
> 
> Reported by checkpatch:
> 
> CHECK: Lines should not end with a '('
> FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:85:
> 
> CHECK: No space is necessary after a cast
> FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c:240:
> 
> CHECK: struct mutex definition without comment
> FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c:14:
> 
> CHECK: struct mutex definition without comment
> FILE: drivers/staging/vc04_services/bcm2835-audio/bcm2835.h:64:
> 
> Signed-off-by: Adrien Thierry <athierry@redhat.com>
> ---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-pcm.c   | 5 ++---
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835-vchiq.c | 2 +-
>  drivers/staging/vc04_services/bcm2835-audio/bcm2835.h       | 2 +-
>  3 files changed, 4 insertions(+), 5 deletions(-)
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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
