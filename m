Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6E057F459
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 11:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiGXJZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 05:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGXJZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 05:25:09 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798EF27D
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 02:25:06 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 92C2D5878347E; Sun, 24 Jul 2022 11:25:04 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 904B760D9DC8C;
        Sun, 24 Jul 2022 11:25:04 +0200 (CEST)
Date:   Sun, 24 Jul 2022 11:25:04 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Adam Borowski <kilobyte@angband.pl>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, lkft-triage@lists.linaro.org,
        Borislav Petkov <bp@suse.de>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: RETBleed: WARNING: Spectre v2 mitigation leaves CPU vulnerable
 to RETBleed attacks, data leaks possible!
In-Reply-To: <YtxtNJorUMwCU+Gf@angband.pl>
Message-ID: <3139s0q2-2o3s-4334-o670-n3p223o34ps9@vanv.qr>
References: <CA+G9fYv0N0FcYRp5irO_7TpheLcUY8LRMQbcZqwEmiRTEccEjA@mail.gmail.com> <Ys/bWIk0F5srkkpF@kroah.com> <YtxtNJorUMwCU+Gf@angband.pl>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Saturday 2022-07-23 23:50, Adam Borowski wrote:
>> > We are booting the i386 kernel on an x86 machine.
>
>[..] And for quite some tasks, halved word
>size (thus ~2/3 memory usage) can overcome register starvation and win
>benchmarks.

So how many benchmarks does a 32-bit userspace with a 32-bit kernel
win over 32-bit userspace with a 64-bit kernel?
