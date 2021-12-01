Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51F7346590B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 23:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353535AbhLAWXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 17:23:07 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43708 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235412AbhLAWXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 17:23:03 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638397181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vF+vI1122M1xefgS/sOmAIhbY1QddRBIrijNYDW8GX4=;
        b=pfhBPHNR3AtX3Ux1DwzekYHkpk8McxqO+1r1PnWFrRdm0Efin2qvGo3+JVjUit/C03R+AM
        fOaiLydtsmIJSgeolp7ABmG4MILO2D9REQnTQH0T1XYBKa1KhL7PrhM9Up4z3O3b+wSNTO
        4dXmWeXoBmSGJ0PMx2GO10oU/UQMyBZm2EKz5Bief+Tn2fab3MkUcgBpKdEEF7Vj50yLAL
        mHqHMPwNblrq5K8bgewA7eJQmIKrYr1qErpXdsjZ0ivPvzVD6rPUpMJiwEXuVD6cJ6xOSo
        H1VF8DTv4uehRe/UmBAj+rHYhWFJQMskgD8xKOL8Q5SrunLeBC2qGnXxzArSow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638397181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vF+vI1122M1xefgS/sOmAIhbY1QddRBIrijNYDW8GX4=;
        b=YPDQJA6uqJ9UHFthLEyM5wWM1bK4UK5GvGKUw8E7iY8GSEfElOWt2nxMHZV2/KaaugBVRP
        SBcj6cSyctLpXABg==
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the tip tree
In-Reply-To: <87zgpk6kcz.ffs@tglx>
References: <20211126145201.5aefa68c@canb.auug.org.au>
 <CAK8P3a078LiivyzUiH+D--iRsQGTcQ_hy=-h7crynrbQ6ZYn6A@mail.gmail.com>
 <20211202090540.1f22fa39@canb.auug.org.au> <87zgpk6kcz.ffs@tglx>
Date:   Wed, 01 Dec 2021 23:19:40 +0100
Message-ID: <87wnko6k8z.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01 2021 at 23:17, Thomas Gleixner wrote:

> On Thu, Dec 02 2021 at 09:05, Stephen Rothwell wrote:
>> On Fri, 26 Nov 2021 11:01:52 +0100 Arnd Bergmann <arnd@arndb.de> wrote:
>>> 
>>> Thanks a lot for the report, I sent a fix now:
>>> 
>>> https://lore.kernel.org/lkml/20211126095852.455492-1-arnd@kernel.org
>>
>> I am still getting this failure (Arnd's fix has not been applied).
>
> It got applied, but due to tip maintainer confusion the next branch was
> not updated. Will be fixed tomorrow.

Actually now. So still today here :)
