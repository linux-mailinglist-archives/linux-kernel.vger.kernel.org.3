Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC132461A85
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 15:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347776AbhK2PCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:02:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:54120 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345994AbhK2PA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:00:26 -0500
Date:   Mon, 29 Nov 2021 15:57:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638197828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gAq2etfKYlF3VbW8M0eDaLMWdfwgg9cIyozwcq3RYo=;
        b=vlUO4LMhg46q+GRVo9Zz8Xo4PRJfLZ10OFZDvGoKs1ZDyjQBsSI6zROsG9RlkYnjjkoNcV
        PfXqs8afvDIxoCpm2F6txSI5kiGb4tpE674IrRv7v5ZkzbDYI7DlxbhXJ6GXerAiNkazsN
        4okUipYwbPkRjdHmtC/rSE3ovu3hcwQO58mTGBn+SABP6tWeApvCGJ3RH8zCZcPaag8fsf
        sS/Ry60VezBqjOlJeupg8rpiUpSijCY0NZ0PO7uzYx7Zqss4Z73OE61nnApw1yA5BdAq8e
        Aky9c9RKj6dIYc809xQ38VXYqH9AWZgQ4XZd4DBd/fJOlXq9LsoNvgy9Q2hgMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638197828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+gAq2etfKYlF3VbW8M0eDaLMWdfwgg9cIyozwcq3RYo=;
        b=GjMvW1WgxMFz3LZdNK+o5BUlMf1UnAz1chpMCmtme3N9orA2X7encrxmhF9k4xt8uuywlD
        J6AWcTDrDr9EjOAA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mtosatti@redhat.com, juri.lelli@redhat.com
Subject: Re: [PATCH RT] arm64: Allow selecting KVM and PREEMPT_RT
Message-ID: <20211129145706.rvfywpvt6sapiwy2@linutronix.de>
References: <20211123095928.21525-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211123095928.21525-1-nsaenzju@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-11-23 10:59:28 [+0100], Nicolas Saenz Julienne wrote:
> With 6caa5812e2d1 ("KVM: arm64: Use generic KVM xfer to guest work
> function") all arm64 exit paths are properly equipped to handle the
> POSIX timers' task work.
> 
> And with a68773bd32d9 ("arm64: Select POSIX_CPU_TIMERS_TASK_WORK") we
> now handle the timers in thread context.
> 
> This allows for KVM and PREEMPT_RT to coexist, so update Kconfig to
> reflect that.
> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

applied.

Sebastian
