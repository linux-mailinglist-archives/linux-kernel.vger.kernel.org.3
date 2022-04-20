Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277A25089F7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 16:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379297AbiDTOEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 10:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379282AbiDTOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 10:04:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE4434B9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 07:01:56 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 819661F380;
        Wed, 20 Apr 2022 14:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650463315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n4dp3HFRrjnXEdZ1A/sAU9AfB8D6QTAPBq+YlxefL8I=;
        b=Myw3c9zIqR+mbrEOdHnK11H3jXIAk3dmygu8jIm69e6ultbG3LTVz4QLcbcZKXVjY5ORqU
        KqayRVq+p3F72BR5+25WLmSWJG8Oq2JliPRnjZcaNipudYO50Oy+LgW11wd5FWzpEd6i1i
        nw9GCL5i1sGrNR/FUGxB9esOCsiKW/c=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 516102C142;
        Wed, 20 Apr 2022 14:01:55 +0000 (UTC)
Date:   Wed, 20 Apr 2022 16:01:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 08/15] printk: add con_printk() macro for
 console details
Message-ID: <YmAST5qLaj8iB9RH@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-9-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419234637.357112-9-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-04-20 01:52:30, John Ogness wrote:
> It is useful to generate log messages that include details about
> the related console. Rather than duplicate the code to assemble
> the details, put that code into a macro con_printk().
> 
> Once console printers become threaded, this macro will find more
> users.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Macro magic ;-)  Looks good to me.

Reviewed-by: Petr Mladek <pmladek@suse.com>

Best Regards,
Petr
