Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE458508967
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353958AbiDTNfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240333AbiDTNfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:35:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B931D0E0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 06:32:18 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1650461535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAjR6vamNC08PrfHVEXiMokJ3AnkBAOwmKBjPszbaQA=;
        b=EsuzH6htxp8bItnkdvkduZ5p7OUYoJcpZc4zzBrNvbdDffIELJa1xqLGnUYWQd1RmOuleS
        Qe9zblF0uerIgatiJmzvu2BT7fCFFXTFnKHBhc006csPswBTfaU6ll9IAz/XinppiyCpl1
        nRwGRWkH2ypM8hMB+ppet6sOlnQxB+Fd5iYX4KgLaQwwXrSNN3VsPG+KrD4iajqciI4apG
        RA2HOIKpI8CNaTf3PryMBqFL0Tdl+PNUzZUvVxGVlvFhFavc/1EAwaMfnDJY/BDjp3svKw
        SHU1B5ACGEsDDtvTAThfQYAiV7KVCkBJsqfwrPK4ZviC7yHeNbO2SXP3aaz7bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1650461535;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DAjR6vamNC08PrfHVEXiMokJ3AnkBAOwmKBjPszbaQA=;
        b=m40KcznrHP/gI+RrjFrB00Eqi2M8/9Jc2aMj/tGSSv5PztN4bcCi/b09lj2NDgFA9QP34f
        c0jmGaPErdqGH0Dw==
To:     kernel test robot <lkp@intel.com>, Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@lists.01.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
In-Reply-To: <202204201041.ZwRzv18o-lkp@intel.com>
References: <20220419234637.357112-15-john.ogness@linutronix.de>
 <202204201041.ZwRzv18o-lkp@intel.com>
Date:   Wed, 20 Apr 2022 15:38:15 +0206
Message-ID: <87a6cfkhi8.fsf@jogness.linutronix.de>
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

On 2022-04-20, kernel test robot <lkp@intel.com> wrote:
>>> kernel/printk/printk.c:2703:6: warning: no previous prototype for 'console_lock_single_hold' [-Wmissing-prototypes]
>     2703 | void console_lock_single_hold(struct console *con)
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~

I forgot to make it static. Thanks lkp!

John Ogness
