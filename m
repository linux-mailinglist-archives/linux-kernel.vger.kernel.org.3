Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE35653251E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbiEXIRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiEXIRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:17:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5B55DBD0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:17:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653380262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/loTL55fQJ32rH7vNmJgGy+B/q4KAMXD6Zzx/exR5fo=;
        b=JPXnMk+MusY//FzLfnU4QnQQtphkx48ozWJoUP66EHgyhznTF4uX7hZslJQ5dUc019bA0T
        utlSZeSw3Zw++8fEpkPdryArmF7bOJ98fxhqn/4JZN+PR1cAku+QGfveVkahowvwbOVRTD
        O9Gy1TKRJcjA39tlgn4ERShTHsJTBAJcxoqze/saTvwSH3q5eOSscZd4FbsvymaTqb/cHx
        CkXIy1xsENrdfWppJXoB2GwURFuEzy2okl4uP/kC91J22WRfkhM95msTIZJrc8L/VqCN6+
        Ek6s1jFFwdhZxTtyklaxd3ZgSjsc2CE+vZB8rt3ebrmN74SG+iIgu0fsZd/RlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653380262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/loTL55fQJ32rH7vNmJgGy+B/q4KAMXD6Zzx/exR5fo=;
        b=jm6o97g9ZNpzovPpFXWb8gaKRwG1HZIAnYeQsJW4XetuwF00qr38hH3eF6mcJEJB4jgNM6
        Z0yn2MfkDNJaDwAw==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] irq/core for 5.19-rc1
In-Reply-To: <CAHk-=wh-Jpp8t6B_HbmGyAQwwEWMJ3Q0tK3HGiRh_KTEzUGn+A@mail.gmail.com>
References: <165329267741.3801280.534077656528571075.tglx@xen13>
 <165329268046.3801280.14650675869745686928.tglx@xen13>
 <CAHk-=wh-Jpp8t6B_HbmGyAQwwEWMJ3Q0tK3HGiRh_KTEzUGn+A@mail.gmail.com>
Date:   Tue, 24 May 2022 10:17:42 +0200
Message-ID: <87zgj7z6mx.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23 2022 at 17:02, Linus Torvalds wrote:

> On Mon, May 23, 2022 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>     - No new irqchip drivers and not even a new device tree binding!
>>       100+ interrupt chips are truly enough.
>
> Oh you sweet optimistic child.

Always look on the bright side of life!

