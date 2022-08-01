Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72965866E9
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 11:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiHAJi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 05:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiHAJi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 05:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F6BD32EF5
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:38:26 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:38:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659346705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msA7Q7r4XurPQ7KKvy4p9K/ULJLPcpL9Ag7JPFV0Fn8=;
        b=JLw9Vta2n5Y8ZSTinAvvOd9VfrvGJXtZkr1/KGsKtHl7dAP5sUAcvegebx4bIyDq3SjuMU
        A8I/6YXNXTS4ib6l+ti7pqLTzzMp3TqLrMVzvnR9ReOR5yHMfpkEakzIdDuz9Mj2KQYi8c
        UvYlefYpmtJMwngEW0Q7OWg1z3TN8K39UQ2iyriLe7foI0hCimseTX6fzV55S1L3UkVVDt
        igZwhst5/Aot7soz6E3OhlDW5bquKfem5Ef994Sgnr9ba8WG+MGWjTjKCj/chuSHSZGSnu
        vwm3c3oDJfvxJb76sxjSCQJsx4nXfOK0scX7ifOZVy1T7GMVjk6nItDQxKGQyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659346705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=msA7Q7r4XurPQ7KKvy4p9K/ULJLPcpL9Ag7JPFV0Fn8=;
        b=I+f4tlz7LMdpLxsSLBzokXuOlgUKbbIatcEYZBFn8Epzzy4AjtbktxE47qmj8fyhx3UcDN
        U/umIa9ntT4UMtBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     0day robot <lkp@intel.com>, Mike Galbraith <efault@gmx.de>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Theodore Ts'o <tytso@mit.edu>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [random]  9fdfe09a52:
 BUG:sleeping_function_called_from_invalid_context_at_include/linux/percpu-rwsem.h
Message-ID: <YuefD4+Z15AFgkkE@linutronix.de>
References: <YuOf6qu453dOkR%2BS@linutronix.de>
 <YuYggHh84ArSJY6w@xsang-OptiPlex-9020>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YuYggHh84ArSJY6w@xsang-OptiPlex-9020>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-31 14:26:08 [+0800], kernel test robot wrote:
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
> 
> 
> [   11.543105][    C1] BUG: sleeping function called from invalid context at include/linux/percpu-rwsem.h:49

Thank you for note, this patch has been dropped.

Sebastian
