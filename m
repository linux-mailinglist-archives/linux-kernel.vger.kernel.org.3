Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C8757BDAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240282AbiGTSWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiGTSWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:22:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39A6C122
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 11:22:13 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658341330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdffNCX4JTcdua+0fjZnrWwVTWjQKhfHJO6PUSI+DgU=;
        b=J0SMIJFNkEYo6mfRH4TulE7MyhIyHJEMIRMahOVUo+s69R/zPMb7aeNH3q4ypLOBhx8HvN
        SKLe1b0dbyx+6hVzy9NBA2/37K1IzLe9XIBp3f5t+1j/GHvSst/lM48RvGv8MOl3X2UH6T
        8U9PW1oJ8bUp1fD88GbNjXR2k9m5nfkJSfzZe5v5CTMNa33XlMRXsXISJXDzvCOD6GRYqe
        nR6zJ+8j3oX2KBZR72MPJbhUzrgqkRVMODDkudKSUu/pqACGjQ/j8KPYiDymr3eWBsV+Yk
        r6yYNpR86wlCubIr91fasXC13DDvH/wxULYhRqDN5bESkzc244uEE4HoVizwJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658341330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdffNCX4JTcdua+0fjZnrWwVTWjQKhfHJO6PUSI+DgU=;
        b=erEno3PMWXKwmHUKutiC9TA9iFmlV70/cL8dBpUDa5CWOc0Jhkl6BzYny7PUq3/opfBt9v
        /GnJEYghzcZCQ7AQ==
To:     Chris Down <chris@chrisdown.name>, linux-kernel@vger.kernel.org
Cc:     Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@fb.com
Subject: Re: [PATCH v3 0/2] printk: console: Per-console loglevels
In-Reply-To: <cover.1658339046.git.chris@chrisdown.name>
References: <cover.1658339046.git.chris@chrisdown.name>
Date:   Wed, 20 Jul 2022 20:28:09 +0206
Message-ID: <87edyfmypa.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-07-20, Chris Down <chris@chrisdown.name> wrote:
> v3:
>
> - Update to work with John's kthread patches

This will get a bit tricky, since I am also preparing a new kthread
series. But for now it is helpful to base your work on the previous
kthread work.

Thanks for your efforts on this!

John
