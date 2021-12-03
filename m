Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A511E4673A5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 10:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379404AbhLCJIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 04:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243758AbhLCJIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 04:08:44 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2C5C06173E;
        Fri,  3 Dec 2021 01:05:20 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y16so2824010ioc.8;
        Fri, 03 Dec 2021 01:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hpHmb8fethI2k7K6CB6NbA3dcvUxz9E13FAFhSEgRqc=;
        b=hYm4+5lL77QIxnm6FZtbulkdjUSQDQt9/Gz8kaSu+ipSnyNy2ooN1te+OFyWaDuQ1G
         FR8N/eeaK1BxJkKGMCT/7uNLbA8tt3tKZCd1PpDYExomklFxl1R1zkpjXeEbfGFWGzay
         0S8iAwh65ZLbM9BEyCzYcfXrBojA9RQfiQCiu0i/o4mDnCxIqZoc8Ay/7AZh1qwCRRv6
         qVnkBFDsfwBTabUA1MawdW4hcfCdCjaDu1fWMVWQKO0AMq+s8COnqL9F9bMM8zemHbwM
         h8Jtisk68RpALWwaaZhJOQl4MDE80Z2Drdk8feuwwBo4NEG+BAImCKcZ6iQPwha+BNDb
         /oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hpHmb8fethI2k7K6CB6NbA3dcvUxz9E13FAFhSEgRqc=;
        b=IqpknACVEhi5altwSKENHjqzp8A0rCZu/WL4Cb3bcivoi8HAgjkKwtx3A4XBE3Aq0s
         YYRwqb9bxeHAEdRfH2YOBj9N5l2RAlFIkPc/8RkZ/BjcaHmqp+5j5t7bavgF5sKKmOz6
         aohg3otMecWQkRRXl0rwHqjfRGTAy/1pl75w3LlcwVXZr1h1uMPjcUp4XoC1ka308iLp
         gPSkcRN3rlGGUteNDD/eXAd6q8iJ8A3FoL4bpwSJ2SxCY7sZrZAJ4JzL8KNdzufW5mSB
         5QT/iAn+o4SH/bdJMgOuT6F9y8OB+05j2JGsd4IQB4HgDG36eBo7LgMI1vGx9q20fkwl
         tEfg==
X-Gm-Message-State: AOAM530c2vTrr/Cb3iNBXyPGEtej+FOw6eEwccefLI1Y166QWZ2ZSOxU
        /uycRNcH1qcY00mgudU5QgaFRjpryeeaH60iTFS4dtsfpmw=
X-Google-Smtp-Source: ABdhPJz8AsxwdtWTj8AhL6g86pHyPc+94skz6mL1GOshnr5YEYBW9wc9SOFrBzoZ5r30UqypeQVQkYwfpz1VRcOaYZ0=
X-Received: by 2002:a6b:b7c8:: with SMTP id h191mr16428134iof.155.1638522320377;
 Fri, 03 Dec 2021 01:05:20 -0800 (PST)
MIME-Version: 1.0
References: <20211203162035.406a055a@canb.auug.org.au>
In-Reply-To: <20211203162035.406a055a@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 3 Dec 2021 10:05:09 +0100
Message-ID: <CANiq72nu_2s=eGy9KbOZDU8LKUw6bczP1Sea1Pewuwvue7ovdQ@mail.gmail.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Finn Behrens <me@kloenk.de>, Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Wei Liu <wei.liu@kernel.org>, Wu XiangCheng <bobwxc@email.cn>,
        Yuki Okushi <jtitor@2k36.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 6:20 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks good to me. Thanks!

Cheers,
Miguel
