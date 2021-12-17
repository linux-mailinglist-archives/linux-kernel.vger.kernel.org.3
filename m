Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B132479710
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 23:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbhLQW0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 17:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbhLQW0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 17:26:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D19C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 14:26:54 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1639780012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PzA8WIuH5rPUQsEYiubWUhj4erHsZPJ9zZik+RRJhBU=;
        b=fz4FQoKNEIL2CyXMcLTj2I2C1SyVYpNQ29UjNNodrp7fLOK4BJihFxGmDTsDhYgE3+GOon
        hbZ8K6hWtiFKIZoiDHczoEz1oXw0+280SuEefhDJj8NBKRdYsYjgthLRBEFCQECnz5EsRs
        0ADxRlsdeNTQzUa3QbIdoPg1/ABPtugBoxchrIu5ijeWRdSNFjTjibyG58Xeed0eAGP7hu
        343/WICXzefchW7PjVudbMQ7m+R3tz20YOV7PKtqBJx+FEloxqPc3Y3/WzFvQhAcgPH57d
        6r5Kc/Dv5G4GsLPxwQTlkBX50PpEpSTrUdH0sehh9CXCqCbQxQ+1AmFwRzWTOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1639780012;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PzA8WIuH5rPUQsEYiubWUhj4erHsZPJ9zZik+RRJhBU=;
        b=8To9cski3Fh9yGLae+nMYB84ZKfxRLPriQjBdaQZq3QzG2S1g5vAeVe3xaNmRSV1Vumjpe
        Kw0v4bMFE2xxPdAA==
To:     Xiang wangx <wangxiang@cdjrlc.com>, john.stultz@linaro.org
Cc:     sboyd@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] time/timekeeping: Fix syntax errors in comments
In-Reply-To: <20211212143225.13727-1-wangxiang@cdjrlc.com>
References: <20211212143225.13727-1-wangxiang@cdjrlc.com>
Date:   Fri, 17 Dec 2021 23:26:52 +0100
Message-ID: <875yrmc1g3.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12 2021 at 22:32, Xiang wangx wrote:
> Delete the redundant word 'time'.
>
> Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
> ---
>  kernel/time/timekeeping.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
> index b348749a9fc6..b1fbedd35300 100644
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -1148,7 +1148,7 @@ static int adjust_historical_crosststamp(struct system_time_snapshot *history,
>  			return ret;
>  	}
>  
> -	/* Fixup monotonic raw and real time time values */
> +	/* Fixup monotonic raw and real time values */

It's not redundant because it talks about 'time values'. The 'time
values' which are fixed up are 'monotonic raw' and 'real time'.

So yes, the comment _is_ awkward and hard to read, but removing time
does not make it any better. Something like this;

     /* Fixup the MONOTONIC_RAW and REAL_TIME time values */

Hmm?

Thanks,

        tglx
 
