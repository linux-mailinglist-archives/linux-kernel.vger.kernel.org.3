Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA22B523F5F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348212AbiEKVRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348205AbiEKVQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:16:33 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BBDBE7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:16:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ba17so4024343edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2PwEoNqfD2KijrCYiqA1CvcUEjJJfq6/rtYAQDMGrWA=;
        b=swPF1vi/3ZNiNcavX6RnOzJFwy23L2LNLBDahNLQqRVl62TwELY4tr8SAKNqefXEXE
         L78i8XineAbToYOoZGt9Uar10p4VQ352442NwUBTmmPuNpJErRmXCrdOpqsFEwX3kgwu
         uJKwCw/64fdvSrmyvpA4nf+GfdfB6WyEPLw3nHIXINh84GkT1gJWYedzDyasZ9N14woa
         IribOI/W6mDO2LxFmq16o2QT3OFmj/0XCaZi20pbcHFQh8j/E18u4PZkAT55L/Gn9aqU
         OPrqVnD//x2mK42/7xHQVeHUVrxGGfQsvbFXipbTYA+BVlxnDNvx+XAIjLnGibYMQkWo
         ISjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2PwEoNqfD2KijrCYiqA1CvcUEjJJfq6/rtYAQDMGrWA=;
        b=j3v9WbRL8rAKLtYS5BR7jRhWy0S0mYt0eMTqxWazax2ghCSoy2nEalCsFRwsSf0hcV
         MGctFS5zfVNYknyZ3IdPjtg1Ozc+aqlyNmLCNTZSC6uQw5ufuw8iL4DbX45KYVsa2nl6
         ER21m+Oxf76Z+wyVDkZWAi615aBE/XYSt9TRorPCPzcLKOcLHkuSUBe8v7p0/tPL1yPN
         SxPc4/Rw3HMrnE2K8hoCjio9j5jt7dJ19DSq5tv448oQm/QQqZqIRy3XTJGtgwE2Ux9J
         yVncFS2fE/SFOMmtpira0d6eEb9eXaYYTxt7wCq/Vga8AhQu4Ee5NkMXvswmghk6t9SF
         gFZA==
X-Gm-Message-State: AOAM5305CZVjx4B2opNO9dqQClsfBtWdLr6+YyeRsjYEZSSUIznUo40p
        F7JwS66A0xg+6bhFbKtQ4LJqjfXTL4Vz8DKI1hbLx/1sXKB0nkVK
X-Google-Smtp-Source: ABdhPJwQ4aHP68hlPfgw+wG+p7luBYpvsD0RlQUldfaoOS+D+x4SfN9AB4xsedr0HsGOPH7N1bXqV217LyjqDnDDnkw=
X-Received: by 2002:a05:6402:40c5:b0:427:af77:c10c with SMTP id
 z5-20020a05640240c500b00427af77c10cmr31494041edb.387.1652303789673; Wed, 11
 May 2022 14:16:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220408215105.2332902-1-dlatypov@google.com>
In-Reply-To: <20220408215105.2332902-1-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 11 May 2022 17:16:17 -0400
Message-ID: <CAFd5g458=ReAz0AAbswOsgZUjGMFR56kk1mazMNu7juLLsb4hw@mail.gmail.com>
Subject: Re: [PATCH v2] kunit: tool: update test counts summary line format
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 5:51 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> Before:
> > Testing complete. Passed: 137, Failed: 0, Crashed: 0, Skipped: 36, Errors: 0
>
> After:
> > Testing complete. Ran 173 tests: passed: 137, skipped: 36
>
> Even with our current set of statuses, the output is a bit verbose.
> It could get worse in the future if we add more (e.g. timeout, kasan).
> Let's only print the relevant ones.
>
> I had previously been sympathetic to the argument that always
> printing out all the statuses would make it easier to parse results.
> But now we have commit acd8e8407b8f ("kunit: Print test statistics on
> failure"), there are test counts printed out in the raw output.
> We don't currently print out an overall total across all suites, but it
> would be easy to add, if we see a need for that.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> Co-developed-by: David Gow <davidgow@google.com>
> Signed-off-by: David Gow <davidgow@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
