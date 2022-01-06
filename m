Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3E4869B7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 19:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242723AbiAFSZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 13:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240698AbiAFSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 13:25:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46208C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:25:13 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E3CBF61D69
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 18:25:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB0BC36AEB;
        Thu,  6 Jan 2022 18:25:11 +0000 (UTC)
Date:   Thu, 6 Jan 2022 13:25:10 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: Update information about printk git
 tree
Message-ID: <20220106132510.0a460fed@gandalf.local.home>
In-Reply-To: <20220105094157.26216-1-pmladek@suse.com>
References: <20220105094157.26216-1-pmladek@suse.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  5 Jan 2022 10:41:55 +0100
Petr Mladek <pmladek@suse.com> wrote:

> I have noticed one outdated and one missing link to the printk git tree.
> I am not sure if it is worth sending for review and having two patches.
> I just want to avoid possible complains ;-)
> 
> Petr Mladek (2):
>   MAINTAINERS/vsprintf: Update link to printk git tree
>   MAINTAIERS/printk: Add link to printk git
> 
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Steven Rostedt <rostedt@goodmis.org>

for both patches.

Thanks Petr,

-- Steve
