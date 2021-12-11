Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03A6B471403
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 14:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230522AbhLKNgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 08:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhLKNgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 08:36:07 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAAD3C061714
        for <linux-kernel@vger.kernel.org>; Sat, 11 Dec 2021 05:36:06 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639229765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEAb45qkqkkhb/bmtyJAWyFSH4HlwrzzLlf4JkPekP0=;
        b=M0dcmU6RyypVL6pXfBv/uWmYj5N9Z7WG1KsPHRHH8PnrfW6he4r9BBg0j046nugEqOJjEQ
        tUbRFWCc1EhIOrdG6CoTWzMT++cOz99ZzZ/U0OFYmFM790Q/7NAEjK3LFtpftS+LC+XiG8
        zDrwjILOH3m/vESC157xq1Y4x1jQhBeyr3xzIZFOhde1qC0zlYygfRogkCnVef1985CGYj
        qJW7CEpFyw1OK2lTymg3nKVzT15PCipRJaMQYOlUUQ/HXG6db8E4wxP6/RMSXYBrrHcF7Z
        l00i60aueFJa1n/cEKFmtdp8rggFczUe9KEa66yH6bRnWcOAl+O0JXp+NsuUYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639229765;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sEAb45qkqkkhb/bmtyJAWyFSH4HlwrzzLlf4JkPekP0=;
        b=DOJ5RvYGlcw89BoEjxmIAS/lkmOMCQXt1uhvBhg7G00c5bgyR69feFCG4ReZYaK9xZYP5+
        DEf0X16zVPMn5TAA==
To:     Joel Daniels <jdaniels@sent.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Time keeping while suspended in the presence of persistent
 clock drift
In-Reply-To: <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
References: <5af5d2a5-767c-d313-3be6-cb6f426f1980@sent.com>
 <b074f506-2568-4506-9557-4a9bc9cbea83@www.fastmail.com>
Date:   Sat, 11 Dec 2021 14:36:04 +0100
Message-ID: <87wnkbuuuz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Joel!

On Thu, Dec 09 2021 at 11:06, Joel Daniels wrote:
> I have an x86 laptop whose CMOS (RTC) clock gains an extra 3.75 seconds
> per day that it is suspended (S3) or off. It keeps time quite accurately
> while awake using the TSC clock source. I use the machine about 1 hour
> per day with the machine in the S3 sleep state for the remaining 23
> hours.
>
> The machine is not usually connected to a network and I do not run an
> NTP daemon (though I do not believe this is relevant). When cold

Believe does not help much for analyzing technical problems. :)

Can you please verify that the problem persists with NTP enabled and
synchronized?

Thanks,

        tglx

