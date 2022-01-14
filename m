Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD03148EEAF
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 17:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243607AbiANQuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 11:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243606AbiANQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:50:21 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0113EC06173F;
        Fri, 14 Jan 2022 08:50:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id q25so36141011edb.2;
        Fri, 14 Jan 2022 08:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CBg3OKueCzhYkiPcmIZrRhu5Y4ClyxxrpwnoSfYSCBA=;
        b=MvDbBAySQAgo4JXyisc+T8HVcVx4XtV+DKMElAaUW5PFxQUMcFcj5aRS3WH9RTF4yB
         5ZAtts1biRf4OxZ3SPqa7qW4BaI8NUwVWLTpnA454bds/UBF5GKrYpyNPwwYCD+LJniU
         X6fEsXxFZlQNxomfI6Jt0AiEOPqzqGdyHM9sJ2Pw964f5ICachhgTWWDu1DqfoJCurbL
         0NatyqqZFO/UwsbUZvxmhQMCVsth/QAJJoxjdyWJ3XS9k+Ii4E0r3tJULjDdWCQfX7/w
         JiCyRfU6aMnQ1FzVb8txhGEFZaDw1hTD4Vqm/j7r3cfkGzVuqqou+QL/ty+FVm8rQoNw
         1xiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CBg3OKueCzhYkiPcmIZrRhu5Y4ClyxxrpwnoSfYSCBA=;
        b=JFJkRngP7LfZzWdQzaG6UTbNvYHl2/T7SLeG6m6hauvyQpI0aEUy8hkitQrB0HNNuf
         rbXNZH1XkKSgko16zJPKSY5RMEmGASFfissj0JpQWOPEzXBruWeiiPmQz6LLMO0o7oxx
         qg1PneJSprVXKU+OIZDWBHLRaHuqP5/L0+FGcBBb5f+0lgF0WUC4pGgw6sprNiYu9B11
         RcgggqdoJC/1gPRfg+4AtlOy3XkPidzRdjeTiRIajW+L4gqWyif5y1SDm/f1hL8Q4TrO
         ihkvEWhnme/Gr0pdDl7jA0KT/ymkjRFA5G+sTf/+LjFoBN7slhZPkZ5sLByuI/Kh2FaM
         S2wQ==
X-Gm-Message-State: AOAM531qpclQ/thk9c3V16XnQ+LguY06LWgbfAKwvQupk0qD28y0UbNw
        TPxSLzepVPWLlvrFVuXZoKnEMSibrT8=
X-Google-Smtp-Source: ABdhPJyBipAPToIgIJjiYIAreHEQqddaRCSgBL+Cf/PTJbSkAtdcBkJF2E+tGh3cLOj8mxcIkzOwXw==
X-Received: by 2002:a05:6402:350b:: with SMTP id b11mr9708123edd.355.1642179019638;
        Fri, 14 Jan 2022 08:50:19 -0800 (PST)
Received: from standask-GA-A55M-S2HP ([188.123.115.255])
        by smtp.gmail.com with ESMTPSA id g11sm2543830edq.46.2022.01.14.08.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:50:19 -0800 (PST)
Date:   Fri, 14 Jan 2022 17:50:17 +0100
From:   Stanislav Jakubek <stano.jakubek@gmail.com>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: trivial-devices: fix comment indentation
Message-ID: <20220114165017.GA2035@standask-GA-A55M-S2HP>
References: <cover.1642080090.git.stano.jakubek@gmail.com>
 <ea7e6b645fb1c2612f14ca62471180a38d51e9f9.1642080090.git.stano.jakubek@gmail.com>
 <YeGVEMl5aKgIHZIv@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGVEMl5aKgIHZIv@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 09:21:52AM -0600, Rob Herring wrote:
> On Thu, Jan 13, 2022 at 02:39:40PM +0100, Stanislav Jakubek wrote:
> > Indent comments the same as the content they describe.
> > Fixes yamllint warnings like:
> > 32:13     warning  comment not indented like content  (comments-indentation)
> 
> But that's not a warning we enable or is this something new in newer 
> yamllint?

Don't know, I just noticed that the comment indentation is inconsistent and
decided to fix that, but checkpatch wasn't complaining about it, so I ran it
through yamllint to check which one is "correct". I guess the default
yamllint config complains about it.

It also gave me errors about some line lengths being > 80, but I decided to
leave those alone. Not sure if it's worth it to break up the comments into
multiple lines for that.

Thanks,

Stanislav

> 
> In any case, a change like this can only be done at the end of the merge 
> window just before rc1. Otherwise, it is merge conflict hell. I would do 
> that, but I really prefer it the way it is. The reason is it makes the 
> '-' stand out more and those are easy to miss in yaml. For example, 
> these look the same but are a bit different:
> 
> - items:
>   - const: foo
> 
> - items:
>     const: foo
> 
> > 
> > Signed-off-by: Stanislav Jakubek <stano.jakubek@gmail.com>
> > ---
> >  .../devicetree/bindings/trivial-devices.yaml  | 314 +++++++++---------
> >  1 file changed, 157 insertions(+), 157 deletions(-)
