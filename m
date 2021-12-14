Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 108BD47423C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 13:18:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhLNMRv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 07:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhLNMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 07:17:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F76DC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 04:17:50 -0800 (PST)
Date:   Tue, 14 Dec 2021 13:17:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639484269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5EjK9U4c1B2UMzOdb/VrmnUd2kGnJXX71T0l2vaNMvw=;
        b=LFK+C3/7skCLlAKeYual5QNG0cjYG8e40f7TSY4MQqfma/UQ6d67wFxp39AR88lvO6nePR
        uhIdror80ph6fl02ir+ouKap1Hd1kz2bMADADJoY6PsTyu4+kU3FplepMkdGvK3qkXxqNT
        tI3GVA5NH04Gtx6TlpfCcMKQmyjUClmA2jz5tFDeaMGotkSsNlkrABbE3cMeZxaphrP9nI
        wRS44pc63FwetZVhkg2U2AYJOaOJmd9mm4rVm406sRAGsN/ooXy47H2AnhrOEKxMYLFvVb
        4y6n1ZWibQT/Ol1h5qLWCHj2AAq8DyPA9vjubBln43hM6sEiWGYE8+gyrJ26UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639484269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5EjK9U4c1B2UMzOdb/VrmnUd2kGnJXX71T0l2vaNMvw=;
        b=rJpgtcmrZni7owWFcBoJFviG+yZFYbPz0kQR2t++AUzw4JSTKMPNOiAow/U3ui0/V0TFgc
        gHq6c2V421H3vDAQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        xen-devel@lists.xenproject.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Longpeng <longpeng2@huawei.com>,
        Gonglei <arei.gonglei@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 0/2 v2] cpu/hotplug: Allow the CPU in CPU_UP_PREPARE
 state to be brought up again.
Message-ID: <YbiLa2nK3pYruDSK@linutronix.de>
References: <20211206152034.2150770-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211206152034.2150770-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-06 16:20:32 [+0100], To linux-kernel@vger.kernel.org wrote:
> This is a repost of the previous patch (#2) and adding Boris
> (Ostrovsky)'s suggestion regarding the XEN bits.
> The previous post can be found at
>    https://lore.kernel.org/all/20211122154714.xaoxok3fpk5bgznz@linutronix.de/

ping.

Sebastian
