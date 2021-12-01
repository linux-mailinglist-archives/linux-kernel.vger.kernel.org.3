Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC7524658FE
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353548AbhLAWVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353498AbhLAWUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:20:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080E8C061574;
        Wed,  1 Dec 2021 14:17:18 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638397036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEntfi+R1B0LdGVSzyc+PZLj+JC9XJ08L6abd7hjSZI=;
        b=gjlu2BnSyIsdoFUY93w/MS/G44ArV1VpPX9nPvKuVsKJkXsdZe0D5NrSVMlp/s8yWc3qA/
        Xn6LLYM96/sekiGyS8/WcL/R/jO7vAo8Pon5Aotq4vqO8l2TnmMNNx8i6/LmD8NrQXMTvx
        FKK6GwdeSbpeG/FtFS7np72Zi8mqQKuo4BBhjM/GgluNZ+oveio/6KeWab1wk831B1RDvt
        2Eu6X9iqCJ3yX76iN4DSPe2LeY2BE5qmPccGjcvbixjeN24iBHNAFPTAqpmGAG0EMd9sFs
        025hRKxOg8+pP7D2RJZb5dXpku3kr+eLtO2dgn944UkVGCbrhtvlcZl9n6AxQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638397036;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JEntfi+R1B0LdGVSzyc+PZLj+JC9XJ08L6abd7hjSZI=;
        b=z3NRdTjrWa4gKapXO/e5RBnmEjy75iPzjHnOv78hif7BdRkrBb7XwnFJadjU57et3rUi2r
        vV4vOwWaiQ+aQlCQ==
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <20211202090540.1f22fa39@canb.auug.org.au>
References: <20211126145201.5aefa68c@canb.auug.org.au>
 <CAK8P3a078LiivyzUiH+D--iRsQGTcQ_hy=-h7crynrbQ6ZYn6A@mail.gmail.com>
 <20211202090540.1f22fa39@canb.auug.org.au>
Date:   Wed, 01 Dec 2021 23:17:16 +0100
Message-ID: <87zgpk6kcz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02 2021 at 09:05, Stephen Rothwell wrote:
> On Fri, 26 Nov 2021 11:01:52 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>> 
>> Thanks a lot for the report, I sent a fix now:
>> 
>> https://lore.kernel.org/lkml/20211126095852.455492-1-arnd@kernel.org
>
> I am still getting this failure (Arnd's fix has not been applied).

It got applied, but due to tip maintainer confusion the next branch was
not updated. Will be fixed tomorrow.

Thanks,

        tglx
