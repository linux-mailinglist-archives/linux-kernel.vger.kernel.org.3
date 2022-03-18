Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C054DD99E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236230AbiCRMU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236224AbiCRMUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:20:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A945193226;
        Fri, 18 Mar 2022 05:19:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9697161865;
        Fri, 18 Mar 2022 12:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84658C36AF8;
        Fri, 18 Mar 2022 12:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1647605943;
        bh=19AlHIQ/CS5s6rs1YQGBfqvcfZuhfwWiLMpeXi48vmM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JLWHhXiSnLs9MwOta8eww1122sDoebX/txoVWIU12Lm0ENlMBsXIGDzI9ljUoIb9h
         8bKjDKrJ8DUdiCWwE5OUGVxD+7c3vQedFZsXLiVvGgRTrCEbDgbcgEFCc7qXFo8wvJ
         IKiWMbMY3dSTPULX3jvkjrt3Zcv236OGN4b0RfKY=
Date:   Fri, 18 Mar 2022 13:10:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PING][PATCH v3 0/2] serial: 8250: Fixes for Oxford
 Semiconductor 950 UARTs
Message-ID: <YjR2zeyAfeXHVa+0@kroah.com>
References: <alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk>
 <alpine.DEB.2.21.2203011748460.11354@angie.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2203011748460.11354@angie.orcam.me.uk>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 08:52:25PM +0000, Maciej W. Rozycki wrote:
> On Sat, 12 Feb 2022, Maciej W. Rozycki wrote:
> 
> >  Here's v3 of the outstanding fixes for Oxford Semiconductor 950 UARTs.  
> > As the change for the default FIFO rx trigger level has been already 
> > merged with commit d7aff291d069 ("serial: 8250: Define RX trigger levels 
> > for OxSemi 950 devices") only one patch of the original series remains.  
> 
>  Ping for:
> 
> <https://lore.kernel.org/lkml/alpine.DEB.2.21.2202100424280.34636@angie.orcam.me.uk/>

These aren't in my review queue, can you resend?

thanks,

greg k-h
