Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193F74902F2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 08:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbiAQHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 02:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiAQHea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:34:30 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837D9C061574;
        Sun, 16 Jan 2022 23:34:30 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id o3so19874208pjs.1;
        Sun, 16 Jan 2022 23:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pk9g25WRpFPs48r7zm5sUpEVslQaRknFfz4t/FLVEiU=;
        b=RaGTC0aQ3uz4reKKahJfMLLELsVCu2ayEhM/j6nlOodNLeNB5a/XNVlAD4+KhlbcO+
         M0Dvs0si/7pissOORAeiEKmGPo+QNS2bv8c4B4LMGewDMU1Db4ZhbWwLbe+MNvGVRp+g
         CIdvcXmNpbgDbHEr1iAAj1mMgpny9mz7LgSqHbAsLdg3uUKO0SybWgGAJLQwFKy5H2yh
         VKgPrGLZcIaQSLqhvM4XEzVoGBBUsdmxikuzDJu37j0rvK3oN7JaU/hU8GxRDPO7vdGN
         9Padw/MmOeWK/BmCpkcDEEHj/6TEPfxtPLvVigtj9iSwE9WVKxozKmwkewr+BdS8b07L
         1A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pk9g25WRpFPs48r7zm5sUpEVslQaRknFfz4t/FLVEiU=;
        b=IMP/D6TRpvf4V2HvVyQbXxnwz/3GOkd4I9DY4gY/0gZ05lT1fzDfwIL2TVCBYLRXNU
         EyM47QAGlT/DZ3+WKvkXAQemPaDJEUM0PdlgaBZAuQzGZsXv8XlK+3bYc5jvNFOOh5GT
         yUXOopxuDHhQXDGGDV3wSVoNVO/4IZrKchAhI8w+P7YqjNolBJUV+yfqQfJ7wsUB3164
         MVSXvHWsbpPAj7qqK707Yfwnpr7OThUYTI4k1O4//Bb7LPmdzQ+FQIEFxnkF0U4fDdGA
         9zW0nwsMrbMcyIZtQ5tB+ocR1xrxlayePzV4+7TyqxDUCr+DS1Ds9z0zuTCU9k60RR05
         sRPw==
X-Gm-Message-State: AOAM530g9lWnUGzeTN+s4G0jssfi2D++8xhjVeQNaZ8MMt8LYP+MYLW1
        gRRsu2LcurmD4Ajd1Z1XGEJSDJ47KJgtdoiEXbE=
X-Google-Smtp-Source: ABdhPJyWuXvmcne1WqXieam6JNmqq2ZZ0W/8Ne39V+bOQAHKd5WhhZcfBApGxHuEqQjqC/DBL9LP14JpYLJ3tIlpmXQ=
X-Received: by 2002:a17:902:bcc1:b0:149:a13f:af62 with SMTP id
 o1-20020a170902bcc100b00149a13faf62mr21072936pls.147.1642404869850; Sun, 16
 Jan 2022 23:34:29 -0800 (PST)
MIME-Version: 1.0
References: <YcJZWiQ407ZxMM+y@bombadil.infradead.org> <20211222132332.7817-1-vimal.agrawal@sophos.com>
 <YcRRQCMZFepB/hzX@infradead.org> <CALkUMdRxTm6STT4CncTuvQ9hM_bez+B91TsuenEj71KPxFgMsg@mail.gmail.com>
 <YcVtG26b/sO9k7ox@infradead.org> <CALkUMdSY3XCHqhH9dDQ+0VHykv9AiBiqLgoC+cj5P=9Q1jdXrg@mail.gmail.com>
 <Yd2nJZRtc3OjPb0w@bombadil.infradead.org> <CALkUMdSc8eNbqptTihwzqhpL9qhGS0xUFr=AFXs3COvpyBoQiw@mail.gmail.com>
 <YeBEAavbBh/MnbEF@bombadil.infradead.org>
In-Reply-To: <YeBEAavbBh/MnbEF@bombadil.infradead.org>
From:   Vimal Agrawal <avimalin@gmail.com>
Date:   Mon, 17 Jan 2022 13:04:18 +0530
Message-ID: <CALkUMdRQ+mJfUVDw5bLWaDkfni1bti0Dd3qk0eupjFZ+eKCrZQ@mail.gmail.com>
Subject: Re: [PATCH v2] kernel/module.c: heuristic enhancement when
 INSTALL_MOD_STRIP= "--strip-unneeded" is used
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Vimal Agrawal <vimal.Agrawal@sophos.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jan Beulich <JBeulich@suse.com>, Jeff Mahoney <jeffm@suse.com>,
        Sam Ravnborg <sam@ravnborg.org>, linux-kbuild@vger.kernel.org,
        jeyu@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

On Thu, Jan 13, 2022 at 8:53 PM Luis Chamberlain <mcgrof@kernel.org> wrote:

>
> You mean it is safe for that case too? If so can you add this to the
> commit log as well?
>
yes. updated in the commit log.

> Can you also use the modules-next tree? I'll still have to test this.
>
> [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/ branch modules-next
>
I am not sure of modules-next but I created the patch (v3) on latest
linux-next (next-20220116). Hope it suffices. Sent patch v3 already.

Vimal
