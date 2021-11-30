Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C38464226
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237463AbhK3XPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 18:15:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36660 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbhK3XPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 18:15:35 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1638313934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orwrqGwIeCn/Frr8jmrZeo75Harp9WXBZKPjyFCkCgU=;
        b=XlaWw8v1tGvFfkw1ZLkbaMYlqE/4rSNs5peGJDFr9s1nn1Njhcu4gWAaRgsjipfvULVGGU
        nKD3RbzX1uJ70szoamLAJllSsbDcsVDR+kkFPek4y5vO1OIoj/8yz7Y5qu81YuYpKD6nyA
        CA8ULOu+ZIAAGUP21X0s3lRdbHqVlNnoxM4qPaxSdR/3eee9JvsjAx8a2Gdm7GCymNml8j
        mpOZBsWH3uUUKgLova48uzJLH2zCdtfz2gk5TbUdo82YdlbKgIWbRDFkZs8ZwArEVufmdW
        KcgNzkZQS9xmaGuGokbO3Illjf6JFruuKxiNV/hU1Tzd79OQX+X1IusTexdxNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1638313934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=orwrqGwIeCn/Frr8jmrZeo75Harp9WXBZKPjyFCkCgU=;
        b=NGvkEfzUzaBuw4G0BuGOLjDivfpz+RFevNwga62NXsDavb45jUTFymNyLSt1TVQyWJjy0e
        h513vPFsRgQBUvAQ==
To:     Maulik Shah <quic_mkshah@quicinc.com>, bjorn.andersson@linaro.org,
        rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, ulf.hansson@linaro.org,
        quic_lsrao@quicinc.com, rnayak@codeaurora.org,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH 1/4] tick/sched: Export symbols used by cpuidle governors
In-Reply-To: <1637830481-21709-2-git-send-email-quic_mkshah@quicinc.com>
References: <1637830481-21709-1-git-send-email-quic_mkshah@quicinc.com>
 <1637830481-21709-2-git-send-email-quic_mkshah@quicinc.com>
Date:   Wed, 01 Dec 2021 00:12:13 +0100
Message-ID: <87wnkp9r1u.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 25 2021 at 14:24, Maulik Shah wrote:
>  bool tick_nohz_enabled __read_mostly  = true;
> +EXPORT_SYMBOL(tick_nohz_enabled);

If any of this gets ever exported then with EXPORT_SYMBOL_GPL(), but I
agree with Rafael that there is no real value for this, so the exports
are not required either.

Thanks,

        tglx
