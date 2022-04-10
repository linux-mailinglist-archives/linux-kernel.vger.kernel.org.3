Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5264FAE6B
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243359AbiDJPU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 11:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiDJPUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 11:20:54 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BAC2980A;
        Sun, 10 Apr 2022 08:18:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 49F41CE0FE5;
        Sun, 10 Apr 2022 15:18:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F11C385A4;
        Sun, 10 Apr 2022 15:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649603920;
        bh=yIvrIYuGpHOrzjH4oQy1ZlnyuMsY1S8I+K/sED7d7QI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1NWFl0PPhSiUncXwtxj8dPOJgwu1vYWUWtVUxkTvmRa7rjlbbYdx/XuqYRy5+iIK+
         cbVAFyqCFsnpj6pNRCl2WpSyypnqU+JeoLA7H7gUG79GmB6cKAvtra0BT1+Kl81p60
         QvcivIqZAW7tk1uhNeROif13McOGavVafYQygFEg=
Date:   Sun, 10 Apr 2022 17:18:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     balbi@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, alcooperx@gmail.com,
        christophe.jaillet@wanadoo.fr, cai.huoqing@linux.dev,
        benh@kernel.crashing.org, neal_liu@aspeedtech.com,
        miles.chen@mediatek.com, balamanikandan.gunasundar@microchip.com,
        macpaul.lin@mediatek.com, s.shtylyov@omp.ru,
        jakobkoschel@gmail.com, stern@rowland.harvard.edu,
        andriy.shevchenko@linux.intel.com, quic_wcheng@quicinc.com,
        yashsri421@gmail.com, rdunlap@infradead.org,
        linux-geode@lists.infradead.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] usb: gadget: udc: clean up comments
Message-ID: <YlL1Takwt2s05igD@kroah.com>
References: <20220410150828.1891123-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410150828.1891123-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
> SPDX
> *.h use /* */ style comments
> 
> For double words, remove
> with, also
> 
> Spelling replacements
> wayt to way
> wakup to wakeup
> Contrl to Control
> cheks to checks
> initiaization to initialization
> dyanmic to dynamic
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
>  drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
>  drivers/usb/gadget/udc/at91_udc.c         | 2 +-
>  drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
>  drivers/usb/gadget/udc/core.c             | 4 ++--
>  drivers/usb/gadget/udc/trace.h            | 2 +-
>  9 files changed, 12 insertions(+), 12 deletions(-)
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
