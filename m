Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8B847303C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238911AbhLMPQF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:16:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbhLMPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:16:04 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EBBC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 07:16:03 -0800 (PST)
Date:   Mon, 13 Dec 2021 16:16:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639408562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToQdhf3v46EZ7+ZT9zyhPQONFZf+B2zPmzbPVD/BAeU=;
        b=pERNLzZJjVAcatK8nKwh+e3/ir5V4GqYTXEV/4/VQL4X6A9yfIhb3yeRgk0UY7OlPPL46J
        dzdMLb+quVCLmrX+IYw0Bgi1KURNobWqVHF3OYGirnOo3QFfv9zcBBsCX++F3iblLNMbTM
        h24J2WieuJlxCBYCtsfNeHSyt2wv46U2RL/arV2E+Bhkwzm5si51Jl2gLoUVojwD9bHeNj
        OaFwU+bU8yg53A1gdOdQsOQIHp1HElsxv3Ubw1oLblDbMmiUzcyVI7bp+YXdSElMO8pEPh
        S9Qr1N0PmybSyves1hIv+y5Iy5LDTG/KYcfuxF88/wH4VyKNQvJQEsFRc8EFbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639408562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ToQdhf3v46EZ7+ZT9zyhPQONFZf+B2zPmzbPVD/BAeU=;
        b=XFbpZO9zW32wcIgRasmjpBfwkx72wiR1WVrMUX4XpoGTrsut+u7op55fiPi1wJXSfJ5ixH
        YJq+njPRgxc1VbBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Theodore Ts'o <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 5/5] random: Defer processing of randomness on PREEMPT_RT.
Message-ID: <YbdjsPYSUbNnaH8N@linutronix.de>
References: <20211207121737.2347312-1-bigeasy@linutronix.de>
 <20211207121737.2347312-6-bigeasy@linutronix.de>
 <CAHmME9q2Yid56ZZ9sBQWjEWEK2B06g3H9KYRwWqExXRoCdbPdA@mail.gmail.com>
 <20211207201037.h46573oa5nfj33xq@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211207201037.h46573oa5nfj33xq@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-07 21:10:39 [+0100], To Jason A. Donenfeld wrote:
> On 2021-12-07 19:14:16 [+0100], Jason A. Donenfeld wrote:
> > Hi Sebastian,
> Hi Jason,
Hi Jason,

is there anything I should do and didn't do or do you just need some
time to think?

Sebastian
