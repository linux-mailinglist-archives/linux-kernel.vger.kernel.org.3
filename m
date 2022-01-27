Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF30649E4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242434AbiA0OeQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:34:16 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:40286 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbiA0OeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:34:15 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 293251F385;
        Thu, 27 Jan 2022 14:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643294054; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bz8jzEDf1u3lcv1eTaG8/3HOxW5EnsWoeSyZ/Ahpeec=;
        b=Wx29Z5EI2SXpqJ8vo+eOPwIcVCaUSXUVmtZmVm40PNEnWUeV3N/lT9PEqwCuq5eqaQaMxg
        CNq9xK8hcFIsWUfDmbPt1wrXcSWImrehOkUylGlVY7qAnP/egPADAqjBSsN6CHvVdV9HSZ
        uLmi81TIK/3EzXXqYFSJJyAOk0cUMus=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 02BB4A3B88;
        Thu, 27 Jan 2022 14:34:13 +0000 (UTC)
Date:   Thu, 27 Jan 2022 15:34:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Brennan <stephen.s.brennan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Reichel <sre@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] panic: Add panic_in_progress helper
Message-ID: <YfKtZUiLWkrUIkwn@alley>
References: <20220126230236.750229-1-stephen.s.brennan@oracle.com>
 <20220126230236.750229-2-stephen.s.brennan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126230236.750229-2-stephen.s.brennan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-01-26 15:02:33, Stephen Brennan wrote:
> This helper will be used in printk code to avoid deadlocks during
> panic().
> 
> Suggested-by: Petr Mladek <pmladek@suse.com>
> Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
