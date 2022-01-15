Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDB6648F719
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 14:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiAONSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 08:18:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiAONSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 08:18:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78DFC061574
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 05:18:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FBD5B80108
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 13:18:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B16EC36AE3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 13:18:32 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="JlJDVrNP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1642252711;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iBpvh8xZM+BawJ4FoIdxHUF9XVmPhfW4ZHNAopR/5ig=;
        b=JlJDVrNPFXPVCMF3MNyKcK6HR0NJ0wLiipkMr5AiQ0M/p3/Mcpoper/ksJEuiotruWe+Gw
        mAbx3GFCw9Us5ITsDj1HU07t62peVHkPoxgKeabthDWCBNSVa0Uzre1pONgLkbQgbdoPvX
        gn7ci3voBEy7UppehZnWTtPMujUJ3cw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id da99b858 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 15 Jan 2022 13:18:31 +0000 (UTC)
Received: by mail-yb1-f170.google.com with SMTP id e195so1693444ybb.7
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jan 2022 05:18:30 -0800 (PST)
X-Gm-Message-State: AOAM533KWTtnIVs1GfEuFEFeQlUEWe96+8p6ToH1dJDS8mofuacFa0Wb
        RBduIEiaT4o89CKOClmEdsUwCtLne4POQ+XdodQ=
X-Google-Smtp-Source: ABdhPJx+kaMkZrphwZ2eLOfwu0fVaTFVMjS7FwfoVb6L5+iQDtaLlqjMGam0TZaYnwNhh1XuFU4qGfYIGhyiAnphP0w=
X-Received: by 2002:a25:ab29:: with SMTP id u38mr418802ybi.457.1642252710043;
 Sat, 15 Jan 2022 05:18:30 -0800 (PST)
MIME-Version: 1.0
References: <20220114081216.60403-1-schspa@gmail.com>
In-Reply-To: <20220114081216.60403-1-schspa@gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 15 Jan 2022 14:18:19 +0100
X-Gmail-Original-Message-ID: <CAHmME9pnUV93hkbKnmCYkaoFihU0Fp1ccAGLoqTgrQuPFBiX5A@mail.gmail.com>
Message-ID: <CAHmME9pnUV93hkbKnmCYkaoFihU0Fp1ccAGLoqTgrQuPFBiX5A@mail.gmail.com>
Subject: Re: [PATCH] random: fix typo in comments
To:     Schspa Shi <schspa@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied, thanks.

Sorry I missed this yesterday; your email hit my spam filter for some reason.

Jason
