Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB245324E9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbiEXIHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 04:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiEXIHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 04:07:15 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED6B3B02A
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 01:07:14 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653379629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4DC/NEY/CSLMDBSHqXNIeQlTK2Cm0ne7WrjKA27TUU=;
        b=nZuxS8+zpsIMGBBrraXSESfJpEZ8jaHvcrhKqA2dFf70DHyAI3RAotjV3Oy1y2dPRqgy0t
        LM8fQO3SM3+G8fVyn7Tirxu7RMZhIifzUIHwduz/tnbe/3C+07iv5npWxEXJ10LYrRV0UZ
        AFjsh8HBx+naWL6p1u2KmMkPjbtFrPTQf4oc31Kzd9TX3TgMFGurh/6LQ6tbxIx1wTNG1Y
        Tcb5cseSJRRUrN2fYJAmlQ5nx4QA8za68HmzV1GAuo9UOOesyE47CphYmDTXc9eTAOrZxI
        wbf557kLxulUHs1EHSvJIthEq/ZrBwQSSXEUcRv+/AjCKnRbcS2r1NTzBYCzpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653379629;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y4DC/NEY/CSLMDBSHqXNIeQlTK2Cm0ne7WrjKA27TUU=;
        b=eXXjpDqYmADARLleF/9ZbEFHpsi/+UYpceXbA7/CX7q6ICb4n/1dKva4fIPDvEpzPDJZ1D
        sFc8RDNNAkSCuGAQ==
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: [GIT pull] timers/core for 5.19-rc1
In-Reply-To: <CAHk-=wi0q-c95_OaHf9Eq16C7kURDNugdqBrE1wwXJf+yfX4Yw@mail.gmail.com>
References: <165329267741.3801280.534077656528571075.tglx@xen13>
 <165329268338.3801280.15015388773053623832.tglx@xen13>
 <CAHk-=wi0q-c95_OaHf9Eq16C7kURDNugdqBrE1wwXJf+yfX4Yw@mail.gmail.com>
Date:   Tue, 24 May 2022 10:07:09 +0200
Message-ID: <8735gz1hhu.ffs@tglx>
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

On Mon, May 23 2022 at 17:11, Linus Torvalds wrote:
> On Mon, May 23, 2022 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-core-2022-05-23
>
> Hmm. My diffstat didn't match yours, and I couldn't figure out why,
> until I noticed that:
>
>> Anna-Maria Behnsen (3):
>>       timers: Fix warning condition in __run_timers()
>
> You had already sent this one to me as part of the timer fixes pull
> back in mid-April, so it was already in my tree. Apparently you hadn't
> updated upstream before doing the git request-pull script.

Weird. My reference branch is on v5.18. Let me see why this is going
wrong.

Thanks,

        tglx
