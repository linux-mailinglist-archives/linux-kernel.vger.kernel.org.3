Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3CC4908F8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:48:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbiAQMrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:47:52 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58220 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbiAQMrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:47:51 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62710611C6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87EFEC36AE7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:47:50 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="jxTyPJoA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642423669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JIRLlbVVis5u8s0hBrGhQwKFxQSA77iBfFr7Eu67/zE=;
        b=jxTyPJoApAb2wwdAMvRX38gK84AlsV4jgRx/9OXkT9ZaX0m2ju3hFF5YFDxe3ozFnwHXUh
        HYByp7NB5AJGyRdlQiUJYZmwZzotilS17Cs7Yl0Ccez+4JLJ4evbSf3rEDPBPgWps/cUw9
        MzDJ9nh5lDFtoev3nZeybWCD3bkwuSo=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 24ce9c37 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jan 2022 12:47:48 +0000 (UTC)
Received: by mail-yb1-f182.google.com with SMTP id m1so26783866ybo.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 04:47:48 -0800 (PST)
X-Gm-Message-State: AOAM531GiyYkh8QnHKhersTot6hnZMOTgyAynLlaeWNNcUBAHPW9Sz2m
        uoCTqFwZQyrcRePJXtz+OY8J4x5KtRhp/kePWBQ=
X-Google-Smtp-Source: ABdhPJzaZNmwxxuqWu4tF/5mRi/0CTO+V2WgdmD482wuh5N9ux0BNnksYSLgLvldyyj3OXdMGZr+tP4oGTS4+t1hCXo=
X-Received: by 2002:a25:e0d7:: with SMTP id x206mr9952050ybg.115.1642423667658;
 Mon, 17 Jan 2022 04:47:47 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
 <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com> <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
In-Reply-To: <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 17 Jan 2022 13:47:37 +0100
X-Gmail-Original-Message-ID: <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
Message-ID: <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey again,

Four years later I went through basically the same motions: "oh hey I
should clean this up", "I'll start with clang format", "oh cool it
adds spaces before the iterator paren so it looks like a normal for
loop to me", "that seems so reasonable; I love clang format", "oh no
checkpatch.pl complains; I hope it's wrong", "I wonder if anybody has
thought about this before", "oh, look, I asked about this already in
2018."

So, here we are again. I'm wondering:
- Can we switch to spaces before iterator parens?
- If not, is clang-format ever going to be fixed to quit adding them?

Regards,
Jason
