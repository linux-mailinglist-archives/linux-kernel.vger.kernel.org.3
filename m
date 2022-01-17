Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1D0349115F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237240AbiAQVlX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:41:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiAQVlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:41:21 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA3CFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:41:21 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id e79so762786iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 13:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ITtYjTNRMw+wZFR0CymyQgyb5XV/OtGzOcVJElxmLuA=;
        b=OHj+gfCkjDNHM76AxlTuaX77Z1WyxEHVRq0w9ZYENW9kyJ+CWyf58IGkth7L+socuh
         NYWBTY3MBqwJJZvlG5iZP/yAa7U6h19wUXETWMsJm3XmoWh+nl5nJYQkRjf0lnRDDI1i
         juStZAR1eD2nFOjdkJ76ntdkIlCsjjgXPHuU88ACAM8XeV8LZIbFSVwBkhkF6DJl9/9Z
         gbERAHj4wgAc1VurfN93fJiPMGGd4updiqB+tM0UQu/B8BVi9R8eZ0UxGmt1eY5cDVPG
         mEs/yF2Ke/VFM9RT5AsI+8V3UweZR7tJktOXfd5Qb+CzvbgzIfJoyFFO4rTXVZgW42yZ
         Cqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ITtYjTNRMw+wZFR0CymyQgyb5XV/OtGzOcVJElxmLuA=;
        b=Gps/JpkIb2iXAXYH8m7vriYlf+G1Ka/O9ODvgGIazMrYCelnUqDoHbejrZQmVXVJoQ
         f1sm+9f+Wn4NmOcTMrbOE6KYUzCjiHtdQirwzCU3MMbsmwwRQ6V+w+pJje9Wb/0wyzUh
         VdR7UctaWLMIdyZJDrjJIjLh+Xw8xy/gQi3brTiaP/5sTVh+R+aDqz3yY+QNMeQXn+tQ
         Qt4JxNjjbkf4R1JGImu9aVNaNnzinq8TUZbRcTRW5CzTCCmbKRprtbghWzb+PG/91uua
         OzHijBx6TdC97j+maLYpmwFDbFgoxzv5717LovZG9dvxQ94SHJshyo1tRIIE/XSbHktV
         reng==
X-Gm-Message-State: AOAM532wpQ9PMRJcdZzdlre6ff4PxNqpCrDCG07uZxTJSXNg1SJ46Mn2
        cTZDxjnu9HRlRTWlNq79/+VBsP9ngHNz0bc+HK9upKnH
X-Google-Smtp-Source: ABdhPJxgVtr64mQngbjEhjcQ4IR7eDKrAWmkinN79u/+yHH6UMQv96PEd6FF4F2VQj/aEviZ5l02PMhrIYIYloQ2M7E=
X-Received: by 2002:a02:7a1b:: with SMTP id a27mr11336706jac.186.1642455681241;
 Mon, 17 Jan 2022 13:41:21 -0800 (PST)
MIME-Version: 1.0
References: <CAHmME9ofzanQTBD_WYBRW49d+gM77rCdh8Utdk4+PM9n_bmKwA@mail.gmail.com>
 <CANiq72=hXXvzfYz-1EdgDNBVfYMiRp2RbjjNF=wwiiPVU+jmuQ@mail.gmail.com>
 <3cbaf145ee577f017cf7aea953c9dd1eb88ed4b4.camel@perches.com>
 <CANiq72=bfYHM6XjQZ9dG_auahA_w59naEXM+VZHGm0m=_7nOqA@mail.gmail.com>
 <CAHmME9pWGsc5wLzNK5pe4gVLPNb4uUWYF8AARK8_K=WYLwdGfQ@mail.gmail.com> <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
In-Reply-To: <CAHmME9p6q5MxLy-_1KaDWz8ksQYAUev1UvaQ-fHhetmy0sNHOg@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 17 Jan 2022 22:41:10 +0100
Message-ID: <CANiq72=HdsTfQt5DWKf065pENN0xrOwvKq+T3JpHdyyRkPVx8w@mail.gmail.com>
Subject: Re: list iterator spacing: clang-format vs checkpatch
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Joe Perches <joe@perches.com>, Andrew Lunn <andrew@lunn.ch>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Mon, Jan 17, 2022 at 1:47 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> - If not, is clang-format ever going to be fixed to quit adding them?

`ControlStatementsExceptForEachMacros` was added in LLVM 11 (and
`SpaceBeforeParensOptions` in LLVM 14, which gives even more
fine-grained control).

So it is coming -- the question is whether we wait a bit until LLVM 11
is the minimum supported version (nowadays LLVM 10) or we are willing
to require LLVM 11.

Cheers,
Miguel
