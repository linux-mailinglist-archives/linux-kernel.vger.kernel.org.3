Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57E8B54F866
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 15:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380908AbiFQNhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 09:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbiFQNhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 09:37:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0D415FD6
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 06:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A4E26200A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 13:37:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84101C3411B;
        Fri, 17 Jun 2022 13:37:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qHhiQ/to"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1655473067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zrED9ByxkZSU3xrrrvY1WtyPRg/C/xFob8Q4J5w13/k=;
        b=qHhiQ/toT6EsjM+2nr4T0WV7O5iJMnyVqTorAhey2Q4U+ACY/eXtrJQTROmoM2gOuWoAGH
        WT3wXl2EpDfXsK634MAml0oR4iG66i7l3YZgFJgIB9X50H9iqR59a5FRmoHECkACjmenmY
        oQrx13j24uJJ7PRXOUBm7NlXrnlmpRo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 37a6ffbe (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Fri, 17 Jun 2022 13:37:47 +0000 (UTC)
Date:   Fri, 17 Jun 2022 15:37:44 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>, Marco Elver <elver@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 5.19 printk breaks message ordering
Message-ID: <YqyDqMAPHIxjA/xZ@zx2c4.com>
References: <YqyANveL50uxupfQ@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YqyANveL50uxupfQ@zx2c4.com>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 17, 2022 at 03:23:02PM +0200, Jason A. Donenfeld wrote:
> So I was wondering if there was some way to boot the kernel with a
> command line option or compile-time flag that always flushes printk
> messages when they're made, or does something to make the ordering a bit
> more faithful.

I'll scratch my own itch. Patch incoming.

Jason
