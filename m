Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E871481F6B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 20:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbhL3TLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 14:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbhL3TLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 14:11:37 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09777C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p65so30684875iof.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 11:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HzwQpdJfvXsIjvjm8A0dpq6ENpHszfKPhEy/ULrVWJ4=;
        b=iom+1/8VmJ76MSkm1gBmvL6xy5Ymq0fjqRaj3NQK4PJBCxS7CIAleK7ritCCUVbiQT
         8weXhQEzqspioYExHn0+s1VViizWSOWQb26AWFwOEJoRPTiw1Ds2CBJUTNcsMuuR0kHg
         KSBWGgRsWvhk8dTcs7hu8cOEv5OtoZ2FaTy6fLcZy960ry/YqbJb7UNeixLzUDHmIrmP
         kpxVj+5Mu6+4L8gBYFyHFGebCWUiQYeppachhBECvmhai84hev27ysYy1HlY3SDPfEkv
         M5x02Ycd66APnQJovkSbJiUpjTCbauPHkDHLJaoBkSmwWnjE3qI5D4YZ+OvBFIDChWqf
         OTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HzwQpdJfvXsIjvjm8A0dpq6ENpHszfKPhEy/ULrVWJ4=;
        b=a7dmS04LLdP8yUSRr+6ci0pGXlfKvQl3f/DQ/D3gK2Bj7LIqqbRpAQKvyjFOvCSmJH
         3sL7fOSNiQTeaA+UWKHnPOpBFwf+JVYD7/uL/OKAK01GJBhLUzXLuUKmB4iCsunvu6Vr
         45N9H+6/wt9flWHIIgMKwY4wmL6rx7vaH9vT1R1ijExzXBwymF+1T9UVkrsZSNlMSs1C
         peiwE0Gbx1JP+Ic2wH9pu6oDXCI77xOZ4QDytnvISpncTKNd9fKtfLqhEM33WxTdFVRZ
         9FozLk7ZMBNKCb3h8rxfmDigVpRnt1gOe8LgHOADVs9dkzuqR+rYJirhIwW5UtnMRkPH
         9v3w==
X-Gm-Message-State: AOAM532gLIsR6wggoqW0IawwSlBVbDWS3YoF052Y0rFE21/56rxlUeN0
        cwWNs+Sm1Z3JN8zv4wWfe/wGqwqAeCk6Pt/gKxw=
X-Google-Smtp-Source: ABdhPJzywR0tUS/YbXABKXiDtcZoK0y/MajMtL10XrFJoxpViErAv/2h3+/uaPrtRuKXehdRb33ESdy0D7IPiYNF5oc=
X-Received: by 2002:a02:b11a:: with SMTP id r26mr14612485jah.22.1640891496450;
 Thu, 30 Dec 2021 11:11:36 -0800 (PST)
MIME-Version: 1.0
References: <cover.1640036051.git.andreyknvl@google.com> <92f3029f3647ab355450ed5c8252bad8cfae1e09.1640036051.git.andreyknvl@google.com>
 <CAG_fn=XcPT=e6zmm-B4KQPLujpuC9D+hTbJEsua31onzopDT5g@mail.gmail.com>
In-Reply-To: <CAG_fn=XcPT=e6zmm-B4KQPLujpuC9D+hTbJEsua31onzopDT5g@mail.gmail.com>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Thu, 30 Dec 2021 20:11:25 +0100
Message-ID: <CA+fCnZeGDeWFHvkMSQQeG=+DLokssfTjp5hq_QOXrZC0YVd0Zg@mail.gmail.com>
Subject: Re: [PATCH mm v4 07/39] mm: clarify __GFP_ZEROTAGS comment
To:     Alexander Potapenko <glider@google.com>
Cc:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 10:17 AM Alexander Potapenko <glider@google.com> wrote:
>
> On Mon, Dec 20, 2021 at 10:59 PM <andrey.konovalov@linux.dev> wrote:
> >
> > From: Andrey Konovalov <andreyknvl@google.com>
>
> Reviewed-by: Alexander Potapenko <glider@google.com>
>
> >
> > __GFP_ZEROTAGS is intended as an optimization: if memory is zeroed during
> > allocation, it's possible to set memory tags at the same time with little
> > performance impact.
> Perhaps you could mention this intention explicitly in the comment?
> Right now it still doesn't reference performance.

Sure, will do in v5. Thanks!
