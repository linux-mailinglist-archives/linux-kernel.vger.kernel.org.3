Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD289508844
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 14:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378622AbiDTMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 08:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378617AbiDTMiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 08:38:52 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E71613FB3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 05:36:06 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 4CD4A1F380;
        Wed, 20 Apr 2022 12:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650458165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Is3aCBLQI6dFhP79h8fzG3bJKE+aN0f1loSW8GYnm6w=;
        b=krUhqrouqnHuOphMc8X0I/kCdBCLtmNVEu1qT61dgWbMP1OF22WiHXvrLTgM9LSiE8T/J7
        sK3NZrOkefkR0Mnx4XCg7L7a6hYBnNZuPHzJ2DliNY1iy3CKqm8QTj+P9fxbADAQTdMJPk
        RfCfEKYEHf4Q6s6k9eLSj5I1aVm4rXg=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 237282C14F;
        Wed, 20 Apr 2022 12:36:05 +0000 (UTC)
Date:   Wed, 20 Apr 2022 14:36:04 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 04/15] printk: wake up all waiters
Message-ID: <Yl/+NO+d3V9dekOS@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-5-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-5-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:26, John Ogness wrote:
> There can be multiple tasks waiting for new records. They should
> all be woken. Use wake_up_interruptible_all() instead of
> wake_up_interruptible().
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Another great catch!

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
