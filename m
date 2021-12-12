Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18969471C75
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Dec 2021 20:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbhLLTG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Dec 2021 14:06:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbhLLTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Dec 2021 14:06:29 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18838C061714
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:06:29 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id m15so12653051pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 12 Dec 2021 11:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0LQCmBUo5l+B03Yci3e9G28eq224UAGiywQoY0pTbs=;
        b=XcQYzNjq0Gih5xdCdgm+TZNbopMi4SMFwA2HdFQRTYIxjk02GDTLVkVPpfLfuW25Ss
         lpF5MjAT6uD3DWZTvo6i2A4dU8DLdTEuLeYHUFFOOU+znHYOhpTVEntd5+anIX190u04
         x7rkqc/rcMAJ93unNj1LM71DJx1PICntgoTNBXtGGEGd6WZsjbhWySsm+FWvJl2i4ARd
         H6pp9P1oh6DbXDnGSHmrQ8kfYgFPfeP/Qr0QIEPNAQDK5YUv20qVMifiUmsF4uUpkQT4
         VdJkPj/XI3aFKm15f9QeYCLjczAQZWavQBkcv6pDSSYNvoClH2D4Wa4ZEcvQJEbo2dWv
         XD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0LQCmBUo5l+B03Yci3e9G28eq224UAGiywQoY0pTbs=;
        b=vgcbYaPaYe15gXHkkFBCFcFFvMSg1UFfBYYBKOdJFdhIMOLOcvMSKm7PkSyuU8Rp8c
         zG4K8tjI9GWGqXsZqcZ/2mW1RjECK299J8fypxmtgWioDf/76sOu2iBiK5rzEuoHH5o2
         WFzwids0u8xz7VzYHH8QcAOJ90oFMfEN1SxBexV2ra+Em/T083hfg/5I/4CiTzs9uAe+
         fJf+NlmGqRUNNYthMBXtFrDjQ0HsTgdU0HbEqeutJhXWWNCqQPkYLNVSzlKCQKsyKANQ
         EkgGHv6pbnh5y5Dfwi7NY7eAkBTxBnicKZYQZ2F9gHHcNuSQL7uyUkYewUygEKPg68Hv
         ubuQ==
X-Gm-Message-State: AOAM533pZLKTS6IwzqPz/KZg72U5PEmSKOR1Syk/m+8ylbQNgftE7bhb
        v3LXW+Az8KWt4Zv9L0v0NDaAfV5BxnMxax/eWMuxnEv8qgw=
X-Google-Smtp-Source: ABdhPJxUQHd9QoZz7FNqIKhdGiKXqBzU5NwMp0zUQydY4g2yAEIUD2AL1dPaarNlItsriDlYa5Z9Nyvduqhp1t+0QSM=
X-Received: by 2002:a63:4f42:: with SMTP id p2mr49517130pgl.381.1639335988559;
 Sun, 12 Dec 2021 11:06:28 -0800 (PST)
MIME-Version: 1.0
References: <20211211173447.4155374-1-hjl.tools@gmail.com> <CACVxJT-k664=aYp4VkG1LH3PsGHEf50PqP5EA+JWiFVb_JVs2Q@mail.gmail.com>
 <CAMe9rOqM+S_uBO-t5jJ1TLVD0R-LOJEiR6htb+k05c+ak7gF-g@mail.gmail.com> <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiEgwj3DGZai2GF9+z-FCSS455kGZ9z2g1qtdPLPWpvxQ@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 12 Dec 2021 11:05:52 -0800
Message-ID: <CAMe9rOqYxiMabie_2LN2mTTP7QPa0_mfKwDY10OSzKFj5GYT7A@mail.gmail.com>
Subject: Re: [PATCH] fs/binfmt_elf.c: disallow zero entry point address
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2021 at 10:29 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Dec 12, 2021 at 5:52 AM H.J. Lu <hjl.tools@gmail.com> wrote:
> >
> > On Sat, Dec 11, 2021 at 11:38 PM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
> > > Why not let it segfault?
> >
> > Why let it segfault?
>
> That's not my main worry - what if somebody has a code section with a
> zero vaddr and intentionally put the entry at the beginning?
>
> Maybe it's not supposed to work by some paper standatd, but afaik
> currently it _would_ work.
>
> All these things are relative to the load address, so a zero e_entry
> doesn't mean NULL, and may be a perfectly valid address.
>
> No?

According to the ELF specification, zero entry point value means
there is no entry point.  Such ELF binary doesn't conform to the
ELF specification.

-- 
H.J.
