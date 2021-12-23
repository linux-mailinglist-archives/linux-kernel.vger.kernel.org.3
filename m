Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23647E78D
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 19:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349797AbhLWSQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 13:16:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235530AbhLWSQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 13:16:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6DC061401
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 10:16:20 -0800 (PST)
Date:   Thu, 23 Dec 2021 19:16:18 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640283379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVvVGmFRMRgJJlnbFf61zJZphy1Y/40cQiMHN3VaNJw=;
        b=rlj5M4rI4WjlPl+EDtDEsm/6YSRDpIytY+k4st3RKCYb4DnwsgV40xO1I0iU+EjenY9P12
        E88TtlKK2o9ZjlOeR2bVxlpP7iv57K3ZeMLwy1f4Ul/NN90VhwzcAZ2GwfXs++QXDHyPW7
        cz1yNmu5xH9QGje/nneFnQ9YfNwn+BvQYOayUBxJAmAlJR2Aye8lTH5RJ+jdQK54yFadq8
        yzVMNDA6nuTJTer6FVccNu83JN8FFkiW5X5VdAhNxpEMZYFhmqPRyjTvPgYqhSl1RTJCwy
        Eur0s5Z1nOAwDX/J3HfNevdMrRpZdNNTNsl5HuZVayEO7JO6V7qFRfU9R1uI2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640283379;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PVvVGmFRMRgJJlnbFf61zJZphy1Y/40cQiMHN3VaNJw=;
        b=L3yVH5ZNd2FXO8VtARNwSSa4VafQgRl79wBUV3gAexxWl/b2VODPOORlVLBm6Q/D5YZLfh
        hqr3KfCR7ci82sBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -v2] notifier: Return an error when a callback has
 already been registered
Message-ID: <YcS88mkwxbO8Qy7c@linutronix.de>
References: <20211202133601.23527-1-bp@alien8.de>
 <YcSWNdUBS8A2ZB3s@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YcSWNdUBS8A2ZB3s@zn.tnic>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-23 16:31:01 [+0100], Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Return -EEXIST when a notifier callback has already been registered on a
> notifier chain.
> 
> This should avoid any homegrown registration tracking at the callsite
> like
> 
>   https://lore.kernel.org/amd-gfx/20210512013058.6827-1-mukul.joshi@amd.com
> 
> for example.
> 
> This version is an alternative of
> 
>   https://lore.kernel.org/r/20211108101157.15189-1-bp@alien8.de
> 
> which needed to touch every caller not checking the registration
> routine's return value.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian
