Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A29934C41A1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 10:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiBYJk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 04:40:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbiBYJkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 04:40:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD20B239335;
        Fri, 25 Feb 2022 01:39:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3F3A3CE2396;
        Fri, 25 Feb 2022 09:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5366DC340E7;
        Fri, 25 Feb 2022 09:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645781990;
        bh=eArH+Pc1LCyVtAnnB0CP/tkL4ckzfLpnsQhqWk8CasU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jqgalOSZZ0oWhmNhkN6vf0BwdohJCFL8ESK6r2mh3syB4MimO8YHZXqFVMCmSm1Dr
         ul0iVAdiiyFYeUEv/OLwtsEw9vndpyTL86YZoqiMPia0y5j0syD5nhVJjfqtc16yDi
         7ZYDeiOxfM7Ikl18hFhMtxIgFHyKLfADLMjWn4h8=
Date:   Fri, 25 Feb 2022 10:39:48 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tty: serial: various cleanups
Message-ID: <Yhij5DkA0n/QNue+@kroah.com>
References: <20220224111028.20917-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220224111028.20917-1-jslaby@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 12:10:23PM +0100, Jiri Slaby wrote:
> This is a small cleanup series of what I have accumulated over past few
> weeks while doing larger changes.
> 
> Jiri Slaby (5):
>   tty: serial: mpc52xx_uart: make rx/tx hooks return unsigned
>   tty: serial: serial_txx9: remove info print from init
>   tty: serial: serial_txx9: remove struct uart_txx9_port
>   tty: serial: amba-pl010: use more uart_port pointers
>   tty: serial: lpc32xx_hs: use serial_lpc32xx_stop_tx() helper
> 
>  drivers/tty/serial/amba-pl010.c   | 174 +++++++-------
>  drivers/tty/serial/lpc32xx_hs.c   |  10 +-
>  drivers/tty/serial/mpc52xx_uart.c |  22 +-
>  drivers/tty/serial/serial_txx9.c  | 369 ++++++++++++++----------------
>  4 files changed, 266 insertions(+), 309 deletions(-)

Patch 3/6 did not apply to my tree for some reason.  Can you rebase and
resend just that one?

thanks,

greg k-h
