Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38F49F803
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348092AbiA1LN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238792AbiA1LN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:13:58 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A94C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:13:57 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id j14so8530764lja.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 03:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=9F4VhxP4SHL7oJExWpXEmXdSPfoShTeHP4aiHJ97OCc=;
        b=TOAKTiOjd6bbG8kOtKUP13KD6Osf7b9AVq1VqEZwyN+snKDfJoaDAYAj84qVeu85gU
         sF32D1a+QcXq9EUG9IYWoEwkk777+/FY88LkPkKTW56wtbj5jtDzBgZv2HxKC63NVizC
         RY2Zk1rN5fC8ecvXxxm+KOUkqHcXrZBD7pHziRDoZo+54L+b8dh8OpqIwJ3Mza5aE6m2
         /TYbI4Lmdy6QW/y1wsDi+AI6g5pEkA7Ow8lkfNdhc8bsR0slUV7KgvkdSZac6zxTuKZe
         QaXmPeb3a4uKSZNhoROBdWZBwKhtHbtTgaRHZxvaPFX5K/p7xIzG4JO6AliLqUEyRe27
         3JtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=9F4VhxP4SHL7oJExWpXEmXdSPfoShTeHP4aiHJ97OCc=;
        b=dDMtv4XPdIEJcB1Q3htI7JtpkstyhxhRMLCI1RyoV/3fjlorIamB6yw75IScwB2kXP
         m4ywli7W1+DniPMbQERfvhfR3STP36Kv49l+zeWlZo9tcfUG6IjiOhRThjM1WShWEhIK
         mf+NOOkZ+PR3rF8Y5rLOoBCOsEtNZJ4/wMqSu1gGeJOSjMyo4WwdNv47GGVnaC90TajL
         R/BygCkwQyNBkcOrdnnqFVH5OnuTkJgVqtfWWJbV43QktEEjUkft8XJ5wZdgM1hFExcn
         Qpda0zi7g1vpaieso7b9Rsi5bJI2ih2sbL5IX8/j/qzexVE4yWdOG7yvdnZub6CO9Ghb
         e+9A==
X-Gm-Message-State: AOAM532B6gwgx9k8bw18cSfdDNJhSk0UCvFQrskG+FQsY+pc0uVtJ7Or
        J4ruSAG21YxJjQ1YoWJ47DU=
X-Google-Smtp-Source: ABdhPJw7D5wRlMIt2p7LEmvCtXl4uMKhgMbXX85L6qr2idj94F4weaSACBAteuGkKoetRSt+Jo9GxQ==
X-Received: by 2002:a05:651c:984:: with SMTP id b4mr5453766ljq.235.1643368436220;
        Fri, 28 Jan 2022 03:13:56 -0800 (PST)
Received: from [10.3.154.43] (staticline-31-183-166-172.toya.net.pl. [31.183.166.172])
        by smtp.gmail.com with ESMTPSA id p16sm787665ljc.86.2022.01.28.03.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 03:13:55 -0800 (PST)
Message-ID: <066fa177642ce6907df06819676cd29c0745e816.camel@gmail.com>
Subject: Re: [PATCH 06/16] tools/include: Add cache.h stub
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        mike.rapoport@gmail.com, linux-kernel@vger.kernel.org
Date:   Fri, 28 Jan 2022 12:13:54 +0100
In-Reply-To: <YfKlfoKXyFZxB/UD@casper.infradead.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
         <fa6e6abc6a214f85089c8a10b8df72d0402c6166.1643206612.git.karolinadrobnik@gmail.com>
         <YfKlfoKXyFZxB/UD@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-01-27 at 14:00 +0000, Matthew Wilcox wrote:
> On Thu, Jan 27, 2022 at 02:21:24PM +0100, Karolina Drobnik wrote:
> > +++ b/tools/include/linux/cache.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _TOOLS_LINUX_CACHE_H
> > +#define _TOOLS_LINUX_CACHE_H
> > +
> > +#define L1_CACHE_SHIFT         5
> > +#define L1_CACHE_BYTES         BIT(L1_CACHE_SHIFT)
> > +
> > +#define SMP_CACHE_BYTES L1_CACHE_BYTES
> > +
> > +#endif
> 
> You've added an implicit dependency on include/vdso/bits.h which
> seems
> unpleasant ...

I'll admit that I just tried to make checkpatch.pl happy with this
change. But you're right, adding such a dependency is undesirable. I
can define it as (1 << L1_CACHE_SHIFT) and ignore the warning.

Is it fine to do so for tools/testing code?

