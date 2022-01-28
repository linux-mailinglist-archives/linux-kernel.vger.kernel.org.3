Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B65249F51C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 09:31:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbiA1Ib0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 03:31:26 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:43550 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbiA1Ib0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 03:31:26 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 391711F385;
        Fri, 28 Jan 2022 08:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643358684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=02PNg5BnxrHWViClE1ae8Hoy2ynTfMJ6d+ldj7atrQM=;
        b=jdrRgz/pwT5XG3uoTIcxbFgcH1XnqpJ2VGwTzCyxe2K+6isOZfzRsYRThUtvfr6qF7tIhK
        v9sc7SNT4QdEjIJkmJCi+ZI4JLWsAK78olTMj39HOmORT2lGromo0Ej9QEZGeYdKfxGuf1
        /8f+XmDkZaEz77wJv5dq9yu2VxDmjbM=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 15677A3B88;
        Fri, 28 Jan 2022 08:31:24 +0000 (UTC)
Date:   Fri, 28 Jan 2022 09:31:22 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sakari Ailus <sakari.ailus@linux.intel.com>
Subject: Re: [PATCH v4 2/2] vsprintf: Move space out of string literals in
 fourcc_string()
Message-ID: <YfOp2gkzceVbPjjQ@alley>
References: <20220127181233.72910-1-andriy.shevchenko@linux.intel.com>
 <20220127181233.72910-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127181233.72910-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 20:12:33, Andy Shevchenko wrote:
> The literals "big-endian" and "little-endian" may be potentially
> occurred in other places. Dropping space allows linker to
> merge them by using only a single copy.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Acked-by: Sakari Ailus <sakari.ailus@linux.intel.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr

PS: I have vacation the following week and will have limited internet
    access. I am going to push this patchset after I am back
    unless there are some complains.
    
