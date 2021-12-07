Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAC846C202
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240140AbhLGRq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240186AbhLGRq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:46:57 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A428C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:43:27 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id e3so60254612edu.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:43:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Y/rEbxcGNF3MAPp6cBp9cVx3Zbkbk32Q1fY5/ZaBHM=;
        b=ALV5YLtBTRmrWneGLJ872Xmnlcr4WZC8qOh0ul0elwkcEzismugq1By5INcWr9ZuVy
         mXPepSiQZFyXw/5uy+Y1la7gu/cWplmZaXd69ja0pcXFSE/NKxW5qsixZblTPt917wft
         37LQeFqJi7XZZz7WNWGx/afsBI8CTVhIduL6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Y/rEbxcGNF3MAPp6cBp9cVx3Zbkbk32Q1fY5/ZaBHM=;
        b=w+T7x1ONnvKbP3cbuniH0RIKmsA+Pabll3Sd8Vc9xVDFaZ2Piab7UOUqXmYW2rM2uf
         6JVfTHQim9WuZqY5F0Au4zLQMXz7nb3nxya1/vzH51SUHuz4caECCP5iPF7+N/kueuue
         pYVYYOjR9pYJS6oNM+BdNuw3EriEef1yzVO63PvhIw20gZ9UOUCRYfibX1gvEadQYg7J
         gCRMd5h+ctJQO7Cpm30chz9meGQNHLq+lmY/DbpU+Nixd/5ufMsN8gvzPsVrnLOejxfv
         MBx+BvKJm+1NSd8IeqHkGXxntSyCC85fh6q+R9dKFc7l6V2zhF1Cyz0PJLP6OMuDLUBD
         OAIA==
X-Gm-Message-State: AOAM530EQrUSTsp3w8LvGo4Y8Fr0hBpUs6YODCYYAXT2LhKCPivWqigr
        d7BtUH3PZcqLhwcQgcg+NygFmqTG3o+tOg0b
X-Google-Smtp-Source: ABdhPJzStNBKEPFp+k8b5xxWnKFmAAg/zPG3Novc7gcnoX+xEeF77esAmbp95b3HVX8ZJHONgdVlxw==
X-Received: by 2002:a05:6402:12c1:: with SMTP id k1mr11088713edx.355.1638899005442;
        Tue, 07 Dec 2021 09:43:25 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id gz10sm138829ejc.38.2021.12.07.09.43.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 09:43:23 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id c4so31052543wrd.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:43:23 -0800 (PST)
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr51063976wrx.378.1638899003390;
 Tue, 07 Dec 2021 09:43:23 -0800 (PST)
MIME-Version: 1.0
References: <9f2ad6f1-c1bb-dfac-95c8-7d9eaa7110cc@kernel.dk>
 <Ya2zfVAwh4aQ7KVd@infradead.org> <Ya9E4HDK/LskTV+z@hirez.programming.kicks-ass.net>
 <Ya9hdlBuWYUWRQzs@hirez.programming.kicks-ass.net> <CAHk-=wjtvUDbbcXw0iqAPn3dmZK+RnqVMFrU9i53HzvPtWx_vw@mail.gmail.com>
 <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
In-Reply-To: <Ya+RPbdgEn6l6RbS@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Dec 2021 09:43:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
Message-ID: <CAHk-=whkx24ON4Ow0xkz-FSyb6nsZxxps5gEh7gCaSOvq4MNMw@mail.gmail.com>
Subject: Re: [PATCH] block: switch to atomic_t for request references
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 7, 2021 at 8:52 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> How about we do something like the unsafe_ uaccess functions and do it
> like so?

Look ok by me, but I'd suggest simply making both error cases labels
in that case.

If somebody wants to distinguish them, it's easy to do, and if not you
can just use the same label.

Yes, it's a bit unusual, but once you start using labels for the
exceptional cases, why not do so consistently?

In the case of "dec_and_test" the "decrement to zero" case may not be
hugely exceptional, but if you do the same for "increment with
overflow protection" you do end up having the two different "zero vs
too big", so it would actually be more consistent, I think..

                     Linus
