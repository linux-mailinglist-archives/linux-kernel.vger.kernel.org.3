Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18D24A5FA4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 16:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239820AbiBAPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 10:09:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbiBAPJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 10:09:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A325C061714;
        Tue,  1 Feb 2022 07:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=AN/jspz2JoBPtJ1HTGOsT/p4u4etOkVQMVBmx8Uzn50=; b=WZ5e8OwGjvIoFUlKOzpq5r3JBZ
        FNMjL8sIW2SyI5neFlh6We62xXvGsLHHSQGOCSHhXHiil6prF36INPc9/M/30qCMpULBBpjNcwlIk
        zbxzOOFt8hFGA1lr6V/RfHtRleV/Ttq+QYj5noyMiCeI6Ps7WRZQZGtmxptqMWOfyWchzSdu4bL0o
        GKXjdYpFFbB7IqWLtgQXfvOAASjQnbAje4SMi7GutaLWLk6ax1JuUCGUuUU6y+z3iwQj2rwjGJHga
        yfh95Fu66JdHlHGFGUvwOp3bEplThJuI5WFa5L+Wb5Hx6EAnG1Zbb5oZjGFKdwFYz1G38BxqilLZH
        YflpeprA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nEumr-00CSpr-Nm; Tue, 01 Feb 2022 15:09:41 +0000
Date:   Tue, 1 Feb 2022 15:09:41 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Ingo Molnar <mingo@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-doc@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] linux/const.h: Explain how __is_constexpr() works
Message-ID: <YflNNRCibwcy7F3Q@casper.infradead.org>
References: <20220131204357.1133674-1-keescook@chromium.org>
 <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc86fdf7-3202-e836-6f71-af1e2458b105@rasmusvillemoes.dk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:05:53PM +0100, Rasmus Villemoes wrote:
> I don't think adding slightly inaccurate comments would help a future
> reader at all. Then it's better to just stick to Linus' "it's art, and
> art should not be explained".

/* You are not expected to understand this */
