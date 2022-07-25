Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8232657FBED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:04:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234395AbiGYJEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233478AbiGYJEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:04:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D583615707;
        Mon, 25 Jul 2022 02:04:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E187B80D81;
        Mon, 25 Jul 2022 09:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12742C341C6;
        Mon, 25 Jul 2022 09:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658739884;
        bh=399BEzla65T2amc+Ztm8fCHBt0jm5XCxQ/AaEzftc2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N32e4TgORE3i5LmV4Axg2W3/dx7ROJVuWcNzE3ZQLCD2i4XMlyN2muyRDGAFJuyBL
         7aA6YnxLZYgnx/GrbjZ6uzTqaVeizQLSZ71cDmhr3wT7ikZcemsF8N2KDfWzvS0f8+
         534u5c2yaGQL1dNv3HI1PlKUfPxOALdYe65+9o8s=
Date:   Mon, 25 Jul 2022 11:04:39 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: fix tty-port initialized comments
Message-ID: <Yt5cpx7iEIMEwqNb@kroah.com>
References: <20220725084457.3010-1-johan@kernel.org>
 <Yt5aIiA8mvU905eB@kroah.com>
 <Yt5bGx79ymjsrK2A@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yt5bGx79ymjsrK2A@hovoldconsulting.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:58:03AM +0200, Johan Hovold wrote:
> On Mon, Jul 25, 2022 at 10:53:54AM +0200, Greg Kroah-Hartman wrote:
> > On Mon, Jul 25, 2022 at 10:44:57AM +0200, Johan Hovold wrote:
> > > Fix up the tty-port initialized comments which got truncated and
> > > obfuscated when replacing the old ASYNCB_INITIALIZED flag.
> > > 
> > > Fixes: d41861ca19c9 ("tty: Replace ASYNC_INITIALIZED bit and update atomically")
> > > Signed-off-by: Johan Hovold <johan@kernel.org>
> > 
> > Looks good, want me to take this now as my tree should be "closed" for
> > 5.20-rc1 now, but stuff like this can sneak in.
> 
> I was hoping to be able to use that extra week that -rc8 bought us.

Yeah, -rc8 has got us a few more days.

> I have a three trivial cleanups in my -next branch. Mind if I add this
> one on top and send it to you straight away?

Sure, please do!

greg k-h
