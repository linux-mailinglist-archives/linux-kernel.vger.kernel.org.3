Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51172470E7C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 00:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345012AbhLJXV3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 10 Dec 2021 18:21:29 -0500
Received: from mail-ot1-f41.google.com ([209.85.210.41]:37623 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231503AbhLJXV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 18:21:28 -0500
Received: by mail-ot1-f41.google.com with SMTP id h19-20020a9d3e53000000b0056547b797b2so11161207otg.4;
        Fri, 10 Dec 2021 15:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OO20A+zOl/DyD3c13V07SAG8BSX+P3+ych6htZ+qir8=;
        b=4qSKAt+uNasvYmcMFuwSSOXDhIl1w2N+uZg2DSRNb8MQWDcXmFdJBympCvWoEC8EQT
         Q00nYiiT6DYxsmZYr8wFMNJBHSoVW1hMmJ2x2mnlWfRq+63IfAtM3RnWFMX/KRbEpSMH
         +sHUg6S0D4Bm1ednjV51aC1D0mqJC6R5a7JHL5UM7xICF/hk7rn+ByWF02O8ECLDFx7e
         D3F480hvLggUarnqm2BdB0X1ScONcrx8r3dJ5/91RJ6fobGIreAFak0g+9yM1YB2T1gH
         9faQrQV3R1v1Y+LOoU4UsYeroDUSDsUEhFmmaQtgRHBYYkDRy5K4807P36084Zsz5Rqn
         weXg==
X-Gm-Message-State: AOAM533By6E/4uXz7pJJXrH1npL3VMv7l4vImpI0Q8YWXj6FwBOuYsds
        wy8DofZjUzsGuAdRy9Ax+86enOMpk3S5NEqN9pA=
X-Google-Smtp-Source: ABdhPJzTit5XCU1S+0nSx25sM9IOdEB8XGwB1PGdyVaTlrN3aRY5hHNjhwSjH6U4PqWhyUkJakGcgYk8ywveLYye8mc=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr13425908otj.16.1639178272575;
 Fri, 10 Dec 2021 15:17:52 -0800 (PST)
MIME-Version: 1.0
References: <CAJZ5v0hpgZ76wUgAuuzcjCdxjpBWAEtruTtXN6eqsDdYdpS8Hw@mail.gmail.com>
 <CAHk-=wgMh42qQSUW_DYkCOsjku401B9210MGmFGCixJFDWCeEA@mail.gmail.com>
In-Reply-To: <CAHk-=wgMh42qQSUW_DYkCOsjku401B9210MGmFGCixJFDWCeEA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sat, 11 Dec 2021 00:17:41 +0100
Message-ID: <CAJZ5v0geXVeUqxXZxBB9Y93MhzUCRT+Tsh8XEnZ0r4MEeAy2uQ@mail.gmail.com>
Subject: Re: [GIT PULL] Thermal control fix for v5.16-rc5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 11:43 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Fri, Dec 10, 2021 at 12:11 PM Rafał Wysocki <rjwysocki@gmail.com> wrote:
> >
> > This fixes the definition of one of the Tiger Lake MMIO registers
> > in the int340x thermal driver (Sumeet Pawnikar).
>
> Funky.
>
> You sent me three pull requests, and two of them came with your normal
> address, and now the third from a new gmail one that I've never seen
> before.

Well, I had used that address before I started to use the kernel.org
one.  Now I'm using it for personal stuff, but sometimes it slips
through.  Sorry for the confusion.

> I also note that this one uses the proper utf-8 "Rafał" rather than
> "Rafael" - is that your preferred spelling?

It's Rafael in the English-speaking part of the world.

> I see the signed tag, and I notice that you do have this gmail address
> in your key, so this is all fine, but now I'm not sure how to spell
> your name any more ;)

It actually is fine both ways as far as I'm concerned. :-)

That said the people on the mailing lists are used to the Rafael one
so I'd rather stick to using it here.

Cheers!
