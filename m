Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8745A9996
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 16:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbiIAOAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 10:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIAOAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 10:00:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCBF2240A4;
        Thu,  1 Sep 2022 07:00:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 58005619DD;
        Thu,  1 Sep 2022 14:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5531EC433C1;
        Thu,  1 Sep 2022 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662040812;
        bh=Vh88NBX/NAkzOwMjWKVdC/jjKxlDpWFCklcVugtnlVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gu9JKsQEwRblBPlbrbIpbvHe/gHIz4uvDOffSJUbRFMeYLdP+Yryu6eHydPRqWgw9
         poEAfgrnNg+G4teIVHKjUdxL56FXJl9AW7GSkUxy1x+2yyqrQi1c6wjd78G8D0n9RI
         yQsyM64Mp6PWnk2Je4iRga2+1f3n9mf4A7QgY2lE=
Date:   Thu, 1 Sep 2022 16:00:09 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] serial: Add uart_xmit_advance() + fixes part (of
 a larger patch series)
Message-ID: <YxC66RkxUSVJxWRe@kroah.com>
References: <20220830131343.25968-1-ilpo.jarvinen@linux.intel.com>
 <c83d6b94-b589-ebbf-303f-1de084bc5676@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c83d6b94-b589-ebbf-303f-1de084bc5676@linux.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 04:19:40PM +0300, Ilpo Järvinen wrote:
> On Tue, 30 Aug 2022, Ilpo Järvinen wrote:
> 
> > Add uart_xmit_advance() helper to handle circular xmit buffer
> > advancement + accounting of Tx'ed bytes. Use it to fix a few drivers
> > that previously lacked to accounting for DMA Tx.
> > 
> > Greg,
> > I've a another series on top this which is tty-next material making the
> > rest of the drivers to use uart_xmit_advance(). That series obviously
> > depends on the patch 1/3 of this series so if you end up putting these
> > 3 patches into tty-linus, I'll need it to be merged into tty-next at
> > some point (I'm not in a big hurry with this so if you choose to delay
> > the merge, it's not a big deal).
> 
> This merge, btw, is no longer that important because I agreed with Jiri to 
> wait for his tx loop rewrite series.

Ok, I'll drop this series for now.

thanks,

greg k-h
