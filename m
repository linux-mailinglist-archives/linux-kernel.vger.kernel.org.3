Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD9463066
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:00:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240508AbhK3KDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235885AbhK3KDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:03:32 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA214C061574;
        Tue, 30 Nov 2021 02:00:13 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id k21so25256936ioh.4;
        Tue, 30 Nov 2021 02:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tom78f0Z07hr5SSiGx4EFP2HEgaq9175M71AAijwfKU=;
        b=d+l0jfFQ0yZ+rsoGH83/dJ3AaQg1DfIk2NvbfHLMbTcFjzvALY/Q4xnRvRTio/FrMP
         3FvOLOHvTRHS3HU1rk3f5WTMq12iXt6TO2czodvJIcl+rGgphq9l64cOjOpvss3IDn0G
         gtAGFC14O4lDuVjFCnlS5xUGRdgW/Fu3vzfOXo6ZnsSc4cgr+NeOS9ykFlxa+BoZFaDc
         i5W+t+imVM0sDkIvBA6vStRrTeyjStbEkWy9fUk+iTJyt26KiB+0FYACkwieQJFqsK5M
         Y9ZJ512qPdxmJ4IpTjMEwxiXW0mF9gYdYgD2UvgX0nFvyfszgYf0ccP81KJX241xk3nU
         YDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tom78f0Z07hr5SSiGx4EFP2HEgaq9175M71AAijwfKU=;
        b=jZNcmT8gkqyRYX0FEob6U7wxjI1t3wjYQXURnRCCVT44Tdm0Q8kj3W1y03i/uPhMLq
         EnvRPt+ZFuMl/CK+Sf7VZNnBiQGH6/v74U4TxPgkFNAnWzjVTA/wN6Le58lCx7hG9aNi
         MPO8D4K7nhPN2JHT2XVyV/9fW4+FMxZgz1kKpk0roZzmaMhpTbfK9ZWaf29S9O0L+Ss0
         hM+8PpCbNKkLIwSHMGUVJnHQV0dC4nYLqjzAmCDNsBVk4d+9w3IMxV9lQn3fXNIroK7T
         ROpD7J1f0xqRI3CQ4HVh5feIgPYYNnWF2opfVmxK0Lgm1VEAcJgZ79viIjpqC6+xuBUb
         PbTg==
X-Gm-Message-State: AOAM530HEiECCwh3asxuFCw2DyC5NvPUD/el3+7wgi33rAa+MqmeFdfD
        HZHPeLlSkCE6yLfy6uVOres5u+dPsf53/fEVcuE=
X-Google-Smtp-Source: ABdhPJyy3fgBe/ywHmSU52fCOnJ+LECB0cGRW1TixSQHCcEk6BYtcbEM7jcgDIzXE+q4e2NRm2k9xm52ae95WiK5EgE=
X-Received: by 2002:a6b:b7c8:: with SMTP id h191mr52188532iof.155.1638266413423;
 Tue, 30 Nov 2021 02:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20211130140621.29261096@canb.auug.org.au>
In-Reply-To: <20211130140621.29261096@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 30 Nov 2021 11:00:02 +0100
Message-ID: <CANiq72kSkv3f9xJ7BMQoTo4DmiGwwW7nMSnwvTeLnuLDQfK1Wg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the coresight tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Ayaan Zaidi <zaidi.ayaan@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 4:06 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

ACK -- looks good to me. Thanks!

Cheers,
Miguel
