Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41304C466F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241049AbiBYNcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:32:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbiBYNco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:32:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9B31BA93B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:32:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB05B61D59
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 13:32:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 982FEC340E7;
        Fri, 25 Feb 2022 13:32:10 +0000 (UTC)
Date:   Fri, 25 Feb 2022 08:32:09 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225083209.24bafe2c@gandalf.local.home>
In-Reply-To: <Yhhj9MLZTrhjSWUE@google.com>
References: <20220224230035.36547137@gandalf.local.home>
        <Yhhh730RX1HpdXp2@google.com>
        <Yhhj9MLZTrhjSWUE@google.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Feb 2022 14:07:00 +0900
Sergey Senozhatsky <senozhatsky@chromium.org> wrote:

> > Steven, did you notice this recently?
> > May I perhaps suggest git bisect? (sorry)  
> 
> On the off chance - do you have this revert in your kernel?
> 
> commit 6a7b9f002eca6788d346c16a6ff0c218b41f8d1d
> Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Date:   Wed Jan 26 14:33:58 2022 +0100
> 
>     Revert "tty: serial: Use fifo in 8250 console driver"
> 
>     This reverts commit 5021d709b31b8a14317998a33cbc78be0de9ab30.
> 
>     The patch is still a bit buggy, and this breaks some other hardware
>     types.  It needs to be resubmitted in a non-buggy way, and make sure the
>     other hardware types also continue to work properly.

My tree does not have this.

I just applied it and I'm building now. I'll let you know if this fixes the
issue or not.

Thanks,

-- Steve
