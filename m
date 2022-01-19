Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0D249354A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 08:15:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351945AbiASHPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 02:15:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbiASHPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 02:15:22 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6E2C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:15:22 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id v186so4679884ybg.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 23:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tGl4nMLems+7E6f9RLfL3TcE1ir7cRrHOqOXat0YP50=;
        b=g831Afh8IJnO+avxY9kcoBiGG1cFLXKdkZNtI/u0By9bg3KN1kFeiU3GO2QMJISmrY
         l86tgc7bbRkvWSJZ1rf1wqAS+OfMB1Q6OF6WI/aAMLdf+lKzb7H7xq6sDZz/iKx9RGqf
         Pc+Ss0zAw10EcuOVQQ7YDDZGehSbrlzh0z5orakBELIHod0OtusZU1V4xfOCNqCJLDWL
         mNweZBNvRGGzBjrmXQTQ7GdKK4eR70EESUlE9tjBAoNsvAFg8d1pB1Nkvx7DleC5gHqZ
         2VxEsax/JC3YNLjeEsfNUuEiPajTtnwad/w/Lzd0eaFEXq7pUB81La0dDKqjkxDK1JqE
         Ck6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tGl4nMLems+7E6f9RLfL3TcE1ir7cRrHOqOXat0YP50=;
        b=mWR+mU55eoxsGET48q45zlxpzf1ErQYxv9It426kgbTtgum8fGIkQM22+XGCSBsCN4
         ny2gIpguehZN4D8/bfudfwyEg5sDyZiVdYVJaq5fbHBiL6gdu5DKHaU98OBYZPj7mAof
         NQ8lvIhYHTkbolgl2LSpEuPSU2y+zh1uZyM+BilH/QRReYunXTBME6NU9bjeE7mmSHyy
         LgynZQs84KpMTWScYcrOMKjIGiDKER+eNZSQGlthor0dFDr8He2zDaraCemPwAPHL7kn
         TBiD4K1fYE9h/3OIx363Q84lblB86WY6J8M3o84YOTyhHc6/gDxXUCIWdO93nu9Ow+S5
         VTXw==
X-Gm-Message-State: AOAM533PZOpXOqJIHj6GsJ/Zdvz1iN36fRztowzWdjg1yOacZH5kvqgU
        lhjPeUNIZKNT2ATUk6pomZ5uIKBOaIyUuGik/L4=
X-Google-Smtp-Source: ABdhPJzev09KIDpfmzgg/ct3i5XC/+88IHcrXmLdaOnTWFBEhfXhIVw1wpYGRrGk3C2wx4/wg77menEJS8b/VhCc6Y8=
X-Received: by 2002:a25:a127:: with SMTP id z36mr40599ybh.547.1642576521188;
 Tue, 18 Jan 2022 23:15:21 -0800 (PST)
MIME-Version: 1.0
References: <20220117074117.3770-1-lukas.bulwahn@gmail.com> <20220119041737.1805441-1-ytcoode@gmail.com>
In-Reply-To: <20220119041737.1805441-1-ytcoode@gmail.com>
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
Date:   Wed, 19 Jan 2022 08:15:10 +0100
Message-ID: <CAKXUXMzmLZ+RzVJ4AmSd6vCjtoATCq+AC3WRE3xbtD7AkgXvZA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Remove redundant assignment to variable ret
To:     Yuntao Wang <ytcoode@gmail.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 5:18 AM Yuntao Wang <ytcoode@gmail.com> wrote:
>
> On Mon, Jan 17, 2022 at 3:47 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> > Dear Yuntao,
> >
> >
> > when you consider removing dead-store assignments guided by some static
> > analyzer, you need to check if the code you are looking at is actually
> > missing an error-handling branch.
> >
> > In this case, ftrace_process_locs() may return -ENOMEM, and the caller
> > needs to appropriately deal with this error return code. Your patch
> > does not change the code at all, i.e., the compiled object code is the
> > same as after the patch as before.
> >
> > Think about how to deal appropriately with the -ENOMEM return in this
> > caller and submit a patch that implements the right error-handling
> > branch or argue in your commit message why that is not needed at all.
> >
> > If you do not understand or cannot check such basic code properties for
> > dead-store assignments, it might be better to work on some other aspect
> > and area of the kernel repository. E.g., the kernel documentation build
> > also has a few warnings that deserve patches to be fixed.
> >
> >
> > Best regards,
> >
> > Lukas
>
> Dear Lukas,
>
> Thanks for your reply.
>
> Actually, I had read the source code carefully and noticed the possible
> error return code -ENOMEM of the ftrace_process_locs() function.
>
> At first I was going to implement an error-handling branch as you said,
> but after digging into more details, I discovered:
>
> - The ftrace_init() function did not handle the error return code of the ftrace_process_locs() function since the first version.
> - The ftrace_module_init() function did not handle it either.
>

This is certainly important information on the rationale, and hence,
this needs to go into the commit message explaining why you propose
this change.

Now, you should also explain: why do you consider it not a problem
that this error situation -ENOMEM is not handled by the caller?

And if so, why should ftrace_process_locs() even return an error code
if this error return is not considered?

Your commit message should really explain this reasoning.

> To keep consistent with the existing code, I just removed the assignment
> in that patch.
>
> Maybe we should deal with the error return code more appropriately,
> at least print some warnings?
>

This might be one way of dealing with it.

Lukas
