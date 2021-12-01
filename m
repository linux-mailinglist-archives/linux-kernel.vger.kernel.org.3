Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AAC0465276
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:05:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242781AbhLAQJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:09:10 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:46240 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbhLAQJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:09:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2079BCE1F9D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EEFC53FCD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 16:05:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="cuWB0K91"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638374743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ch4IWrYJXRMMnBZtelJJU8KFGFv+l7MbqI920CggF+w=;
        b=cuWB0K91qC+4SffU1+LTA810xkUvICJxj9cSmdoPECO+c+aRzPvX3ERKSLnQhVEzhtcriH
        N6M5/SiafhQA+hnps488hQmzB0HLsfTH5TTgRLcV/Gvh9X26PPjauQmbyHyhCG5synO91Z
        WeBY+Hfy8CPW1LV2Nn2exUIW1W9YQuA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 70f70f9f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Wed, 1 Dec 2021 16:05:43 +0000 (UTC)
Received: by mail-yb1-f169.google.com with SMTP id g17so64814285ybe.13
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:05:43 -0800 (PST)
X-Gm-Message-State: AOAM532X8AlpVVHutfvW/YAZW3axBlnZcEFp7v1+78slkS/2jVXKpVaP
        AuaaDtB6w6NhRRHwdPPQNmSznE35Ia9L8Le5Ueg=
X-Google-Smtp-Source: ABdhPJzoLwwJgqb5HKhJjqlzzih8Y+eTxVI1Czr7+1ZBjCNIJS0+MnTsA4tLUaJtxhJqLDdaDHNmeuFcFprXxFcVyAA=
X-Received: by 2002:a25:9781:: with SMTP id i1mr8649850ybo.638.1638374742373;
 Wed, 01 Dec 2021 08:05:42 -0800 (PST)
MIME-Version: 1.0
References: <20211130184315.258150-1-Jason@zx2c4.com> <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
In-Reply-To: <1c2862682ff04463c7ca1f58f1c46aec4d6af03d.camel@perches.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 1 Dec 2021 11:05:31 -0500
X-Gmail-Original-Message-ID: <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com>
Message-ID: <CAHmME9q7kVREOGPpG+kafS25Ny1=geFPwLRREe+nkC=UkGQUHw@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: co-maintain random.c
To:     Joe Perches <joe@perches.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Tue, Nov 30, 2021 at 8:01 PM Joe Perches <joe@perches.com> wrote:
> I suggest you reverse the entry order too as Ted really
> hasn't done much to random.c for quite awhile.

Linus applied this already, but also, I both don't think the order
really matters that much, and I'd really rather this be a "co-" thing,
rather than rocking the boat.

Jason
