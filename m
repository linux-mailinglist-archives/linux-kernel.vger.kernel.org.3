Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1D4650B7
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 16:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350241AbhLAPFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 10:05:02 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57966 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235927AbhLAPE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 10:04:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8EB70B81F6E;
        Wed,  1 Dec 2021 15:01:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A827C53FCD;
        Wed,  1 Dec 2021 15:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638370886;
        bh=hWa/AW8P+Nj1BqQSyzZbAAuCJg4NstfAxPTZFQ/kMZM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=VmSkMNMEuePziWmXmHamk+6licL6VT605ek7EsKigJPOhvT3MMQ5PvkBpfJGMtt/0
         qsgWscPOX5WC2fLR5xMsWfiMVqLGBqIZDjCpx7hCrOE9BajbH2PpiIn9xFN1Q4IsJg
         wCulxeHSi3wE/a3hxoScWNmlRlx+hoZTuMh0WHrjetmyyxq8HWiD6QD1c5ugUdRtDr
         QsmALzYPr99JaVjeLVRF5i6W4TqiI9yJ8264RQqBWpzkIMiimSvUbQ0q2YQ6ghDL7G
         tqcFrsNRJGvVBSQryDYZvhRSL/5IgyfuOUYwcr1ZzgNN1pF67lZdoknqMPE/nxFRo/
         isMlV0IOvQoEw==
Received: by mail-ed1-f41.google.com with SMTP id r25so37566584edq.7;
        Wed, 01 Dec 2021 07:01:26 -0800 (PST)
X-Gm-Message-State: AOAM532taSI/rwOe5Ygx2JCkOSVUmdZdu6Uy56J8W4wYbhMYXRZvyINW
        eiN4naW+g3iBuok9NfFPZUtS4K9/H2aqPRU15g==
X-Google-Smtp-Source: ABdhPJwwe0WMA1uFxfldNVhbQY/uprpaVrFLr+TUWgLN3K+H2vTtY43V8ew2D3T7TdJkzyqwsVH51D/sG3cYG6iZCO0=
X-Received: by 2002:aa7:dc07:: with SMTP id b7mr8923590edu.327.1638370880548;
 Wed, 01 Dec 2021 07:01:20 -0800 (PST)
MIME-Version: 1.0
References: <20211130195817.2911086-1-robh@kernel.org> <CAMRc=Mc-8--9+N2uGWhY6whwuJKCg1jtnnTYyQJifdSS2Um+qA@mail.gmail.com>
In-Reply-To: <CAMRc=Mc-8--9+N2uGWhY6whwuJKCg1jtnnTYyQJifdSS2Um+qA@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 1 Dec 2021 09:01:08 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+4a3FTW1yrM_PjX3_eDwb=Y6GV7PgpxyFiDVARTg5_Ug@mail.gmail.com>
Message-ID: <CAL_Jsq+4a3FTW1yrM_PjX3_eDwb=Y6GV7PgpxyFiDVARTg5_Ug@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: xlp: Remove Netlogic XLP variants
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 1, 2021 at 2:25 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>
> On Tue, Nov 30, 2021 at 8:58 PM Rob Herring <robh@kernel.org> wrote:
> >
> > Netlogic XLP was removed in commit 95b8a5e0111a ("MIPS: Remove NETLOGIC
> > support"). With those gone, the single platform left to support is
> > Cavium ThunderX2. Remove all the Netlogic variants and DT support.
> >
> > For simplicity, the existing kconfig name is retained.
> >
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> > Cc: linux-gpio@vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> > v2:
> >  - Fix !OF and ACPI build errors
> >
>
> Rob,
>
> This doesn't apply on top of v5.16-rc1. Anything I'm missing?

It should, that's exactly what it is based on. You dropped v1 that you
already applied?

Rob
