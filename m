Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF80546A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbiFJQJE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbiFJQI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 12:08:57 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CA866141;
        Fri, 10 Jun 2022 09:08:55 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id y12so25748714ior.7;
        Fri, 10 Jun 2022 09:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vxkopfx3oitF+1kts0RbzQLYlRaI5LJzdMqQSDy1/EQ=;
        b=dLBm4bPkIR3mpGg+Q5ocQC0UzT3Ru2tFsf+60ANewme9OXhFy4K3BLnaRyaXR9ouYA
         QahViZu4cwoQKFgzEXVh8NCuyyM+5wk/VkldqXTMIwC+e6Fh+54wVY2aOCVYpovlVTqI
         stZLB1OcirhXo/tpXAsApaN4eqrYdSZlzUNUGL+Vas/KlNhY7RmSNaxWUysoiEdeEzMK
         g88K0TGLiIqfMo5vxYM9BJgwC/bDBkgTP8thBGRKWlJF/JV+u3yYSr151vYGk+UTd3/C
         Y8ogwWhBxUsAP9PeyC4TCuUXwUOqFdzA9JcyknG6QlyTxeNCDwtU0LkrDq4LnU8mq5kn
         EDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vxkopfx3oitF+1kts0RbzQLYlRaI5LJzdMqQSDy1/EQ=;
        b=IF3rUXRE3IfjHb7r7fIeP+2+YY6ms/MO++f0xpOCFo3KR376WhasDnuTtJmFjvUWtE
         CJj30dhVyKjHhWxsXqPbQKuhFagopZ5aos1IndX+Gxbhf+pudSsZye+6yuSWxqSrR1hd
         nf6Ysj/BbbGbOLUXulT/PVpFg7gXioUbdiEftfFHdgSMMqpX+PdBHC3dclBwc+kn8XIJ
         dMaMzen/9zaP/RyDzcC88Ax3M4nKtkxFITHbLShoEgq7U7lhkYhATzGGbZqtL38YJFOc
         QO14smw3GaPNSrIgRyef79eOcwQuFIV6FbxKw3l9SKFxF+wYvE28p8DIuB7bTQ5nbqr8
         opFw==
X-Gm-Message-State: AOAM531kpNZg2ksuuhrTkrbHiH6fh1TvhE7s5C2Dvb29X6kOYTHaGFNi
        iyCZxgOFePnPKd+yRb2Kubel8PINBLEGstUfIgwTUmxCxj8yig==
X-Google-Smtp-Source: ABdhPJyMpIVJAjZH7mO3KZXqPIGwH3H2WfsDBbF+S8G6fzBvx+qqT+Z9hpdH8U4fQJ3zGwsJqHT37VorBzHa+AXLbo8=
X-Received: by 2002:a05:6602:1606:b0:669:6745:80e9 with SMTP id
 x6-20020a056602160600b00669674580e9mr11202365iow.177.1654877334850; Fri, 10
 Jun 2022 09:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
 <732154bc-aa35-2326-2b64-87b6c4dd02e7@gmail.com> <871qvw2898.fsf@intel.com>
In-Reply-To: <871qvw2898.fsf@intel.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 10 Jun 2022 18:08:43 +0200
Message-ID: <CANiq72n3MQnjenbQGBUKD+SqNzdGUyJW9zjTOVY4+6cKBRc9ig@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] docs/doc-guide: Update guidelines for title adornments
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Akira Yokosawa <akiyks@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 10, 2022 at 11:11 AM Jani Nikula
<jani.nikula@linux.intel.com> wrote:
>
> When I wrote the original guidelines, it was my subjective decision to
> steer towards using the same title adornment styles and ordering across
> the kernel documentation. I intentionally left out all the
> reStructuredText details about this, because the definitive
> documentation is the reStructuredText documentation we can refer to.
>
> While the "Nth level title" is a more precise description, I'm not sure
> it's actually helpful without describing how these levels should map to
> kernel documentation structure. (Not saying the original did that
> either, but then there wasn't much structure to speak of.)

To give a bit of context: this patch followed from a question I asked
to Jonathan and Akira privately. Currently it is hard to tell the
"nesting level", and even worse, existing files are not consistent and
checking is not automated. Therefore, an easy way to handle this is to
request to follow the same pattern regardless of nesting across the
tree.

> Improving the documentation on documentation is great, but I think it's
> a bad sign when length of the notes and warnings on something far exceed
> the length of the thing being documented. The bulk of the text should be
> helpful enough for people to DTRT, while leaving out exhaustive
> descriptions of all the details that should just be references to
> reStructuredText documentation.

Perhaps we can move the rationale to the commit message, and keep only
the current rules in the document. What about something like:

"""
Please stick to this relative order of adornments within each file
(i.e. regardless of nesting level across the kernel tree):

    1. ``=`` with overline.
    2. ``=``.
    3. ``-``.
    4. ``~``.

For instance::

    =====
    First
    =====

    Second
    ======

    Third
    -----

    Fourth
    ~~~~~~
"""

Cheers,
Miguel
