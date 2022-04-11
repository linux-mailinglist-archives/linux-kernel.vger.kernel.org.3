Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321994FBBF9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 14:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234971AbiDKM1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 08:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbiDKM1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 08:27:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3B2DEDB;
        Mon, 11 Apr 2022 05:24:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3D5261594;
        Mon, 11 Apr 2022 12:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFA0EC385A5;
        Mon, 11 Apr 2022 12:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649679891;
        bh=JWAqPgc7iD1EbdPyywpeDJppdn5+C50+xF16jAEfvEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ss27V85LyEf3va8uUAhMU2T361UsxXasbR9zk5VhBFDgQKKAWrlxbo/ZIRwtKUMm1
         oCaDGoCx0OavbahlsC7PhtGhwerIhAduzFShGEoJNTc2bbYtybz8c8H2rcn2mLoiKM
         r1MTB+/qp5OGpXLViaxgmnHTIekBgR5mBtYvxb3I=
Date:   Mon, 11 Apr 2022 14:24:48 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        balbi@kernel.org, joel@jms.id.au, andrew@aj.id.au,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, alcooperx@gmail.com,
        christophe.jaillet@wanadoo.fr, cai.huoqing@linux.dev,
        benh@kernel.crashing.org, neal_liu@aspeedtech.com,
        miles.chen@mediatek.com, balamanikandan.gunasundar@microchip.com,
        macpaul.lin@mediatek.com, s.shtylyov@omp.ru,
        jakobkoschel@gmail.com, stern@rowland.harvard.edu,
        quic_wcheng@quicinc.com, yashsri421@gmail.com,
        rdunlap@infradead.org, linux-geode@lists.infradead.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] usb: gadget: udc: clean up comments
Message-ID: <YlQeEC41m3UeOeiE@kroah.com>
References: <20220410150828.1891123-1-trix@redhat.com>
 <YlQBgnjpkSurf9PZ@smile.fi.intel.com>
 <ecd8609b-2c52-5fb8-7820-191559d76011@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ecd8609b-2c52-5fb8-7820-191559d76011@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 04:49:00AM -0700, Tom Rix wrote:
> 
> On 4/11/22 3:22 AM, Andy Shevchenko wrote:
> > On Sun, Apr 10, 2022 at 11:08:28AM -0400, Tom Rix wrote:
> > > SPDX
> > > *.h use /* */ style comments
> > > 
> > > For double words, remove
> > > with, also
> > > 
> > > Spelling replacements
> > > wayt to way
> > > wakup to wakeup
> > > Contrl to Control
> > > cheks to checks
> > > initiaization to initialization
> > > dyanmic to dynamic
> > Something really wrong with indentation above.
> > 
> > ...
> > 
> > >   drivers/usb/gadget/udc/amd5536udc.h       | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/core.c | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/ep0.c  | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/hub.c  | 2 +-
> > >   drivers/usb/gadget/udc/aspeed-vhub/vhub.h | 4 ++--
> > >   drivers/usb/gadget/udc/at91_udc.c         | 2 +-
> > >   drivers/usb/gadget/udc/bdc/bdc_core.c     | 4 ++--
> > >   drivers/usb/gadget/udc/core.c             | 4 ++--
> > >   drivers/usb/gadget/udc/trace.h            | 2 +-
> > I believe that Greg's bot asks to split on per-driver basis.
> > OTOH I don't see anything that can be problematic if in one
> > change. So, it's up to maintainers then.
> 
> Yes, whatever folks want. I can split these.
> 
> I have been cleaning up the comments in other areas and am trying to strike
> a balance between too big of a patch vs peppering with many single changes.

Patch series are much easier to review and is just as simple to apply as
a single patch, so that makes it overall better for you to do.

thanks,

greg k-h
