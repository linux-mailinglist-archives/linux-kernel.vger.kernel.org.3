Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29714570867
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231969AbiGKQbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiGKQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:31:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFB527FDB;
        Mon, 11 Jul 2022 09:31:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87C6A611DF;
        Mon, 11 Jul 2022 16:31:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0AAC34115;
        Mon, 11 Jul 2022 16:31:29 +0000 (UTC)
Date:   Mon, 11 Jul 2022 12:31:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Schspa Shi <schspa@gmail.com>, pmladek@suse.com,
        sergey.senozhatsky@gmail.com, linux-rt-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, bigeasy@linutronix.de,
        tglx@linutronix.de, "Luis Claudio R. Goncalves" <lclaudio@uudg.org>
Subject: Re: [PATCH 5.10-rt] printk: fix suppressed message print when
 reboot/panic
Message-ID: <20220711123128.1278e203@gandalf.local.home>
In-Reply-To: <87a6dj3b5c.fsf@jogness.linutronix.de>
References: <20220321053815.71316-1-schspa@gmail.com>
        <87a6dj3b5c.fsf@jogness.linutronix.de>
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


Luis,

Care to add this patch into the 5.10-rt stable?

Thanks,

-- Steve

On Mon, 21 Mar 2022 10:36:55 +0106
John Ogness <john.ogness@linutronix.de> wrote:

> On 2022-03-21, Schspa Shi <schspa@gmail.com> wrote:
> > Update printk_seq for suppressed message.
> >
> > Affects 5.9-rt and 5.10-rt
> >
> > When message is suppressed, printk_seq should be updated, otherwise
> > this message will be printed when reboot. This problem was introduced
> > in commit 3edc0c85d154 ("printk: Rebase on top of new ring buffer").
> >
> > Signed-off-by: Schspa Shi <schspa@gmail.com>  
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>
> 
> Nice catch. Thanks.
> 
> 5.15-rt also has this issue, although the fix is slightly different. For
> 5.15-rt, writing to con->printk_seq (via latched_seq_write()) requires
> the console locked. Would you like to post a patch for 5.15-rt as well,
> or would you like me to do it?
> 
> 5.16 and beyond does not have this issue.
> 
> John Ogness

