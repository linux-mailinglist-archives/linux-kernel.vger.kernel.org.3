Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B539246C75F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 23:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237928AbhLGWYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 17:24:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233310AbhLGWYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 17:24:39 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D56AC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 14:21:09 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id v19so217614plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 14:21:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0U14AlJmwfB+e/RVYOfwirVVU1ISVmq48sy+HOK9HUU=;
        b=L1FSJ/KwaTmbswiwLO5H3JAbe6EdsY605iXcH//Ll1DUiWACcbZLD8gaKzKbuhgCer
         o1p8PSf9Duc/6nNpfRi/Gd85Hft199FDAdT04hIYp+cczigwoPyeRIHGzHEhWNkXv057
         qjc03gIBBYyeiEUtur/r6KPD9ZgOigsPkuYUC0M8ntHMeQzDQxEgEtZc6c7QDmDVOXdX
         5fPSGwfNNDoqJQd8RETKbvrQM8sWQFl44KA4sWrNkMBH8VCQeM7mPnPLQ/vbvdr3PyBJ
         PJWhkofV0im2TyuZ+AhmoQz2DJNBEAxC+2xvNR3kUOsC5fLdwT2Slq0dRt3lfX5JSocT
         NRqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0U14AlJmwfB+e/RVYOfwirVVU1ISVmq48sy+HOK9HUU=;
        b=y5739NqIk68ItYVv8A6CayFThdiNHa4T8+6WOGgvR6oNTZr8BOTUo83p7HHJjx89pg
         iU06idQCWEn9r9/Ys5oIBOVAej/Mm68W+MMuRvHwayRVKrvwhGhdinmgkqTspURGPw+c
         E3dAaLC32haIruXGMESNNvA6i1t1PWEvDSgApXcEpsF655zEz4rpXNKFVdC0WIMwF3iQ
         A3wpdA2OSWH0YDGVOb8LtYNwqp+US0BaYysW2mf4pXRnWxRcuq6cXtbQCsfHkq+Q0nn4
         q+O8/08nvgYri7+3KP2n4fESvGiFHYPJvOQaU1i2pqnKOUjz5UzljAMpbrUww65lxM/V
         RGYA==
X-Gm-Message-State: AOAM532NtnHA9I9sN1wqm1kLLaunS1T/voI9yomRfiHVklYxnHKTosw3
        gBngJ+NZUx1/XGcalaNEGYRblxBzfmHlACWruWU5wA==
X-Google-Smtp-Source: ABdhPJxdZxxEERlxR9HetbGs+nmDuevgLWgjNa/dJICW8sAh/CIABDON8aM6odojPC8knmmLBCz5Is1zHgk1l9i0HKE=
X-Received: by 2002:a17:90b:230c:: with SMTP id mt12mr2394253pjb.63.1638915668434;
 Tue, 07 Dec 2021 14:21:08 -0800 (PST)
MIME-Version: 1.0
References: <20211009015406.1311319-1-dlatypov@google.com> <20211009015406.1311319-2-dlatypov@google.com>
In-Reply-To: <20211009015406.1311319-2-dlatypov@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 7 Dec 2021 17:20:57 -0500
Message-ID: <CAFd5g44yXaVG+w+G3EXLkbgHvxSQ3baE_=wTD7EQAK+sroaEkw@mail.gmail.com>
Subject: Re: [PATCH 2/2] kunit: tool: delete kunit_parser.TestResult type
To:     Daniel Latypov <dlatypov@google.com>
Cc:     davidgow@google.com, linux-kernel@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        skhan@linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 8, 2021 at 9:54 PM Daniel Latypov <dlatypov@google.com> wrote:
>
> The `log` field is unused, and the `status` field is accessible via
> `test.status`.
>
> So it's simpler to just return the main `Test` object directly.
>
> And since we're no longer returning a namedtuple, which has no type
> annotations, this hopefully means typecheckers are better equipped to
> find any errors.
>
> Signed-off-by: Daniel Latypov <dlatypov@google.com>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
