Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29594B6B94
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiBOL5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:57:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237428AbiBOL5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:57:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4A329CB4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 03:57:00 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E04091F38A;
        Tue, 15 Feb 2022 11:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644926218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MZgKlMY4uvXGwrwReShkyj4jWBoQgKilIHEcmjEYb+c=;
        b=VJ2BYD1iU4BIslhAimT8zMLw54559U2p1JkAJM4Qty6ekF2tqvBdFOYMRDVdwQmWQmKuU5
        iqjSktBgpsvYb58ZsrRUFwIoxf8p6ynp0++XOQ5KCL0bNRM/AQYpJpDBJ5bRSASIYCf0fo
        xr22fHNfQ+hwh/2ZgL4I1nTObT4JRCU=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 9431EA3B83;
        Tue, 15 Feb 2022 11:56:58 +0000 (UTC)
Date:   Tue, 15 Feb 2022 12:56:55 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 04/13] printk: get caller_id/timestamp after
 migration disable
Message-ID: <YguVB7eV8mxkcIst@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207194323.273637-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-07 20:49:14, John Ogness wrote:
> Currently the local CPU timestamp and caller_id for the record are
> collected while migration is enabled. Since this information is
> CPU-specific, it should be collected with migration disabled.
> 
> Migration is disabled immediately after collecting this information
> anyway, so just move the information collection to after the
> migration disabling.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
