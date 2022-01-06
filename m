Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C11448621D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 10:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237408AbiAFJ3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 04:29:44 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43594 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237186AbiAFJ3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 04:29:42 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3A5031F37F;
        Thu,  6 Jan 2022 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1641461381; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y/GNNjKeLfGD7wvNr18egAh+0Lf4ytydDR7VI/qFwnE=;
        b=PuCayK7k533kZ3ZVczu+Pc7Cj/HuGMGzqMGQNis0E2guRz8tEnucnYllx+lUVP2XtLl8U4
        ryGX0PLF/Y0yBYq7DNlfTMWPQgsekn1GINcZlllQ1DLte33QtbKFx6s/YOd1TdwjwNohT0
        J3QuvMIziEhQruhTA7Txjs8VIc4Kkd4=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EF644A3B81;
        Thu,  6 Jan 2022 09:29:40 +0000 (UTC)
Date:   Thu, 6 Jan 2022 10:29:40 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] MAINTAINERS: Update information about printk git tree
Message-ID: <Yda2hHoVIRQxDJ+H@alley>
References: <20220105094157.26216-1-pmladek@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105094157.26216-1-pmladek@suse.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-05 10:41:55, Petr Mladek wrote:
> I have noticed one outdated and one missing link to the printk git tree.
> I am not sure if it is worth sending for review and having two patches.
> I just want to avoid possible complains ;-)
> 
> Petr Mladek (2):
>   MAINTAINERS/vsprintf: Update link to printk git tree
>   MAINTAIERS/printk: Add link to printk git

JFYI, both patches has been committed into printk/linux.git,
branch for-5.17.

Best Regards,
Petr
