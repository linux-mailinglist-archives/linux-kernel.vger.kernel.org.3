Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E59B59AB75
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 07:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239183AbiHTFTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 01:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiHTFTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 01:19:06 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAC07C1B7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:19:05 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id b2so4617280qkh.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 22:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc;
        bh=m1ZgOOcYV8mHJXYst5LUHqU1/N8VfT3HL95UJv2V6BI=;
        b=QV1tGTIGGCQVqlIktR5AzfD2Wllh970Q32ecVIOFLgLmTuApIw8W172YHxf9e8F4hl
         PdNxGWs0DQaSVygO2HoyktsmzksADC2ZInArRqqb4kkfbFuj0zYOqJ6qUVtZO7tXNRY9
         t0P1V+IRSvRINwWcaWecCpZZgSZ8Q5sim0/K5I+xJYEO6V7+X76Yc56grJ5yHrRKxYLX
         7yWwvOdorAGUXlZt1Ld4SnFkdvO82YBKD1muZFx9lgqtTANNqL7hldfvFGlK4npGMjZS
         pcf4yfJ8p/+bXngCn4BF3G5Rh8+RE0/xz6xBzXlrzBLfFBYnHGvV7s61Xa4ZoTRP3BU4
         LoXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc;
        bh=m1ZgOOcYV8mHJXYst5LUHqU1/N8VfT3HL95UJv2V6BI=;
        b=1y8Fgy8lCg8bS0HB5DAxrP0gKALuKZkCYt11WEE0O68PlNsMdOxwwz7q9ekHRDaZUL
         YOGdzMLospz7xRz++8XvplOGOI+hmx9BgImMt7T7MzYUWVQoKsGWBdaRMhNBbqWhdVSF
         69Jf2e9fIZXYBKd8hyY6KAi/yH8ZHdV3CvdamE+yfo+uCqE/S5CGB3Apam2GP89JpLHp
         qfj4fNd0WB2DQRcwlMrxsLtRxWehLVxl5eVOiy51v0jmewSjlN3uUqeUjNrmxFnkaK57
         WInEr3fjyQGaKCP4w8aQrMwVHred9V1+pxxL9M8adY+sXYG2Gcz9lhwvoRNlseLyMPiy
         jHkQ==
X-Gm-Message-State: ACgBeo08swH926npplSDccdOe0RaeIVXh4IoxLpIUTqio0RsfoF/qHcE
        u/pKGUG/04VU5t1Yc1aDFtw=
X-Google-Smtp-Source: AA6agR51WCgo92S0fZIV2kjB+hgxcuoY9623EgbybJ5QEd0PDAwxB5s7/6BW2aSO2arGGASOxwSIqQ==
X-Received: by 2002:a05:620a:4513:b0:6ba:e66a:191 with SMTP id t19-20020a05620a451300b006bae66a0191mr7192014qkp.746.1660972744842;
        Fri, 19 Aug 2022 22:19:04 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ga10-20020a05622a590a00b003430589dd34sm4556959qtb.57.2022.08.19.22.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 22:19:03 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9473D27C0054;
        Sat, 20 Aug 2022 01:19:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 20 Aug 2022 01:19:03 -0400
X-ME-Sender: <xms:x24AY4tG3OQrWRjxHpWU6SAzzRUrdR4U-Uco3cKKiAzOEJ2COY4AmQ>
    <xme:x24AY1cHRTPw9zB4cxCFHkFY7J7KuhiDnndw0SdfI1AKcZcwK64YfCEVdwvCypQ9z
    sv-HN3FuF4ghOL5yA>
X-ME-Received: <xmr:x24AYzyikAZbMFKLDjneTPuf1yXxFjnaIBAL4iuvwNxnaGTBvLeR637JWQDRoA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeivddgleefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejffegieejvddtgfekkefhjeegjeevuedugfehfedtkeffjedtleeiuefh
    vdefgeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:x24AY7NniplraRskudOqnSajRFfUIhAdNmnYWeIdmjBc0zPhIN9-5A>
    <xmx:x24AY4-9YMjFZsyAjP3dFR-ltH0xmV8Fn4iXxxL5vO4Jx_ZNISb_MA>
    <xmx:x24AYzXMOX4Dc7s-nWdGTXhxD_iaMvGlBqTioNyEz6m-gdvqw01p8w>
    <xmx:x24AY4xk5JbROPN9uuYM2HViQARqUiI951wSn0-7aIC5iCP5tJO9_A>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 20 Aug 2022 01:19:02 -0400 (EDT)
Date:   Fri, 19 Aug 2022 22:18:37 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        kernel <kernel@axis.com>, Waiman Long <longman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdep: Panic on warning if panic_on_warn is set
Message-ID: <YwBurQWDUSZPfyqm@boqun-archlinux>
References: <20220818114259.2203505-1-vincent.whitchurch@axis.com>
 <Yv6z3SlfpmN+ZeV1@boqun-archlinux>
 <Yv9tLO2nbRBVyXgl@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv9tLO2nbRBVyXgl@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022 at 12:59:56PM +0200, Vincent Whitchurch wrote:
> On Thu, Aug 18, 2022 at 11:49:17PM +0200, Boqun Feng wrote:
> > On Thu, Aug 18, 2022 at 01:42:58PM +0200, Vincent Whitchurch wrote:
> > > There does not seem to be any way to get the system to panic if a
> > > lockdep warning is emitted, since those warnings don't use the normal
> > > WARN() infrastructure.  Panicking on any lockdep warning can be
> > > desirable when the kernel is being run in a controlled environment
> > > solely for the purpose of testing.  Make lockdep respect panic_on_warn
> > > to allow this, similar to KASAN and others.
> > > 
> > 
> > I'm not completely against this, but could you explain why you want to
> > panic on lockdep warning? I assume you want to have a kdump so that you
> > can understand the lock bugs closely? But lockdep discovers lock issue
> > possiblity, so it's not an after-the-fact detector. In other words, when
> > lockdep warns, the deadlock cases don't happen in the meanwhile. And
> > also lockdep tries very hard to print useful information to locate the
> > issues.
> 
> I'm not trying to obtain a kdump in this case.  I test device drivers
> under UML[0] and I want to make the tests stop and fail immediately if
> the driver triggers any kind of problem which results in splats in the
> log.  I achieve this using panic_on_warn, panic_on_taint, and oops=panic
> which result in a panic and an error exit code from UML.
> 
> [0] https://lore.kernel.org/lkml/20220311162445.346685-1-vincent.whitchurch@axis.com/
> 
> For lockdep, without this patch, I would be forced to parse the logs
> after each test to determine if the test trigger a lockdep splat or not.
> 

In that case, would a standard line with every lockdep warning help? For
example:

[...] A LOCKDEP issue detected.

Two reasons I don't think making lockdep warning as panic is a good
idea:

* We don't know what other CIs expect, given today lockdep doesn't panic
  with panic_on_warn, this patch is a change of behaviors to them, and
  it may break their setups/scripts.

* As I said, lockdep warnings are different than other warnings, and
  panicking doesn't provide more information for debugging.

So I think an extra line helping scripts to parse may be better.

Work for you?

Regards,
Boqun

> > This patch add lockdep_panic() to a few places, and it's a pain for
> > maintaining. So why do you want to panic on lockdep warning?
> 
> It's adding the call to a lot of places since there is no existing
> common function indicating the end of a lockdep warning.  I can move the
> already duplicated dump_stack() calls into the new function too so that
> some code is removed.  The "stack backtrace" could possible be
> consolidated too, but one of the call sites uses printk instead of
> pr_warn so I wasn't sure if it was OK to change that to a warn too.
