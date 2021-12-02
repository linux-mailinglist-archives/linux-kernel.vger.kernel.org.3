Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9BF465D93
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:49:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344917AbhLBEwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:52:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:44692 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbhLBEw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:52:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E12D7CE215D
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 04:49:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EA5C00446;
        Thu,  2 Dec 2021 04:49:04 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="d0SXFN2M"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638420542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=I7h5wwoUrDU87eyrmLKOx7SiwJlXGwnFT4rulXd0vMg=;
        b=d0SXFN2MfS9XeFThnM8l1ORz8AkhAuDBKv25YUv72rRKqqCc9DSXRbcTYiWKLUt/vXIy3t
        ll2F/EIo4NmTa8vwgV8QoH1xCExBAu5rB2evFMEzopifKVEzGIe2geeJp09q4K5JvJLSpU
        gvEkLKgI4x4LyqyMYlMgk3YXXaYrW1U=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fcb0a9f2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 2 Dec 2021 04:49:02 +0000 (UTC)
Date:   Wed, 1 Dec 2021 23:48:58 -0500
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     tytso@mit.edu, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] random: Document add_hwgenerator_randomness() with other
 input functions
Message-ID: <YahQOjroOQSbB9CR@zx2c4.com>
References: <20211201174449.1359595-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201174449.1359595-1-broonie@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Wed, Dec 01, 2021 at 05:44:49PM +0000, Mark Brown wrote:
> The section at the top of random.c which documents the input functions
> available does not document add_hwgenerator_randomness() which might lead
> a reader to overlook it. Add a brief note about it.
> 
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
> 
> Ted, I've been sending this for almost two years at this point and
> you've not commented on it - if there's some issue please let me know.

Sorry for the delay. I've queued this up in my random tree now after
incorporating Randy's punctuation suggestion from two of the former
posts:

https://git.kernel.org/zx2c4/random-linux/c/91995de6b6dd91

This will transition through the various trees next time I send a pull.

Regards,
Jason
