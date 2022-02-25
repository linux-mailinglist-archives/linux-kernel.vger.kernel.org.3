Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07BD94C46FF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 14:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239466AbiBYN6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 08:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiBYN6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 08:58:02 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C53DD45ADD
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 05:57:29 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 21PDv7J7019333;
        Fri, 25 Feb 2022 14:57:07 +0100
Date:   Fri, 25 Feb 2022 14:57:07 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     David Laight <David.Laight@aculab.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: Strange output on the console
Message-ID: <20220225135707.GA19322@1wt.eu>
References: <20220224230035.36547137@gandalf.local.home>
 <61226fc12ff9459d8daed8e346d6ab94@AcuMS.aculab.com>
 <20220225063637.GA18039@1wt.eu>
 <1dcb185901f04a5ea2476a449e371167@AcuMS.aculab.com>
 <20220225103239.GA18720@1wt.eu>
 <32a7af26f4494f47a03a6d965ac7c99a@AcuMS.aculab.com>
 <20220225122546.GB18720@1wt.eu>
 <20220225082850.2277179f@gandalf.local.home>
 <20220225134056.GE18720@1wt.eu>
 <20220225084424.1950c547@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225084424.1950c547@gandalf.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 08:44:24AM -0500, Steven Rostedt wrote:
> On Fri, 25 Feb 2022 14:40:56 +0100
> Willy Tarreau <w@1wt.eu> wrote:
> 
> > Maybe you could try to change the config on the receiver to try to resync
> > with what it sent and see if you figure what setting is being used ? I
> > would personally try to set it to 7 bit with 1 stop and no parity, same
> > baud rate just to see.
> 
> It appears to be a bug in the kernel and the commit was reverted.
> 
> I Cc'd you on my reply.
> 
>   https://lore.kernel.org/all/Yhhj9MLZTrhjSWUE@google.com/

Yep, just seen, I received it after responding. Another happy end!

Willy
