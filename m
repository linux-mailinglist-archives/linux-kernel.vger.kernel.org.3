Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237AC46C1FA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240117AbhLGRo7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbhLGRo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:44:58 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C81C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:41:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2F5C5CE1A08
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:41:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7196C341C7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 17:41:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="qEBrot7k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1638898882;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GdyZO4yPBUkXCcWoIcrN45a9rRuGd50+yXWo0OuMTyQ=;
        b=qEBrot7k/9fVRwkznbZ7kcTy12hb4rEvs9QlQW3S5axeor1HRxt/r/eQBerggC34VNnW+M
        Be9LB5nUbrcNNpRB692NPDLd+TlGezCtWvsYIn4qNruM8CSiluLUq14rsAalrAwOHeSlFD
        3i7uo02E2kXM7ZEY0Nt51tHd6jlU8e0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 81313d4d (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 7 Dec 2021 17:41:22 +0000 (UTC)
Received: by mail-yb1-f177.google.com with SMTP id d10so43167911ybn.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:41:21 -0800 (PST)
X-Gm-Message-State: AOAM532G3tkopAImlTQ1v0MriyS4p2R41Vlkga11njiC7n6T31GzO8d2
        ShOROCltVGD0op6aAoy44ULRvygJrSL32GN6FD8=
X-Google-Smtp-Source: ABdhPJyg/YyqxBkm+EiVNxWEevqJ1KPYNyac2UmV7OyAP/kb7CGatkniEAf4k/v6F78XW0VzX/JF8VEu8YHygCpHMcA=
X-Received: by 2002:a25:d393:: with SMTP id e141mr54622006ybf.255.1638898880973;
 Tue, 07 Dec 2021 09:41:20 -0800 (PST)
MIME-Version: 1.0
References: <20211207121737.2347312-1-bigeasy@linutronix.de> <20211207121737.2347312-3-bigeasy@linutronix.de>
In-Reply-To: <20211207121737.2347312-3-bigeasy@linutronix.de>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 7 Dec 2021 18:41:10 +0100
X-Gmail-Original-Message-ID: <CAHmME9rYB7uii-HgorYmuEytoJ3bEyuD2FKkqP_oYqrAUf8cvg@mail.gmail.com>
Message-ID: <CAHmME9rYB7uii-HgorYmuEytoJ3bEyuD2FKkqP_oYqrAUf8cvg@mail.gmail.com>
Subject: Re: [PATCH 2/5] irq: Remove unsued flags argument from __handle_irq_event_percpu().
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to the crng/random.git tree, thanks.
